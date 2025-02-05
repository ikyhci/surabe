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
    // protected $db;
    protected $decoded;
    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $usr = $this->decoded->rln;
        if ($usr != 'Soal' || $usr != 'Super Admin') {
            return redirect()->to(base_url().'unauthorized');
        }
        // $this->db = db_connect();
    }

    public function addData()
    {

        if (!empty($this->decoded->rln)) {
            $data = array('usr' => $this->decoded->rln,
            );
            return view('Pages/soal/tambah_soal',$data);
        }else{
            return redirect()->to(base_url().'unauthorized');
        }
    }
}
