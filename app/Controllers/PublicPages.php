<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class PublicPages extends BaseController
{
    // $this->load->helper('captcha');
    // public function __construct(){
    //     $this->load->helper('captcha');
    // }
    
    public function login()
    {
        return view('login');
    }

    public function Unauthorized()
    {
        return view('Pages/unauthorized');
    }
}
