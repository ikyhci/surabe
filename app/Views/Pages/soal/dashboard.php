<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Styles -->
<link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.css">


<?= $this->endSection() ?>

<?= $this->section('content') ?>
<!-- Content -->
<div class="page-heading">
    <h3>Dashboard</h3>
</div>
<div class="page-content">
	 <section class="row">
                    <div class="col-12 col-lg-9">
                        <div class="row">
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                 <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Aspek</h6>
                                                <h6 class="font-extrabold mb-0" id="asp">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                 <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Sub Aspek</h6>
                                                <h6 class="font-extrabold mb-0" id="sasp">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                 <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Sub Sub Aspek</h6>
                                                <h6 class="font-extrabold mb-0" id="ssasp">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                 <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Indikator</h6>
                                                <h6 class="font-extrabold mb-0" id="indk">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                 <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Parameter</h6>
                                                <h6 class="font-extrabold mb-0" id="prmt">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 col-lg-4 col-md-6">
                                <div class="card">
                                    <div class="card-body px-3 py-4-5">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="stats-icon blue">
                                                    <i class="iconly-boldBookmark"></i>
                                                </div>
                                            </div>
                                            <div class="col-md-8">
                                                <h6 class="text-muted font-semibold">Bukti Dukung</h6>
                                                <h6 class="font-extrabold mb-0" id="bktdk">0</h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4>Profile Visit</h4>
                                    </div>
                                    <div class="card-body">
                                        <div id="chart-profile-visit"></div>
                                    </div>
                                </div>
                            </div>
                        </div> -->
                        
                    </div>
                    <div class="col-12 col-lg-3">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between">
                                <h4>Selamat Datang.</h4>
                                <button type="button" class="btn btn-outline-primary btn-sm profil-btn">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
                                        <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0"></path>
                                        <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z"></path>
                                    </svg>
                                </button>
                            </div>
                            <div class="card-body py-4 px-5">
                                <div class="d-flex align-items-center">
                                    <div class="avatar avatar-xl">
                                        <img src="assets/images/faces/1.jpg" alt="Face 1">
                                    </div>
                                    <div class="ms-3 name">
                                        <h5 class="font-bold" id="unamex"><?= $uname;?></h5>
                                        <h6 class="text-muted mb-0"><?= $usr;?></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                    </div>
                </section>
</div>


<?= $this->endSection() ?>

<?= $this->section('script') ?>

<?= $this->include('Pages/profil') ?>
<!-- Script -->
<script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/sweetalert/sweetalert.min.js"></script>

<script {csp-script-nonce} type="text/javascript">
    $(document).ready(function(){
        var token = document.getElementById('token').value;
        loadData()


        function loadData(){
            var csrf = document.getElementById('<?= csrf_token() ?>').value
            $.ajax({
                url: '<?php echo base_url();?>api/get-dashboard-data',
                type:'GET',
                headers: {
                    'Authorization': 'Bearer '+token
                 },
                data:{
                    <?= csrf_token() ?>: csrf
                },
                dataType: 'json',
                success: function(res){
                    $("input#<?= csrf_token() ?>").val(res.token_crs); 
                    document.getElementById('asp').innerHTML    = res.dt.asp;
                    document.getElementById('sasp').innerHTML   = res.dt.sasp;
                    document.getElementById('ssasp').innerHTML  = res.dt.ssasp;
                    document.getElementById('indk').innerHTML   = res.dt.indk;
                    document.getElementById('prmt').innerHTML   = res.dt.prmt;
                    document.getElementById('bktdk').innerHTML  = res.dt.bktdk;

                }
            });
        }

        $(document).on('click', '.profil-btn', function(){
            // 
            var csrf = document.getElementById('<?= csrf_token() ?>').value
            
            $.ajax({
                url: '<?php echo base_url();?>api/get-user-by-id',
                type:'POST',
                headers: {
                    'Authorization': 'Bearer '+token
                 },
                data:{
                    <?= csrf_token() ?>: csrf
                },
                dataType: 'json',
                success: function(res){

                    $("input#<?= csrf_token() ?>").val(res.token_crs); 
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
                // showpass
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

        // function save data 
        $(document).on('click', '#updates', function(){
            var crs = document.getElementById('<?= csrf_token() ?>').value
            var fd = new FormData($('#formdata')[0]);
            
            fd.append('<?= csrf_token() ?>',crs);
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
                        url: "<?php echo base_url();?>api/update-user-data",
                        type: "POST",
                        dataType: "JSON",
                        headers: {
                          'Authorization': 'Bearer '+token
                        },
                        data: fd,
                        processData : false,
                        contentType: false,
                        cache: false,
                        success: function(res){
                            console.log(res)
                            $("input#<?= csrf_token() ?>").val(res.token_crs);
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
                                    }
                                );
                            }
                            
                            // 

                        }
                    })
                });//
            }

            

        })
    })
</script>
<?= $this->endSection() ?>