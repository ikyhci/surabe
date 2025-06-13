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
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
                            <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0"></path>
                            <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z"></path>
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
<script {csp-script-nonce} src="<?php echo base_url();?>assets/js/pages/profil.js"></script>

<?= $this->include('Pages/profil') ?>

<script {csp-script-nonce} type="text/javascript" >
    let csrf_hash = "<?= csrf_hash() ?>";
    $(document).ready(function() {
        $.ajax({
            url: "<?= base_url('api/capaian-opd') ?>",
            type: "GET",
            headers: { "Authorization": "Bearer <?= $token ?>" },
            success: function(response) {
                csrf_hash=response.token_crs;
                loading('.loading', 'hide');
                let dt = response.dt;
                
                let tableHeader = $('#penilaianOpd thead tr');
                tableHeader.empty();
                tableHeader.append('<th class="col-nilai" >No</th>');
                tableHeader.append('<th>OPD</th>');
                $.each(dt[0].domains, function(index, item) {
                    tableHeader.append(`<th class="verticaltext col-nilai" >${item.nama_aspek}</th>`);``
                });
                tableHeader.append('<th>Capaian</th>');
                let tableBody = $('#penilaianOpd tbody');
                tableBody.empty();
                $.each(dt, function(index, item) {
                    let capaian = 0;
                    let row = `<tr>
                        <td>${index + 1}</td>
                        <td>${item.singkatan}</td>`;
                    $.each(item.domains, function(index, d) {
                        row += `<td class="text-center">${d.nilai}</td>`;
                        capaian += d;
                    });                    
                    row += `<td class="text-center">${item.nilai}</td></tr>`;
                    tableBody.append(row);
                });
                
                let table = $("#penilaianOpd")
                table.addClass('table table-hover table-bordered');
                table.DataTable();
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error: ", status, error);
            }
        });
    });

    function loading(elTarget, togle) {
        let eLoading = `<img src="assets/vendors/svg-loaders/audio.svg" class="me-4" style="width: 3rem" alt="audio">`;
        switch (togle) {
            case 'show':
                $(elTarget).append(
                    `<div class="d-flex justify-content-center align-items-center">${eLoading} Loading...</div>`
                );
                break;
            case 'hide':
                $(elTarget).html('');
                break;
        }
    }
    loading('.loading', 'show');
</script>

<?= $this->endSection() ?>