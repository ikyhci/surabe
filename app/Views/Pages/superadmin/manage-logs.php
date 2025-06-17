<?php $this->extend('Layouts/dashboard'); ?>

<!-- section style -->
<?php $this->section('style'); ?>

<style {csp-style-nonce}>
  /* Add your style here */
</style>
<?php $this->endSection(); ?>

<?php $this->section('content'); ?>


log konten t



<?php $this->endSection(); ?>

<?php $this->section('script'); ?>

<link {csp-style-nonce} rel="stylesheet" href="/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="/assets/vendors/dataTables/dataTables.min.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">

  $(document).ready(function() {
    
  });



</script>
<?php $this->endSection(); ?>