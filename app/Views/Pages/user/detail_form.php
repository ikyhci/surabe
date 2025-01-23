<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Tugas Penilaian Mandiri</h3>
    </div>
    <div class="page-content">
              <!--  -->
      <div class="card">

        <div class="card-body">
          <table class="table  mb-0">
            <tbody>
              <tr>
                <td>Detail Form</td>
                <td class="text-end">
                  <a href="<?php echo base_url(); ?>penilaian-mandiri" class="btn btn-primary" id="back"> Kembali</a>
                </td>
              </tr>
              <tr>
                <td>Tahun</td>
                <td>: <?= $dt->tahun;?></td>
              </tr>
              <tr>
                <td>Nama Form</td>
                <td>: <?= $dt->nama_form;?></td>
              </tr>
              <tr>
                <td>Deskripsi</td>
                <td>: <?= $dt->deskripsi;?></td>
              </tr>
              <tr>
                <td>Status Evaluasi</td>
                <td>: <?= $dt->evaluasi;?></td>
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
              </table>
            </div>

            
            <!--  -->
      </div>
     
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<input type="hidden" name="form" id="form" value="<?= $idx;?>">
<!-- popup -->
<?= $this->include('Pages/user/popup') ?>
<script {csp-script-nonce} src="assets/vendors/choices.js/choices.min.js"></script>
    <script {csp-script-nonce} src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.1/js/dataTables.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/dataTables.rowGroup.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/rowGroup.dataTables.js"></script>
    <script {csp-script-nonce} type="text/javascript">
    LoadDatatable() 

    function LoadDatatable(){
      var form = document.getElementById('form').value
      var csrf = document.getElementById('<?= csrf_token() ?>').value;
     
      var t = $('#datatable').DataTable({
          "dom": 'rtip',
          "scrollX": false,
          "processing": true,
          "language": {
            "processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
          },
          "ajax": {
            "url": "<?php echo base_url(); ?>api/get-indikator-penilaian",
            "contentType": 'application/json',
            // "headers": {
            //  'Authorization': 'Bearer '+token
            // },
            "data":{
             "<?= csrf_token() ?>": csrf,
             "form" : form,
            },
            "method": "GET",
            "dataSrc": function(data){
              $('input#<?= csrf_token() ?>').val(data.token_crs)
              return data.dt;

            },
          },
          "columns":[
            {"data": null, defaultContent: ''},
            {"data": "indikator"},
            {
              "render": function(data, type, JsonResultRow, meta) {
                  var btn = '';
                  
                  btn +="<div class='btn-group mb-3 btn-group-sm'>"+
                  
                    "<a href='#'' class='btn icon btn-outline-info detail-indikator' data-idx='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'><path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z'/><path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0'/></svg></a>"
                  +"</div>"
                  return btn;
                }
            },
          ],
          "columnDefs":[
            {
              "className": "dt-center",
              "targets": [0,2]
            }
          ],
          // order: [[2, 'asc']],
          rowGroup: {
              dataSrc: 'sub_sub_aspek'
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

    $(document).on('click', '.detail-indikator', function(){
      var idx = $(this).data('idx')
      $('#Detailparameter').modal('show');
      $.ajax({
        url: '',
        data:{
          idx:idx
        },
        dataType: 'JSON',
        processData : false,
        contentType: false,
        cache: false,
        success: function(data){
          console.log(data)
        },
      })

    })

    function loadPilihanGanda(){
      var data = '<"">';
    }

    function loadLinear(){

    }

    function loadYesNo() {
      
    }
    
  </script>

    
    
<?= $this->endSection() ?>