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

    public function UserInfo($id)
    {
        $userInfo = $this->db->table('lke_user')
                    ->select('lke_user.uid, lke_user.UserName, lke_user.FullName, lke_user.Phone, lke_user.EmailAdds, lke_roles.RoleName, lke_roles.acs, ')
                    ->join('lke_role', 'lke_role.Uid = lke_user.uid', 'inner')
                    ->join('lke_roles', 'lke_role.RoleId = lke_roles.RoleId', 'inner')
                    ->where('lke_user.uid', $id)
                    ->where('lke_user.actv', 'TRUE')
                    ->limit(1)
                    ->get()
                    ->getRow();
        if ($userInfo->acs == '2') {
            $aspek = $this->db->query(" SELECT lsa.* from lke_role lr INNER JOIN lke_sub_aspek lsa ON lsa.id=lr.aspek WHERE lr.Uid = '$id' ")->getResult();
            $userInfo->aspek = $aspek;
        } else {
            $userInfo->aspek = null;
        }
        return $userInfo;
    }
}
