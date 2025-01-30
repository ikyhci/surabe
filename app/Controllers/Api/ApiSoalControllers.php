<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;

class ApiSoalControllers extends BaseController
{
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
        if(is_null($token) || empty($token)) {
            $response = service('response');
            $response->setBody('Access denied');
            $response->setStatusCode(401);
            return $response;
        }else{
            $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        }
        $this->db = db_connect();
    }

    public function saveAspek()
    {
        //
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $nama   = $this->request->getVar('nama');
                $tahun  = $this->request->getVar('tahun');
                $bobot  = $this->request->getVar('bobot');
                $nmform  = $this->request->getVar('namaform');
                $desk  = $this->request->getVar('desk');
                $eval  = $this->request->getVar('eval');
                $btswkt  = $this->request->getVar('wkt');
                $thpn  = null;
                $userid = $this->decoded->ids;//$this->decoded->userid

                $save = $this->db->query("CALL Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $bobot."','".
                    $tahun."','".
                    $nmform."','".
                    $desk."','".
                    $eval."','".
                    $btswkt."','".
                    $thpn."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    }

    public function saveSubAspek()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $aspk   = $this->request->getVar('aspek');
                $nama   = $this->request->getVar('nama');
                $bobot  = $this->request->getVar('bobot');
                $userid = $this->decoded->ids;//$this->decoded->userid

                $save = $this->db->query("CALL Sub_Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $aspk."','".
                    $bobot."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    }

    public function saveSubSubAspek()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $aspk   = $this->request->getVar('subaspek');
                $nama   = $this->request->getVar('nama');
                $bobot  = $this->request->getVar('bobot');
                $userid = $this->decoded->ids;//$this->decoded->userid

                $save = $this->db->query("CALL Sub_Sub_Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $aspk."','".
                    $bobot."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
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
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $aspk   = $this->request->getVar('aspek');
                $sasp   = $this->request->getVar('subaspek');
                $ssasp  = $this->request->getVar('subsubaspek');
                $nama   = $this->request->getVar('nama');
                $jjwb   = $this->request->getVar('jjwb');
                $userid = $this->decoded->ids;//$this->decoded->userid

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
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
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
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $indkt  = $this->request->getVar('indikator');
                $nama   = $this->request->getVar('nama');
                $userid = $this->decoded->ids;//$this->decoded->userid

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
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    } 

    public function saveBuktiDukung()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $indkt  = $this->request->getVar('indkt');
                $nama   = $this->request->getVar('nama');
                $userid = $this->decoded->ids;//$this->decoded->userid

                $save = $this->db->query("CALL Bukti_dukung_add_edit('".
                    $userid."','".
                    $id."','".
                    $indkt."','".
                    $nama."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
                    );
                return $this->response->setJSON($data);
                // 
            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }
            
        } catch (Exception $e) {
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error in : '.$e,
            );
            return $this->response->setJSON($data);
            
        }
    }

    public function delAspek()
    {
        // code...
    }

    public function delSubAspek()
    {
        // code...
    }

    public function delSubSubAspek()
    {
        // code...
    }

    public function delIndikator()
    {
        // code...
    }

    public function delParameter()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idp     = $this->request->getVar('idp');
                $idk     = $this->request->getVar('idk');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Parameter_delete('".
                    $userid."','".
                    $idp."','".
                    $idk."')")->getRow();
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $del->res,
                        'msg'       =>  $del->msg,
                    );
                return $this->response->setJSON($data);


            }else{
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
                return $this->response->setJSON($data);
            }


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
