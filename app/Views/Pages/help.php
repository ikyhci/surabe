<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->



<?= $this->endSection() ?>

<?= $this->section('content') ?>
<!-- Content -->
<div class="page-heading">
    <h3>Help</h3>
</div>
<div class="page-content">
	 <section class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h4>Help </h4>
                </div>
                <div class="card-body">
                    <div id="chart-profile-visit">
                        <!-- Jika Mengalami Masalah silahkan hubungi <b>jimmy</b> komionfo: kontak person : <b>0822-5926-3752</b> <br>
                        atau AAn kominfo , kontak Person :  -->
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>


<?= $this->endSection() ?>

<?= $this->section('script') ?>
<!-- Script -->
<script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
<script {csp-script-nonce}  type="text/javascript">
    
</script>
<?= $this->endSection() ?>