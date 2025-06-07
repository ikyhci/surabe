<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.css">
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Tugas Penilaian Mandiri</h3>
    </div>
    <div class="page-content">
              <!--  -->
      <div class="card">
       <!--  <div class="card-header">
          <h4>Profile Visit</h4>
        </div> -->
        <div class="card-body">
            <div class="form-group">
           
                  <select class="choices form-select" id="pilih-tahun">
                      <option value="" selected disabled>-- Pilih Tahun Form --</option>
                      <?php 

                      foreach ($thn as $key ): 
                        ?>

                        <option value="<?=$key;?>"><?=$key;?></option>
                      <?php endforeach ?>
                  </select>
                </div>   
            <!-- Data Table  -->
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Tahun</th>
                    <th>Nama Form</th>
                    <!-- <th>Tahap Form</th> -->
                    <th>Batas Waktu</th>
                    <th>Kemajuan</th>
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
<!-- popup -->
<?= $this->include('Pages/user/popup') ?>
<script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/choices.js/choices.min.js"></script>
    <script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/dataTables/dataTables.min.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.min.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/pages/user_mandiri.js"></script>

<?= $this->endSection() ?>