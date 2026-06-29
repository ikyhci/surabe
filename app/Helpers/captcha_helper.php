<?php

function generateCaptcha()
{
    $code = substr(str_shuffle('ABCDEFGHJKLMNPQRSTUVWXYZ23456789'), 0, 6);

    $ip = service('request')->getIPAddress();
    $safeIp = preg_replace('/[^A-Za-z0-9_\-]/', '_', $ip);
    $key = 'captcha_' . $safeIp;

    cache()->save($key, $code, 300);

    $width = 150;
    $height = 50;
    $image = imagecreatetruecolor($width, $height);

    $bgColor   = imagecolorallocate($image, 255, 255, 255);
    $textColor = imagecolorallocate($image, 0, 0, 0);
    $lineColor = imagecolorallocate($image, 200, 200, 200);

    imagefill($image, 0, 0, $bgColor);

    for ($i = 0; $i < 5; $i++) {
        imageline(
            $image,
            rand(0, $width),
            rand(0, $height),
            rand(0, $width),
            rand(0, $height),
            $lineColor
        );
    }

    $fontPath = FCPATH . 'font/COMIC.TTF';
    if (!is_file($fontPath)) {
        throw new \Exception('Font tidak ditemukan: ' . $fontPath);
    }

    imagettftext($image, 20, rand(-10, 10), 15, 30, $textColor, $fontPath, $code);

    ob_start();
    imagepng($image);
    $imageData = ob_get_clean();
    imagedestroy($image);

    return 'data:image/png;base64,' . base64_encode($imageData);
}
