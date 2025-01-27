<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class UpdateTables001 extends Migration
{
    public function up()
    {
        // Update table: lke_aspek
        $this->forge->modifyColumn('lke_aspek', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_bukti_dukung
        $this->forge->modifyColumn('lke_bukti_dukung', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_detail_opd
        $this->forge->modifyColumn('lke_detail_opd', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_indikator
        $this->forge->modifyColumn('lke_indikator', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_jawaban
        $this->forge->modifyColumn('lke_jawaban', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_logs
        $this->forge->modifyColumn('lke_logs', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_opd
        $this->forge->modifyColumn('lke_opd', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_role
        $this->forge->modifyColumn('lke_role', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_sub_aspek
        $this->forge->modifyColumn('lke_sub_aspek', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_sub_sub_aspek
        $this->forge->modifyColumn('lke_sub_sub_aspek', [
            'id' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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

        // Update table: lke_user
        $this->forge->modifyColumn('lke_user', [
            'uid' => [
                'type'       => 'VARCHAR',
                'constraint' => '255',
                'null'       => false,
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
    }

    public function down()
    {
        // Revert changes for table: lke_aspek
        $this->forge->modifyColumn('lke_aspek', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'nama_aspek' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'bobot' => [
            'type'       => 'FLOAT',
            'null'       => false,
            ],
            'tahun' => [
            'type'       => 'YEAR',
            'null'       => false,
            ],
        ]);

        // Revert changes for table: lke_bukti_dukung
        $this->forge->modifyColumn('lke_bukti_dukung', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'id_jawaban' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'bukti_dukung' => [
            'type'       => 'TEXT',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_detail_opd
        $this->forge->modifyColumn('lke_detail_opd', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'userid' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'opdid' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_indikator
        $this->forge->modifyColumn('lke_indikator', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'id_sub_sub_aspek' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'indikator' => [
            'type'       => 'TEXT',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_jawaban
        $this->forge->modifyColumn('lke_jawaban', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'id_indikator' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'jawaban' => [
            'type'       => 'TEXT',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_logs
        $this->forge->modifyColumn('lke_logs', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'timestamp' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'level' => [
            'type'       => 'VARCHAR',
            'constraint' => '50',
            'null'       => false,
            ],
            'source' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'message' => [
            'type'       => 'TEXT',
            'null'       => false,
            ],
            'created_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_opd
        $this->forge->modifyColumn('lke_opd', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'nama_opd' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_role
        $this->forge->modifyColumn('lke_role', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'role_name' => [
            'type'       => 'VARCHAR',
            'constraint' => '50',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);

        // Revert changes for table: lke_sub_aspek
        $this->forge->modifyColumn('lke_sub_aspek', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'nama_sub_aspek' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'id_aspek' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'bobot' => [
            'type'       => 'FLOAT',
            'null'       => false,
            ],
        ]);

        // Revert changes for table: lke_sub_sub_aspek
        $this->forge->modifyColumn('lke_sub_sub_aspek', [
            'id' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'nama_sub_sub_aspek' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'id_sub_aspek' => [
            'type'       => 'INT',
            'constraint' => 11,
            'null'       => false,
            ],
            'bobot' => [
            'type'       => 'FLOAT',
            'null'       => false,
            ],
        ]);

        // Revert changes for table: lke_user
        $this->forge->modifyColumn('lke_user', [
            'uid' => [
            'type'       => 'INT',
            'constraint' => 11,
            'unsigned'   => true,
            'auto_increment' => true,
            'null'       => false,
            ],
            'username' => [
            'type'       => 'VARCHAR',
            'constraint' => '50',
            'null'       => false,
            ],
            'fullname' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'phone' => [
            'type'       => 'VARCHAR',
            'constraint' => '15',
            'null'       => false,
            ],
            'email' => [
            'type'       => 'VARCHAR',
            'constraint' => '100',
            'null'       => false,
            ],
            'create_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
            'update_at' => [
            'type' => 'TIMESTAMP',
            'null' => false,
            ],
        ]);
    }
}
