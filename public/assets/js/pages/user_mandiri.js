$(document).ready(function(){
	// Global Variable
	let httpProtocol = window.location.protocol;
    let host = window.location.host;
    let urlx = httpProtocol+'//'+host;
    var token = document.getElementById('token').value;
    var csrf = document.getElementById('csrf_token')
	// Penilaian Mandiri 
	//====================================


	
  $(document).on('change', '#pilih-tahun', function(){
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
      	var t = $('#datatable').DataTable({
        	// "dom": 'rtip',
          lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
          	"scrollX": false,
          	"processing": true,
          	"destroy": true,
          	"language": {
            	"processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
              "emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
          	},
          	"ajax": {
            	"url": urlx+"/api/get-penilaian-mandiri",
            	"contentType": 'application/json',
            	"headers": {
              		'Authorization': 'Bearer '+token
            	},
            	"data":{
              		csrf_token: csrf.value,
              		'thn': thn
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
            	{"data": null, defaultContent: ''},
            	{"data": "tahun"},
            	// {"data": "indikator"},
            	{"data": "nama"},
            	// {"data": "tahapan"},
            	{
              		"render": function(data, type, JsonResultRow, meta){
                    	const d = new Date(JsonResultRow.bataswaktu)

                    	return d.toLocaleDateString();
              		}
            	},
            	// {"data": "bataswaktu"},
            	{"data": "kemajuan"},
            	{
              		"render": function(data, type, JsonResultRow, meta) {
                  		var btn = '';
                  		btn +="<div class='btn-group mb-3 btn-group-sm'>"+
                    	"<button class='btn icon btn-outline-info detail-form' data-id_form='" + JsonResultRow.id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-info-circle' viewBox='0 0 16 16'><path d='M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16'/><path d='m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0'/></svg></button>"
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
    }

    $(document).on('click', '.detail-form', function(){
      	var fd = new FormData();
      	fd.append('csrf_token', csrf.value,);
      	var idx = $(this).data('id_form');
      	fd.append('idx' , idx);
      	$.ajax({
        	url: urlx+"/dashboard/get-detail-form",
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
          		csrf.value = data.token_crs
          		setTimeout(function(){
                  ///
		            if (data.success == 1) {
		              window.location.href = urlx+'/'+data.dt;
		            }else{
		              swal("Error", "Ops Terjadi Kesalahan : "+data.msg, "error");
		            }

            	},500)
        	}
      	})
    })




})