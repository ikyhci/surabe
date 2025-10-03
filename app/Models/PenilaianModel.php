<?php

namespace App\Models;

use CodeIgniter\Model;
use App\Models\LkeSubAspek;

class PenilaianModel extends Model
{
    protected $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = db_connect();
    }
    
    public function getDataOpd($form_id, $idSubASpek = null)
    {
        // dd();

        // $aspek = $this->db->query("CALL View_Aspek('".$idasp."', null, null)")->getRow();
        // $tahun = $aspek->tahun;
        // if ($tahun === null) {
        //     $tahun = date('Y');
        // }
        $form = $this->db->query("CALL View_Forms('$form_id', null, null)")->getRow();
        $form->rb = $this->getRbForm($form->id);

        $tahun = $form->tahun;
        $data = [];
        $opd = $this->db->query("call View_Opd(null, null, null)")->getResult();

        // $indikator = $this->indikatorByAspek($idasp);
        $indikator = $this->getIndikatorTahunan($tahun, null);
        $jumlahIndikator = count($indikator);

        foreach ($opd as $key => $value) {
            $kondisiOpd = $this->getJawabanByOPD($value->id, null, null, $tahun);
            $jumlahKondisi = count($kondisiOpd);
            $data[] = [
                'id' => $value->id,
                // 'formdata'  => base64_encode(json_encode($form)),
                'formid' => base64_encode(json_encode([
                    'opdid' => $value->id, 
                    'idForm' => $form_id, 
                    'idasp' => null, 
                    'tahun' => $tahun
                ])),
                'nama_opd' => $value->nama_opd,
                'detail' => [
                    'jumlah_indikator' => $jumlahIndikator,
                    'jumlah_kondisi' => $jumlahKondisi,
                ]
                
            ];
        }

        return $data;
    }

    // public function getAspek($tahun=null)
    // {
    //     $aspek = $this->db->query("CALL View_Aspek(null, null, null)")->getResult();
    //     if ($tahun) {
            
    //         $aspek = array_filter($aspek, function ($x) use ($tahun) {
    //             return isset($x->tahun) && $x->tahun === $tahun;
    //         });
    //     }
    //     return $aspek;
    // }
    public function getRbForm($form_id){
        $rb = $this->db->table('lke_rb')
                    ->where('form_id', $form_id)
                    ->orderBy('nums', 'ASC')
                    ->get()
                    ->getResult();
        foreach ($rb as $key => $value) {
            $rb[$key]->aspek = $this->getAspekRb($value->id);
        }
        return $rb;
    }
    public function getAspekRb($rb_id) {
        $aspek = $this->db->table('lke_aspek')
                    ->where('rb_id', $rb_id)
                    ->orderBy('nums', 'ASC')
                    ->get()
                    ->getResult();
        foreach ($aspek as $key => $value) {
            $aspek[$key]->sub_aspek = $this->getSubAspekAspek($value->id);
        }
        return $aspek;
    }
    public function getSubAspekAspek($aspek_id) {
        $sub_aspek = $this->db->table('lke_sub_aspek')
                    ->where('id_aspek', $aspek_id)
                    ->orderBy('nums', 'ASC')
                    ->get()
                    ->getResult();
        foreach ($sub_aspek as $key => $value) {
            $sub_aspek[$key]->sub_sub_aspek = $this->getSubSubAspekSubAspek($value->id);
        }
        return $sub_aspek;
    }
    public function getSubSubAspekSubAspek($sub_aspek_id) {
        $sub_sub_aspek = $this->db->table('lke_sub_sub_aspek')
                    ->where('id_sub_aspek', $sub_aspek_id)
                    ->orderBy('nums', 'ASC')
                    ->get()
                    ->getResult();
        foreach ($sub_sub_aspek as $key => $value) {
            $sub_sub_aspek[$key]->indikator = $this->getIndikatorSubSubAspek($value->id);
        }
        return $sub_sub_aspek;
    }
    public function getIndikatorSubSubAspek($sub_sub_aspek_id, $idopd=null) {
        $indikator = $this->db->table('lke_indikator')
                    ->where('id_sub_sub_aspek', $sub_sub_aspek_id)
                    ->orderBy('nums', 'ASC')
                    ->get()
                    ->getResult();
        foreach ($indikator as $key => $value) {
            // $indikator[$key]->sub_sub_aspek = $this->getParameterIndikator($value->id);
            if ($idopd) {
                $indikator[$key]->kondisiOpd = $this->getJawabanByOPD($idopd, $value->id, null, null);
            } else {
                $indikator[$key]->kondisiOpd = [];
            }
        }
        return $indikator;
    }

    public function getAspek($tahun = null) {

        $aspek = $this->db->table('lke_aspek')
                    // ->select('id, nama_aspek, rb_id');
                    ->select('lke_aspek.id, nama_aspek, tahun, rb_id')
                    ->join('lke_rb', 'lke_rb.id = lke_aspek.rb_id', 'left')
                    ->join('lke_form', 'lke_form.id = lke_rb.form_id', 'left');

        if ($tahun !== null && false ) {
            $aspek->where('tahun', $tahun);
        }
        $aspek = $aspek->get()->getResult();
        return $aspek;
    }
    

    public function indikatorByAspek($idAspek)
    {
        // dd($idAspek);
        $db = \Config\Database::connect();
        $builder = $db->table('lke_aspek a')
            ->select('
                a.id AS aspek_id, 
                a.nama_aspek, 
                a.bobot AS aspek_bobot, 
                a.tahun AS aspek_tahun, 
                sa.id AS sub_aspek_id, 
                sa.nama_sub_aspek, 
                sa.bobot AS sub_aspek_bobot, 
                ssa.id AS sub_sub_aspek_id, 
                ssa.nama_sub_sub_aspek, 
                ssa.bobot AS sub_sub_aspek_bobot, 
                i.id AS indikator_id, 
                i.indikator
            ')
            ->join('lke_sub_aspek sa', 'sa.id_aspek = a.id', 'inner')
            ->join('lke_sub_sub_aspek ssa', 'ssa.id_sub_aspek = sa.id', 'inner')
            ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner');

        $builder->where('a.id', $idAspek);

        $query = $builder->get();
        $result = $query->getResultArray();
        return $result;
    }

    // public function getJawabanByOPD($opd_id, $indikator_id=null, $aspek_id=null, $tahun=null)
    // {
    //     if(!$tahun){
    //         $tahun = date('Y');
    //     }

    //     if ($indikator_id && !$aspek_id) {
    //         return $this->db->table('lke_jawaban a')
    //         ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, nj.nilai, a.nilai nilaiSementara, a.aprove, a.ket, a.saran')
    //         ->join('lke_nilai_jawaban_user nj', 'a.id=nj.idJawaban', 'left')
    //         ->join('lke_user b', 'a.userid = b.uid', 'inner')
    //         ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
    //         ->join('lke_opd d', 'c.opdid = d.id', 'inner')
    //         ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
    //         ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
    //         ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
    //         ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
    //         ->join('lke_rb rb', 'asp.rb_id = rb.id', 'inner')
    //         ->join('lke_form f', 'rb.form_id = f.id', 'inner')
    //         ->where('d.id', $opd_id)
    //         ->where('e.id', $indikator_id)
    //         ->where('f.tahun', $tahun)
    //         ->get()
    //         ->getResultArray();
    //     } elseif (!$indikator_id && $aspek_id) {
    //         return $this->db->table('lke_jawaban a')
    //         ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, nj.nilai, a.nilai nilaiSementara, a.aprove, a.ket, a.saran')
    //         ->join('lke_nilai_jawaban_user nj', 'a.id=nj.idJawaban', 'left')
    //         ->join('lke_user b', 'a.userid = b.uid', 'inner')
    //         ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
    //         ->join('lke_opd d', 'c.opdid = d.id', 'inner')
    //         ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
    //         ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
    //         ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
    //         ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
    //         ->join('lke_rb rb', 'asp.rb_id = rb.id', 'inner')
    //         ->join('lke_form f', 'rb.form_id = f.id', 'inner')
    //         ->where('d.id', $opd_id)
    //         ->where('asp.id', $aspek_id)
    //         ->where('f.tahun', $tahun)
    //         ->get()
    //         ->getResultArray();
    //     } elseif ($indikator_id && $aspek_id) {
    //         return $this->db->table('lke_jawaban a')
    //         ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, nj.nilai, a.nilai nilaiSementara, a.aprove, a.ket, a.saran')
    //         ->join('lke_nilai_jawaban_user nj', 'a.id=nj.idJawaban', 'left')
    //         ->join('lke_user b', 'a.userid = b.uid', 'inner')
    //         ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
    //         ->join('lke_opd d', 'c.opdid = d.id', 'inner')
    //         ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
    //         ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
    //         ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
    //         ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
    //         ->join('lke_rb rb', 'asp.rb_id = rb.id', 'inner')
    //         ->join('lke_form f', 'rb.form_id = f.id', 'inner')
    //         ->where('d.id', $opd_id)
    //         ->where('e.id', $indikator_id)
    //         ->where('asp.id', $aspek_id)
    //         ->where('f.tahun', $tahun)
    //         ->get()
    //         ->getResultArray();
    //     } else {
    //         return $this->db->table('lke_jawaban a')
    //         ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, nj.nilai, a.nilai nilaiSementara, a.aprove, a.ket, a.saran')
    //         ->join('lke_nilai_jawaban_user nj', 'a.id=nj.idJawaban', 'left')
    //         ->join('lke_user b', 'a.userid = b.uid', 'inner')
    //         ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
    //         ->join('lke_opd d', 'c.opdid = d.id', 'inner')
    //         ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
    //         ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
    //         ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
    //         ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
    //         ->join('lke_rb rb', 'asp.rb_id = rb.id', 'inner')
    //         ->join('lke_form f', 'rb.form_id = f.id', 'inner')
    //         ->where('d.id', $opd_id)
    //         ->where('f.tahun', $tahun)
    //         ->get()
    //         ->getResultArray();
    //     }
    // }
    public function getJawabanByOPD($opd_id, $indikator_id = null, $aspek_id = null, $tahun = null)
    {
        if (!$tahun) {
            $tahun = date('Y');
        }

        $builder = $this->db->table('lke_jawaban a')
            ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, nj.nilai, a.nilai nilaiSementara, a.aprove, a.ket, a.saran')
            ->join('lke_nilai_jawaban_user nj', 'a.id = nj.idJawaban', 'left')
            ->join('lke_user b', 'a.userid = b.uid', 'inner')
            ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
            ->join('lke_opd d', 'c.opdid = d.id', 'inner')
            ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
            ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
            ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
            ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
            ->join('lke_rb rb', 'asp.rb_id = rb.id', 'inner')
            ->join('lke_form f', 'rb.form_id = f.id', 'inner')
            ->where('d.id', $opd_id)
            ->where('f.tahun', $tahun);

        // Tambahkan filter opsional
        if ($indikator_id) {
            $builder->where('e.id', $indikator_id);
        }
        if ($aspek_id) {
            $builder->where('asp.id', $aspek_id);
        }

        // Grouping agar tidak duplikat
        $builder->groupBy('a.id, a.Jawaban, d.nama_opd, b.UserName, e.id, e.indikator, a.nilai, a.aprove, a.ket, a.saran ');

        return $builder->get()->getResultArray();
    }

    public function nestedData($id_asp, $id_opd = null, $ids_aspek = null, $idForm = null)
    {
        // $aspeks = $this->db->query("CALL View_Aspek('".$id_asp."', null, null)")->getResult();
        $aspeks = $this->db->table('lke_rb rb')
                           ->join('lke_aspek la','la.rb_id = rb.id','inner')
                           ->select("rb.id rb_id, rb.nama rb_nama, rb.nums rb_nums, la.*")
                           ->where('rb.form_id', $idForm)
                           ->orderBy("rb.nums","ASC")
                           ->orderBy("la.nums","ASC")
                           ->get()->getResult();
        // pd($aspeks, false);
        $idAspeks = [];
        foreach ($aspeks as $item) {
            $idAspeks[] = $item->id;
        }
        // pd($idAspeks);
        foreach ($aspeks as $aspek) {
            if (!$aspek) {
                return null;
            }
            
            if (is_array($ids_aspek) && !empty($ids_aspek)) {
                $aspek->subaspek = $this->db->table('lke_sub_aspek')
                                            ->where('id_aspek', $aspek->id)
                                            ->whereIn('id', $ids_aspek)
                                            ->orderBy('nums', 'ASC')
                                            ->get()->getResult();
            } else {
                $aspek->subaspek = $this->db->table('lke_sub_aspek')
                                            ->where('id_aspek', $aspek->id)
                                            ->orderBy('nums', 'ASC')
                                            ->get()->getResult();
            }
            
            foreach ($aspek->subaspek as $subaspek) {
                $subaspek->subsubaspek = $this->db->table('lke_sub_sub_aspek')->where('id_sub_aspek', $subaspek->id)->get()->getResult();
    
                foreach ($subaspek->subsubaspek as $subsubaspek) {
                    $subsubaspek->indikator = $this->db->table('lke_indikator')->where('id_sub_sub_aspek', $subsubaspek->id)->orderBy('nums', 'ASC')->get()->getResult();
                    foreach ($subsubaspek->indikator as $indikator) {
                        $indikator->jenis_jawaban = $this->db->table('lke_Jenis_Jawaban')->where('id', $indikator->jenis_jawaban)->get()->getRow();
                        $indikator->parameter = $this->db->table('lke_parameter')->where('id_indikator', $indikator->id)->get()->getResult();
                        $indikator->kondisiOpd = $this->getJawabanByOPD($id_opd, $indikator->id, $id_asp);
                        $indikator->bukti_dukung = $this->db->table('lke_bukti_dukung')->where('id_indikator', $indikator->id)->get()->getResult();
                        foreach($indikator->kondisiOpd as $s => $kondisi){
                            $indikator->kondisiOpd[$s]['bukti'] = $this->getUploadBukti(null, $indikator->id, $id_opd);
                        }
    
                    }
                }
            }
            if ($id_opd) {
                $aspek->opd = $this->db->query("call View_Opd('$id_opd', null, null)")->getResult();
            }
        }
        
        return $aspeks;
    }

    public function indikatorAndJawabanOpd($id_ind, $id_opd) {
        $indikator = $this->db->table('lke_indikator')->where('id', $id_ind)->get()->getRow();
        $indikator->jenis_jawaban = $this->db->table('lke_Jenis_Jawaban')->where('id', $indikator->jenis_jawaban)->get()->getRow();
        $indikator->parameter = $this->db->table('lke_parameter')
            ->where('id_indikator', $indikator->id)
            ->orderBy('create_at', 'ASC')
            ->get()
            ->getResult();
        $indikator->kondisiOpd = $this->getJawabanByOPD($id_opd, $id_ind, null);
        $indikator->bukti_dukung = $this->db->table('lke_bukti_dukung')->where('id_indikator', $indikator->id)->get()->getResult();
        foreach($indikator->kondisiOpd as $s => $kondisi){
            $indikator->kondisiOpd[$s]['bukti'] = $this->getUploadBukti(null, $indikator->id, $id_opd);
        }
        return $indikator;
    }

    public function getUploadBukti($idbukti=null, $idIndikator=null, $idOpd=null)
    {
        $builder = $this->db->table('lke_indikator i')
            ->select('i.id AS indikator_id, i.indikator, bd.id AS bukti_dukung_id, bd.bukti_dukung, ub.files, o.nama_opd')
            ->join('lke_bukti_dukung bd', 'bd.id_indikator = i.id', 'inner')
            ->join('lke_upload_bukti ub', 'ub.id_bukti = bd.id', 'left')
            ->join('lke_detail_opd uo', 'uo.userid = ub.userid', 'left')
            ->join('lke_opd o', 'o.id = uo.opdid', 'left');

        if ($idbukti) {
            $builder->where('bd.id', $idbukti);
        }

        if ($idIndikator) {
            $builder->where('i.id', $idIndikator);
        }

        if ($idOpd) {
            $builder->where('o.id', $idOpd);
        }

        $query = $builder->get();
        return $query->getResultArray();
    }
    
    public function updatePoint($id_jawaban, $point, $keterangan, $aprv, $jawaban, $ids = null, $nilai=null, $saran=null)
    {

        $this->db->transStart();
        $point = isset($point) ? $point : null;
        $builder = $this->db->table('lke_jawaban');
        $builder->where('id', $id_jawaban);
        $builder->update([
            'nilai' => $point, 
            'aprove' => $aprv, 
            'ket' => $keterangan,
            'saran' => $saran,
            // 'Jawaban' => $jawaban
            'aproveby'  => $ids,
            'update_at' => date('Y-m-d H:i:s')
        ]);

        $tbnilai = $this->db->table('lke_nilai_jawaban_user');
        $adaNilai = $tbnilai->where('IdJawaban', $id_jawaban)->get()->getRow();
        if($adaNilai) {
            $tbnilai->where('id', $adaNilai->id)->update([
            'Nilai' => $point,
            'Aproved' => $aprv,
            'Ket' => $keterangan,
            'PenilaiId' => $ids,
            'AproveBy' => $ids,
            'update' => date('Y-m-d H:i:s')
            ]);
        } else {
            $newId = bin2hex(random_bytes(20));
            $tbnilai->insert([
            'id'        => $newId,
            'IdJawaban' => $id_jawaban,
            'Nilai' => $nilai,
            'Aproved' => $aprv,
            'Ket' => $keterangan,
            'PenilaiId' => $ids,
            'AproveBy' => $ids,
            'create_at' => date('Y-m-d H:i:s')
            ]);
        }

        $this->db->transComplete();

        return $this->db->affectedRows();
        // return true;
    }

    public function saveBuktiDukung($idOpd, $idbkt, $newName)
    {
        $userId = $this->db->table('lke_detail_opd')->where('opdid', $idOpd)->get()->getRow()->userid;

        $this->db->query("CALL upload_bukti_add_edit('$idOpd', '', '$idbkt', '$newName')");
        return $this->db->affectedRows();
    }

    public function getIndikatorTahunan($tahun, $idSubASpek = null) {
        
        $db = \Config\Database::connect();
        $builder = $db->table('lke_aspek a')
            ->select('
                a.id AS aspek_id, 
                a.nama_aspek, 
                a.bobot AS aspek_bobot, 
                f.tahun AS aspek_tahun, 
                sa.id AS sub_aspek_id, 
                sa.nama_sub_aspek, 
                sa.bobot AS sub_aspek_bobot, 
                ssa.id AS sub_sub_aspek_id, 
                ssa.nama_sub_sub_aspek, 
                ssa.bobot AS sub_sub_aspek_bobot, 
                i.id AS indikator_id, 
                i.indikator
            ')
            ->join('lke_rb rb', 'rb.id = a.rb_id', 'inner')
            ->join('lke_form f', 'f.id = rb.form_id', 'inner')
            ->join('lke_sub_aspek sa', 'sa.id_aspek = a.id', 'inner')
            ->join('lke_sub_sub_aspek ssa', 'ssa.id_sub_aspek = sa.id', 'inner')
            ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner');

        $builder->where('f.tahun', $tahun);
        if($idSubASpek !== null){
            $builder->whereIn('sa.id', $idSubASpek);
        }
        $query = $builder->get();
        $result = $query->getResultArray();
        return $result;
    }

    public function UserInfo($id)
    {
        $userInfo = $this->db->table('lke_user')
                    ->select('lke_user.uid, lke_user.UserName, lke_user.FullName, lke_user.Phone, lke_user.EmailAdds, lke_roles.RoleName, lke_roles.acs, ')
                    ->join('lke_role', 'lke_role.Uid = lke_user.uid', 'inner')
                    ->join('lke_roles', 'lke_role.RoleId = lke_roles.RoleId', 'inner')
                    ->where('lke_user.uid', $id)
                    ->where('lke_user.actv', 'TRUE')
                    ->limit(1)
                    ->get()
                    ->getRow();
        if ($userInfo->acs == '2') {
            $aspek = $this->db->query(" SELECT lsa.* from lke_role lr INNER JOIN lke_sub_aspek lsa ON lsa.id=lr.aspek WHERE lr.Uid = '$id' ")->getResult();
            $userInfo->aspek = $aspek;
        } else {
            $userInfo->aspek = null;
        }
        return $userInfo;
    }

    public function getForm($id = null, $limit = null, $offset = null)
    {
        $form = $this->db->query("CALL View_Forms('$id', '$limit', '$offset')")->getResult();
        if (empty($form)) {
            return [];
        }

        if(count($form) === 1 && $id !== null) {
            $form = $form[0];
            $form->rb = $this->getRbForm($form->id);
            return $form;
        }
        foreach ($form as $key => $value) {
            $form[$key]->rb = $this->getRbForm($value->id);
        }
        return $form;
    }
}