<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/vendors/choices.js/choices.min.css" />
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/css/costum.css">
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/vendors/sweetalert/sweetalert.css">


<?= $this->endSection() ?>

<?= $this->section('content') ?>

<div class="page-heading">
  <h3>Tugas Penilaian Mandiri</h3>
</div>
<div class="page-content">
  <div class="card">

    <div class="card-body">
      <table class="table  mb-0">
        <tbody>
          <tr>
            <td>Detail Form</td>
            <td class="text-end">
              <a href="<?php echo base_url(); ?>dashboard/penilaian" class="btn btn-primary" id="back"> Kembali</a>
            </td>
          </tr>
          <tr>
            <td>Tahun</td>
            <td>: <?= $dt->tahun; ?></td>
          </tr>
          <tr>
            <td>Nama Form</td>
            <td>: <?= $dt->nama_form; ?></td>
          </tr>
          <tr>
            <td>Aspek</td>
            <td>: <?= $dt->nama_aspek; ?></td>
          </tr>
          <tr>
            <td>Sub Aspek</td>
            <td>: <?= $aspek->subaspek[0]->nama_sub_aspek; ?></td>
          </tr>
          <tr>
            <td>OPD</td>
            <td>: <?= $aspek->opd[0]->nama_opd ?></td>
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
          <tbody>
            <?php $no = 1;
            foreach ($aspek->subaspek[0]->subsubaspek as $a => $ssa): ?>
              <tr id="<?= $ssa->id; ?>" class="alert alert-secondary list-ssa">
                <td><?= $no++; ?></td>
                <td><?= $ssa->nama_sub_sub_aspek ?></td>
                <td></td>
              </tr>
              <?php foreach ($ssa->indikator as $ind) : ?>
                <tr class="list-indikator  <?= $ssa->id; ?>">
                  <td></td>
                  <td><?= $ind->indikator; ?></td>
                  <td>
                    <?php if (!empty($ind->kondisiOpd)) : ?>
                      <button class="btn btn-info btn-sm detail" data-ssa="<?= $ssa->nama_sub_sub_aspek ?>" data-idInd="<?= $ind->id ?>" data-dataOpd="<?= base64_encode(json_encode($ind)) ?>" data-bs-toggle="modal_" data-bs-target="#detail_indikator"><i class="bi bi-eye"></i></button>
                    <?php endif ?>
                  </td>
                </tr>
              <?php endforeach; ?>
            <?php endforeach; ?>
          </tbody>
        </table>
      </div>


    </div>

  </div>

</div>

<!-- modal -->

<div class="modal fade text-left" id="detail_indikator" tabindex="-1" role="dialog"
  aria-labelledby="myModalLabel17" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg"
    role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h4 class="modal-title white" id="myModalLabel17">Indikator</h4>
        <button type="button" class="close" data-bs-dismiss="modal"
          aria-label="Close">
          <i data-feather="x"></i>
        </button>
      </div>
      <div class="modal-body">
        <div class="table-responsive">
          <table class="table mb-0">
            <tbody>
              <tr>
                <td>Domain</td>
                <td>: </td>
              </tr>
              <tr>
                <td>Sub Sub Aspek</td>
                <td id="ssa">: </td>
              </tr>
              <tr>
                <td>Indikator</td>
                <td id="indk">: </td>
              </tr>
            </tbody>
          </table>
        </div>
        <h6 class="mt-3">Parameter</h6>
        <div id="param"><ol></ol></div>
        <h6 class="mt-3">Jawaban</h6>
        <div id="jawab"><ol></ol></div>
        <h6 class="mt-3">Bukti Dukung</h6>
        <div id="buduk" class="table-responsive">
          <table class="table table-hover mb-0 ">
            <tbody></tbody>
          </table>
        </div>
        <h6 class="mt-3">Point</h6>
        <div class="input-group">
          <input type="hidden" name="data" >
          <input type="number" name="point" id="point" class="form-control" value="" placeholder="Point">
          <!-- <input type="range" min="0" max="100" class="form-control" id="rangeInput"> -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="simpan" class="btn btn-primary ml-1">
          <i class="bx bx-check d-block d-sm-none"></i>
          <span class="d-none d-sm-block">Simpan</span>
        </button>
      </div>
    </div>
  </div>
</div>
<div class="sidebar-item active"></div>
<!-- end modal -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<input type="hidden" name="form" id="form" value="<?= $idx; ?>">
<!-- popup -->
<script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/choices.js/choices.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/dataTables/dataTables.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/sweetalert/sweetalert.min.js'); ?>"></script>

<script {csp-script-nonce} type="text/javascript">
  const TOKEN = "<?= ($token) ? $token : "" ?>";
  let CSRF_HASH = "<?= csrf_hash() ?>";
  $(document).ready(function() {
    $('#point').on('keyup', function() {
      let val = $(this).val();
      if (val > 100) {
        $(this).val(100);
      } else if (val < 0) {
        $(this).val(0);
      }
    });

    $('#simpan').on('click', function() {
      let data = $('input[name="data"]').val();
      let point = $('input[name="point"]').val();      
      $.ajax({
        url: '<?= base_url('api/penilaian/simpanPoint') ?>',
        type: 'POST',
        headers: {
          'Authorization': 'Bearer ' + TOKEN
        },
        data: {
          "<?= csrf_token() ?>": CSRF_HASH,
          data: data,
          point: point
        },
        success: function(res) {
          CSRF_HASH = res.csrf_token
          console.log(res);
          if (res.status) {
            Swal.fire({
              icon: 'success',
              title: 'Berhasil',
              text: res.message,
            });
            $('#modal').modal('hide');
          } else {
            Swal.fire({
              icon: 'error',
              title: 'Gagal',
              text: res.message,
            });
          }
        }
      });
    });

    $('.list-ssa').on('click', function() {
      let id = $(this).attr('id');
      $('.' + id).toggleClass('d-none');
    });
    
    $('.detail').on('click', function() {
      var id = $(this).data('idind');
      var ssa = $(this).data('ssa');
      var dataOpd = $(this).data('dataopd');
      $.ajax({
        url: '<?= base_url('api/penilaian/jawabanOpdIndikator') ?>',
        type: 'POST',
        headers: {
          'Authorization': 'Bearer ' + TOKEN
        },
        data: {
          "<?= csrf_token() ?>": CSRF_HASH,
          id: id,
          dataOpd: dataOpd
        },
        success: function(res) {
          CSRF_HASH = res.csrf_token
          console.log(res);
          $('#detail_indikator #ssa').text(': ' + ssa);
          $('#detail_indikator #indk').text(': ' + res.data.indikator);
          $('#detail_indikator #param ol').html('');
          res.data.parameter.forEach((p, i) => {
            $('#detail_indikator #param ol').append("<li>"+ p.nama_parameter +"</li>");
          });
          let badgeColor = (res.data.kondisiOpd[0].Jawaban == 'YA') ? 'badge bg-light-success' : (res.data.kondisiOpd[0].Jawaban == 'TIDAK') ? 'badge bg-light-danger' : 'badge bg-light-warning';
          $('#detail_indikator #jawab').html(` <span class="${badgeColor}"> ${res.data.kondisiOpd[0].Jawaban}</span> `);
          $('#detail_indikator #buduk table tbody').html('');
          res.data.bukti_dukung.forEach((b, i) => {
            $('#detail_indikator #buduk table tbody').append("<tr><td>"+ b.bukti_dukung +"</td><td id='"+b.id+"'></td></tr>");
          });
          res.data.kondisiOpd.forEach((k, i) => {
            k.bukti.forEach((b, i) => {
              
              let lnk = `<a href="<?= base_url('uploadfile/') ?>${b.files}" class=" icon "><i class="bi bi-download"></i></a>`;
              $('#'+b.bukti_dukung_id).html(lnk);
            });
          });
          $('input[name="point"]').val(res.data.kondisiOpd[0].nilai);
          $('input[name="data"]').val(dataOpd);
          $('#detail_indikator').modal('show');
        }
      });
    });
  })
</script>


<?= $this->endSection() ?>