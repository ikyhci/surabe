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
    // $id_ssa = "057226d2d134fa7f7d12730846d47ea91c482d83";
    // $id_opd = "619577ef9777f6503fdd23b17d0794c21f81cd35";
    // Query untuk mendapatkan nilai per indikator
    $jawabanSubQuery = "
        SELECT 
            j2.id_indikator,
            j2.id AS jawaban_id,
            j2.saran
        FROM lke_jawaban j2
    ";

    if ($id_opd !== null) {
        $jawabanSubQuery .= "
            INNER JOIN lke_detail_opd do2
                ON do2.userid = j2.userid
            AND do2.opdid = " . $this->db->escape($id_opd);
    }

    $builder = $this->db->table('lke_sub_sub_aspek ssa')
        ->select("
            ssa.id as sub_sub_aspek_id,
            ssa.nama_sub_sub_aspek,
            ssa.bobot,
            ssa.nums,
            i.id as indikator_id,
            i.max_point,
            ssa.jenis_perhitungan,
            COALESCE(MAX(nj.Nilai), 0) as nilai_indikator,
            COALESCE(MAX(nj.Aproved), 'Belum dinilai') as aprove_status,
            GROUP_CONCAT(
                CASE 
                    WHEN nj.Ket IS NOT NULL AND TRIM(nj.Ket) != '' 
                    THEN CONCAT(ssa.nums, '.', i.nums, '. ', nj.Ket)
                END
                SEPARATOR '\n'
            ) AS keterangan,
            GROUP_CONCAT(
                CASE 
                    WHEN j.saran IS NOT NULL AND TRIM(j.saran) != '' 
                    THEN CONCAT(ssa.nums, '.', i.nums, '. ', j.saran)
                END
                SEPARATOR '\n'
            ) AS saran
        ")
        ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id', 'inner')
        ->join("($jawabanSubQuery) j", 'j.id_indikator = i.id', 'left')
        ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.jawaban_id', 'left')
        ->where('ssa.id', $id_ssa)
        ->groupBy('ssa.id, ssa.nama_sub_sub_aspek, ssa.bobot, ssa.nums, i.id')
        ->orderBy('i.nums', 'asc');

    $results = $builder->get()->getResult();
    // pd($results);
    if (!empty($results)) {
        $count = count($results);
        $bobot = floatval($results[0]->bobot);
        $aprove_list = [];
        $ket_list = [];
        $saran_list = [];
        $jenis = $results[0]->jenis_perhitungan ?? 'avg';
        $sum = 0;

        foreach ($results as $row) {
            $nilai = floatval($row->nilai_indikator);
            $sum += $nilai;

            if (!empty($row->aprove_status)) $aprove_list[] = $row->aprove_status;
            if (!empty(trim($row->keterangan))) $ket_list[] = trim($row->keterangan);
            if (!empty(trim($row->saran))) $saran_list[] = trim($row->saran);
        }

        $nilai_final = ($jenis === 'avg' && $count > 0) ? ($sum / $count) * ($bobot / 100) : $sum * ($bobot / 100);
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
            ->select('nama_sub_sub_aspek, bobot, nums, jenis_perhitungan')
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
                        $subSubAspek[$kkk]->bobot = $hasil->bobot ?? null;
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

    public function getDetailSubSubAspekOpd($opdId, $subSubAspekId)
    {
        $sql = "
            SELECT
                i.id AS indikator_id,
                i.indikator,
                i.max_point,
                ssa.id AS sub_sub_aspek_id,
                ssa.nama_sub_sub_aspek,
                COALESCE(nj.Nilai, 0) AS nilai_indikator,
                nj.Aproved AS aprove_status,
                CASE
                    WHEN j.jawaban_id IS NULL THEN 'OPD belum menginput penilaian mandiri'
                    WHEN nj.IdJawaban IS NULL THEN 'Belum dilakukan penilaian'
                    ELSE nj.Ket
                END AS keterangan,
                j.saran AS saran
            FROM lke_indikator i
            INNER JOIN lke_sub_sub_aspek ssa ON ssa.id = i.id_sub_sub_aspek
            LEFT JOIN (
                SELECT j2.id_indikator, j2.id AS jawaban_id, j2.saran
                FROM lke_jawaban j2
                INNER JOIN lke_detail_opd do2 
                    ON do2.userid = j2.userid 
                    AND do2.opdid = ?
            ) AS j ON j.id_indikator = i.id
            LEFT JOIN lke_nilai_jawaban_user nj ON nj.IdJawaban = j.jawaban_id
            WHERE ssa.id = ?
            ORDER BY i.nums ASC
        ";

        return $this->db->query($sql, [$opdId, $subSubAspekId])->getResultArray();
    }

    private function floatRound($v, $precision = 2)
    {
        return is_numeric($v) ? round(floatval($v), $precision) : 0.0;
    }

    
}