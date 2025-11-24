<?php

namespace App\Controllers\Pages;
use App\Controllers\BaseController;
use App\Models\LkeModel;
use App\Models\LkeUser;
use App\Models\DashboardModel;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class ReportController extends BaseController
{
    protected $lkeModel;
    protected $LkeUser;

    protected $decoded;

    public function __construct()
    {

        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        if (!$token) {
            return redirect()->to(base_url().'unauthorized');
        }
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));

        $this->lkeModel = new LkeModel();
        $this->LkeUser = new LkeUser();
        $this->DashboardModel = new DashboardModel();

        // pd($this->decoded);
    }

    public function index()
    {
        $data = [
            'title' => 'Laporan Evaluasi SPBE'
        ];
        
        return view('dashboard/report/index', $data);
    }

public function getEvaluasiLengkap()
{
    $tahun = $this->request->getGet('tahun') ?? date('Y');
    $update = $this->request->getGet('update') ?? false;
    $uid = $this->decoded->ids;
    
    $cache = \Config\Services::cache();
    // pd($update);
    // buat key unik berdasarkan tahun
    $cacheKey = 'evaluasi_lengkap_' . $uid . $tahun;
    $opd_id = null;
    $opdUser = $this->LkeUser->opd_user($uid);
    if(count($opdUser) >= 1 && $this->decoded->iss == 'User') {
        $opd_id = $opdUser[0]['opd_id'];
    }
    try {
        // coba ambil dari cache dulu
        $evaluasiData = $cache->get($cacheKey);

        if ($evaluasiData === null || $update === 'true' || $update === true) {
            // jika belum ada, ambil dari model
            $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun, $opd_id);

            // simpan ke cache selama 10 menit (600 detik) 24jam =86400
            $cache->save($cacheKey, $evaluasiData, 86400);
        }

        $data = [
            'token_crs' => csrf_hash(),
            'dt'        => $evaluasiData,
            'success'   => 1,
            'msg'       => 'Data evaluasi lengkap berhasil diambil'
        ];

    } catch (\Exception $e) {
        $data = [
            'token_crs' => csrf_hash(),
            'dt'        => null,
            'success'   => 0,
            'msg'       => 'Gagal mengambil data evaluasi lengkap: ' . $e->getMessage()
        ];
    }

    return $this->response->setJSON($data);
}

    public function getRingkasanEvaluasi()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        
        try {
            $ringkasan = $this->lkeModel->getRingkasanEvaluasi($tahun);
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $ringkasan,
                'success'   => 1,
                'msg'       => 'Data ringkasan evaluasi berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil ringkasan evaluasi: ' . $e->getMessage()
            );
        }
        
        return $this->response->setJSON($data);
    }

    public function getOpdAspekData()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        
        try {
            $opdData = $this->lkeModel->getOpdWithAspekValuesSimple($tahun);
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $opdData,
                'success'   => 1,
                'msg'       => 'Data OPD dengan nilai aspek berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data: ' . $e->getMessage()
            );
        }
        
        return $this->response->setJSON($data);
    }

    public function exportExcel()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');

        try {
            $row = 1;
            $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun);

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            // Header judul
            $sheet->setCellValue("A{$row}", 'Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah ' . $tahun);
            $sheet->mergeCells("A{$row}:G{$row}");
            $sheet->getStyle("A{$row}")->getFont()->setBold(true)->setSize(14);
            $sheet->getStyle("A{$row}")->getAlignment()->setHorizontal(Alignment::HORIZONTAL_CENTER);
            
            // Ringkasan
            $row++; // Move to next row
            // $ringkasan = $evaluasiData['ringkasan'];
            // $sheet->setCellValue("A{$row}", 'RINGKASAN EVALUASI');
            // $sheet->getStyle("A{$row}")->getFont()->setBold(true);

            // $sheet->setCellValue('A4', 'Total Instansi: ' . $ringkasan['total_instansi']);
            // $sheet->setCellValue('A5', 'Rata-rata Index: ' . $ringkasan['rata_rata_index']);
            // $sheet->setCellValue('A6', 'Tertinggi: ' . $ringkasan['tertinggi']);
            // $sheet->setCellValue('A7', 'Terendah: ' . $ringkasan['terendah']);
            // $row++;
            $row++;
            // Table headers
            $sheet->setCellValue('A'.$row, 'No');
            $sheet->setCellValue('B'.$row, 'Instansi');
            $sheet->setCellValue('C'.$row, 'Index RB');
            // $sheet->setCellValue('D'.$row, 'Predikat');

            // Dynamic aspek headers
            $colIndex = 5; // Column E
            if (!empty($evaluasiData['data_opd'])) {
                foreach ($evaluasiData['data_opd'][0]['aspek_values'] as $aspek) {
                    $colLetter = Coordinate::stringFromColumnIndex($colIndex);
                    $sheet->setCellValue("{$colLetter}{$row}", $aspek['nama_aspek']);
                    $colIndex++;
                }
            }

            // Style headers
            $lastCol = Coordinate::stringFromColumnIndex($colIndex - 1);
            $sheet->getStyle("A{$row}:{$lastCol}{$row}")->getFont()->setBold(true);
            $sheet->getStyle("A{$row}:{$lastCol}{$row}")->getFill()
                ->setFillType(Fill::FILL_SOLID)
                ->getStartColor()->setRGB('E2E8F0');

            // Data rows
            $row++; // Start from next row
            foreach ($evaluasiData['data_opd'] as $index => $opd) {
                $sheet->setCellValue("A{$row}", $index + 1);
                $sheet->setCellValue("B{$row}", $opd['nama_opd']);
                $sheet->setCellValue("C{$row}", $opd['nilai_akhir']);
                // $sheet->setCellValue("D{$row}", $this->getPredikat($opd['nilai_akhir']));

                // Nilai aspek
                $colIndex = 5;
                foreach ($opd['aspek_values'] as $aspek) {
                    $colLetter = Coordinate::stringFromColumnIndex($colIndex);
                    $sheet->setCellValue("{$colLetter}{$row}", $aspek['skor_index']);
                    $colIndex++;
                }

                $row++;
            }

            // Auto-size columns
            foreach (range('A', $lastCol) as $col) {
                $sheet->getColumnDimension($col)->setAutoSize(true);
            }

            // Output file
            $writer = new Xlsx($spreadsheet);
            $filename = "Laporan_Evaluasi_SPBE_{$tahun}.xlsx";

            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            header("Content-Disposition: attachment; filename=\"{$filename}\"");
            header('Cache-Control: max-age=0');

            $writer->save('php://output');
            exit;

        } catch (\Exception $e) {
            return $this->response->setJSON([
                'success' => 0,
                'msg' => 'Gagal export Excel: ' . $e->getMessage()
            ]);
        }
    }

    public function exportPDF()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        
        try {
            // Load TCPDF library (install via composer)
            // composer require tecnickcom/tcpdf
            
            $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun);
            
            // Set orientation to Landscape
            $pdf = new \TCPDF('L', PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
            
            // Set document information
            $pdf->SetCreator('SURABE BERANI');
            $pdf->SetTitle('Laporan Evaluasi SPBE ' . $tahun);
            $pdf->SetSubject('Laporan Evaluasi SPBE');
            $pdf->SetKeywords('LKE, SPBE, Evaluasi, Laporan, surabe, berani');
            
            // Set header and footer
            $pdf->setHeaderFont(['helvetica', '', 10]);
            $pdf->setFooterFont(['helvetica', '', 8]);
            
            // Set header data
            // $pdf->SetHeaderData('', 0, 'Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah ' . $tahun, 'SISTEM PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI');
            $pdf->SetHeaderData('', 0, 'SURABE BERANI', 'SISTEM PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI');
            
            // Set margins for landscape
            $pdf->SetMargins(10, 25, 10); // Reduced margins
            $pdf->SetHeaderMargin(10);
            $pdf->SetFooterMargin(10);
            
            // Set auto page breaks
            $pdf->SetAutoPageBreak(TRUE, 20);
            
            // Add page
            $pdf->AddPage();
            
            // Remove default header for first page to create custom header
            $pdf->setPrintHeader(false);
            
            // Custom Title
            $pdf->SetFont('helvetica', 'B', 18);
            $pdf->Cell(0, 12, 'Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah ' . $tahun, 0, 1, 'C');
            $pdf->Ln(3);
            
            // // Subtitle
            // $pdf->SetFont('helvetica', '', 12);
            // $pdf->Cell(0, 8, 'Sistem Evaluasi Laporan Kinerja Evaluasi', 0, 1, 'C');
            // $pdf->Ln(8);
            
            // Enable header for next pages
            $pdf->setPrintHeader(true);
            
            // Ringkasan Section
            $ringkasan = $evaluasiData['ringkasan'];
            $pdf->SetFont('helvetica', 'B', 14);
            $pdf->Cell(0, 10, 'RINGKASAN EVALUASI', 0, 1, 'L');
            $pdf->Ln(2);
            
            // Ringkasan in box style
            $pdf->SetFont('helvetica', '', 11);
            $pdf->SetFillColor(240, 240, 240);
            
            // Create a summary box
            $boxWidth = 65;
            $boxHeight = 8;
            
            // Row 1
            $pdf->Cell($boxWidth, $boxHeight, 'Total Instansi', 1, 0, 'L', true);
            $pdf->Cell(5, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell(30, $boxHeight, $ringkasan['total_instansi'] . ' Instansi', 1, 0, 'L', true);
            
            $pdf->Cell(20, $boxHeight, '', 0, 0, 'L'); // Spacer
            
            $pdf->Cell($boxWidth, $boxHeight, 'Rata-rata Index', 1, 0, 'L', true);
            $pdf->Cell(5, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell(30, $boxHeight, $ringkasan['rata_rata_index'], 1, 1, 'L', true);
            
            // Row 2
            $pdf->Cell($boxWidth, $boxHeight, 'Nilai Tertinggi', 1, 0, 'L', true);
            $pdf->Cell(5, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell(30, $boxHeight, $ringkasan['tertinggi'], 1, 0, 'L', true);
            
            $pdf->Cell(20, $boxHeight, '', 0, 0, 'L'); // Spacer
            
            $pdf->Cell($boxWidth, $boxHeight, 'Nilai Terendah', 1, 0, 'L', true);
            $pdf->Cell(5, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell(30, $boxHeight, $ringkasan['terendah'], 1, 1, 'L', true);
            
            $pdf->Ln(10);
            
            // Table Section
            $pdf->SetFont('helvetica', 'B', 14);
            $pdf->Cell(0, 10, 'DAFTAR HASIL EVALUASI', 0, 1, 'L');
            $pdf->Ln(2);
            
            // Calculate column widths for landscape (A4 landscape = 297mm - 20mm margins = 277mm)
            $pageWidth = 277; // Available width in landscape
            $noWidth = 10;
            $indexWidth = 20;
            $predikatWidth = 25;
            $instansiWidth = 65 + $predikatWidth; // Reduced for better fit
            $predikatWidth = 0;

            
            // Calculate remaining width for aspek columns
            $usedWidth = $noWidth + $instansiWidth + $indexWidth + $predikatWidth;
            $remainingWidth = $pageWidth - $usedWidth;
            
            // Dynamic aspek width based on number of aspek
            $aspekCount = 0;
            if (!empty($evaluasiData['data_opd'])) {
                $aspekCount = count($evaluasiData['data_opd'][0]['aspek_values']);
            }
            $aspekWidth = $aspekCount > 0 ? $remainingWidth / $aspekCount : 30;
            
            // Ensure minimum width for aspek columns
            if ($aspekWidth < 20) {
                $aspekWidth = 20;
            }
            
            // Table headers with wrap text
            $pdf->SetFont('helvetica', 'B', 10);
            $pdf->SetFillColor(220, 220, 220);
            
            // Header row height
            $headerHeight = 18;
            
            // Save current position
            $startY = $pdf->GetY();
            
            // Draw header cells with MultiCell for text wrapping
            $currentX = $pdf->GetX();
            
            // No column
            $pdf->SetXY($currentX, $startY);
            $pdf->MultiCell($noWidth, $headerHeight, 'No', 1, 'C', true, 0);
            $currentX += $noWidth;
            
            // Nama Instansi column
            $pdf->SetXY($currentX, $startY);
            $pdf->MultiCell($instansiWidth, $headerHeight, 'Nama Instansi', 1, 'C', true, 0);
            $currentX += $instansiWidth;
            
            // Index SPBE column
            $pdf->SetXY($currentX, $startY);
            $pdf->MultiCell($indexWidth, $headerHeight, 'Index RB', 1, 'C', true, 0);
            $currentX += $indexWidth;
            
            // // Predikat column
            // $pdf->SetXY($currentX, $startY);
            // $pdf->MultiCell($predikatWidth, $headerHeight, 'Predikat', 1, 'C', true, 0);
            // $currentX += $predikatWidth;
            
            // Dynamic aspek headers with text wrapping
            if (!empty($evaluasiData['data_opd'])) {
                foreach ($evaluasiData['data_opd'][0]['aspek_values'] as $aspek) {
                    $pdf->SetXY($currentX, $startY);
                    // Break long aspek names into multiple lines
                    $aspekName = $this->wrapText($aspek['nama_aspek'], 12);
                    $pdf->MultiCell($aspekWidth, $headerHeight, $aspekName, 1, 'C', true, 0);
                    $currentX += $aspekWidth;
                }
            }
            
            // Move to next line after headers
            $pdf->SetY($startY + $headerHeight);
            
            // Table data with wrap text
            $pdf->SetFont('helvetica', '', 10);
            $pdf->SetFillColor(255, 255, 255);
            
            // Set uniform row height for all data rows
            $uniformRowHeight = 15; // Fixed height for all rows
            
            $rowCount = 0;
            foreach ($evaluasiData['data_opd'] as $index => $opd) {
                // Alternate row colors
                $fill = ($rowCount % 2 == 0) ? false : true;
                if ($fill) {
                    $pdf->SetFillColor(248, 248, 248);
                } else {
                    $pdf->SetFillColor(255, 255, 255);
                }
                
                // Save current position
                $startY = $pdf->GetY();
                $currentX = $pdf->GetX();
                
                // Check if we need a new page
                if ($startY + $uniformRowHeight > $pdf->getPageHeight() - 30) {
                    $pdf->AddPage();
                    $startY = $pdf->GetY();
                }
                
                // No column
                $pdf->SetXY($currentX, $startY);
                $pdf->MultiCell($noWidth, $uniformRowHeight, $index + 1, 1, 'C', $fill, 0);
                $currentX += $noWidth;
                
                // Nama OPD column with text wrapping
                $pdf->SetXY($currentX, $startY);
                $namaOpd = $this->wrapText($opd['nama_opd'], 40, 5);
                $pdf->MultiCell($instansiWidth, $uniformRowHeight, $namaOpd, 1, 'L', $fill, 0);
                $currentX += $instansiWidth;
                
                // Index SPBE column
                $pdf->SetXY($currentX, $startY);
                $pdf->MultiCell($indexWidth, $uniformRowHeight, $opd['nilai_akhir'], 1, 'C', $fill, 0);
                $currentX += $indexWidth;
                
                // // Predikat column
                // $pdf->SetXY($currentX, $startY);
                // $predikat = $this->getPredikat($opd['nilai_akhir']);
                // $pdf->MultiCell($predikatWidth, $uniformRowHeight, $predikat, 1, 'C', $fill, 0);
                // $currentX += $predikatWidth;
                
                // Aspek values
                if (isset($opd['aspek_values'])) {
                    foreach ($opd['aspek_values'] as $aspek) {
                        $pdf->SetXY($currentX, $startY);
                        $pdf->MultiCell($aspekWidth, $uniformRowHeight, $aspek['skor_index'], 1, 'C', $fill, 0);
                        $currentX += $aspekWidth;
                    }
                }
                
                // Move to next row with uniform height
                $pdf->SetY($startY + $uniformRowHeight);
                $rowCount++;
            }
            
            // Footer information
            $pdf->Ln(10);
            $pdf->SetFont('helvetica', 'I', 8);
            $pdf->Cell(0, 5, 'Laporan dibuat pada: ' . date('d/m/Y H:i:s'), 0, 1, 'L');
            
            // // Legend for Predikat
            // $pdf->Ln(5);
            // $pdf->SetFont('helvetica', 'B', 10);
            // $pdf->Cell(0, 6, 'Keterangan Predikat:', 0, 1, 'L');
            
            // $pdf->SetFont('helvetica', '', 9);
            // $pdf->Cell(40, 5, 'Sangat Baik: >= 85', 0, 0, 'L');
            // $pdf->Cell(30, 5, 'Baik: 70-84', 0, 0, 'L');
            // $pdf->Cell(30, 5, 'Kurang: 55-69', 0, 0, 'L');
            // $pdf->Cell(30, 5, 'Buruk: < 55', 0, 1, 'L');
            
            // Output PDF
            $filename = "Laporan_Evaluasi_SPBE_{$tahun}.pdf";
            $pdf->Output($filename, 'D');
            exit;
            
        } catch (\Exception $e) {
            log_message('error', 'Export PDF Error: ' . $e->getMessage());
            return $this->response->setJSON([
                'success' => 0,
                'msg' => 'Gagal export PDF: ' . $e->getMessage()
            ]);
        }
    }

    public function exportPdfOpd()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        $opdId = $this->request->getGet('opd_id');

        if (!$opdId) {
            return $this->response->setJSON([
                'success' => 0,
                'msg' => 'OPD ID tidak ditemukan'
            ]);
        }

        try {

            // $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun, $opdId);
            $nilaiAspek = $this->DashboardModel->nilaiOpd($tahun, $opdId);
            // \pd(['nilaiAspek' => $nilaiAspek, 'evaluasiData' => $evaluasiData]);
            // pd($nilaiAspek);
            // Set basic PDF options - Landscape
            $pdf = new \TCPDF('L', PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
            $pdf->SetCreator('SURABE BERANI');
            $pdf->SetTitle('Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah');
            $pdf->SetHeaderFont(['helvetica', '', 10]);
            $pdf->SetFooterFont(['helvetica', '', 8]);
            $pdf->SetHeaderData('', 0, 'SURABE BERANI', 'SISTEM PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI');
            $pdf->SetMargins(15, 25, 15);
            $pdf->SetHeaderMargin(10);
            $pdf->SetFooterMargin(10);
            $pdf->SetAutoPageBreak(TRUE, 18); // Margin bottom lebih besar
            $pdf->AddPage();
            $pdf->setPrintHeader(false);

            // Header section
            $opd = $nilaiAspek[0];
            $pdf->SetFont('helvetica', 'B', 16);
            $pdf->Cell(0, 10, 'Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah', 0, 1, 'C');
            $pdf->SetFont('helvetica', 'B', 14);
            $pdf->Cell(0, 8, 'TAHUN ' . $tahun, 0, 1, 'C');
            $pdf->Ln(5);

            // OPD Info
            $pdf->SetFont('helvetica', 'B', 12);
            $pdf->Cell(0, 8, 'INFORMASI PERANGKAT DAERAH', 0, 1, 'L');
            $pdf->Ln(2);
            
            $pdf->SetFont('helvetica', '', 11);
            $pdf->SetFillColor(240, 240, 240);
            
            // OPD Details with adjusted widths for landscape
            $boxHeight = 8;
            $labelWidth = 80;
            $colonWidth = 5;
            $valueWidth = 180;
            
            $pdf->Cell($labelWidth, $boxHeight, 'Nama OPD', 1, 0, 'L', true);
            $pdf->Cell($colonWidth, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell($valueWidth, $boxHeight, $opd->nama_opd, 1, 1, 'L', true);
            
            $pdf->Cell($labelWidth, $boxHeight, 'Singkatan', 1, 0, 'L', true);
            $pdf->Cell($colonWidth, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell($valueWidth, $boxHeight, $opd->singkatan, 1, 1, 'L', true);
            
            $pdf->Cell($labelWidth, $boxHeight, 'Nilai Akhir', 1, 0, 'L', true);
            $pdf->Cell($colonWidth, $boxHeight, ':', 1, 0, 'C', true);
            $pdf->Cell($valueWidth, $boxHeight, number_format($opd->nilai, 2), 1, 1, 'L', true);
            
            $pdf->Ln(10);
            $pdf->setPrintHeader(true);

            // Ringkasan aspek
            // Kumpulkan semua aspek dari semua instrumen terlebih dahulu
            $allAspek = [];
            foreach ($opd->instrumen as $instrumen) {
                foreach ($instrumen->aspek as $aspek) {
                    $allAspek[] = (object)[
                        'instrumen_nama' => $instrumen->nama,
                        'instrumen_nums' => $instrumen->nums,
                        'aspek_nums' => $aspek->nums,
                        'nama_aspek' => $aspek->nama_aspek,
                        'nilai' => $aspek->nilai,
                        'bobot_rb'  => $instrumen->bobot
                    ];
                }
            }

            // Get page dimensions
            $pageWidth = $pdf->getPageWidth();
            $pageHeight = $pdf->getPageHeight();
            $margins = $pdf->getMargins();
            $effectiveWidth = $pageWidth - $margins['left'] - $margins['right'];
            $bottomMargin = $pdf->getBreakMargin();

            // Check if new page is needed for summary
            $requiredHeight = 100; // Perkiraan tinggi untuk ringkasan
            if ($pdf->GetY() + $requiredHeight > ($pageHeight - $bottomMargin)) {
                $pdf->AddPage();
            }

            // Define column widths (50% each for table and chart)
            $tableWidth = $effectiveWidth * 0.45;
            $chartWidth = $effectiveWidth * 0.50;
            $spacing = $effectiveWidth * 0.05;

            // Save current Y position
            $startY = $pdf->GetY();

            // LEFT SIDE - Table of ALL Aspek Values
            $pdf->SetFont('helvetica', 'B', 11);
            $pdf->SetFillColor(220, 220, 220);
            $pdf->Cell($tableWidth, 8, 'Rekapitulasi Nilai Aspek', 1, 1, 'C', true);

            // Table header
            $pdf->SetFont('helvetica', 'B', 11);
            $pdf->SetFillColor(245, 245, 245);
            $colWidths = [
                $tableWidth * 0.10,  // No
                $tableWidth * 0.15,  // Kode
                $tableWidth * 0.55,  // Nama Aspek
                $tableWidth * 0.20   // Nilai
            ];

            $pdf->Cell($colWidths[0], 9, 'No', 1, 0, 'C', true);
            $pdf->Cell($colWidths[1], 9, 'Kode', 1, 0, 'C', true);
            $pdf->Cell($colWidths[2], 9, 'Nama Aspek', 1, 0, 'C', true);
            $pdf->Cell($colWidths[3], 9, 'Nilai', 1, 1, 'C', true);

            // Table data
            $pdf->SetFont('helvetica', '', 10);
            $no = 1;
            $radarData = [];
            $radarLabels = [];

            foreach ($allAspek as $aspekItem) {
                $kode = $aspekItem->instrumen_nums . '.' . $aspekItem->aspek_nums;
                
                // Calculate row height
                $height = max($pdf->getStringHeight($colWidths[2], $aspekItem->nama_aspek), 8);
                
                $pdf->MultiCell($colWidths[0], $height, $no++, 1, 'C', false, 0);
                $pdf->MultiCell($colWidths[1], $height, $kode, 1, 'C', false, 0);
                $pdf->MultiCell($colWidths[2], $height, $aspekItem->nama_aspek, 1, 'L', false, 0);
                $pdf->MultiCell($colWidths[3], $height, number_format($aspekItem->nilai, 2), 1, 'C', false, 1);
                
                // Collect data for radar chart
                $radarData[] = floatval($aspekItem->nilai);
                
                // Create shorter label for radar
                $labelText = $kode . '. ';
                $labelText .= strlen($aspekItem->nama_aspek) > 15 ? 
                            substr($aspekItem->nama_aspek, 0, 15) . '...' : 
                            $aspekItem->nama_aspek;
                $radarLabels[] = $labelText;
            }

            $pdf->Ln(4); // jarak dari tabel ke catatan

            $pdf->SetFont('helvetica', '', 8); // ukuran kecil
            $pdf->SetFillColor(255, 255, 255); // latar putih
            $pdf->SetTextColor(0, 0, 0); // teks hitam

            $note = "NB:\n".
                    "I.A - I.C = RB General Perangkat Daerah\n".
                    "II.A - II.B = RB Tematik Perangkat Daerah\n".
                    "Bobot RB General = 65\n".
                    "Bobot RB Tematik = 35";

            $pdf->MultiCell(0, 5, $note, 0, 'L', false);

            
            $tableEndY = $pdf->GetY();

            // RIGHT SIDE - Radar Chart
            $pdf->SetXY($margins['left'] + $tableWidth + $spacing, $startY);

            $chartX = $pdf->GetX();
            $chartY = $pdf->GetY();

            // Draw radar chart frame
            $pdf->SetFont('helvetica', 'B', 11);
            $pdf->SetFillColor(220, 220, 220);
            $pdf->Cell($chartWidth, 8, 'Diagram Radar - Nilai Aspek', 1, 1, 'C', true);

            // Generate radar chart
            $chartHeight = $tableEndY - $startY - 8;
            $pdf->SetXY($chartX, $chartY + 8);

            // Create radar chart
            $centerX = $chartX + $chartWidth / 2;
            $centerY = $chartY + 8 + $chartHeight / 2;
            $radius = min($chartWidth, $chartHeight) / 3.5;

            // Draw chart background
            $pdf->Rect($chartX, $chartY + 8, $chartWidth, $chartHeight, 'D');

            // Draw radar grid circles
            $pdf->SetDrawColor(200, 200, 200);
            $pdf->SetLineStyle(['width' => 0.2, 'dash' => 1]);
            for ($i = 1; $i <= 4; $i++) {
                $pdf->Circle($centerX, $centerY, $radius * $i / 4, 0, 360, 'D');
            }

            // Draw value labels on circles
            $pdf->SetFont('helvetica', '', 6);
            $pdf->SetTextColor(150, 150, 150);
            $maxValue = max(max($radarData), 1);
            for ($i = 1; $i <= 4; $i++) {
                $value = ($maxValue / 4) * $i;
                $labelRadius = $radius * $i / 4;
                $pdf->SetXY($centerX + $labelRadius + 1, $centerY - 2);
                $pdf->Cell(10, 3, number_format($value, 0), 0, 0, 'L');
            }
            $pdf->SetTextColor(0, 0, 0);

            // Draw axes and plot data
            $numPoints = count($radarData);
            if ($numPoints > 0) {
                $angleStep = 360 / $numPoints;
                
                // Draw axes
                $pdf->SetLineStyle(['width' => 0.2]);
                $pdf->SetDrawColor(150, 150, 150);
                for ($i = 0; $i < $numPoints; $i++) {
                    $angle = deg2rad($i * $angleStep - 90);
                    $x = $centerX + cos($angle) * $radius;
                    $y = $centerY + sin($angle) * $radius;
                    $pdf->Line($centerX, $centerY, $x, $y);
                    
                    // Add labels
                    $pdf->SetFont('helvetica', '', 6);
                    $labelX = $centerX + cos($angle) * ($radius + 8);
                    $labelY = $centerY + sin($angle) * ($radius + 8);
                    
                    // Adjust label position based on angle
                    if (cos($angle) < -0.1) {
                        $pdf->SetXY($labelX - 25, $labelY - 2);
                        $pdf->Cell(25, 4, $radarLabels[$i], 0, 0, 'R');
                    } elseif (cos($angle) > 0.1) {
                        $pdf->SetXY($labelX, $labelY - 2);
                        $pdf->Cell(25, 4, $radarLabels[$i], 0, 0, 'L');
                    } else {
                        $pdf->SetXY($labelX - 12.5, $labelY - 2);
                        $pdf->Cell(25, 4, $radarLabels[$i], 0, 0, 'C');
                    }
                }
                
                // Plot data points
                $pdf->SetDrawColor(0, 100, 200);
                $pdf->SetFillColor(0, 100, 200);
                $pdf->SetLineStyle(['width' => 0.8]);
                
                $points = [];
                for ($i = 0; $i < $numPoints; $i++) {
                    $angle = deg2rad($i * $angleStep - 90);
                    $normalizedValue = ($radarData[$i] / $maxValue) * $radius;
                    $x = $centerX + cos($angle) * $normalizedValue;
                    $y = $centerY + sin($angle) * $normalizedValue;
                    $points[] = $x;
                    $points[] = $y;
                }
                
                // Draw filled polygon
                if (count($points) >= 6) {
                    $pdf->SetAlpha(0.3);
                    $pdf->Polygon($points, 'DF');
                    $pdf->SetAlpha(1);
                }
                
                // Draw lines connecting points
                $pdf->SetLineStyle(['width' => 0.8]);
                for ($i = 0; $i < $numPoints; $i++) {
                    $nextI = ($i + 1) % $numPoints;
                    $pdf->Line(
                        $points[$i * 2], 
                        $points[$i * 2 + 1], 
                        $points[$nextI * 2], 
                        $points[$nextI * 2 + 1]
                    );
                }
                
                // Draw points
                $pdf->SetFillColor(0, 100, 200);
                for ($i = 0; $i < $numPoints; $i++) {
                    $pdf->Circle($points[$i * 2], $points[$i * 2 + 1], 1, 0, 360, 'F');
                }
            }

            // Reset drawing color
            $pdf->SetDrawColor(0, 0, 0);
            $pdf->SetLineStyle(['width' => 0.2]);

            // Move to next position
            $pdf->SetY(max($tableEndY, $chartY + 8 + $chartHeight) + 5);
            $pdf->Ln(5);
            // Akhir ringkasan aspek 

            // Loop through instrumen
            foreach ($opd->instrumen as $instrumen) {
                $pdf->AddPage();
                
                // Instrumen header
                $pdf->SetFont('helvetica', 'B', 14);
                $pdf->Cell(0, 10, $instrumen->nums . '. ' . strtoupper($instrumen->nama), 0, 1, 'L');
                $pdf->SetFont('helvetica', '', 11);
                $pdf->Cell(0, 6, 'Nilai: ' . number_format($instrumen->nilai, 2), 0, 1, 'L');
                $pdf->Ln(2);

                // Loop through aspek
                foreach ($instrumen->aspek as $aspek) {
                    // Cek ruang untuk header aspek
                    $requiredHeight = 30; // Header aspek + spacing
                    $currentY = $pdf->GetY();
                    if ($currentY + $requiredHeight > ($pageHeight - $bottomMargin)) {
                        $pdf->AddPage();
                    }

                    // Aspek header
                    $pdf->SetFont('helvetica', 'B', 12);
                    $pdf->SetFillColor(220, 220, 220);

                    // Get the total width available
                    $pageWidth = $pdf->getPageWidth() - $pdf->getMargins()['left'] - $pdf->getMargins()['right'];

                    // Create the aspek header with consistent spacing
                    $aspekTitle = $instrumen->nums . '.' . $aspek->nums . ' ' . $aspek->nama_aspek;
                    $nilai = 'Nilai: ' . number_format($aspek->nilai, 2);

                    // Calculate text widths
                    $aspekWidth = $pdf->GetStringWidth($aspekTitle);
                    $nilaiWidth = $pdf->GetStringWidth($nilai);
                    $spacing = $pageWidth - $aspekWidth - $nilaiWidth - 10;

                    // Draw aspek header with proper alignment
                    $pdf->Cell(0, 8, '', 1, 1, 'L', true);
                    $pdf->SetY($pdf->GetY() - 8);
                    $pdf->Cell($aspekWidth + 5, 8, $aspekTitle, 0, 0, 'L', false);
                    $pdf->Cell($spacing, 8, '', 0, 0, 'C', false);
                    $pdf->Cell($nilaiWidth + 5, 8, $nilai, 0, 1, 'R', false);
                    $pdf->Ln(2);

                    // Sort sub aspek by nums
                    $subAspeks = (array)$aspek->sub_aspek;
                    usort($subAspeks, function($a, $b) {
                        return $a->nums <=> $b->nums;
                    });

                    // Loop through sub aspek
                    foreach ($subAspeks as $subAspek) {
                        // Cek ruang untuk header sub aspek + minimal table content
                        $requiredHeight = 50; // Header + table header + minimal 1 row
                        $currentY = $pdf->GetY();
                        if ($currentY + $requiredHeight > ($pageHeight - $bottomMargin)) {
                            $pdf->AddPage();
                        }

                        // Get page width and calculate margins for effective width
                        $pageWidth = $pdf->getPageWidth();
                        $margins = $pdf->getMargins();
                        $effectiveWidth = $pageWidth - $margins['left'] - $margins['right'];

                        // Calculate column widths
                        $w = [
                            15,                           // No
                            round($effectiveWidth * 0.22)-1,  // Indikator
                            20,                           // Bobot
                            20,                           // Nilai
                            20,                           // Status
                            round($effectiveWidth * 0.25),     // Keterangan
                            round($effectiveWidth * 0.25)      // Saran
                        ];

                        // Sub Aspek header with full width and proper alignment
                        $pdf->SetFont('helvetica', 'B', 11);
                        $pdf->SetFillColor(235, 235, 235);

                        // Calculate title and value widths
                        $subAspekTitle = $instrumen->nums . '.' . $aspek->nums . '.' . $subAspek->nums . ' ' . $subAspek->nama_sub_aspek;
                        $nilaiText = 'Nilai: ' . number_format($subAspek->nilai, 2);

                        $titleWidth = $pdf->GetStringWidth($subAspekTitle);
                        $nilaiWidth = $pdf->GetStringWidth($nilaiText);
                        $spacing = $effectiveWidth - $titleWidth - $nilaiWidth - 10;

                        // Draw header with background
                        $pdf->Cell($effectiveWidth, 8, '', 1, 1, 'L', true);
                        $pdf->SetY($pdf->GetY() - 8);
                        $pdf->Cell($titleWidth + 5, 8, $subAspekTitle, 0, 0, 'L', false);
                        $pdf->Cell($spacing, 8, '', 0, 0, 'C', false);
                        $pdf->Cell($nilaiWidth + 5, 8, $nilaiText, 0, 1, 'R', false);
                        $pdf->Ln(2);

                        // Table header
                        $pdf->SetFont('helvetica', 'B', 10);
                        $pdf->SetFillColor(245, 245, 245);
                        
                        // Header row
                        $pdf->Cell($w[0], 7, 'No', 1, 0, 'C', true);
                        $pdf->Cell($w[1], 7, 'Indikator', 1, 0, 'C', true);
                        $pdf->Cell($w[2], 7, 'Bobot', 1, 0, 'C', true);
                        $pdf->Cell($w[3], 7, 'Nilai', 1, 0, 'C', true);
                        $pdf->Cell($w[4], 7, 'Status', 1, 0, 'C', true);
                        $pdf->Cell($w[5], 7, 'Keterangan', 1, 0, 'C', true);
                        $pdf->Cell($w[6], 7, 'Saran', 1, 1, 'C', true);

                        // Sort and display sub sub aspek
                        $subSubAspeks = (array)$subAspek->sub_sub_aspek;
                        usort($subSubAspeks, function($a, $b) {
                            return $a->nums <=> $b->nums;
                        });

                        // Data rows - TIDAK ADA PEMERIKSAAN PAGE BREAK DI SINI
                        // Biarkan AutoPageBreak TCPDF yang menangani
                        $pdf->SetFont('helvetica', '', 9);
                        foreach ($subSubAspeks as $ssa) {
                            // Calculate row height based on content
                            $text = $ssa->nama_sub_sub_aspek;
                            
                            // Hitung tinggi string tiap cell
                            $heights = [];
                            $heights[] = $pdf->getStringHeight($w[0], $ssa->nums);
                            $heights[] = $pdf->getStringHeight($w[1], $text);
                            $heights[] = $pdf->getStringHeight($w[2], '100%');
                            $heights[] = $pdf->getStringHeight($w[3], number_format($ssa->nilai, 2));
                            $heights[] = $pdf->getStringHeight($w[5], $ssa->ket);
                            // $heights[] = $pdf->getStringHeight($w[6], '');
                            $heights[] = $pdf->getStringHeight($w[6], $ssa->saran);

                            // Ambil tinggi terbesar
                            $height = max($heights) + 5;

                            // Set minimal tinggi
                            if ($height < 6) {
                                $height = 6;
                            }

                            $status = $ssa->aprove === 'yes' ? 'Disetujui' : 
                                    ($ssa->aprove === 'no' ? 'Ditolak' : 'Pending');

                            // Print row with uniform height
                            $pdf->MultiCell($w[0], $height, $ssa->nums, 1, 'C', false, 0);
                            $pdf->MultiCell($w[1], $height, $text, 1, 'L', false, 0);
                            $pdf->MultiCell($w[2], $height, '100%', 1, 'C', false, 0);
                            $pdf->MultiCell($w[3], $height, number_format($ssa->nilai, 2), 1, 'C', false, 0);
                            $pdf->MultiCell($w[4], $height, $status, 1, 'C', false, 0);
                            $pdf->MultiCell($w[5], $height, $ssa->ket, 1, 'L', false, 0);
                            $pdf->MultiCell($w[6], $height, $ssa->saran, 1, 'L', false, 1);
                        }
                        
                        $pdf->Ln(5);
                    }
                    $pdf->Ln(3);
                }
            }

            // Footer
            $pdf->SetY(-30);
            $pdf->SetFont('helvetica', 'I', 8);
            $pdf->Cell(0, 5, 'Laporan dibuat pada: ' . date('d/m/Y H:i:s'), 0, 1, 'L');
            $pdf->Cell(0, 5, 'Sistem SURABE BERANI', 0, 1, 'L');

            // Output PDF
            $filename = "Detail_Evaluasi_SPBE_{$opd->singkatan}_{$tahun}.pdf";
            $filename = $this->sanitizeFilename($filename);
            $pdf->Output($filename, 'D');
            exit;

        } catch (\Exception $e) {
            log_message('error', 'Export PDF OPD Error: ' . $e->getMessage());
            return $this->response->setJSON([
                'success' => 0,
                'msg' => 'Gagal export PDF: ' . $e->getMessage()
            ]);
        }
    }
    // Helper function to sanitize filename
    private function sanitizeFilename($filename)
    {
        // Remove or replace characters that are not allowed in filenames
        $filename = preg_replace('/[^a-zA-Z0-9\-_\.]/', '_', $filename);
        $filename = preg_replace('/_{2,}/', '_', $filename);
        return trim($filename, '_');
    }

    private function wrapText($text, $maxLength, $toleransi = 0)
    {
        if (strlen($text) <= $maxLength) {
            return $text;
        }
        
        // Try to break at word boundaries
        $words = explode(' ', $text);
        $lines = [];
        $currentLine = '';
        
        foreach ($words as $word) {
          $xxx = $currentLine . ' ' . $word;
          if (strlen($xxx) <= $maxLength || (strlen($xxx)-$maxLength) <= $toleransi) {
              $currentLine .= ($currentLine ? ' ' : '') . $word;
          } else {
              if ($currentLine) {
                  $lines[] = $currentLine;
              }
              $currentLine = $word;
          }
        }
        
        if ($currentLine) {
            $lines[] = $currentLine;
        }
        
        return implode("\n", $lines);
    }

    private function calculateMaxLines($texts, $widths)
    {
        $maxLines = 1;
        
        foreach ($texts as $index => $text) {
            if (isset($widths[$index])) {
                $maxLength = $widths[$index] * 0.6; // Approximate character width
                $lines = ceil(strlen($text) / $maxLength);
                $maxLines = max($maxLines, $lines);
            }
        }
        
        return $maxLines;
    }

    private function getPredikat($nilai)
    {
        if ($nilai >= 85) return 'Sangat Baik';
        if ($nilai >= 70) return 'Baik';
        if ($nilai >= 55) return 'Kurang';
        return 'Buruk';
    }

    public function getDetailEvaluasi()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        $opdId = $this->request->getGet('opd_id');
        
        if (!$opdId) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'dt' => null,
                'success' => 0,
                'msg' => 'OPD ID tidak ditemukan'
            ]);
        }
        
        try {
            $detailData = $this->lkeModel->getDetailEvaluasiByOpd($tahun, $opdId);
            $progressData = $this->lkeModel->getProgressEvaluasi($tahun, $opdId);
            
            $result = [
                'detail_evaluasi' => $detailData,
                'progress' => $progressData
            ];
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $result,
                'success'   => 1,
                'msg'       => 'Detail evaluasi berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil detail evaluasi: ' . $e->getMessage()
            );
        }
        
        return $this->response->setJSON($data);
    }

    public function getProgressOverall()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        
        try {
            $progressData = $this->lkeModel->getProgressEvaluasi($tahun);
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $progressData,
                'success'   => 1,
                'msg'       => 'Data progress berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data progress: ' . $e->getMessage()
            );
        }
        
        return $this->response->setJSON($data);
    }

    public function getNilaiAspekDetailed()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        $opdId = $this->request->getGet('opd_id');
        
        if (!$opdId) {
            return $this->response->setJSON([
                'token_crs' => csrf_hash(),
                'dt' => null,
                'success' => 0,
                'msg' => 'OPD ID tidak ditemukan'
            ]);
        }
        
        try {
            // $nilaiAspek = $this->lkeModel->getNilaiSubAspek($tahun, $opdId);
            $nilaiAspek = $this->DashboardModel->nilaiOpd($tahun, $opdId);
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $nilaiAspek, //$this->formatAspekNested($nilaiAspek),
                'success'   => 1,
                'msg'       => 'Data nilai aspek berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data nilai aspek: ' . $e->getMessage()
            );
        }
        
        return $this->response->setJSON($data);
    }

    private function formatAspekNested(array $data): array
    {
        $structuredData = [];

        foreach ($data as $row) {
            $komponenKey = $row['komponen'];
            $aspekKey = $row['nama_aspek'];
            $subAspekKey = $row['nama_sub_aspek'];
            $subSubAspekKey = $row['nama_sub_sub_aspek'];

            if (!isset($structuredData[$komponenKey])) {
                $structuredData[$komponenKey] = [
                    'komponen' => $komponenKey,
                    'bobot_rb' => $row['bobot_rb'],
                    'aspek' => []
                ];
            }

            if (!isset($structuredData[$komponenKey]['aspek'][$aspekKey])) {
                $structuredData[$komponenKey]['aspek'][$aspekKey] = [
                    'nama_aspek' => $aspekKey,
                    'bobot_as' => $row['bobot_as'],
                    'urutan' => $row['urutan'],
                    'sub_aspek' => []
                ];
            }

            if (!isset($structuredData[$komponenKey]['aspek'][$aspekKey]['sub_aspek'][$subAspekKey])) {
                $structuredData[$komponenKey]['aspek'][$aspekKey]['sub_aspek'][$subAspekKey] = [
                    'nama_sub_aspek' => $subAspekKey,
                    'bobot_sa' => $row['bobot_sa'],
                    'sub_sub_aspek' => []
                ];
            }

            if (!isset($structuredData[$komponenKey]['aspek'][$aspekKey]['sub_aspek'][$subAspekKey]['sub_sub_aspek'][$subSubAspekKey])) {
                $structuredData[$komponenKey]['aspek'][$aspekKey]['sub_aspek'][$subAspekKey]['sub_sub_aspek'][$subSubAspekKey] = [
                    'nama_sub_sub_aspek' => $subSubAspekKey,
                    'bobot_ssa' => $row['bobot_ssa'],
                    'indikator' => []
                ];
            }

            $structuredData[$komponenKey]['aspek'][$aspekKey]['sub_aspek'][$subAspekKey]['sub_sub_aspek'][$subSubAspekKey]['indikator'][] = [
                'indikator' => $row['indikator'],
                'jawaban' => $row['jawaban'],
                'nilai_jawaban' => $row['nilai_jawaban'],
                'nilai_penilai' => $row['nilai_penilai'],
                'approved' => $row['Aproved'],
                'ket' => $row['Ket'],
                'status_pengisian' => $row['status_pengisian']
            ];
        }

        return array_values(array_map(function ($komponen) {
            $komponen['aspek'] = array_values(array_map(function ($aspek) {
                $aspek['sub_aspek'] = array_values(array_map(function ($subAspek) {
                    $subAspek['sub_sub_aspek'] = array_values($subAspek['sub_sub_aspek']);
                    return $subAspek;
                }, $aspek['sub_aspek']));
                return $aspek;
            }, $komponen['aspek']));
            return $komponen;
        }, $structuredData));
    }

    public function viewLaporanOpd()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        $opdId = $this->request->getGet('opd_id');

        if (!$opdId) {
            return redirect()->back()->with('error', 'OPD ID tidak ditemukan');
        }

        // try {
            $nilaiAspek = $this->DashboardModel->nilaiOpd($tahun, $opdId);
            
            if (empty($nilaiAspek)) {
                return redirect()->back()->with('error', 'Data tidak ditemukan');
            }

            // Prepare data
            $opd = $nilaiAspek[0];
            
            // Kumpulkan semua aspek dari semua instrumen
            $allAspek = [];
            foreach ($opd->instrumen as $instrumen) {
                foreach ($instrumen->aspek as $aspek) {
                    $allAspek[] = (object)[
                        'instrumen_nama' => $instrumen->nama,
                        'instrumen_nums' => $instrumen->nums,
                        'aspek_nums' => $aspek->nums,
                        'nama_aspek' => $aspek->nama_aspek,
                        'nilai' => $aspek->nilai,
                        'bobot_rb' => $instrumen->bobot
                    ];
                }
            }

            // Prepare radar chart data
            $radarData = [];
            $radarLabels = [];
            foreach ($allAspek as $aspekItem) {
                $kode = $aspekItem->instrumen_nums . '.' . $aspekItem->aspek_nums;
                $radarData[] = floatval($aspekItem->nilai);
                
                $labelText = $kode . '. ';
                $labelText .= strlen($aspekItem->nama_aspek) > 20 ? 
                            substr($aspekItem->nama_aspek, 0, 20) . '...' : 
                            $aspekItem->nama_aspek;
                $radarLabels[] = $labelText;
            }

            $usr = $this->decoded->rln;
            $data = [
                'title' => 'Laporan Evaluasi Indeks Reformasi Birokrasi',
                'tahun' => $tahun,
                'opd' => $opd,
                'allAspek' => $allAspek,
                'radarData' => json_encode($radarData),
                'radarLabels' => json_encode($radarLabels),
                'usr' => $usr,
            ];

            // return view('Pages/laporan/view_opd', $data);
            return view('Pages/laporan/view_opd_layout', $data);

        // } catch (\Exception $e) {
        //     log_message('error', 'View Laporan OPD Error: ' . $e->getMessage());
        //     return redirect()->back()->with('error', 'Gagal memuat laporan: ' . $e->getMessage());
        // }
    }

    public function getLaporanOpdJson()
    {
        $tahun = $this->request->getGet('tahun') ?? date('Y');
        $opdId = $this->request->getGet('opd_id');

        if (!$opdId) {
            return $this->response->setStatusCode(400)
                                ->setJSON(['error' => true, 'message' => 'OPD ID tidak ditemukan']);
        }

        try {
            $nilaiAspek = $this->DashboardModel->nilaiOpd($tahun, $opdId);

            if (empty($nilaiAspek)) {
                return $this->response->setStatusCode(404)
                                    ->setJSON(['error' => true, 'message' => 'Data tidak ditemukan']);
            }

            // Ambil data OPD pertama
            $opd = $nilaiAspek[0];

            // Kumpulkan semua aspek dari semua instrumen
            $allAspek = [];
            foreach ($opd->instrumen as $instrumen) {
                foreach ($instrumen->aspek as $aspek) {
                    $allAspek[] = [
                        'instrumen_nama' => $instrumen->nama,
                        'instrumen_nums' => $instrumen->nums,
                        'aspek_nums' => $aspek->nums,
                        'nama_aspek' => $aspek->nama_aspek,
                        'nilai' => floatval($aspek->nilai),
                        'bobot_rb' => $instrumen->bobot
                    ];
                }
            }

            // Siapkan data untuk radar chart
            $radarData = [];
            $radarLabels = [];
            foreach ($allAspek as $aspekItem) {
                $kode = $aspekItem['instrumen_nums'] . '.' . $aspekItem['aspek_nums'];
                $radarData[] = $aspekItem['nilai'];

                $labelText = $kode . '. ';
                $labelText .= strlen($aspekItem['nama_aspek']) > 20 ? 
                                substr($aspekItem['nama_aspek'], 0, 20) . '...' : 
                                $aspekItem['nama_aspek'];
                $radarLabels[] = $labelText;
            }

            $usr = $this->decoded->rln ?? null;

            $data = [
                'error' => false,
                'tahun' => $tahun,
                'opd' => $opd,
                'allAspek' => $allAspek,
                'radarData' => $radarData,
                'radarLabels' => $radarLabels,
                'usr' => $usr,
            ];

            return $this->response->setStatusCode(200)->setJSON($data);

        } catch (\Exception $e) {
            log_message('error', 'Get Laporan OPD JSON Error: ' . $e->getMessage());
            return $this->response->setStatusCode(500)
                                ->setJSON(['error' => true, 'message' => 'Gagal memuat laporan: ' . $e->getMessage()]);
        }
    }

}