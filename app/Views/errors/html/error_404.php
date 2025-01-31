<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - LKE</title>
    <link {csp-style-nonce} href="/assets/fonts/css2.css" rel="stylesheet">
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/bootstrap.css">
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/bootstrap-icons/bootstrap-icons.css">
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/app.css">
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/pages/error.css">
</head>

<body>
    <div id="error">
        <div class="error-page container">
          <div class="row">
            <div class="col-sm-12 d-flex justify-content-center">
              <img class="img-error w-25 p-3" src="<?php echo base_url();?>assets/images/error-404.png" alt="Not Found">
            </div>
            <div class="col-sm-12">
                <div class="text-center">
                  <h1 class="error-title">NOT FOUND</h1>
                    <p class="fs-5 text-gray-600">The page you are looking not found.</p>
                    <a href="/" class="btn btn-lg btn-outline-primary mt-3">Go Home</a>
                </div>
            </div>
          </div>
        </div>
    </div>
</body>

</html>