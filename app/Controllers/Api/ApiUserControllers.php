<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;

class ApiUserControllers extends BaseController
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
    
    public function index()
    {
        //
    }

    public function getPenilaianMandiri()
    {
        try {
            if (!empty($this->decoded->aud)) {
                
                // $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $LIMIT = null;
                $OFFSET =null;
                $thn = $this->request->getVar('thn')? $this->request->getVar('thn') : null;;
                // $list = $this->db->query("call View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
                $list = $this->db->query("call View_Penilaian_Mandiri('".$thn."')")->getResult();
                $data = array(
                        'token_crs' => csrf_hash(),
                        'dt'        => $list,
                        'success'   =>  1,
                        'msg'       =>  'success',
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

    public function getSoalData()
    {
        try {
            if (!empty($this->decoded->aud)) {
                $IDX = base64_decode($this->request->getVar('form'));
                $LIMIT = null;
                $OFFSET =null;
                $list = $this->db->query("call View_List_Data_Soal_User('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
                $data = array(
                        'token_crs' => csrf_hash(),
                        'dt'        =>  $list,
                        'success'   =>  1,
                        'msg'       =>  'success',
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

    public function getDetailIndikator()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 
                $IDX = $this->request->getVar('idx');
                $LIMIT = null;
                $OFFSET = null;
                $userid = $this->decoded->ids;
                $indk = $this->db->query("call View_Indikator('".$IDX."','".$userid."','".$LIMIT."','".$OFFSET."')")->getRow();
                $prmt = $this->db->query("call View_Parameter('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
                $bkd  = $this->db->query("call View_Bukti_dukung('".$IDX."','".$userid."','".$LIMIT."','".$OFFSET."')")->getResult();

                $flx = $this->db->query("CALL View_UploadFile(null,'".$userid."','".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();

                $data = array(
                        'token_crs' => csrf_hash(),
                        'success'   =>  1,
                        'msg'       =>  'success',
                        'dt'        => array(
                                        'indk'  => $indk,
                                        'prmt'  => $prmt,
                                        'btdk'  => $bkd,
                                        'flx'   => $flx,
                                        ),
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

    public function saveJawaban()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $indkt  = $this->request->getVar('indikator');
                $nama   = $this->request->getVar('jwbn');
                $userid = $this->decoded->ids;//$this->decoded->userid

                $save = $this->db->query("CALL Jawaban_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $indkt."')")->getRow();

                $getFl = $this->db->query("CALL View_File_For_Upload('".$indkt."','".$userid."',null,null)")->getResult();

                foreach ($getFl as $key) {
                    if ($this->request->getFile($key->id) != null) {
                        if ($this->request->getFile($key->id)->isValid() && ! $this->request->getFile($key->id)->hasMoved()) {
                            $newName = $this->request->getFile($key->id)->getRandomName();
                            $this->request->getFile($key->id)->move('uploadfile', $newName);
                            $savebukti = $this->db->query("CALL upload_bukti_add_edit('".
                                $userid."','".
                                $id."','".
                                $key->id."','".
                                $newName."')")->getRow();
                        }
                    }
                    
                }

                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  1,
                        'msg'       =>  'Tambah Data Berhasil',
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
}
