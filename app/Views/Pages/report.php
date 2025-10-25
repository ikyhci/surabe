<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('style') ?>
<?= $this->endSection() ?>

<?= $this->section('content') ?>

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
</style>
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
            <option value="2025" <?= date('Y') === '2025' ? 'selected' : '' ?>>2025</option>
            <option value="2024" <?= date('Y') === '2024' ? 'selected' : '' ?>>2024</option>
            <option value="2023" <?= date('Y') === '2023' ? 'selected' : '' ?>>2023</option>
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
            <!-- <tr>
                            <th>No</th>
                            <th>Instansi</th>
                            <th>Index SPBE</th>
                            <th>Predikat</th>
                            <th id="tableHeaderAspek" class="text-center">Nilai per Aspek</th>
                            <th>Aksi</th>
                        </tr> -->
            <tr>
              <th>No</th>
              <th>Instansi</th>
              <th>Index RB</th>
              <!-- <th></th> -->
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

<!-- Modal Detail -->
<div class="modal fade" id="modalDetail" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Detail Evaluasi: <span id="modal-instansi-name"></span></h5>
        <button class="btn btn-success btn-sm" data-opd_id="" id="btn-pdfOpd">download</button>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body" id="modal-detail-content">
        <!-- Detail content will be loaded here -->
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
});

function loadReportData(refresh = false) {
  tahun = $('#filter-tahun').val();

  // Show loading state
  showLoadingState();

  // Load ringkasan and data
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

        // Update CSRF token
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
  // Reset ringkasan
  $('#total-instansi, #rata-rata-index, #nilai-tertinggi, #nilai-terendah').html(
    '<div class="spinner-border spinner-border-sm" role="status"></div>'
  );
  $('#instansi-tertinggi, #instansi-terendah').text('');

  // Reset table
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

  if (dataOpd.length === 0 || dataOpd[0].aspek_values.length === 0) {
    tbody = `
            <tr>
                <td colspan="8" class="text-center">Tidak ada data untuk tahun ini</td>
            </tr>
        `;
  } else {
    // Update aspek headers
    if (dataOpd[0] && dataOpd[0].aspek_values) {
      $('#tableHeaderAspek').attr('colspan', dataOpd[0].aspek_values.length);
      dataOpd[0].aspek_values.forEach((aspek, index) => {
        if (index <= dataOpd[0].aspek_values.length) {
          $(`#aspek-header-${index + 1}`).removeClass('d-none');
          $(`#aspek-header-${index + 1}`).text(aspek.nama_aspek);
        }
      });
    }

    dataOpd.forEach((opd, index) => {
      const predikat = getPredikat(opd.nilai_akhir);
      const badgeClass = getPredikatBadgeClass(predikat);

      let aspekColumns = '';
      if (opd.aspek_values) {
        for (let i = 0; i < opd.aspek_values.length; i++) {
          const aspekValue = opd.aspek_values[i] ? opd.aspek_values[i].skor_index : '-';
          aspekColumns += `<td>${aspekValue}</td>`;
        }
      } else {
        aspekColumns = '<td>-</td><td>-</td><td>-</td>';
      }

      tbody += `
                <tr>
                    <td>${index + 1}</td>
                    <td>${opd.nama_opd}</td>
                    <td><strong>${opd.nilai_akhir}</strong></td>
                    <!--<td><span class="badge ${badgeClass}">${predikat}</span></td>-->
                    ${aspekColumns}
                    <td>
                        <button class="btn btn-sm btn-info" onclick="showDetail('${opd.opd_id}', '${opd.nama_opd}')">
                            <i class="bi bi-eye"></i> Detail
                        </button>
                    </td>
                </tr>
            `;
    });
  }

  $('#table-body').html(tbody);
}

function updateChart(dataOpd) {
  if (dataOpd.length === 0) return;

  // Calculate average per aspek
  const aspekNames = [];
  const aspekAverages = [];

  if (dataOpd[0] && dataOpd[0].aspek_values) {
    dataOpd[0].aspek_values.forEach((aspek, index) => {
      aspekNames.push(aspek.nama_aspek);

      let total = 0;
      let count = 0;

      dataOpd.forEach(opd => {
        if (opd.aspek_values && opd.aspek_values[index]) {
          total += parseFloat(opd.aspek_values[index].skor_index);
          count++;
        }
      });

      aspekAverages.push(count > 0 ? (total / count).toFixed(2) : 0);
    });
  }

  const ctx = document.getElementById('reportChart');

  if (reportChart) {
    reportChart.destroy();
  }

  reportChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: aspekNames,
      datasets: [{
        label: 'Rata-rata Index per Aspek',
        data: aspekAverages,
        backgroundColor: [
          'rgba(54, 162, 235, 0.5)',
          'rgba(75, 192, 192, 0.5)',
          'rgba(153, 102, 255, 0.5)',
          'rgba(255, 99, 132, 0.5)',
          'rgba(255, 159, 64, 0.5)'
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 99, 132, 1)',
          'rgba(255, 159, 64, 1)'
        ],
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

function showDetail(opdId, namaOpd) {
  $('#modal-instansi-name').text(namaOpd);

  $.ajax({
    url: '<?= base_url('dashboard/report/getNilaiAspekDetailed') ?>',
    method: 'GET',
    data: {
      tahun: tahun,
      opd_id: opdId
    },
    dataType: 'json',
    success: function(response) {
      if (response.success == 1 && response.dt) {
        const data = response.dt[0]; // Get first OPD data
        $('#btn-pdfOpd').data('opd_id', opdId);
        let html = '';

        // Loop through instrumen (RB General & Tematik)
        data.instrumen.forEach((instrumen, idxInstrumen) => {
          html += `
            <div class="mb-4">
              <h5 class="fw-bold border-bottom pb-2">
                ${instrumen.nums}. ${instrumen.nama}
                <span class="float-end">Nilai: ${instrumen.nilai.toFixed(2)}</span>
              </h5>

              <div class="ms-4">
          `;

          // Loop through aspek
          instrumen.aspek.forEach((aspek, idxAspek) => {
            html += `
              <div class="mb-3">
                <h6 class="fw-bold">
                  ${instrumen.nums}.${aspek.nums}. ${aspek.nama_aspek}
                  <span class="float-end">Nilai: ${aspek.nilai.toFixed(2)}</span>
                </h6>

                <div class="ms-4">
            `;

            // Sort sub_aspek by nums
            const sortedSubAspek = aspek.sub_aspek.sort((a, b) =>
              parseInt(a.nums) - parseInt(b.nums)
            );

            // Loop through sub_aspek
            sortedSubAspek.forEach((subAspek, idxSubAspek) => {
              html += `
                <div class="mb-3">
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold">${instrumen.nums}.${aspek.nums}.${subAspek.nums}. ${subAspek.nama_sub_aspek}</span>
                    <span>Nilai: ${subAspek.nilai.toFixed(2)}</span>
                  </div>

                  <div class="table-responsive mt-2">
                    <table class="table table-bordered table-striped table-sm">
                      <thead class="table-light">
                        <tr>
                          <th style="width: 50px">No</th>
                          <th>Indikator</th>
                          <th style="width: 100px">Nilai</th>
                          <th style="width: 150px">Status</th>
                          <th>Keterangan</th>
                          <th>Saran</th>
                        </tr>
                      </thead>
                      <tbody>
              `;

              // Sort sub_sub_aspek by nums
              const sortedSSA = subAspek.sub_sub_aspek.sort((a, b) => {
                const [aMain, aSub] = a.nums.split('.');
                const [bMain, bSub] = b.nums.split('.');
                return aMain === bMain ?
                  parseInt(aSub) - parseInt(bSub) :
                  parseInt(aMain) - parseInt(bMain);
              });

              // Loop through sub_sub_aspek
              sortedSSA.forEach((ssa, idxSSA) => {
                const status = ssa.aprove === null ?
                  '<span class="badge bg-warning">Pending</span>' :
                  ssa.aprove ?
                  '<span class="badge bg-success">Approved</span>' :
                  '<span class="badge bg-danger">Rejected</span>';

                html += `
                  <tr>
                    <td class="text-center">${ssa.nums}</td>
                    <td>${ssa.nama_sub_sub_aspek}</td>
                    <td class="text-center">${ssa.nilai}</td>
                    <td class="text-center">${status}</td>
                    <td>${ssa.ket || '-'}</td>
                    <td>${ssa.saran || '-'}</td>
                  </tr>
                `;
              });

              html += `
                      </tbody>
                    </table>
                  </div>
                </div>
              `;
            });

            html += `</div></div>`;
          });

          html += `</div></div>`;
        });

        $('#modal-detail-content').html(html);
      } else {
        $('#modal-detail-content').html('<div class="alert alert-warning">Data tidak ditemukan</div>');
      }
    },
    error: function(xhr, status, error) {
      console.error('Error loading aspek detail:', error);
      $('#modal-detail-content').html('<div class="alert alert-danger">Terjadi kesalahan saat memuat data</div>');
    }
  });

  $('#modalDetail').modal('show');
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

  // PERBAIKAN: Hilangkan && ekstra dalam URL
  const tahun = $('#filter-tahun').val();
  const url = `<?= base_url('dashboard/report/exportPdfOpd') ?>?tahun=${tahun}&opd_id=${opdId}`;

  // Optional: Tampilkan loading state
  const originalText = $('#btn-pdfOpd').html();
  $('#btn-pdfOpd').html('<i class="bi bi-hourglass-split"></i> Generating...');
  $('#btn-pdfOpd').prop('disabled', true);

  // Buka dalam tab baru
  window.open(url, '_blank');

  // Reset tombol setelah delay singkat
  setTimeout(() => {
    $('#btn-pdfOpd').html(originalText);
    $('#btn-pdfOpd').prop('disabled', false);
  }, 2000);
}

function showError(message) {
  // Reset to error state
  $('#total-instansi, #rata-rata-index, #nilai-tertinggi, #nilai-terendah').text('-');
  $('#table-body').html(`
        <tr>
            <td colspan="8" class="text-center text-danger">
                <i class="bi bi-exclamation-triangle"></i> ${message}
            </td>
        </tr>
    `);

  // Show toast or alert
  if (typeof Swal !== 'undefined') {
    Swal.fire('Error', message, 'error');
  } else {
    alert(message);
  }
}
</script>
<?= $this->endSection() ?>