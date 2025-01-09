<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class InitDb extends Migration
{
    public function up()
    {
        // Table: lke_aspek
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'nama_aspek' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'create_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'update_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'bobot' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_aspek');

        // Table: lke_bukti_dukung
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'id_parameter' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'bukti_dukung' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'create_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'update_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_bukti_dukung');

        // Table: lke_detail_opd
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'userid' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'opdid' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'create_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'update_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_detail_opd');

        // Table: lke_indikator
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'id_sub_sub_aspek' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'indikator' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'create_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'update_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'jenis_jawaban' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_indikator');

        // Tambahkan migrasi tabel lainnya di sini...

        // Contoh: Tabel lke_jawaban
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'id_indikator' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'jawaban' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'create_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'update_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_jawaban');
    }

    public function down()
    {
        $this->forge->dropTable('lke_aspek');
        $this->forge->dropTable('lke_bukti_dukung');
        $this->forge->dropTable('lke_detail_opd');
        $this->forge->dropTable('lke_indikator');
        $this->forge->dropTable('lke_jawaban');
        // Tambahkan dropTable() untuk tabel lainnya di sini...
    }
}
