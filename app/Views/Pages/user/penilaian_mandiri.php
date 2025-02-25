<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Tugas Penilaian Mandiri</h3>
    </div>
    <div class="page-content">
              <!--  -->
      <div class="card">
       <!--  <div class="card-header">
          <h4>Profile Visit</h4>
        </div> -->
        <div class="card-body">
            <div class="form-group">
           
                  <select class="choices form-select" id="pilih-tahun">
                      <option value="" selected disabled>-- Pilih Tahun Form --</option>
                      <?php 

                      foreach ($thn as $key ): 
                        ?>

                        <option value="<?=$key;?>"><?=$key;?></option>
                      <?php endforeach ?>
                  </select>
                </div>   
            <!-- Data Table  -->
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Tahun</th>
                    <th>Nama Form</th>
                    <th>Tahap Form</th>
                    <th>Batas Waktu</th>
                    <th>Kemajuan</th>
                    <th>Aksi</th>
                  </tr>
                  
                </thead>
              </table>
            </div>

            
            <!--  -->
      </div>
     
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<!-- popup -->
<?= $this->include('Pages/user/popup') ?>
<script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/choices.js/choices.min.js"></script>
    <script {csp-script-nonce} src="<?= base_url('/assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/dataTables/dataTables.min.js"></script>
    <script {csp-script-nonce} type="text/javascript">
    var token = document.getElementById('token').value;

    $(document).change('#pilih-tahun', function(){
      
      var optionSelected = $(this).find("option:selected");
      var valueSelected  = optionSelected.val();
      LoadDatatable(valueSelected); 
    })
    
    LoadDatatable(); 
    
    function reloadTable(){
      var t = $("#datatable").DataTable();
      t.ajax.reload(null, false);
    }

    function LoadDatatable(thn){
      var csrf = document.getElementById('<?= csrf_token() ?>').value;
      var t = $('#datatable').DataTable({
          "dom": 'rtip',
          "scrollX": false,
          "processing": true,
          "destroy": true,
          "language": {
            "processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
          },
          "ajax": {
            "url": "<?php echo base_url(); ?>api/get-penilaian-mandiri",
            "contentType": 'application/json',
            "headers": {
              'Authorization': 'Bearer '+token
            },
            "data":{
              <?= csrf_token() ?>: csrf,
              'thn': thn
            },
            "method": "GET",
            "dataSrc": function(data){
              
              $('input#<?= csrf_token() ?>').val(data.token_crs)
              return data.dt;
            },
          },
          "columns":[
            {"data": null, defaultContent: ''},
            
            {"data": "tahun"},
            // {"data": "indikator"},
            {"data": "nama_form"},
            {"data": "tahapan"},
            {"data": "batas_waktu"},
            {"data": "kemajuan"},
            {
              "render": function(data, type, JsonResultRow, meta) {
                  var btn = '';
                  
                  btn +="<div class='btn-group mb-3 btn-group-sm'>"+
                  
                    "<button class='btn icon btn-outline-info detail-form' data-id_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-info-circle' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16'/><path d='m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0'/></svg></button>"
                  +"</div>"
                  return btn;
                }
            },
          ],
          "columnDefs":[
            {
              "className": "dt-center",
              "targets": [0,2,3,4,5]
            }
          ],
          // order: [[2, 'asc']],
          rowGroup: {
              dataSrc: 'indikator'
          }
      });
      t.on('order.dt search.dt', function() {
      t.column(0, {
        search: 'applied',
        order: 'applied'
      }).nodes().each(function(cell, i) {
        cell.innerHTML = i + 1;
      });
    }).draw();
    }

    $(document).on('click', '.detail-form', function(){
      var csrf = document.getElementById('<?= csrf_token() ?>').value;
      var fd = new FormData();
      fd.append('<?= csrf_token() ?>' , csrf);
      var idx = $(this).data('id_aspek');
      fd.append('idx' , idx);
      $.ajax({
        url: "<?php echo base_url();?>dashboard/get-detail-form",
        type: "POST",
        dataType: "JSON",
        headers: {
          'Authorization': 'Bearer '+token
        },
        data: fd,
        processData : false,
        contentType: false,
        cache: false,
        success: function(data){
    
          $('input#<?= csrf_token() ?>').val(data.token_crs);
          setTimeout(function(){
                  ///
            if (data.success == 1) {
              window.location.href = "<?php echo base_url();?>"+data.dt;
            }else{
              swal("Error", "Ops Terjadi Kesalahan : "+data.msg, "error");
            }

            },500)
        }
      })
    })
    
  </script>
    
    
<?= $this->endSection() ?>