$(document).ready(function(){
	// Global Variable
	let httpProtocol = window.location.protocol;
    let host = window.location.host;
    let urlx = httpProtocol+'//'+host;
    var token = document.getElementById('token').value;
    var csrf = document.getElementById('csrf_token')
	// Dashboard 
	//====================================
	

	loadTahun()

    function loadTahun(){
         // let httpProtocol = window.location.protocol;
         // let host = window.location.host;
         //  let urlx = httpProtocol+'//'+host;
         //  var token = document.getElementById('token').value;
         //  var csrf = document.getElementById('csrf_token')
          
        var opt = document.getElementById("pilih-tahun");  
        var pilih = new Choices(opt)
        $.ajax({
            url: urlx+'/api/get-dashboard-user',
            type: 'GET',
            headers: {
              'Authorization': 'Bearer '+token
            },
            data: {
              csrf_token: csrf.value
            },
            dataType: 'JSON',
            success: function(res){
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


    LoadDatatable()

	$(document).change('#pilih-tahun', function(){
      
        var optionSelected = $(this).find("option:selected");
        var valueSelected  = optionSelected.val();
        LoadDatatable(valueSelected);
        // LoadDatatable(valueSelected); 
        // console.log(valueSelected)
    })

    function LoadDatatable(thnx){
      
    var t = $('#datatable').DataTable({
        "dom": 'rtip',
        "scrollX": false,
        "processing": true,
        "destroy": true,
        "language": {
          "processing": "<i class='fas fa-sync-alt fa-spin'></i> Sedang Memuat Data",
        },
        "ajax": {
          "url": urlx+"/api/get-dashboard-table",
          "contentType": 'application/json',
          "headers": {
            'Authorization': 'Bearer '+token
          },
          "data":{
            csrf_token: csrf.value,
            thn: thnx,
            // "apv": apv,

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
          {"data": "nama_rb"},
          {"data": "nama_aspek"},
          {"data": "nama_sub_aspek"},
          {"data": "nama_sub_sub_aspek"},
          {"data": "indikator"},
          {"data": "bobot_subAspek"},
          {"data": "parameter"},
          {"data": "Jawabanx"},
          {"data": "nilaix"},
          {"data": "penilaix"},
        ],
        "columnDefs":[
          {
            // "className": "dt-center",
            "targets": [1,2,3,4],
            visible: false,
          },
          {
            "className": "dt-center",
            "targets":[5,6]
          }
        ],
        rowGroup: {
          // 
          dataSrc: ['nama_rb','nama_aspek','nama_sub_aspek','nama_sub_sub_aspek'],
             
          }
      });
    }

})