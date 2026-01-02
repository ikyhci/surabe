<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class ClearSession implements FilterInterface
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
     * @return mixed
     */
    public function before(RequestInterface $request, $arguments = null)
    {
        //
        $path = WRITEPATH . 'session/';
        $files = glob($path . 'ci_session*');
        $now = time();
        foreach ($files as $file) {
            if (is_file($file)) {
                $lastModified = filemtime($file);
                $maxLifetime = config('App')->sessionExpiration;
                if ($now - $lastModified > $maxLifetime) {
                    unlink($file);
                }
            }
        }
            
        $session = session();
        // Contoh: hapus session jika sudah lewat 10 menit dari 'last_activity'
        $last = $session->get('last_activity');
        if ($last && time() - $last > 300) {
            $session->remove('last_activity');
            $session->remove('captcha_code');
            // Tambahkan session lain yang ingin dihapus
        }

        // Update aktivitas
        $session->set('last_activity', time());
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
     * @return mixed
     */
    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        //
    }
}