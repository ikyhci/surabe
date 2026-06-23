<?php

namespace App\Controllers;

use App\Controllers\BaseController;

class PublicPages extends BaseController
{

    public function login()
    {
        $captchaImage = generateCaptcha();
        return view(
            'login',
            ['captchaImage' => $captchaImage]
        );
    }

    public function Unauthorized()
    {
        return view('Pages/unauthorized');
    }

    public function apis()
    {
        $data = array(
            'token_crs' =>  csrf_hash(),
            'success'   =>  1,
            'msg'       =>  'Api v1.0'
        );
        return $this->response->setJSON($data);
    }

    public function getCapaian()
    {

        // $LkeForm = new \App\Models\LkeForm();
        $model = new \App\Models\LkeModel();

        $thx = $this->request->getVar('t');
        $token = $this->request->getVar('token');
        if (!$token || $token != 'abcdefg') {
            $data = array(
                'success'   =>  1,
                'msg'       => 'success',
                // 'token_crs' => csrf_hash(),
                'data'        => [
                    'return' => 'result'
                ],
            );
            return $this->response->setJSON($data);
        } else {
            // $tahun = $LkeForm->select('tahun')->orderBy('tahun', 'DESC')->first();
            $list = $model->getRekapSemuaOpdPublic($thx);

            $data = array(
                'success'   =>  1,
                'msg'       => 'success',
                // 'token_crs' => csrf_hash(),
                'data'        => $list,
            );
            return $this->response->setJSON($data);
        }

        // $data = array(
        //         'token_crs' =>  csrf_hash(),
        //         'success'   =>  0,
        //         'msg'       =>  'error invalid token.'
        //     );
        // return $this->response->setJSON($data);
    }
}
