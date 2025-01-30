<?php

namespace App\Controllers;
use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;

class Dashboard extends BaseController
{
    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('__LKE-Authorization', true,'');
        if(is_null($token) || empty($token)) {
            return redirect()->to(base_url().'unauthorized');
        }else{
             $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        }
       
        // $this->db = db_connect();
    }

    public function index()
    {
        if (!empty($this->decoded->rln)) {
        $usr = $this->decoded->rln;
            // $usr ='Soal';
            // $usr ='Penilai';
            // $usr ='Super Admin';
            // if (!empty($this->decoded->rln)) {

            if ($usr == 'User') {
                $data = array('usr' => $usr, );
                return view('Pages/user/dashboard',$data);
            }
            if ($usr == 'Soal') {
                $data = array('usr' => $usr, );
                return view('Pages/soal/dashboard',$data);
            }
            if ($usr == 'Penilai') {
                $data = array('usr' => $usr, );
                return view('Pages/dashboard',$data);
            }
            if ($usr == 'Super Admin') {
                $data = array('usr' => $usr, );
                return view('Pages/dashboard',$data);
            }
        }else{
            return redirect()->to(base_url().'unauthorized');
        }
    }

    public function Unauthorized()
    {
        return view('Pages/unauthorized');
    }
}
