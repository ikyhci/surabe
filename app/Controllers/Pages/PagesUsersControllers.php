<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
// use Exception;

class PagesUsersControllers extends BaseController
{

    protected $db;
    protected $decoded;
    public function __construct(){

        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        $token = get_cookie('Authorization', true,'__LKE-');
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        $this->db = db_connect();
    }
    
    public function index()
    {
        if (!empty($this->decoded->rln)) {
            $IDX = null;
            $LIMIT = null;
            $OFFSET =null;
            $thn = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getResult();

            $usr = $this->decoded->rln;
            $data = array(
                'usr'  => $usr,
                'thn'       => $thn,
                 );
            return view('Pages/user/penilaian_mandiri',$data);
        }else{
            return redirect()->to(base_url().'unauthorized');
        }
    }

    public function detailForm()
    {
        if (!empty($this->decoded->rln)) {
            $usr = $this->decoded->rln;
            
            $IDX = $this->request->getVar('idx');
            $LIMIT = null;
            $OFFSET =null;
            $encode = base64_encode($IDX);

            $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
            
            if ($asp->id != null) {
                 $data = array(
                    'usr'       => $usr,
                    'token_crs' => csrf_hash(),
                    'success'   => $asp->res,
                    'msg'       => $asp->msg,
                    'idx'       => $IDX ,
                    
                    'dt'        => 'dashboard/detail-form?form='.base64_encode($asp->id),
                    // ''
                  );
                return $this->response->setJSON($data);
               
             }else{
                $data = array(
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  0,
                        'msg'       =>  'error, Data tidak di temukan.',
                );
                return $this->response->setJSON($data);
             }
        }else{
            return redirect()->to(base_url().'unauthorized');
        }
    }

    public function listDetail()
    {
        if (!empty($this->decoded->rln)) {
            $usr = $this->decoded->rln;
            
            $IDX = base64_decode($this->request->getVar('form'));
            $LIMIT = 1;
            $OFFSET =null;

            $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
            if ($asp->id != null) {
                 $data = array(
                    'usr'       => $usr,
                    'token_crs' => csrf_hash(),
                    'success'   => $asp->res,
                    'msg'       => $asp->msg,
                    'idx'       => base64_encode($IDX) ,
                    'dt'        => $asp,
                  );
                return view('Pages/user/detail_form',$data);
            }else{
                return redirect()->to(base_url().'404');
            }

        }else{
            return redirect()->to(base_url().'unauthorized');
        }
    }

    // public function FunctionName($value='')
    // {
    //     // code...
    // }
}
