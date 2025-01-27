<?= $this->extend('Layouts/dashboard') ?>
<?= $this->section('styles') ?>
<!-- Style -->
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/vendors/choices.js/choices.min.css" />
    <link {csp-style-nonce}  rel="stylesheet" href="<?php echo base_url();?>assets/css/costum.css">
    <link {csp-style-nonce}  rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.bootstrap5.min.css" />
    
<?= $this->endSection() ?>

<?= $this->section('content') ?>

    <div class="page-heading">
      <h3>Dashboard User</h3>
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
            <div class="step step-completed">
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
            </div>
            <div class="step step-completed">
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
            </div>
            <div class="step step-completed">
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
            </div>
            <div class="step step-completed">
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
            </div>
            <!--  -->
            <div class="step step-active">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-award">
                  <circle cx="12" cy="8" r="7"></circle>
                  <polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline>
                </svg>
              </span>Harmonisasi
            </div>
            <!--  -->
            <div class="step">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-truck">
                  <rect x="1" y="3" width="15" height="13"></rect>
                  <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                  <circle cx="5.5" cy="18.5" r="2.5"></circle>
                  <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
              </span>Final
            </div>

             <div class="step">
              <span class="step-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-truck">
                  <rect x="1" y="3" width="15" height="13"></rect>
                  <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
                  <circle cx="5.5" cy="18.5" r="2.5"></circle>
                  <circle cx="18.5" cy="18.5" r="2.5"></circle>
                </svg>
              </span>Selesai
            </div>
            
            

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
                  <select class="choices form-select">
                      <option value="square">Square</option>
                      <option value="rectangle">Rectangle</option>
                      <option value="rombo">Rombo</option>
                      <option value="romboid">Romboid</option>
                      <option value="trapeze">Trapeze</option>
                      <option value="traible">Triangle</option>
                      <option value="polygon">Polygon</option>
                  </select>
                </div> 
              </div>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
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
              </div>
            </div>   
            <!--  -->
            <div class="table-responsive">
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
            </div>
            <!--  -->
            <!-- Cahrt Radar -->
            <h4>Hasil Evaluasi SPBE 2025</h4>
            <script {csp-script-nonce} src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <div class="container">
              <canvas id="myChart"></canvas>
            </div>

            <!--  -->

            <div class="table-responsive">
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
            </div>
            <!-- Datatable Indikator Level -->
            <div class="table-responsive">
              <table class="table table-sm" id="datatable">
                <thead>
                  <tr>
                    <th>No.</th>
                    <th>Indikator</th>
                    <th>Level</th>
                  </tr>
                  
                </thead>
              </table>
            </div>
      </div>
     
    </div>

<!-- konten view di sini -->
<?= $this->endSection() ?>


<?= $this->section('script') ?>
<script {csp-script-nonce} src="assets/vendors/choices.js/choices.min.js"></script>    
    <script {csp-script-nonce} src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.1/js/dataTables.min.js"></script>
    <script {csp-script-nonce} src="https://cdn.datatables.net/2.2.1/js/dataTables.bootstrap5.min.js"></script>
    
    <script {csp-script-nonce} type="text/javascript">
      
      const ctx = document.getElementById('myChart');
      const data = {
        labels: [
          'Kebijakan Internal Terkait Tatakelola SPBE',
          'Kebijakan Internal Layanan SPBE',
          'Kelembagaan',
          'Strategi Dan Perencanaan',
          'Teknologi Informasi Dan komunikasi',
          'Layanan AdPem Berbasis Elektronik',
          'Aplikasi Publik Berbasis Elektronik'
        ],
        datasets: [{
          label: 'Aplikasi SPBE Target',
          data: [2, 2.5, 4, 2, 3, 2.3, 1],
          fill: true,
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgb(255, 99, 132)',
          pointBackgroundColor: 'rgb(255, 99, 132)',
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: 'rgb(255, 99, 132)'
        }, {
          label: 'Aplikasi SPBE Index',
          data: [1, 3.5, 2.4, 1, 4.5, 3, 2],
          fill: true,
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgb(54, 162, 235)',
          pointBackgroundColor: 'rgb(54, 162, 235)',
          pointBorderColor: '#fff',
          pointHoverBackgroundColor: '#fff',
          pointHoverBorderColor: 'rgb(54, 162, 235)'
        }]
      };
new Chart(ctx, {
    type: 'radar',
    data: data,
    options: {
      scales: {
            r: {
                suggestedMin: 1,
                suggestedMax: 5.0
            }
        },
    elements: {
      line: {
        borderWidth: 3
      }
    }
  },
  });
    </script>

  <script {csp-script-nonce} type="text/javascript">
    LoadDatatable()

    function LoadDatatable(){
      var t = $('#datatable').DataTable({
        "dom": 'rtip'
      });
    }
    
  </script>
    
<?= $this->endSection() ?>