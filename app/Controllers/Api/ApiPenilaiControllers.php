<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;
use App\Models\PenilaianModel;

class ApiPenilaiControllers extends BaseController
{
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
        // $this->db = db_connect();
    }
    
    public function index()
    {
        //
    }

    public function getPenilaianMandiri()
    {
        $idaspek = $this->request->getVar('asp');
        $penilaianModel = new PenilaianModel();
        $opd = $penilaianModel->getDataOpd($idaspek);
        $response = [
            'status' => 200,
            'message' => 'Data berhasil diambil',
            'data' => $opd
        ];
        return $this->response->setJSON($response);
    }

    public function jawabanOpdIndikator()
    {
        $dtOpd = $this->request->getVar('dataOpd');
        $indikator = json_decode(base64_decode($dtOpd));
        
        $response = [
            'csrf_token' => csrf_hash(),
            'status' => 200,
            'message' => 'Data berhasil diambil',
            'data' => $indikator
        ];
        return $this->response->setJSON($response);
    }

    public function simpanPoint()
    {
        $data = $this->request->getVar('data');
        $point = $this->request->getVar('point');
        $id_jawaban = json_decode(base64_decode($data))->kondisiOpd[0]->id_jawaban;
        $penilaianModel = new PenilaianModel();
        $update = $penilaianModel->updatePoint($id_jawaban, $point);
        if ($update === false) {
            $response = [
                'status' => 400,
                'message' => 'Data gagal disimpan',
                'data' => json_decode(base64_decode($data)),
                'point' => $point
            ];
            return $this->response->setJSON($response);
        }else{
            $response = [
                'csrf_token' => csrf_hash(),
                'status' => 200,
                'message' => 'Data berhasil disimpan',
                'data' => json_decode(base64_decode($data)),
                'point' => $point
            ];
            return $this->response->setJSON($response);
        }

        // $response = [
        //     'csrf_token' => csrf_hash(),
        //     'status' => 200,
        //     'message' => 'Data berhasil disimpan',
        //     'data' => json_decode(base64_decode($data)),
        //     'point' => $point
        // ];
        // return $this->response->setJSON($response);
    }
}
