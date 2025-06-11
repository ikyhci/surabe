$(document).ready(function(){
	let httpProtocol = window.location.protocol;
	let host = window.location.host;
	let urlx = httpProtocol+'//'+host;
	//global variable
	// var urlx = 'http://localhost:8080/';
	var token = document.getElementById('token').value;
	var csrf = document.getElementById('csrf_token')

	LoadParameter()

	// Pilih Tahun

	loadTahun()

	function loadTahun(){
          
        var opt = document.getElementById("pilih-tahun");  
        var pilih = new Choices(opt)
        $.ajax({
            url: urlx+'/api/get-tahun-form-data',
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
	            $.each(res.dt, function(index,item){
	                if (index) {}
	                	
	                pilih.setValue([
	                  	{value: item, label: item}
	                ])
	            })
	           	pilih.setChoiceByValue('');
            },
        })
    }

    $(document).change('#pilih-tahun', function(){
      
        var optionSelected = $(this).find("option:selected");
        var valueSelected  = optionSelected.val();
        LoadParameter(valueSelected);
        // LoadDatatable(valueSelected); 
        // console.log(valueSelected)
    })

	// function add data 
	//////////////////////////////////////////////////////////
	$(document).on('click','.add-form', function(){
		let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data Form'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputForms();
    	$('#add-data').modal('show');
	})

    $(document).on('click', '.add-rb', function(){
    	let inputs = document.getElementById('content-input');
    	document.getElementById('title-input').innerHTML = 'Tambah Data RB'
    	$('#parameter').modal('hide');
    	inputs.innerHTML = '';
    	inputs.innerHTML = inputrb();
    	loadForms()
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
    	loadForms()
    	$('#add-data').modal('show');
    })

    // function on change combobox
    /////////////////////////////////////
    $(document).on('change', '#forms', function(){
    	var optionSelected = $(this).find("option:selected");
		var valueSelected  = optionSelected.val();
		var textSelected   = optionSelected.text();
		if (valueSelected != ''){
			$.ajax({
    		url: urlx+'/api/get-rb',
    		type: 'GET',
    		headers: {
    			'Authorization': 'Bearer '+token
    		},
    		data: {
    			csrf_token: csrf.value,
    			// idx : valueSelected
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
    })
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

    $(document).on('change', '#indikator', function(){
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
					if (res.jenis_jawaban = 'Pilihan Ganda') {
						$('#pilihan-ganda').removeClass('d-none');
						$('#nox1').attr('required', 'true');
		            	$('#nox2').attr('required', 'true');

					}else{
						$('#pilihan-ganda').addClass('d-none');
						$('#nox1').removeAttr('required');
		            	$('#nox2').removeAttr('required');
		            	$('#nox1').val('');
		            	$('#nox2').val('');
					}

				}
			});
		}
    })

    // function Load Ajax data 
	//////////////////////////////////////////////////////////

	function loadForms(){
		$.ajax({
			url: urlx+'/api/get-form',
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
    			$('#forms').find('option').remove()
    			$('#forms').append('<option value="" selected disabled>Choose...</option>');
    			$('#forms').val("").trigger('change')
    			for (var i = res.dt.length - 1; i >= 0; i--) {
    				$("#forms").append('<option value=' + res.dt[i].id + '>' + res.dt[i].nama + '</option>');
    			}
    		}, 
		})
	}

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
	$(document).on('click','.view-form', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Form'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatForm()
		loadForm()
	})

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
		document.getElementById('title-views').innerHTML = 'Memuat Data..'
		// $('#view-data').modal('hide');
		tabls.innerHTML ='';
		tabls.innerHTML = 
			'<div class="text-center">'+
			  '<div class="spinner-grow text-info" role="status">'+
			    '<span class="visually-hidden">Loading...</span>'+
			  '</div>'+
			  '<p>Sedang Memuat..<p>'+
			'</div>';
		
		setTimeout(function(){
			document.getElementById('title-views').innerHTML = 'List Data Bukti Dukung'
			tabls.innerHTML ='';
			tabls.innerHTML = formatbuktidukung()
			loadbuktidukung(idx)
			// setTimeout(function(){
			// 	loadbuktidukung(idx)
			// },100)
			
		},800)
	})

	// function Edit Data 
	//////////////////////////////////////////////////////////

	$(document).on('click', '.form-edit', function(){
		var t = $('#tbl-form').DataTable();
		var data = t.row($(this).closest('tr')).data();

		var idx = $(this).data('id_form')
		let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Form'
	    // console.log(data)
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataform(idx, 
	    	data[Object.keys(data)[3]], 
	    	data[Object.keys(data)[4]], 
	    	data[Object.keys(data)[5]],
	    	data[Object.keys(data)[6]], 
	    	data[Object.keys(data)[7]]);
	   
	    // console.log()
	    // console.log()
	    // console.log()
	    // console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])


	    $('#view-data').modal('hide');
	    $('#add-data').modal('show');
	})

	//Enable / Disable Form
	$(document).on('click', '.enb-form', function(){
		var idx = $(this).data('id_form');
		var stsx = $(this).data('sts_form');
		var url = urlx+'/api/sts-form';
		var txt = '';
  	var fd = new FormData();
  	fd.append('csrf_token', csrf.value)
  	fd.append('idx', idx);
  	
  	if (stsx == 1) {
  		txt = 'Disable Data Form !'
  		fd.append('stsx', 0);
  	}else{
  		txt = 'Enable Data Form !'
  		fd.append('stsx', 1);
  	}
  	swal({
      title: "Konfirmasi",
      text: txt,
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
                        		swal('success','Data Berhasil Di Update','success');
                        		ReloadData(0)
                        		setTimeout(function(){
                        			ReloadData(7)
                        		},300)
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


	})

	$(document).on('click', '.rb-edit', function() {
	    var t = $('#tbl-rb').DataTable();
  		var data = t.row($(this).closest('tr')).data();

  		var idx = $(this).data('id_rb')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data RB'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editDataRB(idx,data[Object.keys(data)[9]],data[Object.keys(data)[6]], 
	    	data[Object.keys(data)[8]]);
	    // console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    $('#view-data').modal('hide');
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
	  
	    	data[Object.keys(data)[11]],
	    	data[Object.keys(data)[7]],
	    	data[Object.keys(data)[10]]
	    )
	  	//  console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])

	    $('#view-data').modal('hide');
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
	    	data[Object.keys(data)[8]],
	    	data[Object.keys(data)[12]],
	    	data[Object.keys(data)[11]],
	    	data[Object.keys(data)[13]],
	    	// wktx
	    )
	    //  console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])
	    $('#view-data').modal('hide');
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
	    	data[Object.keys(data)[12]],
	    	data[Object.keys(data)[11]],
	    	data[Object.keys(data)[13]]
	    )
	    //  console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])
	    $('#view-data').modal('hide');
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
	    		data[Object.keys(data)[24]],
	    		data[Object.keys(data)[23]]
	    		)
	    // 	 console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])
	    // console.log(data[Object.keys(data)[14]])
	    // console.log(data[Object.keys(data)[15]])
	    // console.log(data[Object.keys(data)[16]])
	    // console.log(data[Object.keys(data)[17]])
	    // console.log(data[Object.keys(data)[18]])
	    // console.log(data[Object.keys(data)[19]])
	    // console.log(data[Object.keys(data)[20]])
	    // console.log(data[Object.keys(data)[21]])
	    // console.log(data[Object.keys(data)[22]])
	    // console.log(data[Object.keys(data)[23]])
	    // console.log(data[Object.keys(data)[24]])
	    	$('#view-data').modal('hide');
	    	$('#add-data').modal('show');
	    	loadJawaban()
	    	setTimeout(function(){
	    		$('#jjwb').val(jwb).trigger('change')
	    	},300)
	})

	$(document).on('click', '.bukti-edit', function(){
  		var t = $('#tbl-bukti-dukung').DataTable();
  		var data = t.row($(this).closest('tr')).data();

	    var idx = $(this).data('bukti')
	    var ind = $(this).data('indk')
	    let inputs = document.getElementById('content-input');
	    document.getElementById('title-input').innerHTML = 'Edit Data Bukti Dukung'
	    inputs.innerHTML = '';
	    inputs.innerHTML = editBuktiDukung(idx,ind,
	    	data[Object.keys(data)[9]], 
	    	data[Object.keys(data)[8]],
	    	);

	    //  console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])
	    // console.log(data[Object.keys(data)[14]])
	    // console.log(data[Object.keys(data)[15]])
	    // console.log(data[Object.keys(data)[16]])
	    // console.log(data[Object.keys(data)[17]])
	    $('#view-data').modal('hide');
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
	    inputs.innerHTML = editDataparameter(ind, idx, 
	    	data[Object.keys(data)[11]], 
	    	data[Object.keys(data)[17]],
	    	data[Object.keys(data)[18]]

	    	);
	    // console.log(data[Object.keys(data)[1]])
	    // console.log(data[Object.keys(data)[2]])
	    // console.log(data[Object.keys(data)[3]])
	    // console.log(data[Object.keys(data)[4]])
	    // console.log(data[Object.keys(data)[5]])
	    // console.log(data[Object.keys(data)[6]])
	    // console.log(data[Object.keys(data)[7]])
	    // console.log(data[Object.keys(data)[8]])
	    // console.log(data[Object.keys(data)[9]])
	    // console.log(data[Object.keys(data)[10]])
	    // console.log(data[Object.keys(data)[11]])
	    // console.log(data[Object.keys(data)[12]])
	    // console.log(data[Object.keys(data)[13]])
	    // console.log(data[Object.keys(data)[14]])
	    // console.log(data[Object.keys(data)[15]])
	    // console.log(data[Object.keys(data)[16]])
	    // console.log(data[Object.keys(data)[17]])
	    // console.log(data[Object.keys(data)[18]])
	    // console.log(data[Object.keys(data)[19]])
	    // console.log(data[Object.keys(data)[20]])
	    // console.log(data[Object.keys(data)[21]])
	    // console.log(data[Object.keys(data)[22]])
	    // console.log(data[Object.keys(data)[23]])
	    // console.log(data[Object.keys(data)[24]])
	    $('#view-data').modal('hide');
	    $('#add-data').modal('show');
	})



	// function Delete data 
	//////////////////////////////////////////////////////////

	$(document).on('click', '.form-delete', function(){
		var idx = $(this).data('id_form');
		var url = urlx+'/api/del-form';
		var nmx = 'FORM';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '0')
	})


	$(document).on('click', '.rb-delete' , function(){
		var idx = $(this).data('id_rb');
		var url = urlx+'/api/del-rb';
		var nmx = 'RB';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '1')
	})

	$(document).on('click', '.aspek-delete' , function(){
		var idx = $(this).data('id_aspek');
		var url = urlx+'/api/del-aspek';
		var nmx = 'Aspek';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '2')
	})

	$(document).on('click', '.sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_aspek');
		var url = urlx+'/api/del-sub-aspek';
		var nmx = 'Sub Aspek';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '3')
	})

	$(document).on('click', '.sub-sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_sub_aspek');
		var url = urlx+'/api/del-sub-sub-aspek';
		var nmx = 'Sub Sub Aspek';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '4')
	})

	$(document).on('click', '.indikator-delete' , function(){
		var idx = $(this).data('id_indikator');
		var url = urlx+'/api/del-indikator';
		var nmx = 'Indikator Dan Bukti Dukung';
  		var fd = new FormData();
  		fd.append('csrf_token', csrf.value)
  		fd.append('idx', idx)
  		// console.log(idx)
		deleteData(fd, url, nmx, '5')
	})

	$(document).on('click', '.bukti-delete', function(){
		var idx = $(this).data('bukti');
		var url = urlx+'/api/del-bukti-dukung';
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

    	if (inputs == 0 ) {
    		 url = urlx+'/api/save-form'
    		 text = 'Simpan Data From Baru ?'
    	}

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
					              		// $('#add-data').modal('hide');
					              		// $('#parameter').modal('show');
					                	ReloadData(inputs);
					              	});
				             	}else{
				             		swal({
				              			title:"Error",
				                		text: data.msg,
				                		type: "error"
				              			}, function(){
				                			ReloadData(inputs);
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

	function inputForms(){
		var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="0" id="datainput">'+

						'<div class="form-group">'+
                        '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Form" required></div>'+
                    	'<div class="form-group">'+
                        '<h6>Tahun <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="tahun" name="tahun" placeholder="Tahun" required></div>'+
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

	function inputrb(){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate><input type="hidden" value="1" id="datainput">'+


    				'<div class="col-md-12 mb-6">'+

                       '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                           '<select class=" form-select" name="forms" id="forms" required></select>'+
                            '</div>'+
                    '</div>'+

                    // 
                    '<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : I, II, III,..." required></div>'+
                        	// 

                    '<div class="form-group">'+
                        '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama RB" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+

                        // tambahan
                        

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

                        // 

                        // tambahan
                        '<div class="form-group">'+
                        '<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : A, B, C,..." required></div>'+
                        

                    '<div class="form-group">'+
                        '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Aspek" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+

                        
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
                        
                        // // tambahan
                '<div class="form-group">'+
                        '<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : 1, 2, 3,..." required></div>'+

                        // 
                    '<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama sub sub aspek" required>'+
                    '</div>'+
                    '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+ 

                    '<div class="form-group">'+
                        '<h6>Batas Waktu <span class="text-danger">*</span></h6>'+
                        '<input type="datetime-local" class="form-control" id="wkt" name="wkt" placeholder="Batas Waktu" required></div>'+

                    '</form>';
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
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="aspek" id="aspek" required></select>'+
                        '</div></div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="subaspek" id="subaspek" required></select>'+ 
                        '</div></div>'+
                        // tambahan
                    '<div class="form-group">'+
                        '<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : 1.1, 1.2, 1.3,..." required></div>'+

                // 
                    '<div class="form-group">'+
                        '<h6>Nama Sub Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama sub sub aspek" required>'+
                    '</div>'+

                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" placeholder="Bobot" required></div>'+
                    //
              

                    
                    '</form>';
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
                        // tambahan
                    '<div class="form-group">'+
                        '<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : a), b), c),..." required></div>'+
                    //
                    '<div class="form-group">'+
                        '<h6>Nama Indikator <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Indikator" required>'+
                    '</div>'+
                    '<div class="col-md-12 mb-6">'+
                       '<h6>Jenis Jawaban <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                            '<select class=" form-select" name="jjwb" id="jjwb" required></select>'+
                        '</div></div>'+
                        
                        '</form>';
        return inpx;
    }

    function inputbuktidukung(idx, nmx){
    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate> <input type="hidden" value="6" id="datainput"><input type="hidden" value="'+idx+'" name="indkt" id="indkt"><h6>Indikator :</h6>'+

    		'<div class="alert alert-light">'+nmx+'.</div>'+
    		/// Tambahan
    		'<div class="form-group">'+
                        '<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nourut" name="nourut" placeholder="Ext : 1, 2, 3,..." required></div>'+
                        ///
    			'<div class="form-group">'+
                '<h6>Nama Bukti Dukung <span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" placeholder="Nama Bukti Dukung" required>'+
               '</div>'+

               

               '</form>';

       return inpx;
    }

    function inputParameter(){
    	var inpx = '<form id="formdata" class="needs-validation" novalidate>'+
            		'<input type="hidden" value="7" id="datainput"><input type="hidden" id="idx" name="idx">'+

            		'<div class="col-md-12 mb-6">'+

                       '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<div class="input-group mb-3">'+
                           '<select class=" form-select" name="forms" id="forms" required></select>'+
                            '<a href="#" class="btn btn-outline-success view-form" for="inputGroupSelect01">'+
                                '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">'+
                                '<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>'+
                                '<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/></svg></a>'+

                            '<a href="#" class="btn btn-outline-primary add-form" for="inputGroupSelect01">'+
                                '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle-dotted" viewBox="0 0 16 16">'+
                                '<path d="M8 0q-.264 0-.523.017l.064.998a7 7 0 0 1 .918 0l.064-.998A8 8 0 0 0 8 0M6.44.152q-.52.104-1.012.27l.321.948q.43-.147.884-.237L6.44.153zm4.132.271a8 8 0 0 0-1.011-.27l-.194.98q.453.09.884.237zm1.873.925a8 8 0 0 0-.906-.524l-.443.896q.413.205.793.459zM4.46.824q-.471.233-.905.524l.556.83a7 7 0 0 1 .793-.458zM2.725 1.985q-.394.346-.74.74l.752.66q.303-.345.648-.648zm11.29.74a8 8 0 0 0-.74-.74l-.66.752q.346.303.648.648zm1.161 1.735a8 8 0 0 0-.524-.905l-.83.556q.254.38.458.793l.896-.443zM1.348 3.555q-.292.433-.524.906l.896.443q.205-.413.459-.793zM.423 5.428a8 8 0 0 0-.27 1.011l.98.194q.09-.453.237-.884zM15.848 6.44a8 8 0 0 0-.27-1.012l-.948.321q.147.43.237.884zM.017 7.477a8 8 0 0 0 0 1.046l.998-.064a7 7 0 0 1 0-.918zM16 8a8 8 0 0 0-.017-.523l-.998.064a7 7 0 0 1 0 .918l.998.064A8 8 0 0 0 16 8M.152 9.56q.104.52.27 1.012l.948-.321a7 7 0 0 1-.237-.884l-.98.194zm15.425 1.012q.168-.493.27-1.011l-.98-.194q-.09.453-.237.884zM.824 11.54a8 8 0 0 0 .524.905l.83-.556a7 7 0 0 1-.458-.793zm13.828.905q.292-.434.524-.906l-.896-.443q-.205.413-.459.793zm-12.667.83q.346.394.74.74l.66-.752a7 7 0 0 1-.648-.648zm11.29.74q.394-.346.74-.74l-.752-.66q-.302.346-.648.648zm-1.735 1.161q.471-.233.905-.524l-.556-.83a7 7 0 0 1-.793.458zm-7.985-.524q.434.292.906.524l.443-.896a7 7 0 0 1-.793-.459zm1.873.925q.493.168 1.011.27l.194-.98a7 7 0 0 1-.884-.237zm4.132.271a8 8 0 0 0 1.012-.27l-.321-.948a7 7 0 0 1-.884.237l.194.98zm-2.083.135a8 8 0 0 0 1.046 0l-.064-.998a7 7 0 0 1-.918 0zM8.5 4.5a.5.5 0 0 0-1 0v3h-3a.5.5 0 0 0 0 1h3v3a.5.5 0 0 0 1 0v-3h3a.5.5 0 0 0 0-1h-3z"/></svg></a>'+
                        '</div>'+
                    '</div>'+

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

             '<div class="row d-none" id="pilihan-ganda">'+
					    '<div class="col-sm-6">'+
					        '<div class="form-group">'+
					            '<label for="nourut">Nomor Urut</label>'+
					            '<input type="text" name="nourut" id="nox1" class="form-control" placeholder="Ext : A, B, C,...">'+
					        '</div> '+ 
					    '</div>'+
					    '<div class="col-sm-6">'+
					        '<div class="form-group">'+
					            '<label for="nilai">Nilai</label>'+
					            '<input type="text" name="nilai" id="nox2" class="form-control" placeholder="Ext : 100, 65, 35, 0">'+
					        '</div>'+  
					    '</div>'+
					'</div>'+
            	'</form>';

        return inpx;
    }

    // Template Edit Data 
	//////////////////////////////////////////////////////////

	function editDataform(idx, nmx, thn, evl, dsk, wkt ){
		var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
					'<input type="hidden" value="0" id="datainput">'+
					'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+
						'<div class="form-group">'+
                        '<h6>Nama Form <span class="text-danger">*</span></h6>'+
                        '<input type="text" value="'+nmx+'" class="form-control" id="nama" name="nama" placeholder="Nama Form" required></div>'+
                    	'<div class="form-group">'+
                        '<h6>Tahun <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" value="'+thn+'" id="tahun" name="tahun" placeholder="Tahun" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Evaluasi <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" value="'+evl+'" id="eval" name="eval" placeholder="Evaluasi" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Deskripsi <span class="text-danger">*</span></h6>'+
                        '<textarea type="text" class="form-control" id="desk" name="desk" placeholder="Deskripsi" required>'+dsk+'</textarea></div>'+
                        '<div class="form-group">'+
                        '<h6>Batas Waktu <span class="text-danger">*</span></h6>'+
                        '<input type="datetime-local" class="form-control" value="'+wkt+'" id="wkt" name="wkt" placeholder="Batas Waktu" required></div>'+

                        '</form>';
        return inpx;
	}

	function editDataRB(idx, nmx, bbt, nox){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="1">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+
	    				// 
                    '<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : I, II, III,..." required></div>'+
                        	// 
	    				'<div class="form-group">'+
                 '<h6>Nama RB <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama RB" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" value="'+bbt+'" placeholder="Bobot" required></div>'+

                        '</form>';
        return inpx;
	}

	function editDataAspek(idr, idx, nmx, bbt, nox){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="2">'+
	    				'<input type="hidden" name="rb" value="'+idr+'" id="rb">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : A, B, C,..." required></div>'+
                        	// 

	    				'<div class="form-group">'+
                        '<h6>Nama Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama Aspek" required></div>'+
                        '<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" name="bobot" value="'+bbt+'" placeholder="Bobot" required></div>'+
                       
                        '</form>';
        return inpx;
	}

	function editDataSubAspek(ids, idx, bbt, nmx, nox, btwkt ){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="3">'+
	    				'<input type="hidden" name="aspek" value="'+ids+'" id="aspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+
	    				'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : 1, 2, 3,..." required></div>'+
                        	// 

              '<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama sub sub aspek" required>'+
                    	'</div>'+
	    				'<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" value="'+bbt+'" name="bobot" placeholder="Bobot" required></div>'+
                    	 '<div class="form-group">'+
                        '<h6>Batas Waktu <span class="text-danger">*</span></h6>'+
                        '<input type="datetime-local" class="form-control" id="wkt" name="wkt" value="'+btwkt+'" placeholder="Batas Waktu" required></div>'+


                    	'</form>';
        return inpx;

	}

	function editDataSubSubAspek(ids, idx, nmx, bbt, nox ){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="4">'+
	    				'<input type="hidden" name="subaspek" value="'+ids+'" id="subaspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : 1.1, 1.2, 1.3,..." required></div>'+
                        	// 

              '<div class="form-group">'+
                        '<h6>Nama Sub Aspek <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama sub sub aspek" required>'+
                    	'</div>'+

	    				'<div class="form-group">'+
                        '<h6>Bobot <span class="text-danger">*</span></h6>'+
                        '<input type="text" class="form-control" id="bobot" value="'+bbt+'" name="bobot" placeholder="Bobot" required></div>'+
                    	

                  '</form>';
        return inpx;

	}

	function editDataIndikator(ids, idx, nmx, nox){
	    	var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="5">'+
	    				'<input type="hidden" name="subsubaspek" value="'+ids+'" id="subsubaspek">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : a), b), c),..." required></div>'+
                        	// 

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

    function editBuktiDukung(ids, idx, nmx, nox){
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    				'<input type="hidden" id="datainput" value="6">'+
	    				'<input type="hidden" name="indkt" value="'+ids+'" id="indkt">'+
	    				'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    				'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : 1, 2, 3,..." required></div>'+
                        	// 
	    				
    			'<div class="form-group">'+
                '<h6>Nama Bukti Dukung <span class="text-danger">*</span></h6>'+
                '<input type="text" class="form-control" id="nama" name="nama" value="'+nmx+'" placeholder="Nama Bukti Dukung" required>'+
               '</div></form>';

       return inpx;
	}


	function editDataparameter(ids, idx, nmx, prmt, nox) {
	    var inpx = '<form method="POST" id="formdata" class="needs-validation" novalidate>'+
	    		'<input type="hidden" id="datainput" value="7">'+
	    		'<input type="hidden" name="indikator" value="'+ids+'" id="indikator">'+
	    		'<input type="hidden" name="idx" value="'+idx+'" id="idx">'+

	    		'<div class="alert alert-light">'+nmx+'.</div>'+
	    		'<div class="form-group">'+
                        	'<h6>Nomor Urut<span class="text-danger">*</span></h6>'+
                        	'<input type="text" class="form-control" id="nourut" name="nourut" value="'+nox+'" placeholder="Ext : A, B, C,..." required></div>'+
                        	// 
	    			'<div class="form-group">'+
	                '<h6>Nama Parameter<span class="text-danger">*</span></h6>'+
	                '<textarea type="text" class="form-control" id="nama" name="nama" placeholder="Nama Parameter" required>'+prmt+'</textarea>'+
	               '</div></form>';

	    return inpx;
	}


    // Template View Data 
	//////////////////////////////////////////////////////////

	function formatForm(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-form">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Nama Form</th>'+
                                   '<th>Deskripsi</th>'+
                                   '<th>Evaluasi</th>'+
                                   '<th>Batas Waktu</th>'+
                                   '<th>Tahun</th>'+
                                   '<th>Aksi</th>'+
                               '</tr>'+
                           '</thead>'+
                           '<tbody></tbody>'+ 
                       '</table></div>';
        return tblx;
	}

	function formatRB(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-rb">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th></th>'+
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
                                   '<th></th>'+
                                   '<th>Aspek</th>'+
                                   '<th>Bobot</th>'+
                                   // '<th>Nama Form</th>'+
                                   // '<th>Deskripsi</th>'+
                                   // '<th>Evaluasi</th>'+
                                   // '<th>Batas Waktu</th>'+
                                   // '<th>Tahun</th>'+
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
                                   '<th></th>'+
                                   '<th>Sub Aspek</th>'+
                                   '<th>Bobot</th>'+
                                   '<th>Batas Waktu</th>'+
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
                                   '<th></th>'+
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
                                   '<th></th>'+
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
                                   '<th></th>'+
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

	function loadForm(){
		var t = $('#tbl-form').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
			},
			"ajax": {
				"url": urlx+"/api/get-form",
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
			"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
                var index = iDisplayIndex +1;
                $('td:eq(0)',nRow).html(index);
                return nRow;
          	},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama"},
				{"data" : "deskripsi"},
				{"data" : "evaluasi"},
				{"data" : "bataswaktu"},
				{"data" : "tahun"},
				{
					"render": function(data, type, JsonResultRow, meta) {

						var enb ='';
						if (JsonResultRow.active == 0) {
							enb +="<button class='btn icon btn-outline-success enb-form' data-id_form='" + 
							JsonResultRow.id + "' data-sts_form='"+JsonResultRow.active+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-check2-circle' viewBox='0 0 16 16'>"+
  						"<path d='M2.5 8a5.5 5.5 0 0 1 8.25-4.764.5.5 0 0 0 .5-.866A6.5 6.5 0 1 0 14.5 8a.5.5 0 0 0-1 0 5.5 5.5 0 1 1-11 0'/>"+
  						"<path d='M15.354 3.354a.5.5 0 0 0-.708-.708L8 9.293 5.354 6.646a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0z'/>"+
							"</svg></button>";

						}else{
							enb +="<button class='btn icon btn-outline-danger enb-form' data-id_form='" + 
							JsonResultRow.id + "' data-sts_form='"+JsonResultRow.active+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-x-circle' viewBox='0 0 16 16'>"+
  						"<path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16'/>"+
  						"<path d='M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708'/>"+
							"</svg></button>";
						}

						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning form-edit' data-id_form='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+
						enb+
						"<button class='btn icon btn-outline-danger form-delete' data-id_form='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"
						+"</div>"
						return btn;
					}
				}
			],
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [0,2,3,4,5,6]
				}
			],

		});
	}

	function loadRB(){
		// var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-rb').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
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
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
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
					"targets": [2,3]
				}
			],
			"rowGroup": {
			    dataSrc: ['nama_form']
			}

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
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
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
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama_aspek"},
				{"data" : "bobot"},
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
			"rowGroup": {
			    dataSrc: ['rb']
			},
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [2,4]
				}
			],
		});
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
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
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
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
			"columns":[
				{"data" : null, defaultContent: ''},
				{"data" : "nama_sub_aspek"},
				{"data" : "bobot"},
				{"data" : "batas_waktu"},
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
			],
			"rowGroup": {
			    dataSrc: ['rb','aspek']
			},
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [2,3,5]
				}
			],
		});
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
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
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
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
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
			],
			"rowGroup": {
			    dataSrc: ['rb','aspek','nama_sub_aspek']
			},
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [2,4]
				}
			],
		});
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
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
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
					// console.log(data)
					return data.dt;
				},
			},
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
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
			],
			"rowGroup": {
			    dataSrc: ['rb','aspek','nama_sub_aspek','nama_sub_sub_aspek']
			},
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [4]
				}
			],
		});

		// t.ajax.reload();
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
				"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
			},
			"ajax": {
				"url": urlx+"/api/get-bukti-dukung",
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
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
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
			],
			"rowGroup": {
			    dataSrc: ['indikator']
			},
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [2]
				}
			],
		});

	}

	function LoadParameter(thnx){

		// let groupCounters = [0, 0]; // Counters for each group level
    // const romanNumerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
    // const alPhabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r',
    // 	's','t','u','v','w','x','y','z'];
      
    var t = $('#tbl-parameter').DataTable({
	    "dom": 'rtip',
	    'iDisplayLength': 1000,
	    // lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
	    "scrollX": false,
			"processing": true,
			"destroy": true,
			"language": {
						"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
						"emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
			},
			"ajax": {
				"url": urlx+'/api/get-penilaian-spbe',
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					csrf_token: csrf.value,
					thn: thnx,
				},
				"method": "GET",
				"dataSrc": function(data){
					// console.log(data)
					csrf.value = data.token_crs
					return data.dt;
					},
			},
			// "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
      //           var index = iDisplayIndex +1;
      //           $('td:eq(0)',nRow).html(index);
      //           return nRow;
      //     	},
      drawCallback: function (settings) {
          groupCounter = 0; // Reset counter each draw to keep numbering consistent
        },
			"columns":[
				{"data": null, defaultContent: ''},	
				{"data": "nama_parameter"},
				{"data": "tahun"},
				// {"data": "active"},
				{"data": "create_at"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						
						var btn = '';	
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
							
							"<button class='btn icon btn-outline-warning edit-parameter' data-indk='" + JsonResultRow.id_ind + "' data-ind='"+JsonResultRow.indikator+"' data-prmt='"+JsonResultRow.id_parameter+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+
					
							"<button class='btn icon btn-outline-danger hapus-parameter' data-indk='" + JsonResultRow.id_ind + "' data-prmt='"+JsonResultRow.id_parameter+"'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-trash3-fill' viewBox='0 0 16 16'><path d='M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06m6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528M8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5'/></svg></button>"

							+"</div>"
							return btn;
					}
				},
			],
			"columnDefs":[
				{
					"className": "dt-center",
					"targets": [0,2,3,4]
				}
			],
					// order: [[2, 'asc']],
			"rowGroup": {
			    dataSrc: ['nama_form','nama_rb','nama_aspek','nama_sub_aspek','nama_sub_sub_aspek','indikator'],
			    // startRender: function (rows, group, index) {

			    // 	// setTimeout(function(){

			    // 	// },100)

			    // 	// Reset counters for levels deeper than current level
          //   for (let i = index + 1; i < groupCounters.length; i++) {
          //     groupCounters[i] = 0;
          //   }

          //   groupCounters[index]++;

          //   let numbering = '';

          //   switch (index) {
          //     case 1:
          //       numbering = romanNumerals[groupCounters[index] - 1] + '. ';
                
          //       break;
          //     case 2:
          //       numbering = String.fromCharCode(64 + groupCounters[index]) + '. '; // A, B, C...
          //       // console.log(alPhabet[groupCounters[index] - 1]+'.')
          //       // console.log(index)
          //       // console.log(groupCounters)
          //       // console.log(groupCounters[index])
          //       break;
          //     case 3:
          //       numbering = groupCounters[index] + '. ';
          //       break;
          //     case 4:
          //       numbering = groupCounters[3] + '.' + groupCounters[index] + '. ';
          //       break;
          //     // default:
          //     //   numbering = groupCounters[level] + '. ';
          //     //   break;
          //   }

			    // 	// for (let i = index; i < groupCounters.length; i++) {
          //   //   groupCounters[i] = 0;
          //   // }

          //   // groupCounters[index]++;

          //   // let numbering = '';

          //   // for (let i = 0; i <= index; i++) {
          //   //   if (groupCounters[i] > 0) {
          //   //     numbering += groupCounters[i] + '.';
          //   //   }
          //   // }
			    	
			    // 	if (index == 0) {
			    // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-0')
          //     .append('<th colspan="6" scope="row"> '+ group + '</th>');
			    // 	}
			    // 	if (index == 1) {
			    // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-1')
          //     .append('<th colspan="6" scope="row"> '+ numbering  + group + ' </th>');
			    // 	}
			    // 	if (index == 2) {
			    // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-2')
          //     .append('<th colspan="6" scope="row">'+ numbering  + group + ' </th>');
			    // 	}
			    // 	if (index == 3) {
			    // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-3')
          //     .append('<th colspan="6" scope="row">'+ numbering  + group + ' </th>');
			    // 	}
			    // 	if (index == 4) {
			    // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-4')
          //     .append('<th colspan="6" scope="row">'+ numbering  + group + '</th>');
			    // 	}

			    // 	if (index == 5) {
			    // 		groupCounter++;
          // 		return $('<tr/>')
          //     .addClass('dtrg-group dtrg-start dtrg-level-5')
          //     .append('<th colspan="6" scope="row">' + alPhabet[groupCounters[index] - 1] + '). ' + group + ' (Total Parameter : ' + rows.count() + ')</th>');
			    // 	}
			    	// else{
			    	// 		return $('<tr/>')
            //   .addClass('dtrg-group dtrg-start dtrg-level-3')
            //   .append('<th colspan="6" scope="row">'+ numbering  + group + ' </th>');
			    	// }
          
      	// },
      	// endRender: function (rows, group, level) {
      	// 	// console.log(level)
        //     if(level === 5) {
        //       return $('<tr/>')
        //         .addClass('dtrg-group dtrg-start dtrg-level-5')
        //         .append('<th colspan="6" scope="row">End of ' + group + '</th>');
        //     }
        //     // return null; // No end row for level 0 or others
        //   }
			},
			
			// order: [[3, 'desc']]
	    });
			// setTimeout(function(){
			// 	ReloadData(7)
			// },100)

    }

    // Reload Data Datatable
	//////////////////////////////////////////////////////////

	function ReloadData(ket) {
		if (ket == 0) {
			var t = $('#tbl-form').DataTable();
		}
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