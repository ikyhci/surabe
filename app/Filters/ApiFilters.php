<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Config\Services;
use CodeIgniter\HTTP\Response;
use CodeIgniter\HTTP\Header;
use Exception;

class ApiFilters implements FilterInterface
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


    protected $response;
    protected $request;
    protected $key;
    protected $decoded;
    protected $header;
    protected $token;
    public function before(RequestInterface $request, $arguments = null)
    {
        //
        $response = service('response');
        $request = request();
        $key = getenv('TOKEN_SECRET');
        $token = null;
        $header = $request->getHeader("Authorization");
         if(!empty($header)) {
            if (preg_match('/Bearer\s(\S+)/', $header, $matches)) {
                $token = $matches[1];
            }
        }
  
        // check if token is null or empty
        if(is_null($token) || empty($token)) {
           
            $data = array(
                    'token_crs'     =>  csrf_hash(),
                    'success'       =>  0,
                    'msg'           =>  'Access denied.',
                    'StatusCode'    =>  '401',
                    );
            return $response->setJSON($data);
        }
  
        try {
            $decoded = JWT::decode($token, new Key($key, 'HS256'));
        } catch (Exception $ex) {
           
            $data = array(
                    'token_crs'     =>  csrf_hash(),
                    'success'       =>  0,
                    'msg'           =>  'Access denied.',
                    'StatusCode'    =>  '401',
                    );
            return $response->setJSON($data);
        }

        //check role with argument
        if (!in_array($decoded->rln , $arguments, true)) {

            $data = array(
                    'token_crs'     =>  csrf_hash(),
                    'success'       =>  0,
                    'msg'           =>  'Access denied.',
                    'StatusCode'    =>  '401',
                    );
            return $response->setJSON($data);
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
