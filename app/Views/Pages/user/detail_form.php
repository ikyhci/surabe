<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.css">
   

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
                  <a href="<?php echo base_url(); ?>dashboard/penilaian-mandiri" class="btn btn-primary" id="back"> Kembali</a>
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
     <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.min.js"></script>
    
    <script {csp-script-nonce} type="text/javascript">
      $(document).ready(function(){
        var token = document.getElementById('token').value;
         LoadDatatable() 

         $(document).on('click' , '#savedata', function(){
          var crs = document.getElementById('<?= csrf_token() ?>').value
          var fd = new FormData($('#formdata')[0]);
          fd.append('<?= csrf_token() ?>',crs);

          var form = document.getElementById('formdata');
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
            form.classList.add('was-validated');
          }else{
            event.preventDefault();
            event.stopPropagation();
            form.classList.add('was-validated');
            swal({
              title: "Konfirmasi",
              text: 'Simpan Jawaban!',
              type: "info",
              showCancelButton: true,
              closeOnConfirm: false,
              showLoaderOnConfirm: true,
              }, function(){
                $.ajax({
                  url: '<?php echo base_url();?>api/save-jawaban',
                  type: "POST",
                  dataType: "JSON",
                  headers: {
                    'Authorization': 'Bearer '+token
                  },
                  data: fd,
                  processData : false,
                  contentType: false,
                  cache: false,
                  success:function(data){
                    $('input#<?= csrf_token() ?>').val(data.token_crs)
                    setTimeout(function(){
                      if (data.success == 1) {
                        swal('success','Data Berhasil Di Simpan','success');
                      }else{
                        swal({
                          title:"Error",
                          text: data.msg,
                          type: "error"
                        });
                      }

                      },1000)

                  },
                })
              })
          }
          
         })

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
                  "headers": {
                   'Authorization': 'Bearer '+token
                  },
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
                        var btncl = '';
                        if (JsonResultRow.tombol == 1) {
                          btncl = 'btn-outline-success'
                        }else{
                          btncl = 'btn-outline-warning'
                        }
                        
                        btn +="<div class='btn-group mb-3 btn-group-sm'>"+
                        
                          "<button class='btn icon "+btncl+" detail-indikator' data-idx='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'><path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z'/><path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0'/></svg></button>"
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
            var crs = document.getElementById('<?= csrf_token() ?>').value
            var fd = new FormData();
            fd.append('<?= csrf_token() ?>',crs);
            fd.append('idx',idx);
            $.ajax({
              url: '<?php echo base_url(); ?>api/get-detail-indikator',
              headers: {
                    'Authorization': 'Bearer '+token
                  },
              data:fd,
              type: "POST",
              dataType: "JSON",
              processData : false,
              contentType: false,
              cache: false,
              success: function(data){
                $('input#<?= csrf_token() ?>').val(data.token_crs)
                console.log(data)
                if (data.dt.indk.tombol == 0) {
                  document.getElementById('tblfoot').innerHTML = 
                  '<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">'+
                    '<i class="bx bx-x d-block d-sm-none"></i>'+
                    '<span class="d-none d-sm-block">Close</span>'+
                '</button>'+
                '<button type="button" class="btn btn-primary ml-1" id="savedata">'+
                  '<i class="bx bx-check d-block d-sm-none"></i>'+
                  '<span class="d-none d-sm-block">Save</span>'+
                '</button>';
                }
                if (data.dt.indk.tombol == 1) {
                  document.getElementById('tblfoot').innerHTML = 
                  '<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">'+
                    '<i class="bx bx-x d-block d-sm-none"></i>'+
                    '<span class="d-none d-sm-block">Close</span>'+
                '</button>';

                }
                document.getElementById('aspk').innerHTML = ': '+data.dt.indk.aspek
                document.getElementById('indk').innerHTML = ': '+data.dt.indk.indikator
                if (data.dt.indk.num == 1 ) {
                  // linear
                  loadPilihanGanda(data.dt.prmt, data.dt.btdk, data.dt.indk.jwbx)
                }
                if (data.dt.indk.num == 2 ) {
                  // yesno
                  loadYesNo(data.dt.prmt, data.dt.btdk, data.dt.indk.jwbx)
                }
                if (data.dt.indk.num == 4 ) {
                  //pilihan ganda
                  loadPilihanGanda(data.dt.prmt, data.dt.btdk, data.dt.indk.jwbx)
                  
                }
                
                $('#Detailparameter').modal('show');
              },
            })

          })

          function loadPilihanGanda(data,dkn, jwb){
            var str = '<ol type="A">'
            var plh = '';
            var upl = '';
            var flx = '<ol type="*">';

             for (var i = 0; i < data.length; i++) {
               str += '<li>'+data[i].nama_parameter+'</li>'
               plh += '<option value="'+String.fromCharCode(65+i)+'">'+String.fromCharCode(65+i)+'</option>'
             }


            for (var i = 0; i < dkn.length; i++) {
                if (dkn[i].filesx === '0') {
                  upl +='<li><div class="form-group"><label>'+dkn[i].bukti_dukung+'</label><input id="file'+i+'" type="file" name="'+dkn[i].id+'" class="form-control" ><small>Max file size 6 MB</small></div></li>'
                }else{
                  upl +='<li><div class="form-group"><label>'+dkn[i].bukti_dukung+'</label></div></li>'
                  flx += '<li><div class="form-group"><a href="<?php echo base_url();?>uploadfile/'+dkn[i].filesx+'" target="_blank">'+dkn[i].bukti_dukung+'</a></div></li>'
                }
              
             }
             

              str += '</ol>';
              str += '<form id="formdata" enctype="multipart/form-data">'+
                        '<input type="hidden" name="indikator" value="'+dkn[0].id_indikator+'">'+
                        '<div class="col-md-12 mb-6">'+
                          '<div class="form-group"><h6>Jawaban <span class="text-danger">*</span></h6>'+
                          '<select class=" form-select" name="jwbn" id="jwb" required>'+
                            '<option selected disabled value="">Choose...</option>'+ 
                            plh+              
                          '</select>'+
                        '</div></div>'+
                        '<h6>Bukti Dukung : </h6>'+
                         '<div class="row">'+
                            '<div class="col-sm-12"><ol>'+
                              upl+
                            '</ol></div>'+
                          '</div>'+
                        
                      '</form>';

                flx += '</ol>';



            document.getElementById('content-form').innerHTML = str;
            document.getElementById('content-upload').innerHTML = flx;
            $("#jwb").val(jwb).trigger('change')
          }

          function loadLinear(){

          }

          function loadYesNo(data,dkn,jwb) {
            var str = '<ol type="*">'
            var plh = '';
            var upl = '';
            var flx = '<ol type="*">';

             for (var i = 0; i < data.length; i++) {
               str += '<li>'+data[i].nama_parameter+'</li>'
              
             }

             for (var i = 0; i < dkn.length; i++) {
                if (dkn[i].filesx === '0') {
                  upl +='<li><div class="form-group"><label>'+dkn[i].bukti_dukung+'</label><input id="file'+i+'" type="file" name="'+dkn[i].id+'" class="form-control" ><small>Max file size 6 MB</small></div></li>'
                }else{
                  upl +='<li><div class="form-group"><label>'+dkn[i].bukti_dukung+'</label></div></li>'
                  flx += '<li><div class="form-group"><a href="<?php echo base_url();?>uploadfile/'+dkn[i].filesx+'" target="_blank">'+dkn[i].bukti_dukung+'</a></div></li>'
                }
              
             }



              str += '</ol>';
              str += '<form id="formdata" enctype="multipart/form-data">'+
                        '<input type="hidden" name="indikator" id="indikator" value="'+dkn[0].id_indikator+'">'+
                        '<div class="col-md-12 mb-6">'+
                          '<div class="form-group"><h6>Jawaban <span class="text-danger">*</span></h6>'+
                            '<div class="form-check">'+
                                '<input class="form-check-input" value="YA" type="radio" name="jwbn" id="jwb1" required>'+
                                  '<label class="form-check-label" for="flexRadioDefault1">YA</label></div>'+
                            '<div class="form-check">'+
                                '<input class="form-check-input" value="TIDAK" type="radio" name="jwbn" id="jwb2" required>'+
                                        '<label class="form-check-label" for="flexRadioDefault1">TIDAK</label></div>'+
                        '</div></div>'+
                        '<h6>Bukti Dukung : </h6>'+
                         '<div class="row">'+
                            '<div class="col-sm-12"><ol>'+
                              upl+
                            '</ol></div>'+
                          '</div>'+
                        
                      '</form>';

            flx += '</ol>';

            document.getElementById('content-form').innerHTML = str;
            document.getElementById('content-upload').innerHTML = flx;

            if (jwb === 'YA') {
              document.getElementById('jwb1').checked = true;
            }
            if (jwb === 'TIDAK') {
              document.getElementById('jwb2').checked = true;
            }
          }

      })
  </script>    

    
<?= $this->endSection() ?>