<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class InitProcedures extends Migration
{
    public function up()
    {
        // Prosedur Aspek_add_edit
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Aspek_add_edit`(
            uidx VARCHAR(255),
            idx VARCHAR(255),
            nmas VARCHAR(255),
            bbt VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Aspek :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT id FROM lke_aspek WHERE id = idx LIMIT 1);

            IF (ada IS NULL) THEN
                INSERT INTO lke_aspek VALUES(SHA(NOW()), nmas, NOW(), null, bbt);
                SET res = 1;
                SET msg = 'Tambah Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                CONCAT('Tambah Data Aspek : ',nmas,' Bobot : ',bbt), NOW());
            ELSE
                UPDATE lke_aspek SET nama_aspek = nmas, bobot = bbt, update_at = NOW() WHERE id = idx;
                SET res = 1;
                SET msg = 'Update Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
                CONCAT('Update Data Aspek : ',nmas,' Bobot : ',bbt), NOW());
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");

        // Prosedur Aspek_delete
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Aspek_delete`(
            uidx VARCHAR(255),
            idx VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Aspek :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id = idx LIMIT 1);
            IF (ada IS NOT NULL) THEN    
                SET ada = (SELECT id_aspek FROM lke_sub_aspek WHERE id_aspek = idx);
                IF (ada IS NULL) THEN
                    INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
                    (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                    CONCAT('Hapus Data Aspek  : ',(SELECT nama_aspek FROM lke_aspek WHERE id=idx LIMIT 1)), NOW());
                    DELETE FROM lke_aspek WHERE id = idx;
                    SET res = 1;
                    SET msg ='success';
                ELSE
                    SET res = 0;
                    SET msg ='Data Aspek Masih Digunakan.';
                END IF;

            ELSE
                SET res = 0;
                SET msg ='Data Aspek Tidak Di Temukan.';
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");

        // Prosedur Indikator_add_edit
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Indikator_add_edit`(
            uidx VARCHAR(255),
            idx VARCHAR(255),
            nmas VARCHAR(255),
            bbt VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Indikator :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT id FROM lke_indikator WHERE id = idx LIMIT 1);

            IF (ada IS NULL) THEN
                INSERT INTO lke_indikator VALUES(SHA(NOW()), nmas, NOW(), null, bbt);
                SET res = 1;
                SET msg = 'Tambah Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                CONCAT('Tambah Data Indikator : ',nmas,' Bobot : ',bbt), NOW());
            ELSE
                UPDATE lke_indikator SET nama_indikator = nmas, bobot = bbt, update_at = NOW() WHERE id = idx;
                SET res = 1;
                SET msg = 'Update Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
                CONCAT('Update Data Indikator : ',nmas,' Bobot : ',bbt), NOW());
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");

        // Prosedur Indikator_delete
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Indikator_delete`(
            uidx VARCHAR(255),
            idx VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Indikator :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT nama_indikator FROM lke_indikator WHERE id = idx LIMIT 1);
            IF (ada IS NOT NULL) THEN    
                SET ada = (SELECT id_indikator FROM lke_sub_indikator WHERE id_indikator = idx);
                IF (ada IS NULL) THEN
                    INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
                    (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                    CONCAT('Hapus Data Indikator : ',(SELECT nama_indikator FROM lke_indikator WHERE id=idx LIMIT 1)), NOW());
                    DELETE FROM lke_indikator WHERE id = idx;
                    SET res = 1;
                    SET msg ='success';
                ELSE
                    SET res = 0;
                    SET msg ='Data Indikator Masih Digunakan.';
                END IF;

            ELSE
                SET res = 0;
                SET msg ='Data Indikator Tidak Di Temukan.';
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");

        // Prosedur Kriteria_add_edit
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Kriteria_add_edit`(
            uidx VARCHAR(255),
            idx VARCHAR(255),
            nmas VARCHAR(255),
            bbt VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Kriteria :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT id FROM lke_kriteria WHERE id = idx LIMIT 1);

            IF (ada IS NULL) THEN
                INSERT INTO lke_kriteria VALUES(SHA(NOW()), nmas, NOW(), null, bbt);
                SET res = 1;
                SET msg = 'Tambah Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                CONCAT('Tambah Data Kriteria : ',nmas,' Bobot : ',bbt), NOW());
            ELSE
                UPDATE lke_kriteria SET nama_kriteria = nmas, bobot = bbt, update_at = NOW() WHERE id = idx;
                SET res = 1;
                SET msg = 'Update Data Berhasil';
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
                (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
                CONCAT('Update Data Kriteria : ',nmas,' Bobot : ',bbt), NOW());
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");

        // Prosedur Kriteria_delete
        $this->db->query("
        CREATE DEFINER=`root`@`localhost` PROCEDURE `Kriteria_delete`(
            uidx VARCHAR(255),
            idx VARCHAR(255)
        )
        BEGIN
            DECLARE ada VARCHAR(255);
            DECLARE res VARCHAR(255);
            DECLARE msg VARCHAR(255);

            DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                GET DIAGNOSTICS CONDITION 1
                @p2 = MESSAGE_TEXT;
                INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Kriteria :',(SELECT @p2)), NOW());
                SET res = 0;
                SET msg = (SELECT @p2);
                SELECT res, msg; 
            END;

            START TRANSACTION;
            SET ada = (SELECT nama_kriteria FROM lke_kriteria WHERE id = idx LIMIT 1);
            IF (ada IS NOT NULL) THEN    
                SET ada = (SELECT id_kriteria FROM lke_sub_kriteria WHERE id_kriteria = idx);
                IF (ada IS NULL) THEN
                    INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
                    (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
                    CONCAT('Hapus Data Kriteria : ',(SELECT nama_kriteria FROM lke_kriteria WHERE id=idx LIMIT 1)), NOW());
                    DELETE FROM lke_kriteria WHERE id = idx;
                    SET res = 1;
                    SET msg ='success';
                ELSE
                    SET res = 0;
                    SET msg ='Data Kriteria Masih Digunakan.';
                END IF;

            ELSE
                SET res = 0;
                SET msg ='Data Kriteria Tidak Di Temukan.';
            END IF;

            COMMIT;
            SELECT res, msg;
        END
        ");
    }

    public function down()
    {
        $this->db->query("DROP PROCEDURE IF EXISTS `Aspek_add_edit`");

        $this->db->query("DROP PROCEDURE IF EXISTS `Aspek_delete`");

        $this->db->query("DROP PROCEDURE IF EXISTS `Indikator_add_edit`");

        $this->db->query("DROP PROCEDURE IF EXISTS `Indikator_delete`");

        $this->db->query("DROP PROCEDURE IF EXISTS `Kriteria_add_edit`");

        $this->db->query("DROP PROCEDURE IF EXISTS `Kriteria_delete`");
    }
}
