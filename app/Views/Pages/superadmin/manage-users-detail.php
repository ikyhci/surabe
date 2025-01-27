<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('content') ?>

<div class="page-heading">
  <h3><?= $title; ?></h3>
</div>
<div class="page-content">
  <div class="card">
    <div class="card-header">
      <h6><?= $sub_title; ?></h6>
    </div>
    <div class="card-body">
      <form>
        <div class="form-group">
          <label for="uid">User ID</label>
          <input type="text" class="form-control" id="uid" value="<?= $user->uid; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="UserName">Username</label>
          <input type="text" class="form-control" id="UserName" value="<?= $user->UserName; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="FullName">Full Name</label>
          <input type="text" class="form-control" id="FullName" value="<?= $user->FullName; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="Phone">Phone</label>
          <input type="text" class="form-control" id="Phone" value="<?= $user->Phone; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="EmailAdds">Email</label>
          <input type="text" class="form-control" id="EmailAdds" value="<?= $user->EmailAdds; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="Create_at">Created At</label>
          <input type="text" class="form-control" id="Create_at" value="<?= $user->Create_at; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="RoleName">Role</label>
          <input type="text" class="form-control" id="RoleName" value="<?= $user->RoleName; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="nama_opd">Organization</label>
          <input type="text" class="form-control" id="nama_opd" value="<?= $user->nama_opd; ?>" <?= $readOnly? 'readonly' : '' ?>>
        </div>
        <br>
        <div class="col-sm-12 d-flex justify-content-end">
          <button type="submit" class="btn btn-primary float-right" <?= $readOnly? 'disabled' : '' ?>>Submit</button>
        </div>

      </form>
    </div>
  </div>
  <!--  -->
  <div class="card">

  </div>

  <!-- konten view di sini -->
  <?= $this->endSection() ?>


  <?= $this->section('script') ?>
  <!-- <script {csp-script-nonce}  src="https://cdn.jsdelivr.net/npm/apexcharts"></script> -->
  <!-- <script {csp-script-nonce} src="assets/vendors/apexcharts/apexcharts.js"></script> -->
  <!-- <script {csp-script-nonce} src="assets/js/pages/dashboard.js"></script> -->
  <!-- jquery -->


  <script {csp-script-nonce} type="text/javascript">

  </script>


  <?= $this->endSection() ?>