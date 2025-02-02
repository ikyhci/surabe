<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
    

    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.css">
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Data Penilaian SPBE</h3>
    </div>
    <div class="page-content">
              <!--  -->
      <div class="card">
       <!--  <div class="card-header">
          <h4>Profile Visit</h4>
        </div> -->
        <div class="card-header">
		    <div class="d-flex justify-content-between">
		    	<h6>List Data Parameter</h6>
		    		<a href="#" class="btn btn-outline-primary add-parameter" > 
		    		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">
					  <path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/>
					</svg>
		    	Tambah Data Parameter</a>
		 
		    </div>
		  </div>
        <div class="card-body">
            <!-- <div class="form-group">
                  <select class="choices form-select">
                      <option value="square">Square</option>
                      <option value="rectangle">Rectangle</option>
                      <option value="rombo">Rombo</option>
                      <option value="romboid">Romboid</option>
                      <option value="trapeze">Trapeze</option>
                      <option value="traible">Triangle</option>
                      <option value="polygon">Polygon</option>
                  </select>
                </div>  -->  
            <!-- Data Table  -->
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <!-- <th>Indikator</th> -->
                    <th>Parameter</th>
                    <th>Tahun</th>
                    <th>Active</th>
                    <th>Dibuat</th>
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
<?= $this->include('Pages/soal/popup') ?>

<script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/choices.js/choices.min.js"></script>
    <script {csp-script-nonce} src="<?= base_url('/assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>/assets/vendors/dataTables/dataTables.min.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/dataTables.rowGroup.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/rowGroup.dataTables.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.min.js"></script>
    
    
    <script {csp-script-nonce} type="text/javascript">
$(document).ready(function(){
	// 
	var act = document.getElementById('<?= csrf_token() ?>')
    var token = document.getElementById('token').value;

    
    LoadDatatable()


    // Save Data Parameter
    $(document).on('click', '#savedataparameter', function(){
    	var crs = document.getElementById('<?= csrf_token() ?>').value
    	var fd = new FormData($('#fparameter')[0]);
    	
    	fd.append('<?= csrf_token() ?>',crs);
    	swal({
    		title: "Konfirmasi",
	        text: "Simpan Data Baru?",
	        type: "info",
	        showCancelButton: true,
	        closeOnConfirm: false,
	        showLoaderOnConfirm: true,
	    	}, function(){
	    	$.ajax({
	    		url: "<?php echo base_url();?>api/save-parameter",
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
	            setTimeout(function(){
	            	$("input#<?= csrf_token() ?>").val(data.token_crs);	
		            if (data.success == 1) {
		              swal({
		              	title:"Data Berhasil Di Simpan",
		                text: data.msg,
		                type: "success"
		              }, function(){
		                // reload datatable
		                ReloadData();
		              	}
		              );
		             }else{
		             	swal({
		              	title:"Error",
		                text: data.msg,
		                type: "error"
		              }, function(){
		                ReloadData();
		              	}
		              );
		             }
	            },1000);
	          },
	          error:function(xhr, ajaxOptions, thrownError){
	            setTimeout(function(){
	              swal("Error", "Ops Terjadi Kesalahan : "+thrownError, "error");
	            },500)
	          } 
	        });
    	});
    });

    // Save Indikator
    $(document).on('click', '#savedata', function(){
    	var crs = document.getElementById('<?= csrf_token() ?>').value
    	var fd = new FormData($('#formdata')[0]);
    	fd.append('<?= csrf_token() ?>',crs);
    	var inputs = document.getElementById('datainput').value;
    	var url ='';
    	var text ='';
    	if (inputs == 0 ) {
    		 url = '<?php echo base_url();?>api/save-bukti-dukung'
    		 text = 'Simpan Data Bukti Dukung Baru ?'
    	}

    	if (inputs == 1 ) {
    		 url = '<?php echo base_url();?>api/save-indikator'
    		 text = 'Simpan Data Indikator Baru ?'
    	}
    	if (inputs == 2 ) {
    		 url = '<?php echo base_url();?>api/save-sub-sub-aspek'
    		 text = 'Simpan Data Sub Sub Aspek Baru ?'
    	}
    	if (inputs == 3 ) {
    		 url = '<?php echo base_url();?>api/save-sub-aspek'
    		 text = 'Simpan Data Sub Aspek Baru ?'
    	}
    	if (inputs == 4 ) {
    		 url = '<?php echo base_url();?>api/save-aspek'
    		 text = 'Simpan Data Aspek Baru ?'
    	}
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
	        text: text,
	        type: "info",
	        showCancelButton: true,
	        closeOnConfirm: false,
	        showLoaderOnConfirm: true,
	    	}, function(){
	    		$.ajax({
	    		url: url,
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
	            setTimeout(function(){
	            	$("input#<?= csrf_token() ?>").val(data.token_crs);
		            if (data.success == 1) {
		              swal({
		              	title:"Data Berhasil Di Simpan",
		                text: data.msg,
		                type: "success"
		              }, function(){
		              	$('#add-data').modal('hide');
		              	$('#parameter').modal('show');
		                ReloadData();
		              	}
		              );
		             }else{
		             	swal({
		              	title:"Error",
		                text: data.msg,
		                type: "error"
		              }, function(){
		                ReloadData();
		              	}
		              );
		             }
	            },1000);
	          },
	          error:function(xhr, ajaxOptions, thrownError){
	            setTimeout(function(){
	              swal("Error", "Ops Terjadi Kesalahan : "+thrownError, "error");
	            },500)
	          } 
	        });
	    	});
      }
    	
    	
    });

    $(document).on('click', '.add-parameter', function(){
    	loadaspek(1);
    	$('#parameter').modal('show');

    })

    $(document).on('click', '.add-indikator', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Indikator'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputindikator();
    	loadaspek(2)
    	loadJawaban()
    	$('#add-data').modal('show');
    	
    })

    $(document).on('click', '.add-sub-sub-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Sub Sub Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputsubsubaspek();
    	loadaspek(2)
    	$('#add-data').modal('show');
    	

    })
    $(document).on('click', '.add-sub-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Sub Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputsubaspek();
    	loadaspek(2)
    	$('#add-data').modal('show');
    	
    	
    })
    $(document).on('click', '.add-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputaspek();
    	loadaspek(2)
    	$('#add-data').modal('show');
    	
    	
    })

    $(document).on('click', '.indikator-plus', function(){
    	var idx = $(this).data('id_indikator');
    	var nmx = $(this).data('indikator');
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Bukti Dukung'
    	$('#view-data').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputbuktidukung(idx,nmx);
    	loadaspek(2)
    	$('#add-data').modal('show');
    	
    })

    // Edit Data

    $(document).on('click', '.edit-parameter', function(){
    	var idx = $(this).data('prmt')
    	var ind = $(this).data('ind')
    	let inputs = document.getElementById('content-edit');
    	document.getElementById('title-edit').innerHTML = 'Edit Data Parameter'
    	inputs.innerHTML = '';
    	inputs.innerHTML = editData(idx,ind);
    	$('#edit-data').modal('show');
    })


    // end

    function loadaspek(nums) {
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	
    	$.ajax({
				url: '<?php echo base_url();?>api/get-aspek',
				type:'GET',
				headers: {
		            'Authorization': 'Bearer '+token
		         },
		        data:{
					<?= csrf_token() ?>: csrf
				},
				dataType: 'json',
				success: function(res){
					if (nums == 1) {
						$("#aspek").find('option').remove();
						$("#aspek").append('<option value="" selected disabled>Choose...</option>');
						$("#aspek").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#aspek").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_aspek + '</option>');
						}
					}
					if (nums == 2) {
						$("#aspek1").find('option').remove();
						$("#aspek1").append('<option value="" selected disabled>Choose...</option>');
						$("#aspek1").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#aspek1").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_aspek + '</option>');
						}
					}
					
				}
			});
    }

    function loadJawaban(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	$.ajax({
				url: '<?php echo base_url();?>api/get-jenis-jawaban',
				type:'GET',
				headers: {
		            'Authorization': 'Bearer '+token
		         },
		        data:{
					<?= csrf_token() ?>: csrf
				},
				dataType: 'json',
				success: function(res){
						$("#jjwb").find('option').remove();
						$("#jjwb").append('<option value="" selected disabled>Choose...</option>');
						$("#jjwb").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#jjwb").append('<option value=' + res.dt[i].id + '>' + res.dt[i].jenis_jawaban + '</option>');
						}
				}
			});
    }


    function inputbuktidukung(idx, nmx){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate> <input type="hidden" value="0" id="datainput"><input type="hidden" value="'+idx+'" name="indkt" id="indkt"><h6>Indikator :</h6>'+

    		'<div class="alert alert-light">'+nmx+'.</div>'+
    			'<div class="form-group">'+
                '<h6>Nama Bukti Dukung <span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Bukti Dukung" required>'+
               '</div></form>';

       return inpx;
    }


    function inputindikator(){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate> <input type="hidden" value="1" id="datainput">'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek1" required></select>'+
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek1" required></select>'+ 
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subsubaspek" id="subsubaspek1" required></select>'+
                        '</div></div>'+
                    '<div class="form-group">'+
                        '<h6>Nama Indikator <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Indikator" required>'+
                    '</div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Jenis Jawaban <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="jjwb" id="jjwb" required></select>'+
                        '</div></div></form>';
        return inpx;
    }

    function inputsubsubaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="2" id="datainput">'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek1" required></select>'+
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek1" required></select>'+ 
                        '</div></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+
                    
                    '<div class="form-group">'+
                        '<h6>Nama Sub Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama sub sub aspek" required>'+
                    '</div></form>';
        return inpx;
    }

    function inputsubaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="3" id="datainput">'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek1" required></select>'+
                        '</div></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+
                    '<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama sub sub aspek" required>'+
                    '</div></form>';
        return inpx;
    }

    function inputaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="4" id="datainput">'+

                    '<div class="form-group">'+
                        '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Aspek" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Tahun <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="tahun" name="tahun" placeholder="Tahun" required></div>'+
                         '<div class="form-group">'+
                        '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="namaform" name="namaform" placeholder="Nama Form" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Evaluasi <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="eval" name="eval" placeholder="Evaluasi" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Deskripsi <span class="text-danger">*</span></h6>'+
                        '<textarea type="text" class="form-control" id="desk" name="desk" placeholder="Deskripsi" required></textarea></div>'+
                        '<div class="form-group">'+
                        '<h6>Batas Waktu <span class="text-danger">*</span></h6>'+
                        '<input type="datetime-local" class="form-control" id="wkt" name="wkt" placeholder="Batas Waktu" required></div>'+

                        '</form>';
        return inpx;
    }


    function editData(idx, nmx) {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" id="datainput" value="'+nmx+'">'+

    		'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

    		'<div class="alert alert-light">'+nmx+'.</div>'+
    			'<div class="form-group">'+
                '<h6>Nama Parameter<span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Parameter" required>'+
               '</div></form>';

               return inpx;
    }

    // end template


    function ReloadData() {
			var t = $("#datatable").DataTable();
			t.ajax.reload(null, false);
		}

    function LoadDatatable(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
      	var t = $('#datatable').DataTable({
	        "dom": 'rtip',
	        "scrollX": false,
			"processing": true,
			"language": {
						"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
					"ajax": {
						"url": "<?php echo base_url(); ?>api/get-penilaian-spbe",
						"contentType": 'application/json',
						"headers": {
							'Authorization': 'Bearer '+token
						},
						"data":{
							<?= csrf_token() ?>: csrf
						},
						"method": "GET",
						"dataSrc": function(data){
							
							$('input#<?= csrf_token() ?>').val(data.token_crs)
							return data.dt;

						},
					},
					"columns":[
						{"data": null, defaultContent: ''},
						
						{"data": "nama_parameter"},
						{"data": "tahun"},
						{"data": "res"},
						{"data": "create_at"},
						{
							"render": function(data, type, JsonResultRow, meta) {
									var btn = '';
									
									btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
										"<button class='btn icon btn-outline-warning edit-parameter' data-indk='" + JsonResultRow.id + "' data-ind='"+JsonResultRow.indikator+"' data-prmt='"+JsonResultRow.id_parameter+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+
										"<button class='btn icon btn-outline-danger hapus-parameter' data-indk='" + JsonResultRow.id + "' data-prmt='"+JsonResultRow.id_parameter+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"

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
    
// 
})
  </script>

<?= $this->include('Pages/soal/add_scr') ?>

  <script {csp-script-nonce} type="text/javascript">
  	//change select box
$(document).ready(function(){
	var token = document.getElementById('token').value;

	$(document).on('change', '#aspek', function(){
		var csrf = document.getElementById('<?= csrf_token() ?>').value
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-sub-aspek',
					headers: {
			            'Authorization': 'Bearer '+token
			         },
					data:{
						idx :valueSelected,
						<?= csrf_token() ?>: csrf
					},
					type:'GET',
					dataType: 'json',
					success: function(res){
					
						$("#subaspek").find('option').remove();
						$("#subaspek").append('<option value="" selected disabled>Choose...</option>');
						$("#subaspek").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#subaspek").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_sub_aspek + '</option>');
						}
					}
				});
			}
    });

    // 
    $(document).on('change', '#subaspek', function(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					headers: {
			            'Authorization': 'Bearer '+token
			         },
					url: '<?php echo base_url();?>api/get-sub-sub-aspek',
					data:{
						idx :valueSelected,
						<?= csrf_token() ?>: csrf
					},
					type:'GET',
					dataType: 'json',
					success: function(res){
					
						$("#subsubaspek").find('option').remove();
						$("#subsubaspek").append('<option value="" selected disabled>Choose...</option>');
						$("#subsubaspek").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#subsubaspek").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_sub_sub_aspek + '</option>');
						}
					}
				});
			}
    	
    });
    // 
    $(document).on('change', '#subsubaspek', function(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
	
			if (valueSelected != '') {
				$.ajax({
					headers: {
			            'Authorization': 'Bearer '+token
			         },
					url: '<?php echo base_url();?>api/get-indikator',
					data:{
						idx :valueSelected,
						<?= csrf_token() ?>: csrf
					},
					type:'GET',
					dataType: 'json',
					success: function(res){
					
						$("#indikator").find('option').remove();
						$("#indikator").append('<option value="" selected disabled>Choose...</option>');
						$("#indikator").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#indikator").append('<option value=' + res.dt[i].id + '>' + res.dt[i].indikator + '</option>');
						}
					}
				});
			}
    	
    });



    // Tambah Data Indikator
    $(document).on('change', '#aspek1', function(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({

					url: '<?php echo base_url();?>api/get-sub-aspek',
					headers: {
			            'Authorization': 'Bearer '+token
			         },
					data:{
						idx :valueSelected,
						<?= csrf_token() ?>: csrf
					},
					type:'GET',
					dataType: 'json',
					success: function(res){
					
						$("#subaspek1").find('option').remove();
						$("#subaspek1").append('<option value="" selected disabled>Choose...</option>');
						$("#subaspek1").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#subaspek1").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_sub_aspek + '</option>');
						}
					}
				});
			}
    });
    // ////
    $(document).on('change', '#subaspek1', function(){
    	var csrf = document.getElementById('<?= csrf_token() ?>').value
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					headers: {
			            'Authorization': 'Bearer '+token
			         },
					url: '<?php echo base_url();?>api/get-sub-sub-aspek',
					data:{
						idx :valueSelected,
						<?= csrf_token() ?>: csrf
					},
					type:'GET',
					dataType: 'json',
					success: function(res){
					
						$("#subsubaspek1").find('option').remove();
						$("#subsubaspek1").append('<option value="" selected disabled>Choose...</option>');
						$("#subsubaspek1").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#subsubaspek1").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_sub_sub_aspek + '</option>');
						}
					}
				});
			}
    	
    });
})

  </script>


    
    
<?= $this->endSection() ?>