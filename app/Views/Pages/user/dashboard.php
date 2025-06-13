<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Style -->
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce} rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.bootstrap5.min.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.dataTables.css" />
    <link {csp-style-nonce} rel="stylesheet" href="https://cdn.datatables.net/rowgroup/1.5.1/css/rowGroup.dataTables.css" />
    
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <div class="d-flex justify-content-between">
         <div class="mr-auto p-2">
           <h3>Dashboard</h3>

         </div>
         <div class="p-2">
           <button type="button" class="btn btn-outline-primary btn-sm profil-btn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
                            <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0"></path>
                            <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z"></path>
                        </svg>
                    </button>
         </div>
      </div>
      
    </div>
    <div class="page-content">
      <div class="card">
          <div class="card-header">
              <h6>Informasi Progress Tahapan Evaluasi</h6>
          </div>
          <div class="card-body">
                  <!-- Chart -->
                  <div class="container pb-5 mb-sm-4">
    <!-- Progress-->
    <div class="steps">
        <div class="steps-body">
           <!--  <div class="step step-completed">
              <span class="step-indicator">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check">
                  <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
              </span>
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle">
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
              </span>Penilaian Mandiri
            </div> -->
           <!--  <div class="step step-completed">
              <span class="step-indicator">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check">
                  <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
              </span>
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle">
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
              </span>Penilaian Dokument
            </div> -->
            <!-- <div class="step step-completed">
              <span class="step-indicator">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check">
                  <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
              </span>
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle">
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
              </span>Penilaian Interview
            </div> -->
           <!--  <div class="step step-completed">
              <span class="step-indicator">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check">
                  <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
              </span>
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-check-circle">
                  <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                  <polyline points="22 4 12 14.01 9 11.01"></polyline>
                </svg>
              </span>Penilaian Visitasi
            </div> -->
            <!--  -->
            <!-- <div class="step step-active">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-award">
                  <circle cx="12" cy="8" r="7"></circle>
                  <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                </svg>
              </span>Harmonisasi
            </div> -->
            <!--  -->
            <!-- <div class="step">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-truck">
                  <rect x="1" y="3" width="15" height="13"></rect>
                  <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                  <circle cx="5.5" cy="18.5" r="2.5"></circle>
                  <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
              </span>Final
            </div> -->

             <!-- <div class="step">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-truck">
                  <rect x="1" y="3" width="15" height="13"></rect>
                  <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                  <circle cx="5.5" cy="18.5" r="2.5"></circle>
                  <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
              </span>Selesai
            </div> -->
            
            

        </div>
    </div>
    <!-- Footer-->
    <!-- <div class="d-sm-flex flex-wrap justify-content-between align-items-center text-center pt-4">
        <div class="custom-control custom-checkbox mt-2 mr-3">
            <input class="custom-control-input" type="checkbox" id="notify-me" checked="">
            <label class="custom-control-label" for="notify-me">Notify me when order is delivered</label>
        </div><a class="btn btn-primary btn-sm mt-2" href="#order-details" data-toggle="modal">View Order Details</a>
    </div> -->
</div>
                  <!--  -->
          </div>
      </div>
              <!--  -->
      <div class="card">
       <!--  <div class="card-header">
          <h4>Profile Visit</h4>
        </div> -->
        <div class="card-body">
            <div class="row">
              <div class=" col-sm-6">
                <div class="form-group">
                  <select class=" form-controll" id="pilih-tahun">
                    <option value="" selected disabled>-- Pilih Tahun Form --</option>
                  </select>
                </div> 
              </div>
             <!--  <div class="col-sm-6">
                
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
                        <label class="form-check-label" for="flexRadioDefault1">
                          Hasil Penilaian Mandiri
                        </label>
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
                        <label class="form-check-label" for="flexRadioDefault2">
                          Hasil Penilaian Akhir
                        </label>
                    </div>
                  </div>
                </div>
              </div> -->
            </div>   
            <!--  -->
            <!-- <div class="table-responsive">
              <table class="table mb-0">
                <tbody>
                  <tr>
                    <td class="text-bold-500">ID FORM</td>
                    <td class="text-bold-500"> : F01</td>
                  </tr>
                  <tr>
                    <td class="text-bold-500">Nama FORM</td>
                    <td class="text-bold-500"> : FORM01</td>
                  </tr>
                  <tr>
                    <td class="text-bold-500">Tahun</td>
                    <td class="text-bold-500"> : 2025</td>
                  </tr>
                  <tr>
                    <td class="text-bold-500">Deskripsi</td>
                    <td class="text-bold-500"> : Evaluasi SPBE 2025</td>
                  </tr>
                  <tr>
                    <td class="text-bold-500">Unduh Dokumen</td>
                    <td class="text-bold-500"> </td>
                  </tr>
                </tbody>
              </table>
            </div> -->
            <!--  -->
            <!-- Cahrt Radar -->
            <!-- <h4>Hasil Evaluasi SPBE 2025</h4>
            <script {csp-script-nonce} src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <div class="container">
              <canvas id="myChart"></canvas>
            </div> -->

            <!--  -->

           <!--  <div class="table-responsive">
              <table class="table mb-0">
                <tbody>
                  <tr>
                    <td class="text-bold-500">Nama Instansi</td>
                    <td class="text-bold-500"></td>
                  </tr>
                  <tr class="table-secondary ">
                    <td class="text-bold-500">Pemerintah Provinsi Sulawesi Tengah</td>
                    <td class="text-bold-500"></td>
                  </tr>
                  <tr class="dotsxhr">
                    <td class="text-bold-500"></td>
                    <td class="text-bold-500"></td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">K/L/D</td>
                    <td class="text-bold-500"> : Pemerintah Provinsi</td>
                  </tr>
                  <tr class="table-secondary">
                    <td class="text-bold-500">Index SPBE</td>
                    <td class="text-bold-500"> : 2.5</td>
                  </tr>
                  <tr class="table-secondary">
                    <td class="text-bold-500">Predikat SPBE</td>
                    <td class="text-bold-500"> : Cukup</td>
                  </tr>
                  <tr class="dotsxhr">
                    <td class="text-bold-500"></td>
                    <td class="text-bold-500"></td>
                  </tr>
                  <tr class="table-secondary">
                    <td class="text-bold-500">Domain Kebijakan SPBE</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Kebijakan Internal Terkait Tata Kelola SPBE</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Kebijakan Internal Layanan SPBE</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="table-secondary">
                    <td class="text-bold-500">Domain Tatakelola SPBE</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Kelembagaan</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Strategi Dan Perencanaan</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Teknologi Informasi Dan Layanan</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="table-secondary">
                    <td class="text-bold-500">Domain Layanan SPBE</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Layanan Administrasi Pemerintah Berbasis Elektronik</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                  <tr class="">
                    <td class="text-bold-500">Layanan Publik Berbasis Elektronik</td>
                    <td class="text-bold-500"> : 2.0</td>
                  </tr>
                </tbody>
              </table>
            </div> -->
            <!-- Datatable Indikator Level -->
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Nama RB</th>
                    <th>Nama Aspek</th>
                    <th>Nama Sub Aspek</th>
                    <th>Nama Sub Sub Aspek</th> 
                    <th>Indikator</th>
                    <th>Bobot Nilai</th>
                    <th>Parameter</th>
                    <th>Jawaban</th>
                    <th>Nilai</th>
                    <th>Penanggung Jawab</th>
                  </tr>
                  
                </thead>
              </table>
            </div>
      </div>
     
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<script {csp-script-nonce} src="<?php echo base_url();?>assets/vendors/choices.js/choices.min.js"></script>    
    <script {csp-script-nonce} src="<?= base_url('assets/vendors/jquery/jquery.min.js'); ?>"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.2/js/dataTables.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.2/js/dataTables.bootstrap5.min.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/dataTables.rowGroup.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/rowgroup/1.5.1/js/rowGroup.dataTables.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/pages/user.js"></script>
    <script {csp-script-nonce} src="<?php echo base_url();?>assets/js/pages/profil.js"></script>

    <?= $this->include('Pages/profil') ?>
    
    <script {csp-script-nonce} type="text/javascript">
      
//       const ctx = document.getElementById('myChart');
//       const data = {
//         labels: [
//           'Kebijakan Internal Terkait Tatakelola SPBE',
//           'Kebijakan Internal Layanan SPBE',
//           'Kelembagaan',
//           // 'Strategi Dan Perencanaan',
//           // 'Teknologi Informasi Dan komunikasi',
//           // 'Layanan AdPem Berbasis Elektronik',
//           // 'Aplikasi Publik Berbasis Elektronik'
//         ],
//         datasets: [{
//           label: 'Aplikasi SPBE Target',
//           data: [2, 2.5, 4],//, 2, 3, 2.3, 1],
//           fill: true,
//           backgroundColor: 'rgba(255, 99, 132, 0.2)',
//           borderColor: 'rgb(255, 99, 132)',
//           pointBackgroundColor: 'rgb(255, 99, 132)',
//           pointBorderColor: '#fff',
//           pointHoverBackgroundColor: '#fff',
//           pointHoverBorderColor: 'rgb(255, 99, 132)'
//         }, {
//           label: 'Aplikasi SPBE Index',
//           data: [1, 3.5, 2.4],//, 1, 4.5, 3, 2],
//           fill: true,
//           backgroundColor: 'rgba(54, 162, 235, 0.2)',
//           borderColor: 'rgb(54, 162, 235)',
//           pointBackgroundColor: 'rgb(54, 162, 235)',
//           pointBorderColor: '#fff',
//           pointHoverBackgroundColor: '#fff',
//           pointHoverBorderColor: 'rgb(54, 162, 235)'
//         }]
//       };
// new Chart(ctx, {
//     type: 'radar',
//     data: data,
//     options: {
//       scales: {
//             r: {
//                 suggestedMin: 1,
//                 suggestedMax: 5.0
//             }
//         },
//     elements: {
//       line: {
//         borderWidth: 3
//       }
//     }
//   },
//   });
    </script>

  
    
<?= $this->endSection() ?>