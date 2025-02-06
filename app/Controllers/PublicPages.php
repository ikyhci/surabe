<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class PublicPages extends BaseController
{
    public function login()
    {
        return view('login');
    }

    public function Unauthorized()
    {
        return view('Pages/unauthorized');
    }
}
