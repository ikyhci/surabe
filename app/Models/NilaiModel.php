<?php

namespace App\Models;

use CodeIgniter\Model;

class NilaiModel extends Model
{
    protected $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = \Config\Database::connect();
    }

    /**
     * Hitung total nilai OPD berdasarkan tahun
     */
    public function getNilaiOpd(string $opdId, string $tahun): array
    {
        $result = [
            'rb' => [],
            'opd_nilai' => 0
        ];

        $rbRows = $this->db->table('lke_rb rb')
            ->select('rb.*')
            ->join('lke_form f', 'f.id = rb.form_id')
            ->where('f.tahun', $tahun)
            ->orderBy('rb.nums', 'ASC')
            ->get()
            ->getResultArray();

        foreach ($rbRows as $rb) {
            $aspekArr = $this->getAspek($rb['id'], $opdId, $tahun);

            // nilai RB = rata2 aspek
            $nilaiRb = !empty($aspekArr) ? (array_sum(array_column($aspekArr, 'nilai')) / count($aspekArr)) : 0;

            $result['rb'][] = [
                'id'    => $rb['id'],
                'nama'  => $rb['nama'] ?? null,
                'bobot' => $rb['bobot'],
                'nilai' => $this->floatRound($nilaiRb),
                'aspek' => $aspekArr
            ];
        }

        // nilai opd = rata2 RB
        $result['opd_nilai'] = !empty($result['rb'])
            ? $this->floatRound(array_sum(array_column($result['rb'], 'nilai')) / count($result['rb']))
            : 0;

        return $result;
    }

    private function getAspek(string $rbId, string $opdId, string $tahun): array
    {
        $rows = $this->db->table('lke_aspek')
            ->where('rb_id', $rbId)
            ->orderBy('nums', 'ASC')
            ->get()
            ->getResultArray();

        $out = [];
        foreach ($rows as $row) {
            $subAspekArr = $this->getSubAspek($row['id'], $opdId, $tahun);

            // nilai aspek = rata2 sub_aspek
            $nilaiAspek = !empty($subAspekArr)
                ? (array_sum(array_column($subAspekArr, 'nilai')) / count($subAspekArr))
                : 0;

            $out[] = [
                'id'    => $row['id'],
                'nama'  => $row['nama_aspek'],
                'nilai' => $this->floatRound($nilaiAspek),
                'sub_aspek' => $subAspekArr
            ];
        }

        return $out;
    }

    private function getSubAspek(string $aspekId, string $opdId, string $tahun): array
    {
        $rows = $this->db->table('lke_sub_aspek')
            ->where('id_aspek', $aspekId)
            ->orderBy('nums', 'ASC')
            ->get()
            ->getResultArray();

        $out = [];
        foreach ($rows as $row) {
            $ssaArr = $this->getSubSubAspek($row['id'], $opdId, $tahun);

            // nilai sub_aspek = total SSA
            $totalSSA = !empty($ssaArr) ? array_sum(array_column($ssaArr, 'nilai')) : 0;

            $out[] = [
                'id'    => $row['id'],
                'nama'  => $row['nama_sub_aspek'],
                'nilai' => $this->floatRound($totalSSA),
                'sub_sub_aspek' => $ssaArr
            ];
        }

        return $out;
    }

    private function getSubSubAspek(string $subAspekId, string $opdId, string $tahun): array
    {
        $rows = $this->db->table('lke_sub_sub_aspek ssa')
            ->select('ssa.id, ssa.nama_sub_sub_aspek, ssa.bobot')
            ->where('ssa.id_sub_aspek', $subAspekId)
            ->orderBy('ssa.nums', 'ASC')
            ->get()
            ->getResultArray();

        $out = [];
        foreach ($rows as $row) {
            $indikatorArr = $this->getIndikator($row['id'], $opdId, $tahun);

            // rata2 indikator
            $avgIndikator = !empty($indikatorArr)
                ? (array_sum(array_column($indikatorArr, 'nilai')) / count($indikatorArr))
                : 0;

            // SSA = rata2 indikator × bobot
            $nilaiSSA = $avgIndikator * $this->normalizeBobot($row['bobot']);

            $out[] = [
                'id'        => $row['id'],
                'nama'      => $row['nama_sub_sub_aspek'],
                'bobot'     => $row['bobot'],
                'nilai'     => $this->floatRound($nilaiSSA),
                'indikator' => $indikatorArr
            ];
        }

        return $out;
    }

    private function getIndikator(string $subSubId, string $opdId, string $tahun): array
    {
        $rows = $this->db->table('lke_indikator i')
            ->select('i.id, i.indikator, i.nums')
            ->where('i.id_sub_sub_aspek', $subSubId)
            ->orderBy('i.nums', 'ASC')
            ->get()
            ->getResultArray();

        $out = [];
        foreach ($rows as $r) {
            $nilaiRow = $this->db->table('lke_indikator i')
                ->select('COALESCE(AVG(nj.Nilai), 0) as nilai')
                ->join('lke_jawaban j', 'j.id_indikator = i.id', 'left')
                ->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = j.id', 'left')

                ->join('lke_detail_opd d', 'd.userid = j.userid', 'left')
                ->join('lke_opd o', 'o.id = d.opdid', 'left')
                ->join('lke_role r', 'r.Uid = d.userid', 'left')
                ->join('lke_roles rs', 'rs.RoleId = r.RoleId', 'left')

                ->join('lke_sub_sub_aspek ssa', 'ssa.id = i.id_sub_sub_aspek', 'left')
                ->join('lke_sub_aspek sa', 'sa.id = ssa.id_sub_aspek', 'left')
                ->join('lke_aspek a', 'a.id = sa.id_aspek', 'left')
                ->join('lke_rb rb', 'rb.id = a.rb_id', 'left')
                ->join('lke_form f', 'f.id = rb.form_id', 'left')

                ->where('i.id', $r['id'])
                ->where('o.id', $opdId)
                ->where('f.tahun', $tahun)
                ->where('rs.acs', 5) // hanya role penilai
                ->get()
                ->getRowArray();

            $out[] = [
                'id'    => $r['id'],
                'nama'  => $r['indikator'] ?? null,
                'nilai' => $this->floatRound($nilaiRow['nilai'] ?? 0),
            ];
        }

        return $out;
    }

    private function normalizeBobot($b): float
    {
        $b = floatval($b);
        return $b > 1.0 ? $b / 100.0 : $b;
    }

    private function floatRound($v, $precision = 2)
    {
        return is_numeric($v) ? round(floatval($v), $precision) : 0.0;
    }

    // ... other model methods ...

    /**
     * Get data OPD
     * 
     * @param string $opdId
     * @return array|null
     */
    public function getOpdInfo($opdId)
    {
        $db = \Config\Database::connect();
        $builder = $db->table('lke_opd o');
        
        return $builder->select('o.nama_opd, o.singkatan')
            ->where('o.id', $opdId)
            ->get()
            ->getRowArray();
    }

    /**
     * Get hierarchy data untuk perhitungan reformasi birokrasi
     * 
     * @param string $opdId
     * @param string $tahun
     * @return array
     */
    public function getHierarchyData($opdId, $tahun)
    {
        $db = \Config\Database::connect();
        $builder = $db->table('lke_form frm');
        
        $builder->select('
            rb.id as rb_id,
            rb.nama as rb_nama,
            rb.nums as rb_nums,
            rb.bobot as rb_bobot,
            
            asp.id as aspek_id,
            asp.nama_aspek,
            asp.nums as aspek_nums,
            asp.bobot as aspek_bobot,
            
            sub.id as sub_aspek_id,
            sub.nama_sub_aspek,
            sub.nums as sub_aspek_nums,
            sub.bobot as sub_aspek_bobot,
            
            subsub.id as sub_sub_aspek_id,
            subsub.nama_sub_sub_aspek,
            subsub.nums as sub_sub_aspek_nums,
            subsub.bobot as sub_sub_aspek_bobot,
            
            ind.id as indikator_id,
            ind.indikator as nama_indikator,
            ind.nums as indikator_nums,
            
            jaw.id as jawaban_id,
            jaw.aprove as status_approve,
            
            COALESCE(nj.Nilai, 0) as nilai_indikator,
            nj.Ket as keterangan,
            jaw.saran as saran,
            nj.AproveBy as approve_by
        ');
        
        $builder->join('lke_rb rb', 'rb.form_id = frm.id', 'inner');
        $builder->join('lke_aspek asp', 'asp.rb_id = rb.id', 'inner');
        $builder->join('lke_sub_aspek sub', 'sub.id_aspek = asp.id', 'inner');
        $builder->join('lke_sub_sub_aspek subsub', 'subsub.id_sub_aspek = sub.id', 'inner');
        $builder->join('lke_indikator ind', 'ind.id_sub_sub_aspek = subsub.id', 'inner');
        
        // Subquery untuk LEFT JOIN
        $subquery = $db->table('lke_detail_opd')
            ->select('userid')
            ->where('opdid', $opdId)
            ->getCompiledSelect();
        
        $builder->join("lke_jawaban jaw", "jaw.id_indikator = ind.id AND jaw.userid IN ($subquery)", 'left', false);
        $builder->join('lke_nilai_jawaban_user nj', 'nj.IdJawaban = jaw.id', 'left');
        
        $builder->where('frm.tahun', $tahun);
        $builder->orderBy('rb.nums', 'ASC');
        $builder->orderBy('asp.nums', 'ASC');
        $builder->orderBy('sub.nums', 'ASC');
        $builder->orderBy('subsub.nums', 'ASC');
        $builder->orderBy('ind.nums', 'ASC');
        
        // $sql = $builder->getCompiledSelect();
        // \pd($sql); // Debug: tampilkan query SQL
        return $builder->get()->getResultArray();
    }

    /**
     * Build hierarchy structure dari data mentah
     * 
     * @param array $data
     * @return array
     */
    public function buildHierarchy($data)
    {
        $hierarchy = [];

        foreach ($data as $row) {
            $rbId = $row['rb_id'];
            $aspekId = $row['aspek_id'];
            $subAspekId = $row['sub_aspek_id'];
            $subSubAspekId = $row['sub_sub_aspek_id'];
            $indikatorId = $row['indikator_id'];
            
            // Initialize RB level
            if (!isset($hierarchy[$rbId])) {
                $hierarchy[$rbId] = [
                    'info' => [
                        'id' => $rbId,
                        'nama' => $row['rb_nama'],
                        'nums' => $row['rb_nums'],
                        'bobot' => $row['rb_bobot']
                    ],
                    'aspek' => []
                ];
            }
            
            // Initialize Aspek level
            if (!isset($hierarchy[$rbId]['aspek'][$aspekId])) {
                $hierarchy[$rbId]['aspek'][$aspekId] = [
                    'info' => [
                        'id' => $aspekId,
                        'nama' => $row['nama_aspek'],
                        'nums' => $row['aspek_nums'],
                        'bobot' => $row['aspek_bobot']
                    ],
                    'sub_aspek' => []
                ];
            }
            
            // Initialize Sub Aspek level
            if (!isset($hierarchy[$rbId]['aspek'][$aspekId]['sub_aspek'][$subAspekId])) {
                $hierarchy[$rbId]['aspek'][$aspekId]['sub_aspek'][$subAspekId] = [
                    'info' => [
                        'id' => $subAspekId,
                        'nama' => $row['nama_sub_aspek'],
                        'nums' => $row['sub_aspek_nums'],
                        'bobot' => $row['sub_aspek_bobot']
                    ],
                    'sub_sub_aspek' => []
                ];
            }
            
            // Initialize Sub Sub Aspek level
            if (!isset($hierarchy[$rbId]['aspek'][$aspekId]['sub_aspek'][$subAspekId]['sub_sub_aspek'][$subSubAspekId])) {
                $hierarchy[$rbId]['aspek'][$aspekId]['sub_aspek'][$subAspekId]['sub_sub_aspek'][$subSubAspekId] = [
                    'info' => [
                        'id' => $subSubAspekId,
                        'nama' => $row['nama_sub_sub_aspek'],
                        'nums' => $row['sub_sub_aspek_nums'],
                        'bobot' => floatval($row['sub_sub_aspek_bobot'])
                        
                    ],
                    'indikator' => []
                ];
            }
            
            // Add Indikator
            $hierarchy[$rbId]['aspek'][$aspekId]['sub_aspek'][$subAspekId]['sub_sub_aspek'][$subSubAspekId]['indikator'][$indikatorId] = [
                'id' => $indikatorId,
                'nama' => $row['nama_indikator'],
                'nums' => $row['indikator_nums'],
                'nilai' => floatval($row['nilai_indikator']),
                'status' => $row['status_approve'],
                'keterangan' => $row['keterangan'],
                'saran' => $row['saran'],
                'approve_by' => $row['approve_by']
            ];
        }

        return $hierarchy;
    }

    /**
     * Hitung nilai untuk semua level hierarchy
     * 
     * @param array $hierarchy (passed by reference)
     * @return void
     */
    public function hitungNilai(&$hierarchy)
    {
        foreach ($hierarchy as &$rb) {
            $totalAspek = 0;
            $countAspek = 0;
            
            foreach ($rb['aspek'] as &$aspek) {
                $totalSubAspek = 0;
                $countSubAspek = 0;
                
                foreach ($aspek['sub_aspek'] as &$subAspek) {
                    $totalSubSubAspek = 0;
                    
                    foreach ($subAspek['sub_sub_aspek'] as &$subSubAspek) {
                        $totalIndikator = 0;
                        $countIndikator = count($subSubAspek['indikator']);
                        
                        foreach ($subSubAspek['indikator'] as $indikator) {
                            $totalIndikator += $indikator['nilai'];
                        }
                        
                        $rataIndikator = $countIndikator > 0 ? $totalIndikator / $countIndikator : 0;
                        $bobot = $subSubAspek['info']['bobot'] / 100;
                        $subSubAspek['nilai'] = $rataIndikator * $bobot;
                        $totalSubSubAspek += $subSubAspek['nilai'];
                    }
                    
                    $subAspek['nilai'] = $this->floatRound($totalSubSubAspek);
                    $totalSubAspek += $subAspek['nilai'];
                    $countSubAspek++;
                }
                
                $aspeknilai = $countSubAspek > 0 ? $totalSubAspek / $countSubAspek : 0;
                $aspek['nilai'] = $this->floatRound($aspeknilai);

                $totalAspek += $aspek['nilai'];
                $countAspek++;
            }
            
            $rbnilai = $countAspek > 0 ? $totalAspek / $countAspek : 0;
            $rb['nilai'] = $this->floatRound($rbnilai);
        }
    }

    /**
     * Hitung nilai total akhir
     * 
     * @param array $hierarchy
     * @return float
     */
    public function hitungNilaiTotal($hierarchy)
    {
        $nilaiTotal = 0;
        $countRb = count($hierarchy);
        
        foreach ($hierarchy as $rb) {
            $nilaiTotal += $rb['nilai'];
        }
        
        $nilai = $countRb > 0 ? $nilaiTotal / $countRb : 0;
        return $this->floatRound($nilai);
    }

    /**
     * Get complete report data
     * 
     * @param string $opdId
     * @param string $tahun
     * @return array
     */
    public function getReportData($opdId, $tahun)
    {
        // Get OPD info
        $opdInfo = $this->getOpdInfo($opdId);
        
        // Get raw data
        $rawData = $this->getHierarchyData($opdId, $tahun);
        
        // Build hierarchy
        $hierarchy = $this->buildHierarchy($rawData);
        
        // Calculate values
        $this->hitungNilai($hierarchy);
        
        // Calculate total
        $nilaiTotal = $this->hitungNilaiTotal($hierarchy);
        
        return [
            'opd_info' => $opdInfo,
            'hierarchy' => $hierarchy,
            'nilai_total' => $this->floatRound($nilaiTotal),
            'tahun' => $tahun
        ];
    }

}