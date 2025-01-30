<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;

class PagesSoalControllers extends BaseController
{
    protected $db;
    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // $this->db = db_connect();
    }
    
    public function index()
    {
        $data = array('usr' => 'Soal', );
        return view('Pages/soal/dashboard',$data);
    }

    public function addData()
    {
        

        $data = array('usr' => 'Soal',
         );
        return view('Pages/soal/tambah_soal',$data);
    }
}
