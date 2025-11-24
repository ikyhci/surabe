<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('styles') ?>
<style>
.text-vertikal {
  writing-mode: vertical-rl;
  text-orientation: mixed;
  text-align: center;
  height: 200px;
  padding: 5px;
  transform: rotate(180deg);
}

th.text-vertikal {
  vertical-align: middle;
}

/* Modal Custom Styles */
.modal-xl-custom {
  max-width: 95%;
  margin: 1rem auto;
}

#modalDetail .modal-body {
  padding: 0;
  max-height: calc(100vh - 150px);
  overflow-y: auto;
}

/* Embedded Report Styles */
.embedded-report {
  background-color: #f8f9fa;
  padding: 20px;
}

.embedded-report .container-report {
  background-color: white;
  padding: 30px;
  box-shadow: none;
  max-width: 100%;
}

.embedded-report .header-section {
  text-align: center;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 3px solid #0d6efd;
}

.embedded-report .header-section h1 {
  color: #0d6efd;
  font-weight: bold;
  margin-bottom: 10px;
  font-size: 1.5rem;
}

.embedded-report .header-section h2 {
  color: #6c757d;
  font-size: 1.2rem;
}

.embedded-report .info-box {
  background-color: #f8f9fa;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 30px;
}

.embedded-report .info-box table {
  width: 100%;
}

.embedded-report .info-box td {
  padding: 8px;
}

.embedded-report .info-box td:first-child {
  font-weight: bold;
  width: 200px;
}

.embedded-report .summary-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 30px;
  margin-bottom: 30px;
}

@media (max-width: 992px) {
  .embedded-report .summary-grid {
    grid-template-columns: 1fr;
  }
}

.embedded-report .card-custom {
  border: 1px solid #dee2e6;
  border-radius: 8px;
  overflow: hidden;
}

.embedded-report .card-custom-header {
  background-color: #0d6efd;
  color: white;
  padding: 15px;
  font-weight: bold;
  text-align: center;
}

.embedded-report .card-custom-body {
  padding: 20px;
}

.embedded-report .note-box {
  background-color: #fff3cd;
  border-left: 4px solid #ffc107;
  padding: 15px;
  margin-top: 20px;
  border-radius: 4px;
  font-size: 0.9rem;
}

.embedded-report .instrumen-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
  margin-top: 30px;
}

.embedded-report .aspek-header {
  background-color: #e9ecef;
  padding: 15px;
  border-radius: 8px;
  margin-top: 30px;
  margin-bottom: 15px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.embedded-report .sub-aspek-header {
  background-color: #f8f9fa;
  padding: 12px;
  border-radius: 6px;
  margin-top: 20px;
  margin-bottom: 15px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-left: 4px solid #0d6efd;
}

.embedded-report .table-detail {
  font-size: 0.85rem;
}

.embedded-report .table-detail th {
  background-color: #f8f9fa;
  font-weight: bold;
  text-align: center;
  vertical-align: middle;
}

.embedded-report .status-badge {
  display: inline-block;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: bold;
}

.embedded-report .status-disetujui {
  background-color: #d1e7dd;
  color: #0f5132;
}

.embedded-report .status-ditolak {
  background-color: #f8d7da;
  color: #842029;
}

.embedded-report .status-pending {
  background-color: #fff3cd;
  color: #856404;
}

/* Loading Spinner in Modal */
.modal-loading {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 400px;
  flex-direction: column;
}

.modal-loading .spinner-border {
  width: 3rem;
  height: 3rem;
}

/* Sticky Modal Header */
.modal-header.sticky-header {
  position: sticky;
  top: 0;
  z-index: 1000;
  background-color: white;
  border-bottom: 2px solid #dee2e6;
}
</style>
<?= $this->endSection() ?>

<?= $this->section('content') ?>
<div class="page-heading">
  <h3>Laporan Hasil Evaluasi Indeks Reformasi Birokrasi Pemerintah Daerah</h3>
</div>
<div class="page-content">
  <!-- Filter Card -->
  <div class="card">
    <div class="card-body">
      <div class="row">
        <div class="col-md-4 mb-3">
          <label>Tahun</label>
          <select class="form-select" id="filter-tahun">
            <?php for($year = date('Y'); $year >= (date('Y') -5); $year--) : ?>
            <option value="<?= $year ?>" <?= $year == date('Y') ? 'selected' : '' ?>>
              <?= $year ?>
            </option>
            <?php endfor; ?>
            <!-- <option value="2025" <?= date('Y') === '2025' ? 'selected' : '' ?>>2025</option>
            <option value="2024" <?= date('Y') === '2024' ? 'selected' : '' ?>>2024</option>
            <option value="2023" <?= date('Y') === '2023' ? 'selected' : '' ?>>2023</option> -->
          </select>
        </div>
        <div class="col-md-4 mb-3">
          <button class="btn btn-primary mt-4" id="btn-refresh">
            <i class="bi bi-arrow-clockwise"></i> Refresh Data
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- Summary Card -->
  <div class="card">
    <div class="card-header">
      <h5>Ringkasan Evaluasi</h5>
    </div>
    <div class="card-body">
      <div class="row" id="ringkasan-container">
        <div class="col-md-3 mb-3">
          <div class="border p-3 rounded text-center">
            <h6>Total Instansi</h6>
            <h2 id="total-instansi">
              <div class="spinner-border spinner-border-sm" role="status"></div>
            </h2>
          </div>
        </div>
        <div class="col-md-3 mb-3">
          <div class="border p-3 rounded text-center">
            <h6>Rata-rata Index</h6>
            <h2 id="rata-rata-index">
              <div class="spinner-border spinner-border-sm" role="status"></div>
            </h2>
          </div>
        </div>
        <div class="col-md-3 mb-3">
          <div class="border p-3 rounded text-center">
            <h6>Tertinggi</h6>
            <h2 id="nilai-tertinggi">
              <div class="spinner-border spinner-border-sm" role="status"></div>
            </h2>
            <small class="text-muted" id="instansi-tertinggi"></small>
          </div>
        </div>
        <div class="col-md-3 mb-3">
          <div class="border p-3 rounded text-center">
            <h6>Terendah</h6>
            <h2 id="nilai-terendah">
              <div class="spinner-border spinner-border-sm" role="status"></div>
            </h2>
            <small class="text-muted" id="instansi-terendah"></small>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Table Report -->
  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h5>Daftar Hasil Evaluasi</h5>
      <div>
        <button class="btn btn-primary btn-sm" id="btn-excel">
          <i class="bi bi-file-earmark-excel"></i> Export Excel
        </button>
        <button class="btn btn-danger btn-sm" id="btn-pdf">
          <i class="bi bi-file-earmark-pdf"></i> Export PDF
        </button>
      </div>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped" id="table-report">
          <thead>
            <tr>
              <th>No</th>
              <th>Instansi</th>
              <th>Index RB</th>
              <th class="d-none aspek-header text-vertikal" id="aspek-header-1">-</th>
              <th class="d-none aspek-header text-vertikal" id="aspek-header-2">-</th>
              <th class="d-none aspek-header text-vertikal" id="aspek-header-3">-</th>
              <th class="d-none aspek-header text-vertikal" id="aspek-header-4">-</th>
              <th class="d-none aspek-header text-vertikal" id="aspek-header-5">-</th>
              <th>Aksi</th>
            </tr>
          </thead>
          <tbody id="table-body">
            <tr>
              <td colspan="8" class="text-center">
                <div class="spinner-border" role="status">
                  <span class="visually-hidden">Loading...</span>
                </div>
                <br>Memuat data...
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <!-- Chart -->
  <div class="card">
    <div class="card-header">
      <h5>Grafik Perbandingan Aspek</h5>
    </div>
    <div class="card-body">
      <canvas id="reportChart" width="400" height="200"></canvas>
    </div>
  </div>
</div>

<!-- Modal Detail - IMPROVED -->
<div class="modal fade" id="modalDetail" tabindex="-1">
  <div class="modal-dialog modal-xl-custom">
    <div class="modal-content">
      <div class="modal-header sticky-header">
        <h5 class="modal-title">
          <i class="bi bi-file-earmark-text"></i>
          Detail Laporan Evaluasi: <span id="modal-instansi-name" class="text-primary"></span>
        </h5>
        <div class="ms-auto d-flex gap-2 me-3">
          <button class="btn btn-success btn-sm" data-opd_id="" id="btn-pdfOpd">
            <i class="bi bi-file-pdf"></i> Download PDF
          </button>
          <button class="btn btn-primary btn-sm" id="btn-printModal">
            <i class="bi bi-printer"></i> Print
          </button>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="modal-detail-content">
        <div class="modal-loading">
          <div class="spinner-border text-primary" role="status"></div>
          <p class="mt-3 text-muted">Memuat laporan lengkap...</p>
        </div>
      </div>
    </div>
  </div>
</div>

<?= $this->endSection() ?>

<?= $this->section('script') ?>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script {csp-script-nonce}>
let reportChart;
let currentData = {};

let tahun = $('#filter-tahun').val();
$(document).ready(function() {
  loadReportData();

  // Event listeners
  $('#btn-refresh').click(function() {
    loadReportData(true);
  });

  $('#filter-tahun').change(function() {
    loadReportData();
  });

  $('#btn-excel').click(function() {
    exportToExcel();
  });

  $('#btn-pdf').click(function() {
    exportToPDF();
  });

  $('#btn-pdfOpd').click(function() {
    const opdId = $(this).data('opd_id');
    if (!opdId) {
      showError('ID OPD tidak ditemukan. Silakan tutup modal dan buka detail lagi.');
      return;
    }
    exportToPDFOpd(opdId);
  });

  // Print modal content
  $('#btn-printModal').click(function() {
    printModalContent();
  });
});

function loadReportData(refresh = false) {
  tahun = $('#filter-tahun').val();
  showLoadingState();

  $.ajax({
    url: '<?= base_url('dashboard/report/getEvaluasiLengkap') ?>',
    method: 'GET',
    data: {
      tahun: tahun,
      update: refresh
    },
    dataType: 'json',
    success: function(response) {
      if (response.success == 1) {
        currentData = response.dt;
        updateRingkasan(response.dt.ringkasan);
        updateTable(response.dt.data_opd);
        updateChart(response.dt.data_opd);

        if (response.token_crs) {
          $('input[name="<?= csrf_token() ?>"]').val(response.token_crs);
        }
      } else {
        showError('Gagal memuat data: ' + response.msg);
      }
    },
    error: function(xhr, status, error) {
      showError('Terjadi kesalahan saat memuat data');
      console.error('Error:', error);
    }
  });
}

function showLoadingState() {
  $('#total-instansi, #rata-rata-index, #nilai-tertinggi, #nilai-terendah').html(
    '<div class="spinner-border spinner-border-sm" role="status"></div>'
  );
  $('#instansi-tertinggi, #instansi-terendah').text('');

  $('#table-body').html(`
    <tr>
      <td colspan="8" class="text-center">
        <div class="spinner-border" role="status"></div>
        <br>Memuat data...
      </td>
    </tr>
  `);
}

function updateRingkasan(ringkasan) {
  $('#total-instansi').text(ringkasan.total_instansi);
  $('#rata-rata-index').text(ringkasan.rata_rata_index);
  $('#nilai-tertinggi').text(ringkasan.tertinggi);
  $('#nilai-terendah').text(ringkasan.terendah);

  if (ringkasan.instansi_tertinggi) {
    $('#instansi-tertinggi').text(ringkasan.instansi_tertinggi.nama_opd);
  }

  if (ringkasan.instansi_terendah) {
    $('#instansi-terendah').text(ringkasan.instansi_terendah.nama_opd);
  }
}

function updateTable(dataOpd) {
  $('.aspek-header').addClass('d-none');
  let tbody = '';

  if (!dataOpd || dataOpd.length === 0) {
    tbody = `
      <tr><td colspan="8" class="text-center">Tidak ada data untuk tahun ini</td></tr>
    `;
  } else {

    // Tampilkan header aspek dari allAspek pertama
    if (dataOpd[0].allAspek) {
      dataOpd[0].allAspek.forEach((aspek, index) => {
        $(`#aspek-header-${index + 1}`).removeClass('d-none')
          .text(`${aspek.nama_aspek}`);
      });
    }

    // Isi baris tabel
    dataOpd.forEach((item, index) => {
      const opd = item.opd;
      const aspekColumns = item.radarData ?
        item.radarData.map(v => `<td>${parseFloat(v).toFixed(2)}</td>`).join('') :
        '';

      tbody += `
        <tr>
          <td>${index + 1}</td>
          <td>${opd.nama_opd}</td>
          <td><strong>${parseFloat(opd.nilai).toFixed(2)}</strong></td>
          ${aspekColumns}
          <td>
            <a href="<?= base_url('dashboard/report/view-opd') ?>?tahun=${tahun}&opd_id=${opd.id}"
              class="btn btn-sm btn-info">
              <i class="bi bi-eye"></i> Detail
            </a>
          </td>
        </tr>
      `;
    });
  }

  $('#table-body').html(tbody);
}

function updateChart(dataOpd) {
  if (!dataOpd.length) return;

  const labels = dataOpd[0].radarLabels;
  const averages = [];

  labels.forEach((label, index) => {
    let total = 0;
    let count = 0;

    dataOpd.forEach(item => {
      if (item.radarData && item.radarData[index] != null) {
        total += parseFloat(item.radarData[index]);
        count++;
      }
    });

    averages.push(count > 0 ? (total / count).toFixed(2) : 0);
  });

  if (reportChart) reportChart.destroy();

  const ctx = document.getElementById('reportChart');

  reportChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels,
      datasets: [{
        label: 'Rata-rata Per Aspek',
        data: averages,
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      scales: {
        y: {
          beginAtZero: true,
          max: 100
        }
      }
    }
  });
}

function getPredikat(nilai) {
  if (nilai >= 85) return 'Sangat Baik';
  if (nilai >= 70) return 'Baik';
  if (nilai >= 55) return 'Kurang';
  return 'Buruk';
}

function getPredikatBadgeClass(predikat) {
  switch (predikat) {
    case 'Sangat Baik':
      return 'bg-success';
    case 'Baik':
      return 'bg-primary';
    case 'Kurang':
      return 'bg-warning';
    case 'Buruk':
      return 'bg-danger';
    default:
      return 'bg-secondary';
  }
}

// IMPROVED: Load HTML report in modal
function showDetail(opdId, namaOpd) {
  $('#modal-instansi-name').text(namaOpd);
  $('#btn-pdfOpd').data('opd_id', opdId);

  // Show loading state
  $('#modal-detail-content').html(`
    <div class="modal-loading">
      <div class="spinner-border text-primary" role="status"></div>
      <p class="mt-3 text-muted">Memuat laporan lengkap...</p>
    </div>
  `);

  // Show modal immediately
  $('#modalDetail').modal('show');

  // Load HTML report
  const url = `<?= base_url('dashboard/report/view-opd') ?>?tahun=${tahun}&opd_id=${opdId}`;

  $.ajax({
    url: url,
    method: 'GET',
    dataType: 'html',
    success: function(html) {
      // Extract body content from HTML response
      const $html = $(html);

      // Find the main content (container-report)
      let reportContent = $html.find('.container-report').html();

      // If not found, try to get body content
      if (!reportContent) {
        reportContent = $html.find('body').html();
      }

      // Wrap in embedded-report div for custom styling
      const wrappedContent = `
        <div class="embedded-report">
          <div class="container-report">
            ${reportContent}
          </div>
        </div>
      `;

      $('#modal-detail-content').html(wrappedContent);

      // Hide action buttons in modal view
      $('#modal-detail-content .btn-actions').hide();

      // Re-initialize any charts in the loaded content
      reinitializeCharts();
    },
    error: function(xhr, status, error) {
      console.error('Error loading report:', error);
      $('#modal-detail-content').html(`
        <div class="alert alert-danger m-4">
          <i class="bi bi-exclamation-triangle"></i>
          <strong>Terjadi kesalahan!</strong><br>
          Gagal memuat laporan. Silakan coba lagi.
        </div>
      `);
    }
  });
}

// Reinitialize charts after loading HTML content
function reinitializeCharts() {
  // Wait a bit for DOM to be ready
  setTimeout(() => {
    const canvas = document.getElementById('radarChart');
    if (canvas) {
      // Chart will be initialized by the script in the loaded HTML
      console.log('Chart found in modal');
    }
  }, 100);
}

// Print modal content
function printModalContent() {
  const printContent = $('#modal-detail-content').html();
  const originalContent = document.body.innerHTML;

  // Create print window
  const printWindow = window.open('', '', 'height=600,width=800');
  printWindow.document.write('<html><head><title>Print Laporan</title>');

  // Add Bootstrap CSS
  printWindow.document.write(
    '<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">');

  // Add custom print styles
  printWindow.document.write(`
    <style>
      body { padding: 20px; }
      .embedded-report { background: white; }
      .btn-actions { display: none !important; }
      @media print {
        .embedded-report { background: white; }
      }
    </style>
  `);

  printWindow.document.write('</head><body>');
  printWindow.document.write(printContent);
  printWindow.document.write('</body></html>');

  printWindow.document.close();
  printWindow.focus();

  // Wait for content to load then print
  setTimeout(() => {
    printWindow.print();
  }, 500);
}

function exportToExcel() {
  const tahun = $('#filter-tahun').val();
  window.open(`<?= base_url('dashboard/report/exportExcel') ?>?tahun=${tahun}`, '_blank');
}

function exportToPDF() {
  const tahun = $('#filter-tahun').val();
  window.open(`<?= base_url('dashboard/report/exportPDF') ?>?tahun=${tahun}`, '_blank');
}

function exportToPDFOpd(opdId = '') {
  if (!opdId) {
    showError('ID OPD tidak boleh kosong.');
    return;
  }

  const tahun = $('#filter-tahun').val();
  const url = `<?= base_url('dashboard/report/exportPdfOpd') ?>?tahun=${tahun}&opd_id=${opdId}`;

  const originalText = $('#btn-pdfOpd').html();
  $('#btn-pdfOpd').html('<i class="bi bi-hourglass-split"></i> Generating...');
  $('#btn-pdfOpd').prop('disabled', true);

  window.open(url, '_blank');

  setTimeout(() => {
    $('#btn-pdfOpd').html(originalText);
    $('#btn-pdfOpd').prop('disabled', false);
  }, 2000);
}

function showError(message) {
  $('#total-instansi, #rata-rata-index, #nilai-tertinggi, #nilai-terendah').text('-');
  $('#table-body').html(`
    <tr>
      <td colspan="8" class="text-center text-danger">
        <i class="bi bi-exclamation-triangle"></i> ${message}
      </td>
    </tr>
  `);

  if (typeof Swal !== 'undefined') {
    Swal.fire('Error', message, 'error');
  } else {
    alert(message);
  }
}
</script>
<?= $this->endSection() ?>