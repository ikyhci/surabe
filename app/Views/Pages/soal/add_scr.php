<script {csp-script-nonce}  type="text/javascript">
$(document).ready(function(){
	var token = document.getElementById('token').value;

	$(document).on('click', '.view-indikator', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Indikator'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatIndikator()
		loadindikator()

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

	$(document).on('click', '.view-sub-aspek', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data Sub Aspek'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatSubaspek()
		loadsubaspek()

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

	$(document).on('click', '.view-rb', function(){
		let tabls = document.getElementById('content-views');
		document.getElementById('title-views').innerHTML = 'List Data RB'
		$('#parameter').modal('hide');
		$('#view-data').modal('show');
		tabls.innerHTML ='';
		tabls.innerHTML = formatRB()
		loadRB()
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


	function loadRB(){
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-rb').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-rb",
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

	$(document).on('click', '.rb-delete' , function(){
		var idx = $(this).data('id_rb');
		var url = '<?php echo base_url();?>api/del-rb';
		var nmx = 'RB';
		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '7')
	})

	

	function loadaspek() {
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-aspek",
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
				{"data" : null, defaultContent: ''},
				{"data" : "nama_aspek"},
				{"data" : "bobot"},
				{"data" : "nama_form"},
				{"data" : "deskripsi"},
				{"data" : "evaluasi"},
				{"data" : "batas_waktu"},
				{"data" : "sub_aspek"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning aspek-edit' data-id_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

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

	//hapus aspek
	$(document).on('click', '.aspek-delete' , function(){
		var idx = $(this).data('id_aspek');
		var url = '<?php echo base_url();?>api/del-aspek';
		var nmx = 'Aspek';
		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '1')
	})


	function loadsubaspek() {
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-sub-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-sub-aspek",
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
				{"data" : null, defaultContent: ''},
				{"data" : "nama_sub_aspek"},
				{"data" : "sub_sub_aspek"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
						"<button class='btn icon btn-outline-warning sub-aspek-edit' data-id_sub_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

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

	//hapus sub aspek
	$(document).on('click', '.sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_aspek');
		var url = '<?php echo base_url();?>api/del-sub-aspek';
		var nmx = 'Sub Aspek';
		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '2')
	})


	function loadsubsubaspek() {
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-sub-sub-aspek').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-sub-sub-aspek",
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
				{"data" : null, defaultContent: ''},
				{"data" : "nama_sub_sub_aspek"},
				{"data" : "indikator"},
				{
					"render": function(data, type, JsonResultRow, meta) {
						var btn = '';
									
						btn +="<div class='btn-group mb-3 btn-group-sm'>"+
									
						"<button class='btn icon btn-outline-warning sub-sub-aspek-edit' data-id_sub_sub_aspek='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

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

	$(document).on('click', '.sub-sub-aspek-delete' , function(){
		var idx = $(this).data('id_sub_sub_aspek');
		var url = '<?php echo base_url();?>api/del-sub-sub-aspek';
		var nmx = 'Sub Sub Aspek';
		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
		deleteData(fd, url, nmx, '3')
	})


	function loadindikator(){
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-indikator').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-indikator",
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
									
						"<button class='btn icon btn-outline-warning indikator-edit' data-id_indikator='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

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

	$(document).on('click', '.indikator-delete' , function(){
		var idx = $(this).data('id_indikator');
		var url = '<?php echo base_url();?>api/del-indikator';
		var nmx = 'Indikator Dan Bukti Dukung';
		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
  		console.log(idx)
		deleteData(fd, url, nmx, '4')
	})

	function loadbuktidukung(idx){
		var csrf = document.getElementById('<?= csrf_token() ?>').value
		var t = $('#tbl-bukti-dukung').DataTable({
			"dom": 'rtip',
			"destroy": true,
	        "scrollX": false,
			"processing": true,
			"language": {
				"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
			},
			"ajax": {
				"url": "<?php echo base_url(); ?>api/get-bukti-dukung",
				"contentType": 'application/json',
				"headers": {
					'Authorization': 'Bearer '+token
				},
				"data":{
					<?= csrf_token() ?>: csrf,
					idx : idx
				},
				"method": "GET",
				"dataSrc": function(data){
					$('input#<?= csrf_token() ?>').val(data.token_crs)
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
						"<button class='btn icon btn-outline-warning bukti-edit' data-bukti='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-pencil-square' viewBox='0 0 16 16'><path d='M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z'/><path fill-rule='evenodd' d='M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z'/></svg></button>"+

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

	$(document).on('click', '.bukti-delete', function(){
		var idx = $(this).data('bukti');
		var url = '<?php echo base_url();?>api/del-bukti-dukung';
  		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idx', idx)
		var nmx = 'Bukti Dukung';
		deleteData(fd, url, nmx, '6')
	})

	

	$(document).on('click', '.hapus-parameter', function(){
		var idx = $(this).data('id_indikator');
		var url = '<?php echo base_url();?>api/del-parameter';
		var idk = $(this).data('indk');
  		var idp = $(this).data('prmt');
  		var csrf = document.getElementById('<?= csrf_token() ?>').value
  		var fd = new FormData();
  		fd.append('<?= csrf_token() ?>', csrf)
  		fd.append('idp', idp)
  		fd.append('idk', idk)
		var nmx = 'Parameter';
		deleteData(fd, url, nmx, '5')
	})


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

	function formatSubsubaspek(){
		var tblx = '<div class="table-responsive">'+
                       '<table class="table mb-0" id="tbl-sub-sub-aspek">'+
                           '<thead>'+
                               '<tr>'+
                                   '<th>No</th>'+
                                   '<th>Sub Sub Aspek</th>'+
                                   '<th>Indikator</th>'+
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
                                   '<th>Sub Sub Aspek</th>'+
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
                                   '<th>Sub Aspek</th>'+
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

	function ReloadData(ket) {
		if (ket == 1) {
			var t = $('#tbl-aspek').DataTable();
		}
		if (ket == 2) {
			var t = $('#tbl-sub-aspek').DataTable();
		}
		if (ket == 3) {
			var t = $('#tbl-sub-sub-aspek').DataTable();
		}
		if (ket == 4) {
			var t = $('#tbl-indikator').DataTable();
		}
		if (ket == 5) {
			var t = $('#datatable').DataTable();
		}
		if (ket == 6) {
			var t = $('#tbl-bukti-dukung').DataTable();
		}
		if (ket == 7) {
			var t = $('#tbl-rb').DataTable();
		}
		
		t.ajax.reload(null, false);
	}


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
                    	$('input#<?= csrf_token() ?>').val(data.token_crs)
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

});
</script>