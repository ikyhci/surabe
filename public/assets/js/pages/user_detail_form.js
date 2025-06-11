$(document).ready(function(){
	// Global Variable
	let httpProtocol = window.location.protocol;
    let host = window.location.host;
    let urlx = httpProtocol+'//'+host;
    var token = document.getElementById('token').value;
    var csrf = document.getElementById('csrf_token');
    var form = document.getElementById('form').value
    let validExt = ['jpg', 'jpeg', 'png','pdf','docx','doc','xls','xlsx']
	// Penilaian Mandiri Detail Form
	//====================================

	LoadDatatable() 

	// Load Data
	//====================================

	function LoadDatatable(){
           
        var t = $('#datatable').DataTable({
            "dom": 'rtip',
            "scrollX": false,
            "processing": true,
            "language": {
                "processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
                "emptyTable": "Tidak Ada Data Untuk Di Tampilkan",
            },
            "ajax": {
                "url": urlx+"/api/get-indikator-penilaian",
                "contentType": 'application/json',
                "headers": {
                   	'Authorization': 'Bearer '+token
                },
                "data":{
                	csrf_token: csrf.value,
                   	"form" : form,
                },
                "method": "GET",
                "dataSrc": function(data){
                   	// console.log(data)
                   	csrf.value = data.token_crs
                    return data.dt;
                },
            },
            // "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
            //     var index = iDisplayIndex +1;
            //     $('td:eq(0)',nRow).html(index);
            //     return nRow;
            // },
            "columns":[
                {"data": null, defaultContent: ''},
                {"data": "indikator"},


                {
                    "render": function(data, type, JsonResultRow, meta) {
                        var btn = '';
                        var btncl = '';
                         
                        
                        if (JsonResultRow.jwbx == 0 ) {
                            btncl = 'btn-outline-warning'
                        }

                        if (JsonResultRow.jwbx != 0 ) {
                            btncl = 'btn-outline-info'

                            if (JsonResultRow.tombol == 1) {
                                btncl = 'btn-outline-primary'
                            }
                            if (JsonResultRow.tombol == 0) {
                                btncl = 'btn-outline-danger'
                            }
                            
                        }
                        
                        
                        btn +="<div class='btn-group mb-3 btn-group-sm'>"+
                        
                          "<button class='btn icon "+btncl+" detail-indikator' data-idx='" + JsonResultRow.ind_id + "'><svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='currentColor' class='bi bi-eye' viewBox='0 0 16 16'><path d='M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z'/><path d='M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0'/></svg></button>"
                        +"</div>"
                        return btn;
                    }
                },
            ],
            "columnDefs":[
                {
                    "className": "dt-center",
                    // "targets": [0,5]
                    "targets": [0,2]
                },
                // {
                //     "visible": false,
                //     "targets": [2,3,4]
                // },
            ],
                // order: [[2, 'asc']],
            "rowGroup": {
                dataSrc: ['nama_sub_aspek2','nama_sub_sub_aspek'],
                // dataSrc: 2,
                // startRender: function (rows, nama_sub_aspek, bataswaktu) {
                //     let dates = rows.data().pluck('bataswaktu')[0]; // Date column
                //     // let fixdate = dates.toString().replace(" ", "T");
                    

                //     console.log( dates)
                //     return nama_sub_aspek + ' (Batas Waktu: ' +dates+ ')';
                //   },
                // endRender: null,
                
            }
        });
            
    }

    function ReloadTable(){
        var t = $('#datatable').DataTable();
        t.ajax.reload(null, false);
    }

    // Get Detail Indikator
    //====================================

    $(document).on('click', '.detail-indikator', function(){
        var idx = $(this).data('idx')
        var fd = new FormData();
        fd.append('csrf_token', csrf.value,);
        fd.append('idx',idx);
        $.ajax({
            url: urlx+'/api/get-detail-indikator',
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
                // console.log(data)
                
                csrf.value = data.token_crs
                if(data.dt.indk.wktsubasp == 0 || data.dt.indk.wktsubasp == null){
                    if (data.dt.indk.tombol == null || data.dt.indk.tombol == 0) {
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
                }

                if (data.dt.indk.wktsubasp == 1) {
                    document.getElementById('tblfoot').innerHTML = 
                        '<button type="button" class="btn btn-light-secondary" data-bs-dismiss="modal">'+
                            '<i class="bx bx-x d-block d-sm-none"></i>'+
                            '<span class="d-none d-sm-block">Close</span>'+
                        '</button>';
                }
                

                document.getElementById('rb').innerHTML = ': '+data.dt.indk.nmrb 
                document.getElementById('aspk').innerHTML = ': '+data.dt.indk.nmaspek
                document.getElementById('indk').innerHTML = ': '+data.dt.indk.nmindk
                if (data.dt.indk.num == 1 ) {
                  // linear
                  loadLinear(data.dt.prmt, data.dt.btdk, data.dt.indk, data.dt.flx)
                }
                if (data.dt.indk.num == 2 ) {
                  // yesno
                  loadYesNo(data.dt.prmt, data.dt.btdk, data.dt.indk, data.dt.flx)
                }
                if (data.dt.indk.num == 4 ) {
                  //pilihan ganda
                  loadPilihanGanda(data.dt.prmt, data.dt.btdk, data.dt.indk, data.dt.flx)
                  
                }
                
                $('#Detailparameter').modal('show');
                $('input[type="file"]').change(function(){
                    const fileName = $(this).val().split("\\").pop();
                    var ext = fileName.split('.').pop();//this.files[0].type.split('.')[1]
                    const idx = $(this).attr("id")
                    if(validExt.indexOf(ext) == -1){
                        
                        document.getElementById(idx).value =''
                        swal("Ops..", "File Yang Di Upload Tidak Sesuai ,\n Pastikan File Berformat [jpeg, jpg, png, pdf, docx, doc, xls, xlsx]", "error");
                    }
                })
            },
        })

    })

    // Load templates
    //====================================

    // Pilihan Ganda Template

    function loadPilihanGanda(data, dkn, jwb, fls){
        // console.log(jwb)
        var str = '<ol type="A">'
        var plh = '';
        var upl = '';
        var flx = '<ol type="*">';
        var ket = '';

        if (jwb.tolak == 1) {
            ket += '<div class="alert alert-danger"><h4 class="alert-heading">Di Tolak</h4>'+
                    '<p>'+jwb.ketsx+'.</p></div>'
        }else{
            ket = '';
        }
           
        for (var i = 0; i < data.length; i++) {
            str += '<li>'+data[i].nama_parameter+'</li>'
            plh += '<option value="'+data[i].id+'">'+String.fromCharCode(65+i)+'</option>'
        }

        if (jwb.wktsubasp == 0 || jwb.wktsubasp == null) {
            //
            if (jwb.tombol == 0 || jwb.tombol == null) {
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+
                        dkn[i].nmbukti+'</label><input id="file'+i+
                        '" type="file" name="'+dkn[i].id+
                        '" class="form-control" ><small>Max file size 6 MB</small></div></li>'
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].bukti_dukung+'</a></div></li>';
                }

            }else{
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].bukti_dukung+'</a></div></li>'
                  
                }
            }
            //
        }else{
            for (var i = 0; i < dkn.length; i++) {
                upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
            }

            for (var i = 0; i < fls.length; i++) {
                flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>'
                  
            }
        }

        
             

        str += '</ol>';
        str += '<form id="formdata" enctype="multipart/form-data">'+
               	'<input type="hidden" name="indikator" value="'+data[0].id_indikator+'">'+
                '<input type="hidden" name="idx" value="'+jwb.idjwbx+'">'+
                '<div class="col-md-12 mb-6">'+
                    '<div class="form-group"><h6>Jawaban <span class="text-danger">*</span></h6>'+
                        '<select class=" form-select" name="jwbn" id="jwbn" required>'+
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
        document.getElementById('content-info').innerHTML = ket;
        $("#jwbn").val(jwb.jwbx).trigger('change')

        if (jwb.wktsubasp > 0 || jwb.tombol > 0 || jwb.tombol != null) {
            var input =  document.getElementById('jwbn');
            input.disabled = true;
        }
    }

    // Linear Template

    function loadLinear(data,dkn,jwb, fls){
        var str = '<ol type="A">'
        // var plh = '';
        var upl = '';
        var flx = '<ol type="*">';
        var ket = '';

        if (jwb.tolak == 1) {
            ket += '<div class="alert alert-danger"><h4 class="alert-heading">Di Tolak</h4>'+
                    '<p>'+jwb.ketsx+'.</p></div>'
        }else{
            ket = '';
        }
        
        for (var i = 0; i < data.length; i++) {
            str += '<li>'+data[i].nama_parameter+'</li>'
            // plh += '<option value="'+String.fromCharCode(65+i)+'">'+String.fromCharCode(65+i)+'</option>'
        }
        

        if (jwb.wktsubasp == 0 || jwb.wktsubasp == null) {
            //
            if (jwb.tombol == 0 || jwb.tombol == null) {
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label><input id="file'+i+'" type="file" name="'+dkn[i].id+'" class="form-control" ><small>Max file size 6 MB</small></div></li>'
                  
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>';
                }

            }else{
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>'
                  
                }
            }
            //

        }else{
            for (var i = 0; i < dkn.length; i++) {
                upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
            }

            for (var i = 0; i < fls.length; i++) {
                flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>'
                  
            }
        }

        
            
             

        str += '</ol>';
             
        str += '<form id="formdata" enctype="multipart/form-data">'+
                    '<input type="hidden" name="indikator" value="'+data[0].id_indikator+'">'+
                    '<input type="hidden" name="idx" value="'+jwb.idjwbx+'">'+
                    '<div class="col-md-12 mb-6">'+
                        '<div class="form-group"><h6>Jawaban <span class="text-danger">*</span></h6>'+
                        '<input type="range" class="form-range" name="jwbn" value="0" min="0" max="100" id="customRange2" required>'+
                        '<small id="ranges">Value : 0</small>'+
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
        document.getElementById('content-info').innerHTML = ket;

        $('#customRange2').val(jwb.jwbx)
        var output = document.getElementById("ranges");
        output.innerHTML = 'Value : '+jwb.jwbx

        if (jwb.wktsubasp > 0 || jwb.tombol > 0 || jwb.tombol != null) {
            var input =  document.getElementById('ranges');
            input.disabled = true;
        }
    }

    // Yes No Template

    function loadYesNo(data,dkn,jwb, fls) {
        var str = '<ol type="*">'
        var plh = '';
        var upl = '';
        var flx = '<ol type="*">';
        var ket = '';

        if (jwb.tolak == 1) {
            ket += '<div class="alert alert-danger"><h4 class="alert-heading">Di Tolak</h4>'+
                      '<p>'+jwb.ketsx+'.</p></div>'
        }else{
            ket = '';
        }

        for (var i = 0; i < data.length; i++) {
            str += '<li>'+data[i].nama_parameter+'</li>'
        }

        if (jwb.wktsubasp == '0' || jwb.wktsubasp == null) {
            //
            if (jwb.tombol == 0|| jwb.tombol == null) {
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label><input id="file'+i+'" type="file" name="'+dkn[i].id+'" class="form-control" ><small>Max file size 6 MB</small></div></li>'
                  
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>';
                }

            }else{
                for (var i = 0; i < dkn.length; i++) {
                    upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
                }

                for (var i = 0; i < fls.length; i++) {
                    flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>'
                  
                }
            }
            //
        }else{
            for (var i = 0; i < dkn.length; i++) {
                upl +='<li><div class="form-group"><label>'+dkn[i].nmbukti+'</label></div></li>'
            }

            for (var i = 0; i < fls.length; i++) {
                flx += '<li><div class="form-group"><a href="'+urlx+'/uploadfile/'+fls[i].files+'" target="_blank">'+fls[i].nmbukti+'</a></div></li>'
                  
            }
        }
        

        str += '</ol>';
        str += '<form id="formdata" enctype="multipart/form-data">'+
                    '<input type="hidden" name="indikator" id="indikator" value="'+data[0].id_indikator+'">'+
                    '<input type="hidden" name="idx" value="'+jwb.idjwbx+'">'+
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
        document.getElementById('content-info').innerHTML = ket;
        if (jwb.jwbx === 'YA') {
            document.getElementById('jwb1').checked = true;
        }
        if (jwb.jwbx === 'TIDAK') {
            document.getElementById('jwb2').checked = true;
        }

        if (jwb.wktsubasp > 0 || jwb.tombol > 0 || jwb.tombol != null) {
            var input =  document.getElementById('jwb1');
            var input2 =  document.getElementById('jwb2');
            input.disabled = true;
            input2.disabled = true;
        }
    }

    // On Change Value Range

    $(document).on('change', '#customRange2',function(){
        var slider = document.getElementById("customRange2");
        var output = document.getElementById("ranges");
        output.innerHTML = 'Value : '+slider.value;
           
        slider.oninput = function() {
            output.innerHTML = 'Value : '+this.value;
        }
    })

    //  Save Data Mandiri

    $(document).on('click' , '#savedata', function(){ 
        var fd = new FormData($('#formdata')[0]);
        var form = document.getElementById('formdata');
        fd.append('csrf_token', csrf.value,);

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
	                  	url: urlx+'/api/save-jawaban',
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
		                    csrf.value = data.token_crs
		                    setTimeout(function(){
		                      	if (data.success == 1) {
		                        	swal('success','Data Berhasil Di Simpan','success');
		                        	ReloadTable()
		                        	$('#Detailparameter').modal('hide');
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
    });

})