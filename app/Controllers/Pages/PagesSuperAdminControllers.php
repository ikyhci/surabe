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

    public function __construct(){
        $this->data = [
            'title' => 'Manage Users',
            'usr' => 'Super Admin',
        ];
    //     helper('cookie');
    //     $key = getenv('TOKEN_SECRET');
    //     $token = get_cookie('Authorization', true,'');
    //     $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
        // $this->db = db_connect();
        $this->superAdminModel = new SuperAdminModel();
    }
    
    public function index()
    {
        redirect()->to('/');
    }

    public function manageUsers()
    {
        $this->data['first_part'] = 'user-management';
        return view('Pages/superadmin/manage-users', $this->data);
    }

    public function manageUsersDetail($uid) 
    {
        $this->data['first_part'] = 'user-management';
        $this->data['sub_title'] = 'Users Detail';
        $this->data['uid'] = $uid;
        $this->data['user'] = $this->superAdminModel->getUser($uid);
        $this->data['readOnly'] = false;

        return view('Pages/superadmin/manage-users-detail', $this->data);
    }

}
