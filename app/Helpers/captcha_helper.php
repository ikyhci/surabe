<?php

use CodeIgniter\Files\File;

function generateCaptcha()
{
    $code = substr(str_shuffle('ABCDEFGHJKLMNPQRSTUVWXYZ23456789'), 0, 6);
    session()->set('captcha_code', $code);

    $width = 150;
    $height = 50;
    $image = imagecreatetruecolor($width, $height);

    $bgColor = imagecolorallocate($image, 255, 255, 255);
    $textColor = imagecolorallocate($image, 0, 0, 0);
    $lineColor = imagecolorallocate($image, 200, 200, 200);

    imagefill($image, 0, 0, $bgColor);

    for ($i = 0; $i < 5; $i++) {
        imageline($image, rand(0, $width), rand(0, $height),
        rand(0, $width), rand(0, $height), $lineColor);
    }

    // $fontPath = WRITEPATH . 'font/COMIC.TTF';
    $fontPath = FCPATH . 'font/COMIC.TTF';
    if (!is_file($fontPath)) {
        // Ganti dengan path ke font TTF yang kamu miliki
        throw new \Exception('Font tidak ditemukan: ' . $fontPath);
    }

    imagettftext($image, 20, rand(-10, 10), 15, 30, $textColor, $fontPath, $code);

    ob_start();
    imagepng($image);
    $imageData = ob_get_clean();
    imagedestroy($image);

    return 'data:image/png;base64,' . base64_encode($imageData);
}