<?php $this->extend('Layouts/dashboard'); ?>

<!-- section style -->
<?php $this->section('style'); ?>

<style {csp-style-nonce}>
  /* Add your style here */
</style>
<?php $this->endSection(); ?>

<?php $this->section('content'); ?>

<div class="page-heading">
  <h3><?= $title; ?></h3>
</div>
<div class="page-content">
  <div class="card">
    <div class="card-header">
      <h4 class="card-title">Manage OPD</h4>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-hover table-striped" id="manage-opd">
          <thead>
            <tr>
              <th>No</th>
              <th>Nama OPD</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </Table>
      </div>
    </div>
  </div>
</div>

<!-- modal -->
<div class="modal fade" id="opdModal" tabindex="-1" role="dialog" aria-labelledby="opdModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <div class="modal-header bg-primary">
          <h5 class="modal-title white" id="userModalLabel">Form OPD</h5>
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-x">
              <line x1="18" y1="6" x2="6" y2="18"></line>
              <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
          </button>
        </div>
      <div class="modal-body">
        <form id="opdForm">
          <div class="form-group">
            <label for="nama_opd">Nama OPD</label>
            <input type="text" class="form-control" id="nama_opd" name="nama_opd" required>
          </div>
          <input type="hidden" id="opd_id" name="opd_id">
          <input type="hidden" name="<?= csrf_token() ?>" value="<?= csrf_hash() ?>">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="deleteOpd">Hapus</button>
        <button type="button" class="btn btn-primary" id="saveOpd">Simpan</button>
      </div>
    </div>
  </div>
</div>
<!-- end modal -->

<?php $this->endSection(); ?>

<?php $this->section('script'); ?>

<link {csp-style-nonce} rel="stylesheet" href="/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="/assets/vendors/dataTables/dataTables.min.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">

  $(document).ready(function() {

    setTimeout(function() {
      var searchBox = $('.dt-search');
      var addButton = $('<button>')
        .addClass('btn btn-primary ml-2')
        .text('Tambah')
        .attr('id', 'btn-tambah')
        .on('click', addOpd);
      searchBox.after(addButton);
    }, 100);

    const addOpd = function() {
      $('input[name=nama_opd]').val('')
      $('#opd_id').val('');
      $('#opdModal').modal('show');
      
    }

    let table = $('#manage-opd').DataTable({
      ajax: {
        url: '<?= base_url('api/get-opd') ?>',
        type: 'GET',
        headers: {
          'Authorization': 'Bearer ' + '<?= $token ?>',
        },
        dataSrc: 'dt'
      },
      columns: [
        { data: 'id' },
        { data: 'nama_opd' },
        {
          data: null,
          render: function(data, type, row) {
            return `<button class="btn btn-primary btnOpdModal" data-bs-toggle="modal" data-bs-target="#opdModal" data-id="${row.id}">Edit</button>`;
          }
        }
      ]
    });

  $('#manage-opd').off('click', '.btnOpdModal').on('click', '.btnOpdModal', function() {
    let id = $(this).data('id');
    $.ajax({
      url: '<?= base_url('api/get-opd?idx=') ?>' + id,
      type: 'GET',
      headers: {
        'Authorization':'Bearer ' + '<?= $token ?>',
      },
      success: function(res) {
        if(res.dt.length > 0) {
          let opd = res.dt[0];
          $('#opd_id').val(opd.id);
          $('#nama_opd').val(opd.nama_opd);
          $('#opdModal').modal('show');
        }
      }
    });
  });

  $('#saveOpd').click(function() {
    $.ajax({
      url: '<?= base_url('api/save-opd') ?>',
      type: 'POST',
      data: $('#opdForm').serialize(),
      headers: {
        'Authorization': 'Bearer ' + '<?= $token ?>',
      },
      success: function(res) {
        $("input[name='<?= csrf_token() ?>']").val(res.token_crs);
        $('#opdModal').modal('hide');
        table.ajax.reload(null, false);
      }
    });
  });

  // deleteOpd confirm with sweetalert
  $('#deleteOpd').click(function() {
    let id = $('#opd_id').val();
    Swal.fire({
      title: 'Apakah anda yakin?',
      text: "Data yang dihapus tidak dapat dikembalikan!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Ya, hapus!',
      cancelButtonText: 'Batal'
    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          url: '<?= base_url('api/del-opd') ?>',
          type: 'POST',
          data: $('#opdForm').serialize(),
          headers: {
            'Authorization': 'Bearer ' + '<?= $token ?>',
          },
          success: function(res) {
            $("input[name='<?= csrf_token() ?>']").val(res.token_crs);
            $('#opdModal').modal('hide');
            table.ajax.reload(null, false);
          }
        });
      }
    });
  });

});


</script>
<?php $this->endSection(); ?>