<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use App\Models\PenilaianModel;

class PagesPenilaiControllers extends BaseController
{
    protected $db;
    protected $decoded;
    public $data;

    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
    
        $token = $_COOKIE['__LKE-Authorization']; // get_cookie('__LKE-Authorization');
        
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        
        $this->db = db_connect();
        $this->data = [
            'title' => 'Penilaian',
            'usr' => $this->decoded->rln,
            'ids' => $this->decoded->ids,
            'token' => $token
        ];
    }
    
    public function index()
    {
        $penilaianModel = new PenilaianModel();
        $this->data['opd'] = $penilaianModel->getDataOpd(null);
        $this->data['aspek'] = $penilaianModel->getAspek();
        // dd($this->data['opd']);
        return view('/Pages/penilai/index', $this->data);
    }

    public function detailForm()
    {
        $form = $this->request->getVar('form');
        $this->data['form'] = json_decode(base64_decode($form), true);
        $penilaianModel = new PenilaianModel();
        $data = $penilaianModel->nestedData( $this->data['form']['idasp'], $this->data['form']['opdid'] );
        // echo "<pre>";
        // echo json_encode($data);
        // die;
        $IDX = '0d94dc2a709e6902b75bb2bbdb03c64b754f6061'; //$this->data['form']['opdid'];
        $LIMIT = 1;
        $OFFSET =null;

        $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
  
        // $this->data = [
        //     'usr'       => $this->decoded->rln,
        //     'token_crs' => csrf_hash(),
        //     'success'   => $asp->res,
        //     'msg'       => $asp->msg,
        //     'idx'       => base64_encode($IDX) ,
        //     'dt'        => $asp,
        //     'aspek'      => $data,
        // ];
        $this->data['usr']          = $this->decoded->rln;
        $this->data['token_crs']    = csrf_hash() ;
        $this->data['success']      = $asp->res ;
        $this->data['msg']          = $asp->msg ;
        $this->data['idx']          = base64_encode($IDX)  ;
        $this->data['dt']           = $asp ;
        $this->data['aspek']        = $data ;
        
        $penilaianModel = new PenilaianModel();
        // $data = $penilaianModel->getDetailForm();
        // dd($this->data);
        return view('/Pages/penilai/detail_form', $this->data);
    }
    
}
