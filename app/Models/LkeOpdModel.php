<?php

namespace App\Models;

use CodeIgniter\Model;

class LkeOpdModel extends Model
{
    protected $table = 'lke_opd';
    protected $primaryKey = 'id';
    protected $allowedFields = ['id', 'nama_opd'];
}