<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
    

    <link {csp-style-nonce} rel="stylesheet" href="assets/vendors/sweetalert/sweetalert.css">
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
		    	List Data	
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

<script {csp-script-nonce} src="assets/vendors/choices.js/choices.min.js"></script>
    <script {csp-script-nonce} src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.1/js/dataTables.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/dataTables.rowGroup.js"></script>
     <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/rowGroup.dataTables.js"></script>
    <script {csp-script-nonce} src="assets/vendors/sweetalert/sweetalert.min.js"></script>
    
    
    <script {csp-script-nonce} type="text/javascript">
    	var act = document.getElementById('<?= csrf_token() ?>')
    	
    	var token = document.getElementById('token').value;

    
    LoadDatatable()


    // Save Data Parameter
    $(document).on('click', '#savedataparameter', function(){
    	var crs = document.getElementById('<?= csrf_token() ?>').value
    	var fd = new FormData($('#fparameter')[0]);
    	console.log(<?= csrf_token() ?>+':'+crs)
    	fd.append('<?= csrf_token() ?>',crs);
    	swal({
    		title: "Konfirmasi",
        text: "Simpan Parameter Baru?",
        type: "info",
        showCancelButton: true,
        closeOnConfirm: false,
        showLoaderOnConfirm: true,
    	}, function(){
    		$.ajax({
    			url: "<?php echo base_url();?>api/save-parameter",
          type: "POST",
          dataType: "JSON",
          // headers: {
          //   'Authorization': 'Bearer '+token
          // },
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
    $(document).on('click', '#savedataindikator', function(){
    	var crs = document.getElementById('<?= csrf_token() ?>').value
    	var fd = new FormData($('#findikator')[0]);
    	fd.append('<?= csrf_token() ?>',crs);

    	swal({
    		title: "Konfirmasi",
        text: "Simpan Indikator Baru?",
        type: "info",
        showCancelButton: true,
        closeOnConfirm: false,
        showLoaderOnConfirm: true,
    	}, function(){
    		$.ajax({
    			url: "<?php echo base_url();?>api/save-indikator",
          type: "POST",
          dataType: "JSON",
          // headers: {
          //   'Authorization': 'Bearer '+token
          // },
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

    $(document).on('click', '.add-parameter', function(){
    	loadaspek(4)
    	$('#parameter').modal('show');

    })



    $(document).on('click', '.add-indikator', function(){
    	$('#parameter').modal('hide');
    	loadaspek(3)
    	$('#adindikator').modal('show');
    })

    $(document).on('click', '.savedataindikator', function(){

    })

    function loadaspek(nums) {
    	$.ajax({
				url: '<?php echo base_url();?>api/get-aspek',
				type:'GET',
				dataType: 'json',
				success: function(res){
					// var aspk = 
					if (nums == 4) {
						$("#aspek").find('option').remove();
						$("#aspek").append('<option value="" selected disabled>Choose...</option>');
						$("#aspek").val("").trigger('change')
						for (var i = res.dt.length - 1; i >= 0; i--) {
							$("#aspek").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_aspek + '</option>');
						}
					}
					if (nums == 3) {
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


    function ReloadData() {
			var t = $("#datatable").DataTable();
			t.ajax.reload(null, false);
		}

    function LoadDatatable(){

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
						// "headers": {
						// 	'Authorization': 'Bearer '+token
						// },
						// "data":{
						// 	<?= csrf_token() ?>: csrf
						// },
						"method": "GET",
						"dataSrc": function(data){
							$('input#<?= csrf_token() ?>').val(data.token_crs)
							return data.dt;

						},
					},
					"columns":[
						{"data": null, defaultContent: ''},
						
						{"data": "nama_parameter"},
						// {"data": "indikator"},
						{"data": "tahun"},
						{"data": "res"},
						{"data": "create_at"},
						{
							"render": function(data, type, JsonResultRow, meta) {
									var btn = '';
									
									btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
										"<a href='#'' class='btn icon btn-outline-warning' data-id_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></a>"+
										"<a href='#'' class='btn icon btn-outline-danger' data-id_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></a>"

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
    
  </script>

  <?php include 'add_scr.php';?>

  <script  {csp-script-nonce} type="text/javascript">
  	//Tambah Data Parameter

  	$(document).on('change', '#aspek', function(){
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-sub-aspek',
					data:{
						idx :valueSelected
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
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-sub-sub-aspek',
					data:{
						idx :valueSelected
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
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
	
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-indikator',
					data:{
						idx :valueSelected
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
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-sub-aspek',
					data:{
						idx :valueSelected
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
    	var optionSelected = $(this).find("option:selected");
			var valueSelected  = optionSelected.val();
			var textSelected   = optionSelected.text();
			
			if (valueSelected != '') {
				$.ajax({
					url: '<?php echo base_url();?>api/get-sub-sub-aspek',
					data:{
						idx :valueSelected
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

    

  </script>


    
    
<?= $this->endSection() ?>