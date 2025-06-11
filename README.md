# CodeIgniter 4 Framework
# -CodeIgniter v4.5.7-

## PENGUKURAN REFORMASI BIROKRASI ELEKTRONIK BERINTEGRITAS DAN MANDIRI (SURABE BERANI)
 Aplikasi Pengukuran Reformasi Birokrasi Elektronik Berintegrasi dan Mandiri 
 Pemerintah Provinsi Sulawesi Tengah

 versi aplikasi 1.0.2(062025)

## Server Requirements

PHP version 8.1 or higher is required, with the following extensions installed:

- [intl](http://php.net/manual/en/intl.requirements.php)
- [mbstring](http://php.net/manual/en/mbstring.installation.php)
- [mysqli](https://www.php.net/manual/en/mysqli.installation.php)

> [!WARNING]

 - The end of life date for PHP 7.4 was November 28, 2022.
 - The end of life date for PHP 8.0 was November 26, 2023.
 - If you are still using PHP 7.4 or 8.0, you should upgrade immediately.
 - The end of life date for PHP 8.1 will be December 31, 2025.
 

Additionally, make sure that the following extensions are enabled in your PHP:

- json (enabled by default - don't turn it off)
- [mysqlnd](http://php.net/manual/en/mysqlnd.install.php) if you plan to use MySQL
- [libcurl](http://php.net/manual/en/curl.requirements.php) if you plan to use the HTTP\CURLRequest library


## Last Update
 > [10-06-2025]

 - Fix Penomoran (Soal, User)
 - Fix Edit data Soal(Soal)
 - Remove colom active di parameter
 - Tambahan tombol Enable/Disable Di Tabel Form
 - Fix bug Upload File Jawaban Yes No Dan Linear


 > [10-06-2025]

 - Perubahan nomor Urut RowGroup (Soal)
 - Fix Bug save Sub Sub Aspek

 > [09-06-2025]
 
 - Tambahan Nomor Urut Dari Rb Sanpai Parameter [Khusus Pilihan Ganda] (Soal)
 - Tambahan Batas Waktu Sub Aspek (Soal, User)
 - Perbaikan View Urutan Berdasarkan Nomor Urut (Soal, User)
 - Perbaikan Backdrop Modal di View Data Upload Bukti Dukung (Soal)
 - Tambahan Filter Data Per Tahun (Soal)
 - Tambahan Filter File Upload ['jpg', 'jpeg', 'png','pdf','docx','doc','xls','xlsx'] (User)
 - Tambahan Stop Upload Bila Batas Waktu Sudah Lewat (User) 
 - Perbaikan View Data Pertahun [Hanya Yang ada Data Yang Tampil] (User)
 - Login Page Responsive
 - CI/CD menggunakan Pipelines Bitbucket
 - menggunakan base url dari file .env (BASE_URL)
 - perbaikan CorsFilters.php


## What is CodeIgniter?

CodeIgniter is a PHP full-stack web framework that is light, fast, flexible and secure.
More information can be found at the [official site](https://codeigniter.com).

This repository holds the distributable version of the framework.
It has been built from the
[development repository](https://github.com/codeigniter4/CodeIgniter4).

More information about the plans for version 4 can be found in [CodeIgniter 4](https://forum.codeigniter.com/forumdisplay.php?fid=28) on the forums.

You can read the [user guide](https://codeigniter.com/user_guide/)
corresponding to the latest version of the framework.

## Important Change with index.php

`index.php` is no longer in the root of the project! It has been moved inside the *public* folder,
for better security and separation of components.

This means that you should configure your web server to "point" to your project's *public* folder, and
not to the project root. A better practice would be to configure a virtual host to point there. A poor practice would be to point your web server to the project root and expect to enter *public/...*, as the rest of your logic and the
framework are exposed.

**Please** read the user guide for a better explanation of how CI4 works!

## Repository Management

We use GitHub issues, in our main repository, to track **BUGS** and to track approved **DEVELOPMENT** work packages.
We use our [forum](http://forum.codeigniter.com) to provide SUPPORT and to discuss
FEATURE REQUESTS.

This repository is a "distribution" one, built by our release preparation script.
Problems with it can be raised on our forum, or as issues in the main repository.

## Contributing

We welcome contributions from the community.

Please read the [*Contributing to CodeIgniter*](https://github.com/codeigniter4/CodeIgniter4/blob/develop/CONTRIBUTING.md) section in the development repository.


