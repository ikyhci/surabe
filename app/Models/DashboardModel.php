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

    public function nilaiSubSubAspekOpd($id_ssa, $id_opd = null)
    {
        $builder = $this->db->table('lke_sub_sub_aspek ssa')
            ->select("
                o.nama_opd,
                ssa.nama_sub_sub_aspek,
                ssa.bobot,
                ssa.nums,
                MAX(nj.Aproved) AS aprove,
                MAX(nj.Ket) AS ket,
                COALESCE(AVG(nj.Nilai) * (CAST(ssa.bobot AS DECIMAL(10,2)) / 100), 0) AS nilai,
                GROUP_CONCAT(nj.Ket SEPARATOR '\n') AS ssa_ket,
                GROUP_CONCAT(j.saran SEPARATOR '\n') AS ssa_saran
            ")
            ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner')
            ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
            ->join('lke_user u', 'u.uid = j.userid', 'left')
            ->join('lke_detail_opd do', 'do.userid = u.uid', 'left')
            ->join('lke_opd o', 'o.id = do.opdid', 'left')
            ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.id', 'left')
            ->where('ssa.id', $id_ssa);

        if ($id_opd !== null) {
            $builder->where('o.id', $id_opd);
        }

        $builder->groupBy('o.nama_opd, ssa.nama_sub_sub_aspek, ssa.bobot, ssa.nums');

        $query = $builder->get()->getRow();

        if ($query) {
            return $query;
        } else {
            $data = new \stdClass();
            $data->nama_opd = null;
            $data->nama_sub_sub_aspek = null;
            $data->nilai = 0;
            $data->aprove = null;
            $data->nums = null;
            $data->bobot = 0;
            $data->Ket = '';
            $data->saran = '';
            return $data;
        }
    }

    public function getAspek($tahun = null) {
        $aspek = $this->db->table('lke_aspek')
            ->select('lke_aspek.id, lke_aspek.nama_aspek, lke_form.tahun, lke_aspek.rb_id, lke_aspek.nums')
            ->join('lke_rb', 'lke_rb.id = lke_aspek.rb_id', 'left')
            ->join('lke_form', 'lke_form.id = lke_rb.form_id', 'left');

        if ($tahun !== null) {
            $aspek->where('lke_form.tahun', $tahun);
        }
        $aspek->orderBy('nums', 'asc');
        return $aspek->get()->getResult();
    }

    public function getSubAspek($id_aspek) {
        return $this->db->table('lke_sub_aspek')
            ->select('lke_sub_aspek.id, lke_sub_aspek.nama_sub_aspek, lke_sub_aspek.nums')
            ->where('lke_sub_aspek.id_aspek', $id_aspek)
            ->orderBy('nums', 'asc')
            ->get()->getResult();
    }

    public function getSubSubAspek($id_sub_aspek) {
        return $this->db->table('lke_sub_sub_aspek')
            ->select('lke_sub_sub_aspek.id, lke_sub_sub_aspek.nama_sub_sub_aspek, lke_sub_sub_aspek.nums')
            ->where('lke_sub_sub_aspek.id_sub_aspek', $id_sub_aspek)
            ->orderBy('nums', 'asc')
            ->get()->getResult();
    }

    public function getOpd($opd_id = null) {
        $opd = $this->db->table('lke_opd')
            ->select('lke_opd.id, lke_opd.nama_opd, lke_opd.singkatan');
        if ($opd_id !== null) {
            $opd->where('lke_opd.id', $opd_id);
        }
        return $opd->get()->getResult();
    }

    public function getInstrumen() {
        return $this->db->table('lke_rb')
            ->select('lke_rb.id, lke_rb.nama, lke_rb.nums, 0 nilai')
            ->orderBy('nums', 'asc')
            ->get()->getResult();
    }

public function nilaiOpd($tahun = null, $opd_id = null)
{
    $tahun = $tahun ?? date('Y');
    $opd = $this->getOpd($opd_id);

    foreach ($opd as $key => $value) {
        $opd[$key]->nilai = 0;
        $instrumen = $this->getInstrumen();
        $aspek = $this->getAspek($tahun);
        $i_ket = '';
        $i_saran = '';

        foreach ($aspek as $k => $v) {
            $aspek[$k]->nums = $v->nums ?? null;
            $subAspek = $this->getSubAspek($v->id);
            $a_ket = '';
            $a_saran = '';

            foreach ($subAspek as $kk => $vv) {
                $subAspek[$kk]->nums = $vv->nums ?? null;
                $subSubAspek = $this->getSubSubAspek($vv->id);
                $totalSubSubAspekNilai = 0;
                $sa_ket = '';
                $sa_saran = '';

                foreach ($subSubAspek as $kkk => $vvv) {
                    $subSubAspek[$kkk]->nums = $vvv->nums ?? null;
                    $hasil = $this->nilaiSubSubAspekOpd($vvv->id, $value->id);
                    $nilai = $hasil->nilai ?? 0;

                    $subSubAspek[$kkk]->nilai = $nilai;
                    $subSubAspek[$kkk]->aprove = $hasil->aprove ?? null;
                    $subSubAspek[$kkk]->ket = $hasil->ssa_ket ?? null;
                    $subSubAspek[$kkk]->saran = $hasil->ssa_saran ?? null;

                    // kumpulkan ket
                    if (!empty(trim($hasil->ssa_ket ?? ''))) {
                        $sa_ket .= trim($hasil->ssa_ket) . "\n";
                    }

                    // kumpulkan saran
                    if (!empty(trim($hasil->ssa_saran ?? ''))) {
                        $sa_saran .= trim($hasil->ssa_saran) . "\n";
                    }

                    $totalSubSubAspekNilai += $nilai;
                }

                if (!empty(trim($sa_ket))) {
                    $a_ket .= trim($sa_ket) . "\n";
                }
                if (!empty(trim($sa_saran))) {
                    $a_saran .= trim($sa_saran) . "\n";
                }

                $subAspek[$kk]->sub_sub_aspek = $subSubAspek;
                $subAspek[$kk]->nilai = $totalSubSubAspekNilai;
            }

            if (!empty(trim($a_ket))) {
                $i_ket .= trim($a_ket) . "\n";
            }
            if (!empty(trim($a_saran))) {
                $i_saran .= trim($a_saran) . "\n";
            }

            $totalSubAspekNilai = array_sum(array_column($subAspek, 'nilai'));
            $aspek[$k]->sub_aspek = $subAspek;
            $aspek[$k]->nilai = count($subAspek) > 0 ? $totalSubAspekNilai / count($subAspek) : 0;
        }

        foreach ($instrumen as $ik => $iv) {
            $instrumen[$ik]->nums = $iv->nums ?? null;
            $aspek_rb = array_filter($aspek, fn($a) => $a->rb_id == $iv->id);
            $nilai_instrumen = count($aspek_rb) > 0 ? array_sum(array_column($aspek_rb, 'nilai')) / count($aspek_rb) : 0;

            $instrumen[$ik]->nilai = $nilai_instrumen;
            $instrumen[$ik]->aspek = array_values($aspek_rb);
            $opd[$key]->nilai += $nilai_instrumen;
        }

        $opd[$key]->instrumen = $instrumen;
        $opd[$key]->ket = trim($i_ket);
        $opd[$key]->saran = trim($i_saran);
    }

    return $opd;
}
}