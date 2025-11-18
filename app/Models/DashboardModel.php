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
        // Query untuk mendapatkan nilai per indikator terlebih dahulu
        $builder = $this->db->table('lke_sub_sub_aspek ssa')
            ->select("
                ssa.id as sub_sub_aspek_id,
                ssa.nama_sub_sub_aspek,
                ssa.bobot,
                ssa.nums,
                i.id as indikator_id,
                COALESCE(MAX(nj.Nilai), 0) as nilai_indikator,
                MAX(nj.Aproved) as aprove_status,
                MAX(nj.Ket) as keterangan,
                MAX(j.saran) as saran
            ")
            ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner')
            ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
            ->join('lke_user u', 'u.uid = j.userid', 'left')
            ->join('lke_detail_opd do', 'do.userid = u.uid', 'left')
            ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.id', 'left')
            ->where('ssa.id', $id_ssa);

        if ($id_opd !== null) {
            $builder->where('do.opdid', $id_opd);
        }

        $builder->groupBy('ssa.id, ssa.nama_sub_sub_aspek, ssa.bobot, ssa.nums, i.id');
        
        $results = $builder->get()->getResult();

        if (!empty($results)) {
            $total_nilai = 0;
            $count = count($results);
            $bobot = $results[0]->bobot;
            $aprove_list = [];
            $ket_list = [];
            $saran_list = [];
            
            foreach ($results as $row) {
                $total_nilai += floatval($row->nilai_indikator);
                
                if (!empty($row->aprove_status)) {
                    $aprove_list[] = $row->aprove_status;
                }
                if (!empty(trim($row->keterangan))) {
                    $ket_list[] = trim($row->keterangan);
                }
                if (!empty(trim($row->saran))) {
                    $saran_list[] = trim($row->saran);
                }
            }
            
            $rata_rata = $count > 0 ? $total_nilai / $count : 0;
            $nilai_final = $rata_rata * (floatval($bobot) / 100);
            $opd_name = null;
            if ($id_opd !== null) {
                $opd = $this->db->table('lke_opd')
                    ->select('nama_opd')
                    ->where('id', $id_opd)
                    ->get()->getRow();
                $opd_name = $opd->nama_opd ?? null;
            }
            $data = new \stdClass();
            $data->nama_opd = $opd_name;
            $data->nama_sub_sub_aspek = $results[0]->nama_sub_sub_aspek;
            $data->nilai = $this->floatRound($nilai_final);
            $data->aprove = !empty($aprove_list) ? max($aprove_list) : null;
            $data->nums = $results[0]->nums;
            $data->bobot = $bobot;
            $data->ssa_ket = !empty($ket_list) ? implode("\n", $ket_list) : '';
            $data->ssa_saran = !empty($saran_list) ? implode("\n", $saran_list) : '';
            
            return $data;
        } else {
            // Jika tidak ada data, ambil info sub_sub_aspek saja
            $ssa_info = $this->db->table('lke_sub_sub_aspek')
                ->select('nama_sub_sub_aspek, bobot, nums')
                ->where('id', $id_ssa)
                ->get()->getRow();
            
            $opd_name = null;
            if ($id_opd !== null) {
                $opd = $this->db->table('lke_opd')
                    ->select('nama_opd')
                    ->where('id', $id_opd)
                    ->get()->getRow();
                $opd_name = $opd->nama_opd ?? null;
            }
            
            $data = new \stdClass();
            $data->nama_opd = $opd_name;
            $data->nama_sub_sub_aspek = $ssa_info->nama_sub_sub_aspek ?? null;
            $data->nilai = $this->floatRound(0);
            $data->aprove = null;
            $data->nums = $ssa_info->nums ?? null;
            $data->bobot = $ssa_info->bobot ?? 0;
            $data->ssa_ket = '';
            $data->ssa_saran = '';
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

    // public function getInstrumen() {
    //     return $this->db->table('lke_rb')
    //         ->select('lke_rb.id, lke_rb.nama, lke_rb.nums, 0 nilai')
    //         ->orderBy('nums', 'asc')
    //         ->get()->getResult();
    // }
    public function getInstrumen() {
        return $this->db->table('lke_rb')
            ->select("
                lke_rb.id,
                lke_rb.nama,
                lke_rb.nums,
                0 AS nilai,
                CASE
                    WHEN lke_rb.nama like '%RB General Perangkat Daerah%' THEN 65
                    WHEN lke_rb.nama like '%RB TEMATIK PERANGKAT DAERAH%' THEN 35
                    ELSE 0
                END AS bobot
            ")
            ->orderBy('nums', 'asc')
            ->get()
            ->getResult();
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

                $instrumen[$ik]->nilai = ($nilai_instrumen/100) * $instrumen[$ik]->bobot;
                $instrumen[$ik]->aspek = array_values($aspek_rb);
                $opd[$key]->nilai += $instrumen[$ik]->nilai;
            }

            $opd[$key]->instrumen = $instrumen;
            $opd[$key]->ket = trim($i_ket);
            $opd[$key]->saran = trim($i_saran);
        }

        return $opd;
    }

    private function floatRound($v, $precision = 2)
    {
        return is_numeric($v) ? round(floatval($v), $precision) : 0.0;
    }

    
}