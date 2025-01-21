<?php

namespace App\Controllers;

class Dashboard extends BaseController
{
    // public function __construct(){
    //     helper('cookie');
    //     $key = getenv('TOKEN_SECRET');
    //     $token = get_cookie('Authorization', true,'');
    //     $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
    //     $this->db = db_connect();
    // }

    public function index()
    {
        // $usr ='User';
        $usr ='User';
        // $usr ='Penilai';
        // $usr ='Super Admin';

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
    }

    public function Unauthorized()
    {
        return view('Pages/unauthorized');
    }
}
