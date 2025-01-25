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
            'tahun' => [
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
            'id_jawaban' => [
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
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_indikator');

        // Table: lke_jawaban
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

        // Table: lke_logs
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'timestamp' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
            'level' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'source' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'message' => [
                'type'       => 'TEXT',
                'null'       => true,
            ],
            'created_at' => [
                'type' => 'DATETIME',
                'null' => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_logs');

        // Table: lke_opd
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'nama_opd' => [
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
        $this->forge->createTable('lke_opd');

        // Table: lke_role
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'role_name' => [
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
        $this->forge->createTable('lke_role');

        // Table: lke_sub_aspek
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'nama_sub_aspek' => [
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
            'id_aspek' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'bobot' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_sub_aspek');

        // Table: lke_sub_sub_aspek
        $this->forge->addField([
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'nama_sub_sub_aspek' => [
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
            'id_sub_aspek' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'bobot' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
        ]);
        $this->forge->addKey('id', true);
        $this->forge->createTable('lke_sub_sub_aspek');

        // Table: lke_user
        $this->forge->addField([
            'uid' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
            ],
            'username' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'fullname' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'phone' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => true,
            ],
            'email' => [
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
        $this->forge->addKey('uid', true);
        $this->forge->createTable('lke_user');
    }

    public function down()
    {
        $this->forge->dropTable('lke_aspek');
        $this->forge->dropTable('lke_bukti_dukung');
        $this->forge->dropTable('lke_detail_opd');
        $this->forge->dropTable('lke_indikator');
        $this->forge->dropTable('lke_jawaban');
        $this->forge->dropTable('lke_logs');
        $this->forge->dropTable('lke_opd');
        $this->forge->dropTable('lke_role');
        $this->forge->dropTable('lke_sub_aspek');
        $this->forge->dropTable('lke_sub_sub_aspek');
        $this->forge->dropTable('lke_user');
    }
}