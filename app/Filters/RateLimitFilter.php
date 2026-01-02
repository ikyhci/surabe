<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class RateLimitFilter implements FilterInterface
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
            $ip     = $request->getIPAddress();
            $method = strtolower($request->getMethod());

            // hanya cek GET, POST, PUT
            if (! in_array($method, ['get', 'post', 'put'])) {
                return;
            }

            $cache = cache();
            $key   = "rate_limit_{$ip}_{$method}";

            // ambil counter, default 0
            $count = $cache->get($key) ?? 0;

            $count++;

            // simpan dengan TTL 10 detik 
            $cache->save($key, $count, 10);

            if ($count > 10) {
                return service('response')
                    ->setStatusCode(429) // Too Many Requests
                    ->setBody("Too many {$method} requests from your IP. Please wait a minute.");
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
