<?php

namespace App\Models;

use CodeIgniter\Model;

class PenilaianModel extends Model
{
    protected $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = db_connect();
    }
    
    public function getDataOpd($idasp)
    {
        // dd();

        $aspek = $this->db->query("CALL View_Aspek('".$idasp."', null, null)")->getRow();
        $tahun = $aspek->tahun;
        if ($tahun === null) {
            $tahun = date('Y');
        }
        $data = [];
        $opd = $this->db->query("call View_Opd(null, null, null)")->getResult();

        $indikator = $this->indikatorByAspek($idasp);
        $jumlahIndikator = count($indikator);

        foreach ($opd as $key => $value) {
            $kondisiOpd = $this->getJawabanByOPD($value->id, null, $idasp);
            $jumlahKondisi = count($kondisiOpd);
            $data[] = [
                'id' => $value->id,
                'formid' => base64_encode(json_encode(['opdid' => $value->id, 'idasp' => $aspek->id])),
                'nama_opd' => $value->nama_opd,
                'detail' => [
                    'jumlah_indikator' => $jumlahIndikator,
                    'jumlah_kondisi' => $jumlahKondisi,
                ]
                
            ];
        }

        return $data;
    }

    public function getAspek($tahun=null)
    {
        $aspek = $this->db->query("CALL View_Aspek(null, null, null)")->getResult();
        if ($tahun) {
            
            $aspek = array_filter($aspek, function ($x) use ($tahun) {
                return isset($x->tahun) && $x->tahun === $tahun;
            });
        }
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

    public function getJawabanByOPD($opd_id, $indikator_id=null, $aspek_id=null)
    {
        if ($indikator_id && !$aspek_id) {
            return $this->db->table('lke_jawaban a')
                ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, a.nilai, a.aprove, a.ket')
                ->join('lke_user b', 'a.userid = b.uid', 'inner')
                ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
                ->join('lke_opd d', 'c.opdid = d.id', 'inner')
                ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
                ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
                ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
                ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
                ->where('d.id', $opd_id)
                ->where('e.id', $indikator_id)
                ->get()
                ->getResultArray();
        }elseif(!$indikator_id && $aspek_id){
            return $this->db->table('lke_jawaban a')
                ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, a.nilai, a.aprove, a.ket')
                ->join('lke_user b', 'a.userid = b.uid', 'inner')
                ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
                ->join('lke_opd d', 'c.opdid = d.id', 'inner')
                ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
                ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
                ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
                ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
                ->where('d.id', $opd_id)
                ->where('asp.id', $aspek_id)
                ->get()
                ->getResultArray();
        }elseif($indikator_id && $aspek_id){
            return $this->db->table('lke_jawaban a')
                ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, a.nilai, a.aprove, a.ket')
                ->join('lke_user b', 'a.userid = b.uid', 'inner')
                ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
                ->join('lke_opd d', 'c.opdid = d.id', 'inner')
                ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
                ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
                ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
                ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
                ->where('d.id', $opd_id)
                ->where('e.id', $indikator_id)
                ->where('asp.id', $aspek_id)
                ->get()
                ->getResultArray();
        }else{
            return $this->db->table('lke_jawaban a')
                ->select('a.id as id_jawaban, a.Jawaban, d.nama_opd, b.UserName, e.id as id_indikator, e.indikator, a.nilai, a.aprove, a.ket')
                ->join('lke_user b', 'a.userid = b.uid', 'inner')
                ->join('lke_detail_opd c', 'b.uid = c.userid', 'inner')
                ->join('lke_opd d', 'c.opdid = d.id', 'inner')
                ->join('lke_indikator e', 'a.id_indikator = e.id', 'inner')
                ->join('lke_sub_sub_aspek ssa', 'e.id_sub_sub_aspek = ssa.id', 'inner')
                ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id', 'inner')
                ->join('lke_aspek asp', 'sa.id_aspek = asp.id', 'inner')
                ->where('d.id', $opd_id)
                ->get()
                ->getResultArray();
        }
    }

    public function nestedData($id_asp, $id_opd = null)
    {
        // $sql = "CALL View_Aspek('".$id_asp."', null, null)";
        $aspek = $this->db->query("CALL View_Aspek('".$id_asp."', null, null)")->getRow();
        if (!$aspek) {
            return null;
        }
        // dd([$aspek, $id_asp, $id_opd, 'sql' => $sql]);
        $aspek->subaspek = $this->db->table('lke_sub_aspek')->where('id_aspek', $aspek->id)->get()->getResult();

        foreach ($aspek->subaspek as $subaspek) {
            $subaspek->subsubaspek = $this->db->table('lke_sub_sub_aspek')->where('id_sub_aspek', $subaspek->id)->get()->getResult();

            foreach ($subaspek->subsubaspek as $subsubaspek) {
                $subsubaspek->indikator = $this->db->table('lke_indikator')->where('id_sub_sub_aspek', $subsubaspek->id)->get()->getResult();
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
        
        return $aspek;
    }

    public function indikatorAndJawabanOpd($id_ind, $id_opd) {
        $indikator = $this->db->table('lke_indikator')->where('id', $id_ind)->get()->getRow();
        $indikator->jenis_jawaban = $this->db->table('lke_Jenis_Jawaban')->where('id', $indikator->jenis_jawaban)->get()->getRow();
        $indikator->parameter = $this->db->table('lke_parameter')->where('id_indikator', $indikator->id)->get()->getResult();
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
    
    public function updatePoint($id_jawaban, $point, $keterangan, $aprv, $jawaban)
    {
        $builder = $this->db->table('lke.lke_jawaban');
        $builder->where('id', $id_jawaban);
        $builder->update([
            'nilai' => $point, 
            'aprove' => $aprv, 
            'ket' => $keterangan, 
            'Jawaban' => $jawaban
        ]);
        return $this->db->affectedRows();
        // return true;
    }

    public function saveBuktiDukung($idOpd, $idbkt, $newName)
    {
        $userId = $this->db->table('lke_detail_opd')->where('opdid', $idOpd)->get()->getRow()->userid;

        $this->db->query("CALL upload_bukti_add_edit('$idOpd', '', '$idbkt', '$newName')");
        return $this->db->affectedRows();
    }
}
