<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Blank Page</h3>
    </div>
    <div class="page-content">
      <section class="row">
        
      </section>
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
    <script src="assets/vendors/apexcharts/apexcharts.js"></script>
    <script src="assets/js/pages/dashboard.js"></script>
<?= $this->endSection() ?>