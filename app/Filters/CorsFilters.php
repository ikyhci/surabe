<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class CorsFilters implements FilterInterface
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
    public function before(RequestInterface $request, $arguments = null)
    {
        //
        header('Access-Control-Allow-Origin: https://csirt.sultengprov.go.id/');
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Max-Age: 86400");
        header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");
        
        header('Strict-Transport-Security "max-age=10886400; includeSubDomains; preload"');
        header('Content-Security-Policy "upgrade-insecure-requests"');
        header('X-XSS-Protection "1; mode=block"');
        header('X-Frame-Options "SAMEORIGIN"');
        header('X-Content-Type-Options "nosniff"');
        header('Referrer-Policy "strict-origin-when-cross-origin"');
        header('Permissions-Policy "geolocation=self"');
        
        if ( $request->getMethod() == 'options')
        {
            $response = service('response');
            $response->setJSON(['method' => 'OPTIONS']);
            return $response;
            die();
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
