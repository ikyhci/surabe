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
    
        $token = $_COOKIE['__Secure-LKE_Authorization']; // get_cookie('__LKE-Authorization');

        
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
        
        $this->data['form'] = $penilaianModel->getForm();
        
        return view('/Pages/penilai/index', $this->data);
    }

    public function detailForm()
    {
        $form = $this->request->getVar('form');
        
        // $form_id = $this->request->getVar('idform');
        try {
            $this->data['form'] = json_decode(base64_decode($form), true);
            if (empty($this->data['form'])) {
                return redirect()->to('/dashboard/penilaian');
            }
        } catch (\Exception $e) {
            return redirect()->to('/dashboard/penilaian');
        }
        
        $penilaianModel = new PenilaianModel();
        $userInfo = $penilaianModel->UserInfo($this->data['ids']);
        if ($userInfo->acs == '2') {
            $ids_aspek = array_map(function($aspek) {
                return $aspek->id;
            }, $userInfo->aspek);
        } else {
            $ids_aspek = null;
        }
        
        $lke_form = $this->db->table('lke_form')->where('tahun', $this->data['form']['tahun'])->get()->getRowArray();
        $this->data['form']['nama_form'] = $lke_form['nama'];
        $penilaianModel = new PenilaianModel();
        $data = $penilaianModel->nestedData( $this->data['form']['idasp'], $this->data['form']['opdid'], $ids_aspek , $this->data['form']['idForm'] );
        // pd($data);
        $IDX = $this->data['form']['idasp'];
        $LIMIT = 1;
        $OFFSET =null;
        $idopd = $this->data['form']['opdid']; 
        $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
        $this->data['opd']          = $this->db->query("CALL View_Opd('$idopd','null','null')") ->getRow();
        $this->data['usr']          = $this->decoded->rln;
        $this->data['token_crs']    = csrf_hash() ;
        $this->data['success']      = ($asp)? $asp->res : null ;
        $this->data['msg']          = ($asp)? $asp->msg : null ;
        $this->data['idx']          = base64_encode($IDX)  ;
        $this->data['dt']           = ($asp)? $asp : null ;
        $this->data['aspeks']        = $data ;
        $this->data['forms']        = $penilaianModel->getForm($this->data['form']['idForm']);
        $this->data['formids'] = $this->data['form']['idForm'];
        // pd($this->data);
        return view('/Pages/penilai/detail_form', $this->data);
    }
    
}