<?php

namespace App\Controllers;

class Dashboard extends BaseController
{
    public function index(): string
    {
        return view('Pages/dashboard');
    }

    public function blankPage(): string
    {
        return view('Pages/example');
    }
}
