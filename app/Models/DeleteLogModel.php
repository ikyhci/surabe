<?php

namespace App\Models;

use CodeIgniter\Model;
use Config\Database;
use CodeIgniter\Database\Exceptions\DatabaseException;
use InvalidArgumentException;
use RuntimeException;

/**
 * Model untuk mengelola log penghapusan (lke_delete_log).
 * 
 * Fitur utama:
 * - Insert single & batch log dengan error handling
 * - Query berdasarkan kondisi JSON atau kolom biasa
 * - Filter berdasarkan rentang tanggal dengan pagination
 * - Restore record yang terhapus ke tabel asal (dengan transaction)
 * - Purge (hapus permanen) log yang dipilih
 * - OOP-style (chaining method) dengan proper error handling
 * - Audit trail dan logging
 */
class DeleteLogModel extends Model
{
    protected $table      = 'lke_delete_log';
    protected $primaryKey = 'id';
    protected $allowedFields = ['table_name', 'record_id', 'data', 'deleted_at', 'deleted_by', 'status'];
    protected $useTimestamps = false;

    protected array $lastLogs = [];
    protected int $lastCount = 0;
    protected array $errors = [];

    // Status constants
    const STATUS_DELETED = 'deleted';
    const STATUS_RESTORED = 'restored';
    const STATUS_PURGED = 'purged';

    /**
     * Insert log baru (single) dengan validasi
     */
    public function insertLog(string $tableName, $recordId, array $data, string $deletedBy): self
    {
        $this->validateInputs($tableName, $recordId, $deletedBy);
        
        if (empty($data)) {
            throw new InvalidArgumentException('Data cannot be empty');
        }

        try {
            $jsonData = json_encode($data, JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR);
            
            $insertData = [
                'table_name' => $tableName,
                'record_id'  => $recordId,
                'data'       => $jsonData,
                'deleted_at' => date('Y-m-d H:i:s'),
                'deleted_by' => $deletedBy,
                'status'     => self::STATUS_DELETED,
            ];

            $result = $this->insert($insertData);
            
            if (!$result) {
                $this->errors[] = "Failed to insert log for {$tableName}:{$recordId}";
                throw new DatabaseException('Failed to insert delete log');
            }

            // Log the action
            log_message('info', "Delete log created: {$tableName}:{$recordId} by {$deletedBy}");
            
        } catch (\JsonException $e) {
            $this->errors[] = "JSON encoding failed: " . $e->getMessage();
            throw new RuntimeException('Failed to encode data as JSON: ' . $e->getMessage());
        }

        return $this;
    }

    /**
     * Insert log dalam batch dengan proper error handling
     */
    public function insertBatchLog(string $tableName, array $rows, ?string $deletedBy = null): self
    {
        if (empty($rows)) {
            throw new InvalidArgumentException('Rows cannot be empty');
        }

        $this->validateTableName($tableName);
        
        $batchData = [];
        $errors = [];

        foreach ($rows as $index => $row) {
            try {
                $recordId = $row['id'] ?? $row['record_id'] ?? null;
                $userDeletedBy = $row['deleted_by'] ?? $deletedBy;
                
                if (!$userDeletedBy) {
                    throw new InvalidArgumentException("deleted_by is required for row {$index}");
                }

                $jsonData = json_encode($row, JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR);
                
                $batchData[] = [
                    'table_name' => $tableName,
                    'record_id'  => $recordId,
                    'data'       => $jsonData,
                    'deleted_at' => date('Y-m-d H:i:s'),
                    'deleted_by' => $userDeletedBy,
                    'status'     => self::STATUS_DELETED,
                ];
            } catch (\Exception $e) {
                $errors[] = "Row {$index}: " . $e->getMessage();
            }
        }

        if (!empty($errors)) {
            $this->errors = array_merge($this->errors, $errors);
            throw new RuntimeException('Batch preparation failed: ' . implode('; ', $errors));
        }

        try {
            $result = $this->insertBatch($batchData);
            if (!$result) {
                throw new DatabaseException('Failed to insert batch delete logs');
            }

            log_message('info', "Batch delete log created: {$tableName} (" . count($batchData) . " records)");
        } catch (DatabaseException $e) {
            $this->errors[] = $e->getMessage();
            throw $e;
        }

        return $this;
    }

    /**
     * Cari log berdasarkan kondisi dengan pagination
     */
    public function findByCondition(
        array $conditions = [], 
        ?string $dateFrom = null, 
        ?string $dateTo = null, 
        ?int $limit = null,
        int $offset = 0
    ): self {
        try {
            $db = Database::connect();
            $builder = $db->table($this->table);

            // Apply conditions
            foreach ($conditions as $field => $value) {
                if (strpos($field, '$.') === 0) {
                    // Escape JSON path untuk security
                    $escapedPath = $db->escape($field);
                    $escapedValue = $db->escape($value);
                    $builder->where("JSON_UNQUOTE(JSON_EXTRACT(data, {$escapedPath})) =", $escapedValue);
                } else {
                    // Validasi field name untuk security
                    if (!in_array($field, $this->allowedFields)) {
                        throw new InvalidArgumentException("Invalid field: {$field}");
                    }
                    $builder->where($field, $value);
                }
            }

            // Date range filter
            if ($dateFrom) {
                $builder->where('deleted_at >=', $dateFrom);
            }
            if ($dateTo) {
                $builder->where('deleted_at <=', $dateTo);
            }

            // Pagination
            if ($limit) {
                $builder->limit($limit, $offset);
            }

            // Order by latest first
            $builder->orderBy('deleted_at', 'DESC');

            $this->lastLogs = $builder->get()->getResultArray();
            $this->lastCount = count($this->lastLogs);

        } catch (\Exception $e) {
            $this->errors[] = "Query failed: " . $e->getMessage();
            $this->lastLogs = [];
            $this->lastCount = 0;
            throw new RuntimeException('Failed to execute query: ' . $e->getMessage());
        }

        return $this;
    }

    /**
     * Restore data dengan transaction dan error handling
     */
    public function restore(string $restoredBy = 'system'): self
    {
        if (empty($this->lastLogs)) {
            throw new RuntimeException('No logs to restore. Call findByCondition() first.');
        }

        $db = Database::connect();
        $db->transStart();

        $restored = [];
        $failed = [];

        try {
            foreach ($this->lastLogs as $log) {
                try {
                    // Skip if already restored
                    if ($log['status'] === self::STATUS_RESTORED) {
                        continue;
                    }

                    $tableName = $log['table_name'];
                    $data = json_decode($log['data'], true, 512, JSON_THROW_ON_ERROR);

                    // Validate target table exists
                    if (!$db->tableExists($tableName)) {
                        throw new RuntimeException("Target table '{$tableName}' does not exist");
                    }

                    // Insert to target table
                    $insertResult = $db->table($tableName)->insert($data);
                    
                    if (!$insertResult) {
                        throw new RuntimeException("Failed to insert into {$tableName}");
                    }

                    // Update log status
                    $this->update($log['id'], [
                        'status' => self::STATUS_RESTORED,
                        'deleted_by' => $restoredBy . ' (restored from ' . $log['deleted_by'] . ')'
                    ]);

                    $restored[] = $log['id'];

                } catch (\Exception $e) {
                    $failed[] = "Log ID {$log['id']}: " . $e->getMessage();
                }
            }

            if (!empty($failed)) {
                throw new RuntimeException('Some restores failed: ' . implode('; ', $failed));
            }

            $db->transCommit();
            
            log_message('info', "Restored " . count($restored) . " records by {$restoredBy}");

        } catch (\Exception $e) {
            $db->transRollback();
            $this->errors[] = $e->getMessage();
            throw $e;
        }

        return $this;
    }

    /**
     * Purge dengan konfirmasi dan audit trail
     */
    public function purge(string $purgedBy = 'system', bool $confirmed = false): self
    {
        if (!$confirmed) {
            throw new RuntimeException('Purge operation requires explicit confirmation (set $confirmed = true)');
        }

        if (empty($this->lastLogs)) {
            throw new RuntimeException('No logs to purge. Call findByCondition() first.');
        }

        try {
            $ids = array_column($this->lastLogs, 'id');
            $count = count($ids);
            
            // Log before purging
            log_message('warning', "Purging {$count} delete logs by {$purgedBy}. IDs: " . implode(',', $ids));
            
            $result = $this->whereIn('id', $ids)->delete();
            
            if (!$result) {
                throw new DatabaseException('Failed to purge delete logs');
            }

            log_message('info', "Successfully purged {$count} delete logs");

        } catch (\Exception $e) {
            $this->errors[] = $e->getMessage();
            throw new RuntimeException('Purge failed: ' . $e->getMessage());
        }

        return $this;
    }

    /**
     * Get errors from last operations
     */
    public function getErrors(): array
    {
        return $this->errors;
    }

    /**
     * Clear errors
     */
    public function clearErrors(): self
    {
        $this->errors = [];
        return $this;
    }

    /**
     * Check if there are any errors
     */
    public function hasErrors(): bool
    {
        return !empty($this->errors);
    }

    /**
     * Get total count for pagination (without limit)
     */
    public function getTotalCount(array $conditions = [], ?string $dateFrom = null, ?string $dateTo = null): int
    {
        $db = Database::connect();
        $builder = $db->table($this->table);

        foreach ($conditions as $field => $value) {
            if (strpos($field, '$.') === 0) {
                $escapedPath = $db->escape($field);
                $escapedValue = $db->escape($value);
                $builder->where("JSON_UNQUOTE(JSON_EXTRACT(data, {$escapedPath})) =", $escapedValue);
            } else {
                if (!in_array($field, $this->allowedFields)) {
                    throw new InvalidArgumentException("Invalid field: {$field}");
                }
                $builder->where($field, $value);
            }
        }

        if ($dateFrom) {
            $builder->where('deleted_at >=', $dateFrom);
        }
        if ($dateTo) {
            $builder->where('deleted_at <=', $dateTo);
        }

        return $builder->countAllResults();
    }

    /**
     * Validate common inputs
     */
    private function validateInputs(string $tableName, $recordId, string $deletedBy): void
    {
        $this->validateTableName($tableName);

        if (empty($recordId)) {
            throw new InvalidArgumentException('Record ID cannot be empty');
        }

        if (empty(trim($deletedBy))) {
            throw new InvalidArgumentException('deleted_by cannot be empty');
        }
    }

    /**
     * Validate table name
     */
    private function validateTableName(string $tableName): void
    {
        if (empty(trim($tableName))) {
            throw new InvalidArgumentException('Table name cannot be empty');
        }

        // Basic security check for table name
        if (!preg_match('/^[a-zA-Z_][a-zA-Z0-9_]*$/', $tableName)) {
            throw new InvalidArgumentException('Invalid table name format');
        }
    }

    public function countLast(): int
    {
        return $this->lastCount;
    }

    public function getLastLogs(): array
    {
        return $this->lastLogs;
    }
}