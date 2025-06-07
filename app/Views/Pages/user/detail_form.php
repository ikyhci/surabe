<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
   
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.bootstrap5.min.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.css">
   

<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Tugas Penilaian Mandiri</h3>
    </div>
    <div class="page-content">
              <!--  -->
      <div class="card">

        <div class="card-body">
          
          <table class="table  mb-0">
            <tbody>
              <tr>
                <td>Detail Form</td>
                <td class="text-end">
                  <a href="<?php echo base_url(); ?>dashboard/penilaian-mandiri" class="btn btn-primary" id="back"> Kembali</a>
                </td>
              </tr>
              <tr>
                <td>Tahun</td>
                <td>: <?= $dt->tahun;?></td>
              </tr>
              <tr>
                <td>Nama Form</td>
                <td>: <?= $dt->nama;?></td>
              </tr>
              <tr>
                <td>Deskripsi</td>
                <td>: <?= $dt->deskripsi;?></td>
              </tr>
              <tr>
                <td>Status Evaluasi</td>
                <td>: <?= $dt->evaluasi;?></td>
              </tr>
              <tr>
                <td>Batas Waktu</td>
                <td>: <?= date_format(date_create($dt->bataswaktu),"d - m - Y");?></td>
              </tr>
            </tbody>
          </table>
          <br>
             
            <!-- Data Table  -->
            <p>Data Indikator</p>
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Nama Indikator</th>
                    <th>Aksi</th>
                  </tr>
                  
                </thead>
              </table>
            </div>

            
            <!--  -->
      </div>
     
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<input type="hidden" name="form" id="form" value="<?= $idx;?>">
<!-- popup -->
<?= $this->include('Pages/user/popup') ?>

    <script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/dataTables/dataTables.min.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/dataTables.rowGroup.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/rowGroup.dataTables.js"></script>
     <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.min.js"></script>
     <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/pages/user_detail_form.js"></script>
    
    

    
<?= $this->endSection() ?>