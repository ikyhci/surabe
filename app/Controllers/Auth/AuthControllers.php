<?php

namespace App\Controllers\Auth;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;

class AuthControllers extends BaseController
{
    protected $db;
    public function __construct()
    {
        helper('cookie');
        $this->db = db_connect();
    }
    
    public function index()
    {
        //
    }

    public function auth()
    {
        
        if ($this->validate([
            'username'  => 'required|trim|regex_match[/[a-zA-Z0-9@.]/]|min_length[4]',
            'password'  => 'required|trim|regex_match[/[a-zA-Z0-9@.]/]|min_length[8]'
        ]))
        {
            $unm = $this->request->getVar('username');
            $psw = $this->request->getVar('password');
            $chek = $this->db->query("CALL User_Auth('".$unm."','".$psw."')")->getRow();
            if ($chek->res == 0 ) {
                $data = array(
                        'token'     =>  '',
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  0,
                        'msg'       =>  $chek->msg
                    );

                return $this->response->setJSON($data); 
            }
            if ($chek->res == 1 ) 
            {
                if ($chek->actv == "TRUE") {
                    $key = getenv('TOKEN_SECRET');
                    $iat = time(); 
                    $exp = $iat + 60 * 60 * 60;

                    $payload = array(
                        "iss" => $chek->FullName,
                        "aud" => $chek->UserName,
                        "sub" => "Login LKE APP",
                        "iat" => $iat, 
                        "exp" => $exp, 
                        "ids" => $chek->uid,
                        "rln" => $chek->RoleName,
                    );

                    $token = JWT::encode($payload, $key, 'HS256');

                    $data = array(
                        'token'     =>  $token,
                        'direct'    =>  'dashboard',
                        'exp'       =>  $exp,
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  1,
                        'msg'       =>  'succes'
                    );

                    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {   //check ip from share internet
                        $ip = $_SERVER['HTTP_CLIENT_IP'];
                    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {   //to check ip is pass from proxy
                        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
                    } else {
                        $ip = $_SERVER['REMOTE_ADDR'];
                    } 

                    $logs = $this->db->query("CALL log_user('".$chek->uid."','".$ip."', 'LOGIN')");

                    setcookie(
                    // '__Secure-Authorization',
                        '__LKE-Authorization',
                        $token,[
                            'expires'=>time() +3600,
                            //'prefix' => '__Secure-',
                            // 'prefix' => '__LKE-',
                            'path'=>'/',
                            'domain'=> '',
                            'secure'=>true,
                            'httponly'=>true,
                            'samesite'=>Cookie::SAMESITE_LAX,
                        ]
                    );
                    return $this->response->setJSON($data);

                }else{
                    $data = array(
                        'token'     =>  '',
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $chek->res,
                        'msg'       =>  $chek->msg,
                    );
                    return $this->response->setJSON($data);
                }
            }else{
                $data = array(
                        'token'     =>  '',
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  $chek->res,
                        'msg'       =>  $chek->msg,
                    );
                return $this->response->setJSON($data);
            }
        }else{
            $data = array(
                        'token'     =>  '',
                        'token_crs' =>  csrf_hash(),
                        'success'   =>  0,
                        'msg'       =>  'Validasi Input Gagal.  ',
                    );
                return $this->response->setJSON($data);
        }
    }

    public function Logout()
    {
        $request = request();
        $token = null;
        $header = $request->getHeader("Authorization");
        $key = getenv('TOKEN_SECRET');
         if(!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                $token = $matches[1];
            }
        }

        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));

        $id = $this->decoded->ids;
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {   //check ip from share internet
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {   //to check ip is pass from proxy
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        } 
        $logs = $this->db->query("CALL log_user('".$id."','".$ip."', 'LOGOUT')");

        setcookie(
            // '__Secure-Authorization',
            '__LKE-Authorization',
            '',[
                'expires'=>'',
                //'prefix' => '__Secure-',
                // 'prefix' => '__LKE-',
                'path'=>'/',
                'domain'=> '',
                'secure'=>true,
                'httponly'=>true,
                'samesite'=>Cookie::SAMESITE_LAX,
            ]
        );
        // delete_cookie('__Secure-Authorization');
        delete_cookie('__LKE-Authorization');
        
        $data = array(
                'token_crs' =>  csrf_hash(),
                'success'   =>  1,
                'msg'       =>  'success',
                'redirec'   => base_url().'',
                );
        return $this->response->setJSON($data);
        
        // return redirect()->to(base_url().'login');
    }
}
