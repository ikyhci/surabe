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

    public function getAspek($tahun = null) {

        $aspek = $this->db->table('lke_aspek')
                    ->select('id, nama_aspek');
        if ($tahun !== null) {
            $aspek->where('tahun', $tahun);
        }
        $aspek = $aspek->get()->getResult();
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

        return $query;
    }
    
    
}
