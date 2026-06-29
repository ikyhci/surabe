<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use App\Models\DashboardModel;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

// Global API Controller

class ApiGlobalControllers extends BaseController
{
    protected $db;
    protected $decoded;
    protected $lkeModel;

    public function __construct()
    {
        $request = request();
        $key = getenv('TOKEN_SECRET');
        $token = null;
        $header = $request->getHeader("Authorization");
        if (!$header) {
            $token = $request->getCookie('__Secure-LKE_Authorization');
        }
        if (!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                $token = $matches[1];
            }
        }

        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $this->db = db_connect();
        $this->lkeModel = new \App\Models\LkeModel();
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
            $psw = '';
            $udt = '';

            if (!is_null($upass)) {
                if ($upass == $reppas) {
                    $uppass = $this->db->query("CALL User_update_password('" .
                        $idx . "','" .
                        $reppas . "')")->getRow();

                    $psw = $uppass->res;
                } else {
                    $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  0,
                        'msg'       =>  'error password tidak sama.'
                    );
                    return $this->response->setJSON($data);
                }
            } else {
                $upddata = $this->db->query("CALL User_Update_data('" .
                    $idx . "','" .
                    $uname . "','" .
                    $fname . "','" .
                    $uphon . "','" .
                    $umail . "')")->getRow();

                $udt = $upddata->res;
            }

            if ($udt == 1 && $psw == 1) {
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  1,
                    'msg'       =>  'Data dan Password Berhasil Di Perbarui.'
                );
                return $this->response->setJSON($data);
            } else if ($udt == 1) {
                $data = array(
                    'token_crs' =>  csrf_hash(),
                    'success'   =>  1,
                    'msg'       =>  'Data Berhasil Di Perbarui.'
                );
                return $this->response->setJSON($data);
            }
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("call View_Data_List_Soal('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "','" .
                $THN . "')")->getResult();

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("CALL View_Forms('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $FID = $this->request->getVar('find') ? $this->request->getVar('find') : null;
            $list = $this->db->query("CALL View_Rb('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "','" . $FID . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("call View_Aspek('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("call View_Sub_Aspek('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("call View_sub_sub_aspek('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $userid = $this->decoded->ids;
            $list = $this->db->query("call View_Indikator('" . $IDX . "','" . $userid . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
                'idx'       => $IDX
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $userid = $this->decoded->uid;
            // $userid = null;
            $list   = $this->db->query("call View_Bukti_dukung('" . $IDX . "','" . $userid . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            $list = $this->db->query("call View_Jenis_Jawaban('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getResult();
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;
            // $list = $this->db->query("call View_Opd('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
            $adminModel = new \App\Models\SuperAdminModel();
            $list = $adminModel->getOpd($IDX, $nama_opd, $LIMIT, $OFFSET);
            // pd($list);
            if ($nama_opd) {
                $i = array_search($nama_opd, array_column($list, 'nama_opd'));
                $list = array($list[$i]);
            }
            if ($IDX) {
                if (count($list) === 1) {
                    $list[0]->data_terkait = $adminModel->getUserByOpd($list[0]->id);
                }
            }
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            if ($RoleName && !$RoleId) {
                $i = array_search($RoleId, array_column($list, 'RoleId'));
                $list = array($list[$i]);
            } elseif ($RoleName && $RoleId) {

                $i1 = array_search($RoleId, array_column($list, 'RoleId'));
                $list1 = array($list[$i1]);

                $i2 = array_search($RoleId, array_column($list, 'RoleId'));
                $list2 = array($list[$i2]);

                $list = array_merge($list1, $list2);
            } elseif (!$RoleName && $RoleId) {
                $i = array_search($RoleId, array_column($list, 'RoleId'));
                $list = array($list[$i]);
            }

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $list,
            );

            return $this->response->setJSON($data);
        } else {
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
            $LIMIT = $this->request->getVar('lmt') ? $this->request->getVar('lmt') : null;
            $OFFSET = $this->request->getVar('ofs') ? $this->request->getVar('ofs') : null;

            if ($IDX != null) {
                $list   = $this->db->query("call View_Users('" . $IDX . "','" . $LIMIT . "','" . $OFFSET . "')")->getRow();
                $data   = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => $list,
                );
            } else {
                $data   = array(
                    'token_crs' => csrf_hash(),
                    'dt'        => 'No Data',
                );
            }
            return $this->response->setJSON($data);
        } else {
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
                        $subSubAspek[$kkk]->nilai = $nilai ?? 0;
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


    public function getOpdAspekData()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');

        try {
            $opdData = $this->lkeModel->getOpdWithAspekValuesSimple($tahun);

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $opdData,
                'success'   => 1,
                'msg'       => 'Data OPD dengan nilai aspek berhasil diambil'
            );
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data: ' . $e->getMessage()
            );
        }

        return $this->response->setJSON($data);
    }

    public function getOpdAspekDataDetailed()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');

        try {
            $opdData = $this->lkeModel->getOpdWithAspekValues($tahun);

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $opdData,
                'success'   => 1,
                'msg'       => 'Data OPD detail dengan nilai aspek berhasil diambil'
            );
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data: ' . $e->getMessage()
            );
        }

        return $this->response->setJSON($data);
    }

    public function getRingkasanEvaluasi()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');

        try {
            $ringkasan = $this->lkeModel->getRingkasanEvaluasi($tahun);

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $ringkasan,
                'success'   => 1,
                'msg'       => 'Data ringkasan evaluasi berhasil diambil'
            );
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil ringkasan evaluasi: ' . $e->getMessage()
            );
        }

        return $this->response->setJSON($data);
    }

    public function getEvaluasiLengkap()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');

        try {
            $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun);

            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $evaluasiData,
                'success'   => 1,
                'msg'       => 'Data evaluasi lengkap berhasil diambil'
            );
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data evaluasi lengkap: ' . $e->getMessage()
            );
        }

        return $this->response->setJSON($data);
    }
}
