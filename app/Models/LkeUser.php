<?php

namespace App\Models;

use CodeIgniter\Model;

class LkeUser extends Model
{
    protected $table            = 'lke_user';
    protected $primaryKey       = 'uid';
    protected $useAutoIncrement = true;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = ['uid', 'UserName', 'FullName', 'PassEnc', 'Phone', 'EmailAdds', 'Create_at', 'Update_at', 'actv'];

    protected bool $allowEmptyInserts = false;
    protected bool $updateOnlyChanged = true;

    protected array $casts = [];
    protected array $castHandlers = [];

    // Dates
    protected $useTimestamps = false;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'actv';

    // Validation
    protected $validationRules      = [];
    protected $validationMessages   = [];
    protected $skipValidation       = false;
    protected $cleanValidationRules = true;

    // Callbacks
    protected $allowCallbacks = true;
    protected $beforeInsert   = [];
    protected $afterInsert    = [];
    protected $beforeUpdate   = [];
    protected $afterUpdate    = [];
    protected $beforeFind     = [];
    protected $afterFind      = [];
    protected $beforeDelete   = [];
    protected $afterDelete    = [];

    public function getUserDetail($uid)
    {
        $user = $this->find($uid);
        $user['Role'] = $this->db->table('lke_roles rl')
            ->select('rl.RoleId, rl.RoleName')
            ->join('lke_role r', 'r.RoleId = rl.RoleId')
            ->where('r.Uid', $uid)
            ->groupBy('rl.RoleId')
            ->get()
            ->getRow();
        return $user;
    }

}
