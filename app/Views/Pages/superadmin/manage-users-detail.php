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
          <input type="text" class="form-control" id="uid" value="<?= $user->uid; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="UserName">Username</label>
          <input type="text" class="form-control" id="UserName" value="<?= $user->UserName; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="FullName">Full Name</label>
          <input type="text" class="form-control" id="FullName" value="<?= $user->FullName; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="Phone">Phone</label>
          <input type="text" class="form-control" id="Phone" value="<?= $user->Phone; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="EmailAdds">Email</label>
          <input type="text" class="form-control" id="EmailAdds" value="<?= $user->EmailAdds; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="Create_at">Created At</label>
          <input type="text" class="form-control" id="Create_at" value="<?= $user->Create_at; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="RoleName">Role</label>
          <input type="text" class="form-control" id="RoleName" value="<?= $user->RoleName; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>
        <div class="form-group">
          <label for="nama_opd">Organization</label>
          <input type="text" class="form-control" id="nama_opd" value="<?= $user->nama_opd; ?>"
            <?= $readOnly ? 'readonly' : '' ?>>
        </div>

        <!-- Input untuk password baru -->
        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input type="password" class="form-control" id="newPassword" name="newPassword"
            placeholder="Enter new password" <?= $readOnly ? 'readonly' : '' ?>>
        </div>

        <!-- Input untuk verifikasi password -->
        <div class="form-group">
          <label for="confirmPassword">Confirm New Password</label>
          <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
            placeholder="Confirm new password" <?= $readOnly ? 'readonly' : '' ?>>
        </div>

        <br>
        <div class="col-sm-12 d-flex justify-content-end">
          <button type="submit" class="btn btn-primary float-right" <?= $readOnly ? 'disabled' : '' ?>>Submit</button>
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
  <script {csp-script-nonce} type="text/javascript">
  // Menunggu DOM siap
  document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector('form');
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const submitButton = document.querySelector('button[type="submit"]');

    form.addEventListener('submit', function(event) {
      // Mengecek apakah password baru dan konfirmasi password cocok
      if (newPassword.value !== confirmPassword.value) {
        event.preventDefault(); // Mencegah form disubmit
        alert("Password dan konfirmasi password tidak cocok. Silakan coba lagi.");
        confirmPassword.focus(); // Fokus ke konfirmasi password
        return false;
      }

      // Jika password sudah cocok, form dapat disubmit
      return true;
    });
  });
  </script>
  <?= $this->endSection() ?>