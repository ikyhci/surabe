<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class PagesUsersControllers extends BaseController
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
        $usr = 'User';
        $data = array('usr' => $usr, );
        return view('Pages/user/penilaian_mandiri',$data);
    }

    public function detailForm()
    {
        $usr = 'User';
        
        $IDX = $this->request->getVar('idx');
        $LIMIT = null;
        $OFFSET =null;

        $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
        if ($asp->id != null) {
             $data = array(
                'usr'       => $usr,
                'token_crs' => csrf_hash(),
                'success'   => $asp->res,
                'msg'       => $asp->msg,
                'dt'        => 'detail-form',
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
    }

    public function listDetail()
    {
        $usr = 'User';
        
        $IDX = $this->request->getVar('idx');
        $LIMIT = null;
        $OFFSET =null;

        $asp = $this->db->query("CALL View_Aspek('".$IDX."','".$LIMIT."','".$OFFSET."')")->getRow();
        if ($asp->id != null) {
             $data = array(
                'usr'       => $usr,
                'token_crs' => csrf_hash(),
                'success'   => $asp->res,
                'msg'       => $asp->msg,
                'dt'        => $asp,
              );
            return view('Pages/user/detail_form',$data);
        }
    }
}
