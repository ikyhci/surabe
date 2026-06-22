<?php

/** @var array|object $opd */
/** @var string $idx */
/** @var array|object $allAspek */
/** @var array|object $aspek */
/** @var array|object $radarLabels */
/** @var string $title */
/** @var array|object $forms */
/** @var array|object $form */
/** @var string $uname */
/** @var string $usr */
/** @var string $token */
?>

<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/vendors/choices.js/choices.min.css" />
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/css/costum.css">
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url(); ?>assets/vendors/sweetalert/sweetalert.css">

<style>
  .clickable {
    cursor: pointer;
  }

  .tr-header-1 {
    background-color: rgb(183, 221, 255);
    /* Light blue */
    /* text-transform: uppercase; */
    font-weight: bold;
  }

  .tr-header-2 {
    background-color: rgb(204, 228, 191);
    /* Very light gray */
  }

  .tr-header-3 {
    background-color: #fcfcf0;
    /* Soft yellow */
  }
</style>

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
            <td>: <?= $form['tahun']; ?></td>
          </tr>
          <tr>
            <td>Nama Form</td>
            <td>: <?= $form['nama_form']; ?></td>
          </tr>
          <tr>
            <td>OPD</td>
            <td>: <?= $aspek->opd[0]->nama_opd ?></td>
          </tr>
        </tbody>
      </table>
      <br>
    </div>
  </div>


  <?php foreach ($forms->rb as $key => $rb) : ?>
    <div class="card">
      <div class="card-header header-sm">
        <h5 class="card-title"><?= $rb->nums . ". " . $rb->nama ?></h5>
      </div>
      <div class="card-body">
        <div class="table-responsive" style="overflow-x: auto;">
          <table class="table table-hover" id="table<?= $rb->id ?>" style="min-width: 600px;">
            <thead>
              <tr>
                <th scope="col" colspan="4">Indikator</th>
                <th scope="col" width="10%">Point</th>
                <th scope="col" width="10%">Aksi</th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($rb->aspek as $key => $aspek) : ?>
                <tr class="<?= $rb->id ?> list-aspek tr-header-1">
                  <td colspan="6"><?= $aspek->nums . ". " . $aspek->nama_aspek ?></td>
                </tr>
                <?php foreach ($aspek->sub_aspek as $sub_aspek) : ?>
                  <tr class="<?= $aspek->id ?> list-sa tr-header-2">
                    <td width="1%"></td>
                    <td colspan="3"><?= $sub_aspek->nums . ". " . $sub_aspek->nama_sub_aspek ?></td>
                    <td></td>
                    <td></td>
                  </tr>
                  <?php foreach ($sub_aspek->sub_sub_aspek as $key => $sub_sub_aspek): ?>
                    <tr class="list-ssa <?= $sub_aspek->id ?> list-ssa tr-header-3">
                      <td width="1%"></td>
                      <td width="1%"></td>
                      <td colspan="2"><?= $sub_sub_aspek->nums . ". " . $sub_sub_aspek->nama_sub_sub_aspek ?></td>
                      <td></td>
                      <td>
                        <?php if (count($sub_sub_aspek->indikator) > 0) : ?>
                          <i id="<?= $sub_sub_aspek->id ?>" class="bi bi-plus clickable"></i>
                        <?php endif; ?>
                      </td>
                    </tr>
                    <?php foreach ($sub_sub_aspek->indikator as $key => $indikator): ?>
                      <tr class="<?= $sub_sub_aspek->id ?> list-ind d-none">
                        <td width="1%"></td>
                        <td width="1%"></td>
                        <td width="1%"></td>
                        <td><?= $indikator->nums . ". " . $indikator->indikator ?> </td>
                        <td></td>
                        <td>
                          <?php if (!empty($indikator->kondisiOpd)) : ?>
                            <button class="btn btn-success btn-sm detail" data-ssa="<?= $sub_sub_aspek->nama_sub_sub_aspek ?>" data-idInd="<?= $indikator->id ?>" data-dataOpd="<?= base64_encode(json_encode($form['opdid'])) ?>" data-idOpd="<?= $form['opdid'] ?>" data-bs-toggle="modal_" data-bs-target="#detail_indikator"><i class="bi bi-eye"></i></button>
                          <?php endif; ?>
                        </td>
                      </tr>
                    <?php endforeach; ?>
                  <?php endforeach; ?>
                <?php endforeach; ?>
              <?php endforeach; ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  <?php endforeach; ?>
</div>

<!-- modal -->

<div class="modal fade text-left" id="detail_indikator" tabindex="-1" role="dialog"
  aria-labelledby="myModalLabel17" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl"
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
        <form action="#">
          <div class="table-responsive">
            <table class="table mb-0">
              <tbody>
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
          <div id="param">
            <ol></ol>
          </div>
          <h6 class="mt-3">Jawaban</h6>
          <div id="jawab">
            <ol></ol>
          </div>
          <h6 class="mt-3">Bukti Dukung</h6>
          <div id="buduk" class="m-3">

          </div>
          <h6 class="mt-3">Point</h6>
          <div class="input-group">
            <input type="hidden" name="data">
            <input type="number" name="point" id="point" class="form-control w-25" value="" placeholder="Point" readonly>
            <!-- <input type="range" min="0" max="100" class="form-control" id="rangeInput"> -->
          </div>
          <h6 class="mt-3">Keterangan</h6>
          <textarea class="form-control" name="keterangan" id="keterangan" rows="3" placeholder="Masukkan keterangan"></textarea>
          <h6 class="mt-3">Persetujuan</h6>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="aprv" id="approval_yes" value="yes">
            <label class="form-check-label" for="approval_yes">
              Setuju
            </label>
          </div>
          <div class="form-check">
            <input class="form-check-input" type="radio" name="aprv" id="approval_no" value="no">
            <label class="form-check-label" for="approval_no">
              Tolak
            </label>
          </div>
        </form>
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
<?= csrf_field() ?>
<input type="hidden" name="form" id="form" value="<?= $idx; ?>">
<!-- popup -->
<script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/choices.js/choices.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/dataTables/dataTables.min.js'); ?>"></script>
<script {csp-script-nonce} src="<?= base_url('assets/vendors/sweetalert/sweetalert.min.js'); ?>"></script>

<script {csp-script-nonce} type="text/javascript">
  const wXy = "<?= ($token) ? $token : "" ?>";
  let xYz = "<?= csrf_hash() ?>";
  let idOpd = "<?= $form['opdid'] ?>";
  let xpnd = [];
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
      event.preventDefault();
      let data = $('input[name="data"]').val();
      let point = $('input[name="point"]').val();
      $.ajax({
        url: '<?= base_url('api/penilaian/simpanPoint') ?>',
        type: 'POST',
        headers: {
          'Authorization': 'Bearer ' + wXy
        },
        data: {
          "<?= csrf_token() ?>": xYz,
          dataForm: $('form').serialize(),
          // data: data,
          // point: point
        },
        success: function(res) {
          xYz = res.csrf_token
          $('input[name="<?= csrf_token() ?>"]').val(xYz);
          if (res.status) {
            swal({
              icon: 'success',
              title: 'Berhasil',
              text: res.message,
            }, function() {
              location.reload();
            });

            $('#detail_indikator').modal('hide');

          } else {
            swal({
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
          'Authorization': 'Bearer ' + wXy
        },
        data: {
          "<?= csrf_token() ?>": xYz,
          id: id,
          dataOpd: dataOpd,
          idOpd: $(this).data('idopd')
        },
        success: function(res) {
          xYz = res.csrf_token
          if (res.data.kondisiOpd.length == 0) {
            alert('Data belum diisi, silahkan isi terlebih dahulu');
            return;
          }
          $('input[name="<?= csrf_token() ?>"]').val(xYz);
          $('#detail_indikator #ssa').text(': ' + ssa);
          $('#detail_indikator #indk').text(': ' + res.data.indikator);
          $('#detail_indikator #param ol').html('');
          res.data.parameter.forEach((p, i) => {
            $('#detail_indikator #param ol').append("<li>" + p.nama_parameter + "</li>");
          });

          $('input[name="point"]').val((res.data.kondisiOpd[0]) ? res.data.kondisiOpd[0].nilai : "");
          $('input[name="data"]').val(dataOpd);
          $('textarea[name="keterangan"]').val((res.data.kondisiOpd[0]) ? res.data.kondisiOpd[0].ket : "");
          if (res.data.kondisiOpd[0]) {
            if (res.data.kondisiOpd[0].aprove == 'yes') {
              $('input[name="aprv"][value="yes"]').prop('checked', true);
            } else {
              $('input[name="aprv"][value="no"]').prop('checked', true);
            }
          }
          generateJawaban(res.data.jenis_jawaban.num, res.data);
          $('#detail_indikator').modal('show');
        }
      });
    });

    $('.clickable').on('click', function() {
      let id = $(this).attr('id');
      $('.list-ind').addClass('d-none');
      // $('.'+id).toggleClass('d-none');
      $('.clickable').attr('class', 'bi bi-plus clickable');
      if (xpnd[id]) {
        $('.' + id).addClass('d-none');
        // xpnd.forEach((item, index) => {
        //   xpnd[index] = false;
        // });
        $(this).attr('class', 'bi bi-plus clickable');
      } else {
        $('.' + id).removeClass('d-none');
        $(this).attr('class', 'bi bi-dash clickable');
      }
      xpnd[id] = !xpnd[id];
    });

    function generateJawaban(jenis_jawaban_num, data) {
      let parameter = data.parameter;
      let jawabContainer = document.getElementById("jawab");
      jawabContainer.innerHTML = "";

      if (jenis_jawaban_num == 1) {
        // Jika jenis jawaban == 1, tampilkan input range
        let nilai = (data.kondisiOpd[0]) ? data.kondisiOpd[0].nilai : 0;
        let inputGroup = document.createElement("div");
        inputGroup.setAttribute("class", "input-group input-group-sm mb-3");

        let inputNumber = document.createElement("input");
        inputNumber.setAttribute("type", "text");
        inputNumber.setAttribute("class", "form-control form-control-sm w-10");
        inputNumber.setAttribute("min", "0");
        inputNumber.setAttribute("max", "100");
        inputNumber.setAttribute("step", "1");
        inputNumber.setAttribute("value", nilai + " %");
        inputNumber.setAttribute('disabled', 'disabled');

        let inputRange = document.createElement("input");
        inputRange.setAttribute("type", "range");
        inputRange.setAttribute("name", "jawaban");
        inputRange.setAttribute("class", "form-control form-control-lg form-range w-75");
        inputRange.setAttribute("aria-label", "Sizing example input");
        inputRange.setAttribute("aria-describedby", "inputGroup-sizing-sm");
        inputRange.setAttribute("min", "0");
        inputRange.setAttribute("max", "100");
        inputRange.setAttribute("step", "1");
        inputRange.setAttribute("value", nilai);
        inputRange.setAttribute('disabled', 'disabled');

        inputGroup.appendChild(inputNumber);
        inputGroup.appendChild(inputRange);

        jawabContainer.appendChild(inputGroup);

        inputRange.addEventListener("input", function() {
          inputNumber.value = inputRange.value + " %";
        });

        inputNumber.addEventListener("input", function() {
          let value = inputNumber.value.replace(/\D/g, '').replace(/^0+/, '');
          inputNumber.value = value + " %";
          inputRange.value = value;
        });

      } else if (jenis_jawaban_num == 2) {
        // Jika jenis jawaban == 2 tampilkan radio button
        let ol = document.createElement("ol");
        let options = [];
        let jawabanOpd = (data.kondisiOpd[0]) ? data.kondisiOpd[0].Jawaban : "";
        options = ["YA", "TIDAK"];
        // options[4] = parameter.map( p => p.nama_parameter);
        options.forEach((option, index) => {

          let li = document.createElement("li");

          let radio = document.createElement("input");
          radio.setAttribute("type", "radio");
          radio.setAttribute("name", "jawaban");
          radio.setAttribute("value", option);
          radio.setAttribute("id", "jawaban" + index);
          radio.setAttribute("class", "form-check-input");
          if (option == jawabanOpd) {
            radio.setAttribute("checked", "checked");
          }

          let jawaban = (data.kondisiOpd[0]) ? data.kondisiOpd[0].Jawaban : "";
          if (option == jawaban) {
            radio.setAttribute("checked", "checked");
          }
          radio.setAttribute('disabled', 'disabled');
          let label = document.createElement("label");
          label.setAttribute("for", "jawaban" + index);
          label.innerText = option;

          li.appendChild(radio);
          li.appendChild(label);
          ol.appendChild(li);
        });

        jawabContainer.appendChild(ol);
      } else if (jenis_jawaban_num == 4) {
        let ol = document.createElement("ol");
        ol.setAttribute("type", "A");
        let jawabanOpd = (data.kondisiOpd[0]) ? data.kondisiOpd[0].Jawaban : "";
        // let options = ["A", "B", "C", "D"];
        parameter.forEach((p, i) => {
          let li = document.createElement("li");

          let radio = document.createElement("input");
          radio.setAttribute("type", "radio");
          radio.setAttribute("name", "jawaban");
          // radio.setAttribute("value", options[i]);
          radio.setAttribute("value", p.id);
          radio.setAttribute("id", "jawaban" + i);
          radio.setAttribute("class", "form-check-input");
          if (p.id == jawabanOpd) {
            radio.setAttribute("checked", "checked");
          }
          radio.setAttribute('disabled', 'disabled');
          let label = document.createElement("label");
          label.setAttribute("for", "jawaban" + i);
          label.innerText = "  " + p.nama_parameter;

          li.appendChild(radio);
          li.appendChild(label);
          ol.appendChild(li);
        });

        jawabContainer.appendChild(ol);

      }

      let inputJawaban = $('input[name="jawaban"]');
      let pointInput = $('#point');
      inputJawaban.on("change", function() {
        updatePointInput(jenis_jawaban_num, inputJawaban);
      });

      function updatePointInput(jenis_jawaban_num, inputJawaban) {
        let pointInput = $('#point');
        if (jenis_jawaban_num == 1) {
          pointInput.val(inputJawaban.val());
        } else if (jenis_jawaban_num == 2) {
          pointInput.val((inputJawaban.filter(':checked').val() === 'YA') ? 100 : 0);
        } else if (jenis_jawaban_num == 4) {
          let point = [100, 65, 35, 0];
          let parameterId = inputJawaban.filter(':checked').val();
          let idx = parameter.findIndex(p => p.id == parameterId);
          pointInput.val(point[idx] !== undefined ? point[idx] : 0);
          console.log(parameterId);

          // switch (inputJawaban.filter(':checked').val()) {
          //   case 'A':
          //     pointInput.val(100);
          //     break;
          //   case 'B':
          //     pointInput.val(65);
          //     break;
          //   case 'C':
          //     pointInput.val(35);
          //     break;
          //   case 'D':
          //     pointInput.val(0);
          //     break;
          //   default:
          //     pointInput.val(0);
          //     break;
          // }
        } else {
          pointInput.val(0);
        }
      }

      // updatePointInput(jenis_jawaban_num, inputJawaban);

      if (data.kondisiOpd[0].aprove == 'no') {
        $('#point').val(0);
      } else if (data.kondisiOpd[0].nilai > 0) {
        $('#point').val(data.kondisiOpd[0].nilai);
      } else {
        updatePointInput(jenis_jawaban_num, inputJawaban);
      }


      $('#approval_no').on('click', function() {
        let pointInput = $('#point');
        pointInput.val(0);
      });
      $('#approval_yes').on('click', function() {
        updatePointInput(jenis_jawaban_num, inputJawaban);
      });

    }

    function generateBuktiDukung(data) {
      console.log(idOpd);

      $('#buduk').html('');
      data.bukti_dukung.forEach((b, i) => {
        $('#buduk').append(`
          <strong>${b.bukti_dukung}</strong>
          <ul class="list-group" id="${b.id}">
          </ul>
          <br>
        `);
      });
      data.kondisiOpd.forEach((k, i) => {
        k.bukti.forEach((b, i) => {
          let buduks = `
            <li class="list-group-item d-flex justify-content-between align-items-center">
                <span> <a href="<?= base_url('uploadfile/') ?>${b.files}" target="_blank" class="me-3 icon "><i class="bi bi-file-earmark"></i> ${b.files}</a></span>
                <a href="javascript:void(0);" class="text-danger d-none delete-file" data-file="${b.files}"><i class="bi bi-trash"></i></a>
            </li>
          `;
          $('#' + b.bukti_dukung_id).append(buduks);
        });

      });

      // data.bukti_dukung.forEach((b, i) => {
      //   $('#'+b.id).append(`
      //         <input type="file" name="bukti_dukung[${b.id}]" class="form-control upbuduk" id="input${b.id}" data-id="${b.id}">
      //   `);
      // });

      $('.upbuduk').on('change', function() {
        let id = $(this).data('id');
        let formData = new FormData();
        formData.append('file', $(this)[0].files[0]);
        formData.append('id', id);
        formData.append('idOpd', idOpd);
        formData.append('idIndikator', data.id);
        formData.append('<?= csrf_token() ?>', xYz);

        $.ajax({
          url: '<?= base_url('api/penilaian/uploadBuktiDukung') ?>',
          type: 'POST',
          headers: {
            'Authorization': 'Bearer ' + wXy
          },
          data: formData,
          contentType: false,
          processData: false,
          success: function(res) {
            xYz = res.csrf_token
            $('input[name="<?= csrf_token() ?>"]').val(xYz);
            // generateBuktiDukung(res.data);
            // console.log(res);

          }
        });
      });
    }

  })
</script>


<?= $this->endSection() ?>