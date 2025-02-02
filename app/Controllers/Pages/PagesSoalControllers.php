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
    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        if(is_null($token) || empty($token)) {
            return redirect()->to(base_url().'unauthorized');
        }else{
             $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        }
        // $this->db = db_connect();
    }
    
    // public function index()
    // {
    //     if (!empty($this->decoded->rln)) {
    //         $data = array(
    //             'usr'   => $this->decoded->rln, 
    //             'uname' => $this->decoded->iss,
    //         );
    //         return view('Pages/soal/dashboard',$data);
    //     }else{
    //         return redirect()->to(base_url().'unauthorized');
    //     }
    // }

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
