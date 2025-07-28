<?php

namespace App\Models;

use CodeIgniter\Model;

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
            rb.nums AS ururan_rb,
            rb.nama AS komponen,
            rb.bobot AS bobot_rb,
            a.nums AS urutan_aspek,
            a.nama_aspek,
            a.bobot AS bobot_as,
            sa.nums AS urutan_sub_aspek,
            sa.nama_sub_aspek,
            sa.bobot AS bobot_sa,
            ssa.nums AS urutan_sub_sub_aspek,
            ssa.id,
            ssa.nama_sub_sub_aspek,
            ssa.id_sub_aspek,
            ssa.bobot,
            COUNT(i.id) AS jumlah_indikator,
            SUM(IFNULL(j.nilai, 0)) AS total_skor,
            ROUND(SUM(IFNULL(j.nilai, 0)) / NULLIF(ssa.bobot, 0) * 100, 2) AS skor_index,
            j.ket AS keterangan,
        ")
        ->join('lke_indikator i', 'i.id_sub_sub_aspek = ssa.id')
        ->join('lke_sub_aspek sa', 'sa.id = ssa.id_sub_aspek')
        ->join('lke_aspek a', 'a.id = sa.id_aspek')
        ->join('lke_rb rb', 'rb.id = a.rb_id')
        ->join('lke_form f', 'f.id = rb.form_id')
        ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
        ->join('lke_detail_opd d', 'd.userid = j.userid', 'left')
        ->where('f.tahun', $tahun)
        ->where('d.opdid', $idopd)
        ->groupBy('ssa.id, ssa.nama_sub_sub_aspek, ssa.nums, ssa.id_sub_aspek, ssa.bobot')
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
                    'total_bobot' => 0,
                    'total_skor' => 0,
                ];
            }

            $grouped[$id]['total_bobot'] += $row['bobot'];
            $grouped[$id]['total_skor'] += $row['total_skor'];
        }

        foreach ($grouped as &$val) {
            $val['skor_index'] = round(($val['total_bobot'] > 0 ? $val['total_skor'] / $val['total_bobot'] * 100 : 0), 2);
        }

        return array_values($grouped);
    }

    public function getNilaiAspek($tahun, $idopd)
    {
        $subAspek = $this->getNilaiSubAspek($tahun, $idopd);
        $grouped = [];

        foreach ($subAspek as $row) {
            $idSubAspek = $row['id'];
            $idAspek = $this->db->table('lke_sub_aspek')
                ->select('id_aspek')
                ->where('id', $idSubAspek)
                ->get()
                ->getRow('id_aspek');

            if (!isset($grouped[$idAspek])) {
                $grouped[$idAspek] = [
                    'id' => $idAspek,
                    'total_skor_index' => 0,
                    'jumlah_sub_aspek' => 0,
                ];
            }

            $grouped[$idAspek]['total_skor_index'] += $row['skor_index'];
            $grouped[$idAspek]['jumlah_sub_aspek']++;
        }

        foreach ($grouped as &$val) {
            $val['skor_index'] = round($val['total_skor_index'] / $val['jumlah_sub_aspek'], 2);
        }

        return array_values($grouped);
    }

    public function getNilaiRB($tahun, $idopd)
    {
        $aspek = $this->getNilaiAspek($tahun, $idopd);
        $grouped = [];

        foreach ($aspek as $row) {
            $idAspek = $row['id'];
            $idRB = $this->db->table('lke_aspek')
                ->select('rb_id')
                ->where('id', $idAspek)
                ->get()
                ->getRow('rb_id');

            if (!isset($grouped[$idRB])) {
                $grouped[$idRB] = [
                    'id' => $idRB,
                    'total_skor_index' => 0,
                    'jumlah_aspek' => 0,
                ];
            }

            $grouped[$idRB]['total_skor_index'] += $row['skor_index'];
            $grouped[$idRB]['jumlah_aspek']++;
        }

        foreach ($grouped as &$val) {
            $val['skor_index'] = round($val['total_skor_index'] / $val['jumlah_aspek'], 2);
        }

        return array_values($grouped);
    }

    public function getTotalNilaiLKE($tahun, $idopd)
    {
        $rb = $this->getNilaiRB($tahun, $idopd);

        $total = 0;
        $jumlah = count($rb);
        foreach ($rb as $r) {
            $total += $r['skor_index'];
        }

        return $jumlah > 0 ? round($total / $jumlah, 2) : 0;
    }

    public function getRekapSemuaOpd($tahun)
    {
        $builder = $this->db->table('lke_opd o');
        $builder->select('o.id AS opd_id, o.nama_opd, d.userid');
        $builder->join('lke_detail_opd d', 'd.opdid = o.id', 'left');
        $builder->join('lke_user u', 'u.uid = d.userid', 'left');
        $builder->groupBy('o.id');
        $builder->orderBy('o.nama_opd');

        $opds = $builder->get()->getResultArray();

        $result = [];
        foreach ($opds as $opd) {
            $capaian = $this->getTotalNilaiLKE($tahun, $opd['opd_id']);
            $result[] = [
                'opd_id' => $opd['opd_id'],
                'nama_opd' => $opd['nama_opd'],
                'userid' => $opd['userid'],
                'capaian' => $capaian,
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
        $builder = $this->db->table('lke_opd o');
        $builder->select('o.id AS opd_id, o.nama_opd, o.singkatan, d.userid');
        $builder->join('lke_detail_opd d', 'd.opdid = o.id', 'left');
        $builder->groupBy('o.id');
        $builder->orderBy('o.nama_opd');
        
        $opds = $builder->get()->getResultArray();
        
        $result = [];
        
        foreach ($opds as $opd) {
            // Get nilai aspek for this OPD
            $aspekNilai = $this->getNilaiAspek($tahun, $opd['opd_id']);
            
            // Get aspek details
            $aspekDetails = $this->db->table('lke_aspek a')
                ->select('a.id, a.nama_aspek, a.bobot, a.nums')
                ->join('lke_rb rb', 'rb.id = a.rb_id')
                ->join('lke_form f', 'f.id = rb.form_id')
                ->where('f.tahun', $tahun)
                ->orderBy('a.nums')
                ->get()
                ->getResultArray();
            
            $aspekValues = [];
            $totalSkor = 0;
            $jumlahAspek = count($aspekDetails);
            
            foreach ($aspekDetails as $aspek) {
                $skorIndex = 0;
                
                // Find matching score
                foreach ($aspekNilai as $nilai) {
                    if ($nilai['id'] == $aspek['id']) {
                        $skorIndex = $nilai['skor_index'];
                        break;
                    }
                }
                
                $aspekValues[] = [
                    'aspek_id' => $aspek['id'],
                    'nama_aspek' => $aspek['nama_aspek'],
                    'skor_index' => $skorIndex
                ];
                
                $totalSkor += $skorIndex;
            }
            
            $result[] = [
                'opd_id' => $opd['opd_id'],
                'nama_opd' => $opd['nama_opd'],
                'singkatan' => $opd['singkatan'],
                'userid' => $opd['userid'],
                'aspek_values' => $aspekValues,
                'nilai_akhir' => $jumlahAspek > 0 ? round($totalSkor / $jumlahAspek, 2) : 0
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