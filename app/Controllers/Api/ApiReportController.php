<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;

class ApiReportController extends BaseController
{

    protected $db;
    protected $decoded;

    public function __construct()
    {
        $request = request();
        $key = getenv('TOKEN_SECRET');
        $token = null;
        $header = $request->getHeader("Authorization");
        // if(!empty($header)) {
        //     if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
        //         $token = $matches[1];
        //     }
        // }
        // $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $this->db = db_connect();
    }


    public function data_opd($tahun, $opdId)
    {
        $nilaiModel = new \App\Models\NilaiModel();

        if (empty($opdId) || empty($tahun)) {

            $data = array(
                'token_crs'     =>  csrf_hash(),
                'success'       =>  0,
                'msg'           =>  'Bad Request, Parameter tidak lengkap',
                'StatusCode'    =>  '400',
            );
            return $this->response->setJSON($data);
        }
        // $opdId = '619577ef9777f6503fdd23b17d0794c21f81cd35';
        // $tahun = '2025';

        $reportData = $nilaiModel->getReportData($opdId, $tahun);
        $data = array(
            'token_crs'     =>  csrf_hash(),
            'success'       =>  1,
            'msg'           =>  'Data laporan berhasil diambil',
            'StatusCode'    =>  '200',
            'data'          =>  $reportData,
        );
        return $this->response->setJSON($data);
    }
}
