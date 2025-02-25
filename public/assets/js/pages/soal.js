$(document).ready(function(){
	let httpProtocol = window.location.protocol;
	let host = window.location.host;
	let urlx = httpProtocol+'//'+host;
	//global variable
	// var urlx = 'http://localhost:8080/';
	var token = document.getElementById('token').value;
	var csrf = document.getElementById('csrf_token')

	LoadParameter()

	// function add data 
	//////////////////////////////////////////////////////////

    $(document).on('click', '.add-rb', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data RB'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputrb();
    	$('#add-data').modal('show');
    })

    $(document).on('click', '.add-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputaspek();
    	loadrb()
    	$('#add-data').modal('show');
    })

    $(document).on('click', '.add-sub-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Sub Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputsubaspek();
    	loadrb()
    	$('#add-data').modal('show');
    })

    $(document).on('click', '.add-sub-sub-aspek', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Sub Sub Aspek'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputsubsubaspek();
    	loadrb()
    	$('#add-data').modal('show');
    })

    $(document).on('click', '.add-indikator', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Indikator'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputindikator();
    	loadrb()
    	loadJawaban()
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
    	loadrb()
    	$('#add-data').modal('show');
    })

    $(document).on('click', '.add-parameter', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Parameter'
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputParameter();
    	loadrb()
    	$('#add-data').modal('show');
    })

    // function on change combobox
    /////////////////////////////////////
    $(document).on('change','#rb', function(){
    	var optionSelected = $(this).find("option:selected");
		var valueSelected  = optionSelected.val();
		var textSelected   = optionSelected.text();
		if (valueSelected != '') {
			$.ajax({
				url: urlx+'/api/get-aspek',
				type:'GET',
				headers: {
			        'Authorization': 'Bearer '+token
			    },
			    data:{
					csrf_token: csrf.value,
					idx : valueSelected
				},
				dataType: 'json',
				success: function(res){	
					
					csrf.value = res.token_crs	
					$("#aspek").find('option').remove();
					$("#aspek").append('<option value="" selected disabled>Choose...</option>');
					$("#aspek").val("").trigger('change')
					for (var i = res.dt.length - 1; i >= 0; i--) {
						$("#aspek").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama_aspek + '</option>');
					}
				}
			});

		}
	})

	$(document).on('change', '#aspek', function(){
    	var optionSelected = $(this).find("option:selected");
		var valueSelected  = optionSelected.val();
		var textSelected   = optionSelected.text();
		if (valueSelected != '') {
			$.ajax({
				url: urlx+'/api/get-sub-aspek',
				headers: {
			    	'Authorization': 'Bearer '+token
			    },
				data:{
					idx :valueSelected,
					csrf_token: csrf.value,
				},
				type:'GET',
				dataType: 'json',
				success: function(res){	
					csrf.value = res.token_crs
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

    $(document).on('change', '#subaspek', function(){
    	
    	var optionSelected = $(this).find("option:selected");
		var valueSelected  = optionSelected.val();
		var textSelected   = optionSelected.text();
		if (valueSelected != '') {
			$.ajax({
				headers: {
			        'Authorization': 'Bearer '+token
			    },
				url: urlx+'/api/get-sub-sub-aspek',
				data:{
					idx :valueSelected,
					csrf_token: csrf.value,
				},
				type:'GET',
				dataType: 'json',
				success: function(res){	
					csrf.value = res.token_crs
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

    $(document).on('change', '#subsubaspek', function(){
    	
    	var optionSelected = $(this).find("option:selected");
		var valueSelected  = optionSelected.val();
		var textSelected   = optionSelected.text();
		if (valueSelected != '') {
			$.ajax({
				headers: {
			    	'Authorization': 'Bearer '+token
			    },
				url: urlx+'/api/get-indikator',
				data:{
					idx :valueSelected,
					csrf_token: csrf.value,
				},
				type:'GET',
				dataType: 'json',
				success: function(res){
					csrf.value = res.token_crs
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

    // function Load Ajax data 
	//////////////////////////////////////////////////////////

	function loadrb() {
    	// var csrf = document.getElementById('<?= csrf_token() ?>').value
    	$.ajax({
    		url: urlx+'/api/get-rb',
    		type: 'GET',
    		headers: {
    			'Authorization': 'Bearer '+token
    		},
    		data: {
    			csrf_token: csrf.value
    		},
    		dataType: 'JSON',
    		success: function(res){
    			csrf.value = res.token_crs
    			$('#rb').find('option').remove()
    			$('#rb').append('<option value="" selected disabled>Choose...</option>');
    			$('#rb').val("").trigger('change')
    			for (var i = res.dt.length - 1; i >= 0; i--) {
    				$("#rb").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama + '</option>');
    			}
    		},
    	})
    }

    function loadJawaban(){
    	// var csrf = document.getElementById('<?= csrf_token() ?>').value
    	$.ajax({
				url: urlx+'/api/get-jenis-jawaban',
				type:'GET',
				headers: {
		            'Authorization': 'Bearer '+token
		         },
		        data:{
					csrf_token: csrf.value
				},
				dataType: 'json',
				success: function(res){
					csrf.value = res.token_crs
					$("#jjwb").find('option').remove();
					$("#jjwb").append('<option value="" selected disabled>Choose...</option>');
					$("#jjwb").val("").trigger('change')
					for (var i = res.dt.length - 1; i >= 0; i--) {
						$("#jjwb").append('<option value=' + res.dt[i].id + '>' + res.dt[i].jenis_jawaban + '</option>');
					}
				}
			});
    }


    // function View data 
	//////////////////////////////////////////////////////////

	$(document).on('click', '.view-rb', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data RB'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatRB()
		loadRB()
	})

	$(document).on('click', '.view-aspek', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Aspek'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatAspek()
		loadaspek()
	})

	$(document).on('click', '.view-sub-aspek', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Sub Aspek'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatSubaspek()
		loadsubaspek()
	})

	$(document).on('click', '.view-sub-sub-aspek', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Sub Sub Aspek'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatSubsubaspek()
		loadsubsubaspek()
	})

	$(document).on('click', '.view-indikator', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Indikator'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatIndikator()
		loadindikator()
	})

	$(document).on('click', '.indikator-view', function(){
		var idx = $(this).data('id_indikator')
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Bukti Dukung'
		$('#view-data').modal('hide');
		setTimeout(function(){
			tabls.innerHTML ='';
			tabls.innerHTML = formatbuktidukung()
			loadbuktidukung(idx)
			$('#view-data').modal('show');
		},500)
	})

	// function Edit Data 
	//////////////////////////////////////////////////////////

	$(document).on('click', '.rb-edit', function() {
	    var t = $('#tbl-rb').DataTable();
  		var data = t.row($(this).closest('tr')).data();

  		var idx = $(this).data('id')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data RB'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataRB(idx,data[Object.keys(data)[3]],data[Object.keys(data)[4]]);
	    $('#add-data').modal('show');
	})

	$(document).on('click','.aspek-edit', function(){
	    var t = $('#tbl-aspek').DataTable();
  		var data = t.row($(this).closest('tr')).data();

  		var idx = $(this).data('id_aspek')
  		var idr = $(this).data('id_rb')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Aspek'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataAspek(idr, idx,
	    	data[Object.keys(data)[4]],
	    	data[Object.keys(data)[7]],
	    	data[Object.keys(data)[3]],
	    	data[Object.keys(data)[8]],
	    	data[Object.keys(data)[10]],
	    	data[Object.keys(data)[9]],
	    	data[Object.keys(data)[5]],
	    )
	    $('#add-data').modal('show');
	})

	$(document).on('click','.sub-aspek-edit', function(){
	    var t = $('#tbl-sub-aspek').DataTable();
  		var data = t.row($(this).closest('tr')).data();

  		var idx = $(this).data('id_sub_aspek')
  		var ids = $(this).data('id_aspek')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Sub Aspek'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataSubAspek(ids, idx,
	    	data[Object.keys(data)[6]],
	    	data[Object.keys(data)[3]]
	    )

	    $('#add-data').modal('show');
	})


	$(document).on('click','.sub-sub-aspek-edit', function(){
	    var t = $('#tbl-sub-sub-aspek').DataTable();
  		var data = t.row($(this).closest('tr')).data();

  		var idx = $(this).data('id_sub_sub_aspek')
  		var ids = $(this).data('sub_aspek')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Sub Sub Aspek'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataSubSubAspek(ids, idx,
	    	data[Object.keys(data)[3]],
	    	data[Object.keys(data)[8]]
	    )
	    $('#add-data').modal('show');
	})


	$(document).on('click','.indikator-edit', function(){
	    	var t = $('#tbl-indikator').DataTable();
  			var data = t.row($(this).closest('tr')).data();

  			var idx = $(this).data('id_indikator')
  			var ids = $(this).data('sub_sub_aspek')
  			var jwb = $(this).data('jjwb')
	    	let inputs = document.getElementById('content-input');
	    	document.getElementById('title-input').innerHTML = 'Edit Data Indikator'
	    	inputs.innerHTML = '';
	    	inputs.innerHTML = editDataIndikator(ids, idx,
	    		data[Object.keys(data)[5]],
	    		)
	    	$('#add-data').modal('show');
	    	loadJawaban()
	    	setTimeout(function(){
	    		$('#jjwb').val(jwb).trigger('change')
	    	},100)
	})

	$(document).on('click', '.bukti-edit', function(){
  		var t = $('#tbl-bukti-dukung').DataTable();
  		var data = t.row($(this).closest('tr')).data();

	    var idx = $(this).data('bukti')
	    var ind = $(this).data('indk')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Bukti Dukung'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editBuktiDukung(idx,ind,data[Object.keys(data)[4]]);
	    	
	   	$('#add-data').modal('show');
	})

	$(document).on('click', '.edit-parameter', function(){
  		var t = $('#tbl-parameter').DataTable();
  		var data = t.row($(this).closest('tr')).data();

	    var idx = $(this).data('prmt')
	    var ind = $(this).data('indk')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Parameter'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataparameter(ind, idx, data[Object.keys(data)[3]], data[Object.keys(data)[5]]);
	    	
	    $('#add-data').modal('show');
	})



	// function Delete data 
	//////////////////////////////////////////////////////////


	$(document).on('click', '.rb-delete' , function(){
		var idx = $(this).data('id_rb');
		var url = urlx+'/api/del-rb';
		var nmx = 'RB';
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '1')
	})

	$(document).on('click', '.aspek-delete' , function(){
		var idx = $(this).data('id_aspek');
		var url = urlx+'/api/del-aspek';
		var nmx = 'Aspek';
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '2')
	})

	$(document).on('click', '.sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_aspek');
		var url = urlx+'/api/del-sub-aspek';
		var nmx = 'Sub Aspek';
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '3')
	})

	$(document).on('click', '.sub-sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_sub_aspek');
		var url = urlx+'/api/del-sub-sub-aspek';
		var nmx = 'Sub Sub Aspek';
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '4')
	})

	$(document).on('click', '.indikator-delete' , function(){
		var idx = $(this).data('id_indikator');
		var url = urlx+'/api/del-indikator';
		var nmx = 'Indikator Dan Bukti Dukung';
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
  		console.log(idx)
		deleteData(fd, url, nmx, '5')
	})

	$(document).on('click', '.bukti-delete', function(){
		var idx = $(this).data('bukti');
		var url = urlx+'/api/del-bukti-dukung';
  		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		var nmx = 'Bukti Dukung';
		deleteData(fd, url, nmx, '6')
	})

	$(document).on('click', '.hapus-parameter', function(){
		var idx = $(this).data('id_indikator');
		var url = urlx+'/api/del-parameter';
		var idk = $(this).data('indk');
  		var idp = $(this).data('prmt');
  		// var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idp', idp)
  		fd.append('idk', idk)
		var nmx = 'Parameter';
		deleteData(fd, url, nmx, '7')
	})

	// function Execute Save data 
	//////////////////////////////////////////////////////////

	$(document).on('click', '#savedata', function(){
    	// var crs = document.getElementById('<?= csrf_token() ?>').value
    	var fd = new FormData($('#formdata')[0]);
    	fd.append('csrf_token',csrf.value);
    	var inputs = document.getElementById('datainput').value;
    	var url ='';
    	var text ='';

    	if (inputs == 1 ) {
    		 url = urlx+'/api/save-rb'
    		 text = 'Simpan Data RB Baru ?'
    	}
    	if (inputs == 2 ) {
    		 url = urlx+'/api/save-aspek'
    		 text = 'Simpan Data Aspek Baru ?'
    	}
    	if (inputs == 3 ) {
    		 url = urlx+'/api/save-sub-aspek'
    		 text = 'Simpan Data Sub Aspek Baru ?'
    	}
    	if (inputs == 4 ) {
    		 url = urlx+'/api/save-sub-sub-aspek'
    		 text = 'Simpan Data Sub Sub Aspek Baru ?'
    	}
    	if (inputs == 5 ) {
    		 url = urlx+'/api/save-indikator'
    		 text = 'Simpan Data Indikator Baru ?'
    	}
    	if (inputs == 6 ) {
    		 url = urlx+'/api/save-bukti-dukung'
    		 text = 'Simpan Data Bukti Dukung Baru ?'
    	}
    	if (inputs == 7) {
    		url = urlx+'/api/save-parameter'
    		 text = 'Simpan Data Parameter Baru ?'
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
		            		csrf.value = data.token_crs
				            	if (data.success == 1) {
					              	swal({
					              		title:"Data Berhasil Di Simpan",
					                	text: data.msg,
					                	type: "success"
					              	}, function(){
					              		$('#add-data').modal('hide');
					              		// $('#parameter').modal('show');
					                	ReloadData(7);
					              	});
				             	}else{
				             		swal({
				              			title:"Error",
				                		text: data.msg,
				                		type: "error"
				              			}, function(){
				                			ReloadData();
				              			});
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

    // function Execute Delete data 
	//////////////////////////////////////////////////////////

	function deleteData(fd, url, nmx, ket){
		swal({
            title: "Konfirmasi",
            text: 'Hapus Data '+nmx+'!',
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: false,
            showLoaderOnConfirm: true,
            },function(){
              	$.ajax({
                  	url: url,
                  	type: "POST",
                  	dataType: "JSON",
                  	headers: {
                    	'Authorization': 'Bearer '+token
                  	},
                  	data:fd,
                  	processData : false,
                  	contentType: false,
                  	cache: false,
                  	success:function(data){
                    	csrf.value = data.token_crs
                    	setTimeout(function(){
                      		if (data.success == 1) {
                        		swal('success','Data Berhasil Di Hapus','success');
                        		ReloadData(ket)
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

        });
	}

	// Template Input Data 
	//////////////////////////////////////////////////////////

	function inputrb(){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="1" id="datainput">'+

                    '<div class="form-group">'+
                        '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama RB" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+

                        '</form>';
        return inpx;
    }

    function inputaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="2" id="datainput">'+
    				'<div class="col-md-12 mb-6">'+
                       '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="rb" id="rb" required></select>'+
                        '</div></div>'+

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

    function inputsubaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="3" id="datainput">'+
    				'<div class="col-md-12 mb-6">'+
                       '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="rb" id="rb" required></select>'+
                        '</div></div>'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek" required></select>'+
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

    function inputsubsubaspek() {
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="4" id="datainput">'+
    				'<div class="col-md-12 mb-6">'+
                       '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="rb" id="rb" required></select>'+
                        '</div></div>'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek" required></select>'+
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek" required></select>'+ 
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

    function inputindikator(){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate> <input type="hidden" value="5" id="datainput">'+
    				'<div class="col-md-12 mb-6">'+
                       '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="rb" id="rb" required></select>'+
                        '</div></div>'+

            		'<div class="col-md-12 mb-6">'+
                       '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek" required></select>'+
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek" required></select>'+ 
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subsubaspek" id="subsubaspek" required></select>'+
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

    function inputbuktidukung(idx, nmx){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate> <input type="hidden" value="6" id="datainput"><input type="hidden" value="'+idx+'" name="indkt" id="indkt"><h6>Indikator :</h6>'+

    		'<div class="alert alert-light">'+nmx+'.</div>'+
    			'<div class="form-group">'+
                '<h6>Nama Bukti Dukung <span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Bukti Dukung" required>'+
               '</div></form>';

       return inpx;
    }

    function inputParameter(){
    	var inpx = '<form id="formdata" class="needs-validation" novalidate>'+
            		'<input type="hidden" value="7" id="datainput"><input type="hidden" id="idx" name="idx">'+
                    '<div class="col-md-12 mb-6">'+

                       '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                           '<select class=" form-select" name="rb" id="rb" required></select>'+
                            '<a href="#" class="btn btn-outline-success view-rb" for="inputGroupSelect01">'+
                                '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
                                '<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
                                '<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-rb" for="inputGroupSelect01">'+
                                '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
                                '<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+

            		'<div class="col-md-12 mb-6">'+
                      	'<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek" required></select>'+
                            '<a href="#" class="btn btn-outline-success view-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
								 '<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
								 '<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
								'<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+
                
                    '<div class="col-md-12 mb-6">'+
                       	'<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek" required></select>'+

                            '<a href="#" class="btn btn-outline-success view-sub-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
								'<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
								'<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-sub-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
								'<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+

                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subsubaspek" id="subsubaspek" required></select>'+
                            '<a href="#" class="btn btn-outline-success view-sub-sub-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
								'<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
								'<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-sub-sub-aspek" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
								'<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+

                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Indikator <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="indikator" id="indikator" required></select>'+

                            '<a href="#" class="btn btn-outline-success view-indikator" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
								'<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
								'<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-indikator" for="inputGroupSelect01">'+
                            	'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
								'<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+
                   
            		'<div class="form-group">'+
                        '<h6>Nama Parameter <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Parameter" required>'+
                    '</div>'+
            	'</form>';

        return inpx;
    }

    // Template Edit Data 
	//////////////////////////////////////////////////////////

	function editDataRB(idx, nmx, bbt){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="1">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+
	    				'<div class="form-group">'+
                        '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama RB" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" value="'+bbt+'" placeholder="Bobot" required></div>'+

                        '</form>';
        return inpx;
	}

	function editDataAspek(idr, idx, nmx, bbt, thn, nmf, evl, dsk, wkt){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="2">'+
	    				'<input type="hidden" name="rb" value="'+idr+'" id="rb">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama Aspek" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" value="'+bbt+'" placeholder="Bobot" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Tahun <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="tahun" name="tahun" value="'+thn+'" placeholder="Tahun" required></div>'+
                         '<div class="form-group">'+
                        '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="namaform" name="namaform" value="'+nmf+'" placeholder="Nama Form" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Evaluasi <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="eval" name="eval" value="'+evl+'" placeholder="Evaluasi" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Deskripsi <span class="text-danger">*</span></h6>'+
                        '<textarea type="text" class="form-control" id="desk" name="desk" placeholder="Deskripsi" required>'+dsk+'</textarea></div>'+
                        '<div class="form-group">'+
                        '<h6>Batas Waktu <span class="text-danger">*</span></h6>'+
                        '<input type="datetime-local" class="form-control" id="wkt" value="'+wkt+'" name="wkt" placeholder="Batas Waktu" required></div>'+

                        '</form>';
        return inpx;
	}

	function editDataSubAspek(ids, idx, bbt, nmx ){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="3">'+
	    				'<input type="hidden" name="aspek" value="'+ids+'" id="aspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" value="'+bbt+'" name="bobot" placeholder="Bobot" required></div>'+
                    	'<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama sub sub aspek" required>'+
                    	'</div></form>';
        return inpx;

	}

	function editDataSubSubAspek(ids, idx, nmx, bbt){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="4">'+
	    				'<input type="hidden" name="subaspek" value="'+ids+'" id="subaspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" value="'+bbt+'" name="bobot" placeholder="Bobot" required></div>'+
                    	'<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama sub sub aspek" required>'+
                    	'</div></form>';
        return inpx;

	}

	function editDataIndikator(ids, idx, nmx){
	    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="5">'+
	    				'<input type="hidden" name="subsubaspek" value="'+ids+'" id="subsubaspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        '<h6>Nama Indikator <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" value="'+nmx+'" name="nama" placeholder="Nama Indikator" required>'+
                    '</div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Jenis Jawaban <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="jjwb" id="jjwb" required></select>'+
                        '</div></div></form>';
        return inpx;       
    }

    function editBuktiDukung(ids, idx, nmx){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="6">'+
	    				'<input type="hidden" name="indkt" value="'+ids+'" id="indkt">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+
	    				
    			'<div class="form-group">'+
                '<h6>Nama Bukti Dukung <span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama Bukti Dukung" required>'+
               '</div></form>';

       return inpx;
	}


	function editDataparameter(ids, idx, nmx, prmt) {
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    		'<input type="hidden" id="datainput" value="7">'+
	    		'<input type="hidden" name="indikator" value="'+ids+'" id="indikator">'+
	    		'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    		'<div class="alert alert-light">'+nmx+'.</div>'+
	    			'<div class="form-group">'+
	                '<h6>Nama Parameter<span class="text-danger">*</span></h6>'+
	                '<textarea type="text" class="form-control" id="nama" name="nama" placeholder="Nama Parameter" required>'+prmt+'</textarea>'+
	               '</div></form>';

	    return inpx;
	}


    // Template View Data 
	//////////////////////////////////////////////////////////

	function formatRB(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-rb">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Nama RB</th>'+
                                   '<th>Bobot</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	function formatAspek(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-aspek">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Aspek</th>'+
                                   '<th>Bobot</th>'+
                                   '<th>Nama Form</th>'+
                                   '<th>Deskripsi</th>'+
                                   '<th>Evaluasi</th>'+
                                   '<th>Batas Waktu</th>'+
                                   '<th>Tahun</th>'+
                                   '<th>Sub Aspek</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	function formatSubaspek(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-sub-aspek">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Sub Aspek</th>'+
                                   '<th>Bobot</th>'+
                                   '<th>Sub Sub Aspek</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	function formatSubsubaspek(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-sub-sub-aspek">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Sub Sub Aspek</th>'+
                                   '<th>Bobot</th>'+
                                   '<th>Indikator</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	function formatIndikator(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-indikator">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Indikator</th>'+
                                   '<th>Parameter</th>'+
                                   '<th>Bukti Dukung</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;

	}

	function formatbuktidukung(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-bukti-dukung">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   // '<th>Indikator</th>'+
                                   '<th>Bukti Dukung</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	//  Load Data Datatable
	//////////////////////////////////////////////////////////

	function loadRB(){
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-rb').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"/api/get-rb",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value = data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama"},
				{"data" : "bobot"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning rb-edit' data-id_rb='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger rb-delete' data-id_rb='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			],
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [0,2,3]
				}
			],

		});
	}

	function loadaspek() {
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"/api/get-aspek",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value = data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama_aspek"},
				{"data" : "bobot"},
				{"data" : "nama_form"},
				{"data" : "deskripsi"},
				{"data" : "evaluasi"},
				{"data" : "batas_waktu"},
				{"data" : "tahun"},
				{"data" : "sub_aspek"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning aspek-edit' data-id_aspek='" + JsonResultRow.id + "' data-id_rb='"+JsonResultRow.rb_id+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger aspek-delete' data-id_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			],
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [0,2,3,4,5,6,8]
				}
			],
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

	function loadsubaspek() {
		// var csrf = document.getElementById('<?= csrf_token() ?>').value

		var t = $('#tbl-sub-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"/api/get-sub-aspek",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value = data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama_sub_aspek"},
				{"data" : "bobot"},
				{"data" : "sub_sub_aspek"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
						"<button class='btn icon btn-outline-warning sub-aspek-edit' data-id_sub_aspek='" + JsonResultRow.id + "' data-id_aspek='"+JsonResultRow.id_aspek+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger sub-aspek-delete' data-id_sub_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			]
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

	function loadsubsubaspek() {
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-sub-sub-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"/api/get-sub-sub-aspek",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value= data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama_sub_sub_aspek"},
				{"data" : "bobot"},
				{"data" : "indikator"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning sub-sub-aspek-edit' data-id_sub_sub_aspek='" + JsonResultRow.id + "' data-sub_aspek='"+JsonResultRow.id_sub_aspek+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger sub-sub-aspek-delete' data-id_sub_sub_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button"
						+"</div>"
						return btn;
					}
				}
			]
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

	function loadindikator(){
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-indikator').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"/api/get-indikator",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value = data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "indikator"},
				{"data" : "parameter"},
				{"data" : "bukti_dukung"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
						"<button class='btn icon btn-outline-success indikator-view' data-id_indikator='" + JsonResultRow.id + "' data-indikator='"+JsonResultRow.indikator+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'><path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z'/><path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0'/></svg></button>"+

						"<button class='btn icon btn-outline-primary indikator-plus' data-id_indikator='" + JsonResultRow.id + "' data-indikator='"+JsonResultRow.indikator+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-plus-circle' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16'/><path d='M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4'/></svg></button>"+
									
						"<button class='btn icon btn-outline-warning indikator-edit' data-id_indikator='" + JsonResultRow.id + "' data-sub_sub_aspek='"+JsonResultRow.id_sub_sub_aspek+"' data-jjwb='"+JsonResultRow.jwbid+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger indikator-delete' data-id_indikator='" + JsonResultRow.id + "' ><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			]
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

	function loadbuktidukung(idx){
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-bukti-dukung').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": urlx+"api/get-bukti-dukung",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value,
					idx : idx
				},
				"method": "GET",
				"dataSrc": function(data){
					csrf.value = data.token_crs
					return data.dt;
				},
			},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "bukti_dukung"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
						"<button class='btn icon btn-outline-warning bukti-edit' data-bukti='" + JsonResultRow.id + "' data-indk='"+JsonResultRow.id_indikator+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

						"<button class='btn icon btn-outline-danger bukti-delete' data-bukti='" + JsonResultRow.id + "' ><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			]
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

	function LoadParameter(){
      	var t = $('#tbl-parameter').DataTable({
	        "dom": 'rtip',
	        "scrollX": false,
			"processing": true,
			"language": {
						"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
					"ajax": {
						"url": urlx+'/api/get-penilaian-spbe',
						"contentType": 'application/json',
						"headers": {
							'Authorization': 'Bearer '+token
						},
						"data":{
							csrf_token: csrf.value
						},
						"method": "GET",
						"dataSrc": function(data){

							csrf.value = data.token_crs
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
					"rowGroup": {
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

    // Reload Data Datatable
	//////////////////////////////////////////////////////////

	function ReloadData(ket) {
		if (ket == 1) {
			var t = $('#tbl-rb').DataTable();
		}
		if (ket == 2) {
			var t = $('#tbl-aspek').DataTable();
		}
		if (ket == 3) {
			var t = $('#tbl-sub-aspek').DataTable();
		}
		if (ket == 4) {
			var t = $('#tbl-sub-sub-aspek').DataTable();
		}
		if (ket == 5) {
			var t = $('#tbl-indikator').DataTable();
		}
		if (ket == 6) {
			var t = $('#tbl-bukti-dukung').DataTable();
		}
		if (ket == 7) {
			var t = $('#tbl-parameter').DataTable();
		}
		t.ajax.reload(null, false);
	}




})