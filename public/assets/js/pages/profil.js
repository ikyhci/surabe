$(document).ready(function(){
````/* Global Variable */
	let httpProtocol = window.location.protocol;
	let host = window.location.host;
	let urlx = httpProtocol+'//'+host;
	var token = document.getElementById('token').value;
	var csrf = document.getElementById('csrf_token')

	$(document).on('click', '.profil-btn', function(){
        $.ajax({
            url: urlx+'/api/get-user-by-id',
            type:'POST',
            headers: {'Authorization': 'Bearer '+token},
            data:{
                csrf_token: csrf.value
            },
            dataType: 'json',
            success: function(res){
                csrf.value = res.token_crs 
                document.getElementById('fname').value  = res.dt.FullName;
                document.getElementById('uname').value  = res.dt.UserName;
                document.getElementById('umail').value   = res.dt.EmailAdds;
                document.getElementById('phone').value  = res.dt.Phone;
                document.getElementById('idx').value  = res.dt.uid;

                document.getElementById('newpas').value ='';
                document.getElementById('reppas').value ='';
                document.getElementById('newpas').disabled = true;
                document.getElementById('newpas').required = false;
                document.getElementById('reppas').disabled = true;
                document.getElementById('reppas').required = false;

                var chk = document.getElementById('edtpas')
                if (chk.checked == true) {
                    chk.checked = false
                    $('#showpass').addClass('d-none');
                    $('#tampilpass').prop( "checked", false )
                    $('#newpas').attr('type', 'password'); 
                    $('#reppas').attr('type', 'password'); 
                }

                $('#edit-data').modal('show');
            }
        });
    })

    $(document).on('change', '#edtpas', function(){
        var chk = document.getElementById('edtpas')
        if (chk.checked == true) {
            document.getElementById('newpas').disabled = false;
            document.getElementById('newpas').required = true;
            document.getElementById('reppas').disabled = false;
            document.getElementById('reppas').required = true;
            $('#showpass').removeClass('d-none');
            $('#tampilpass').prop( "checked", false )
        }else{
            $('#showpass').addClass('d-none');
            $('#tampilpass').prop( "checked", false )
            $('#newpas').attr('type', 'password'); 
            $('#reppas').attr('type', 'password'); 
            $('#newpas').val(''); 
            $('#reppas').val(''); 
            document.getElementById('newpas').disabled = true;
            document.getElementById('newpas').required = false;
            document.getElementById('reppas').disabled = true;
            document.getElementById('reppas').required = false;
        }
    })

    $(document).on('change', '#tampilpass', function(){
        var show = document.getElementById('tampilpass')
        if (show.checked == true) {
            $('#newpas').attr('type', 'text'); 
            $('#reppas').attr('type', 'text'); 
        }else{
            $('#newpas').attr('type', 'password'); 
            $('#reppas').attr('type', 'password'); 
        }
    })

    /* Save Data

    ============================================================================

    */

    $(document).on('click', '#updates', function(){

        var fd = new FormData($('#formdata')[0]);
        fd.append('csrf_token', csrf.value)
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
                text: "Perubahan Data ?",
                type: "info",
                showCancelButton: true,
                closeOnConfirm: false,
                showLoaderOnConfirm: true,
            },function(){
                $.ajax({
                    url: urlx+"/api/update-user-data",
                    type: "POST",
                    dataType: "JSON",
                    headers: {'Authorization': 'Bearer '+token},
                    data: fd,
                    processData : false,
                    contentType: false,
                    cache: false,
                    success: function(res){
                        csrf.value = res.token_crs
                        if (res.success == 1) {
                            swal({
                                title:"Data Berhasil Di Simpan",
                                text: res.msg,
                                type: "success"
                            }, function(){
                                document.getElementById('unamex').innerHTML = document.getElementById('uname').value
                                $('#edit-data').modal('hide');
                            }
                            );  
                        }else{
                            swal({
                                title:"Ops..",
                                text: res.msg,
                                type: "error"
                            }, function(){
                                $('#edit-data').modal('hide');
                            });
                        }
                    }
                })
            });
        }

    })
})