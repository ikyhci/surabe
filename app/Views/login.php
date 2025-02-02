<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link {csp-style-nonce} href="/assets/fonts/css2.css" rel="stylesheet">
    <link {csp-style-nonce} rel="stylesheet" href="assets/css/bootstrap.css">
    <link {csp-style-nonce} rel="stylesheet" href="assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link {csp-style-nonce} rel="stylesheet" href="assets/css/app.css">
    <link {csp-style-nonce} rel="stylesheet" href="assets/vendors/toastify/toastify.css">
    <link {csp-style-nonce} rel="stylesheet" href="assets/css/pages/auth.css">
</head>

<body>
    <div id="auth">

        <div class="row h-100">
            <div class="col-sm-5 col-12">
                <div id="auth-left">
                    <div class="auth-logo">
                        <!-- <a href="/"><img src="assets/images/logo/logo.png" alt="Logo"></a> -->
                    </div>
                    <!-- <div class="text-center pesan-valid" id="valid"> -->
                    <h1 class="auth-title">Log in.</h1>

                    <form id="login" method="POST" class="needs-validations login-form" novalidate>
                        <div class="form-group position-relative has-icon-left mb-4">

                            <input type="text" name="username" class="form-control form-control" placeholder="Username" required>
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-4">
                            <input type="password" name="password" class="form-control form-control" placeholder="Password" required>
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <!-- capcha -->
                        <input type="hidden" id="<?= csrf_token() ?>" name="<?= csrf_token() ?>" value="<?= csrf_hash() ?>" />
                        <button type="submit" id="btnLogin"class="btn btn-primary btn-block shadow-lg mt-5">Log in</button>
                    </form>
                    <!-- <div class="text-center mt-5 text-lg fs-4">

                        <p><a class="font-bold" href="auth-forgot-password.html">Forgot password?</a>.</p>
                    </div> -->
                </div>
            </div>
            <div class="col-lg-7 d-none d-lg-block">
                <div id="auth-right">
                    <div class="container text-center d-flex justify-content-center">
                        <div class="vertical-center">
                            <h2 class="text-white">Aplikasi Evaluasi<br>Sistem Pemerintahan Berbasis Elektronik</h2>
                            <h4 class="text-white">Dinas Komunikasi, Informatika, Persandian, Dan Statistik<br> Provinsi Sulawesi Tengah</h4>
                        </div>
                        
                        
                    </div>
                    
                  

                </div>
            </div>
        </div>

    </div>
    <script {csp-script-nonce} src="<?= base_url('/assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="assets/vendors/toastify/toastify.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/bootstrap.bundle.min.js"></script>
    <script {csp-script-nonce} src="assets/js/pages/auth.js"></script>
</body>

</html>