<?php

namespace App\Controllers\Pages;

use App\Controllers\BaseController;
// use CodeIgniter\HTTP\ResponseInterface;
// use CodeIgniter\Database\Database;
use App\Models\SuperAdminModel;

use CodeIgniter\Cookie\Cookie;
use CodeIgniter\Cookie\CookieStore;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;

class PagesSuperAdminControllers extends BaseController
{
    protected $db;
    protected $superAdminModel;
    public $data;
    protected $decoded;
    
    public function __construct(){
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        if(!isset($_COOKIE['__LKE-Authorization'])) {
            $response = service('response');
            $response->setStatusCode(302);
            $response->setHeader('Location', base_url('unauthorized'));
            $response->send();
            exit;
        }
        $token = $_COOKIE['__LKE-Authorization']; // get_cookie('__LKE-Authorization');
        
        if(is_null($token) || empty($token)) {
            $response = service('response');
            $response->setStatusCode(302);
            $response->setHeader('Location', base_url('unauthorized'));
            $response->send();
            exit;
        }
        $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        
        $this->db = db_connect();
        $this->data = [
            // 'title' => 'Super Admin',
            'usr' => $this->decoded->rln,
            'ids' => $this->decoded->ids,
            'token' => $token
        ];
    }
    
    public function index()
    {
        redirect()->to('/');
    }

    public function manageUsers()
    {
        $this->data['title'] = 'User Management';
        $this->data['sub_title'] = 'Manage Users';
        $this->data['first_part'] = 'user-management';
        return view('Pages/superadmin/manage-users', $this->data);
    }

    public function manageUsersDetail($uid) 
    {
        $this->data['first_part'] = 'user-management';
        $this->data['title'] = 'User Management';
        $this->data['sub_title'] = 'Users Detail';
        $this->data['uid'] = $uid;
        $this->data['user'] = $this->superAdminModel->getUser($uid);
        $this->data['readOnly'] = false;

        return view('Pages/superadmin/manage-users-detail', $this->data);
    }

    public function manageOpd()
    {
        $this->data['first_part'] = 'opd-management';
        $this->data['title'] = 'OPD';
        $this->data['sub_title'] = 'Master Data OPD';
        return view('Pages/superadmin/manage-opd', $this->data);
    }
}
