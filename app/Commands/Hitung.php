<?php

namespace App\Commands;

use CodeIgniter\CLI\BaseCommand;
use CodeIgniter\CLI\CLI;
use App\Models\LkeModel;
use App\Models\LkeOpdModel;

class Hitung extends BaseCommand
{
    protected $group       = 'Custom';
    protected $name        = 'hitung';
    protected $description = 'Menghitung laporan OPD berdasarkan tahun & opsional ID OPD';

    public function run(array $params)
    {
        // ----------- PARAMETER -------------
        $tahun  = $params[0] ?? null;
        $opdId  = $params[1] ?? null;

        if (!$tahun) {
            CLI::error("Tahun wajib diisi.\nContoh: php spark hitung 2025");
            return;
        }

        $lkeModel = new LkeModel();
        $opdModel = new LkeOpdModel();

        // ----------- TANPA OPD ID -------------
        if (!$opdId) {
            CLI::write("Menghitung seluruh OPD untuk tahun $tahun ...");

            $opds = $opdModel->findAll();

            foreach ($opds as $opd) {
                CLI::write("- Menghitung OPD {$opd['nama_opd']} ({$opd['id']}) ...");
                $lkeModel->getLaporanOpdJson($tahun, $opd['id'], true);
            }

            CLI::write("Selesai menghitung seluruh OPD.");
            return;
        }

        // ----------- DENGAN OPD ID -------------
        CLI::write("Menghitung OPD $opdId untuk tahun $tahun ...");

        $lkeModel->getLaporanOpdJson($tahun, $opdId, true);

        CLI::write("Selesai.");
    }
}