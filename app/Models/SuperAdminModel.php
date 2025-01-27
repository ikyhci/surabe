<?php

namespace App\Models;

use CodeIgniter\Model;

class SuperAdminModel extends Model
{
    protected $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = db_connect();
    }

    public function getUsers($uid = null, $role = null, $offset = null, $limit = null)
    {
        $query = $this->db->query("CALL View_Users(?, ?, ?)", [$uid, $offset, $limit]);

        $users = $query->getResult();
        
        if (!is_null($role)) {
            $users = array_filter($users, function ($user) use ($role) {
                return isset($user->RoleName) && $user->RoleName === $role;
            });
        }

        return $users;
    }

    public function getUser($uid)
    {
        $query = $this->db->query("CALL View_Users(?, null,null)", [$uid]);
        if ($query->getNumRows() === 0) {
            return null;
        }
        
        return $query->getRow();
    }

    public function updateUser($uid, $uname, $fname, $phn, $eml)
    {
        // Panggil stored procedure dengan parameter
        $query = $this->db->query("CALL User_Update_data(?, ?, ?, ?, ?)", [$uid, $uname, $fname, $phn, $eml]);
    
        // Ambil hasil dari stored procedure
        $result = $query->getRowArray(); // Mengambil hasil sebagai array asosiatif
    
        // Periksa apakah hasil ada dan sesuai format
        if ($result && isset($result['res'], $result['msg'])) {
            // Periksa nilai 'res' untuk menentukan keberhasilan atau kegagalan
            if ($result['res'] == 1) {
                return [
                    'res' => true,
                    'msg' => $result['msg']
                ];
            } else {
                return [
                    'res' => false,
                    'msg' => $result['msg']
                ];
            }
        }
    
        // Jika tidak ada hasil yang valid, kembalikan respons error
        return [
            'res' => false,
            'msg' => 'Terjadi kesalahan pada server atau prosedur.'
        ];
    }
    
    public function addUser($uidx, $uname, $fname, $pswd, $phn, $eml, $rlid, $opid) {

        $query = $this->db->query("CALL User_Cretae_new(?, ?, ?, ?, ?, ?, ?, ?)", array($uidx, $uname, $fname, $pswd, $phn, $eml, $rlid, $opid));
        
        $result = $query->getRowArray();
        
        $this->db->close();
    
        if ($result['res'] == 1) {
            return [
                'res' => 'success',
                'msg' => $result['msg']
            ];
        } else {
            return [
                'res' => 'error',
                'msg' => $result['msg']
            ];
        }
    }
    
    public function deleteUser($uid) {
        $query = $this->db->query("CALL User_Delete(?)", [$uid]);
        
        $result = $query->getRowArray();
        
        $this->db->close();
    
        if ($result['res'] == 1) {
            return [
                'res' => 'success',
                'msg' => $result['msg']
            ];
        } else {
            return [
                'res' => 'error',
                'msg' => $result['msg']
            ];
        }
    }


}
