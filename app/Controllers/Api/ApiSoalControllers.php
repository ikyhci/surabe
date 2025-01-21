<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class ApiSoalControllers extends BaseController
{
    public function __construct(){
        // $request = request();
        // $key = getenv('TOKEN_SECRET');
        // $token = null;
        // $header = $request->getHeader("Authorization");
        //  if(!empty($header)) {
        //     if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
        //         $token = $matches[1];
        //     }
        // }
        // if(is_null($token) || empty($token)) {
        //     $response = service('response');
        //     $response->setBody('Access denied');
        //     $response->setStatusCode(401);
        //     return $response;
        // }else{
        //     $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // }
        $this->db = db_connect();
    }

    public function saveAspek()
    {
        //
        try {
            // if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $nama   = $this->request->getVar('nama');
                $tahun  = $this->request->getVar('tahun');
                $bobot  = $this->request->getVar('bobot');
                $userid = 'c01e70c5551bf859d6de5dd332deaf41c6895742';//$this->decoded->userid

                $save = $this->db->query("CALL Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $bobot."','".
                    $tahun."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            // }else{
            //     $data = array(
            //         'token_crs' =>  csrf_hash(),
            //         'success'   =>  0,
            //         'msg'       =>  'error invalid token'
            //     );
            //     return $this->response->setJSON($data);
            // }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    }

    public function saveIndikator()
    {
        try {
            // if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $aspk   = $this->request->getVar('aspek');
                $sasp   = $this->request->getVar('subaspek');
                $ssasp  = $this->request->getVar('subsubaspek');
                $nama   = $this->request->getVar('nama');
                $jjwb   = $this->request->getVar('jjwb');
                $userid = 'c01e70c5551bf859d6de5dd332deaf41c6895742';//$this->decoded->userid

                $save = $this->db->query("CALL Indikator_add_edit('".
                    $userid."','".
                    $id."','".
                    $ssasp."','".
                    $nama."','".
                    $jjwb."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            // }else{
            //     $data = array(
            //         'token_crs' =>  csrf_hash(),
            //         'success'   =>  0,
            //         'msg'       =>  'error invalid token'
            //     );
            //     return $this->response->setJSON($data);
            // }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }

    }

    public function saveParameter()
    {
        try {
            // if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                // $aspk   = $this->request->getVar('aspek');
                // $sasp   = $this->request->getVar('subaspek');
                // $ssasp  = $this->request->getVar('subsubaspek');
                $indkt  = $this->request->getVar('indikator');
                $nama   = $this->request->getVar('nama');
                $userid = 'c01e70c5551bf859d6de5dd332deaf41c6895742';//$this->decoded->userid

                $save = $this->db->query("CALL Parameter_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $indkt."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            // }else{
            //     $data = array(
            //         'token_crs' =>  csrf_hash(),
            //         'success'   =>  0,
            //         'msg'       =>  'error invalid token'
            //     );
            //     return $this->response->setJSON($data);
            // }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    }
}
