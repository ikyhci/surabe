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

class ApiSuperAdminControllers extends BaseController
{
    protected $superAdminModel;
    protected $decoded;
    protected $db;
    
    public function __construct(){
        $response = service('response');
        $key = getenv('TOKEN_SECRET');
        $token = null;
        $header = $request->getHeader("Authorization");
         if(!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                $token = $matches[1];
            }
        }
        // if(is_null($token) || empty($token)) {
        //     $response = service('response');
        //     $response->setBody('Access denied');
        //     $response->setStatusCode(401);
        //     return $response;
        // }else{
        //     $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // }
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
        if (count($user)===1) {
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
    
        $result = $this->superAdminModel->updateUser($uid, $uname, $fname, $phn, $eml);
    
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
        $uidx = '';
        $uname = $this->request->getPost('UserName');
        $fname = $this->request->getPost('FullName');
        $pswd = $this->request->getPost('Password');
        $phn = $this->request->getPost('Phone');
        $eml = $this->request->getPost('EmailAdds');
        $rlid = $this->request->getPost('RoleName');
        $opid = $this->request->getPost('nama_opd');
    
        $result = $this->superAdminModel->addUser($uidx, $uname, $fname, $pswd, $phn, $eml, $rlid, $opid);
    
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

    public function deleteUser($uid)
    {
        // fitur belum tersedia
        return $this->response->setJSON([
            'token_crs' => csrf_hash(),
            'res' => false,
            'msg' => 'Fitur belum tersedia'
        ]);
        // $result = $this->superAdminModel->deleteUser($uid);
    
        // if ($result['res'] == 1) {
        //     return $this->response->setJSON([
        //         'token_crs' => csrf_hash(),
        //         'res' => true,
        //         'msg' => $result['msg']
        //     ]);
        // } else {
        //     return $this->response->setJSON([
        //         'token_crs' => csrf_hash(),
        //         'res' => false,
        //         'msg' => $result['msg']
        //     ]);
        // }
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
    
        $result = $this->superAdminModel->updateOpd($uidx, $opid, $opnm);
    
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
}
