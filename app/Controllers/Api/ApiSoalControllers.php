<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;
use Exception;

class ApiSoalControllers extends BaseController
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


    public function getTahun()
    {
        if (!empty($this->decoded->aud)) {
            $thn = $this->db->query('SELECT tahun FROM lke_form group by tahun')->getResult();

            $tahun = array();
                foreach ($thn as $key ) {
                    $tahun[] = $key->tahun;
                }
                
            $data = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => array_unique($tahun),
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


    public function getDashboard()
    {
        if (!empty($this->decoded->aud)) {
            // $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            // $LIMIT = null;
            // $OFFSET =null;
            $list = $this->db->query("call View_Dashboard_Soal()")->getRow();
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

    public function saveForm()
    {
        try {
            if (!empty($this->decoded->aud)) {
                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $nama   = $this->request->getVar('nama');
                $desk  = $this->request->getVar('desk');
                $eval  = $this->request->getVar('eval');
                $btswkt  = $this->request->getVar('wkt');
                $tahun  = $this->request->getVar('tahun');
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Form_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $tahun."','".
                    $desk."','".
                    $eval."','".
                    $btswkt."')")->getRow();

                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
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

    public function saveRb()
    {
        try {
            if (!empty($this->decoded->aud)) {
                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $nama   = $this->request->getVar('nama');
                $bobot  = $this->request->getVar('bobot');
                $fmx    = $this->request->getVar('forms');
                $nox    = $this->request->getVar('nourut'); 
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Rb_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $bobot."','".
                    $fmx."','".
                    $nox."')")->getRow();

                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $save->res,
                        'msg'       =>  $save->msg,
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

    public function saveAspek()
    {
        //
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $nama   = $this->request->getVar('nama');
                $bobot  = $this->request->getVar('bobot');
                $rb     = $this->request->getVar('rb');
                $nox    = $this->request->getVar('nourut'); 
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $bobot."','".
                    $rb."','".
                    $nox."')")->getRow();
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
                $nox    = $this->request->getVar('nourut'); 
                $btswkt = $this->request->getVar('wkt');
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Sub_Aspek_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $aspk."','".
                    $bobot."','".
                    $nox."','".
                    $btswkt."')")->getRow();
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
                $nox    = $this->request->getVar('nourut'); 
                $userid = $this->decoded->ids;

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
                // $aspk   = $this->request->getVar('aspek');
                // $sasp   = $this->request->getVar('subaspek');
                $ssasp  = $this->request->getVar('subsubaspek');
                $nama   = $this->request->getVar('nama');
                $jjwb   = $this->request->getVar('jjwb');
                $nox    = $this->request->getVar('nourut'); 
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Indikator_add_edit('".
                    $userid."','".
                    $id."','".
                    $ssasp."','".
                    $nama."','".
                    $jjwb."','".
                    $nox."')")->getRow();
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
                $nox    = $this->request->getVar('nourut'); 
                $userid = $this->decoded->ids;

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

    public function saveParameter()
    {
        try {
            if (!empty($this->decoded->aud)) {
                // 

                $id     = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
                $indkt  = $this->request->getVar('indikator');
                $nama   = $this->request->getVar('nama');
                $nox    = $this->request->getVar('nourut'); 
                $nilaix = $this->request->getVar('nilai');
                $userid = $this->decoded->ids;

                $save = $this->db->query("CALL Parameter_add_edit('".
                    $userid."','".
                    $id."','".
                    $nama."','".
                    $indkt."','".
                    $nox."','".
                    $nilaix."')")->getRow();
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
    
    public function delForm()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Form_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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


    public function delRb()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Rb_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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

    public function delAspek()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Aspek_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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

    public function delSubAspek()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Sub_Aspek_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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

    public function delSubSubAspek()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL sub_Sub_Aspek_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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

    public function delIndikator()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Indikator_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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


    public function delBuktiDukung()
    {
        try {

            if (!empty($this->decoded->aud)) {

                $idx     = $this->request->getVar('idx');
                $userid = $this->decoded->ids;

                $del = $this->db->query("CALL Bukti_dukung_delete('".
                    $userid."','".
                    $idx."')")->getRow();
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
