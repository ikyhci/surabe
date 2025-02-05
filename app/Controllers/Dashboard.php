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

    protected $decoded;

    public function __construct(){
        // parent::__construct();
        helper('cookie');
        // // $this->db = db_connect();
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // if(is_null($token) || empty($token)) {
        //     return redirect()->to(base_url().'unauthorized');
        // }else{
        //      $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // }
       
        // $this->db = db_connect();
    }

    public function index()
    {
        if (!empty($this->decoded->rln)) {
            $usr = $this->decoded->rln;
            $data = array(
                'usr' => $usr,
                'uname' => $this->decoded->iss, 
            );
            if ($usr == 'User') {

                return view('Pages/user/dashboard',$data);
            }
            if ($usr == 'Soal') {
                
                return view('Pages/soal/dashboard',$data);
            }
            if ($usr == 'Penilai') {
              
                return view('Pages/dashboard',$data);
            }
            if ($usr == 'Super Admin') {
                
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

    public function help()
    {
        if (!empty($this->decoded->rln)) {
            $usr = $this->decoded->rln;
            $data = array('usr' => $usr, );
            return view('Pages/help',$data);
        }else{
            return redirect()->to(base_url().'unauthorized');
            
        }
    }
}
