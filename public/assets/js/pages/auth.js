   (function() {
        'use strict';
        window.addEventListener('load', function() {
            // aos_init()
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('login-form');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                        form.classList.add('was-validated');    
                    }else{
                        event.preventDefault();
                        event.stopPropagation();
                        form.classList.add('was-validated');
                        var btnicon = document.getElementById("btnLogin");
                        btnicon.innerHTML='<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Cheking..'
                        btnicon.disabled = true
                        var fd = new FormData($('#login')[0])
                        var crsf = document.getElementById('csrf_token')
                        var url = window.location.href
                        let date = new Date();
                        localStorage.removeItem('Authorization');
                        setTimeout(function()
                        {
                            $.ajax({
                                type:"POST",
                                url: url+'/api/login',//url.replace(/\/[^\/]*$/, '/api/login'),
                                data:fd,
                                dataType: 'JSON',
                                processData : false,
                                contentType: false,
                                cache: false,
                                 success:function(data) {
                                     setTimeout(function(){
                                        if (data.success === 1) {
                                            date.setTime(date.getTime() + data.exp);
                                            url = url.replace(/\/[^\/]*$/, '/'+data.direct)
                                            window.location = url
                                         }else{
                                            crsf.value = data.token_crs
                                            btnicon.disabled = false
                                            btnicon.innerHTML= '<i class="fa-solid fa-right-to-bracket"></i> Login '
                                            Toastify({
                                                text: data.msg,
                                                duration: 3000,
                                                close:true,
                                                gravity:"top",
                                                position: "center",
                                                backgroundColor: "#fff3cd",
                                                className: "text-dark",
                                            }).showToast();
                                         }
                                     },1000)    
                                 },
                                 error: function(xhr, ajaxOptions, thrownError){
                                    Toastify({
                                        text: 'Error In :'+thrownError,
                                        duration: 3000,
                                        close:true,
                                        gravity:"top",
                                        position: "center",
                                        backgroundColor: "#DC143C",
                                        className: "text-white",
                                    }).showToast();
                                    // console.log(thrownError)
                                    // setTimeout(function(){
                                    //     window.location.reload()
                                    // },5000)
                                 }
                            })
                        },500);
                    }

                }, false);
            });

        }, false);
  //       function aos_init() {
  //   AOS.init({
  //     duration: 1000,
  //     easing: "ease-in-out",
  //     once: false,
  //     mirror: false
  //   });
  // }
    })();