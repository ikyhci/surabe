<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use App\Models\SuperAdminModel;
use CodeIgniter\HTTP\Request;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;
use CodeIgniter\Model;
use stdClass;
use App\Models\LkeModel;
use App\Models\LkeForm;


class ApiSuperAdminControllers extends BaseController
{
    protected $superAdminModel;
    protected $decoded;
    protected $db;
    
    public function __construct(){
        $request = request();
        $key = getenv('TOKEN_SECRET');
        $token = null;
        $header = $request->getHeader("Authorization");
         if(!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                $token = $matches[1];
            }
        }
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $this->db = db_connect();
        $this->superAdminModel = new SuperAdminModel();
    }

    public function getUsers(){

        $uid = $this->request->getVar('uid') ? $this->request->getVar('uid') : null;
        $role = $this->request->getVar('role') ? $this->request->getVar('role') : null;
        $offset = $this->request->getVar('offset') ? $this->request->getVar('offset') : null;
        $limit = $this->request->getVar('limit') ? $this->request->getVar('limit') : null;

        $users = $this->superAdminModel->getUsers($uid, $role, $offset, $limit);

        $data = array(
            'token_crs' => csrf_hash(),
            'dt'        =>  $users,
            'success'   =>  1,
            'msg'       =>  'success',
        );

        return $this->response->setJSON($data);
    }

    public function getUser($uid)
    {

        $data = array(
            'token_crs' => csrf_hash(),
            'dt'        =>  [],
            'success'   =>  1,
            'msg'       =>  'success',
        );
        $user = $this->superAdminModel->getUsers($uid, null, null);
        $dataTerkait = $this->superAdminModel->checkUserRelations($uid);
        if (count($user)===1) {
            $aspek_penilai = [];
            $lke_role = new \App\Models\LkeRole();
            $aspek_penilai = $lke_role->select('aspek as aspek_id')->where('Uid', $uid)->findAll();
            $user[0]->data_terkait = $dataTerkait['relations'];
            $user[0]->aspek_penilai = $aspek_penilai;
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        =>  $user[0],
                'success'   =>  1,
                'msg'       =>  'success',
            );
        }

        return $this->response->setJSON($data);
    }

    public function updateUser($uid)
    {
        $validation = \Config\Services::validation();
        $validation->setRules([
            'UserName'   => 'required|min_length[3]|max_length[50]',
            'FullName'   => 'required|min_length[3]|max_length[100]',
            'Phone'      => 'required|numeric|min_length[10]|max_length[15]',
            'EmailAdds'  => 'required|valid_email|max_length[100]',
        ]);
    
        if (!$this->validate($validation->getRules())) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $validation->getErrors()
            ]);
        }
    
        $uname  = $this->request->getPost('UserName');
        $fname  = $this->request->getPost('FullName');
        $phn    = $this->request->getPost('Phone');
        $eml    = $this->request->getPost('EmailAdds');

        $pass   = $this->request->getPost('Password');

        $rlid = $this->request->getPost('RoleName');
        $opid = $this->request->getPost('nama_opd');
        $aspek_penilai = $this->request->getPost('aspek_penilai');

        $result = $this->superAdminModel->updateUser($uid, $uname, $fname, $phn, $eml, $pass);

        if ($result['res'] == 1) {
            $lke_detail_opd = new \App\Models\LkeDetailOpd();
            $lke_detail_opd->where('userid', $uid)->set(['opdid' => $opid])->update();
            $lke_role = new \App\Models\LkeRole();
            $lke_role->where('Uid', $uid)->delete();
            if (!empty($aspek_penilai)) {
                foreach ($aspek_penilai as $key => $value) {
                    $lke_role->insert([
                        'Uid' => $uid,
                        'RoleId' => $rlid,
                        'aspek' => $value,
                    ]);
                }
            }else {
                $lke_role->insert([
                    'Uid' => $uid,
                    'RoleId' => $rlid,
                ]);
            }
            
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => true,
                'msg' => $result['msg'],
                'uid' => $uid
            ]);
        } else {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $result['msg']
            ]);
        }
    }
    
    public function addUser()
    {
        $validation = \Config\Services::validation();
        $validation->setRules([
            'UserName'   => 'required|min_length[3]|max_length[50]',
            'FullName'   => 'required|min_length[3]|max_length[100]',
            'Phone'      => 'required|numeric|min_length[10]|max_length[15]',
            'EmailAdds'  => 'required|valid_email|max_length[100]',
            'RoleName'   => 'required',
            'nama_opd'   => 'required',
        ]);
    
        if (!$this->validate($validation->getRules())) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $validation->getErrors()
            ]);
        }
        $uidx = sha1(random_bytes(20));
        $uname = $this->request->getPost('UserName');
        $fname = $this->request->getPost('FullName');
        $pswd = $this->request->getPost('Password');
        $phn = $this->request->getPost('Phone');
        $eml = $this->request->getPost('EmailAdds');
        $rlid = $this->request->getPost('RoleName');
        $opid = $this->request->getPost('nama_opd');
        $aspek_penilai = $this->request->getPost('aspek_penilai');
        // $result = $this->superAdminModel->addUser($uidx, $uname, $fname, $pswd, $phn, $eml, $rlid, $opid);
        
        $lke_user = new \App\Models\LkeUser();
        $lke_role = new \App\Models\LkeRole();
        $lke_detail_opd = new \App\Models\LkeDetailOpd();
        $hashPass = null;//$this->superAdminModel->EncPass($pswd);
        $user_data = [
            'uid'       => $uidx,
            'UserName'  => $uname,
            'PassEnc'   => $hashPass,
            'FullName'  => $fname,
            'Phone'     => $phn,
            'EmailAdds' => $eml,
            'Create_at' => date('Y-m-d H:i:s'),
            'actv'      => 'TRUE',
        ];

        try {
            $lke_user->insert($user_data);
            // $lke_user->query("CALL User_Cretae_new(?, ?, ?, ?, ?, ?, ?, ?)", [$uidx, $uname, $fname, $pswd, $phn, $eml, $rlid, $opid]);
            
            if ($lke_user->affectedRows() > 0) {
                $user_id = $uidx;
                $lke_detail_opd->insert([
                    'id' => sha1(random_bytes(20)),
                    'userid' => $user_id,
                    'opdid' => $opid,
                    'create_at' => date('Y-m-d H:i:s'),
                ]);
                // $lke_role->where('Uid', $user_id)->delete();
                // $lke_user->query("UPDATE lke_user SET PassEnc = EncPass(?) WHERE Uid = ?", [$pswd, $user_id]);
                $lke_user->query("CALL User_update_password(?, ?)", [ $user_id, $pswd ]);
                if (!empty($aspek_penilai)) {
                    $aspek = new \App\Models\LkeAspek();
                    // $aspek->whereIn('id', $aspek_penilai)->update(['penilaiid' => $user_id]);
                    foreach ($aspek_penilai as $asp) {
                        $lke_role->save([
                            'Uid' => $user_id,
                            'RoleId' => $rlid,
                            'aspek' => $asp,
                            'Create_at' => date('Y-m-d H:i:s'),
                        ]);
                    }
                }else {
                    $lke_role->save([
                        'Uid' => $user_id,
                        'RoleId' => $rlid,
                    ]);
                }
                
                return $this->response->setJSON([
                    'token_crs' => csrf_hash(),
                    'res' => true,
                    'msg' => 'User berhasil ditambahkan'
                ]);
            } else {
                return $this->response->setJSON([
                    'token_crs' => csrf_hash(),
                    'res' => false,
                    'msg' => 'User gagal ditambahkan',
                    'data' => $user_data,
                    'last_query' => $lke_user->getLastQuery()->getQuery()
                ]);
            }
        } catch (\Exception $e) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => 'Error: ' . $e->getMessage(),
                'last_query' => $lke_user->getLastQuery()->getQuery(),
                'data' => $user_data
            ]);
        }

    }

    public function deleteUser($uid, $paramMode = null, $uidxx = null)
    {

        $mode = $paramMode ?? $this->request->getGet('mode') ?? 'soft';
        
        $uidx = $uidxx ?? $this->decoded->ids;
        $user = $this->superAdminModel->getUsers($uidx, null, null);
        if (count($user)===0 || $user[0]->actv != 'TRUE' || $user[0]->acs != 1) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'usr' => $user,
                'validasi' => [
                    'count' => (count($user)===0),
                    'actv' => ($user[0]->actv != 'TRUE'),
                    'acs' => ($user[0]->acs != 1),
                ],
                'msg' => 'anda tidak memiliki akses menghapus user ini'
            ]);
        }
        $deletedBy = $user[0]->FullName;
        // ambil data relasi untuk informasi
        $relasi_data = $this->superAdminModel->getUserRelations($uid);

        // jalankan delete sesuai mode
        $result = $this->superAdminModel->deleteUser($uid, $mode, $deletedBy);

        return $this->response->setJSON([
            'token_crs'    => csrf_hash(),
            'res'          => $result['res'],
            'mode'         => $mode,
            'data_terkait' => $relasi_data,
            'msg'          => $result['msg']
        ]);
    }

    
    public function saveOPD()
    {
        $validation = \Config\Services::validation();
        $validation->setRules([
            'nama_opd'   => 'required|min_length[3]|max_length[100]',
        ]);
    
        if (!$this->validate($validation->getRules())) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $validation->getErrors()
            ]);
        }
    
        $opid = $this->request->getPost('opd_id');
        $opnm = $this->request->getPost('nama_opd');
        $uidx = $this->decoded->ids;
        $singkatan = $this->request->getPost('singkatan');
        $result = $this->superAdminModel->updateOpd($uidx, $opid, $opnm, $singkatan);
    
        if ($result['res'] == 1) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => true,
                'msg' => $result['msg']
            ]);
        } else {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $result['msg']
            ]);
        }
    }

    // delOPD
    public function delOPD()
    {
        $validation = \Config\Services::validation();
        $validation->setRules([
            'id'   => 'required|numeric',
        ]);
    
        if (!$this->validate($validation->getRules())) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $validation->getErrors()
            ]);
        }
    
        $opid = $this->request->getPost('id');
        $uidx = $this->decoded->ids;

        $result = $this->superAdminModel->deleteOpd($uidx, $opid);
    
        if ($result['res'] == 1) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => true,
                'msg' => $result['msg']
            ]);
        } else {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'res' => false,
                'msg' => $result['msg']
            ]);
        }
    }

    public function capaianOpd()
    {
        /*
        $dashboardModel = new \App\Models\DashboardModel;
        $tahun = $this->request->getVar('tahun') ?? date('Y') ;
        $list = [];
        $nilaiOpd = $dashboardModel->nilaiOpd($tahun);
        foreach($nilaiOpd as $k => $v) {
            $opd = new stdClass();
            $opd->id_opd = $v->id;
            $opd->nama_opd = $v->nama_opd;
            $opd->singkatan = $v->singkatan;
            $opd->nilai = 0;
            $nilaisum = 0;
            $opd->domains = [];
            foreach ($v->instrumen as $rb) {
                $nilaisum += $rb->nilai;
                foreach ($rb->aspek as $aspek) {
                    $opd->domains[] = $aspek;
                }
            }
            $opd->nilai = $nilaisum / count($v->instrumen);
            $list[] = $opd;
        }
        */
        $LkeForm = new \App\Models\LkeForm();
        $model = new LkeModel();

        $tahun = $LkeForm->select('tahun')->orderBy('tahun', 'DESC')->first();
        $list = $model->getRekapSemuaOpd($tahun);

        $data = array(
            'success'   =>  1,
            'msg'       =>  'success',
            'token_crs' => csrf_hash(),
            'dt'        => $list,
        );
        return $this->response->setJSON($data);
    }

    public function getSubAspekByForm()
    {
        $form_id = $this->request->getVar('FormId');
        if (!$form_id) {
            $data = array(
                'token_crs' => csrf_hash(),
                'success'   => 0,
                'msg'       => 'Form ID tidak boleh kosong'
            );
            return $this->response->setJSON($data);
        }
        $lke_sub_aspek = new \App\Models\LkeSubAspek();
        $subAspek = $lke_sub_aspek->getSubAspekByFormId($form_id);
        $data = array(
            'token_crs' => csrf_hash(),
            'dt'        => $subAspek,
            'success'   => 1,
            'msg'       => 'Data berhasil diambil'
        );
        

        return $this->response->setJSON($data);
    }
}