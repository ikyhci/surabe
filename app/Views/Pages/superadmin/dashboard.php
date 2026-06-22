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
<style {csp-style-nonce}>
  .page-heading {
    margin-bottom: 1rem;
  }

  .info-cards .card {
    min-height: 120px;
  }

  .info-value {
    font-size: 1.6rem;
    font-weight: 700;
  }

  .verticaltext {
    writing-mode: vertical-rl;
    transform: rotate(180deg);
    white-space: normal;
    height: 200px;
  }

  .loading {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
  }

  .canvas-wrap {
    height: 320px;
  }

  .legend-columns {
    column-count: 3;
    column-gap: 14px;
    font-size: 0.75rem;
    /* PERKECIL UKURAN TEKS */
    margin-top: 10px;
  }

  .legend-columns div {
    break-inside: avoid;
    margin-bottom: 4px;
    /* rapikan jarak antar baris */
    display: flex;
    align-items: center;
  }

  .legend-columns span {
    width: 10px;
    /* perkecil icon warna */
    height: 10px;
    display: inline-block;
    margin-right: 5px;
    border-radius: 3px;
  }

  .canvas-wrap {
    height: 320px;
    /* tetap */
  }

  .card-body {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
</style>
<?= $this->endSection() ?>

<?= $this->section('content') ?>

<div class="page-heading">
  <h3>Dashboard Evaluasi Kinerja OPD</h3>
</div>

<div class="page-content">

  <!-- ===== RINGKASAN CARDS ===== -->

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


  <!-- ===== CHART: Distribusi & Aspek ===== -->
  <section class="row mt-3 align-items-stretch">
    <div class="col-12 col-lg-6 d-flex">
      <div class="card h-100 w-100">
        <div class="card-header">
          <h4>Distribusi Kategori Kinerja</h4>
        </div>
        <div class="card-body">
          <div class="canvas-wrap">
            <canvas id="chartDistribusi"></canvas>
          </div>
          <div id="legend-distribusi" class="legend-columns"></div>
        </div>
      </div>
    </div>

    <div class="col-12 col-lg-6 d-flex">
      <div class="card h-100 w-100">
        <div class="card-header">
          <h4>Rata-rata Nilai per Aspek</h4>
        </div>
        <div class="card-body">
          <div class="canvas-wrap">
            <canvas id="chartAspekAvg"></canvas>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ===== CHART: Top10 & Trend ===== -->
  <section class="row mt-3">
    <div class="col-12 col-lg-6">
      <div class="card">
        <div class="card-header">
          <h4>Top 10 OPD</h4>
        </div>
        <div class="card-body">
          <div class="canvas-wrap"><canvas id="chartTop10"></canvas></div>
        </div>
      </div>
    </div>

    <div class="col-12 col-lg-6">
      <div class="card">
        <div class="card-header">
          <h4>Tren Rata-rata Indeks per Tahun</h4>
        </div>
        <div class="card-body">
          <div class="canvas-wrap"><canvas id="chartTrend"></canvas></div>
        </div>
      </div>
    </div>
  </section>


  <!-- ===== TABEL OPD ===== -->
  <section class="row mt-3">
    <div class="col-12">
      <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
          <h4>Peringkat & Capaian OPD</h4>
          <select id="select-year" class="form-select form-select-sm" style="width:120px;"></select>
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <div class="loading" id="table-loading"></div>
            <table id="table-opd" class="table table-hover table-bordered">
              <thead class="text-center">
                <tr>
                  <th>No</th>
                  <th>Nama OPD</th>
                  <th>Singkatan</th>
                  <th>Nilai Akhir</th>
                </tr>
              </thead>
              <tbody></tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </section>

</div>

<?= $this->endSection() ?>


<?= $this->section('script') ?>
<link {csp-style-nonce} rel="stylesheet" href="/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="/assets/vendors/dataTables/dataTables.min.js"></script>
<script {csp-script-nonce} src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script {csp-script-nonce}>
  const API_BASE = "<?= base_url('dashboard/report/getEvaluasiLengkap') ?>";
  let charts = {};
  let dataTable;

  document.addEventListener("DOMContentLoaded", () => {
    initYears();
    fetchAndRender();
  });

  function initYears() {
    const select = document.getElementById("select-year");
    const now = new Date().getFullYear();
    for (let y = now; y >= now - 5; y--) {
      const opt = document.createElement("option");
      opt.value = y;
      opt.textContent = y;
      if (y === now) opt.selected = true;
      select.appendChild(opt);
    }
    select.addEventListener("change", fetchAndRender);
  }

  async function fetchAndRender() {
    const tahun = document.getElementById("select-year").value;
    loading("#table-loading", true);
    try {
      const res = await fetch(`${API_BASE}?tahun=${tahun}`);
      const json = await res.json();
      const ringkasan = json.dt?.ringkasan ?? {};
      const opdList = json.dt?.data_opd ?? [];

      updateCards(ringkasan);
      renderTable(opdList);
      renderDistribusi(opdList);
      renderAspekAvg(opdList);
      renderTop10(opdList);
      renderTrend(tahun);

    } catch (e) {
      console.error("Fetch error:", e);
    } finally {
      loading("#table-loading", false);
    }
  }

  function setText(id, val) {
    const el = document.getElementById(id);
    if (el) el.innerText = val;
  }

  function updateCards(r) {
    setText("card-total-instansi", r.total_instansi ?? 0);
    setText("card-rerata", (r.rata_rata_index ?? 0).toFixed(2));
    setText("card-tertinggi", r.tertinggi?.nama_opd ?? "-");
    setText("card-tertinggi-val", r.tertinggi?.nilai?.toFixed(2) ?? "");
    setText("card-terendah", r.terendah?.nama_opd ?? "-");
    setText("card-terendah-val", r.terendah?.nilai?.toFixed(2) ?? "");
  }

  function renderTable(data) {
    if (dataTable) dataTable.destroy();
    const tbody = document.querySelector("#table-opd tbody");
    tbody.innerHTML = "";

    data.sort((a, b) => b.opd.nilai - a.opd.nilai);

    data.forEach((d, i) => {
      tbody.innerHTML += `
      <tr>
        <td>${i + 1}</td>
        <td>${d.opd.nama_opd}</td>
        <td>${d.opd.singkatan ?? ""}</td>
        <td class="text-center">${(d.opd.nilai ?? 0).toFixed(2)}</td>
      </tr>
    `;
    });

    dataTable = $("#table-opd").DataTable({
      pageLength: 10,
      order: [
        [3, "desc"]
      ]
    });
  }

  function renderDistribusi(list) {
    const cat = {
      D: 0,
      C: 0,
      CC: 0,
      B: 0,
      BB: 0,
      A: 0,
      AA: 0
    };

    list.forEach(o => {
      const v = o.opd.nilai ?? 0;
      if (v <= 30) cat.D++;
      else if (v <= 50) cat.C++;
      else if (v <= 60) cat.CC++;
      else if (v <= 70) cat.B++;
      else if (v <= 80) cat.BB++;
      else if (v <= 90) cat.A++;
      else if (v <= 100) cat.AA++;
    });

    const labels = [
      "0–30 Sangat Buruk",
      ">30–50 Buruk",
      ">50–60 Cukup",
      ">60–70 Cukup Baik",
      ">70–80 Baik",
      ">80–90 Sangat Baik",
      ">90–100 Istimewa"
    ];

    const values = [cat.D, cat.C, cat.CC, cat.B, cat.BB, cat.A, cat.AA];
    const colors = ["#dc3545", "#ff6f6f", "#ffc107", "#ffe17a", "#0d6efd", "#198754", "#009688"];

    const ctx = document.getElementById("chartDistribusi").getContext("2d");

    charts.distribusi?.destroy();
    charts.distribusi = new Chart(ctx, {
      type: "pie",
      data: {
        labels,
        datasets: [{
          data: values,
          backgroundColor: colors
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
          }
        }
      }
    });

    // Buat legend 3 kolom
    const legendContainer = document.getElementById("legend-distribusi");
    legendContainer.innerHTML = labels.map((lbl, i) => `
      <div><span style="background:${colors[i]}"></span>${lbl} : <b>${values[i]}</b></div>
  `).join("");
  }

  function renderAspekAvg(list) {
    if (!list.length) return;

    const labels = list[0].radarLabels ?? [];
    const totals = Array(labels.length).fill(0);
    const counts = Array(labels.length).fill(0);

    list.forEach(o => {
      (o.radarData ?? []).forEach((v, i) => {
        totals[i] += parseFloat(v);
        counts[i]++;
      });
    });

    const avg = totals.map((t, i) => (t / (counts[i] || 1)).toFixed(2));

    const ctx = document.getElementById("chartAspekAvg").getContext("2d");
    charts.aspek?.destroy();
    charts.aspek = new Chart(ctx, {
      type: "bar",
      data: {
        labels,
        datasets: [{
          label: "Rata-rata Per Aspek",
          data: avg
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true,
            max: 100
          }
        }
      }
    });
  }

  function renderTop10(list) {
    const sorted = list.slice().sort((a, b) => b.opd.nilai - a.opd.nilai).slice(0, 10);

    const ctx = document.getElementById("chartTop10").getContext("2d");
    charts.top10?.destroy();

    charts.top10 = new Chart(ctx, {
      type: "bar",
      data: {
        labels: sorted.map(o => o.opd.singkatan),
        datasets: [{
          label: "Nilai",
          data: sorted.map(o => o.opd.nilai)
        }]
      },
      options: {
        indexAxis: "y",
        scales: {
          x: {
            beginAtZero: true,
            max: 100
          }
        }
      }
    });
  }

  async function renderTrend(currentYear) {
    const years = [currentYear - 2, currentYear - 1, currentYear];
    const dataArr = [];

    for (const y of years) {
      const res = await fetch(`${API_BASE}?tahun=${y}`).then(r => r.json()).catch(() => null);
      dataArr.push(res?.dt?.ringkasan?.rata_rata_index ?? 0);
    }

    const ctx = document.getElementById("chartTrend").getContext("2d");
    charts.trend?.destroy();
    charts.trend = new Chart(ctx, {
      type: "line",
      data: {
        labels: years,
        datasets: [{
          label: "Rata-rata",
          data: dataArr
        }]
      }
    });
  }

  function loading(sel, show) {
    const el = document.querySelector(sel);
    if (!el) return;
    el.innerHTML = show ? `<img src="/assets/vendors/svg-loaders/audio.svg" style="width:3rem" alt="loading">` : "";
  }
</script>
<?= $this->endSection() ?>