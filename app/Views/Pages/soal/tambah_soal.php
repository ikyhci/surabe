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
    <script {csp-script-nonce} src="<?php echo base_url();?>/assets/js/pages/soal.js"></script>

<?= $this->include('Pages/soal/add_scr') ?>

  <script {csp-script-nonce}  type="text/javascript">
  	//update function
  	$(document).ready(function(){
  		

  		$(document).on('click', '.edit-parameter', function(){
  			var t = $('#datatable').DataTable();
  			var data = t.row($(this).closest('tr')).data();

	    	var idx = $(this).data('prmt')
	    	var ind = $(this).data('ind')
	    	let inputs = document.getElementById('content-edit');
	    	document.getElementById('title-edit').innerHTML = 'Edit Data Parameter'
	    	inputs.innerHTML = '';
	    	inputs.innerHTML = editDataparameter(idx,ind,data[Object.keys(data)[5]]);
	    	
	    	$('#edit-data').modal('show');
	    })

	    function editDataparameter(idx, nmx, prmt) {
	    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" id="datainput" value="'+nmx+'">'+

	    		'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    		'<div class="alert alert-light">'+nmx+'.</div>'+
	    			'<div class="form-group">'+
	                '<h6>Nama Parameter<span class="text-danger">*</span></h6>'+
	                '<textarea type="text" class="form-control" id="nama" name="nama" placeholder="Nama Parameter" required>'+prmt+'</textarea>'+
	               '</div></form>';

	               return inpx;
	    }

	    function editDataIndikator(){

	    }

	    function editDataSubSubAspek(){

	    }

	    function editDataSubAspek(){

	    }

	    function editDataAspek(){
	    	
	    }

  	})
  </script>


    
    
<?= $this->endSection() ?>