<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= getenv('APPNAME') ?> | Dashboard</title>

    <link {csp-style-nonce}  rel="preconnect" href="https://fonts.gstatic.com">
    <link {csp-style-nonce}  href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/bootstrap.css">

    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/iconly/bold.css">

    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/perfect-scrollbar/perfect-scrollbar.css">
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/app.css">
    <link {csp-style-nonce}  rel="shortcut icon" href="<?php echo base_url();?>assets/images/favicon.svg" type="image/x-icon">
    <?= $this->renderSection('styles') ?>

</head>

<body>
    <div id="app">
      <?= $this->include('Components/sidebar') ?>

      <div id="main">  
        <?= $this->include('Components/header') ?>
        <?= $this->renderSection('content') ?>
        <input type="hidden" id="<?= csrf_token() ?>" name="<?= csrf_token() ?>" value="<?= csrf_hash() ?>" />
        <?= $this->include('Components/footer') ?>
      </div>

    </div>
    <!-- token auth -->
    <?php 
    helper('cookie');
    $token = get_cookie('Authorization', true,'__LKE-');
    echo '
    <input type="hidden" name="token" id="token" value="'.$token.'">';
    ?>
    
    
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/bootstrap.bundle.min.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/main.js"></script>
    <?= $this->renderSection('script') ?>
</body>

</html>