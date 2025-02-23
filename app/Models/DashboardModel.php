<?php

namespace App\Models;

use CodeIgniter\Model;

class DashboardModel extends Model
{
    protected $db;

    public function __construct()
    {
        $this->db = db_connect();
    }

    public function nilaiSubSubAspekOpd($id_ssa, $id_opd=null){
        $builder = $this->db->table('lke_sub_sub_aspek ssa')
                    ->select('o.nama_opd, ssa.nama_sub_sub_aspek, COALESCE(AVG(j.nilai) * CAST(ssa.bobot AS DECIMAL(10,2)), 0) AS nilai')
                    ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner')
                    ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
                    ->join('lke_user u', 'u.uid = j.userid', 'left')
                    ->join('lke_detail_opd do', 'do.userid = u.uid', 'left')
                    ->join('lke_opd o', 'o.id = do.opdid', 'left')
                    ->where('ssa.id', $id_ssa)
                    ->groupBy('o.nama_opd, ssa.nama_sub_sub_aspek, ssa.bobot');

        if ($id_opd !== null) {
            $builder->where('o.id', $id_opd);
            $query = $builder->get()->getRow();

        }else {
            $query = $builder->get()->getResult();
        }
        if ($query) {
            return $query;
        }else {
            $data = new \stdClass();
            $data->nama_opd = null;
            $data->nama_sub_sub_aspek = null;
            $data->nilai = 0;
            return $data;
        }
    }

    public function getAspek($tahun = null) {

        $aspek = $this->db->table('lke_aspek')
                    ->select('id, nama_aspek, tahun, rb_id');
        if ($tahun !== null) {
            $aspek->where('tahun', $tahun);
        }
        $aspek = $aspek->get()->getResult();
        return $aspek;
    }
    
    public function getSubAspek($id_aspek) {
        $sub_aspek = $this->db->table('lke_sub_aspek')
                    ->select('id, nama_sub_aspek')
                    ->where('id_aspek', $id_aspek);
        $sub_aspek = $sub_aspek->get()->getResult();
        return $sub_aspek;
    }

    public function getSubSubAspek($id_sub_aspek) {
        $sub_sub_aspek = $this->db->table('lke_sub_sub_aspek')
                    ->select('id, nama_sub_sub_aspek')
                    ->where('id_sub_aspek', $id_sub_aspek);
        $sub_sub_aspek = $sub_sub_aspek->get()->getResult();
        return $sub_sub_aspek;
    }

    public function getOpd() {
        $opd = $this->db->table('lke_opd')
                    ->select('id, nama_opd, singkatan');
        $opd = $opd->get()->getResult();
        return $opd;
    }
    
    public function getInstrumen() {
        $instrumen = $this->db->table('lke_rb')
                    ->select('id, nama, 0 nilai');
        $instrumen = $instrumen->get()->getResult();
        return $instrumen;
    }

    public function nilaiOpd($tahun = null)
    {

        $tahun = $tahun ?? date('Y') ;
        $opd = $this->getOpd();
        foreach ($opd as $key => $value) {
            $opd[$key]->nilai = 0;
            $instrumen = $this->getInstrumen();
            $nilaiInstrumen = [];

            $aspek = $this->getAspek($tahun);
            foreach ($aspek as $k => $v) {
                $subAspek = $this->getSubAspek($v->id);
                foreach ($subAspek as $kk => $vv) {
                    $subSubAspek = $this->getSubSubAspek($vv->id);
                    $totalSubSubAspekNilai = 0;
                    foreach ($subSubAspek as $kkk => $vvv) {
                        $nilai = $this->nilaiSubSubAspekOpd($vvv->id, $value->id)->nilai;
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

        return $opd;
    }

}
