<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class ApiUserControllers extends BaseController
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
    
    public function index()
    {
        //
    }

    public function getPenilaianMandiri()
    {
        // code...View_Penilaian_Mandiri
        $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
        $LIMIT = null;
        $OFFSET =null;
        // $list = $this->db->query("call View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $list = $this->db->query("call View_Penilaian_Mandiri()")->getResult();
        $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
                'success'   =>  1,
                'msg'       =>  'success',
                );

        return $this->response->setJSON($data);
    }

    public function getSoalData()
    {
        // code...
        // 
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
    }

    public function detailIndikator()
    {
        $idx = $this->request->getVar('idx');
        $LIMIT = null;
        $OFFSET = null;
        $indk = $this->db->query("call View_Indikator('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $prmt = $this->db->query("call View_Parameter('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $bkd  = $this->db->query("call View_Bukti_dukung('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();

        $data = array(
                'token_crs' => csrf_hash(),
                'success'   =>  1,
                'msg'       =>  'success',
                'dt'        => array(
                            'index'     => $indk,
                            'prmt'      => $prmt,
                            'btdk'      => $bkd,
                    ),
                
                );

        return $this->response->setJSON($data);

    }
}
