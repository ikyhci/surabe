<?php

namespace App\Models;

use CodeIgniter\Model;
use \App\Models\NilaiModel;

class LkeModel extends Model
{
    protected $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = \Config\Database::connect();
    }

public function getNilaiSubSubAspek($tahun, $idopd)
{
  return $this->db->table('lke_sub_sub_aspek ssa')
    ->select("
        ssa.id,
        ssa.id_sub_aspek,
        ssa.nama_sub_sub_aspek,
        ssa.bobot,
        COUNT(i.id) AS jumlah_indikator,
        AVG(IFNULL(nj.Nilai, 0)) AS rata_rata_nilai
    ")
    ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id')
    ->join('lke_sub_aspek sa', 'sa.id = ssa.id_sub_aspek')
    ->join('lke_aspek a', 'a.id = sa.id_aspek')
    ->join('lke_rb rb', 'rb.id = a.rb_id')
    ->join('lke_form f', 'f.id = rb.form_id')
    ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
    ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.id', 'left')
    ->join('lke_detail_opd d', 'd.userid = j.userid', 'left')
    ->where('f.tahun', $tahun)
    ->where('d.opdid', $idopd)
    ->groupBy('ssa.id, ssa.id_sub_aspek, ssa.nama_sub_sub_aspek, ssa.bobot')
    ->get()
    ->getResultArray();
}

public function getNilaiSubAspek($tahun, $idopd)
{
    $subSub = $this->getNilaiSubSubAspek($tahun, $idopd);
    $grouped = [];

    foreach ($subSub as $row) {
        $id = $row['id_sub_aspek'];
        if (!isset($grouped[$id])) {
            $grouped[$id] = [
                'id' => $id,
                'total_nilai' => 0,
            ];
        }

        // Hitung nilai SSA dengan bobot
        $nilaiSSA = ($row['rata_rata_nilai'] * $row['bobot']) / 100;

        $grouped[$id]['total_nilai'] += $nilaiSSA;
    }

    foreach ($grouped as &$val) {
        $val['skor_index'] = round($val['total_nilai'], 2); // langsung sum, tanpa bobot lagi
    }

    return array_values($grouped);
}


public function getNilaiAspek($tahun, $idopd)
{
    $subAspek = $this->getNilaiSubAspek($tahun, $idopd);
    $grouped = [];

    foreach ($subAspek as $row) {
        $idAspek = $this->db->table('lke_sub_aspek')
            ->select('id_aspek')
            ->where('id', $row['id'])
            ->get()
            ->getRow('id_aspek');

        if (!isset($grouped[$idAspek])) {
            $grouped[$idAspek] = [
                'id' => $idAspek,
                'scores' => []
            ];
        }

        $grouped[$idAspek]['scores'][] = $row['skor_index'];
    }

    foreach ($grouped as &$val) {
        $val['skor_index'] = count($val['scores']) > 0 
            ? round(array_sum($val['scores']) / count($val['scores']), 2) 
            : 0;
    }

    return array_values($grouped);
}


public function getNilaiRB($tahun, $idopd)
{
    $aspek = $this->getNilaiAspek($tahun, $idopd);
    $grouped = [];

    foreach ($aspek as $row) {
        $idRB = $this->db->table('lke_aspek')
            ->select('rb_id')
            ->where('id', $row['id'])
            ->get()
            ->getRow('rb_id');

        if (!isset($grouped[$idRB])) {
            $grouped[$idRB] = [
                'id' => $idRB,
                'scores' => []
            ];
        }

        $grouped[$idRB]['scores'][] = $row['skor_index'];
    }

    foreach ($grouped as &$val) {
        $val['skor_index'] = count($val['scores']) > 0
            ? round(array_sum($val['scores']) / count($val['scores']), 2)
            : 0;
    }

    return array_values($grouped);
}

public function getTotalNilaiLKE($tahun, $idopd)
{
    $rb = $this->getNilaiRB($tahun, $idopd);

    $scores = array_column($rb, 'skor_index');

    return !empty($scores) 
        ? round(array_sum($scores) / count($scores), 2) 
        : 0;
}

    public function getRekapSemuaOpd($tahun)
    {
        $tahun = (is_array($tahun))? $tahun['tahun'] : $tahun ;
        $builder = $this->db->table('lke_opd o');
        $builder->select('o.id AS opd_id, o.nama_opd, d.userid');
        $builder->join('lke_detail_opd d', 'd.opdid = o.id', 'left');
        $builder->join('lke_user u', 'u.uid = d.userid', 'left');
        $builder->groupBy('o.id');
        $builder->orderBy('o.nama_opd');

        $opds = $builder->get()->getResultArray();

        $result = [];
        foreach ($opds as $opd) {
            // $capaian = $this->getTotalNilaiLKE($tahun, $opd['opd_id']);
            $nilaiOpdModel = new NilaiModel();
            $nilaiOpd = $nilaiOpdModel->getNilaiOpd($opd['opd_id'], $tahun);
            $capaian = $nilaiOpd['opd_nilai'];
            $rb = $this->getNilaiRB($tahun, $opd['opd_id']);
            $result[] = [
                'opd_id' => $opd['opd_id'],
                'nama_opd' => $opd['nama_opd'],
                'userid' => $opd['userid'],
                'capaian' => $capaian,
                'nilai' => $nilaiOpd,
                'rb'    => $rb,
            ];
        }

        return $result;
    }
      
    public function getOpdWithAspekValues($tahun)
    {
        // Get all OPDs
        $builder = $this->db->table('lke_opd o');
        $builder->select('o.id AS opd_id, o.nama_opd, o.singkatan, d.userid');
        $builder->join('lke_detail_opd d', 'd.opdid = o.id', 'left');
        $builder->join('lke_user u', 'u.uid = d.userid', 'left');
        $builder->groupBy('o.id');
        $builder->orderBy('o.nama_opd');
        
        $opds = $builder->get()->getResultArray();
        
        // Get all aspek for the given year
        $aspekBuilder = $this->db->table('lke_aspek a');
        $aspekBuilder->select('a.id, a.nama_aspek, a.bobot, a.nums');
        $aspekBuilder->join('lke_rb rb', 'rb.id = a.rb_id');
        $aspekBuilder->join('lke_form f', 'f.id = rb.form_id');
        $aspekBuilder->where('f.tahun', $tahun);
        $aspekBuilder->orderBy('a.nums');
        
        $aspekList = $aspekBuilder->get()->getResultArray();
        
        $result = [];
        
        foreach ($opds as $opd) {
            $opdData = [
                'opd_id' => $opd['opd_id'],
                'nama_opd' => $opd['nama_opd'],
                'singkatan' => $opd['singkatan'],
                'userid' => $opd['userid'],
                'aspek_values' => [],
                'nilai_akhir' => 0
            ];
            
            // Get nilai per aspek for this OPD
            $nilaiAspek = $this->getNilaiAspekDetailed($tahun, $opd['opd_id']);
            
            $totalSkorIndex = 0;
            $jumlahAspek = 0;
            
            // Map aspek values
            foreach ($aspekList as $aspek) {
                $nilaiAspekData = array_filter($nilaiAspek, function($item) use ($aspek) {
                    return $item['aspek_id'] == $aspek['id'];
                });
                
                $skorIndex = 0;
                if (!empty($nilaiAspekData)) {
                    $skorIndex = reset($nilaiAspekData)['skor_index'];
                }
                
                $opdData['aspek_values'][] = [
                    'aspek_id' => $aspek['id'],
                    'nama_aspek' => $aspek['nama_aspek'],
                    'bobot' => $aspek['bobot'],
                    'nums' => $aspek['nums'],
                    'skor_index' => $skorIndex
                ];
                
                $totalSkorIndex += $skorIndex;
                $jumlahAspek++;
            }
            
            // Calculate nilai akhir
            $opdData['nilai_akhir'] = $jumlahAspek > 0 ? round($totalSkorIndex / $jumlahAspek, 2) : 0;
            
            $result[] = $opdData;
        }
        
        return $result;
    }

    public function getNilaiAspekDetailed($tahun, $idopd)
    {
        return $this->db->table('lke_indikator i')
            ->select("
                CONCAT(rb.nums, '.', a.nums, '.', sa.nums, '.', ssa.nums) AS urutan,
                rb.nama AS komponen,
                rb.bobot AS bobot_rb,
                a.nama_aspek,
                a.bobot AS bobot_as,
                sa.nama_sub_aspek,
                sa.bobot AS bobot_sa,
                ssa.nama_sub_sub_aspek,
                ssa.bobot AS bobot_ssa,
                i.indikator,
                j.jawaban,
                j.nilai AS nilai_jawaban,
                nj.Nilai AS nilai_penilai,
                nj.Aproved,
                nj.Ket,
                CASE 
                    WHEN j.id IS NULL THEN 'Belum diisi'
                    ELSE 'Sudah diisi'
                END AS status_pengisian
            ")
            // INNER JOIN
            ->join('lke_sub_sub_aspek ssa', 'i.id_sub_sub_aspek = ssa.id')
            ->join('lke_sub_aspek sa', 'ssa.id_sub_aspek = sa.id')
            ->join('lke_aspek a', 'sa.id_aspek = a.id')
            ->join('lke_rb rb', 'a.rb_id = rb.id')
            ->join('lke_form f', 'rb.form_id = f.id')
            // LEFT JOIN
            ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
            ->join('lke_user u', 'j.userid = u.uid', 'left')
            ->join('lke_detail_opd dopd', 'dopd.userid = u.uid', 'left')
            ->join('lke_opd o', 'dopd.opdid = o.id AND o.id = ' . $this->db->escape($idopd), 'left') // filter di ON clause
            ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.id', 'left')
            // WHERE filter tahun (aman)
            ->where('f.tahun', $tahun)
            // ORDER BY logika
            ->orderBy("
                CASE rb.nums
                    WHEN 'I' THEN 1
                    WHEN 'II' THEN 2
                    WHEN 'III' THEN 3
                    WHEN 'IV' THEN 4
                    WHEN 'V' THEN 5
                    WHEN 'VI' THEN 6
                    WHEN 'VII' THEN 7
                    WHEN 'VIII' THEN 8
                    WHEN 'IX' THEN 9
                    WHEN 'X' THEN 10
                    ELSE 99
                END
            ", '', false) // false to avoid escaping the CASE
            ->orderBy('a.nums', 'ASC')
            ->orderBy('CAST(sa.nums AS UNSIGNED)', 'ASC', false)
            ->orderBy('CAST(ssa.nums AS UNSIGNED)', 'ASC', false)
            ->orderBy('i.nums', 'ASC')
            ->get()
            ->getResultArray();
    }


    public function getRekapSubAspek($tahun, $idopd) 
    {
        // Get detailed data
        $detailedData = $this->getNilaiAspekDetailed($tahun, $idopd);
        
        // Group data by sub aspek
        $groupedData = [];
        foreach ($detailedData as $row) {
            $key = $row['nama_sub_aspek'];
            
            if (!isset($groupedData[$key])) {
                $groupedData[$key] = $row;
                $groupedData[$key]['sub_sub_aspek'] = [];
            }
            
            // Group sub sub aspek
            $subSubKey = $row['nama_sub_sub_aspek'];
            if (!isset($groupedData[$key]['sub_sub_aspek'][$subSubKey])) {
                $groupedData[$key]['sub_sub_aspek'][$subSubKey] = [
                    'nama_sub_sub_aspek' => $row['nama_sub_sub_aspek'],
                    'bobot_ssa' => $row['bobot_ssa'],
                    'indikator' => [],
                    'nilai_ssa' => 0
                ];
            }
            
            // Add indikator
            if ($row['nilai_penilai'] !== null) {
                $groupedData[$key]['sub_sub_aspek'][$subSubKey]['indikator'][] = [
                    'indikator' => $row['indikator'],
                    'nilai' => $row['nilai_penilai'] ?? $row['nilai_jawaban']
                ];
            }
        }
        
        // Calculate values
        $result = [];
        foreach ($groupedData as $subAspek) {
            $subAspekData = [
                'urutan'         => $subAspek['urutan'],
                'komponen'       => $subAspek['komponen'],
                'nama_aspek'     => $subAspek['nama_aspek'],
                'nama_sub_aspek' => $subAspek['nama_sub_aspek'],
                'bobot'          => $subAspek['bobot_sa'],
                'sub_sub_aspek'  => [],
                'nilai_sa'       => 0
            ];
            
            $totalNilaiSSA = 0;
            
            foreach ($subAspek['sub_sub_aspek'] as $ssa) {
                // Calculate average of indikator values
                $totalNilai = 0;
                $jumlahIndikator = count($ssa['indikator']);
                
                foreach ($ssa['indikator'] as $ind) {
                    $totalNilai += floatval($ind['nilai']);
                }
                
                $rataRataNilai = $jumlahIndikator > 0 ? $totalNilai / $jumlahIndikator : 0;
                
                // Calculate sub sub aspek value
                $nilaiSSA = ($rataRataNilai * $ssa['bobot_ssa']) / 100;
                $totalNilaiSSA += $nilaiSSA;
                
                $subAspekData['sub_sub_aspek'][] = [
                    'nama_sub_sub_aspek' => $ssa['nama_sub_sub_aspek'],
                    'bobot' => $ssa['bobot_ssa'],
                    'rata_rata_nilai' => round($rataRataNilai, 2),
                    'nilai_ssa' => round($nilaiSSA, 2)
                ];
            }
            
            // Set total nilai sub aspek
            $subAspekData['nilai_sa'] = round($totalNilaiSSA, 2);
            
            $result[] = $subAspekData;
        }
        
        return $result;
    }

    public function getRingkasanEvaluasi($tahun)
    {
        // Get all OPDs with their final scores
        $opds = $this->getRekapSemuaOpd($tahun);
        
        // Filter OPDs that have scores (exclude those with 0 scores)
        $opdsWithScores = array_filter($opds, function($opd) {
            return $opd['capaian'] > 0;
        });
        
        $totalInstansi = count($opdsWithScores);
        
        if ($totalInstansi == 0) {
            return [
                'total_instansi' => 0,
                'rata_rata_index' => 0,
                'tertinggi' => 0,
                'terendah' => 0,
                'instansi_tertinggi' => null,
                'instansi_terendah' => null
            ];
        }
        
        // Extract scores for calculation
        $scores = array_column($opdsWithScores, 'capaian');
        
        // Calculate statistics
        $rataRataIndex = round(array_sum($scores) / $totalInstansi, 2);
        $tertinggi = max($scores);
        $terendah = min($scores);
        
        // Find instansi with highest and lowest scores
        $instansiTertinggi = null;
        $instansiTerendah = null;
        
        foreach ($opdsWithScores as $opd) {
            if ($opd['capaian'] == $tertinggi && $instansiTertinggi === null) {
                $instansiTertinggi = [
                    'opd_id' => $opd['opd_id'],
                    'nama_opd' => $opd['nama_opd'],
                    'capaian' => $opd['capaian']
                ];
            }
            if ($opd['capaian'] == $terendah && $instansiTerendah === null) {
                $instansiTerendah = [
                    'opd_id' => $opd['opd_id'],
                    'nama_opd' => $opd['nama_opd'],
                    'capaian' => $opd['capaian']
                ];
            }
        }
        
        return [
            'total_instansi' => $totalInstansi,
            'rata_rata_index' => $rataRataIndex,
            'tertinggi' => $tertinggi,
            'terendah' => $terendah,
            'instansi_tertinggi' => $instansiTertinggi,
            'instansi_terendah' => $instansiTerendah
        ];
    }

    public function getEvaluasiLengkap($tahun)
    {
        return [
            'ringkasan' => $this->getRingkasanEvaluasi($tahun),
            'data_opd' => $this->getOpdWithAspekValuesSimple($tahun)
        ];
    }

public function getOpdWithAspekValuesSimple($tahun)
{
    // Ambil OPD dengan filter role
    $builder = $this->db->table('lke_opd o');
    $builder->select('o.id AS opd_id, o.nama_opd, o.singkatan, d.userid');
    $builder->join('lke_detail_opd d', 'd.opdid = o.id', 'left');
    $builder->join('lke_role r', 'r.Uid = d.userid', 'left');
    $builder->join('lke_roles rs', 'rs.RoleId = r.RoleId', 'left');
    $builder->where('rs.acs', 5);
    $builder->groupBy('o.id');
    $builder->orderBy('o.nama_opd', 'ASC');

    $opds = $builder->get()->getResultArray();

    $result = [];

    foreach ($opds as $opd) {
        // Ambil nilai aspek per OPD
        $aspekNilai = $this->getNilaiAspek($tahun, $opd['opd_id']);

        // Ambil daftar aspek + RB
        $aspekDetails = $this->db->table('lke_aspek a')
            ->select('rb.id as rbId, rb.nama as namaRb, a.id, a.nama_aspek, a.bobot, a.nums')
            ->join('lke_rb rb', 'rb.id = a.rb_id')
            ->join('lke_form f', 'f.id = rb.form_id')
            ->where('f.tahun', $tahun)
            ->orderBy('rb.nums', 'ASC')
            ->orderBy('a.nums', 'ASC')
            ->get()
            ->getResultArray();

        // Ambil rekap sub aspek lengkap
        $rekapSubAspek = $this->getRekapSubAspek($tahun, $opd['opd_id']);

        $aspekValues = [];
        $rbGroups = []; // kumpulan skor aspek per RB

        foreach ($aspekDetails as $aspek) {
            $skorIndex = 0;

            // Cari skor aspek
            foreach ($aspekNilai as $nilai) {
                if ($nilai['id'] == $aspek['id']) {
                    $skorIndex = $nilai['skor_index'];
                    break;
                }
            }

            // Filter sub aspek yang termasuk dalam aspek ini
            $subAspekFiltered = array_filter($rekapSubAspek, function ($item) use ($aspek) {
                return $item['nama_aspek'] === $aspek['nama_aspek'];
            });

            $subAspekList = [];
            foreach ($subAspekFiltered as $sub) {
                $subAspekList[] = [
                    'nama_sub_aspek' => $sub['nama_sub_aspek'],
                    'bobot' => $sub['bobot'],
                    'nilai_sa' => $sub['nilai_sa'],
                    'sub_sub_aspek' => $sub['sub_sub_aspek'] // sudah dalam bentuk array nested
                ];
            }

            $aspekValues[] = [
                'rb_id'         => $aspek['rbId'],
                'nama_rb'       => $aspek['namaRb'],
                'aspek_id'      => $aspek['id'],
                'nama_aspek'    => $aspek['nama_aspek'],
                'skor_index'    => $skorIndex,
                'sub_aspek'     => $subAspekList // ✅ tambahan nested data
            ];

            // Tambahkan skor ke grup RB
            $rbGroups[$aspek['rbId']][] = $skorIndex;
        }

        // Hitung rata-rata per RB
        $rbAverages = [];
        foreach ($rbGroups as $rbId => $scores) {
            $rbAverages[$rbId] = count($scores) > 0 ? array_sum($scores) / count($scores) : 0;
        }

        // Hitung nilai akhir OPD
        $nilaiAkhir = !empty($rbAverages)
            ? round(array_sum($rbAverages) / count($rbAverages), 2)
            : 0;

        $result[] = [
            'opd_id'        => $opd['opd_id'],
            'nama_opd'      => $opd['nama_opd'],
            'singkatan'     => $opd['singkatan'],
            'userid'        => $opd['userid'],
            'aspek_values'  => $aspekValues,
            'nilai_akhir'   => $nilaiAkhir
        ];
    }

    return $result;
}

    public function getDetailEvaluasiByOpd($tahun, $opdId)
    {
        // Get detailed evaluation for specific OPD
        $builder = $this->db->table('lke_sub_sub_aspek ssa');
        $builder->select("
            a.id as aspek_id,
            a.nama_aspek,
            a.nums as aspek_nums,
            sa.id as sub_aspek_id,
            sa.nama_sub_aspek,
            ssa.id as sub_sub_aspek_id,
            ssa.nama_sub_sub_aspek,
            ssa.bobot,
            COUNT(i.id) AS jumlah_indikator,
            SUM(IFNULL(j.nilai, 0)) AS total_skor,
            ROUND(SUM(IFNULL(j.nilai, 0)) / NULLIF(ssa.bobot, 0) * 100, 2) AS skor_index
        ");
        $builder->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id');
        $builder->join('lke_sub_aspek sa', 'sa.id = ssa.id_sub_aspek');
        $builder->join('lke_aspek a', 'a.id = sa.id_aspek');
        $builder->join('lke_rb rb', 'rb.id = a.rb_id');
        $builder->join('lke_form f', 'f.id = rb.form_id');
        $builder->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
        ->join('lke_detail_opd d', 'd.userid = j.userid', 'left');
        $builder->where('f.tahun', $tahun);
        $builder->where('d.opdid', $opdId);
        $builder->groupBy('ssa.id, ssa.nama_sub_sub_aspek, ssa.bobot, sa.id, sa.nama_sub_aspek, a.id, a.nama_aspek, a.nums');
        $builder->orderBy('a.nums, sa.id, ssa.id');
        
        return $builder->get()->getResultArray();
    }

    public function getProgressEvaluasi($tahun, $opdId = null)
    {
        // Get evaluation progress
        $builder = $this->db->table('lke_indikator i');
        $builder->select("
            COUNT(i.id) as total_indikator,
            COUNT(j.id) as terisi,
            COUNT(CASE WHEN j.aprove = 'Y' THEN 1 END) as approved
        ");
        $builder->join('lke_sub_sub_aspek ssa', 'ssa.id = i.id_sub_sub_aspek');
        $builder->join('lke_sub_aspek sa', 'sa.id = ssa.id_sub_aspek');
        $builder->join('lke_aspek a', 'a.id = sa.id_aspek');
        $builder->join('lke_rb rb', 'rb.id = a.rb_id');
        $builder->join('lke_form f', 'f.id = rb.form_id');
        $builder->join('lke_jawaban j', 'j.id_indikator = i.id', 'left');
        
        if ($opdId) {
            $builder->join('lke_detail_opd d', 'd.userid = j.userid', 'left');
            $builder->where('d.opdid', $opdId);
        }
        
        $builder->where('f.tahun', $tahun);
        
        $result = $builder->get()->getRowArray();
        
        $progress = [
            'total_indikator' => $result['total_indikator'],
            'terisi' => $result['terisi'],
            'approved' => $result['approved'],
            'progress_pengisian' => $result['total_indikator'] > 0 ? 
                round(($result['terisi'] / $result['total_indikator']) * 100, 2) : 0,
            'progress_approval' => $result['total_indikator'] > 0 ? 
                round(($result['approved'] / $result['total_indikator']) * 100, 2) : 0
        ];
        
        return $progress;
    }


}