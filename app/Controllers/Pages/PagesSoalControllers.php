<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class PagesSoalControllers extends BaseController
{
    public function __construct(){
        // helper('cookie');
        // $key = getenv('TOKEN_SECRET');
        // $token = get_cookie('Authorization', true,'');
        // $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $this->db = db_connect();
    }
    
    public function index()
    {
        $data = array('usr' => 'Soal', );
        return view('Pages/soal/dashboard',$data);
    }

    public function addData()
    {
        $IDX = null;
        $LIMIT = null;
        $OFFSET =null;
        $aspek = $this->db->query("call View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $subaspek = $this->db->query("call View_Sub_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $subsubaspek = $this->db->query("call View_sub_sub_aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $indk = $this->db->query("call View_Indikator('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();
        $jjwb = $this->db->query("call View_Jenis_Jawaban('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();

        $data = array('usr' => 'Soal',
            'asp'   => $aspek,
            'sasp'  => $subaspek,
            'ssasp' => $subsubaspek,
            'ind'   => $indk,
            'jjwb'  => $jjwb,
         );
        return view('Pages/soal/tambah_soal',$data);
    }
}
