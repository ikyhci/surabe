<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use Clue\React\NDJson\Decoder;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;

// Global API Controller

class ApiGlobalControllers extends BaseController
{
    protected $db;
    protected $decoded;
    
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
    }


    public function updateUserData()
    {
        if (!empty($this->decoded->aud)) {
            $idx    = $this->request->getVar('idx');
            $fname  = $this->request->getVar('fname');
            $uname  = $this->request->getVar('uname');
            $umail  = $this->request->getVar('umail');
            $uphon  = $this->request->getVar('phone');
            $upass  = $this->request->getVar('newpas') ? $this->request->getVar('newpas') : null;
            $reppas = $this->request->getVar('reppas');
            $psw ='';
            $udt = '';



            $upddata = $this->db->query("CALL User_Update_data('".
                $idx."','".
                $uname."','".
                $fname."','".
                $uphon."','".
                $umail."')")->getRow();

            $udt = $upddata->res;

            if ($upass != null) {
                if ($upass == $reppas) {
                    $uppass = $this->db->query("CALL User_update_password('".
                    $idx."','".
                    $reppas."')")->getRow();

                    $psw = $uppass->res;


                }else{
                    $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  0,
                        'msg'       =>  'error password tidak sama.'
                    );
                }
                
            }

            if ($udt == 1 && $psw == 1) {
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  1,
                    'msg'       =>  'Data dan Password Berhasil Di Perbarui.'
                );
            }else if ($udt == 1) {
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  1,
                    'msg'       =>  'Data Berhasil Di Perbarui.'
                );
            }

           


            return $this->response->setJSON($data);

        }else{
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token.'
                );
            return $this->response->setJSON($data);
        }
    }
    
    public function getPenilain()
    {
        //
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_Data_List_Soal('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }


    public function getRb()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("CALL View_Rb('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
                    );

            return $this->response->setJSON($data);
        }else{
            $data = array(
                    'token_crs'     =>  csrf_hash(),
                    'success'       =>  0,
                    'msg'           =>  'Access denied cntrl',
                    'StatusCode'    =>  '401',
                    );
            return  json_encode($data);
        }
    }

    public function getAspek()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
                    );

            return $this->response->setJSON($data);
        }else{
            $data = array(
                    'token_crs'     =>  csrf_hash(),
                    'success'       =>  0,
                    'msg'           =>  'Access denied cntrl',
                    'StatusCode'    =>  '401',
                    );
            return  json_encode($data);
        }
    }

    public function getSubAspek()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_Sub_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getSubSubAspek()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_sub_sub_aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getIndikator()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $userid = $this->decoded->ids;
            $list = $this->db->query("call View_Indikator('".$IDX."','".$userid."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getBuktiDukung()
    {
         if (!empty($this->decoded->aud)) {
            $IDX    = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT  = null;
            $OFFSET = null;
            $userid = null;
            $list   = $this->db->query("call View_Bukti_dukung('".$IDX."','".$userid."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getParameter()
    {
        // code...
    }

    public function getJenisJawaban()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_Jenis_Jawaban('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getOPD()
    {
        if (!empty($this->decoded->aud)) {
            $nama_opd = $this->request->getVar('nama_opd') ? $this->request->getVar('nama_opd') : null;
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET = null;
            $list = $this->db->query("call View_Opd('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            if($nama_opd){
                $i = array_search($nama_opd, array_column($list, 'nama_opd'));
                $list = array($list[$i]);
            }
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getRoles()
    {
        if (!empty($this->decoded->aud)) {
            $RoleName = $this->request->getVar('RoleName') ? $this->request->getVar('RoleName') : null;
            // $LIMIT = null;
            // $OFFSET = null;
            // $list = $this->db->query("call View_Roles('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $list = $this->db->query("call View_Roles()")->getResult();
            if($RoleName){
                $i = array_search($RoleName, array_column($list, 'RoleName'));
                $list = array($list[$i]);
            }
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
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
    }

    public function getUSerById()
    {
        if (!empty($this->decoded->aud)) {
            $IDX    = $this->decoded->ids ? $this->decoded->ids : null;
            $LIMIT  = null;
            $OFFSET = null;

            if ($IDX != null) {
                $list   = $this->db->query("call View_Users('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
                $data   = array(
                        'token_crs' => csrf_hash(),
                        'dt'        => $list,
                        );
            }else{
                $data   = array(
                        'token_crs' => csrf_hash(),
                        'dt'        => 'No Data',
                        );
            }
            return $this->response->setJSON($data);
        }else{
            $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  0,
                    'msg'       =>  'error invalid token'
                );
            return $this->response->setJSON($data);
        }
    }

}
