<?php

namespace App\Controllers\Api;

use CodeIgniter\HTTP\IncomingRequest;
use App\Controllers\BaseController;
use App\Models\DashboardModel;
use Clue\React\NDJson\Decoder;
use CodeIgniter\Commands\Utilities\Publish;
use CodeIgniter\HTTP\Header;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\ResponseInterface;
use Config\App;
use Config\Services;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

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
        if (!$header) {
            $token = $request->getCookie('__LKE-Authorization');
        }
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
            $THN = $this->request->getVar('thn') ? $this->request->getVar('thn') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("call View_Data_List_Soal('".$IDX."','".$LIMIT."','".$OFFSET."','".
                $THN."')")->getResult();
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


    public function getForms()
    {
        if (!empty($this->decoded->aud)) {
            $IDX = $this->request->getVar('idx') ? $this->request->getVar('idx') : null;
            $LIMIT = null;
            $OFFSET =null;
            $list = $this->db->query("CALL View_Forms('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
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
            $RoleId = $this->request->getVar('RoleId') ? $this->request->getVar('RoleId') : null;
            // $LIMIT = null;
            // $OFFSET = null;
            // $list = $this->db->query("call View_Roles('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $list = $this->db->query("call View_Roles()")->getResult();
            if($RoleName && !$RoleId){
                $i = array_search($RoleId, array_column($list, 'RoleId'));
                $list = array($list[$i]);
            } elseif($RoleName && $RoleId){
                
                $i1 = array_search($RoleId, array_column($list, 'RoleId'));
                $list1 = array($list[$i1]);

                $i2 = array_search($RoleId, array_column($list, 'RoleId'));
                $list2 = array($list[$i2]);

                $list = array_merge($list1, $list2);
            } elseif(!$RoleName && $RoleId) {
                $i = array_search($RoleId, array_column($list, 'RoleId'));
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

    public function nilai()
    {

        $tahun = $this->request->getVar('tahun') ?? date('Y');

        $dashboardModel = new DashboardModel();


        $opd = $dashboardModel->getOpd();
        foreach ($opd as $key => $value) {
            $opd[$key]->nilai = 0;
            $instrumen = $dashboardModel->getInstrumen();
            $nilaiInstrumen = [];

            $aspek = $dashboardModel->getAspek($tahun);
            foreach ($aspek as $k => $v) {
                $subAspek = $dashboardModel->getSubAspek($v->id);
                foreach ($subAspek as $kk => $vv) {
                    $subSubAspek = $dashboardModel->getSubSubAspek($vv->id);
                    $totalSubSubAspekNilai = 0;
                    foreach ($subSubAspek as $kkk => $vvv) {
                        $nilai = $dashboardModel->nilaiSubSubAspekOpd($vvv->id, $value->id)->nilai;
                        $subSubAspek[$kkk]->nilai = $nilai?? 0 ;
                        $totalSubSubAspekNilai += $nilai;
                    }
                    $subAspek[$kk]->sub_sub_aspek = $subSubAspek;
                    $subAspek[$kk]->nilai = $totalSubSubAspekNilai;
                }

                $totalSubAspekNilai = array_sum(array_column($subAspek, 'nilai'));
                $aspek[$k]->sub_aspek = $subAspek;
                $aspek[$k]->nilai = $totalSubAspekNilai / count($subAspek);
                foreach ($instrumen as $ik => $iv) {
                    if ($iv->id == $v->rb_id) {
                        $instrumen[$ik]->nilai +=  $aspek[$k]->nilai;
                        $instrumen[$ik]->aspek[] = $aspek[$k];
                    } else {
                        $instrumen[$ik]->nilai +=  0;
                        $instrumen[$ik]->aspek = [];
                    }

                    $opd[$key]->nilai += $instrumen[$ik]->nilai;
                }
            }
            $opd[$key]->instrumen = $instrumen;

        }

        $data = [
            'success' => true,
            'dt' => $opd,
            'msg' => 'Data berhasil diambil',
            'token_crs' => csrf_hash(),
        ];

        return $this->response->setJSON($data);
    }
    
    public function getTahun()
    {
        $lke_form = new \App\Models\LkeForm();
        $tahun = $lke_form->findAll();
        $data = array(
            'token_crs' => csrf_hash(),
            'dt'        => $tahun,
            'success'   => 1,
            'msg'       => 'Data berhasil diambil'
        );

        return $this->response->setJSON($data);
    }

}
