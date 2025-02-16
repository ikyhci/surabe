<?= $this->extend('Layouts/dashboard') ?>

<?= $this->section('styles') ?>
<style {csp-style-nonce} >
  .opd-index {
    width: 50px;
  }
</style>
<?= $this->endSection() ?>

<?= $this->section('content') ?>

<div class="page-heading">
  <h3><?= $title; ?></h3>
</div>
<div class="page-content">
  <div class="card">
    <div class="card-header">
      <!-- <h4 class="card-title">Card Title</h4> -->
    </div>
    <div class="card-body">
      <div class="form-group">
        <select class="choices form-select choices__input" name="aspek" id="aspek">
          <!-- <option value="">Pilih Aspek</option> -->
          <!-- <php foreach ($aspek as $key => $val) : ?>
            <option value="<= $val->id ?>"><= $val->nama_aspek . ', ' . $val->sub_aspek . ' Tahun ' . $val->tahun ?></option>
          <php endforeach; ?> -->
            <?php
            $currentYear = date('Y');
            for ($i = 0; $i < 5; $i++) {
              $year = $currentYear - $i;
              $selected = ($i == 0) ? 'selected' : '';
              echo "<option value=\"$year\" $selected>$year</option>";
            }
            ?>
        </select>
      </div>
      <br>
      <!-- <div>
        <table>
          <tr>
            <td>Aspek</td>
            <td>: -</td>
          </tr>
          <tr>
            <td>Sub Aspek</td>
            <td>: -</td>
          </tr>
          <tr>
            <td>Sub Sub Aspek</td>
            <td>: -</td>
          </tr>
        </table>
      </div> -->
      <br>
      <div>
        <h6>Daftar OPD</h6>
        <table class="table table-hover">
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<?= $this->endSection() ?>

<?= $this->section('script') ?>

<script {csp-script-nonce} src="<?php echo base_url();?>/assets/vendors/jquery/jquery.min.js"></script>
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>/assets/vendors/dataTables/dataTables.min.css">
<script {csp-script-nonce} src="<?php echo base_url();?>/assets/vendors/dataTables/dataTables.min.js"></script>

<link {csp-script-nonce} rel="stylesheet" href="/assets/vendors/choices.js/choices.min.css" />
<script {csp-script-nonce} src="/assets/vendors/choices.js/choices.min.js"></script>
<script {csp-script-nonce} src="/assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">
  $(document).ready(function() {
    var token = document.getElementById('token').value;

    getOpd($('#aspek').val());

    $('#aspek').change(function() {
      let aspek = $(this).val();
      getOpd(aspek);
      console.log(aspek)
    });

    

    function getOpd(asp) {
      var crs = document.getElementById('<?= csrf_token() ?>').value
      if (!asp) {
        asp = $('#aspek').val();
      }

      $.ajaxSetup({
        headers:{
          'Authorization': 'Bearer '+token
           }
        });
      // if (!asp) {
      //   asp = new Date().getFullYear()
      // }
      let tbody = '';
      $.ajax({
        url: '<?= base_url('api/penilaian/data-opd?asp=') ?>' + asp,
        type: 'GET',
        headers: {
          'Authorization': 'Bearer <?= $token ?>'
        },
        success: function(data) {
          data.data.forEach((opd, index) => {
        let progress = ((opd.detail.jumlah_kondisi / opd.detail.jumlah_indikator) * 100).toFixed(2);
        tbody += `
          <tr class="bg-light">
            <td class="text-center opd-index">${index + 1}</td>
            <td colspan="2" class="opd_name " data-opdid="${opd.id}">${opd.nama_opd}</td>
          </tr>
          <tr class="opd-detail d-none" data-opdid="${opd.id}">
            <td></td>
            <td class="ml-4">
          Jumlah Indikator: ${opd.detail.jumlah_indikator} <br>
          Jumlah Evaluasi: ${opd.detail.jumlah_kondisi} <br>
          <!--
          <div class="progress progress-primary  mb-4">
              <div class="progress-bar progress-bar-width " width="${progress}%" role="progressbar" aria-valuenow="${progress}" aria-valuemin="0" aria-valuemax="100"></div>
          </div>
          --!>
            </td>
            <td class="text-end">
          <a href="<?= base_url('dashboard/penilaian/detail-form?form=') ?>${opd.formid}" class="btn icon btn-info"><i class="bi bi-pencil"></i></a>
            </td>
          </tr>
        `;
          });
          $('.table tbody').html(tbody);

          $('.opd_name').click(function() {
        let opdid = $(this).data('opdid');
        let detailRow = $('.opd-detail[data-opdid="' + opdid + '"]');
        if (detailRow.hasClass('d-none')) {
          $('.opd-detail').addClass('d-none');
          detailRow.removeClass('d-none');
        } else {
          detailRow.addClass('d-none');
        }
          });
        }
      });
    };

  });
</script>
<?= $this->endSection() ?>