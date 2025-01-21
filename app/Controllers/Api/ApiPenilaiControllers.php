<?php

namespace App\Controllers\Api;

use App\Controllers\BaseController;
use CodeIgniter\HTTP\ResponseInterface;

class ApiPenilaiControllers extends BaseController
{
    // public function __construct(){
    //     $request = request();
    //     $key = getenv('TOKEN_SECRET');
    //     $token = null;
    //     $header = $request->getHeader("Authorization");
    //      if(!empty($header)) {
    //         if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
    //             $token = $matches[1];
    //         }
    //     }
    //     if(is_null($token) || empty($token)) {
    //         $response = service('response');
    //         $response->setBody('Access denied');
    //         $response->setStatusCode(401);
    //         return $response;
    //     }else{
    //         $this->decoded = JWT::decode($token, new Key($key, 'HS256'));
    //     }
    //     $this->db = db_connect();
    // }
    
    public function index()
    {
        //
    }
}
