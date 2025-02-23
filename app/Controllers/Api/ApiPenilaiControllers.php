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
    
    public function index()
    {
        //
    }

    public function getPenilaianMandiri()
    {
        $idaspek = $this->request->getVar('asp');
        $ttahun = $this->request->getVar('thn');
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
        $penilaianModel = new PenilaianModel();
        $idOpd = $this->request->getVar('idOpd');
        $id_indikator = $this->request->getVar('id');
        $indikator = $penilaianModel->indikatorAndJawabanOpd($id_indikator, $idOpd);
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
        
        $dataForm = $this->request->getVar('dataForm');
        parse_str($dataForm, $parsedData);
        $data = $parsedData['data'];
        $point = $parsedData['point'];
        $keterangan = $parsedData['keterangan'];
        $aprv = isset($parsedData['aprv']) ? $parsedData['aprv'] : null;
        $jawaban = isset($parsedData['jawaban']) ? $parsedData['jawaban'] : null;

        $id_jawaban = json_decode(base64_decode($data))->kondisiOpd[0]->id_jawaban;
        $penilaianModel = new PenilaianModel();
        $update = $penilaianModel->updatePoint($id_jawaban, $point, $keterangan, $aprv, $jawaban);
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

    public function uploadBuktiDukung(){

        $penilaianModel = new PenilaianModel();
        $idOpd = $this->request->getVar('idOpd');
        $id_indikator = $this->request->getVar('idIndikator');
        $idbkt = $this->request->getVar('id');
        $indikator = $penilaianModel->indikatorAndJawabanOpd($id_indikator, $idOpd);

        $file = $this->request->getFile('file');
        if (!$file->isValid()) {
            $response = [
                'csrf_token' => csrf_hash(),
                'status' => 400,
                'message' => $file->getErrorString(),
                'data' => $indikator
            ];
            return $this->response->setJSON($response);
        }

        $newName = $file->getRandomName();
        $file->move('uploadfile', $newName);
        if ($file->hasMoved()) {
            $savebukti = $penilaianModel->saveBuktiDukung($idOpd, $idbkt, $newName);
            if ($savebukti === false) {
                unlink('uploadfile/' . $newName);
                $response = [
                    'csrf_token' => csrf_hash(),
                    'status' => 400,
                    'message' => 'File Gagal diunggah',
                    'data' => $indikator
                ];
            }else {
                $response = [
                    'csrf_token' => csrf_hash(),
                    'status' => 200,
                    'message' => 'File Berhasil diunggah',
                    'data' => $indikator
                ];
            }
        } else {
            $response = [
                'csrf_token' => csrf_hash(),
                'status' => 400,
                'message' => 'File gagal diunggah',
                'data' => $indikator
            ];
        }
        
        return $this->response->setJSON($response);
    }
}
