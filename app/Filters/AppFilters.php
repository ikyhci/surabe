<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Throwable; 

class AppFilters implements FilterInterface
{
    /**
     * Do whatever processing this filter needs to do.
     * By default it should not return anything during
     * normal execution. However, when an abnormal state
     * is found, it should return an instance of
     * CodeIgniter\HTTP\Response. If it does, script
     * execution will end and that Response will be
     * sent back to the client, allowing for error pages,
     * redirects, etc.
     *
     * @param RequestInterface $request
     * @param array|null       $arguments
     *
     * @return RequestInterface|ResponseInterface|string|void
     */
    
    protected $key;
    protected $decoded;
    protected $token;
    public function before(RequestInterface $request, $arguments = null)
    {
        //
        helper('cookie');
        $key = getenv('TOKEN_SECRET');
        // $token = get_cookie('Authorization', true,'__Secure-') ? get_cookie('Authorization', true,'__Secure-') : null;
        $token = get_cookie('LKE_Authorization', true,'__Secure-') ? get_cookie('LKE_Authorization', true,'__Secure-') : null;

  
        // check if token is null or empty
        if(is_null($token) || empty($token)) {

            return redirect()->to(base_url().'unauthorized');
        }

  
        try {

            $decoded = JWT::decode($token, new Key($key, 'HS256'));  

        } catch (\Throwable $ex) {

            return redirect()->to(base_url().'unauthorized');
        }

    }

    /**
     * Allows After filters to inspect and modify the response
     * object as needed. This method does not allow any way
     * to stop execution of other after filters, short of
     * throwing an Exception or Error.
     *
     * @param RequestInterface  $request
     * @param ResponseInterface $response
     * @param array|null        $arguments
     *
     * @return ResponseInterface|void
     */
    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        //
    }
}
