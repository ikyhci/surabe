<?php

/**
 * BaseModel - Extended CI4 Model with Eloquent-like Relations
 * 
 * This class provides Laravel Eloquent-style relationships for CodeIgniter 4
 * 
 * @author Your Name
 * @version 1.0.0
 */

namespace App\Models;

use CodeIgniter\Model;

class BaseModel extends Model
{
    protected $with = []; // Eager loading relations
    protected $loaded_relations = [];
    
    /**
     * One To One Relationship
     * 
     * @param string $related Related model class
     * @param string $foreignKey Foreign key in related table
     * @param string $localKey Local key in current table
     * @return object|null
     */
    protected function hasOne($related, $foreignKey = null, $localKey = null)
    {
        $localKey = $localKey ?? $this->primaryKey;
        $foreignKey = $foreignKey ?? $this->getForeignKey();
        
        $relatedModel = new $related();
        
        return $relatedModel->where($foreignKey, $this->{$localKey})->first();
    }
    
    /**
     * Inverse One To One Relationship
     * 
     * @param string $related Related model class
     * @param string $foreignKey Foreign key in current table
     * @param string $ownerKey Owner key in related table
     * @return object|null
     */
    protected function belongsTo($related, $foreignKey = null, $ownerKey = null)
    {
        $relatedModel = new $related();
        $foreignKey = $foreignKey ?? $this->getRelatedForeignKey($relatedModel);
        $ownerKey = $ownerKey ?? $relatedModel->primaryKey;
        
        return $relatedModel->where($ownerKey, $this->{$foreignKey})->first();
    }
    
    /**
     * One To Many Relationship
     * 
     * @param string $related Related model class
     * @param string $foreignKey Foreign key in related table
     * @param string $localKey Local key in current table
     * @return array
     */
    protected function hasMany($related, $foreignKey = null, $localKey = null)
    {
        $localKey = $localKey ?? $this->primaryKey;
        $foreignKey = $foreignKey ?? $this->getForeignKey();
        
        $relatedModel = new $related();
        
        return $relatedModel->where($foreignKey, $this->{$localKey})->find_All();
    }
    
    /**
     * Many To Many Relationship
     * 
     * @param string $related Related model class
     * @param string $pivotTable Pivot table name
     * @param string $foreignPivotKey Foreign key in pivot table for current model
     * @param string $relatedPivotKey Foreign key in pivot table for related model
     * @param string $parentKey Parent key in current table
     * @param string $relatedKey Related key in related table
     * @return array
     */
    protected function belongsToMany($related, $pivotTable = null, $foreignPivotKey = null, $relatedPivotKey = null, $parentKey = null, $relatedKey = null)
    {
        $relatedModel = new $related();
        
        $parentKey = $parentKey ?? $this->primaryKey;
        $relatedKey = $relatedKey ?? $relatedModel->primaryKey;
        $foreignPivotKey = $foreignPivotKey ?? $this->getForeignKey();
        $relatedPivotKey = $relatedPivotKey ?? $relatedModel->getForeignKey();
        $pivotTable = $pivotTable ?? $this->getPivotTableName($relatedModel);
        
        $db = \Config\Database::connect();
        
        $results = $db->table($relatedModel->table)
            ->select($relatedModel->table . '.*, ' . $pivotTable . '.*')
            ->join($pivotTable, $pivotTable . '.' . $relatedPivotKey . ' = ' . $relatedModel->table . '.' . $relatedKey)
            ->where($pivotTable . '.' . $foreignPivotKey, $this->{$parentKey})
            ->get()
            ->getResultArray();
        
        return $results;
    }
    
    /**
     * Has One Through Relationship
     * 
     * @param string $related Final related model
     * @param string $through Intermediate model
     * @param string $firstKey Key on intermediate table that references current model
     * @param string $secondKey Key on final table that references intermediate model
     * @param string $localKey Key on current model
     * @param string $secondLocalKey Key on intermediate model
     * @return object|null
     */
    protected function hasOneThrough($related, $through, $firstKey = null, $secondKey = null, $localKey = null, $secondLocalKey = null)
    {
        $relatedModel = new $related();
        $throughModel = new $through();
        
        $localKey = $localKey ?? $this->primaryKey;
        $firstKey = $firstKey ?? $this->getForeignKey();
        $secondKey = $secondKey ?? $throughModel->getForeignKey();
        $secondLocalKey = $secondLocalKey ?? $throughModel->primaryKey;
        
        $db = \Config\Database::connect();
        
        $result = $db->table($relatedModel->table)
            ->select($relatedModel->table . '.*')
            ->join($throughModel->table, $throughModel->table . '.' . $secondLocalKey . ' = ' . $relatedModel->table . '.' . $secondKey)
            ->where($throughModel->table . '.' . $firstKey, $this->{$localKey})
            ->get()
            ->getFirstRow();
        
        return $result;
    }
    
    /**
     * Has Many Through Relationship
     * 
     * @param string $related Final related model
     * @param string $through Intermediate model
     * @param string $firstKey Key on intermediate table that references current model
     * @param string $secondKey Key on final table that references intermediate model
     * @param string $localKey Key on current model
     * @param string $secondLocalKey Key on intermediate model
     * @return array
     */
    protected function hasManyThrough($related, $through, $firstKey = null, $secondKey = null, $localKey = null, $secondLocalKey = null)
    {
        $relatedModel = new $related();
        $throughModel = new $through();
        
        $localKey = $localKey ?? $this->primaryKey;
        $firstKey = $firstKey ?? $this->getForeignKey();
        $secondKey = $secondKey ?? $throughModel->getForeignKey();
        $secondLocalKey = $secondLocalKey ?? $throughModel->primaryKey;
        
        $db = \Config\Database::connect();
        
        $results = $db->table($relatedModel->table)
            ->select($relatedModel->table . '.*')
            ->join($throughModel->table, $throughModel->table . '.' . $secondLocalKey . ' = ' . $relatedModel->table . '.' . $secondKey)
            ->where($throughModel->table . '.' . $firstKey, $this->{$localKey})
            ->get()
            ->getResultArray();
        
        return $results;
    }
    
    /**
     * Polymorphic One To One
     * 
     * @param string $related Related model class
     * @param string $name Polymorphic relation name
     * @param string $type Type column name
     * @param string $id ID column name
     * @return object|null
     */
    protected function morphOne($related, $name, $type = null, $id = null)
    {
        $type = $type ?? $name . '_type';
        $id = $id ?? $name . '_id';
        
        $relatedModel = new $related();
        
        return $relatedModel->where($type, get_class($this))
            ->where($id, $this->{$this->primaryKey})
            ->first();
    }
    
    /**
     * Polymorphic One To Many
     * 
     * @param string $related Related model class
     * @param string $name Polymorphic relation name
     * @param string $type Type column name
     * @param string $id ID column name
     * @return array
     */
    protected function morphMany($related, $name, $type = null, $id = null)
    {
        $type = $type ?? $name . '_type';
        $id = $id ?? $name . '_id';
        
        $relatedModel = new $related();
        
        return $relatedModel->where($type, get_class($this))
            ->where($id, $this->{$this->primaryKey})
            ->find_All();
    }
    
    /**
     * Inverse Polymorphic Relationship
     * 
     * @param string $name Polymorphic relation name
     * @param string $type Type column name
     * @param string $id ID column name
     * @return object|null
     */
    protected function morphTo($name = null, $type = null, $id = null)
    {
        $name = $name ?? 'morphable';
        $type = $type ?? $name . '_type';
        $id = $id ?? $name . '_id';
        
        $relatedClass = $this->{$type};
        $relatedId = $this->{$id};
        
        if (!$relatedClass || !$relatedId) {
            return null;
        }
        
        $relatedModel = new $relatedClass();
        return $relatedModel->find($relatedId);
    }
    
    /**
     * Polymorphic Many To Many
     * 
     * @param string $related Related model class
     * @param string $name Polymorphic relation name
     * @param string $table Pivot table name
     * @param string $foreignPivotKey Foreign key for current model
     * @param string $relatedPivotKey Foreign key for related model
     * @param string $parentKey Parent key
     * @param string $relatedKey Related key
     * @return array
     */
    protected function morphToMany($related, $name, $table = null, $foreignPivotKey = null, $relatedPivotKey = null, $parentKey = null, $relatedKey = null)
    {
        $relatedModel = new $related();
        
        $table = $table ?? $name;
        $parentKey = $parentKey ?? $this->primaryKey;
        $relatedKey = $relatedKey ?? $relatedModel->primaryKey;
        $foreignPivotKey = $foreignPivotKey ?? $name . '_id';
        $relatedPivotKey = $relatedPivotKey ?? $relatedModel->getForeignKey();
        
        $db = \Config\Database::connect();
        
        $results = $db->table($relatedModel->table)
            ->select($relatedModel->table . '.*, ' . $table . '.*')
            ->join($table, $table . '.' . $relatedPivotKey . ' = ' . $relatedModel->table . '.' . $relatedKey)
            ->where($table . '.' . $foreignPivotKey, $this->{$parentKey})
            ->where($table . '.' . $name . '_type', get_class($this))
            ->get()
            ->getResultArray();
        
        return $results;
    }
    
    /**
     * Inverse Polymorphic Many To Many
     * 
     * @param string $related Related model class
     * @param string $name Polymorphic relation name
     * @param string $table Pivot table name
     * @param string $foreignPivotKey Foreign key for current model
     * @param string $relatedPivotKey Foreign key for related model
     * @param string $parentKey Parent key
     * @param string $relatedKey Related key
     * @return array
     */
    protected function morphedByMany($related, $name, $table = null, $foreignPivotKey = null, $relatedPivotKey = null, $parentKey = null, $relatedKey = null)
    {
        $relatedModel = new $related();
        
        $table = $table ?? $name;
        $parentKey = $parentKey ?? $this->primaryKey;
        $relatedKey = $relatedKey ?? $relatedModel->primaryKey;
        $foreignPivotKey = $foreignPivotKey ?? $this->getForeignKey();
        $relatedPivotKey = $relatedPivotKey ?? $name . '_id';
        
        $db = \Config\Database::connect();
        
        $results = $db->table($relatedModel->table)
            ->select($relatedModel->table . '.*, ' . $table . '.*')
            ->join($table, $table . '.' . $relatedPivotKey . ' = ' . $relatedModel->table . '.' . $relatedKey)
            ->where($table . '.' . $foreignPivotKey, $this->{$parentKey})
            ->where($table . '.' . $name . '_type', get_class($relatedModel))
            ->get()
            ->getResultArray();
        
        return $results;
    }
    
    /**
     * Load relationships
     * 
     * @param array|string $relations
     * @return $this
     */
    public function with($relations)
    {
        if (is_string($relations)) {
            $relations = [$relations];
        }
        
        $this->with = array_merge($this->with, $relations);
        return $this;
    }
    
    /**
     * Load relationships for existing model instance
     * 
     * @param array|string $relations
     * @return $this
     */
    public function load($relations)
    {
        if (is_string($relations)) {
            $relations = [$relations];
        }
        
        foreach ($relations as $relation) {
            if (method_exists($this, $relation)) {
                $this->loaded_relations[$relation] = $this->{$relation}();
            }
        }
        
        return $this;
    }
    
    /**
     * Check if relation is loaded
     * 
     * @param string $relation
     * @return bool
     */
    public function relationLoaded($relation)
    {
        return isset($this->loaded_relations[$relation]);
    }
    
    /**
     * Get loaded relation
     * 
     * @param string $relation
     * @return mixed
     */
    public function getRelation($relation)
    {
        return $this->loaded_relations[$relation] ?? null;
    }
    
    /**
     * Override find to support eager loading
     */
    public function find($id = null)
    {
        $result = parent::find($id);
        
        if ($result && !empty($this->with)) {
            if (is_array($result)) {
                foreach ($result as &$item) {
                    $item = $this->loadRelationsForItem($item);
                }
            } else {
                $result = $this->loadRelationsForItem($result);
            }
        }
        
        return $result;
    }
    
    /**
     * Override find_All to support eager loading
     */
    public function find_All(int $limit = 0, int $offset = 0)
    {
        $results = parent::find_All($limit, $offset);

        if (!empty($results) && !empty($this->with)) {
            foreach ($results as &$item) {
                $item = $this->loadRelationsForItem($item);
            }
        }
        
        return $results;
    }
    
    /**
     * Load relations for single item
     * 
     * @param object $item
     * @return object
     */
    protected function loadRelationsForItem($item)
    {
        foreach ($this->with as $relation) {
            if (method_exists($this, $relation)) {
                // Create temporary instance with item data
                $tempInstance = clone $this;
                foreach ($item as $key => $value) {
                    $tempInstance->{$key} = $value;
                }
                
                $item->{$relation} = $tempInstance->{$relation}();
            }
        }
        
        return $item;
    }
    
    /**
     * Get foreign key for current model
     * 
     * @return string
     */
    protected function getForeignKey()
    {
        $className = class_basename(get_class($this));
        return strtolower($className) . '_id';
    }
    
    /**
     * Get foreign key for related model
     * 
     * @param object $relatedModel
     * @return string
     */
    protected function getRelatedForeignKey($relatedModel)
    {
        $className = class_basename(get_class($relatedModel));
        return strtolower($className) . '_id';
    }
    
    /**
     * Get pivot table name
     * 
     * @param object $relatedModel
     * @return string
     */
    protected function getPivotTableName($relatedModel)
    {
        $models = [
            strtolower(class_basename(get_class($this))),
            strtolower(class_basename(get_class($relatedModel)))
        ];
        
        sort($models);
        return implode('_', $models);
    }
}

