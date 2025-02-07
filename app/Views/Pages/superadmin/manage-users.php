<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('content') ?>

<div class="page-heading">
  <h3><?= $title; ?></h3>
</div>
<div class="page-content">
  <div class="card">
    <div class="card-header">
      <h6>Daftar User</h6>
    </div>
    <div class="card-body">
      <table id="table" class="table table-striped table-bordered">
        <thead>
          <tr>
            <th>ID</th>
            <th>Nama</th>
            <th>No HP</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Modal -->
  <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
    <div class="modal-dialog-centered modal-dialog modal-md " role="document">
      <div class="modal-content">
        <div class="modal-header bg-primary">
          <h5 class="modal-title white" id="userModalLabel">User Details</h5>
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        <form id="formDetail" method="POST">
          <div class="modal-body">
            <input type="hidden" id="<?= csrf_token() ?>" name="<?= csrf_token() ?>" value="<?= csrf_hash(); ?>">
            <div class="form-group">
              <label for="UserName">Username</label>
              <input type="text" class="form-control" id="UserName" name="UserName">
            </div>
            <div class="form-group">
              <label for="FullName">Full Name</label>
              <input type="text" class="form-control" id="FullName" name="FullName">
            </div>
            <div class="form-group">
              <label for="Phone">Phone</label>
              <input type="text" class="form-control" id="Phone" name="Phone">
            </div>
            <div class="form-group">
              <label for="EmailAdds">Email</label>
              <input type="text" class="form-control" id="EmailAdds" name="EmailAdds">
            </div>
            <div class="form-group">
              <label for="RoleName">Role</label>
              <select class="form-select" name="RoleName" id="RoleName"></select>
            </div>
            <div class="form-group">
              <label for="nama_opd">Organization</label>
              <select class="form-select" name="nama_opd" id="nama_opd"></select>
            </div>
            <div id="pwd">
              <div class="form-group">
                <label for="Password">Password</label>
                <input type="password" class="form-control" id="Password" name="Password">
              </div>
              <div class="form-group">
                <label for="ConfirmPassword">Confirm Password</label>
                <input type="password" class="form-control" id="ConfirmPassword" name="ConfirmPassword">
                <p><small class="text-danger" id="pwdValidation"></small></p>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <!-- <div class="col-sm-12 d-flex justify-content-end"> -->
            <button id="submit" class="btn btn-primary me-1 mb-1">Simpan</button>
            <!-- </div> -->

          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</div>

<?= $this->endSection() ?>

<?= $this->section('script') ?>
<script {csp-script-nonce} src="/assets/vendors/jquery/jquery.min.js"></script>
<link {csp-style-nonce} rel="stylesheet" href="/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="/assets/vendors/dataTables/dataTables.min.js"></script>

<link {csp-script-nonce} rel="stylesheet" href="/assets/vendors/choices.js/choices.min.css" />
<script {csp-script-nonce} src="/assets/vendors/choices.js/choices.min.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">
  const TOKEN = "<?= ($token) ? $token : "" ?>";
  $(document).ready(function() {

    setTimeout(function() {
      var searchBox = $('.dt-search');
      var addButton = $('<button>')
        .addClass('btn btn-primary ml-2')
        .text('Tambah')
        .attr('id', 'btn-tambah')
        .on('click', addUser);
      searchBox.after(addButton);
    }, 100);

    const roleSelect = new Choices('#RoleName', {
      placeholder: true,
      searchPlaceholderValue: 'Pilih Role',
      itemSelectText: '',
      shouldSort: false
    });

    const opdSelect = new Choices('#nama_opd', {
      placeholder: true,
      searchPlaceholderValue: 'Pilih Organization',
      itemSelectText: '',
      shouldSort: false
    });

    $.ajax({
      url: '/api/get-roles',
      method: 'GET',
      dataType: 'json',
      headers: {
        'Authorization': 'Bearer ' + TOKEN
      },
      success: function(response) {
        if (response.dt) {
          roleSelect.setValue(response.dt.map((dt) => {
            return {
              value: dt.RoleId,
              label: dt.RoleName
            }
          }));
        }
      },
      error: function() {
        console.log('Gagal mengambil data role');
      }
    });

    $.ajax({
      url: '/api/get-opd',
      method: 'GET',
      dataType: 'json',
      headers: {
        'Authorization': 'Bearer ' + TOKEN,
      },
      success: function(response) {
        if (response.dt) {
          opdSelect.setValue(response.dt.map((dt) => {
            return {
              value: dt.id,
              label: dt.nama_opd
            }
          }));
        }
      },
      error: function() {
        console.log('Gagal mengambil data organization');
      }
    });

    var table = $('#table').DataTable({
      "processing": false,
      "serverSide": false,
      "ajax": {
        "url": "<?= base_url('api/get-users') ?>",
        "type": "GET",
        "headers": {
          'Authorization': 'Bearer ' + TOKEN
        },
        "dataSrc": "dt"
      },
      "columns": [{
          "data": function(data) {
            return data.uid.substring(0, 10);
          }
        },
        {
          "data": "FullName"
        },
        {
          "data": "Phone"
        },
        {
          "data": "EmailAdds"
        },
        {
          "data": "RoleName"
        },
        {
          "data": function(data) {
            return `<button data-uid="${data.uid}" class="btnDetail btn btn-primary btn-sm">Detail</button>
                    <button data-uid="${data.uid}" class="btnDelete btn btn-danger btn-sm">Delete</button>`;
          }
        }
      ]
    });

    $('#table').on('click', '.btnDetail', function() {
      var uid = $(this).data('uid');
      var actionUrl = "<?= base_url('api/put-user') ?>/" + uid;
      $('#pwd').hide();
      $.ajax({
        url: `<?= base_url('api/get-user') ?>/${uid}`,
        type: 'GET',
        headers: {
          'Authorization': 'Bearer ' + TOKEN
        },
        success: function(response) {
          $('#formDetail').attr('action', actionUrl);
          $('#UserName').val(response.dt.UserName);
          $('#FullName').val(response.dt.FullName);
          $('#Phone').val(response.dt.Phone);
          $('#EmailAdds').val(response.dt.EmailAdds);
          $.ajax({
            url: '/api/get-roles',
            type: 'GET',
            headers: {
              'Authorization': 'Bearer ' + TOKEN
            },
            data: {
              RoleName: response.dt.RoleName
            },
            success: function(data) {
              if (data.dt && data.dt.length > 0) {
                roleSelect.setChoiceByValue(data.dt[0].RoleId);
                roleSelect.disable();
              }
            },
            error: function() {
              console.error('Gagal mengambil data role.');
            }
          });

          $.ajax({
            url: '/api/get-opd',
            type: 'GET',
            headers: {
              'Authorization': 'Bearer ' + TOKEN
            },
            data: {
              nama_opd: response.dt.nama_opd
            },
            success: function(data) {
              if (data.dt && data.dt.length > 0) {
                opdSelect.setChoiceByValue(data.dt[0].id);
                opdSelect.disable();
              }
            },
            error: function() {
              console.error('Gagal mengambil data OPD.');
            }
          });


          $('#userModal').modal('show');
        },
        error: function() {
          alert('Gagal mengambil data user.');
        }
      });
    });

    const addUser = function() {
      $('#pwd').show();
      var actionUrl = "<?= base_url('api/post-user') ?>/";
      $('#formDetail').attr('action', actionUrl);
      $('#UserName').val('');
      $('#FullName').val('');
      $('#Phone').val('');
      $('#EmailAdds').val('');
      roleSelect.enable();
      opdSelect.enable();
      roleSelect.setChoiceByValue('');
      opdSelect.setChoiceByValue('');
      $('#userModal').modal('show');
    }

    $('#Password, #ConfirmPassword').on('keyup', function() {
      if ($('#Password').val() !== $('#ConfirmPassword').val()) {
        $('#pwdValidation').text('Passwords do not match');
      } else {
        $('#pwdValidation').text('');
      }
    });

    $('#formDetail').on('submit', function(event) {
      event.preventDefault();
      // var formData = $(this).serialize();
      // console.log(formData);

      $.ajax({
        url: "<?= base_url('api/post-user') ?>",
        type: "POST",
        headers: {
          'Authorization': 'Bearer ' + TOKEN
        },
        data: {
          UserName: $('#UserName').val(),
          FullName: $('#FullName').val(),
          Phone: $('#Phone').val(),
          EmailAdds: $('#EmailAdds').val(),
          RoleName: $('#RoleName').val(),
          nama_opd: $('#nama_opd').val(),
          Password: $('#Password').val(),
          ConfirmPassword: $('#ConfirmPassword').val(),
          "<?= csrf_token() ?>": $('#<?= csrf_token() ?>').val()
        },
        success: function(response) {
          alert(response.msg);
          if (response.res) {
            $('#userModal').modal('hide');
            table.ajax.reload();
          }
        },
        error: function(xhr) {
          alert("Terjadi kesalahan: " + xhr.responseText);
        }
      });

    });

    $('#table').on('click', '.btnDelete', function() {
      var uid = $(this).data('uid');
      var actionUrl = "<?= base_url('api/delete-user') ?>/" + uid;
      $.ajax({
        url: `<?= base_url('api/get-user') ?>/${uid}`,
        type: 'GET',
        headers: {
          Authorization: 'Bearer ' + TOKEN
        },
        success: function(response) {
          const user = response.dt;

          Swal.fire({
            title: "Anda Yakin?",
            html: `
              <p>Username: ${user.UserName}</p>
              <p>Full Name: ${user.FullName}</p>
              <p>Phone: ${user.Phone}</p>
              <p>Email: ${user.EmailAdds}</p>
              <p>Role: ${user.RoleName}</p>
              <p>Organization: ${user.nama_opd}</p>`,
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Hapus!"
          }).then((result) => {
            if (result.isConfirmed) {
              $.ajax({
                url: actionUrl,
                type: 'DELETE',
                data: {
                  "<?= csrf_token() ?>": $('#<?= csrf_token() ?>').val()
                },
                headers: {
                  Authorization: 'Bearer ' + TOKEN
                },
                success: function(response) {
                  if (response.res) {
                    Swal.fire({
                      title: "Terhapus!",
                      text: "User berhasil dihapus.",
                      icon: "success"
                    });
                    table.ajax.reload();
                  } else {
                    Swal.fire({
                      title: "Gagal!",
                      text: response.msg,
                      icon: "error"
                    });
                  }
                },
                error: function() {
                  alert('Gagal menghapus data user.');
                }
              });
            }
          });

        },
        error: function() {
          Swal.fire({
            title: "Gagal!",
            text: "Gagal mengambil data user.",
            icon: "error"
          });
        }
      });


    });

  });
</script>
<?= $this->endSection() ?>