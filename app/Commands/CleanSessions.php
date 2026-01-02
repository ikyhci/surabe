<?php

namespace App\Commands;

use CodeIgniter\CLI\BaseCommand;
use CodeIgniter\CLI\CLI;

class CleanSessions extends BaseCommand
{
    protected $group       = 'custom';
    protected $name        = 'sessions:clean';
    protected $description = 'Hapus file session yang sudah expired';

    public function run(array $params)
    {
        $path = WRITEPATH . 'session/';
        $files = glob($path . 'ci_session*');
        $now = time();

        foreach ($files as $file) {
            if (is_file($file)) {
                $lastModified = filemtime($file);
                $maxLifetime = config('App')->sessionExpiration;
                if ($now - $lastModified > $maxLifetime) {
                    unlink($file);
                    CLI::write("Dihapus: " . basename($file), 'green');
                }
            }
        }
    }
}