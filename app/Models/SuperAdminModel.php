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

    public function EncPass($pass)
    {
        return $this->db->query("SELECT EncPass(?) as pass", [$pass])->getRow()->pass;
    }

    // public function getUsers($uid = null, $role = null, $offset = null, $limit = null)
    // {
    //     $query = $this->db->query("CALL View_Users(?, ?, ?)", [$uid, $offset, $limit]);

    //     $users = $query->getResult();
        
    //     if (!is_null($role)) {
    //         $users = array_filter($users, function ($user) use ($role) {
    //             return isset($user->RoleName) && $user->RoleName === $role;
    //         });
    //     }

    //     return $users;
    // }
    public function getUsers($uid = null, $role = null, $offset = null, $limit = null)
    {
        $builder = $this->db->table('lke_user u')
            ->select('u.uid, u.UserName, u.FullName, u.Phone, u.EmailAdds,rl.RoleId, rl.RoleName, d.opdid, u.actv, rl.acs')
            ->join('lke_role r', 'r.Uid = u.uid', 'left')
            ->join('lke_roles rl', 'rl.RoleId = r.RoleId', 'left')
            ->join('lke_detail_opd d', 'd.userid = u.uid', 'left')
            ->groupBy('u.uid, rl.RoleId, rl.RoleName, d.opdid');
        
        if (!is_null($uid)) {
            $builder->where('u.uid', $uid);
        }

        if (!is_null($role)) {
            $builder->where('rl.RoleId', $role);
        }

        if (!is_null($offset) && !is_null($limit)) {
            $builder->limit($limit, $offset);
        }
        
        $query = $builder->get();

        return $query->getResult();
    }

    public function getUser($uid)
    {
        $query = $this->db->query("CALL View_Users(?, null,null)", [$uid]);
        if ($query->getNumRows() === 0) {
            return null;
        }
        
        return $query->getRow();
    }

    public function getUserByOpd($opdId)
    {
        $builder = $this->db->table('lke_user as u');
        $builder->select('u.uid, u.UserName, u.FullName, u.EmailAdds, u.Phone');
        $builder->join('lke_detail_opd as d', 'd.userid = u.uid');
        $builder->where('d.opdid', $opdId);
        $query = $builder->get();
        $users = $query->getResultArray();
        foreach ($users as $user) {
            $data_terkait = $this->checkUserRelations($user['uid']);
            $user['data_terkait'] = $data_terkait;
            $result[] = $user;
        }
        return $result ?? [];
    }

    public function updateUser($uid, $uname, $fname, $phn, $eml, $pass = null)
    {

        $uppass = $this->db->query("CALL User_update_password('".
            $uid."','".
            $pass."')")->getRowArray();

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

    public function checkUserRelations($uid) {
        $relations = [];

        // Cek keterhubungan di jawaban
        $jawaban = $this->db->table('lke_jawaban')
            ->where('userid', $uid)
            ->countAllResults();
        if ($jawaban > 0) {
            $relations['jawaban'] = $jawaban;
        }

        // Cek keterhubungan di upload bukti
        $uploads = $this->db->table('lke_upload_bukti')
            ->where('userid', $uid)
            ->countAllResults();
        if ($uploads > 0) {
            $relations['uploads'] = $uploads;
        }

        // Cek keterhubungan di nilai jawaban (sebagai penilai)
        $nilai = $this->db->table('lke_nilai_jawaban_user')
            ->where('PenilaiId', $uid)
            ->countAllResults();
        if ($nilai > 0) {
            $relations['nilai'] = $nilai;
        }

        return [
            'uid' => $uid,
            'has_relations' => !empty($relations),
            'relations' => $relations
        ];
    }
    public function getUserRelations($uid)
    {
        $relations = [];

        // Ambil data jawaban user
        $jawaban = $this->db->table('lke_jawaban')
            ->where('userid', $uid)
            ->get()
            ->getResultArray();
        if (!empty($jawaban)) {
            $relations['jawaban'] = $jawaban;
        }

        // Ambil data upload bukti user
        $uploads = $this->db->table('lke_upload_bukti')
            ->where('userid', $uid)
            ->get()
            ->getResultArray();
        if (!empty($uploads)) {
            $relations['uploads'] = $uploads;
        }

        // Ambil data penilaian yang dilakukan user
        $nilai = $this->db->table('lke_nilai_jawaban_user')
            ->where('PenilaiId', $uid)
            ->get()
            ->getResultArray();
        if (!empty($nilai)) {
            $relations['nilai'] = $nilai;
        }

        return [
            'uid' => $uid,
            'has_relations' => !empty($relations),
            'relations' => $relations
        ];
    }
    
    public function deleteUser($uid, $mode = 'soft', $deletedBy = null)
    {
        $db = $this->db;

        // Ambil data user
        $user = $db->table('lke_user')
            ->where('uid', $uid)
            ->get()
            ->getRowArray();

        if (!$user) {
            return ['res' => false, 'msg' => 'User tidak ditemukan'];
        }

        if ($mode === 'soft') {
            // Mode 1: Soft delete (nonaktifkan user)
            $db->table('lke_user')
                ->where('uid', $uid)
                ->update([
                    'actv'      => 'FALSE',
                    'Update_at' => date('Y-m-d H:i:s')
                ]);

            return ['res' => true, 'msg' => 'User berhasil dinonaktifkan (soft delete)'];
        }

        if ($mode === 'hard') {
            // Mode 2: Hard delete (hapus user saja, data terkait orphan)
            $db->table('lke_delete_log')->insert([
                'table_name' => 'lke_user',
                'record_id'  => $uid,
                'data'       => json_encode($user),
                'deleted_at' => date('Y-m-d H:i:s'),
                'deleted_by' => $deletedBy
            ]);

            $db->table('lke_user')->where('uid', $uid)->delete();

            return ['res' => true, 'msg' => 'User berhasil dihapus (hard delete). Data terkait tetap ada'];
        }

        if ($mode === 'force') {
            // Mode 3: Force delete (hapus user + semua data terkait)
            $db->transBegin();

            try {
                // Log user
                $db->table('lke_delete_log')->insert([
                    'table_name' => 'lke_user',
                    'record_id'  => $uid,
                    'data'       => json_encode($user),
                    'deleted_at' => date('Y-m-d H:i:s'),
                    'deleted_by' => $deletedBy
                ]);

                // 1. Jawaban
                $jawaban = $db->table('lke_jawaban')->where('userid', $uid)->get()->getResultArray();
                foreach ($jawaban as $row) {
                    $db->table('lke_delete_log')->insert([
                        'table_name' => 'lke_jawaban',
                        'record_id'  => $row['id'],
                        'data'       => json_encode($row),
                        'deleted_at' => date('Y-m-d H:i:s'),
                        'deleted_by' => $deletedBy
                    ]);
                }
                $db->table('lke_jawaban')->where('userid', $uid)->delete();

                // 2. Upload bukti
                $uploads = $db->table('lke_upload_bukti')->where('userid', $uid)->get()->getResultArray();
                foreach ($uploads as $row) {
                    $db->table('lke_delete_log')->insert([
                        'table_name' => 'lke_upload_bukti',
                        'record_id'  => $row['id'],
                        'data'       => json_encode($row),
                        'deleted_at' => date('Y-m-d H:i:s'),
                        'deleted_by' => $deletedBy
                    ]);
                }
                $db->table('lke_upload_bukti')->where('userid', $uid)->delete();

                // 3. Nilai jawaban user
                $nilai = $db->table('lke_nilai_jawaban_user')->where('PenilaiId', $uid)->get()->getResultArray();
                foreach ($nilai as $row) {
                    $db->table('lke_delete_log')->insert([
                        'table_name' => 'lke_nilai_jawaban_user',
                        'record_id'  => $row['id'],
                        'data'       => json_encode($row),
                        'deleted_at' => date('Y-m-d H:i:s'),
                        'deleted_by' => $deletedBy
                    ]);
                }
                $db->table('lke_nilai_jawaban_user')->where('PenilaiId', $uid)->delete();

                // Terakhir: hapus user
                $db->table('lke_user')->where('uid', $uid)->delete();

                $db->transCommit();
                return ['res' => true, 'msg' => 'User beserta semua data terkait berhasil dihapus permanen (force delete)'];

            } catch (\Exception $e) {
                $db->transRollback();
                return ['res' => false, 'msg' => 'Gagal menghapus: ' . $e->getMessage()];
            }
        }

        return ['res' => false, 'msg' => 'Mode penghapusan tidak valid'];
    }

    // updateOpd
    public function updateOpd($uidx, $id, $nama_opd, $singkatan)
    {
        $query = $this->db->query("CALL Opd_add_edit(?, ?, ?)", [$uidx, $id, $nama_opd]);
        $opd = $this->db->table('lke_opd');

        $result = $query->getRowArray();
    
        if ($result['res'] == 1) {
            $opd->where('id', $id)->update(['singkatan' => $singkatan]);
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

    // deleteOpd
    public function deleteOpd($uidx, $id)
    {
        $opd = $this->db->table('lke_opd')->where('id', $id)->get()->getRowArray();
        if (!$opd) {
            return [
                'res' => 'error',
                'msg' => 'OPD tidak ditemukan'
            ];
        }
        $row = $opd;
        
        $user = $this->getUsers($uidx, null, null);
        if (count($user)===0 || $user[0]->actv != 'TRUE' || $user[0]->acs !== 1) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'usr' => $user,
                'msg' => 'anda tidak memiliki akses menghapus data ini'
            ]);
        }
        $deletedBy = $user[0]->FullName;

        $db->table('lke_delete_log')->insert([
            'table_name' => 'lke_opd',
            'record_id'  => $row['id'],
            'data'       => json_encode($row),
            'deleted_at' => date('Y-m-d H:i:s'),
            'deleted_by' => $deletedBy
        ]);
        // $this->deleteUserByOpd($id, $deletedBy);
        $userByOpd = $this->getUserByOpd($id);
        foreach ($userByOpd as $usr) {
            $this->deleteUser($usr['id'], 'force', $deletedBy);
        }
        $query = $this->db->query("CALL Opd_delete(?, ?)", [$uidx, $id]);
    
        $result = $query->getRowArray();
    
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

    public function getOpd($id_opd = null, $nama_opd = null, $limit = null, $offset = null)
    {
        $builder = $this->db->table('lke_opd')
                            ->select('id, id AS id_opd, nama_opd, singkatan');

        // Filter berdasarkan ID (sekarang idx = id_opd)
        if (!is_null($id_opd)) {
            $builder->where('id', $id_opd);
        }

        // Filter berdasarkan nama_opd (like)
        if (!is_null($nama_opd)) {
            $builder->like('nama_opd', $nama_opd);
        }

        // Limit dan offset untuk pagination
        if (!is_null($limit)) {
            $builder->limit($limit, $offset);
        }

        $query = $builder->get();
        return $query->getResult();
    }

}