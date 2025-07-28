<?php

namespace App\Controllers\Pages;
use App\Controllers\BaseController;
use App\Models\LkeModel;
use App\Models\DashboardModel;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use PhpOffice\PhpSpreadsheet\Style\Alignment;
use PhpOffice\PhpSpreadsheet\Style\Fill;
use PhpOffice\PhpSpreadsheet\Cell\Coordinate;


class ReportController extends BaseController
{
    protected $lkeModel;

    public function __construct()
    {
        $this->lkeModel = new LkeModel();
        $this->DashboardModel = new DashboardModel();
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
        
        try {
            $evaluasiData = $this->lkeModel->getEvaluasiLengkap($tahun);
            
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => $evaluasiData,
                'success'   => 1,
                'msg'       => 'Data evaluasi lengkap berhasil diambil'
            );
            
        } catch (\Exception $e) {
            $data = array(
                'token_crs' => csrf_hash(),
                'dt'        => null,
                'success'   => 0,
                'msg'       => 'Gagal mengambil data evaluasi lengkap: ' . $e->getMessage()
            );
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
            $sheet->setCellValue("A{$row}", 'Laporan Evaluasi SPBE Tahun ' . $tahun);
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
            $sheet->setCellValue('C'.$row, 'Index SPBE');
            $sheet->setCellValue('D'.$row, 'Predikat');

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
                $sheet->setCellValue("D{$row}", $this->getPredikat($opd['nilai_akhir']));

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
            // $pdf->SetHeaderData('', 0, 'LAPORAN EVALUASI SPBE TAHUN ' . $tahun, 'SISTEM PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI');
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
            $pdf->Cell(0, 12, 'LAPORAN EVALUASI SPBE TAHUN ' . $tahun, 0, 1, 'C');
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
            $pdf->MultiCell($indexWidth, $headerHeight, 'Index SPBE', 1, 'C', true, 0);
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
            $nilaiAspek = $this->DashboardModel->nilaiOpd($tahun, $opdId);
            
            // Set basic PDF options - Changed to Landscape
            $pdf = new \TCPDF('L', PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
            $pdf->SetCreator('SURABE BERANI');
            $pdf->SetTitle('Laporan Detail Evaluasi SPBE');
            $pdf->SetHeaderFont(['helvetica', '', 10]);
            $pdf->SetFooterFont(['helvetica', '', 8]);
            $pdf->SetHeaderData('', 0, 'SURABE BERANI', 'SISTEM PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI');
            $pdf->SetMargins(15, 25, 15);
            $pdf->SetHeaderMargin(10);
            $pdf->SetFooterMargin(10);
            $pdf->SetAutoPageBreak(TRUE, 20);
            $pdf->AddPage();
            $pdf->setPrintHeader(false);

            // Header section
            $opd = $nilaiAspek[0];
            $pdf->SetFont('helvetica', 'B', 16);
            $pdf->Cell(0, 10, 'LAPORAN DETAIL EVALUASI SPBE', 0, 1, 'C');
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

            // Loop through instrumen
            foreach ($opd->instrumen as $instrumen) {
                // Instrumen header
                $pdf->SetFont('helvetica', 'B', 14);
                $pdf->Cell(0, 10, $instrumen->nums . '. ' . strtoupper($instrumen->nama), 0, 1, 'L');
                $pdf->SetFont('helvetica', '', 11);
                $pdf->Cell(0, 6, 'Nilai: ' . number_format($instrumen->nilai, 2), 0, 1, 'L');
                $pdf->Ln(2);

                // Loop through aspek
                foreach ($instrumen->aspek as $aspek) {
                    if ($pdf->GetY() > 180) { // Adjusted for landscape
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
                    $spacing = $pageWidth - $aspekWidth - $nilaiWidth - 10; // 10 for padding

                    // Draw aspek header with proper alignment
                    $pdf->Cell(0, 8, '', 1, 1, 'L', true); // Background cell
                    $pdf->SetY($pdf->GetY() - 8); // Move back to draw text
                    $pdf->Cell($aspekWidth + 5, 8, $aspekTitle, 0, 0, 'L', false);
                    $pdf->Cell($spacing, 8, '', 0, 0, 'C', false);
                    $pdf->Cell($nilaiWidth + 5, 8, $nilai, 0, 1, 'R', false);

                    // Add spacing after header
                    $pdf->Ln(2);
                    
                    // Aspek header
                    // $pdf->SetFont('helvetica', 'B', 12);
                    // $pdf->SetFillColor(220, 220, 220);
                    // $pdf->Cell(0, 8, $instrumen->nums . '.' . $aspek->nums . ' ' . $aspek->nama_aspek, 1, 1, 'L', true);
                    // $pdf->SetFont('helvetica', '', 11);
                    // $pdf->Cell(0, 6, 'Nilai: ' . number_format($aspek->nilai, 2), 0, 1, 'L');
                    // $pdf->Ln(2);

                    // Sort sub aspek by nums
                    $subAspeks = (array)$aspek->sub_aspek;
                    usort($subAspeks, function($a, $b) {
                        return $a->nums <=> $b->nums;
                    });

                    // Loop through sub aspek
                    foreach ($subAspeks as $subAspek) {
                        if ($pdf->GetY() > 180) { // Adjusted for landscape
                            $pdf->AddPage();
                        }

                        // Get page width and calculate margins for effective width
                        $pageWidth = $pdf->getPageWidth();
                        $margins = $pdf->getMargins();
                        $effectiveWidth = $pageWidth - $margins['left'] - $margins['right'];

                        // Calculate column widths
                        $w = [
                            15,                     // No
                            round($effectiveWidth * 0.35)-1,  // Indikator
                            20,                     // Bobot
                            20,                     // Nilai
                            20,                     // Status
                            round($effectiveWidth * 0.20)-3,  // Keterangan
                            round($effectiveWidth * 0.20)-3   // Saran
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

                        // Data rows
                        $pdf->SetFont('helvetica', '', 9);
                        foreach ($subSubAspeks as $ssa) {
                            // Calculate row height based on content
                            $text = $ssa->nama_sub_sub_aspek;
                            $height = max(
                                $pdf->getStringHeight($w[1], $text),
                                6
                            );

                            $status = $ssa->aprove === 'yes' ? 'Disetujui' : 
                                     ($ssa->aprove === 'no' ? 'Ditolak' : 'Pending');

                            // Print row with uniform height
                            $pdf->MultiCell($w[0], $height, $ssa->nums, 1, 'C', false, 0);
                            $pdf->MultiCell($w[1], $height, $text, 1, 'L', false, 0);
                            $pdf->MultiCell($w[2], $height, '100%', 1, 'C', false, 0);
                            $pdf->MultiCell($w[3], $height, number_format($ssa->nilai, 2), 1, 'C', false, 0);
                            $pdf->MultiCell($w[4], $height, $status, 1, 'C', false, 0);
                            $pdf->MultiCell($w[5], $height, ($ssa->ket ), 1, 'L', false, 0);
                            $pdf->MultiCell($w[6], $height, '', 1, 'L', false, 1);
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


}