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
  <div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel"
    aria-hidden="true">
    <div class="modal-dialog-centered modal-dialog modal-lg " role="document">
      <div class="modal-content">
        <div class="modal-header bg-primary">
          <h5 class="modal-title white" id="userModalLabel">User Details</h5>
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
              class="feather feather-x">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
        <form id="formDetail" method="POST">
          <div class="modal-body">
            <input type="hidden" id="<?= csrf_token() ?>" name="<?= csrf_token() ?>" value="<?= csrf_hash(); ?>">
            <div class="row">
              <div class="col-6">
                <div class="form-group">
                  <label for="UserName">Username</label>
                  <input type="text" class="form-control" id="UserName" name="UserName">
                </div>
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label for="FullName">Full Name</label>
                  <input type="text" class="form-control" id="FullName" name="FullName">
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-6">
                <div class="form-group">
                  <label for="Phone">Phone</label>
                  <input type="text" class="form-control" id="Phone" name="Phone">
                </div>
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label for="EmailAdds">Email</label>
                  <input type="text" class="form-control" id="EmailAdds" name="EmailAdds">
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="nama_opd">Organization</label>
              <select class="form-select" name="nama_opd" id="nama_opd"></select>
            </div>
            <div class="row" id="pwd">
              <div class="col-6">
                <div class="form-group">
                  <label for="Password">Password</label>
                  <input type="password" class="form-control" id="Password" name="Password">
                </div>
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label for="ConfirmPassword">Confirm Password</label>
                  <input type="password" class="form-control" id="ConfirmPassword" name="ConfirmPassword">
                  <p><small class="text-danger" id="pwdValidation"></small></p>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label for="RoleName">Role</label>
              <select class="form-select" name="RoleName" id="RoleName"></select>
            </div>
            <div id="tahunForm" class="d-none">
              <div class="form-group">
                <label for="tahun">Tahun</label>
                <select class="form-select" id="tahunPenilaian">
                </select>
              </div>
            </div>
            <div id="aspek-penilai">
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
<script {csp-script-nonce} src="/assets/vendors/sweetalert2/sweetalert2-11.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">
const TOKEN = "<?= ($token) ? $token : "" ?>";
let opdSelect;
let roleSelect;
let aspekSelect;
let tahunSelect;
let aspek_penilai = [];

$(document).ready(function() {
  initializeDataTable();
  setupEventHandlers();
});

function initializeDataTable() {
  $('#table').DataTable({
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
        "data": data => data.uid.substring(0, 10)
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
        "data": data => `
          <button data-uid="${data.uid}" class="btnDetail btn btn-primary btn-sm">Detail</button>
          <button data-uid="${data.uid}" class="btnDelete btn btn-danger btn-sm">Delete</button>
        `
      }
    ]
  });
}

function loadRoles() {
  $.ajax({
    url: '/api/get-roles',
    method: 'GET',
    dataType: 'json',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        const roleSelect = new Choices('#RoleName');
        roleSelect.setValue(response.dt.map(dt => ({
          value: dt.RoleId,
          label: dt.RoleName
        })));
      }
    },
    error: function() {
      console.log('Gagal mengambil data role');
    }
  });
}

function loadOrganizations() {
  $.ajax({
    url: '/api/get-opd',
    method: 'GET',
    dataType: 'json',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        const opdSelect = new Choices('#nama_opd');
        opdSelect.setValue(response.dt.map(dt => ({
          value: dt.id,
          label: dt.nama_opd
        })));
      }
    },
    error: function() {
      console.log('Gagal mengambil data organization');
    }
  });
}

function setupEventHandlers() {
  setTimeout(function() {
    var searchBox = $('.dt-search');
    var addButton = $('<button>')
      .addClass('btn btn-primary ml-2')
      .text('Tambah')
      .attr('id', 'btn-tambah')
      .on('click', addUser);
    searchBox.after(addButton);
  }, 100);

  $('#table').on('click', '.btnDetail', showUserDetail);
  $('#table').on('click', '.btnDelete', deleteUser);
  $('#Password, #ConfirmPassword').on('keyup', validatePasswords);
  $('#formDetail').on('submit', submitForm);
  $('#RoleName').on('change', handleRoleChange);
  $('#tahunPenilaian').on('change', loadAspects);
}

function showUserDetail() {
  clearForm();
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
      // console.log(response.dt);
      aspek_penilai = response.dt.aspek_penilai.map(ap => ap.aspek_id);

      $('#formDetail').attr('action', actionUrl);
      $('#UserName').val(response.dt.UserName);
      $('#FullName').val(response.dt.FullName);
      $('#Phone').val(response.dt.Phone);
      $('#EmailAdds').val(response.dt.EmailAdds);
      SelectOpd(response.dt.opdid);
      SelectRole(response.dt.RoleId);
      loadAspects(aspek_penilai);
      $('#userModal').modal('show');
    },
    error: function() {
      alert('Gagal mengambil data user.');
    }
  });
}

function addUser() {
  clearForm();
  $('#pwd').show();
  var actionUrl = "<?= base_url('api/add-user') ?>";
  $('#formDetail').attr('action', actionUrl);
  $('#formDetail').attr('method', 'POST');
  $('#UserName').val('');
  $('#FullName').val('');
  $('#Phone').val('');
  $('#EmailAdds').val('');
  SelectOpd();
  SelectRole();
  $('#userModal').modal('show');
}

function SelectOpd(selectedId = null) {
  if (opdSelect) {
    opdSelect.destroy();
  }
  $.ajax({
    url: '/api/get-opd',
    type: 'GET',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        var opd = response.dt;
        var options = opd.map(function(item) {
          return {
            value: item.id,
            label: item.nama_opd,
            selected: item.id == selectedId
          };
        });
        opdSelect = new Choices('#nama_opd', {
          choices: options,
          shouldSort: false
        });
      }
    },
    error: function() {
      console.error('Gagal mengambil data OPD.');
    }
  });
}

function SelectRole(selectedId = null) {
  if (roleSelect) {
    roleSelect.destroy();
  }
  $.ajax({
    url: '/api/get-roles',
    type: 'GET',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        var roles = response.dt;
        var options = roles.map(function(item) {
          return {
            value: item.RoleId,
            label: item.RoleName,
            selected: item.RoleId == selectedId
          };
        });
        roleSelect = new Choices('#RoleName', {
          choices: options,
          shouldSort: false
        });
        if (selectedId) {
          let role = roles.find(role => role.RoleId == selectedId);
          if (role.acs == '2') {
            $('#tahunForm').removeClass('d-none');
            loadYears(selectedId);
          }
        }
      }
    },
    error: function() {
      console.error('Gagal mengambil data Role.');
    }
  });
}

function validatePasswords() {
  if ($('#Password').val() !== $('#ConfirmPassword').val()) {
    $('#pwdValidation').text('Passwords do not match');
  } else {
    $('#pwdValidation').text('');
  }
}

function submitForm(event) {
  event.preventDefault();
  $.ajax({
    url: $(this).attr('action'),
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
      aspek_penilai: $('#aspek').val(),
      ConfirmPassword: $('#ConfirmPassword').val(),
      "<?= csrf_token() ?>": $('#<?= csrf_token() ?>').val()
    },
    success: function(response) {
      $('#<?= csrf_token() ?>').val(response.token_crs);
      if (typeof response.msg === 'object') {
        let errorMsg = '';
        for (const [key, value] of Object.entries(response.msg)) {
          errorMsg += `${key}: ${value}\n`;
        }
        alert(errorMsg);
      } else {
        alert(response.msg);
      }
      if (response.res) {
        $('#userModal').modal('hide');
        $('#table').DataTable().ajax.reload();
      }
    },
    error: function(xhr) {
      alert("Terjadi kesalahan: " + xhr.responseText);
    }
  });
}

function deleteUser() {
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

      // Buat tabel data terkait
      let relatedRows = '';
      if (user.data_terkait) {
        for (let [key, val] of Object.entries(user.data_terkait)) {
          relatedRows += `<tr><th>${key}</th><td>${val}</td></tr>`;
        }
      }

      Swal.fire({
        title: "Anda Yakin?",
        html: `
          <div style="text-align:left">
            <table class="table table-sm">
              <tr><th>Username</th><td>${user.UserName}</td></tr>
              <tr><th>Full Name</th><td>${user.FullName}</td></tr>
              <tr><th>Phone</th><td>${user.Phone}</td></tr>
              <tr><th>Email</th><td>${user.EmailAdds}</td></tr>
              <tr><th>Role</th><td>${user.RoleName}</td></tr>
              <tr><th>Organization</th><td>${user.nama_opd ?? '-'}</td></tr>
            </table>

            <h6>Data Terkait:</h6>
            <table class="table table-bordered table-sm">
              ${relatedRows || '<tr><td colspan="2">Tidak ada data terkait</td></tr>'}
            </table>

            <div class="form-check">
              <input class="form-check-input" type="radio" name="deleteMode" id="softDelete" value="soft" checked>
              <label class="form-check-label" for="softDelete">
                Soft Delete (nonaktifkan user, data tetap ada)
              </label>
            </div>
            
            <div class="form-check">
              <input class="form-check-input" type="radio" name="deleteMode" id="hardDelete" value="hard" checked>
              <label class="form-check-label" for="hardDelete">
                Hard Delete <span class="text-warning">(hapus user.  data terkait tidak lagi memiliki hubungan atau tautan dengan user manapun)</span>
              </label>
            </div>
            
            <div class="form-check">
              <input class="form-check-input" type="radio" name="deleteMode" id="forceDelete" value="force">
              <label class="form-check-label" for="forceDelete">
                Force Delete <span class="text-danger">(hapus user beserta semua data terkait. data tidak dapat dikembalikan)</span>
              </label>
            </div>
          </div>
        `,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Hapus!"
      }).then((result) => {
        if (result.isConfirmed) {
          // Ambil mode dari checkbox
          let deleteMode = $('input[name="deleteMode"]:checked').val();

          $.ajax({
            url: actionUrl + '?mode=' + deleteMode,
            type: 'DELETE',
            data: {
              "<?= csrf_token() ?>": $('#<?= csrf_token() ?>').val(),
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
                $('#table').DataTable().ajax.reload();
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
}

function handleRoleChange() {
  var role_id = $(this).val();
  $.ajax({
    url: '/api/get-roles',
    type: 'GET',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    data: {
      RoleId: role_id
    },
    success: function(response) {
      if (response.dt && response.dt.length > 0) {
        let user_role = response.dt[0];
        let role_acs = user_role.acs;
        if (role_acs == '2') {
          $('#tahunForm').removeClass('d-none');
          loadYears(role_id);
        } else {
          $('#tahunForm').addClass('d-none');
          $('#aspek-penilai').html('');
        }
      }
    },
    error: function() {
      console.error('Gagal mengambil data role.');
    }
  });
}

function loadYears(role_id) {
  if (tahunSelect) {
    tahunSelect.destroy();
  }
  tahunSelect = new Choices('#tahunPenilaian', {
    placeholder: true,
    searchPlaceholderValue: 'Pilih Tahun',
    itemSelectText: '',
    shouldSort: false
  });

  $.ajax({
    url: '/api/get-tahun',
    type: 'GET',
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        response.dt.unshift({
          id: '0',
          nama: '- Pilih Tahun -'
        });
        tahunSelect.setValue(response.dt.map(dt => ({
          value: dt.id,
          label: dt.nama
        })));
        $('#tahunPenilaian').trigger('change');
      }
    },
    error: function() {
      console.error('Gagal mengambil data tahun.');
    }
  });

}

function loadAspects() {

  if (aspekSelect) {
    aspekSelect.destroy();
  }

  let form_id = $('#tahunPenilaian').val();
  if (form_id == '0') {
    $('#aspek-penilai').html('');
    return;
  }

  $.ajax({
    url: '/api/get-aspek-by-form/',
    type: 'GET',
    data: {
      FormId: form_id
    },
    headers: {
      'Authorization': 'Bearer ' + TOKEN
    },
    success: function(response) {
      if (response.dt) {
        let optionsHtml = '';

        for (let dt of response.dt) {
          let selected = aspek_penilai.includes(dt.id) ? 'selected' : '';
          optionsHtml += `<option value="${dt.id}" ${selected}>${dt.nama_sub_aspek}</option>`;
        }

        $('#aspek-penilai').html(`
            <div class="form-group">
              <label for="aspek">Aspek Penilaian</label>
              <select id="aspek" name="aspek[]" class="form-select" multiple>
                ${optionsHtml}
              </select>
            </div>
          `);

        aspekSelect = new Choices('#aspek', {
          placeholder: true,
          searchPlaceholderValue: 'Pilih Aspek Penilaian',
          itemSelectText: '',
          shouldSort: false,
          removeItemButton: true,
        });
      }
    },
    error: function() {
      console.error('Gagal mengambil data aspek.');
    }
  });
}


function clearForm() {
  $('#UserName').val('');
  $('#FullName').val('');
  $('#Phone').val('');
  $('#EmailAdds').val('');
  $('#Password').val('');
  $('#ConfirmPassword').val('');
  $('#tahunForm').addClass('d-none');
  $('#tahunPenilaian').html('');
  $('#aspek-penilai').html('');
  if (roleSelect) {
    roleSelect.clearStore();
  }
  if (opdSelect) {
    opdSelect.clearStore();
  }
}
</script>
<?= $this->endSection() ?>