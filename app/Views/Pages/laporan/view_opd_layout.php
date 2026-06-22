<?php

/** @var array|object $opd */
/** @var string $tahun */
/** @var array|object $allAspek */
/** @var array|object $radarData */
/** @var array|object $radarLabels */
/** @var string $title */
?>

<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('styles') ?>

<!-- Bootstrap CSS -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"> -->

<!-- Bootstrap Icons -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"> -->

<style>
  body {
    background-color: #f8f9fa;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }

  .instrumen-header {
    position: relative;
    /* penting agar posisi absolut berpatokan di sini */
    background: linear-gradient(to right, #6a7df0, #7453c9);
    padding: 20px;
    border-radius: 10px;
    color: white;
  }

  .nilai-kanan {
    position: absolute;
    right: 20px;
    /* jarak dari kanan */
    top: 50%;
    /* vertikal tengah */
    transform: translateY(-50%);
    /* bener-bener tengah */
    font-size: 3em;
    /* angka besar */
    font-weight: bold;
    opacity: 0.2;
    /* transparan biar gak ganggu teks utama */
  }

  .container-report {
    background-color: white;
    padding: 30px;
    margin: 20px auto;
    max-width: 1400px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
  }

  .header-section {
    text-align: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 3px solid #0d6efd;
  }

  .header-section h1 {
    color: #0d6efd;
    font-weight: bold;
    margin-bottom: 10px;
  }

  .header-section h2 {
    color: #6c757d;
    font-size: 1.5rem;
  }

  .info-box {
    background-color: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
  }

  .info-box table {
    width: 100%;
  }

  .info-box td {
    padding: 8px;
  }

  .info-box td:first-child {
    font-weight: bold;
    width: 200px;
  }

  .summary-section {
    margin-bottom: 40px;
  }

  .summary-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
    margin-bottom: 30px;
  }

  @media (max-width: 992px) {
    .summary-grid {
      grid-template-columns: 1fr;
    }
  }

  .card-custom {
    border: 1px solid #dee2e6;
    border-radius: 8px;
    overflow: hidden;
  }

  .card-custom-header {
    background-color: #0d6efd;
    color: white;
    padding: 15px;
    font-weight: bold;
    text-align: center;
  }

  .card-custom-body {
    padding: 20px;
  }

  .table-aspek {
    font-size: 0.9rem;
  }

  .table-aspek th {
    background-color: #e9ecef;
    font-weight: bold;
    text-align: center;
  }

  .note-box {
    background-color: #fff3cd;
    border-left: 4px solid #ffc107;
    padding: 15px;
    margin-top: 20px;
    border-radius: 4px;
  }

  .note-box strong {
    color: #856404;
  }

  .instrumen-section {
    margin-top: 50px;
    page-break-before: always;
  }

  .instrumen-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 20px;
  }

  .instrumen-header h3 {
    color: white;
  }

  .aspek-header {
    background-color: #e9ecef;
    padding: 15px;
    border-radius: 8px;
    margin-top: 30px;
    margin-bottom: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .sub-aspek-header {
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

  .table-detail {
    font-size: 0.85rem;
  }

  .table-detail th {
    background-color: #f8f9fa;
    font-weight: bold;
    text-align: center;
    vertical-align: middle;
  }

  .table-detail td {
    vertical-align: middle;
  }

  .status-badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: bold;
  }

  .status-disetujui {
    background-color: #d1e7dd;
    color: #0f5132;
  }

  .status-ditolak {
    background-color: #f8d7da;
    color: #842029;
  }

  .status-pending {
    background-color: #fff3cd;
    color: #856404;
  }

  .btn-actions {
    margin-bottom: 20px;
    display: flex;
    gap: 10px;
  }

  .footer-section {
    margin-top: 50px;
    padding-top: 20px;
    border-top: 2px solid #dee2e6;
    font-size: 0.9rem;
    color: #6c757d;
  }

  @media print {
    .btn-actions {
      display: none;
    }

    body {
      background-color: white;
    }

    .container-report {
      box-shadow: none;
      max-width: 100%;
    }

    .instrumen-section {
      page-break-before: always;
    }
  }
</style>
<?= $this->endSection() ?>

<?= $this->section('content') ?>

<div class="container-report">
  <!-- Action Buttons -->
  <div class="btn-actions">
    <!-- <button onclick="window.print()" class="btn btn-primary">
        <i class="bi bi-printer"></i> Cetak / Print
      </button> -->
    <a href="<?= base_url('dashboard/report/exportPdfOpd?tahun=' . $tahun . '&opd_id=' . $opd->id) ?>"
      class="btn btn-danger">
      <i class="bi bi-file-pdf"></i> Export PDF
    </a>
    <button onclick="window.history.back()" class="btn btn-secondary">
      <i class="bi bi-arrow-left"></i> Kembali
    </button>
  </div>

  <!-- Header -->
  <div class="header-section">
    <h1>Laporan Hasil Evaluasi Indeks Reformasi Birokrasi</h1>
    <h1>Pemerintah Daerah</h1>
    <h2>TAHUN <?= esc($tahun) ?></h2>
  </div>

  <!-- OPD Information -->
  <div class="info-box">
    <h4 class="mb-3">INFORMASI PERANGKAT DAERAH</h4>
    <table>
      <tr>
        <td>Nama OPD</td>
        <td>: <?= esc($opd->nama_opd) ?></td>
      </tr>
      <tr>
        <td>Singkatan</td>
        <td>: <?= esc($opd->singkatan) ?></td>
      </tr>
      <tr>
        <td>Nilai Akhir</td>
        <td>: <strong class="text-primary"><?= number_format($opd->nilai, 2) ?></strong></td>
      </tr>
    </table>
  </div>

  <!-- Summary Section -->
  <div class="summary-section">
    <h4 class="mb-4">RINGKASAN EVALUASI</h4>

    <div class="summary-grid">
      <!-- Table of Aspek Values -->
      <div class="card-custom">
        <div class="card-custom-header">
          Rekapitulasi Nilai Aspek
        </div>
        <div class="card-custom-body">
          <table class="table table-bordered table-aspek table-hover">
            <thead>
              <tr>
                <th style="width: 8%">No</th>
                <th style="width: 15%">Kode</th>
                <th style="width: 57%">Nama Aspek</th>
                <th style="width: 20%">Nilai</th>
              </tr>
            </thead>
            <tbody>
              <?php $no = 1;
              foreach ($allAspek as $aspekItem): ?>
                <tr>
                  <td class="text-center"><?= $no++ ?></td>
                  <td class="text-center">
                    <?= esc($aspekItem->instrumen_nums . '.' . $aspekItem->aspek_nums) ?>
                  </td>
                  <td><?= esc($aspekItem->nama_aspek) ?></td>
                  <td class="text-center">
                    <strong><?= number_format($aspekItem->nilai, 2) ?></strong>
                  </td>
                </tr>
              <?php endforeach; ?>
            </tbody>
          </table>

          <div class="note-box">
            <strong>NB:</strong><br>
            I.A - I.C = RB General Perangkat Daerah<br>
            II.A - II.B = RB Tematik Perangkat Daerah<br>
            Bobot RB General = 65<br>
            Bobot RB Tematik = 35
          </div>
        </div>
      </div>

      <!-- Radar Chart -->
      <div class="card-custom">
        <div class="card-custom-header">
          Diagram Radar - Nilai Aspek
        </div>
        <div class="card-custom-body">
          <canvas id="radarChart" style="max-height: 400px;"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Detail Instrumen -->
  <?php foreach ($opd->instrumen as $instrumen): ?>
    <div class="instrumen-section">
      <div class="instrumen-header">
        <h3 class="mb-2"><?= esc($instrumen->nums . '. ' . strtoupper($instrumen->nama)) ?></h3>
        <p class="mb-0">Nilai: <strong><?= number_format($instrumen->nilai, 2) ?></strong></p>
        <span class="nilai-kanan"><?= number_format($instrumen->nilai, 2) ?></span>
      </div>

      <?php foreach ($instrumen->aspek as $aspek): ?>
        <div class="aspek-section">
          <div class="aspek-header">
            <div>
              <strong><?= esc($instrumen->nums . '.' . $aspek->nums . ' ' . $aspek->nama_aspek) ?></strong>
            </div>
            <div>
              Nilai: <strong class="text-primary"><?= number_format($aspek->nilai, 2) ?></strong>
            </div>
          </div>

          <?php
          $subAspeks = (array)$aspek->sub_aspek;
          usort($subAspeks, function ($a, $b) {
            return $a->nums <=> $b->nums;
          });
          ?>

          <?php foreach ($subAspeks as $subAspek): ?>
            <div class="sub-aspek-section">
              <div class="sub-aspek-header">
                <div>
                  <strong><?= esc($instrumen->nums . '.' . $aspek->nums . '.' . $subAspek->nums . ' ' . $subAspek->nama_sub_aspek) ?></strong>
                </div>
                <div>
                  Nilai: <strong class="text-success"><?= number_format($subAspek->nilai, 2) ?></strong>
                </div>
              </div>

              <?php
              $subSubAspeks = (array)$subAspek->sub_sub_aspek;
              usort($subSubAspeks, function ($a, $b) {
                return $a->nums <=> $b->nums;
              });
              ?>

              <div class="table-responsive">
                <table class="table table-bordered table-detail table-striped">
                  <thead>
                    <tr>
                      <th style="width: 5%">No</th>
                      <th style="width: 19%">Indikator</th>
                      <th style="width: 8%">Bobot</th>
                      <th style="width: 8%">Nilai</th>
                      <th style="width: 10%">Status</th>
                      <th style="width: 25%">Keterangan</th>
                      <th style="width: 25%">Saran</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($subSubAspeks as $ssa): ?>
                      <tr>
                        <td class="text-center"><?= esc($ssa->nums) ?></td>
                        <td><?= esc($ssa->nama_sub_sub_aspek) ?></td>
                        <td class="text-center"><?= $ssa->bobot ?></td>
                        <td class="text-center">
                          <strong><?= number_format($ssa->nilai, 2) ?></strong>
                        <td class="text-center">
                          <?php
                          if ($ssa->aprove === 'yes') {
                            echo '<span class="status-badge status-disetujui">Disetujui</span>';
                          } elseif ($ssa->aprove === 'no') {
                            echo '<span class="status-badge status-ditolak">Ditolak</span>';
                          } else {
                            echo '<span class="status-badge status-pending">Pending</span>';
                          }
                          ?>
                        </td>
                        <td><?= shortTextWithTooltip($ssa->ket) ?></td>
                        <td><?= shortTextWithTooltip($ssa->saran) ?></td>
                        <td><button class="btn btn-sm btn-info detail-ssa" data-opdId="<?= $opd->id ?>"
                            data-idssa="<?= $ssa->id ?>" data-nmssa="<?= esc($ssa->nama_sub_sub_aspek) ?>"
                            data-bobotssa="<?= $ssa->bobot ?>">detail</button>
                        </td>
                        </td>
                      </tr>
                    <?php endforeach; ?>
                  </tbody>
                </table>
              </div>
            </div>
          <?php endforeach; ?>
        </div>
      <?php endforeach; ?>
    </div>
  <?php endforeach; ?>

  <!-- Footer -->
  <div class="footer-section">
    <p><strong>Laporan dibuat pada:</strong> <?= date('d/m/Y H:i:s') ?></p>
    <p><strong>Sistem:</strong> SURABE BERANI - Sistem Pengukuran Reformasi Birokrasi Elektronik Berintegritas dan
      Mandiri</p>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="detailSsaModal" tabindex="-1" aria-labelledby="detailSsaModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="detailSsaModalLabel">Detail SSA</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- Konten akan diisi via JS -->
        <table class="table table-bordered" id="detailSsaTable">
          <thead>
            <tr>
              <th>Indikator</th>
              <!-- <th>Max Point</th> -->
              <th>Nilai</th>
              <th>Status Persetujuan</th>
              <th>Keterangan</th>
              <th>Saran</th>
            </tr>
          </thead>
          <tbody>
            <!-- Data akan diinsert di sini -->
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
      </div>
    </div>
  </div>
</div>

<?= $this->endSection() ?>

<?= $this->section('script') ?>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<script>
  // Radar Chart
  const ctx = document.getElementById('radarChart').getContext('2d');
  const radarData = <?= $radarData ?>;
  const radarLabels = <?= $radarLabels ?>;

  new Chart(ctx, {
    type: 'radar',
    data: {
      labels: radarLabels,
      datasets: [{
        label: 'Nilai Aspek',
        data: radarData,
        backgroundColor: 'rgba(13, 110, 253, 0.2)',
        borderColor: 'rgba(13, 110, 253, 1)',
        borderWidth: 2,
        pointBackgroundColor: 'rgba(13, 110, 253, 1)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgba(13, 110, 253, 1)'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: true,
      scales: {
        r: {
          angleLines: {
            display: true
          },
          suggestedMin: 0,
          suggestedMax: Math.max(...radarData) * 1.2,
          ticks: {
            stepSize: Math.ceil(Math.max(...radarData) / 4)
          }
        }
      },
      plugins: {
        legend: {
          display: true,
          position: 'top'
        },
        tooltip: {
          enabled: true,
          callbacks: {
            label: function(context) {
              return context.dataset.label + ': ' + context.parsed.r.toFixed(2);
            }
          }
        }
      }
    }
  });

  let detailSsaBtn = $('.detail-ssa');

  detailSsaBtn.on('click', function() {
    let opdId = $(this).data('opdid');
    let nmSsa = $(this).data('nmssa');
    let idSsa = $(this).data('idssa');
    let bobotSsa = $(this).data('bobotssa');

    $('#detailSsaModalLabel').text("Detail " + nmSsa + " (bobot=" + bobotSsa + ")");
    fetch(`/dashboard/report/data-opd/detailSsa?opdId=${opdId}&idSsa=${idSsa}`)
      .then(response => response.json())
      .then(data => {
        // console.log(data);

        // Bersihkan tbody dulu
        let tbody = $('#detailSsaTable tbody');
        tbody.empty();

        // Loop data dan buat baris tabel
        data.forEach(item => {
          let row = `
                    <tr>
                        <td>${item.indikator}</td>
                        
                        <td>${item.nilai_indikator}</td>
                        <td>${item.aprove_status ?? '-'}</td>
                        <td>${item.keterangan ?? '-'}</td>
                        <td>${item.saran ?? '-'}</td>
                    </tr>
                `;
          tbody.append(row);
        });

        // Tampilkan modal
        let modal = new bootstrap.Modal(document.getElementById('detailSsaModal'));
        modal.show();
      })
      .catch(error => console.error('Error:', error));
  });
</script>
<?= $this->endSection() ?>