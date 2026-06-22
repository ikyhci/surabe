<?php

/** @var array|object $opd */
/** @var string $idx */
/** @var array|object $dt */
/** @var array|object $aspeks */
/** @var array|object $radarLabels */
/** @var string $title */
/** @var array|object $forms */
/** @var array|object $form */
/** @var string $uname */
/** @var string $usr */
/** @var string $token */
?>

<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
<style {csp-style-nonce}>
  .verticaltext {
    writing-mode: vertical-rl;
    transform: rotate(180deg);
    white-space: normal;
    height: 200px;
  }

  .col-nilai {
    width: 100px;
  }

  .loading {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
  }
</style>
<?= $this->endSection() ?>

<?= $this->section('content') ?>
<!-- Content -->
<div class="page-heading">
  <h3>Dashboard Soal</h3>
</div>
<div class="page-content">
  <section class="row">
    <div class="col-12 col-lg-9">
      <div class="row">
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Aspek</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Sub Aspek</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Sub Sub Aspek</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Indikator</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Parameter</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-6 col-lg-4 col-md-6">
          <div class="card">
            <div class="card-body px-3 py-4-5">
              <div class="row">
                <div class="col-md-4">
                  <div class="stats-icon blue">
                    <i class="iconly-boldBookmark"></i>
                  </div>
                </div>
                <div class="col-md-8">
                  <h6 class="text-muted font-semibold">Bukti Dukung</h6>
                  <h6 class="font-extrabold mb-0">0</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <div class="col-12 col-lg-3">
      <div class="card">
        <div class="card-header d-flex justify-content-end">
          <button type="button" class="btn btn-outline-primary btn-sm profil-btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear"
              viewBox="0 0 16 16">
              <path
                d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0">
              </path>
              <path
                d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z">
              </path>
            </svg>
          </button>
        </div>
        <div class="card-body py-4 px-5">
          <div class="d-flex align-items-center">
            <div class="avatar avatar-xl">
              <img src="assets/images/faces/1.jpg" alt="Face 1">
            </div>
            <div class="ms-3 name">
              <h5 class="font-bold"><?= $uname; ?></h5>
              <h6 class="text-muted mb-0"><?= $usr; ?></h6>
            </div>
          </div>
        </div>
      </div>


    </div>

  </section>

  <!-- === SECTION BARU: Ringkasan & Grafik === -->
  <section class="row mt-4">
    <div class="col-12 col-lg-4">
      <div class="card">
        <div class="card-header">
          <h4>Ringkasan Evaluasi</h4>
        </div>
        <div class="card-body">
          <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between">
              <span>Total Instansi</span> <strong id="total-instansi">0</strong>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Rata-rata Indeks</span> <strong id="rata-rata">0</strong>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Nilai Tertinggi</span>
              <span class="text-success fw-bold">
                <span id="opd-tertinggi">-</span> (<span id="nilai-tertinggi">0</span>)
              </span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Nilai Terendah</span>
              <span class="text-danger fw-bold">
                <span id="opd-terendah">-</span> (<span id="nilai-terendah">0</span>)
              </span>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="col-12 col-lg-8">
      <div class="card">
        <div class="card-header">
          <h4>Rata-rata Nilai per Aspek</h4>
        </div>
        <div class="card-body">
          <canvas id="chartAspek"></canvas>
        </div>
      </div>
    </div>
  </section>


  <section class="row">
    <div class="col-12">
      <div class="card">
        <div class="card-header">
          <h4>Capaian OPD</h4>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <div class="loading"></div>
            <table id="penilaianOpd">
              <thead class="text-center">
                <tr>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
          <!-- <div id="chart-profile-visit"></div> -->
        </div>
      </div>
    </div>
  </section>
</div>


<?= $this->endSection() ?>

<?= $this->section('script') ?>

<link {csp-style-nonce} rel="stylesheet" href="/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="/assets/vendors/dataTables/dataTables.min.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>
<script {csp-script-nonce} src="<?php echo base_url(); ?>assets/js/pages/profil.js"></script>
<script {csp-script-nonce} src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<?= $this->include('Pages/profil') ?>

<script {csp-script-nonce} type="text/javascript">
  let csrf_hash = "<?= csrf_hash() ?>";

  $(document).ready(function() {
    // tampilkan loading
    loading('.loading', 'show');

    $.ajax({
      url: "<?= base_url('dashboard/report/getEvaluasiLengkap?tahun=2025') ?>",
      type: "GET",
      success: function(response) {
        csrf_hash = response.token_crs;
        loading('.loading', 'hide');

        const ringkasan = response.dt.ringkasan;
        const opdList = response.dt.data_opd;

        // === UPDATE CARD DI ATAS (OPSIONAL) ===
        $('.stats-icon i').first().closest('.card-body').find('h6.font-extrabold').text(ringkasan
          .total_instansi);

        // === SECTION RINGKASAN EVALUASI ===
        $('#total-instansi').text(ringkasan.total_instansi);
        $('#rata-rata').text(ringkasan.rata_rata_index.toFixed(2));
        $('#opd-tertinggi').text(ringkasan.instansi_tertinggi.nama_opd);
        $('#nilai-tertinggi').text(ringkasan.instansi_tertinggi.capaian.toFixed(2));
        $('#opd-terendah').text(ringkasan.instansi_terendah.nama_opd);
        $('#nilai-terendah').text(ringkasan.instansi_terendah.capaian.toFixed(2));

        // === BUAT TABEL CAPAIAN OPD ===
        let tableHeader = $('#penilaianOpd thead tr');
        tableHeader.empty();
        tableHeader.append('<th class="text-center col-nilai">No</th>');
        tableHeader.append('<th>Nama OPD</th>');
        tableHeader.append('<th class="text-center">Nilai Akhir</th>');

        let tableBody = $('#penilaianOpd tbody');
        tableBody.empty();

        opdList.sort((a, b) => b.nilai_akhir - a.nilai_akhir);

        $.each(opdList, function(index, item) {
          let row = `
      <tr>
        <td class="text-center">${index + 1}</td>
        <td>${item.nama_opd}</td>
        <td class="text-center fw-bold">${item.nilai_akhir.toFixed(2)}</td>
      </tr>`;
          tableBody.append(row);
        });

        $("#penilaianOpd").addClass('table table-hover table-bordered').DataTable({
          order: [
            [2, "desc"]
          ],
          pageLength: 10
        });

        // === BUAT DATA UNTUK CHART PER ASPEK ===
        const aspekList = {};
        opdList.forEach(opd => {
          opd.aspek_values.forEach(aspek => {
            if (!aspekList[aspek.nama_aspek]) aspekList[aspek.nama_aspek] = [];
            aspekList[aspek.nama_aspek].push(aspek.skor_index);
          });
        });

        const aspekLabels = Object.keys(aspekList);
        const aspekValues = aspekLabels.map(label => {
          const scores = aspekList[label];
          const avg = scores.reduce((a, b) => a + b, 0) / scores.length;
          return avg;
        });

        // === CHART: RATA-RATA NILAI PER ASPEK ===
        const ctx = document.getElementById('chartAspek').getContext('2d');
        new Chart(ctx, {
          type: 'bar',
          data: {
            labels: aspekLabels,
            datasets: [{
              label: 'Rata-rata Skor',
              data: aspekValues,
              backgroundColor: 'rgba(54, 162, 235, 0.7)',
              borderColor: 'rgba(54, 162, 235, 1)',
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
      },
      error: function(xhr, status, error) {
        loading('.loading', 'hide');
        console.error("AJAX Error: ", status, error);
        Swal.fire("Error", "Gagal memuat data evaluasi lengkap", "error");
      }
    });
  });

  function loading(elTarget, toggle) {
    let eLoading = `<img src="assets/vendors/svg-loaders/audio.svg" class="me-4" style="width: 3rem" alt="audio">`;
    switch (toggle) {
      case 'show':
        $(elTarget).html(`<div class="d-flex justify-content-center align-items-center">${eLoading} Loading...</div>`);
        break;
      case 'hide':
        $(elTarget).html('');
        break;
    }
  }
</script>

<?= $this->endSection() ?>