-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3309
-- Generation Time: Jun 25, 2025 at 12:00 PM
-- Server version: 8.0.42-0ubuntu0.22.04.1
-- PHP Version: 8.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `surabe`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`surabe2`@`%` PROCEDURE `Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmas` VARCHAR(255), `bbt` VARCHAR(255), `rbx` VARCHAR(255), `numsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_aspek WHERE id = idx LIMIT 1);
	
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE nama_aspek = nmas AND bobot = bbt LIMIT 1);
		IF (ada IS NULL) THEN
			INSERT INTO lke_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmas, NOW(), null, bbt, NULL, rbx, numsx);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Aspek : ',nmas,' Bobot : ',bbt), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama Aspek Sudah Ada.';
		END IF;
	ELSE
		UPDATE lke_aspek SET nama_aspek = nmas, bobot = bbt, nums = numsx, update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data Aspek : ',nmas,' Bobot : ',bbt), NOW());
	END IF;
	
	COMMIT;
	SELECT res, msg;

END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NOT NULL) THEN	
		SET ada = (SELECT id_aspek FROM lke_sub_aspek WHERE id_aspek = idx LIMIT 1);
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
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Bukti_dukung_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idindk` VARCHAR(255), `bkdk` VARCHAR(255), `nox` VARCHAR(255))   BEGIN
  #Routine body goes here...
	
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Jawaban :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_bukti_dukung WHERE id = idx LIMIT 1);
	IF (ada IS NULL)THEN
		SET ada = (SELECT id FROM lke_indikator WHERE id = idindk LIMIT 1);
		IF(ada IS NOT NULL)THEN
-- 			SET ada = (SELECT bukti_dukung WHERE );
				INSERT INTO lke_bukti_dukung VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), idindk, bkdk, NOW(), NULL, nox);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Bukti Dukung : ',bkdk, ' ,Indikator  : ',(SELECT id FROM lke_indikator WHERE id = idindk) ), NOW());
		ELSE
			SET res = 0;
			SET msg = ' Simpan Gagal ,Indikator Tidak Ditemukan.';
		END IF;
	ELSE
		SET ada = (SELECT id FROM lke_indikator WHERE id = idindk LIMIT 1);
		IF(ada IS NOT NULL)THEN
			UPDATE lke_bukti_dukung SET id_indikator = idindk, bukti_dukung = bkdk, nums = nox, update_at = NOW() WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Update Data Bukti Dukung : ',bkdk, ' ,Indikator  : ',(SELECT id FROM lke_indikator WHERE id = idindk) ), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Update Gagal, Indikator Tidak Ditemukan.';
		END IF;
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Bukti_dukung_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Jawaban :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT bukti_dukung FROM lke_bukti_dukung WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT id_bukti FROM lke_upload_bukti WHERE id_bukti = idx LIMIT 1);
		IF(ada IS NULL)THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Hapus Data Bukti Dukung  : ',(SELECT bukti_dukung FROM lke_bukti_dukung WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_bukti_dukung WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg = 'Bukti Dukung Masih Digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Bukti Dukung Tidak Ditemukan.';
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Form_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmx` VARCHAR(255), `thnx` VARCHAR(255), `desk` VARCHAR(255), `evls` VARCHAR(255), `btwkt` DATETIME)   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Form :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_form WHERE id = idx LIMIT 1);
	
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama FROM lke_form WHERE nama = nmx AND tahun = thnx LIMIT 1);
		IF (ada IS NULL) THEN
			INSERT INTO lke_form VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmx, thnx, desk, evls, btwkt, NOW(), '1', NULL);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Form : ',nmx,' Tahun : ',thnx), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama Form Sudah Ada.';
		END IF;
	ELSE
		UPDATE lke_form SET nama = nmx, tahun = thnx, deskripsi = desk, evaluasi = evls, bataswaktu = btwkt, update_at = NOW() WHERE id= idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data Form : ',nmx,' Tahun : ',thnx), NOW()); 
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Form_add_edit2` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmx` VARCHAR(255), `thnx` VARCHAR(255), `desk` VARCHAR(255), `evls` VARCHAR(255), `btwkt` DATETIME)   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Form :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_form WHERE id = idx LIMIT 1);
	
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama FROM lke_form WHERE nama = nmx AND tahun = thnx LIMIT 1);
		IF (ada IS NULL) THEN
			INSERT INTO lke_form VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmx, thnx, desk, evls, btwkt, NOW(), '1', NULL);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Form : ',nmx,' Tahun : ',thnx), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama Form Sudah Ada.';
		END IF;
	ELSE
		UPDATE lke_form SET nama = nmx, tahun = thnx, deskripsi = desk, evaluasi = evls, bataswaktu = btwkt, update_at = NOW() WHERE id= idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data Form : ',nmx,' Tahun : ',thnx), NOW()); 
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Form_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Form :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_form WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT form_id FROM lke_rb WHERE form_id = idx LIMIT 1);
		IF (ada IS NULL) THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data Form  : ',(SELECT nama FROM lke_form WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_form WHERE id= idx;
			SET res = 1;
			SET msg = 'success';
		ELSE
			SET res = 0;
			SET msg = 'Data Form masih digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Data Form tidak ditemukan.';
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Form_Enb_Dsb` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `stsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('ENABLE OR DISABLE Form :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
	
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_form WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
-- 		SET ada = (SELECT form_id FROM lke_rb WHERE form_id = idx LIMIT 1);
-- 		IF (ada IS NULL) THEN
			IF (stsx = 1) THEN
				INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ENABLE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('ENABLE Data Form  : ',(SELECT nama FROM lke_form WHERE id=idx LIMIT 1)), NOW());
			ELSE
				INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DISABLE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('DISABLE Data Form  : ',(SELECT nama FROM lke_form WHERE id=idx LIMIT 1)), NOW());
			END IF;
			
			UPDATE lke_form SET active = stsx, update_at = NOW() WHERE id= idx;
			SET res = 1;
			SET msg = 'success';
-- 		ELSE
-- 			SET res = 0;
-- 			SET msg = 'Data Form masih digunakan.';
-- 		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Data Form tidak ditemukan.';
	END IF;
	COMMIT;
	SELECT res, msg;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Indikator_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idssa` VARCHAR(255), `nmind` VARCHAR(255), `jjwb` VARCHAR(255), `numsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Indikator :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_indikator WHERE id=idx LIMIT 1);
	IF (ada IS NULL) THEN
		set ada = (SELECT id from lke_sub_sub_aspek WHERE id = idssa LIMIT 1);
		IF (ada IS NOT NULL) THEN
			SET ada = (SELECT indikator FROM lke_indikator WHERE id_sub_sub_aspek= idssa AND indikator= nmind);
			IF(ada IS NULL)THEN
				INSERT INTO lke_indikator VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), idssa, nmind, NOW(), NULL, jjwb, numsx);
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Indikator : ',nmind), NOW());
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
			ELSE
				SET res = 0;
				SET msg = 'Nama Indikator Dengan Sub Sub Aspek Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Sub Sub Aspek Tidak Di Temukan';
		END IF;
	ELSE
		set ada = (SELECT id from lke_sub_sub_aspek WHERE id = idssa LIMIT 1);
		IF (ada IS NOT NULL) THEN
			UPDATE lke_indikator SET indikator= nmind, id_sub_sub_aspek = idssa, jenis_jawaban = jjwb, nums = numsx 
			WHERE id = idx;
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Edit Data Indikator : ',nmind), NOW());
			SET res = 1;
			SET msg = 'Update Data Berhasil';
		ELSE
			SET res = 0;
			SET msg = 'Sub Sub Aspek Tidak Di Temukan';
		END IF;
	END IF;
	
	COMMIT;
	SELECT res,msg;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Indikator_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Indikator :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
		SET ada = (SELECT id FROM lke_indikator WHERE id = idx LIMIT 1);
		IF (ada IS NOT NULL) THEN
			SET ada = (SELECT id_indikator FROM lke_parameter WHERE id_indikator=idx LIMIT 1);
			IF (ada IS NULL)THEN
				INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Hapus Data Indikator  : ',(SELECT indikator FROM lke_indikator WHERE id=idx LIMIT 1)), NOW());
				DELETE FROM lke_indikator WHERE id = idx;
				DELETE FROM lke_bukti_dukung WHERE id_indikator = idx;
				SET res = 1;
				SET msg ='success';
			ELSE
				SET res = 0;
				SET msg ='Data Indikator Masih Digunakan';
			END IF;
		ELSE
			SET res = 0 ;
			SET msg = 'Data Indikator Tidak Di Temukan.';
		END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Jawaban_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `jwb` VARCHAR(255), `idindx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Jawaban :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_jawaban WHERE id = idx LIMIT 1);
	IF(ada IS NULL)THEN
		SET ada = (SELECT indikator FROM lke_indikator WHERE id= idindx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET ada = (SELECT Jawaban FROM lke_jawaban WHERE  id_indikator = idindx AND userid= uidx LIMIT 1);
			IF(ada IS NULL)THEN
				INSERT INTO lke_jawaban VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), jwb, idindx, NOW(), NULL, uidx, NULL, NULL, NULL,NULL);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Jawaban : ',jwb, 'Parameter : ',(SELECT indikator FROM lke_indikator WHERE id= idindx LIMIT 1) ), NOW());
			ELSE
				SET res = 0;
				SET msg = 'Jawaban Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Data Parameter Tidak Ditemukan.';
		END IF;
	ELSE
		SET ada = (SELECT indikator FROM lke_indikator WHERE id= idindx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			UPDATE lke_jawaban SET Jawaban = jwb , update_at = NOW() WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Update Data Jawaban : ',jwb, 'Parameter : ',(SELECT indikator FROM lke_indikator WHERE id= idindx LIMIT 1) ), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Data Parameter Tidak Ditemukan.';
		END IF;
	END IF;
	
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Jawaban_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Indikator :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT Jawaban FROM lke_jawaban WHERE id= idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT id_jawaban FROM lke_bukti_dukung WHERE id_jawaban = idx LIMIT 1);
		IF(ada IS NULL)THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Jawaban : ',jwb, 'Parameter : ',(SELECT nama_parameter FROM lke_parameter WHERE id= 
			(SELECT id_parameter FROM lke_jawaban WHERE id = idx))), NOW());
			DELETE FROM lke_jawaban WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg = 'Data Jawaban Masih Digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Data Jawaban tidak Ditemukan.';
	END IF;
	
	COMMIT;
	SELECT res,msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Jenis_Jawaban_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `jnjwb` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE anums INT;
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Jenis Jawaban :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET anums = (SELECT IF((SELECT num FROM lke_Jenis_Jawaban ORDER BY num DESC LIMIT 1) = NULL,1,(SELECT num FROM lke_Jenis_Jawaban ORDER BY num DESC LIMIT 1) +1));
	SET ada = (SELECT id FROM lke_Jenis_Jawaban WHERE id = idx LIMIT 1);
	IF(ada IS NULL)THEN
		SET ada = (SELECT jenis_jawaban FROM lke_Jenis_Jawaban WHERE jenis_jawaban = jnjwb LIMIT 1);
		IF (ada IS NULL)THEN
			INSERT INTO lke_Jenis_Jawaban VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), jnjwb, anums, 
			NOW(), NULL);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Jenis Jawaban : ',jnjwb,' Nomor : ',anums), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Jenis Jawaban Sudah Ada.';
		END IF;
	ELSE
		UPDATE lke_Jenis_Jawaban SET jenis_jawaban = jnjwb, Update_at = NOW() WHERE id=idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Update Data Jenis Jawaban : ',jnjwb,' Nomor : ',(SELECT num FROM lke_Jenis_Jawaban WHERE id = idx LIMIT 1)), NOW());
-- 	update DATA
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Jenis_Jawaban_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Jenis Jawaban :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_Jenis_Jawaban WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
		SET ada =(SELECT jenis_jawaban FROM lke_indikator WHERE jenis_jawaban=idx LIMIT 1);
		IF(ada IS NULL)THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Hapus Data Jenis Jawaban  : ',(SELECT jenis_jawaban FROM lke_Jenis_Jawaban WHERE id=idx LIMIT 1)), NOW());
				DELETE FROM lke_Jenis_Jawaban WHERE id = idx;
				SET res = 1;
				SET msg ='success';
		ELSE
			SET res = 0;
			SET msg ='Data Jenis Jawaban Masih Digunakan';
		END IF;
	ELSE
		SET res = 0 ;
		SET msg = 'Data Jenis Jawaban Tidak Di Temukan.';
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `log_user` (`uidx` VARCHAR(255), `ipx` VARCHAR(255), `stsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add user :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg;
  END;
		
	START TRANSACTION;
	
	INSERT INTO lke_log_user VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), uidx, (SELECT FullName FROM lke_user WHERE uid = uidx), NOW(), ipx, stsx);
	INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'LOGIN', 'USER', CONCAT('User Login :',(SELECT FullName FROM lke_user WHERE uid = uidx)), NOW());
	
	SET res = 1;
	SET msg = 'success';
	SELECT res, msg;
	
	COMMIT;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Opd_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmopd` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add, edit OPD :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_opd FROM lke_opd WHERE id=idx LIMIT 1);
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama_opd FROM lke_opd WHERE nama_opd=nmopd LIMIT 1);
		IF(ada IS NULL)THEN
			INSERT INTO lke_opd VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmopd, NOW(), NULL);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data OPD  : ',nmopd), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama OPD Sudah Ada.';
		END IF;
	ELSE
		UPDATE lke_opd SET nama_opd = nmopd, update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Update Data OPD  : ',nmopd), NOW());
	END IF;

	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Opd_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del OPD :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_opd FROM lke_opd WHERE id = idx LIMIT 1);
	IF (ada IS not null) THEN	
		SET ada = (SELECT id from lke_detail_opd WHERE opdid = idx LIMIT 1);
		IF (ada IS null) THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data OPD  : ',(SELECT nama_opd FROM lke_opd WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_opd WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg ='Data OPD Masih Digunakan';
		END IF;
	ELSE
		SET res = 0;
		SET msg ='Data OPD Tidak Di Temukan.';
	END IF;
	
	COMMIT;
	SELECT res, msg;

END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Parameter_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmpar` TEXT, `idind` VARCHAR(255), `numsx` VARCHAR(255), `nilx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Paraameter :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_parameter WHERE id=idx LIMIT 1);
	IF(ada IS NULL)THEN
		SET ada = (SELECT indikator FROM lke_indikator WHERE id=idind LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET ada= (SELECT nama_parameter FROM lke_parameter WHERE id_indikator = idind AND nama_parameter = nmpar LIMIT 1);
			IF(ada IS NULL)THEN
				INSERT INTO lke_parameter VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmpar, idind, NOW(), NULL, numsx, nilx);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Parameter : ',nmpar), NOW());
			ELSE
				SET res = 0;
				SET msg = 'Nama Parameter Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Nama Indikator Tidak Ditemukan.';
		END IF;
	ELSE
		SET ada = (SELECT indikator FROM lke_indikator WHERE id=idind LIMIT 1);
		IF(ada IS NOT NULL)THEN
			UPDATE lke_parameter SET nama_parameter = nmpar, id_indikator = idind, nums = numsx, update_at = NOW()
			WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('update Data Parameter : ',nmpar), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama Indikator Tidak Ditemukan.';
		END IF;
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Parameter_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idk` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Parameter :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_parameter WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT Jawaban FROM lke_jawaban INNER JOIN lke_indikator ON lke_jawaban.id_indikator = lke_indikator.id 
		WHERE lke_indikator.id = idk LIMIT 1
		);
		 
		IF (ada IS NULL)THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Parameter  : ',(SELECT nama_parameter FROM lke_parameter WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_parameter WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg = 'Data Parameter Masih Digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Data Parameter Tidak Ditemukan.';
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Rb_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmx` VARCHAR(255), `bbt` VARCHAR(255), `frmx` VARCHAR(255), `numsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Rb :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
	
	START TRANSACTION;
	
	SET ada = (SELECT id FROM lke_rb WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama FROM lke_rb WHERE nama = nmx LIMIT 1);
		IF(ada IS NULL) THEN
			INSERT INTO lke_rb VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmx, bbt, NOW(), NULL, frmx, numsx);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data RB : ',nmx,' Bobot : ',bbt), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama RB Sudah Ada.';
		END IF; 
	ELSE
		UPDATE lke_rb SET nama = nmx, bobot = bbt, nums = numsx, update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data RB : ',nmx,' Bobot : ',bbt), NOW());
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Rb_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	
	SET ada = (SELECT id FROM lke_rb WHERE id = idx LIMIT 1);
	IF(ada IS NOT NULL) THEN
		SET ada = (SELECT id FROM lke_aspek WHERE rb_id = idx LIMIT 1);
		IF(ada IS NULL)THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data RB  : ',(SELECT nama FROM lke_rb WHERE id=idx LIMIT 1)), NOW());
			
			DELETE FROM lke_rb WHERE id= idx;
			SET res = 1;
			SET msg = 'success';
			
		ELSE
			SET res = 0;
			SET msg = 'Data RB masih digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg = 'Data RB tidak ditemukan.';
	END IF;
	
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Sub_Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmsub` VARCHAR(255), `idasp` VARCHAR(255), `bbt` VARCHAR(255), `numsx` VARCHAR(255), `btswkt` DATETIME)   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Sub Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
-- 		SET ada = (SELECT id FROM )
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id= idasp LIMIT 1);
		IF (ada IS NOT NULL ) THEN
			SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id_aspek=idasp AND nama_sub_aspek=nmsub LIMIT 1);
			IF(ada IS NULL)THEN
				INSERT INTO lke_sub_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmsub, NOW(), NULL, idasp, bbt, numsx, btswkt);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
			ELSE
				SET res = 0;
				SET msg = 'Nama Sub Aspek Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Nama Aspek Tidak Di Temukan';
		END IF;
	ELSE
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id= idasp LIMIT 1);
		IF (ada IS NOT NULL ) THEN
			UPDATE lke_sub_aspek SET nama_sub_aspek = nmsub , id_aspek = idasp ,bobot = bbt, nums = numsx, batas_waktu = btswkt, update_at = NOW()
			WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Update Data Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Nama Aspek Tidak Di Temukan';
		END IF;
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Sub_Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Sub Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NOT NULL) THEN	
		SET ada = (SELECT id_sub_aspek FROM lke_sub_sub_aspek WHERE id_sub_aspek = idx);
		IF (ada IS NULL) THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data Sub Aspek  : ',(SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_sub_aspek WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg ='Data Sub Aspek Masih Digunakan.';
		END IF;
		
	ELSE
		SET res = 0;
		SET msg ='Data Sub Aspek Tidak Di Temukan.';
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `Sub_Sub_Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmsub` VARCHAR(255), `idasp` VARCHAR(255), `bbt` VARCHAR(255), `numsx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Sub Sub Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_sub_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id=idasp );
		IF(ada IS NOT NULL)THEN
			SET ada = (SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id_sub_aspek = idasp AND nama_sub_sub_aspek = nmsub);
			IF(ada IS NULL )THEN
				INSERT INTO lke_sub_sub_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmsub, NOW(), NULL, idasp, bbt, numsx);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil.';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Sub Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
			ELSE
				SET res = 0;
				SET msg = 'Sub Sub Aspek Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Sub Aspek Tidak Ditemukan.';
		END IF;
	ELSE
		SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id=idasp );
		IF(ada IS NOT NULL)THEN
			UPDATE lke_sub_sub_aspek SET nama_sub_sub_aspek = nmsub , id_sub_aspek = idasp ,bobot = bbt, nums = numsx, update_at = NOW()
			WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil.';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Update Data Sub Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
		ELSE
			SET res = 0;
			SET msg = 'Sub Aspek Tidak Ditemukan.';
		END IF;
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `sub_Sub_Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Sub Sub Aspek :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NOT NULL) THEN	
		SET ada = (SELECT id_sub_sub_aspek FROM lke_indikator WHERE id_sub_sub_aspek = idx LIMIT 1);
		IF (ada IS NULL) THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data Sub Sub Aspek  : ',(SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_sub_sub_aspek WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0;
			SET msg ='Data Sub Sub Aspek Masih Digunakan.';
		END IF;
	ELSE
		SET res = 0;
		SET msg ='Data Sub Sub Aspek Tidak Di Temukan.';
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `upload_bukti_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idbkt` VARCHAR(255), `flnm` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add Bukti Dukung :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg; 
  END;
	
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_upload_bukti WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
-- 		SET ada = (SELECT id FROM lke_bukti_dukung WHERE id = idx);
-- 		IF (ada IS NOT NULL) THEN
			INSERT INTO lke_upload_bukti VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), flnm, idbkt, NOW(), NULL, uidx);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data File Bukti Dukung : ',flnm, ' ,bukti Dukung  : ',(SELECT id FROM lke_bukti_dukung WHERE id = idbkt) ), NOW());
-- 		ELSE
-- 			SET res = 0;
-- 			SET msg = ' Simpan Gagal ,Bukti Dukung Tidak Ditemukan.';
-- 		END IF;

-- 	ELSE
-- 		update
	END IF;

	
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `User_Auth` (`usrnm` VARCHAR(255), `pswd` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm LIMIT 1);
	
	IF (ada IS NOT NULL) THEN
		SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm AND PassEnc = EncPass(pswd));
		IF (ada IS not NULL) THEN
			SET ada = (SELECT actv from lke_user WHERE UserName= usrnm AND PassEnc = EncPass(pswd));
			IF(ada = 'TRUE')THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res,
					msg,
					a.uid,
					a.UserName,
					a.FullName,
					a.Phone,
					a.EmailAdds,
					a.Create_at,
					b.RoleName,
					IF(e.nama_opd IS NULL,'-',e.nama_opd ) AS nama_opd,
					a.actv
				FROM
					lke_user AS a
					INNER JOIN lke_role AS c ON a.uid = c.Uid
					INNER JOIN lke_roles AS b ON c.RoleId = b.RoleId
					LEFT JOIN lke_detail_opd AS d ON a.uid = d.userid
					LEFT JOIN lke_opd AS e ON d.opdid = e.id
					WHERE a.UserName = usrnm AND 
					a.PassEnc = EncPass(pswd) LIMIT 1;
			ELSE
				SET res = 0;
				SET msg = 'Akun Tidak Aktif.';
				SELECT res, msg;
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Password Tidak Benar';
			SELECT res, msg;
		END IF;

	ELSE
		SET res = 0;
		SET msg = CONCAT('Kami Tidak Menemukan Username : ',usrnm,',');
		SELECT res, msg;
	END IF;

END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `User_Cretae_new` (`uidx` VARCHAR(255), `uname` VARCHAR(255), `fname` VARCHAR(255), `pswd` VARCHAR(255), `phn` VARCHAR(255), `eml` VARCHAR(255), `rlid` VARCHAR(255), `opid` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE uids VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('add user :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg;
  END;
		
	START TRANSACTION;
	
	SET ada = (select uid from lke_user WHERE UserName = uname LIMIT 1);
	SET uids = SHA(CONCAT(NOW(),RAND(),uidx));
	
	IF (ada is NULL) THEN
		SET ada = (SELECT RoleId FROM lke_roles WHERE RoleId = rlid LIMIT 1);
		if (ada IS NOT NULL) THEN
			SET ada = (SELECT id from lke_opd WHERE id = opid LIMIT 1);
			IF (ada IS NOT NULL) THEN
				INSERT INTO lke_user VALUES(uids, uname, fname, 
				EncPass(pswd)
				,phn, eml, NOW(), NULL, 'TRUE');
				
				INSERT INTO lke_role VALUES(uids, rlid, NOW(), NULL, NULL);

				INSERT INTO lke_detail_opd VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), uids, opid, NOW(), NULL);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT(msg,' : ',uname,' Full Name : ',fname), NOW());
			ELSE
				SET res = 0;
				SET msg = 'OPD Tidak Ditemukan';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Role Tidak Ditemukan';
		END IF;
	ELSE
		SET res = 0;
		SET msg = CONCAT('Data Dengan Username : ',uname , ' ,Sudah Ada. Gunakan Username Yang Lain');
	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `User_Update_data` (`uidx` VARCHAR(255), `uname` VARCHAR(255), `fname` VARCHAR(255), `phn` VARCHAR(255), `eml` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('edit user :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg;
  END;
		
	START TRANSACTION;
		SET ada = (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1);
		IF (ada IS NOT NULL) THEN
			UPDATE lke_user SET UserName = uname, FullName = fname, Phone = phn, EmailAdds = eml, Update_at=NOW() 
			WHERE uid = uidx;
			SET res = 1;
			SET msg ='success'; 
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('UPDATE Data User ',' : ',uname,' Full Name : ',fname), NOW());
		ELSE
			SET res = 0;
			SET msg ='Pengguna Tidak Menemukan.'; 
		END IF;
	COMMIT;
	
	select res, msg;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `User_update_password` (`uidx` VARCHAR(255), `pswd` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		ROLLBACK;
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'ERROR', 'System', CONCAT('edit password user :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg;
  END;
		
	START TRANSACTION;
	SET ada = (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1);
	IF (ada is not NULL) THEN
		UPDATE lke_user SET PassEnc = EncPass(pswd), Update_at=NOW() 
		WHERE uid = uidx;
			SET res = 1;
			SET msg ='success'; 
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('UPDATE Password User ',' : ',
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),' Full Name : ',
			(SELECT FullName FROM lke_user WHERE uid = uidx LIMIT 1)), NOW());
	ELSE
		SET res = 0;
		SET msg ='Pengguna Tidak Ditemukan.'; 
	END IF;
	COMMIT;
	SELECT res,msg;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 1000;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res,
				msg,
				(
					SELECT CONCAT(nums,'. ',nama) FROM lke_rb 
					WHERE lke_rb.id = a.rb_id
				) AS rb,
				a.id, 
				CONCAT(a.nums,'. ',a.nama_aspek) AS nama_aspek,  
				a.create_at, 
				a.update_at, 
				a.bobot,
				(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,

				(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id,
				a.nums,
				a.nama_aspek as nmaspek
			FROM
				lke_aspek AS a
				ORDER BY  a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT nama FROM lke_rb WHERE id = idx);
		IF (ada IS NOT NULL) THEN
			SET res = 1;
				SET msg = 'success';
				SELECT
					res,
					msg,
					(
						SELECT CONCAT(nums,'. ',nama) FROM lke_rb 
						WHERE lke_rb.id = a.rb_id
					) AS rb,
					a.id,
					CONCAT(a.nums,'. ',a.nama_aspek) AS nama_aspek, 
					a.create_at, 
					a.update_at, 
					a.bobot,
				
					(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
			
					(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id,
					a.nums,
					a.nama_aspek as nmaspek
				FROM
					lke_aspek AS a
					WHERE a.rb_id = idx
					ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET res = 1;
			SET msg = 'success';
			SELECT
				res,
				msg,
				(
					SELECT CONCAT(nums,'. ',nama) FROM lke_rb 
					WHERE lke_rb.id = a.rb_id
				) AS rb,
				a.id, 
				CONCAT(a.nums,'. ',a.nama_aspek) AS nama_aspek, 
				a.create_at, 
				a.update_at, 
				a.bobot,
		
				(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
				(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id,
				a.nums,
				a.nama_aspek as nmaspek
			FROM
				lke_aspek AS a
				WHERE a.id = idx
				ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
				
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Bukti_dukung` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			a.id, 
			a.id_indikator,
			(SELECT CONCAT(lke_indikator.nums,'. ',lke_indikator.indikator) FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
			CONCAT(a.nums,'. ',a.bukti_dukung ) AS bukti_dukung,
				a.create_at, 
				a.update_at,
				a.nums,
				a.bukti_dukung AS nmbukti
		FROM
			lke_bukti_dukung AS a
			ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_bukti_dukung WHERE id = idx);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res,
				msg,
				a.id, 
				a.id_indikator, 
				(SELECT CONCAT(lke_indikator.nums,'. ',lke_indikator.indikator) FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
				CONCAT(a.nums,'. ',a.bukti_dukung ) AS bukti_dukung,
				a.create_at, 
				a.update_at,
				a.nums,
				a.bukti_dukung AS nmbukti
			FROM
				lke_bukti_dukung AS a
				WHERE a.id = idx
				ORDER BY indikator, a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id from lke_indikator WHERE id = idx);
			IF(ada IS NOT NULL) THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res,
					msg,
					a.id, 
					a.id_indikator, 
					(SELECT CONCAT(lke_indikator.nums,'. ',lke_indikator.indikator) FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
					CONCAT(a.nums,'. ',a.bukti_dukung ) AS bukti_dukung,
				a.create_at, 
				a.update_at,
				a.nums,
				a.bukti_dukung AS nmbukti
				FROM
					lke_bukti_dukung AS a
					WHERE a.id_indikator = idx
					ORDER BY indikator, a.nums ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Dashboard_Soal` ()   BEGIN
  #Routine body goes here...
	DECLARE asp VARCHAR(255);
	DECLARE sasp VARCHAR(255);
	DECLARE ssasp VARCHAR(255);
	DECLARE indk VARCHAR(255);
	DECLARE prmt VARCHAR(255);
	DECLARE bktdk VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET asp 		= (SELECT count(*) FROM lke_aspek);
	SET sasp 		= (SELECT count(*) FROM lke_sub_aspek);
	SET ssasp 	= (SELECT count(*) FROM lke_sub_sub_aspek);
	SET indk 		= (SELECT count(*) FROM lke_indikator);
	SET prmt 		= (SELECT count(*) FROM lke_parameter);
	SET bktdk 	= (SELECT count(*) FROM lke_bukti_dukung);
	SET res 		= '1';
	SET msg 		= 'success';
	
	SELECT res, msg, asp, sasp, ssasp, indk, prmt, bktdk; 
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Dashboard_User` (`uidx` VARCHAR(255), `thnx` VARCHAR(255), `aprv` VARCHAR(255))   BEGIN
  #Routine body goes here...
	
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET res='1';
	SET msg= 'success';
	IF (aprv = 'yes') THEN
		SELECT
			res,msg,
			CONCAT(a.nums,'. ',a.nama)AS nama_rb,
			CONCAT(b.nums,'. ',b.nama_aspek) AS nama_aspek,
			h.tahun,
			h.deskripsi,
			h.evaluasi,
			h.bataswaktu,
			'' AS tahapan,
-- 			b.tahapan,
			b.bobot AS bobot_aspek,
			CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			CONCAT(f.nums,'. ',f.indikator) AS indikator,
			( SELECT GROUP_CONCAT(nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = f.id ) AS parameter,
		-- 	g.jenis_jawaban,
		-- -- 	user Jawaban
		-- 
			IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) IS NULL,
			'-',
			IF((SELECT
					lke_parameter.nama_parameter 
				FROM
					lke_parameter
					INNER JOIN lke_jawaban ON lke_parameter.id = lke_jawaban.Jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx ) IS NULL
				,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx),
				(SELECT
					lke_parameter.nama_parameter 
				FROM
					lke_parameter
					INNER JOIN lke_jawaban ON lke_parameter.id = lke_jawaban.Jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx )
				)
			) AS Jawabanx,
			
			IF((SELECT nilai FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx AND lke_jawaban.aprove = 'yes') IS NULL,
			'-',
			(SELECT nilai FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx)) AS nilaix,
			
			(SELECT
				lke_opd.singkatan
			FROM
				lke_detail_opd
				INNER JOIN
				lke_opd
				ON 
					lke_detail_opd.opdid = lke_opd.id WHERE userid = 
					(SELECT aproveby FROM lke_jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx) LIMIT 1) AS penilaix
					
-- 			
			
		FROM
			lke_rb AS a
			INNER JOIN lke_aspek AS b ON a.id = b.rb_id
			INNER JOIN lke_sub_aspek AS d ON b.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			INNER JOIN lke_Jenis_Jawaban AS g ON f.jenis_jawaban = g.id 
			INNER JOIN lke_form AS h ON h.id = a.form_id
			WHERE h.active = 1 AND h.tahun = thnx AND f.id IN (SELECT id_indikator FROM lke_parameter);
	ELSE
		SELECT
			res,msg,
			CONCAT(a.nums,'. ',a.nama)AS nama_rb,
			CONCAT(b.nums,'. ',b.nama_aspek) AS nama_aspek,
			h.tahun,
			h.deskripsi,
			h.evaluasi,
			h.bataswaktu,
			'' AS tahapan,
-- 			b.tahapan,
			b.bobot AS bobot_aspek,
			CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			CONCAT(f.nums,'. ',f.indikator) AS indikator,
			( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = f.id ) AS parameter,
		-- 	g.jenis_jawaban,
		-- -- 	user Jawaban
		-- 
			IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) IS NULL,
			'-',
			IF((SELECT
					lke_parameter.nama_parameter 
				FROM
					lke_parameter
					INNER JOIN lke_jawaban ON lke_parameter.id = lke_jawaban.Jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx ) IS NULL
				,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx),
				(SELECT
					lke_parameter.nama_parameter 
				FROM
					lke_parameter
					INNER JOIN lke_jawaban ON lke_parameter.id = lke_jawaban.Jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx )
				)
			) AS Jawabanx,
			
			IF((SELECT nilai FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx AND lke_jawaban.aprove = 'yes') IS NULL,
			'-',
			(SELECT nilai FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx)) AS nilaix,
			(SELECT
				lke_opd.singkatan
			FROM
				lke_detail_opd
				INNER JOIN
				lke_opd
				ON 
					lke_detail_opd.opdid = lke_opd.id WHERE userid = 
					(SELECT aproveby FROM lke_jawaban WHERE lke_jawaban.id_indikator = f.id AND lke_jawaban.userid = uidx) LIMIT 1) AS penilaix
			
		FROM
			lke_rb AS a
			INNER JOIN lke_aspek AS b ON a.id = b.rb_id
			INNER JOIN lke_sub_aspek AS d ON b.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			INNER JOIN lke_Jenis_Jawaban AS g ON f.jenis_jawaban = g.id 
			INNER JOIN lke_form AS h ON h.id = a.form_id
			WHERE h.active = 1 AND h.tahun = thnx AND f.id IN (SELECT id_indikator FROM lke_parameter);
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Data_List_Soal` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255), `thnx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE tahunx VARCHAR(255);
	
	IF (thnx IS NULL OR thnx = '') THEN
		SET tahunx = '%%';
	ELSE
		SET tahunx = thnx;
	END IF;

	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res,msg,
			CONCAT('Form : ',a.nama,'(',
				IF(a.active  = 1,
				'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle-fill text-success" viewBox="0 0 16 16">
  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0m-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
</svg>'
				,'<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-circle-fill text-danger" viewBox="0 0 16 16">
  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M5.354 4.646a.5.5 0 1 0-.708.708L7.293 8l-2.647 2.646a.5.5 0 0 0 .708.708L8 8.707l2.646 2.647a.5.5 0 0 0 .708-.708L8.707 8l2.647-2.646a.5.5 0 0 0-.708-.708L8 7.293z"/>
</svg>'
				)
				,')') AS nama_form,
			a.tahun,
			a.deskripsi,
			a.evaluasi,
			a.bataswaktu,
			CONCAT(b.nums,'. ',b.nama)AS nama_rb,
			CONCAT(c.nums,'. ',c.nama_aspek) AS nama_aspek,
			CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
			CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
			CONCAT(f.nums,'. ',f.indikator) AS indikator,
			f.id AS id_ind,
			IF(g.nums IS NOT NULL,
			CONCAT(g.nums,'. ',g.nama_parameter)
			,g.nama_parameter) AS nama_parameter,
			g.id AS id_parameter,
			g.create_at,
			a.active,
			g.nama_parameter AS nmpr,
			g.nums
			 
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			INNER JOIN lke_parameter AS g ON f.id = g.id_indikator
			WHERE a.tahun LIKE(tahunx)
			ORDER BY  b.nums, c.nums, d.nums, e.nums, f.nums, g.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
				CONCAT('Form : ',a.nama,'(',
				IF(a.active  = 1,'AKTIV','TIDAK AKTIV')
				,')') AS nama_form,
				a.tahun,
				a.deskripsi,
				a.evaluasi,
				a.bataswaktu,
				CONCAT(b.nums,'. ',b.nama)AS nama_rb,
				CONCAT(c.nums,'. ',c.nama_aspek) AS nama_aspek,
				CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
				CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
				CONCAT(f.nums,'. ',f.indikator) AS indikator,
				f.id AS id_ind,
				IF(g.nums IS NOT NULL,
				CONCAT(g.nums,'. ',g.nama_parameter)
				,g.nama_parameter) AS nama_parameter,
				g.id AS id_parameter,
				g.create_at,
				a.active,
				g.nama_parameter AS nmpr,
				g.nums
				 
			FROM
				lke_form AS a
				INNER JOIN lke_rb AS b ON a.id = b.form_id
				INNER JOIN lke_aspek AS c ON b.id = c.rb_id
				INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
				INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
				INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
				INNER JOIN lke_parameter AS g ON f.id = g.id_indikator
				WHERE f.id = idx AND a.tahun LIKE(tahunx)
				ORDER BY  b.nums, c.nums, d.nums, e.nums, f.nums, g.nums ASC LIMIT lmtx OFFSET ofset;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_File_For_Upload` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	SET ada = (SELECT id FROM lke_indikator WHERE id = idx);
	IF (ada IS NULL) THEN
	SET res = 0;
	SET msg = 'Data Tidak Ditemukan.';
	SELECT
		res, msg;
	ELSE
		SET ada = (SELECT FullName from lke_user WHERE uid = uidx);
		IF (ada IS NULL) THEN
			SET res = 0;
			SET msg = 'Data Tidak Ditemukan.';
			SELECT
				res, msg;
		ELSE
			SET res = 1;
			SET msg = 'success';
			SELECT
				res,
				msg,
				a.id, 
				a.id_indikator, 
				a.bukti_dukung, 
				a.create_at, 
				a.update_at
			FROM
				lke_bukti_dukung AS a
				WHERE id_indikator = idx
				AND a.id NOT IN (SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx)
				ORDER BY a.bukti_dukung ASC LIMIT lmtx OFFSET ofset;
		END IF;
	
	END IF;
	
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Forms` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 1000;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	
	SET res = 1;
	SET msg = 'success';
	
	IF(idx IS NULL OR idx ='')THEN
		SELECT
			res,msg,
			a.id, 
			a.nama, 
			a.tahun, 
			a.deskripsi, 
			a.evaluasi, 
			a.bataswaktu, 
			a.create_at, 
			a.active, 
			a.update_at
		FROM
			lke_form AS a
			ORDER BY a.nama, a.tahun ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SELECT
			res,msg,
			a.id, 
			a.nama, 
			a.tahun, 
			a.deskripsi, 
			a.evaluasi, 
			a.bataswaktu, 
			a.create_at, 
			a.active, 
			a.update_at
		FROM
			lke_form AS a
			WHERE a.id = idx
			ORDER BY a.nama ,a.tahun ASC LIMIT lmtx OFFSET ofset;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Indikator` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 1000;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			(
			SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
			INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS rb,
			(
			SELECT CONCAT(lke_aspek.nums, '. ' ,lke_aspek.nama_aspek) FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS aspek,
			
			(
			SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS nama_sub_aspek,
			
			(
			SELECT CONCAT(lke_sub_sub_aspek.nums,'. ',lke_sub_sub_aspek.nama_sub_sub_aspek) FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS nama_sub_sub_aspek,
			
			a.id,
			a.id_sub_sub_aspek,
			CONCAT(a.nums,'. ',a.indikator) AS indikator,
			a.create_at,
			a.update_at,
			( SELECT GROUP_CONCAT( nama_parameter ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
			( SELECT GROUP_CONCAT( bukti_dukung ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
			IF(uidx IS NULL, 0 ,
				IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
			) AS jwbx,
			b.jenis_jawaban,
			a.jenis_jawaban AS jwbid,
			(SELECT id FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) idjwbx,
			b.num,
				IF(DATE((
				SELECT
					lke_form.bataswaktu 
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_rb ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_form ON lke_rb.form_id = lke_form.id
				WHERE lke_indikator.id = a.id)
				 ) > DATE(NOW()),IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','0',NULL), '1') tombol
				 , IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','1',NULL) as tolak
				 ,IF((SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no',
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx,
				 
				 (SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id) AS wktsubasp1,
				 
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				 ) IS NOT NULL,
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				  ) <= NOW()
				 
				 ,1,0)
				 ,0) AS wktsubasp,
				 a.nums,
				 a.indikator AS nmindk,
				 (
					SELECT lke_rb.nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmrb,
					(
					SELECT lke_aspek.nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmaspek,
					IF(b.jenis_jawaban = 'Skala Linear',( SELECT nilai FROM lke_parameter WHERE id_indikator = a.id ),NULL) AS nilaiprmt
				 
		FROM
			lke_indikator AS a
			INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
			ORDER BY rb, aspek, nama_sub_aspek, nama_sub_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_indikator WHERE id =idx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				(
				SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
				INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS rb,
				(
				SELECT CONCAT(lke_aspek.nums, '. ' ,lke_aspek.nama_aspek) FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS aspek,
				
				(
				SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS nama_sub_aspek,
				
				(
				SELECT CONCAT(lke_sub_sub_aspek.nums,'. ',lke_sub_sub_aspek.nama_sub_sub_aspek) FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS nama_sub_sub_aspek,
				
				a.id,
				a.id_sub_sub_aspek,
				CONCAT(a.nums,'. ',a.indikator) AS indikator,
				a.create_at,
				a.update_at,
				( SELECT GROUP_CONCAT( nama_parameter ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
				( SELECT GROUP_CONCAT( bukti_dukung ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
				IF(uidx IS NULL, 0 ,
					IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
				) AS jwbx,
				b.jenis_jawaban,
				a.jenis_jawaban AS jwbid,
				(SELECT id FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) idjwbx,
				b.num,
			IF(DATE((
				SELECT
					lke_form.bataswaktu 
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_rb ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_form ON lke_rb.form_id = lke_form.id
				WHERE lke_indikator.id = a.id)
				 ) > DATE(NOW()),IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','0',NULL), '1') tombol
				 , IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','1',NULL) as tolak
				 ,IF((SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no',
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx,
				 
				 (SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id) AS wktsubasp1,
				 
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				 ) IS NOT NULL,
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				  ) <= NOW()
				 
				 ,1,0)
				 ,0) AS wktsubasp,
				 a.nums,
				 a.indikator AS nmindk,
				 (
					SELECT lke_rb.nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmrb,
					(
					SELECT lke_aspek.nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmaspek,
					IF(b.jenis_jawaban = 'Skala Linear',( SELECT nilai FROM lke_parameter WHERE id_indikator = a.id ),NULL) AS nilaiprmt
				 
			FROM
				lke_indikator AS a
				INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
				WHERE a.id = idx
				ORDER BY  rb, aspek, nama_sub_aspek, nama_sub_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_sub_sub_aspek WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					(
					SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS rb,
					(
					SELECT CONCAT(lke_aspek.nums, '. ' ,lke_aspek.nama_aspek) FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS aspek,
					
					(
					SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nama_sub_aspek,
					
					(
					SELECT CONCAT(lke_sub_sub_aspek.nums,'. ',lke_sub_sub_aspek.nama_sub_sub_aspek) FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nama_sub_sub_aspek,
					
					a.id,
					a.id_sub_sub_aspek,
					CONCAT(a.nums,'. ',a.indikator) AS indikator,
					a.create_at,
					a.update_at,
					( SELECT GROUP_CONCAT( nama_parameter ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_parameter WHERE id_indikator = a.id) AS parameter,
					( SELECT GROUP_CONCAT( bukti_dukung ORDER BY nums ASC SEPARATOR ',<br> ' ) FROM lke_bukti_dukung WHERE id_indikator = a.id) AS bukti_dukung,
					IF(uidx IS NULL, 0 ,
						IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
					) AS jwbx,
					b.jenis_jawaban,
					a.jenis_jawaban AS jwbid,
					(SELECT id FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) idjwbx,
					b.num,
					IF(DATE((
				SELECT
					lke_form.bataswaktu 
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_rb ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_form ON lke_rb.form_id = lke_form.id
				WHERE lke_indikator.id = a.id)
				 ) > DATE(NOW()),IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','0',NULL), '1') tombol
				 , IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no','1',NULL) as tolak
				 ,IF((SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) = 'no',
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx,
				 
				 (SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id) AS wktsubasp1,
				 
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				 ) IS NOT NULL,
				 IF((
				 SELECT
						lke_sub_aspek.batas_waktu 
					FROM
						lke_indikator
						INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
						INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					WHERE lke_indikator.id = a.id
				  ) <= NOW()
				 
				 ,1,0)
				 ,0) AS wktsubasp,
				 a.nums,
				 a.indikator AS nmindk,
				 (
					SELECT lke_rb.nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmrb,
					(
					SELECT lke_aspek.nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nmaspek,
					IF(b.jenis_jawaban = 'Skala Linear',( SELECT nilai FROM lke_parameter WHERE id_indikator = a.id ),NULL) AS nilaiprmt
				 
				FROM
					lke_indikator AS a
					INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
					WHERE id_sub_sub_aspek = idx
					ORDER BY rb, aspek, nama_sub_aspek, nama_sub_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Jawaban` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			a.id, 
			a.Jawaban, 
			a.id_parameter, 
			a.create_at, 
			a.update_at, 
			a.userid, 
			a.nilai
		FROM
			lke_jawaban AS a
			ORDER BY a.Jawaban ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_jawaban WHERE id=idx);
		IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
				res, msg,
				a.id, 
				a.Jawaban, 
				a.id_parameter, 
				a.create_at, 
				a.update_at, 
				a.userid, 
				a.nilai
			FROM
				lke_jawaban AS a
				WHERE a.id = idx
				ORDER BY a.Jawaban ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_parameter WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					a.id, 
					a.Jawaban, 
					a.id_parameter, 
					a.create_at, 
					a.update_at, 
					a.userid, 
					a.nilai
				FROM
					lke_jawaban AS a
					WHERE a.id_parameter = idx
					ORDER BY a.Jawaban ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Jawaban_By_OPD` (IN `idx` VARCHAR(255), IN `id_opd` VARCHAR(255), IN `lmt` VARCHAR(255), IN `ofst` VARCHAR(255))   BEGIN
    -- Deklarasi Variabel
    DECLARE lmtx INT DEFAULT 200;
    DECLARE ofset INT DEFAULT 0;
    DECLARE res INT DEFAULT 1;
    DECLARE msg VARCHAR(255) DEFAULT 'success';

    -- Validasi limit dan offset
    IF (lmt REGEXP '^-?[0-9]+$') THEN
        SET lmtx = CAST(lmt AS SIGNED);
    END IF;

    IF (ofst REGEXP '^-?[0-9]+$') THEN
        SET ofset = CAST(ofst AS SIGNED);
    END IF;

    -- Cek apakah idx kosong atau tidak
    IF (idx IS NULL OR idx = '') THEN
        -- Ambil semua data dengan filter ID OPD dan pagination
        SELECT 
            res AS status, msg AS message,
            a.Jawaban,
            d.nama_opd,
            b.UserName,
            e.indikator 
        FROM lke_jawaban AS a
        INNER JOIN lke_user AS b ON a.userid = b.uid
        INNER JOIN lke_detail_opd AS c ON b.uid = c.userid
        INNER JOIN lke_opd AS d ON c.opdid = d.id
        INNER JOIN lke_indikator AS e ON a.id_indikator = e.id
        WHERE (id_opd IS NULL OR id_opd = '' OR d.id = id_opd)  -- Tambahkan filter ID OPD
        LIMIT lmtx OFFSET ofset;
    
    ELSE
        -- Ambil data berdasarkan idx dan filter ID OPD
        SELECT 
            res AS status, msg AS message,
            a.Jawaban,
            d.nama_opd,
            b.UserName,
            e.indikator 
        FROM lke_jawaban AS a
        INNER JOIN lke_user AS b ON a.userid = b.uid
        INNER JOIN lke_detail_opd AS c ON b.uid = c.userid
        INNER JOIN lke_opd AS d ON c.opdid = d.id
        INNER JOIN lke_indikator AS e ON a.id_indikator = e.id
        WHERE a.id = idx 
          AND (id_opd IS NULL OR id_opd = '' OR d.id = id_opd);  -- Tambahkan filter ID OPD
    
    END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Jenis_Jawaban` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.id, 
			a.jenis_jawaban, 
			a.num, 
			a.create_at, 
			a.update_at
		FROM
			lke_Jenis_Jawaban AS a
			ORDER BY a.num ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_Jenis_Jawaban WHERE id = idx);
		IF (ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				a.id, 
				a.jenis_jawaban, 
				a.num, 
				a.create_at, 
				a.update_at
			FROM
				lke_Jenis_Jawaban AS a
				WHERE id = idx
				ORDER BY a.num ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET res = 0;
			SET msg = 'Data Tidak Ditemukan.';
			SELECT
					res, msg;
		END IF;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_List_Data_Soal_User` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255), `uidx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.nama AS nama_form,
			a.tahun,
			a.deskripsi,
			a.evaluasi,
			a.bataswaktu,
			CONCAT(b.nums,'. ',b.nama)AS nama_rb,
			CONCAT(c.nums,'. ',c.nama_aspek) AS nama_aspek,
			CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
			IF(d.batas_waktu IS NULL,d.nama_sub_aspek,CONCAT(d.nums,'. ',d.nama_sub_aspek ,' (Batas Waktu : ', d.batas_waktu, ')')) AS nama_sub_aspek2,
-- 			d.batas_waktu AS wktAsp,
			IF(d.batas_waktu <= NOW(),1,0) AS wktAsp,
			 
			(SELECT COUNT(*) FROM lke_sub_sub_aspek WHERE lke_sub_sub_aspek.id_sub_aspek = d.id) AS jum_subSubaspek,
			CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
			CONCAT(f.nums,'. ',f.indikator) AS indikator,
			f.id AS ind_id,
			IF((( SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id LIMIT 1) IS NOT NULL ) AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = f.id LIMIT 1) <= 
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
 							IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0','1'),NULL) AS tombol,
							
	
			CONCAT(
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
					' / ',
				( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = f.id ) 
						) AS kemajuan  
						, IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = idx AND userid = uidx) = 'no','0',NULL) as tolak,
			
			IF(uidx IS NULL, 0 ,
				IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx))
			) AS jwbx
			
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			WHERE a.active = 1
			ORDER BY   b.nums, c.nums, d.nums, e.nums, f.nums  ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
			SELECT
			res, msg,
			a.nama AS nama_form,
			a.tahun,
			a.deskripsi,
			a.evaluasi,
			a.bataswaktu,
			CONCAT(b.nums,'. ',b.nama)AS nama_rb,
			CONCAT(c.nums,'. ',c.nama_aspek) AS nama_aspek,
			CONCAT(d.nums,'. ',d.nama_sub_aspek) AS nama_sub_aspek,
			IF(d.batas_waktu IS NULL,d.nama_sub_aspek,CONCAT(d.nums,'. ',d.nama_sub_aspek ,' (Batas Waktu : ', d.batas_waktu, ')')) AS nama_sub_aspek2,
-- 			d.batas_waktu AS wktAsp,
			IF(d.batas_waktu <= NOW(),1,0) AS wktAsp,
			CONCAT(e.nums,'. ',e.nama_sub_sub_aspek) AS nama_sub_sub_aspek,
			CONCAT(f.nums,'. ',f.indikator) AS indikator,
			f.id AS ind_id,
			IF((( SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id LIMIT 1) IS NOT NULL ) AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = f.id LIMIT 1) <= 
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
 							IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0','1'),NULL) AS tombol,

			CONCAT(
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
					' / ',
				( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = f.id ) 
						) AS kemajuan  
						, IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0',NULL) as tolak,
						
			IF(uidx IS NULL, 0 ,
				IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx))
			) AS jwbx
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			WHERE a.active = 1 AND a.id = idx AND f.id IN (SELECT id_indikator FROM lke_parameter) 
			ORDER BY  b.nums, c.nums, d.nums, e.nums, f.nums LIMIT lmtx OFFSET ofset;
			
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Opd` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.id, 
			a.nama_opd, 
			a.create_at, 
			a.update_at
		FROM
			lke_opd AS a
			ORDER BY a.nama_opd ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.id, 
			a.nama_opd, 
			a.create_at, 
			a.update_at
		FROM
			lke_opd AS a
			WHERE a.id = idx
			ORDER BY a.nama_opd ASC LIMIT lmtx OFFSET ofset;
	END if;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Parameter` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.id, 
			(SELECT indikator FROM lke_indikator WHERE lke_indikator.id = a.id_indikator) AS nama_indikator,
			a.nama_parameter, 
			a.id_indikator, 
			a.create_at, 
			a.update_at
		FROM
			lke_parameter AS a
			ORDER BY a.create_at, a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_parameter WHERE id = idx);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				a.id, 
				(SELECT indikator FROM lke_indikator WHERE lke_indikator.id = a.id_indikator) AS nama_indikator,
				a.nama_parameter, 
				a.id_indikator, 
				a.create_at, 
				a.update_at
			FROM
				lke_parameter AS a
				WHERE a.id = idx
				ORDER BY a.create_at, a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_indikator WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					a.id, 
					(SELECT indikator FROM lke_indikator WHERE lke_indikator.id = a.id_indikator) AS nama_indikator,
					a.nama_parameter, 
					a.id_indikator, 
					a.create_at, 
					a.update_at
				FROM
					lke_parameter AS a
					WHERE a.id_indikator = idx
					ORDER BY a.create_at, a.nums ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Penilaian_Mandiri` (`thn` VARCHAR(255), `uidx` VARCHAR(255))   BEGIN
  #Routine body goes here...
	
	SELECT
	a.id,
	a.nama, 
	a.tahun, 
	a.deskripsi, 
	a.evaluasi, 
	a.bataswaktu, 
	CONCAT(
			( 
			SELECT
				COUNT(*) AS jum
			FROM
				lke_jawaban
				INNER JOIN lke_indikator ON lke_jawaban.id_indikator = lke_indikator.id
				INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
				INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
				INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_rb ON lke_rb.id = lke_aspek.rb_id
				WHERE lke_rb.form_id = a.id AND lke_jawaban.userid = uidx AND lke_indikator.id IN (SELECT id_indikator FROM lke_parameter)
			 ),
			' dari ',
			( 
			SELECT
				COUNT(*) AS jum 
			FROM
				lke_indikator
				INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
				INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
				INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_rb ON lke_rb.id = lke_aspek.rb_id
				WHERE lke_rb.form_id = a.id  AND lke_indikator.id IN (SELECT id_indikator FROM lke_parameter)
			 ) 
		) AS kemajuan, 
	a.active
FROM
	lke_form AS a
	WHERE a.tahun = thn AND a.active = 1 AND 
	( 
			SELECT
				COUNT(*) AS jum 
			FROM
				lke_indikator
				INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
				INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
				INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_rb ON lke_rb.id = lke_aspek.rb_id
				WHERE lke_rb.form_id = a.id  AND lke_indikator.id IN (SELECT id_indikator FROM lke_parameter)
			 )  > 0
	ORDER BY a.create_at;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Rb` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE ada VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 1000;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	
	SET res = 1;
	SET msg = 'success';
	
	IF(idx IS NULL OR idx ='')THEN
		SELECT
			res,
			msg,
			(
			SELECT nama FROM lke_form 
			WHERE lke_form.id = a.form_id
			) AS nama_form,
			a.form_id,
			a.id,
			CONCAT(a.nums,'. ',a.nama) AS nama,
			a.bobot,
			a.create_at,
			a.nums,
			a.nama AS nmrb
		FROM
			lke_rb AS a
			ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		set ada = (SELECT id FROM lke_rb WHERE id = idx);
		IF (ada IS NULL) THEN
			SELECT
				res, 
				msg,
				(
				SELECT nama FROM lke_form 
				WHERE lke_form.id = a.form_id
				) AS nama_form,
				a.form_id,
				a.id,
				CONCAT(a.nums,'. ',a.nama) AS nama,
				a.bobot,
				a.create_at 
			FROM
				lke_rb AS a
				WHERE form_id = idx
				ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
				SELECT
				res, 
				msg,
				(
				SELECT nama FROM lke_form 
				WHERE lke_form.id = a.form_id
				) AS nama_form,
				a.form_id,
				a.id,
				CONCAT(a.nums,'. ',a.nama) AS nama,
				a.bobot,
				a.create_at,
				a.nums,
				a.nama AS nmrb 
			FROM
				lke_rb AS a
				WHERE id = idx
				ORDER BY a.nums ASC LIMIT lmtx OFFSET ofset;
		END if;
	END IF;
		
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Roles` ()   BEGIN
  #Routine body goes here...
	SELECT * FROM lke_roles
	ORDER BY acs ASC;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Sub_Aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			(
				SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
				INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
				WHERE lke_aspek.id =a.id_aspek
			) AS rb,
			(
				SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
				WHERE lke_aspek.id =a.id_aspek
			) AS aspek,
			a.id, 
			CONCAT(a.nums,'. ',a.nama_sub_aspek) AS nama_sub_aspek, 
			a.create_at, 
			a.update_at, 
			a.bobot, 
			(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
			a.id_aspek,
			a.nums,
			a.nama_sub_aspek AS nmsub,
			a.batas_waktu
		FROM
			lke_sub_aspek AS a
			ORDER BY rb, aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id from lke_sub_aspek WHERE id = idx LIMIT 1);
		IF (ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				(
					SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					WHERE lke_aspek.id =a.id_aspek
				) AS rb,
				(
					SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
					WHERE lke_aspek.id =a.id_aspek
				) AS aspek,
				a.id, 
				CONCAT(a.nums,'. ',a.nama_sub_aspek) AS nama_sub_aspek, 
				a.create_at, 
				a.update_at, 
				a.bobot, 
				(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
				a.id_aspek,
				a.nums,
				a.nama_sub_aspek AS nmsub
			FROM
				lke_sub_aspek AS a
				WHERE id = idx
				ORDER BY rb, aspek, a.nums  ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id from lke_aspek WHERE id = idx LIMIT 1);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					(
						SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama ) FROM lke_rb 
						INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
						WHERE lke_aspek.id =a.id_aspek
					) AS rb,
					(
						SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
						WHERE lke_aspek.id =a.id_aspek
					) AS aspek,
					a.id, 
					CONCAT(a.nums,'. ',a.nama_sub_aspek) AS nama_sub_aspek, 
					a.create_at, 
					a.update_at, 
					a.bobot, 
					(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
					a.id_aspek,
					a.nums,
					a.nama_sub_aspek AS nmsub,
					a.batas_waktu
				FROM
					lke_sub_aspek AS a
					WHERE a.id_aspek = idx
					ORDER BY rb, aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	
	END IF;
			
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_sub_sub_aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 1000;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			(
			SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
			INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS rb,
			(
			SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS aspek,
			
			(
			SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS nama_sub_aspek,
			
			a.id, 
			CONCAT(a.nums, '. ',a.nama_sub_sub_aspek) AS nama_sub_sub_aspek, 
			a.create_at, 
			a.update_at, 
			a.id_sub_aspek,
			(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator, 
			a.bobot,
			a.nama_sub_sub_aspek AS nmsusub,
			a.nums
		FROM
			lke_sub_sub_aspek AS a
			ORDER BY rb, aspek, nama_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id from lke_sub_sub_aspek WHERE id = idx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				(
					SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS rb,
					(
					SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS aspek,
					
					(
					SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS nama_sub_aspek,
				a.id, 
				CONCAT(a.nums, '. ',a.nama_sub_sub_aspek) AS nama_sub_sub_aspek, 
				a.create_at, 
				a.update_at, 
				a.id_sub_aspek, 
				(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator,
				a.bobot,
				a.nama_sub_sub_aspek AS nmsusub,
				a.nums
			FROM
				lke_sub_sub_aspek AS a
				WHERE id = idx
				ORDER BY rb, aspek, nama_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_sub_aspek WHERE id = idx LIMIT 1);
			IF (ada IS NOT NULL) THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					(
						SELECT CONCAT(lke_rb.nums,'. ',lke_rb.nama) FROM lke_rb 
						INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
						INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
						WHERE lke_sub_aspek.id = a.id_sub_aspek
						) AS rb,
						(
						SELECT CONCAT(lke_aspek.nums,'. ',lke_aspek.nama_aspek) FROM lke_aspek 
						INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
						WHERE lke_sub_aspek.id = a.id_sub_aspek
						) AS aspek,
						
						(
						SELECT CONCAT(lke_sub_aspek.nums,'. ',lke_sub_aspek.nama_sub_aspek) FROM lke_aspek 
						INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
						WHERE lke_sub_aspek.id = a.id_sub_aspek
						) AS nama_sub_aspek,
					a.id, 
					CONCAT(a.nums, '. ',a.nama_sub_sub_aspek) AS nama_sub_sub_aspek, 
					a.create_at, 
					a.update_at, 
					a.id_sub_aspek, 
					(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator,
					a.bobot,
					a.nama_sub_sub_aspek AS nmsusub,
					a.nums
				FROM
					lke_sub_sub_aspek AS a
					WHERE a.id_sub_aspek = idx
					ORDER BY rb, aspek, nama_sub_aspek, a.nums ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_UploadFile` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `idind` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET ada = (SELECT FullName FROM lke_user WHERE uid = uidx);
		IF(ada IS NULL) THEN
			SET res = 0;
			SET msg = 'Data Tidak ditemukan.';
			SELECT res, msg;
		ELSE
			SET ada = (SELECT id FROM lke_indikator WHERE id= idind);
			IF (ada IS null) THEN
				SET res = 0;
				SET msg = 'Data Tidak ditemukan.';
				SELECT res, msg;
			ELSE
				SET res = 1;
				SET msg = 'success';
				SELECT
					res,
					msg,
					a.files,
					a.id AS idfiles, 
					b.bukti_dukung,
					b.id AS idbukti,
					c.id AS idind,
					a.userid,
					(SELECT FullName FROM lke_user WHERE uid = a.userid) AS userName
				FROM
					lke_upload_bukti AS a
					INNER JOIN lke_bukti_dukung AS b ON a.id_bukti = b.id
					INNER JOIN lke_indikator AS c ON b.id_indikator = c.id
					WHERE a.userid = uidx AND c.id = idind
					ORDER BY c.nums, b.nums ASC LIMIT lmtx OFFSET ofset;
			END IF;
		END IF;
	ELSE
		SET ada = (SELECT FullName FROM lke_user WHERE uid = uidx);
		IF(ada IS NULL)THEN
			SET res = 0;
			SET msg = 'Data Tidak ditemukan.';
			SELECT res, msg;
		ELSE
			SET ada = (SELECT id FROM lke_indikator WHERE id= idx);
			IF(ada IS NULL)THEN
				SET res = 0;
				SET msg = 'Data Tidak ditemukan.';
				SELECT res, msg;
			ELSE
			
				SET ada = (SELECT files FROM lke_upload_bukti WHERE id = idx AND userid = uidx);
				IF(ada IS NULL) THEN
					SET res = 0;
					SET msg = 'Data Tidak ditemukan.';
					SELECT res, msg;
				ELSE
					
					SET res = 1;
					SET msg = 'success';
					SELECT
						res,
						msg,
						a.files,
						a.id AS idfiles, 
						b.bukti_dukung,
						b.id AS idbukti,
						c.id AS idind,
						a.userid,
						(SELECT FullName FROM lke_user WHERE uid = a.userid) AS userName
					FROM
						lke_upload_bukti AS a
						INNER JOIN lke_bukti_dukung AS b ON a.id_bukti = b.id
						INNER JOIN lke_indikator AS c ON b.id_indikator = c.id
						WHERE a.id = idx AND a.userid = uidx
						ORDER BY c.nums, b.nums ASC LIMIT lmtx OFFSET ofset;
			
				END IF;
			END IF;
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`surabe2`@`%` PROCEDURE `View_Users` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	IF (lmt REGEXP '^-?[0-9]+$') THEN
		SET lmtx = lmt;
	ELSE
		SET lmtx = 200;
	END IF;
	IF (ofst REGEXP '^-?[0-9]+$') THEN
		SET ofset = ofst;
	ELSE
		SET ofset = 0;
	END IF;
	IF(idx IS NULL OR idx ='')THEN
		SET res = 1;
		SET msg = 'success';
		SELECT
				res, msg,
				a.uid,
				a.UserName,
				a.FullName,
				a.Phone,
				a.EmailAdds,
				a.Create_at,
				b.RoleName,
				IF(e.nama_opd IS NULL,'-',e.nama_opd ) AS nama_opd,
				a.actv
			FROM
				lke_user AS a
				INNER JOIN lke_role AS c ON a.uid = c.Uid
				INNER JOIN lke_roles AS b ON c.RoleId = b.RoleId
				LEFT JOIN lke_detail_opd AS d ON a.uid = d.userid
				LEFT JOIN lke_opd AS e ON d.opdid = e.id
				ORDER BY b.acs ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
				res, msg,
				a.uid,
				a.UserName,
				a.FullName,
				a.Phone,
				a.EmailAdds,
				a.Create_at,
				b.RoleName,
				IF(e.nama_opd IS NULL,'-',e.nama_opd ) AS nama_opd,
				a.actv
			FROM
				lke_user AS a
				INNER JOIN lke_role AS c ON a.uid = c.Uid
				INNER JOIN lke_roles AS b ON c.RoleId = b.RoleId
				LEFT JOIN lke_detail_opd AS d ON a.uid = d.userid
				LEFT JOIN lke_opd AS e ON d.opdid = e.id
				WHERE a.Uid =idx
				ORDER BY b.acs ASC LIMIT lmtx OFFSET ofset;
	
	END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`surabe2`@`%` FUNCTION `EncPass` (`psxc` VARCHAR(255)) RETURNS VARBINARY(255)  BEGIN
  #Routine body goes here...
	DECLARE EncPs VARBINARY(255);
-- 	SET EncPs = AES_ENCRYPT(psxc,UNHEX(SHA2('EVALUASISPBEOPD2025',256)),'E31C32B22EA452B0F2959E296827CE59');
	SET EncPs = AES_ENCRYPT(psxc,UNHEX(SHA2('EVALUASISPBEOPD2025',256)),'', 'hkdf','JAN2025', 'DISKOMINFOSULTENG' );
RETURN EncPs;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lke_aspek`
--

CREATE TABLE `lke_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penilaiid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rb_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_aspek`
--

INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `penilaiid`, `rb_id`, `nums`) VALUES
('47116ecef80d2b99adafd531a5bd9070746c7f5c', 'Strategi Membangunan RB Tematik', '2025-06-13 10:12:08', NULL, '100', NULL, 'd3477629f57db96c6819ab2887528ee80b810e91', 'A'),
('5b7bbdd04ecbd22db45c48f5b18c8b03f52c3699', 'Capaian Dampak RB Tematik', '2025-06-13 10:14:50', NULL, '100', NULL, 'd3477629f57db96c6819ab2887528ee80b810e91', 'B'),
('a10caed3d3670153b16cde164bbf348fd2ce643a', 'Capaian Pelaksanaan Kebijakan RB', '2025-06-10 19:58:14', NULL, '100', NULL, '41f64d8b77d2170f551799a3cc3b38e9e8e1aae8', 'B'),
('ac40ca513bf374d82b4540e1aab40a64abeb5045', 'Capaian Strategis Pelaksanaan RB General', '2025-06-11 10:37:47', NULL, '100 ', NULL, '41f64d8b77d2170f551799a3cc3b38e9e8e1aae8', 'C'),
('c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', 'Capaian Sasaran Strategis', '2025-06-10 19:57:43', NULL, '100', NULL, '41f64d8b77d2170f551799a3cc3b38e9e8e1aae8', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `lke_bobot`
--

CREATE TABLE `lke_bobot` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot_akhir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lke_bukti_dukung`
--

CREATE TABLE `lke_bukti_dukung` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_dukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_bukti_dukung`
--

INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`, `nums`) VALUES
('01d2ff65ecacca35c2528792ea327a196821491d', '26bb65c06a82d70329ae01ac36be312c38974880', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi) ', '2025-06-20 09:57:14', NULL, '2'),
('022cc146f1d13e02480ea374e094289251f77caa', '7791f5c1e867947c05b7761ad4cf5673e5cda607', 'Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah', '2025-06-16 10:37:36', NULL, '1'),
('031559ec7f5f16de3b455b62446743ec9ccab32b', '222918ef0072144df43126dd42d8946bfe37329e', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 10:00:02', NULL, '3'),
('0423569ca987a865d42636e2650d6250aff84c3c', '3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', 'Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-06-13 11:41:47', NULL, '1'),
('05337b25e3ba7ed4dfdea894362c1391da088529', '1462e56acf3115229e54b5930b24730eb5613efc', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)  ', '2025-06-20 10:01:51', NULL, '2'),
('07b46bd6f6aa1d5ff1a5027ac2628d67c721095e', '38c860642d8faf7029945cb902fb9beaf59f8a15', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 09:15:50', NULL, '3'),
('07db99344d4e1ae46dc39addfd02af2cd4857fd6', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', 'SK Penetapan oleh Kepala Unit terkait Kriteria Penerima Penghargaan (Umumnya dilihat dari Kinerja Pegawai, Kehadiran, Kerjasama tim, memiliki inovasi, berpenampilan menarik ataupun belum pernah mendapat komplain dari penerima layanan)', '2025-06-20 14:53:02', NULL, '1'),
('08563c855d26fd4e0f151d7b0b813ca6797b654e', 'bdfdfe3ff3f049f04205f465b68af41adab5f10d', 'Berita Acara Tindaklanjut Hasil Pemeriksaan/ Laporan Rekapitulasi Tindaklanjut Hasil Pemeriksaan yang di keluarkan oleh BPK RI', '2025-06-20 09:09:47', NULL, '1'),
('08d1e20ff227a7d627448374f8626592571de5ef', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata)', '2025-06-19 14:01:53', NULL, '4'),
('091ff1aec539357a2147b740629b80bb125c1004', '3de9a291fe5be48c4d41d62d7e3598137675151a', 'Screenshot Pencatatan paket transaksional pada Toko Daring pada SPSE pada SPSE atau Laporan Pencatatan paket transaksional pada Toko Daring pada SPSE', '2025-06-16 10:34:50', NULL, '1'),
('0c2396237222aa901fa08bc9357547f48d8a759d', 'c198acc0217854f3958d6a4f4969260c1934a185', '1. SK Launching / Penetapan Pelaksanaan Inovasi', '2025-06-20 14:43:33', NULL, '1'),
('0c747fafa307d022f58abb5131aa09ad11ce9918', '1672b51208686e126770604c791bfd67d0ea7dcc', 'etersediaan Fasilitas Front Office  (Petugas Khusus, Meja/Kursi, Layar Display Informasi, Bahan Cetak Informasi layanan, serta Register Tamu baik manual maupun elektronik)', '2025-06-20 15:00:03', NULL, '1'),
('0c776fc365196f76b787d38a38bb04a73ae00708', 'da31f7996d51add8aa2dda4aeb587896bd9af816', 'Ketersediaan Sarana pada ruang Konsultasi dan Pengaduan, berupa Kotak Saran, Ruang Khusus, Petugas Khusus, Air Minum, Register Tamu, serta publikasi terkait informasi mekanisme konsultasi pengaduan (dapat berupa poster/spanduk/buku/bahan cetak lainnya)', '2025-06-20 14:54:09', NULL, '1'),
('0c9ac4ce21e0e306aad774b1c942d81f3026ae7d', '8419f961c95170927dc5a0221dd924eedf99569b', 'Dokumen Rancangan Perda/ Perkada Hasil Evaluasi', '2025-06-11 22:59:48', NULL, '4'),
('0cf9d60906e45048de99bc88914179d85685bee7', '8419f961c95170927dc5a0221dd924eedf99569b', 'Surat Keputusan/Naskah Dinas Penetapan Propemperda', '2025-06-11 22:58:24', NULL, '1'),
('0da661f76b32aef4833d39b6f9a6fbb1dc5022a5', 'b2b39157592e921b7a4893ec51e37e01688327dc', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                                     2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dok', '2025-06-20 09:35:51', NULL, '1'),
('0f061e37e36bf521d5847d99ccbd09c3cfcbbbf5', '1ff16ba78f665f700312c31ca80da58389e7a81b', 'Telah mengisi form  pembangunan / pengembangan aplikasi di lingkungan Pemerintah Provinsi Sulawesi Tengah ', '2025-06-13 11:32:30', NULL, '1'),
('0f7fd1c745939b6676ba0f39baf820f92c44d9c5', '479b03a54d5860c3494d9986e39767088a6ba472', 'Screenshot Pemanfaatan SIAP Sulteng dan menu-menu layanan kepegawaian di dalam SiAP Sulteng (untuk PD lain)', '2025-06-13 11:49:22', NULL, '1'),
('13177d897e52b79e31b6b0afef85c657a7bb9cba', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi) ', '2025-06-20 14:32:28', NULL, '2'),
('13fc09734e4d631364133b590cdfd05727645174', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 14:38:43', NULL, '3'),
('141cedcfd21187746db0d788ca211da8fd43f7e4', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 10:05:52', NULL, '4'),
('143680a56ab509c5b595bce890d100fbd11b92fe', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', 'Ketersediaan Fasilitas Ruang Tunggu, dibagi menjadi Fasilitas Wajib (Kursi Tunggu dan Pendingin/sirkulasi ruangan) dan Fasilitas Penunjang (Mesin Antrian, TV, Bahan Bacaan, Pengisi Daya, Wifi, Air Minum dll)', '2025-06-20 14:56:52', NULL, '1'),
('15b75098ed601e97dfabd1487af7024ce7593c84', '0133e2eaecfbdd0b86264e90740661739847444a', 'Ketersediaan Fasilitas Sarpras bagi Kelompok Rentan sesuai dengan Surat Edaran Menteri PANRB Nomor 66 Tahun 2020', '2025-06-20 14:58:28', NULL, '1'),
('191941f99b2f8fdf3643f421407194fae4f8a201', '23f08c7833dcc8775fc86ac0682e7d2472af3267', 'Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll', '2025-06-19 10:22:45', NULL, '2'),
('1b026886d0f1a133e203ddca22a41065637b1d09', '773967cf70fb968c9e52d268d06c1e6abdc530e6', 'Screenshot media konsultasi pengaduan maupun keterhubugan Instansi dengan SP4N Lapor diambil dari tampilan login admin', '2025-06-20 14:56:50', NULL, '1'),
('1d345ce498e8207e24351b6f29aa3e075bfd88fa', '02e0b378b75ccaeba97fb2a141e64480c5447297', 'Laporan Rekapitulasi Jumlah penyelesaian pengaduan pada aplikasi SP4N-LAPOR/ screenshot Jumlah Penyelesaian Pengaduan pada SP4N-LAPOR', '2025-06-11 23:04:46', NULL, '1'),
('1deea1b8d59bde297ec61608e58254b16b4ef629', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '1. SK/Peraturan yang berlaku terkait Penetapan Jam Kerja (Hari Kerja, Penambahan waktu diluar jam kerja ataupun kondisi tertentu)', '2025-06-20 14:39:41', NULL, '1'),
('1f73ceb3202bc5d16d721fcfe191e9307b855972', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 14:36:45', NULL, '5'),
('212576b2181c568b72d409d5624d2de18c432599', '26dabc885d6a369ceab60d138385533a50a22958', 'LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal', '2025-06-20 09:05:36', NULL, '1'),
('21a5bbd5b7d7f61f4b4136396a999dfc0721e5f0', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', 'Ketersediaan Fasilitas Penunjang (Fotokopi/ATK, Kotak P3K, APAR, Kantin, Ruang Ibadah, Area Merokok, Jalur Evaluasi, Tempat Sampah dan CCTV)', '2025-06-20 14:59:22', NULL, '1'),
('22b532953deed70e00dda67562802630f6c4ec24', 'a92b34d679d1c6f6e5aecc60bf20e8819b4c33b1', 'Screenshot Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE atau Laporan Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE yang dikeluarkan oleh Biro PBJ', '2025-06-16 10:33:42', NULL, '1'),
('26170f4ba8486004b7a6888430f21cec1a1c1fd8', '333624b6008c5fda79189d98f043ec0763db0355', 'Laporan Rekapitulasi rata-rata lama hari penyelesaian pengaduan pada aplikasi SP4N-LAPOR/ screenshot rata-rata lama Penyelesaian Pengaduan pada SP4N-LAPOR', '2025-06-11 23:05:14', NULL, '1'),
('28036da77de8bb42ebe947a66db1ea65ae15bff3', 'a9069b289f2e0f78afa7d4ac8c6a98975e03e886', 'SK atau SP Tim Pengelola SP4N -LAPOR yang telah di formalkan oleh Kepala Perangkat Daerah', '2025-06-11 23:01:11', NULL, '1'),
('297951707abd97dbde847f90dcfb918fd1d0e240', '38c860642d8faf7029945cb902fb9beaf59f8a15', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 09:16:19', NULL, '4'),
('2c8163c7ed826276faa15aa0f457fe21569a8094', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 14:33:00', NULL, '3'),
('2c9820276ab2c3b5b8d235dc4c533c9e4570632f', 'b5c441f52388bcbb8ee5b4b1ac6dae1ff1da918e', 'Screenshot Pemanfaatan Aplikasi SPIP', '2025-06-13 11:51:35', NULL, '1'),
('2c9d7575d45414a9b1e4134f3859cee832d27a19', '54a6147d981a7d176e0c5dd43705569ba6db34fe', 'Dokumen Manajemen Data PD (List user, log aktivitas, dataset PD)', '2025-06-13 11:45:52', NULL, '1'),
('2e7c4298f952bcdff9a5de2f8be3f510ddbc320c', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', 'Notulensi', '2025-06-11 22:51:55', NULL, '3'),
('2edf5d1b6c6d645bfe853de2199f7ffbb359214c', '6aee4cc780191317ea55ac6e0cf353f0a1588182', 'Screenshot Pemanfaatan SIPD (Perencanaan)', '2025-06-13 08:34:55', NULL, '1'),
('2ef75aeb39e10bd5f3640de9c61ca40d0cf6f8a3', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', 'Ketersediaan Fasilitas Penunjang (Fotokopi/ATK, Kotak P3K, APAR, Kantin, Ruang Ibadah, Area Merokok, Jalur Evaluasi, Tempat Sampah dan CCTV)', '2025-06-20 14:59:06', NULL, '1'),
('312ac44c2fd8cdabf573c64c46d18c0c03a439cb', '356adee25a1526c8f6deafff1ec564ad5a407623', 'Raport Kinerja Perangkat Daerah pada Lingkup Sekretariat Perangkat Daerah', '2025-06-16 10:42:08', NULL, '1'),
('333e4ef8551b115ffd4a3f20cd7f268c7c4cdb68', 'b3050198a0311b2fd1e1521bda8cecd00f63d4e4', 'Berita Acara Hasil Survey Implementasi Kamus Kompetensi ASN BerAKHLAK Tahun Sebelumnya/Tahun Berjalan', '2025-06-19 14:27:29', NULL, '1'),
('33735e9eccd6bf979935cce9c4052da74582566a', '18bcf56fc86cf0bacb9716b241247e385b294376', 'SK Pembentukan Panitia Antar Perangkat Daerah', '2025-06-11 22:47:50', NULL, '1'),
('3452af56c84f72cda5c5260ec1301fa021137553', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)  ', '2025-06-20 09:15:27', NULL, '2'),
('35f7c396e32d2395d659c73d530560e089da5343', '5c8040f3ac32bd6e074d0897d3d130d41ac839d2', 'Screenshot Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering atau Laporan Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering yang dikeluarkan oleh Biro PBJ', '2025-06-16 10:32:38', NULL, '1'),
('3665fbd5b26663d195bfeb6f26cda0a238fc224d', 'd19c3e6ed374d12a978546f90608c9d155d319bd', 'Screenshot Pemanfaatan SIPD (Penganggaran)', '2025-06-13 10:58:34', NULL, '1'),
('3757a369a527138842b6e26095b4886c1c99a23a', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', 'Screenshot  dari Sistem Informasi yang dimiliki (SIPPN)', '2025-06-20 14:59:08', NULL, '1'),
('37994d5d18948e6e41769e7dd85080fb574d7641', 'dc396ec8de0dba70307b0bf352b614202622f75e', 'Laporan Rekapitulasi Jumlah pengaduan pada aplikasi SP4N-LAPOR/ screenshot Jumlah Pengaduan pada SP4N-LAPOR', '2025-06-11 23:04:19', NULL, '1'),
('3c5a38ce0fa94b00cb25d1f10502b53f3a7a087b', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)  ', '2025-06-20 10:04:26', NULL, '2'),
('3d8b9189018f2e01f4dafb0b24b07ed293c67582', '23f08c7833dcc8775fc86ac0682e7d2472af3267', 'Screenshot media Publikasi SP4N-LAPOR pada website, media sosial;', '2025-06-19 10:22:14', NULL, '1'),
('420d84acf7aacb3da2fbb7780654e94b9ff1e762', '4c8378c214c94d9085e88f953e0199ba8feae24c', 'Laporan Hasil TIndak Lanjut Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Sebelumnya', '2025-06-20 09:04:04', NULL, '1'),
('45c7cd45be5b86782b48de14910d44ed3c877d98', '26bb65c06a82d70329ae01ac36be312c38974880', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 09:58:21', NULL, '5'),
('4ad5f7bcbdde5442e11445927c501ce6abceaae6', '397a7dbe2fd7b34ab6ebed2a09fee9c3ded5d8d5', 'Screenshot Pemanfaatan SRIKANDI', '2025-06-13 11:50:22', NULL, '1'),
('4ba2b02a22cae301fecde076fe1aed8d5812b15c', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2. Sarana dan Prasarana (Dokumentasi Sarpras pendukung inovasi)', '2025-06-20 14:51:39', NULL, '2'),
('4df131411d642893655b3a9f3b3fa9228276b065', '26bb65c06a82d70329ae01ac36be312c38974880', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 09:57:38', NULL, '3'),
('4f582709611736f2cd37f5f277a4fdf14f36bae1', '4c8378c214c94d9085e88f953e0199ba8feae24c', 'Laporan Hasil TIndak Lanjut Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Sebelumnya', '2025-06-20 09:03:55', NULL, '1'),
('4f655b5f2b0df64318fef8b14fe147942d2599bb', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '3. SDM (SK Perorangan dan /atau tim yang menginisiasi penciptaan inovasi ', '2025-06-20 14:52:00', NULL, '3'),
('50086cc6eb5c2d931dae694cf8ec607341a1a530', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 10:06:08', NULL, '5'),
('521a473688f83514378b621f8fe21e23368b2f60', '9d065032e5205e2ac9d88a57f95608179707ec61', 'SK Tim Analisis dan Evaluasi Hukum terhadap Produk Hukum Perda/Perkada', '2025-06-11 22:57:09', NULL, '1'),
('529920ba4a1855c001372c35869b78cc572984a2', '5fc1fe493b1f677a1075171f6248fe5f0c620e40', 'LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal', '2025-06-20 09:06:11', NULL, '1'),
('532af6d2f871632cc423ba497c0c390b5d70892d', '1462e56acf3115229e54b5930b24730eb5613efc', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017okumentasi)  ', '2025-06-20 10:02:13', NULL, '3'),
('54f792ab62f262a04773c7968f61f3ada9852df8', '38c860642d8faf7029945cb902fb9beaf59f8a15', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014   ', '2025-06-20 09:14:56', NULL, '1'),
('56b67d34918379c203412143900b36c91d73eac0', '936328e1dfe004e577c7e26d41681bd365fc6f09', 'LHE Penilaian Kearsipan Internal (LAKI) Masing-masing perangkat daerah yang dikeluarkan oleh Dinas Perpustakaan dan Kearsipan Daerah ', '2025-06-16 09:27:14', NULL, '-'),
('56f9e833c5a9847218d772a037ab5a6dab4c845f', '413464b84908505e7d4fcbe8e802d6a44da902b4', 'Penyampaian 1 buah \"Praktek Baik\" Tata Kelola Pemerintahan Berbasis Elektronik (Digital Services)/ layanan administrasi pemerintah berbasis elektronik dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet dikemas secara informatif dan menarik)', '2025-06-19 09:21:47', NULL, '1'),
('585efdfe235b98a650a95fcdc1d031929761fc08', 'ec38526ca158862acf6403a395e855c723391f5d', 'Screenshot Pemanfaatan SPSE', '2025-06-13 11:48:50', NULL, '1'),
('5d8c691194280486db75ee878ce3119629e32930', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)', '2025-06-20 14:35:53', NULL, '2'),
('5e028698a607f9201382101d05ebb9f96afd1cf7', '8419f961c95170927dc5a0221dd924eedf99569b', 'Surat Keputusan/Naskah Dinas Pengusulan Perubahan/Pencabutan/ Penggabungan Perda/Perkada hasil evaluasi', '2025-06-11 22:59:35', NULL, '3'),
('5f7d2a33313773c8e850fa2d810c072b4ac1bccf', '72c74e606e4d873d6f94f0030a06946590352cbc', 'Screenshot  dari Sistem Informasi Pendukung Layanan (SP4N Lapor!, SKM, Website  Pengelola Kepegawaian, FAQ, Pengelolaan keuangan pelayanan publik bagi layanan berbayar)', '2025-06-20 14:59:57', NULL, '1'),
('60dd8f6721d6a329cfd8cac420669c47a1861a7c', 'cc426e33d29c9393353bc051ba24720a1709a2af', 'Dokumentasi Pelaksanaan Kegiatan Peningkatan Motivasi, antara lain dengan pemberian penghargaan, pemberian kesempatan mengikuti diklat, beasiswa, konseling, maupun mekanisme lainnya yang dapat meningkatkan motivasi kerja pegawai', '2025-06-20 14:52:18', NULL, '1'),
('60f9f625e17c0436e7db5790e05b7fc02cc9c437', 'bdc31064087319d26c08507f5f3dbaaaa8d5205c', 'Naskah Akademik/ penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:47:28', NULL, '1'),
('61211899629259e616868195facc28d99d353a70', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)', '2025-06-20 14:38:22', NULL, '2'),
('6384bf4a79c00181bef810e22542de4a24c664bb', '28a5d1b98409915a3b0e821647d8477e8687b4d7', 'Rancangnan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:48:19', NULL, '1'),
('63dbb35944a9f2b081e5cc75905eeec88917aebe', 'abdcb370678c9efebdae43a6d0edd6ef227f3aca', 'Alokasi anggaran TIK diselaraskan antara roadmap dengan renstra', '2025-06-11 15:00:02', NULL, '1'),
('64ec9ee4a68c65c28b9f79fbbac83d8c5f3f3d87', '124e174eab918098602fc8b5c503877d45dc8037', 'Berita Acara Tindaklanjut Hasil Pemeriksaan/ Laporan Rekapitulasi Tindaklanjut Hasil Pemeriksaan yang dikeluarkan oleh Inspektorat', '2025-06-20 09:10:27', NULL, '1'),
('66575b2958348fb637e6d271983021dbe7ea0c70', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '1. Dokumen Penetapan (SK) terkait Kode Etik (Dengan unsur meliputi Hak & Kewajiban, Larangan KKN, Larangan Diskriminasi, Sanksi dan Penghargaan)', '2025-06-20 14:45:15', NULL, '1'),
('68fbe1152b795493b08874fa5a866568d8037e03', '222918ef0072144df43126dd42d8946bfe37329e', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 10:00:23', NULL, '4'),
('69e1138870bda650337a937a2c7019bac06d519e', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 14:39:12', NULL, '5'),
('6b412f9c7d5ec214d01dfafb59403ebb4154414a', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', 'Bentuk Pelembagaan Inovasi 1. Anggaran (Bahwa Inovasi tersebut dianggarkan)', '2025-06-20 14:45:39', NULL, '1'),
('6de6dce5321322bbab13a0b53a95a6b05b19d761', '222918ef0072144df43126dd42d8946bfe37329e', '2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)', '2025-06-20 09:59:41', NULL, '2'),
('6e43fa30276d9a2bcd79cc8ed9d31d801dfb734e', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', 'Daftar Hadir Pimpinan Tinggi Pratama', '2025-06-11 22:51:42', NULL, '2'),
('6e9a63e19ba01d67b3b87e03420272829d737a9c', 'b3f348e5efc8ef54cff7d945a876410e1b329641', 'Dokumen metadata IKU Perangkat Daerah sesuai dengan Peraturan BPS no. 5 Tahun 2020 tentang Petunjuk Teknis Metadata Statistik', '2025-06-13 11:58:02', NULL, '1'),
('6f118e1ffca96d8c9ce07da731c0d9e48c3d8e78', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', 'Ketersediaan fasilitas toilet (terpisah laki-laki/perempuan), wastafel, toiletries, air bersih serta terdapat SK petugas membersihkan toilet', '2025-06-20 14:57:42', NULL, '1'),
('6f18d51daa38c3f3ff28a4e1031ce129443b3e67', '2017b67bb7ec425721f4f39badb0cc1766dd6359', 'Dokumen Manajemen Risiko SPBE PD', '2025-06-13 11:42:50', NULL, '1'),
('70166ea29e553c36167a0c79f4e7ab8d72b47510', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', 'Undangan Rapat', '2025-06-11 22:51:24', NULL, '1'),
('71bcd7f41f07b72623a6dbdf9a241498a46a3740', 'e235d1e25296c5f4a241e55993abcb72b24ee4b9', 'Screenshot progres pelaksanaan penggunaan  produk dalam negeri  pada Pengadaan Barang/Jasa Pemerintah melalui aplikasi SIPD P3DN dan Aplikasi Bigbox LKPP', '2025-06-19 11:32:12', NULL, '1'),
('75686231e759750b56f8ee5efd26cd31afd2976f', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', 'Laporan Kinerja Instansi Pemerintah (LKIP) Perangkat Daerah Tahun sebelumnya', '2025-06-20 09:08:28', NULL, '1'),
('7b6dd51b5ad04714432fe190724a5db287e4fc9c', '29cf25bb5ea0d1b0c8ef68c1e401765ba6d6651f', 'Cascading Kinerja Sekretariat Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah ', '2025-06-16 10:41:26', NULL, '1'),
('7ced41e753db0a2b0d2b4490d0cc2dbcb349887f', '89a3cfcafdb60bf04616631ab63464418ff7367c', 'LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal', '2025-06-20 09:07:21', NULL, '1'),
('859d2c3b337604f37f612828f70ef75f1c95386a', 'fb090dae0186365c93dd6a97bee9fc96fe7ac3fb', 'List data prioritas dari masing-masing Perangkat Daerah (dari Bappeda)', '2025-06-13 11:58:24', NULL, '1'),
('8907d85aff9358bc25d6d86a1b63f5d57f2f4105', '45cf18e926282fc9b3211f0428052fbb760c2583', 'Surat Permohonan pengusulan Pembentukan Peraturan Daerah/ Peraturan Kepala Daerah', '2025-06-11 22:46:24', NULL, '1'),
('8933d88e9f86810e9487146b4a8ad88a05d35aad', '4cc7c0d2808515a7deb6b967a47d749eddf4ca61', 'Dokumentasi pengembangan layanan berbasis elektronik (sesuai siklus SDLC, manualbook, vidio penggunaan)', '2025-06-13 11:55:30', NULL, '1'),
('899e590cfbeb89def147ad82ab8059e98393f131', '2b7af354328c5e03b48e33a9e62978f4b0124629', 'Dokumen atau Screenshoot bukti pengelolaan pengaduan, jika tidak terdapat pengaduan melalui SP4N LAPOR, sarana ini dapat dimanfaatkan untuk pengelolaan konsultasi pengaduan secara manual guna mempermudah rekap konsultasi dan pengaduan', '2025-06-20 14:57:25', NULL, '1'),
('8a9b0ee4f2e683ca146f649630615c940357552c', '222918ef0072144df43126dd42d8946bfe37329e', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014 ', '2025-06-20 09:59:21', NULL, '1'),
('8ac8c3122b516ab507f739bd63d697788f1d74d7', 'b0458145e51457abbcecfa494984e96c16d041a6', 'Berita Acara Capaian Kinerja APBD Tahun Berjalan', '2025-06-20 09:12:32', NULL, '1'),
('8b3f8ea806665dc9a7af7f46e70dbdf0b9c8732b', 'c6ddd5c9cfb225fc4881f98607ebc677a34fd715', 'Surat Perintah Tim Pengelola TIK/SPBE/Tim Layanan Digital', '2025-06-13 11:42:24', NULL, '1'),
('8caeb848087c1862d53730b8bb220d9d91e568db', '31328f434366f016ada5b7ce753da81b9887fda0', 'Screenshot  Pemutakhiran/Unggahan Berkala yang dilakukan oleh Unit Pelayanan', '2025-06-20 15:00:59', NULL, '1'),
('94657920c8af1d0493e04ba1c8f88cc9401aec25', 'd823766c948a1c8dc2c4fd700e48889192782492', 'Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN ', '2025-06-13 11:57:35', NULL, '1'),
('94f5fbd2917184ed983b50ada76cadee74b703c0', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 14:36:10', NULL, '3'),
('9537026dca78938bde2304f4f4479f5b04d8e51e', '6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', 'Identifikasi inovasi berbasis TIK baru yang berbeda dengan proses bisnis sebelumnya', '2025-06-13 11:31:34', NULL, '1'),
('963644d4216e89f9c185f309701df71a67d067cd', '060245c55fa1cdda77c0639b1978131ba5cab3dc', 'Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD', '2025-06-16 08:36:25', NULL, '1'),
('974438b367d9bd6bc6de80fe7b46c760d2b54cd7', 'f56c31c955255c249de67a93de07093489b5f250', 'Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah', '2025-06-16 10:38:45', NULL, '1'),
('99550ca15d48f8fabad18ebd9c278b7f775fab7f', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4. 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta', '2025-06-19 13:58:39', NULL, '2'),
('9a0175ee467c92806f55a02dd38e5b55505f1e33', '534b4f1b17fb66a0934dd6de2965307b36fdfd94', 'Screenshot Pemanfaatan eKinerja dan KMOB', '2025-06-13 11:53:37', NULL, '1'),
('9b3636054d3708d4889175431eb2b344bd8e4475', '054a031448fee205ada507d5fa566fd9e001bc70', 'Ketersediaan Fasilitas Parkir antara lain Parkir Roda 2 dan Roda 4 yang terpisah dan diberi marka, petugas perkir jika ada, karcis parkir, CCTV, penitipan jaket/helm, dan  Kanopi', '2025-06-20 14:56:07', NULL, '1'),
('9c6049652f8158739533e305af207f47264400f3', '26bb65c06a82d70329ae01ac36be312c38974880', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 09:57:59', NULL, '4'),
('9feb28a7a3bf8bc08c825a050b6233438882f444', 'e0c4526e75ba296f19f1472590d0baf1f9b64e29', 'Nota Dinas, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Jaringan Intra Pemerintah Daerah, Laporan Pemanfaatan ', '2025-06-13 11:34:53', NULL, '1'),
('a17adeba9080bb396d876372a378964c1473aa69', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014  ', '2025-06-20 10:04:09', NULL, '1'),
('a2cb4899ed733504069e5265dddbf4adcb567594', '4581da6e1cc226decb6a880b7d4b68e1b553a520', 'Cascading Kinerja Penyelenggaraan urusan yang menjadi core Bisnis Perangkat Daerah pada Bidang Teknis Perangkat Daerah', '2025-06-16 10:43:11', NULL, '1'),
('a5012bff0f7948339b11f0d6e8298eacdf3b62b9', 'bf29c2c0ebb5bf5f234eb273a94f4bfc198e2f3f', 'Buku Laporan Realisasi Akhir APBD Tahun Sebelumnya', '2025-06-20 09:11:45', NULL, '1'),
('a545414d3973c500bb8de04f03ba89a387564b52', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP)', '2025-06-19 14:01:32', NULL, '3'),
('aaff513a9f2f58babc90388b49b0a4e2c3ee8054', '9d065032e5205e2ac9d88a57f95608179707ec61', 'Laporan Hasil Evaluasi Produk Hukum Perda/Perkada', '2025-06-11 22:57:23', NULL, '2'),
('ad9444da212ab0105df4b5c570d7bf748459a8a0', '4b3401518bf31cce72ee049f1d8f63a440b13e0c', 'Screenshot Pencatatan Paket e- Purchasing pada Katalog Elektronik atau Laporan Pencatatan Paket e- Purchasing pada Katalog Elektronik yang dikeluarkan oleh Biro PBJ', '2025-06-16 10:33:14', NULL, '1'),
('ae03589a62f936f926d8aeef595a37148fc77d1a', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', 'Dokumentasi Petugas Layanan dengan Budaya Pelayanan yakni memakai seragam khusus, memakai Identitas nama, PIN/Atribut/Logo, menerapkan 5S ', '2025-06-20 14:53:38', NULL, '1'),
('ae92f97199005f220c451eb3161ed4a0718811f7', 'bdf634491a8ee3ad5404841758b381bd1a9f40d8', 'Rekap pengelolaan pengaduan', '2025-06-13 11:54:04', NULL, '1'),
('af75280154b7d975568deb9a77a7052b29f4eed1', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya) 4. Domain Data dan Informas', '2025-06-19 13:59:52', NULL, '1'),
('b3c5e6dcdb2f94ed5ccf1d839343f6388e3884a2', '05e92a67e5198493e3c0845daa851f48bad80241', 'Screenshot Pemanfaatan JDIH (cek regulasi PD yang telah diterbitkan), Website/Sistem Informasi dari PD yang sudah diintegrasikan dengan JDIH khusus untuk produk hukumnya', '2025-06-13 11:55:02', NULL, '1'),
('b4214cbdb8e2b00fdb9d78fa8370f8187fafd3a1', '208565ef7e96a72f09425ef5a7cb30bbe24a3243', 'Screenshot Pemanfaatan Aplikasi Sistem AKIP (Biro Organisasi dan Kemenpanrb)', '2025-06-13 11:53:07', NULL, '1'),
('b6da12b28a0ff43cfdf79b9fa0039b7eda257a8a', '1462e56acf3115229e54b5930b24730eb5613efc', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 10:02:48', NULL, '5'),
('b6dd8254be94e12d35f3264f0b0bf218bd218b3b', '38c860642d8faf7029945cb902fb9beaf59f8a15', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 09:16:38', NULL, '5'),
('bcf1af47dfbdffd05564bcf1815778056a49b932', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2. Publikasi Kode Etik di ruang pelayanan ', '2025-06-20 14:45:31', NULL, '2'),
('bd1bdc3ffc841ed1436e5e02db3edfcc358a78a4', 'fb3fb9de5de3842714c3b79c47bf40fe774778f9', 'Dokumen jumlah data prioritas yang telah terupdate (per 31 Desember n-1/tahun sebelumnya) pada 30 Juni tahun berjalan', '2025-06-13 11:58:53', NULL, '1'),
('c1de36ae190bdeef1da7409f63a0af47154ba4c9', 'e614f202a3b5c0ca97de18c5c2ab930593270a0b', 'Screenshot Pemanfaatan SIPD (Penatausahaan Keuangan Daerah)', '2025-06-13 10:59:10', NULL, '1'),
('c542a937c808fa002127465dadd5a6401d406ea1', '91abd3afcd2747a8c0e261587c1eef09351d09d6', 'Ketersediaan mesin antrian', '2025-06-20 14:52:41', NULL, '1'),
('c945e08539a646ebcf8fd7c89fe9098939cdd978', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2. Publikasi Waktu Pelayanan', '2025-06-20 14:44:29', NULL, '2'),
('ca93d19d79984c2b33253baa8488d2e5a2b7de39', '93cd1583f20318aba4ed3cabeb9e9a9994332480', 'Penyampaian 1 Buah \"Praktek Baik\" Implementasi RB Tematik (Public Services) dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet yang dikemas secara informatif dan menarik)', '2025-06-16 10:56:17', NULL, '1'),
('cab76dc78c8fbe551d38073628824d1270471450', 'ed4052a793493ad6e117034f1a47e15e4ec4308a', 'Dokumen Manajemen Aset TIK PD', '2025-06-13 11:46:53', NULL, '1'),
('cbfbbf7974b334ed3737f06f111c992d7ae620b7', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014', '2025-06-20 14:35:32', NULL, '1'),
('d19a9d3b8cb6dc3fe53492e8ab8e6db208dd3bbb', '7ced43deb489a53e67d08903c1d91d85b86de1f3', 'Respon PD terkait Form Permintaan Data', '2025-06-13 11:54:34', NULL, '1'),
('d33703384b2c52b2f3e59dc9a2278b056404ccdd', '1462e56acf3115229e54b5930b24730eb5613efc', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017ut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017okumentasi)  ', '2025-06-20 10:02:31', NULL, '4'),
('d6b343496003ab498983fa4a4a574ccb25043604', '1462e56acf3115229e54b5930b24730eb5613efc', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014', '2025-06-20 10:01:30', NULL, '1'),
('d78480a7ab97952e8f1b402e43fff87071c15c41', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', 'Dokumentasi Foto', '2025-06-11 22:52:11', NULL, '4'),
('da6ea42c040892f4dfc93bde4d050cf6e4f58095', '26bb65c06a82d70329ae01ac36be312c38974880', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014      ', '2025-06-20 09:56:50', NULL, '1'),
('dd0e7765ed3bc7c40e77f50ddc6cee652f47887b', 'fa2adebb9a3e011b8e751c4c58f0c8f9a5246304', 'Nota Dinas, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Pusat Data Pemerintah Daerah', '2025-06-13 11:34:11', NULL, '1'),
('dfa461f3c3e8e6b5f3d7dcd083b8b714940845fa', '222918ef0072144df43126dd42d8946bfe37329e', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)cara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 10:00:41', NULL, '5'),
('e13ba588ea2574d1a003e4cd918fcb9b222e56aa', 'c198acc0217854f3958d6a4f4969260c1934a185', '2. SK Inovator', '2025-06-20 14:43:51', NULL, '2'),
('e1ec731675a300fab22842fc54eebb440ae2e4bf', 'bef033f1d4dfe3a1cc60dd728acf7a3530b4a396', 'Raport Kinerja Perangkat Daerah pada Lingkup Penyelenggaraan Urusan yang menjadi core bisnis Perangkat Daerah pada Bidang Teknis Perangkat Daerah', '2025-06-16 10:43:52', NULL, '1'),
('e220f0ab1a46de34dda723d1514ca5905cf30ac3', '7f93d7c672515bec3b590bf3d39c1a77dd376f15', 'Laporan Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Berjalan', '2025-06-20 08:59:34', NULL, '1'),
('e26e2b751b6e6b13c0e969042dcff8f234597f1a', '2b557a8de90f11956d143d38ebb34f4f3e1517b7', 'Screenshot Pencatatan paket transaksional pada e-Kontrak dalam SPSE atau Laporan Pencatatan paket transaksional pada e-Kontrak dalam SPSE yang dikeluarkan oleh Biro PBJ', '2025-06-16 10:34:09', NULL, '1'),
('e2baf0dc33a08f8af3a1d289564979d31f457bf1', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014     ', '2025-06-20 14:31:22', NULL, '1'),
('e2eb7c7fe7b2bddf3ca5e9e7bb7bc83305fb5f62', '8419f961c95170927dc5a0221dd924eedf99569b', 'Surat Keputusan/Naskah Dinas Penetapan Propemperkada', '2025-06-11 22:59:22', NULL, '2'),
('e3593f76416ae4fc2993bf4ce3702148a1c652fe', '1e18d576a11913f59bb54c7cefef863406078720', 'Dokumen Okupasi Pemetaan Kompetensi SDM TIK PD', '2025-06-13 11:47:55', NULL, '1'),
('e5d4a25e26c25721a00381e7c1fcd09790f69916', '4936f4074cfdb199ef8064f699a81f1c53662e6f', 'Laporan pelaksanaan Indeks KAMI (Diskominfo), Dashboard Indeks KAMI (PD lain)', '2025-06-13 11:41:13', NULL, '1'),
('e6a24ed2eb81d83b973a95cda9295cb6d4763193', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 14:38:58', NULL, '4'),
('e9f5203f9736a7090f0bfea76afa16281d757d2b', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014 ', '2025-06-20 14:38:05', NULL, '1'),
('eb1658e60a2ff38dc92144a56538869dfd91b920', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', 'Berita Acara Hasil Evaluasi TPI dan/atau Laporan Hasil Evaluasi TPN dan/atau Piagam Penghargaan Capaian Predikat WBK/WBBM pada unit kerja', '2025-06-20 09:01:44', NULL, '1'),
('eb2cd70bf1f6917842cbb29a0e437c5c4180b1d8', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 14:36:27', NULL, '4'),
('eb338240a52f800481a164e6513b3d33925141d3', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017', '2025-06-20 10:05:32', NULL, '3'),
('edececcea65692abbaac7af558e2eb70c1be68d3', '1c2c2b8dad484483b8e643700c597e24b054ce97', 'Screenshot  dari Sistem Informasi yang dimiliki berupa website dengan melihat aspek yakni tata letak, kejelasan menu, kemudahan bagi pengguna website, kompatibilitas tampilan website serta domain situs pemerintahan', '2025-06-20 15:00:28', NULL, '1'),
('f177ae03aecf80d540dd2b0358005bac6295c46a', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017', '2025-06-20 14:34:07', NULL, '4'),
('f48b7daab9f1d76721b98264af9ba3412a5633c9', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)', '2025-06-20 14:34:33', NULL, '5'),
('f5294e43672802ef7d2410ed24e43a36fea9a842', '564e33091fb99843c88bf568e7c137ee45a0b025', 'Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah', '2025-06-16 10:38:26', NULL, '1'),
('f5abc250cc68b14356e3d66af728d10107690738', 'f2633c69c8df08f548c62656ab0a76483ba25942', 'Screenshot Pemanfaatan Aplikasi Aset', '2025-06-13 11:51:07', NULL, '1'),
('f71e2183f9c1f151c0b234bfac680cdf40872231', '95e18a732238ea906e25d348f878f80b7d9345c2', 'LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal', '2025-06-20 09:06:49', NULL, '1'),
('fc2cf1d87c2d902baaa66547a988eff1ede60693', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', 'Dokumen tindaklanjut dari hasil Konsultasi ataupun pengaduan yang masuk', '2025-06-20 14:57:54', NULL, '1'),
('fc4befb2599c071a6739140201a41284b2205e84', '26fa43a7b899b315dd5f4677400867f2103d9a87', 'Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah', '2025-06-16 10:37:56', NULL, '1'),
('fc8b4c0b600c315ad150353eac09e512368a0282', 'e130a0fb0ce28f10c4f0f1c54249077fe30ed8ef', 'Surat Edaran, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Sistem Penghubung Layanan Pemerintah Daerah', '2025-06-13 11:35:47', NULL, '1'),
('fdbedb0beda14fe9f61161faf208669da3874c31', '5d87606c5eee137d90d291e708f3220790f6cbf5', 'Screenshot Laporan RUP pada Aplikasi SiRUP atau Laporan Rekapitulasi RUP pada SiRUP yang dikeluarkan oleh Biro PBJ', '2025-06-16 10:30:28', NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `lke_detail_opd`
--

CREATE TABLE `lke_detail_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opdid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_detail_opd`
--

INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES
('03e7da95b52f070890de6eb195569d824cb53e6d', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '056dd8b1762b5e8195fb91c3525d05b79bf6e3a2', '2025-03-13 03:42:15', NULL),
('15e427e124b32a81f844b8e6aec541558c2f40ce', '12c2130d7b2d29e0930b2d3fccf97d978b0e821c', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-06-23 07:08:23', NULL),
('43a3d5ed7d8be4cfe72939f234aaac54e8035ffb', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 03:11:55', NULL),
('74567b45e048584698167e93be1cf4354e7d6a04', '400287b9dbd5310785484fc6e23f1ed312767494', '81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', '2025-06-23 06:57:46', NULL),
('c202274f678efde74a8015b24691a1945f7ac772', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'ba273eab7dc54d995b5ee2ca958b5c447f277d84', '2025-05-15 07:02:00', NULL),
('cc0bd82ca92dce73e533301b262409202d296dc5', 'c895f123acea93c7dc34d334eadf6cf086474170', '6a674853b7c5e54cd19140c17cca792811418c1b', '2025-03-13 03:41:41', NULL),
('d7337fc416527508037c7bea5b1dc7881fbcef59', 'a8dfbd890507edce5df5425d990883ad144967fd', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 04:46:43', NULL),
('dfebaec58a33ea0bfd2f9cb7282b181aa47f3e70', '08a62fdb70f816447cbb4488ed1626653233851f', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 11:09:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lke_form`
--

CREATE TABLE `lke_form` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evaluasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bataswaktu` datetime DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `active` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_form`
--

INSERT INTO `lke_form` (`id`, `nama`, `tahun`, `deskripsi`, `evaluasi`, `bataswaktu`, `create_at`, `active`, `update_at`) VALUES
('ca637035f0a5396d1cc11662a8c674a1aec6f3a6', 'LKE REFORMASI BIROKRASI PERANGKAT DAERAH ', '2025', 'Ini adalah LKE RB 2025', 'Evaluasi 2025', '2025-10-15 12:00:00', '2025-06-10 19:54:49', '1', '2025-06-11 18:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `lke_indikator`
--

CREATE TABLE `lke_indikator` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_indikator`
--

INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`, `nums`) VALUES
('0133e2eaecfbdd0b86264e90740661739847444a', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-19 10:04:58', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('02e0b378b75ccaeba97fb2a141e64480c5447297', '057226d2d134fa7f7d12730846d47ea91c482d83', 'Persentase Penyelesaian Pengaduan pada SP4N-LAPOR! dengan Status Selesai', '2025-06-11 22:40:43', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('054a031448fee205ada507d5fa566fd9e001bc70', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Tersedia tempat parkir dengan fasilitas pendukung yang memadai', '2025-06-19 10:03:37', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('05e92a67e5198493e3c0845daa851f48bad80241', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Jaringan Dokumentasi dan Informasi Hukum (JDIH) Berbasis Elektronik', '2025-06-13 11:22:03', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'm)'),
('060245c55fa1cdda77c0639b1978131ba5cab3dc', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-06-10 21:46:46', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'b)'),
('124e174eab918098602fc8b5c503877d45dc8037', 'b10a47f65bf169dca8dd07aa4376453992b7ba6f', 'Tindaklanjut Hasil Pemerikaan APIP ', '2025-06-19 09:17:34', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('1462e56acf3115229e54b5930b24730eb5613efc', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Persentase rencana tindak lanjut hasil SKM yang telah selesai ditindaklanjuti', '2025-06-18 11:13:04', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'h)'),
('1672b51208686e126770604c791bfd67d0ea7dcc', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Sarana Front Office (FO) Informasi di unit layanan', '2025-06-19 10:06:20', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'f)'),
('18bcf56fc86cf0bacb9716b241247e385b294376', '0b5c8fa0d034429574ebd1fec5cea98a0a08fc69', 'SK Pembentukan Panitia Antar Perangkat Daerah', '2025-06-11 22:37:13', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'c)'),
('1c2c2b8dad484483b8e643700c597e24b054ce97', 'ece1165f2445dac8cd6e55eda12ac57bb822e4e3', 'Kualitas penggunaan SIPP Elektronik (Website/Aplikasi)', '2025-06-19 10:32:03', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('1e18d576a11913f59bb54c7cefef863406078720', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah dilakukan pemenuhan kompetensi Sumber Daya Manusia TIK', '2025-06-10 22:13:40', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'o)'),
('1ff16ba78f665f700312c31ca80da58389e7a81b', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menerapkan proses pembangunan Aplikasi SPBE sesuai siklus pembangunan aplikasi', '2025-06-10 21:49:16', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'e)'),
('2017b67bb7ec425721f4f39badb0cc1766dd6359', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menerapkan Manajemen Risiko SPBE', '2025-06-10 22:11:37', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'j)'),
('208565ef7e96a72f09425ef5a7cb30bbe24a3243', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Akuntabilitas Kinerja Organisasi Berbasis Elektronik', '2025-06-13 11:17:19', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'i)'),
('222918ef0072144df43126dd42d8946bfe37329e', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Jumlah media publikasi hasil SKM', '2025-06-18 11:12:42', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'g)'),
('23166a8ae4d427fe718a1ae565cbd72a19aa3392', 'c068df47a0481354b6283c9cf910e3235e68e3a0', 'Tersedia pelaksana yang menerapkan budaya pelayanan', '2025-06-18 15:14:19', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'e)'),
('23f08c7833dcc8775fc86ac0682e7d2472af3267', '2928673966d41805cb642c2f4060ec78af0114c7', 'Telah melakukan diseminasi/sosialisasi SP4N-LAPOR kepada masyarakat/pengguna layanan', '2025-06-11 22:40:01', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('26bb65c06a82d70329ae01ac36be312c38974880', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'SKM yang dilaksanakan sesuai dengan PermenPANRB', '2025-06-18 11:12:20', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'f)'),
('26dabc885d6a369ceab60d138385533a50a22958', '4180c76ad2a00cb809b55f763eda4151dc37cc86', 'Aspek Perencanaan Kinerja', '2025-06-11 19:08:04', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('26fa43a7b899b315dd5f4677400867f2103d9a87', 'd6020f1eb35d3442dbb2f6cf20338fe4e50ea0db', 'Dimensi Kompetensi', '2025-06-16 09:49:07', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('28a5d1b98409915a3b0e821647d8477e8687b4d7', '0b5c8fa0d034429574ebd1fec5cea98a0a08fc69', 'Rancangan Peraturan Daerah/Peraturan Kepala Daerah yang telah di paraf pejabat terkait', '2025-06-11 22:37:26', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'd)'),
('29cf25bb5ea0d1b0c8ef68c1e401765ba6d6651f', '4cadf397a1a3f85cf769b91d9c0e3c063a355384', 'Dokumen Rencana Aksi Pembangunan RB General telah disusun dan ditetapkan sebagai dokumen formal', '2025-06-16 09:54:19', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', 'e5266f7bdc984ff804e99a1d67b4cde04ff70350', 'Tingkat Kehadiran Pimpinan Tinggi Pemrakarsa dalam rapat Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:38:26', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('2b557a8de90f11956d143d38ebb34f4f3e1517b7', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '2025-06-16 09:37:29', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'e)'),
('2b7af354328c5e03b48e33a9e62978f4b0124629', '6b73c827ee8be49cb9a2d61e0651cd0f3eef11d3', 'Tersedia akuntabilitas hasil konsultasi dan/atau pengaduan', '2025-06-19 10:45:10', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('31328f434366f016ada5b7ce753da81b9887fda0', 'ece1165f2445dac8cd6e55eda12ac57bb822e4e3', 'Pemutakhiran data dan informasi kanal digital', '2025-06-19 10:32:26', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('333624b6008c5fda79189d98f043ec0763db0355', '057226d2d134fa7f7d12730846d47ea91c482d83', 'Laju Tindak Lanjut Penyelesaian Aduan', '2025-06-11 22:40:59', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('356adee25a1526c8f6deafff1ec564ad5a407623', 'a6eb6aa1a78a957d36ce9932e03e80662d7c430b', 'Capaian Rencana Aksi Pembangunan RB General', '2025-06-16 09:56:38', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('38c860642d8faf7029945cb902fb9beaf59f8a15', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Jumlah media publikasi untuk komponen Service Delivery', '2025-06-18 11:10:12', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('397a7dbe2fd7b34ab6ebed2a09fee9c3ded5d8d5', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Kearsipan Dinamis Berbasis Elektronik', '2025-06-13 11:10:47', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'f)'),
('3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menerapkan Tanda Tangan Elektronik pada Naskah Dokumen Elektronik', '2025-06-10 22:12:26', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'l)'),
('3de9a291fe5be48c4d41d62d7e3598137675151a', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Pencatatan paket transaksional pada Toko Daring', '2025-06-16 09:37:49', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'f)'),
('413464b84908505e7d4fcbe8e802d6a44da902b4', '56a54e1832dc68831bcca696e66c80cb56fd64e0', 'Tingkat Penerapan Digitalasasi Administrasi Pemerintahan dalam Pelaksanaan Tugas Pokok dan Fungsi ', '2025-06-16 10:13:37', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', 'ea7358c7806920c8efafd2112c0db8e010196627', 'Jumlah IKU Perangkat Daerah Tercapai', '2025-06-19 09:09:40', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Proses penyusunan dan perubahan SP telah melibatkan unsur masyarakat', '2025-06-18 11:01:52', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('4581da6e1cc226decb6a880b7d4b68e1b553a520', '1ec675aeeb3ed00af2269a6a3aede471a428b161', 'Dokumen Rencana Aksi Pembangunan RB Tematik telah disusun dan ditetapkan sebagai dokumen formal dengan memuat logical framework', '2025-06-16 09:59:30', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('45cf18e926282fc9b3211f0428052fbb760c2583', '0b5c8fa0d034429574ebd1fec5cea98a0a08fc69', 'Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:36:25', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-10 21:46:05', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('479b03a54d5860c3494d9986e39767088a6ba472', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Kepegawaian Berbasis Elektronik', '2025-06-13 11:10:28', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'e)'),
('4936f4074cfdb199ef8064f699a81f1c53662e6f', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah melakukan self-assessment Indeks KAMI', '2025-06-10 22:12:03', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'k)'),
('4b3401518bf31cce72ee049f1d8f63a440b13e0c', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Pencatatan Paket e- Purchasing pada Katalog Elektronik', '2025-06-16 09:36:46', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'c)'),
('4c8378c214c94d9085e88f953e0199ba8feae24c', '01b9f45ad2a0fb7dccdbdc646a0821c23f27cb1b', 'Hasil Tindak Lanjut SKM Tahun Sebelumnya', '2025-06-18 09:54:34', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('4cc7c0d2808515a7deb6b967a47d749eddf4ca61', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Memiliki Layanan Berbasis Elektronik', '2025-06-13 11:22:23', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'n)'),
('534b4f1b17fb66a0934dd6de2965307b36fdfd94', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Kinerja Pegawai Berbasis Elektronik', '2025-06-13 11:17:34', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'j)'),
('54a6147d981a7d176e0c5dd43705569ba6db34fe', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah melaksanakan Manajemen Data', '2025-06-10 22:12:56', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'm)'),
('564e33091fb99843c88bf568e7c137ee45a0b025', 'd6020f1eb35d3442dbb2f6cf20338fe4e50ea0db', 'Dimensi Kinerja', '2025-06-16 09:49:26', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'c)'),
('5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Tersedia ruang tunggu dengan fasilitas wajib dan pelengkap', '2025-06-19 10:04:05', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('5ab92f78db60f19538f40fa37c44bfc79ddf67a0', 'f8cb84a75af5b3b14d1f5094d2b3ec1598eb660e', 'Pembangunan Zona Integritas Unit Kerja/Perangkat Daerah', '2025-06-10 22:47:05', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('5c8040f3ac32bd6e074d0897d3d130d41ac839d2', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering', '2025-06-16 09:36:26', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('5d87606c5eee137d90d291e708f3220790f6cbf5', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Paket Pekerjaan yang diumumkan RUPnya melalui SiRUP', '2025-06-16 09:36:05', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('5fc1fe493b1f677a1075171f6248fe5f0c620e40', '4180c76ad2a00cb809b55f763eda4151dc37cc86', 'Aspek Pengukuran Kinerja', '2025-06-11 19:24:29', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('6aee4cc780191317ea55ac6e0cf353f0a1588182', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 08:31:59', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-06-10 21:47:42', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('72c74e606e4d873d6f94f0030a06946590352cbc', 'ece1165f2445dac8cd6e55eda12ac57bb822e4e3', 'Tersedia sistem informasi pelayanan publik pendukung operasional pelayanan', '2025-06-19 10:31:44', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('773967cf70fb968c9e52d268d06c1e6abdc530e6', '6b73c827ee8be49cb9a2d61e0651cd0f3eef11d3', 'Tersedia sarana dan media konsultasi serta pengaduan yang bisa dimanfaatkan semua lapisan masyarakat', '2025-06-19 10:44:47', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('7791f5c1e867947c05b7761ad4cf5673e5cda607', 'd6020f1eb35d3442dbb2f6cf20338fe4e50ea0db', 'Dimensi Kualifikasi', '2025-06-16 09:48:45', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('7ced43deb489a53e67d08903c1d91d85b86de1f3', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah menggunakan Layanan Data Terbuka Berbasis Elektronik', '2025-06-13 11:21:48', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'l)'),
('7f93d7c672515bec3b590bf3d39c1a77dd376f15', '01b9f45ad2a0fb7dccdbdc646a0821c23f27cb1b', 'Hasil Survey Kepuasan Masyarakat pada Aplikasi SKM Terintegrasi', '2025-06-18 09:37:17', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('8419f961c95170927dc5a0221dd924eedf99569b', 'e87a0405f07d0319c900e09843a592128f94286c', 'Tindaklanjut Hasil Evaluasi Produk Hukum', '2025-06-11 22:39:04', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('89a3cfcafdb60bf04616631ab63464418ff7367c', '4180c76ad2a00cb809b55f763eda4151dc37cc86', 'Aspek Evaluasi Akuntabilitas Kinerja Internal', '2025-06-11 19:25:31', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'd)'),
('91abd3afcd2747a8c0e261587c1eef09351d09d6', 'f8d46c4490720c9a7d64660ab2b996c88ea2e110', 'Tersedia sistem antrian untuk menunjang pelayanan', '2025-06-19 11:28:54', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('936328e1dfe004e577c7e26d41681bd365fc6f09', '1f2d995999594443cc5ea4edae3ced8d3e16bbcd', 'Nilai Hasil Evaluasi Pengawasan Kearsipan Internal Perangkat Daerah', '2025-06-13 11:10:15', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('93cd1583f20318aba4ed3cabeb9e9a9994332480', '5242c03179064bdbbe544bc4e318963af585bf32', 'Capaian Kinerja Organisasi dalam Pengentasan Kemiskinan dan/atau Penanganan Stunting dan/atau Peningkatan Investasi dan/atau Pengendalian Laju Inflasi dan/atau kinerja lainnya yang merupakan core business perangkat daerah', '2025-06-16 10:53:27', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('95e18a732238ea906e25d348f878f80b7d9345c2', '4180c76ad2a00cb809b55f763eda4151dc37cc86', 'Aspek Pelaporan Kinerja', '2025-06-11 19:25:04', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'c)'),
('9688074a1777e6aa64f154f0483f6edb7fd8c234', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Kecepatan tindak lanjut hasil SKM seluruh jenis pelayanan', '2025-06-18 11:13:36', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'i)'),
('9d065032e5205e2ac9d88a57f95608179707ec61', 'e87a0405f07d0319c900e09843a592128f94286c', 'Evaluasi Produk Hukum', '2025-06-11 22:38:49', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('a7f919001f45b9a552a6ffcd418ea4273bfce467', 'c068df47a0481354b6283c9cf910e3235e68e3a0', 'Tersedia waktu pelayanan yang memudahkan pengguna layanan', '2025-06-18 15:12:14', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('a9069b289f2e0f78afa7d4ac8c6a98975e03e886', '08f9b667ed43041f853956fcab74908204072d69', 'Telah membentuk Tim Pengelola SP4N-LAPOR Perangkat Daerah yang diformalkan dalam bentuk SK atau SP Kepala Perangkat Daerah', '2025-06-11 22:39:42', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'a)'),
('a92b34d679d1c6f6e5aecc60bf20e8819b4c33b1', '50b2c319a07d11a546718361b885977af6f7001b', 'Persentase Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE', '2025-06-16 09:37:07', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'd)'),
('ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', 'ece1165f2445dac8cd6e55eda12ac57bb822e4e3', 'Tersedia sistem informasi pelayanan publik untuk informasi publik', '2025-06-19 10:31:06', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah mengalokasikan anggaran pelaksanaan SPBE setiap tahunnya', '2025-06-10 21:47:17', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('b0458145e51457abbcecfa494984e96c16d041a6', '4f01cbe6d105283f43490afeee3f9ecfd2dd4a4c', 'Realisasi APBD Tahun Berjalan', '2025-06-19 09:23:24', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('b2b39157592e921b7a4893ec51e37e01688327dc', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Pemenuhan siklus Maklumat Pelayanan (ketersediaan, penetapan, dan publikasi)', '2025-06-18 11:11:33', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'e)'),
('b3050198a0311b2fd1e1521bda8cecd00f63d4e4', '255b7ce5c32637bee13941cfbf05fcd35957a4a8', 'Nilai Hasil Survey Implementasi Kamus Kompetensi ASN BerAKHLAK', '2025-06-18 09:29:37', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('b3f348e5efc8ef54cff7d945a876410e1b329641', 'bcaa314592885431f94270f39f1b6cda138a9348', 'Persentase Data yang Memiliki Metadata', '2025-06-13 11:26:52', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'b)'),
('b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '6b73c827ee8be49cb9a2d61e0651cd0f3eef11d3', 'Tersedia tindak lanjut atas konsultasi dan pengaduan dari semua lapisan masyarakat', '2025-06-19 10:45:29', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('b5c441f52388bcbb8ee5b4b1ac6dae1ff1da918e', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Pengawasan Internal Pemerintah Berbasis Elektronik', '2025-06-13 11:16:26', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'h)'),
('ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Telah dilakukan peninjauan ulang secara berkala terhadap Standar Pelayanan', '2025-06-18 11:10:58', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('bbd6766844c62b32f026fd274cb4ca16a94fb4ba', 'f8d46c4490720c9a7d64660ab2b996c88ea2e110', 'Sumber daya yang mendukung keberlanjutan Inovasi Pelayanan Publik', '2025-06-19 11:28:31', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('bdc31064087319d26c08507f5f3dbaaaa8d5205c', '0b5c8fa0d034429574ebd1fec5cea98a0a08fc69', 'Naskah Akademik/penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:36:56', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'b)'),
('bdf634491a8ee3ad5404841758b381bd1a9f40d8', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Pengaduan Pelayanan Publik Berbasis Elektronik', '2025-06-13 11:21:26', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'k)'),
('bdfdfe3ff3f049f04205f465b68af41adab5f10d', 'b10a47f65bf169dca8dd07aa4376453992b7ba6f', 'Tindaklanjut Hasil Pemerikaan BPK RI', '2025-06-19 09:17:11', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('bef033f1d4dfe3a1cc60dd728acf7a3530b4a396', '829f8f418b567768a9065d723d4dbc1025f11c25', 'Capaian Rencana Aksi Pembangunan RB Tematik', '2025-06-16 10:04:15', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('bf29c2c0ebb5bf5f234eb273a94f4bfc198e2f3f', 'daaa5c6a688167eef7f272370c794f469382e734', 'Realisasi APBD Tahun Sebelumnya', '2025-06-19 09:23:03', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('c198acc0217854f3958d6a4f4969260c1934a185', 'f8d46c4490720c9a7d64660ab2b996c88ea2e110', 'Penciptaan Inovasi Pelayanan Publik', '2025-06-19 11:28:09', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('c6ddd5c9cfb225fc4881f98607ebc677a34fd715', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah terdapat Tim Pelaksana SPBE Perangkat Daerah', '2025-06-10 22:11:13', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'i)'),
('cc426e33d29c9393353bc051ba24720a1709a2af', 'c068df47a0481354b6283c9cf910e3235e68e3a0', 'Tersedia mekanisme yang dibangun untuk menjaga dan meningkatkan motivasi kerja Pelaksana pelayanan', '2025-06-18 15:13:35', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('d19c3e6ed374d12a978546f90608c9d155d319bd', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:52:56', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'b)'),
('d515540f163958822b5b8fadb89c591bcaf6f0bb', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Tersedia sarana toilet pengguna layanan yang layak pakai', '2025-06-19 10:04:38', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'c)'),
('d823766c948a1c8dc2c4fd700e48889192782492', 'bcaa314592885431f94270f39f1b6cda138a9348', 'Telah Memiliki Standar Data Statistik', '2025-06-13 11:26:33', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'a)'),
('da31f7996d51add8aa2dda4aeb587896bd9af816', '6b73c827ee8be49cb9a2d61e0651cd0f3eef11d3', 'Tersedia sarana konsultasi dan pengaduan secara tatap muka yang berkualitas', '2025-06-19 10:44:21', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('dc396ec8de0dba70307b0bf352b614202622f75e', '057226d2d134fa7f7d12730846d47ea91c482d83', 'Jumlah Laporan yang Diterima/Masuk pada SP4N - LAPOR', '2025-06-11 22:40:21', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)'),
('de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', 'c068df47a0481354b6283c9cf910e3235e68e3a0', 'Tersedia Kode Etik dan Kode Perilaku Pelaksana dan/atau Budaya Pelayanan di lingkungan instansi', '2025-06-18 15:13:06', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'b)'),
('e02be12b2244cfb5b6eb22080f7caf366e9d607d', '43f884162b5470fcce60d5124eebc4ad201cdae6', 'Tersedia sarana prasarana penunjang', '2025-06-19 10:05:42', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'e)'),
('e0c4526e75ba296f19f1472590d0baf1f9b64e29', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-06-10 21:53:47', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'g)'),
('e130a0fb0ce28f10c4f0f1c54249077fe30ed8ef', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menggunakan Sistem Penghubung Layanan Pemerintah Daerah', '2025-06-10 21:54:23', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'h)'),
('e235d1e25296c5f4a241e55993abcb72b24ee4b9', '747c28476e689b3a321f8c527aaf2a37489a874a', 'Realisasi Belanja Pengadaan Barang/Jasa Pemerintah pada setiap perangkat daerah yang menggunakan Produk Dalam Negeri/Tingkat Komponen Dalam Negeri (PDN/TKDN)', '2025-06-16 11:41:06', NULL, '30a403ce07541f207e00f56165f2ddb4cae5e24a', 'a)'),
('e614f202a3b5c0ca97de18c5c2ab930593270a0b', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Keuangan Berbasis Elektronik', '2025-06-13 10:02:03', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'c)'),
('e6c3f34ae501e033efe0a84932f24dad6b0f18e4', 'c068df47a0481354b6283c9cf910e3235e68e3a0', 'Tersedia kriteria pemberian penghargaan bagi pegawai yang berprestasi', '2025-06-18 15:14:00', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'd)'),
('ec38526ca158862acf6403a395e855c723391f5d', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Pengadaan Barang/Jasa Berbasis Elektronik', '2025-06-13 11:10:03', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'd)'),
('ed4052a793493ad6e117034f1a47e15e4ec4308a', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah menerapkan Manajemen Aset TIK', '2025-06-10 22:13:18', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'n)'),
('f2633c69c8df08f548c62656ab0a76483ba25942', '380f62689db0a9dea250a9c361827dc5944ef251', 'Telah Menggunakan Layanan Pengelolaan Barang Milik Daerah Berbasis Elektronik', '2025-06-13 11:16:04', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'g)'),
('f56c31c955255c249de67a93de07093489b5f250', 'd6020f1eb35d3442dbb2f6cf20338fe4e50ea0db', 'Dimensi Disiplin', '2025-06-16 09:49:44', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'd)'),
('fa2adebb9a3e011b8e751c4c58f0c8f9a5246304', '2d92920988e321f741f783fce665e30f30c188e5', 'Telah memanfaatkan Layanan Pusat Data Pemerintah Daerah ', '2025-06-10 21:49:45', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'f)'),
('fb090dae0186365c93dd6a97bee9fc96fe7ac3fb', 'bcaa314592885431f94270f39f1b6cda138a9348', 'Persentase Keterisian Data Prioritas (Relevansi)', '2025-06-13 11:27:05', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'c)'),
('fb3fb9de5de3842714c3b79c47bf40fe774778f9', 'bcaa314592885431f94270f39f1b6cda138a9348', 'Persentase Data yang Dirilis sesuai Jadwal (Aktualisasi & Ketepatan Waktu)', '2025-06-13 11:27:32', NULL, '2908a111a94b52d770dbe8db5800d71706463811', 'd)'),
('fb50aefb093247f432cb57343143ae7fa60be3bc', '49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Tersedia Standar Pelayanan (SP) sesuai dengan ketentuan peraturan perundang-undangan yang berlaku', '2025-06-18 10:42:06', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'a)');

-- --------------------------------------------------------

--
-- Table structure for table `lke_jawaban`
--

CREATE TABLE `lke_jawaban` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nilai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aprove` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ket` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `aproveby` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_jawaban`
--

INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`, `aproveby`) VALUES
('2b2e18d968a78f1d93ee537a5b0e07f61f29e213', '865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-23 12:36:38', '2025-06-23 12:40:48', 'c895f123acea93c7dc34d334eadf6cf086474170', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lke_Jenis_Jawaban`
--

CREATE TABLE `lke_Jenis_Jawaban` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_Jenis_Jawaban`
--

INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES
('2908a111a94b52d770dbe8db5800d71706463811', 'Skala Linear', 1, '2025-01-10 14:40:06', NULL),
('30a403ce07541f207e00f56165f2ddb4cae5e24a', 'Persentase (%)', 1, '2025-06-16 11:34:05', NULL),
('b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'Pilihan Ganda', 4, '2025-01-10 14:32:35', NULL),
('cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'Ya/Tidak', 2, '2025-01-16 13:39:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lke_logs`
--

CREATE TABLE `lke_logs` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `log` datetime DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `create_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_logs`
--

INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('004d6c5523ed9a3997b0585f381340d935a3282a', '2025-06-20 08:59:03', 'LOGIN', 'USER', 'User Login :muhammad mufti abyan', '2025-06-20 08:59:03'),
('0066297985c2135e81099956436bbe975453d9c1', '2025-06-11 09:28:03', 'UPDATE', 'admin', 'update Data Parameter : Perangkat Daerah konsultasi dengan Diskominfo dalam proses Pembangunan/ Pengembangan Aplikasi ', '2025-06-11 09:28:03'),
('01304621fcde0ad8b50fa766cfbb1aa1251cc89d', '2025-06-20 14:38:22', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi) ,Indikator  : ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-20 14:38:22'),
('0133996f5b7f95f67ecd5e5a433ab31a190fd47c', '2025-06-19 10:29:27', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia sarana FO informasi layanan', '2025-06-19 10:29:27'),
('01906b797257151caa99a5e05372bddb9985cbf0', '2025-06-19 09:18:19', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Persentase Hasil Tindaklanjut Rekomendasi (TLHP) BPK RI', '2025-06-19 09:18:19'),
('0196dbb5b7d784720076403a1798d37c50c87118', '2025-06-10 20:00:19', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 1. Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-06-10 20:00:19'),
('01d6c23820d8580400886321a51cdc03e7884653', '2025-06-10 23:21:39', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-10 23:21:39'),
('01e74874143b08df56d47dcbd5c3ddb3a0f1d460', '2025-06-19 14:27:29', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Berita Acara Hasil Survey Implementasi Kamus Kompetensi ASN BerAKHLAK Tahun Sebelumnya/Tahun Berjalan ,Indikator  : b3050198a0311b2fd1e1521bda8cecd00f63d4e4', '2025-06-19 14:27:29'),
('0201ebc86858f1a490b3ee1c0f452709f4bb0621', '2025-06-19 10:54:06', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dilakukan monev, ditindaklanjuti, dan dipublikasikan', '2025-06-19 10:54:06'),
('02b06107252962979ff3912bfcbdc5353d32d807', '2025-06-13 11:23:25', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan JDIH', '2025-06-13 11:23:25'),
('03eaf709a041c40d44af79c4f14ea8eb85cc8cfd', '2025-06-19 10:58:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada konsultasi atau pengaduan yang ditindaklanjuti', '2025-06-19 10:58:19'),
('0421b8f3f965ededc96b4528c348b628bd5dc960', '2025-06-13 11:50:22', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SRIKANDI ,Indikator  : 397a7dbe2fd7b34ab6ebed2a09fee9c3ded5d8d5', '2025-06-13 11:50:22'),
('0482b07000cf0d129cacfa0b2c84aee458d59266', '2025-06-20 10:04:09', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014   ,Indikator  : 9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-20 10:04:09'),
('04a06c1ce24fb331a17ea403b5a7e042510b3d09', '2025-06-12 11:16:39', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-12 11:16:39'),
('04db9e9fe5a563c540953895eaa7efb36643cab7', '2025-06-14 23:01:14', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-14 23:01:14'),
('04f18917858568778a944072377cb804b9c1a978', '2025-06-19 10:00:11', 'INSERT', 'sultan', 'Tambah Data Indikator : Sarana Front Office (FO) Informasi di unit layanan', '2025-06-19 10:00:11'),
('04f96d739769174750512eb904e7df2b9feb6a3f', '2025-06-20 15:00:28', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot  dari Sistem Informasi yang dimiliki berupa website dengan melihat aspek yakni tata letak, kejelasan menu, kemudahan bagi pengguna website, kompatibilitas tampilan website serta domain situs pemerintahan ,Indikator  : 1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-20 15:00:28'),
('057c94f870ab8b92c5c03b7de9c13f08ab557a87', '2025-06-10 22:23:44', 'INSERT', 'admin', 'Tambah Data Parameter : A. Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', '2025-06-10 22:23:44'),
('05cf57e97e0a92bab46af21c94b6c5d669d79d9c', '2025-06-13 10:47:19', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:47:19'),
('05f4407ac0d433a175fc29cb42184a9b5b28818e', '2025-06-19 09:23:24', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Realisasi APBD Tahun Berjalan', '2025-06-19 09:23:24'),
('063cfdf17c0ce1be82aa72c0db33a67eee5fdcf2', '2025-06-23 14:58:16', 'LOGIN', 'USER', 'User Login :Admin Surabe', '2025-06-23 14:58:16'),
('066873e99ad74859be57d2d461b16e04f743e1f9', '2025-06-20 14:57:42', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan fasilitas toilet (terpisah laki-laki/perempuan), wastafel, toiletries, air bersih serta terdapat SK petugas membersihkan toilet ,Indikator  : d515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-20 14:57:42'),
('06a39232ee411eaa921939939d3ab51b0ba8e045', '2025-06-20 09:27:55', 'DELETE', 'soal', 'Hapus Data Bukti Dukung  : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                                     2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dok', '2025-06-20 09:27:55'),
('070c00af0647220aec0e477451843ff309f305fc', '2025-06-20 10:06:08', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : 9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-20 10:06:08'),
('0734ad3241d2d3072b6b5f82926b7cd597eb96e9', '2025-06-11 11:10:47', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 11:10:47'),
('0746b36397793995f3c0060d66eea078fc07d868', '2025-06-19 10:09:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia tempat parkir dan memiliki 3 atau lebih fasilitas parkir', '2025-06-19 10:09:36'),
('0806f4a014aac7939586aa64e335d52e3288354d', '2025-06-13 09:31:36', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-13 09:31:36'),
('080bc6d40670d6a795a3afc9a4e4f8e3f47e8241', '2025-06-13 10:42:45', 'INSERT', 'budker', 'Tambah Data Parameter : Jumlah Pengaduan diatas 20 aduan', '2025-06-13 10:42:45'),
('08418e415d18f82d843829e75a1c8827930c1311', '2025-06-19 13:30:59', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-19 13:30:59'),
('08573533bab366829e284f8de77ee9869e88ef6b', '2025-06-18 15:14:19', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia pelaksana yang menerapkan budaya pelayanan', '2025-06-18 15:14:19'),
('086459867703fe3ea470c92e98cfbcd3a7fd729b', '2025-06-16 10:29:26', 'UPDATE', 'soal', 'Edit Data Indikator : Persentase Paket Pekerjaan yang diumumkan RUPnya melalui SiRUP', '2025-06-16 10:29:26'),
('08df9ebb5a2db5ac1e3955fdf74192e2226acb93', '2025-06-19 10:40:09', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik berbasis website/aplikasi mudah dioperasikan  ', '2025-06-19 10:40:09'),
('095a216eaa933954473db6d9ff0360e550f79dec', '2025-06-10 19:55:38', 'INSERT', 'admin', 'Tambah Data RB : I. RB General PD Bobot : 100', '2025-06-10 19:55:38'),
('096d6add07727cb17a2e6f1d8b03e01840dc4df1', '2025-06-11 22:41:46', 'INSERT', 'budker', 'Tambah Data Indikator : Nilai Hasil Evaluasi Pengawasan Kearsipan Internal Perangkat Daerah', '2025-06-11 22:41:46'),
('09d7a6bea3a6b74c16e7134ea560c67efbd21363', '2025-06-20 10:02:48', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : 1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-20 10:02:48'),
('09dc3cfebcedbf392b87d037e26951e3faffa9b3', '2025-06-11 20:16:49', 'INSERT', 'admin', 'Tambah Data Parameter : vvvv', '2025-06-11 20:16:49'),
('0a0a16a911c8848c6060304bda7a0fb938d23a7d', '2025-06-10 23:29:34', 'UPDATE', 'admin', 'update Data Parameter : Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', '2025-06-10 23:29:34'),
('0a2205e7e7c81602517dd1ce4b4e25e7714a8f01', '2025-06-19 08:53:06', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Nilai Hasil Evaluasi Pengukuran Kinerja ', '2025-06-19 08:53:06'),
('0a35eee1e804b90ceec1e687ac0902af6fa441ec', '2025-06-10 22:18:14', 'INSERT', 'admin', 'Tambah Data Parameter : A.  Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-10 22:18:14'),
('0acb8a2ca54813dca5d45d2526ecde82a98978d5', '2025-06-19 11:31:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia inovasi', '2025-06-19 11:31:35'),
('0b998eaab53328264481bab906bf9188ea872be6', '2025-06-13 10:54:43', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi penganggaran', '2025-06-13 10:54:43'),
('0c09518e91f909b9a089629bf57dd523f3c0512c', '2025-06-19 09:26:43', 'INSERT', 'sultan', 'Tambah Data Parameter : Memiliki kebijakan jam pelayanan/kerja dan 3 unsur lainnya  unsur lainnya ', '2025-06-19 09:26:43'),
('0c3ebddfc199d0bd323f88460a2a1684a0e0a03b', '2025-06-20 10:02:13', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017okumentasi)   ,Indikator  : 1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-20 10:02:13'),
('0c5d241d596ecf1b838a3385c75d900170cbcbbd', '2025-06-19 10:51:43', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada sarana dan petugas', '2025-06-19 10:51:43'),
('0c6a7860242e2bf0b7b71d9f14d06699dd2e85cd', '2025-06-23 12:54:15', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:54:15'),
('0c7426568860ca7efff1b2302d2ac5e7d6ce2392', '2025-06-13 08:57:45', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 08:57:45'),
('0ca9acbc5ac31f8c840d5be5b9d72d6a1fb63cfd', '2025-06-13 10:52:02', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:52:02'),
('0cd1ab103b86739fba338a40229404349ce905ca', '2025-06-16 10:32:38', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering atau Laporan Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering yang dikeluarkan oleh Biro PBJ ,Indikator  : 5c8040f3ac32bd6e074d0897d3d130d41ac839d2', '2025-06-16 10:32:38'),
('0cfb37c192cf694af9467e0e08addb4fdf845ebc', '2025-06-18 10:05:22', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-18 10:05:22'),
('0d23a54ba24dff39a64b3364247aff989a50db28', '2025-06-13 10:18:00', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Peningkatan Penggunaan Produk Dalam Negeri Bobot : 100', '2025-06-13 10:18:00'),
('0d33e0f3acea1b79424d1475952ba8798c6e2237', '2025-06-13 09:21:55', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 09:21:55'),
('0d716a7f61f6174d606563ff31fa9edad27065a5', '2025-06-23 14:50:16', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 14:50:16'),
('0d7a1e8661a0da303f7f8fe4b3f1af70771832b5', '2025-06-20 08:59:34', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Laporan Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Berjalan ,Indikator  : 7f93d7c672515bec3b590bf3d39c1a77dd376f15', '2025-06-20 08:59:34'),
('0d9436dd667b2182c357b43a487e0e949888a849', '2025-06-11 19:54:55', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:54:55'),
('0dae49abcd1af964c128b4d36a07bb346fac8aa7', '2025-06-16 09:46:58', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '2025-06-16 09:46:58'),
('0df8df4d173e8ea61a688f95cba4af4af945e8b6', '2025-06-20 09:57:59', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-20 09:57:59'),
('0dfbefecff0d5384cbaeef73b99809f68a8e1337', '2025-06-19 10:51:24', 'INSERT', 'sultan', 'Tambah Data Parameter : Hanya terdapat media konsultasi dan pengaduan secara offline menyatu dengan front office  ', '2025-06-19 10:51:24'),
('0e08be35281a5f6385e8d54bba275c3e7cb4dd10', '2025-06-13 08:39:35', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 08:39:35'),
('0e624029ed309aa0c4c865c1c29e5ca2d2271813', '2025-06-11 09:23:49', 'UPDATE', 'admin', 'update Data Parameter : Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', '2025-06-11 09:23:49'),
('0e998927359b5386e5ec2df8db533e6d9d2f3a4c', '2025-06-10 22:12:03', 'INSERT', 'admin', 'Tambah Data Indikator : k) Telah melakukan self-assessment Indeks KAMI', '2025-06-10 22:12:03'),
('0ea115936d2f7186bedbda590178facd0f96037f', '2025-06-19 11:34:58', 'INSERT', 'sultan', 'Tambah Data Parameter :  Tersedia sistem antrian dengan 3 fasilitas', '2025-06-19 11:34:58'),
('0ed24c394dd37e045cc04cc6f489fed91469524b', '2025-06-19 09:27:28', 'INSERT', 'sultan', 'Tambah Data Parameter : Memiliki kebijakan jam pelayanan/kerja dan 2 unsur lainnya ', '2025-06-19 09:27:28'),
('0ee9541af6a8dfcef10b23d6d4fc803ae20d5781', '2025-06-11 22:37:26', 'INSERT', 'budker', 'Tambah Data Indikator : Rancangan Peraturan Daerah/Peraturan Kepala Daerah yang telah di paraf pejabat terkait', '2025-06-11 22:37:26'),
('0ef04761adb5274ba613be100fa695dddf3dc7c0', '2025-06-13 09:43:53', 'INSERT', 'budker', 'Tambah Data Parameter : dibawah 21% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:43:53'),
('0f70d8727ba5b670f0e01c92d32f3e49cd32dcaa', '2025-06-16 10:56:17', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Penyampaian 1 Buah \"Praktek Baik\" Implementasi RB Tematik (Public Services) dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet yang dikemas secara informatif dan menarik) ,Indikator  : 93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-16 10:56:17'),
('0fb8dfa595b9db967943cef9b4e9a653d311170a', '2025-06-11 10:11:39', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 10:11:39'),
('0fc2432414d84ab7cdd642aa70878ed917e5191d', '2025-06-19 09:42:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Pelaksana pelayanan menerapkan 3 (tiga)  unsur budaya pelayanan', '2025-06-19 09:42:14'),
('0fcd048fd64801c517a56f11ecf5da10a4fc79c9', '2025-06-10 22:13:18', 'INSERT', 'admin', 'Tambah Data Indikator : n) Telah menerapkan Manajemen Aset TIK', '2025-06-10 22:13:18'),
('0fdc4b4d8013c9ecb01bcda37cc4a6e44d2f6409', '2025-06-20 09:47:27', 'UPDATE', 'soal', 'update Data Parameter : Diisi dengan nilai hasil survei ASN BerAKHLAK', '2025-06-20 09:47:27'),
('101158259040c09541e9c25a538091df98ab1fe9', '2025-06-13 11:12:29', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan SiAP Sulteng', '2025-06-13 11:12:29'),
('10239bdbbe8bd5d08f583b6df827a1e70c279e8b', '2025-06-16 08:43:48', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi- ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-16 08:43:48'),
('1042f6ee949613babc57345cadb9bb49ef5fe81c', '2025-06-11 14:32:41', 'UPDATE', 'rb_renaksi', 'Update Data Sub Aspek : Nilai SAKIP Perangkat Daerah Bobot : 100', '2025-06-11 14:32:41'),
('1054414b84c4aa9b8a6f33a51391e9a5da06530a', '2025-06-16 08:36:25', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD ,Indikator  : 060245c55fa1cdda77c0639b1978131ba5cab3dc', '2025-06-16 08:36:25'),
('10844d29fae43953750eb49293c2301113d28cf5', '2025-06-13 10:01:21', 'DELETE', 'admin', 'Hapus Parameter  : Nilai Hasil Evaluasi Perencanaan Kinerja', '2025-06-13 10:01:21'),
('108c5a57b783be11694da2c8f605ace0d92a134d', '2025-06-13 10:45:20', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 10:45:20'),
('1118a1627f804d8ff98ffe40efe4ae20ac6e68ef', '2025-06-11 15:30:21', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 15:30:21'),
('112ca057f554d1b42d963bc094a9d7394dd077fa', '2025-06-13 11:40:47', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 11:40:47'),
('118b67f5f24c7c4339b0e353b4c4610197d0183a', '2025-06-13 10:59:18', 'UPDATE', 'budker', 'update Data Parameter : - ', '2025-06-13 10:59:18'),
('124a5c1288c7429679984f49d56e271faa7bc187', '2025-06-11 22:29:11', 'UPDATE', 'budker', 'Update Data Sub Aspek : Tingkat tindak lanjut pengaduan masyarakat (LAPOR) Bobot : 100', '2025-06-11 22:29:11'),
('126180113662a5738e9f74693b7baf0ae058d40e', '2025-06-16 10:38:26', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah ,Indikator  : 564e33091fb99843c88bf568e7c137ee45a0b025', '2025-06-16 10:38:26'),
('128997b6f0b7798c321a2b7a3a7a208ea1bdf1b2', '2025-06-19 09:35:12', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia lebih dari 4 jenis mekanisme peningkatan motivasi kerja ', '2025-06-19 09:35:12'),
('1291c22c4e48d798b3bbad08efe17f53e7c68bae', '2025-06-10 23:24:02', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-10 23:24:02'),
('132a40e4f931bc6273f9d43214c7fa7fe9d23bdf', '2025-06-20 09:13:41', 'LOGIN', 'USER', 'User Login :muhammad mufti abyan', '2025-06-20 09:13:41'),
('137af08bf4f107989ddcacfd24cdd380ef166e3a', '2025-06-19 08:51:32', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Nilai Hasil Evaluasi Perencanaan Kinerja ', '2025-06-19 08:51:32'),
('139f81f195ef15556ffe7e1e32a68167a6aa5349', '2025-06-13 11:28:52', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Tersedianya metadata terstandar (sesuai Perka BPS No. 5 Tahun 2020) untuk semua IKU Rumus: (Jumlah metadata IKU yang tersedia dibagi jumlah total IKU) * 100%', '2025-06-13 11:28:52'),
('13ac71aed7d2e42634f27a3e7211482ff7f008f9', '2025-06-18 11:17:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia publikasi SP seluruh komponen service delivery pada 3 media publikasi dan pada SIPP Nasional ', '2025-06-18 11:17:36'),
('147a81b8fcd383c9564602c544ee3b03e9c78125', '2025-06-19 09:26:42', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Diisi dengan Persentasi realisasi total APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Sebelumnya Rumus = Realisasi Akhir APBD Tahun Sebelumnya / Total APBD x 100%', '2025-06-19 09:26:42'),
('1496106a127d5306d94204bd7837fd4c1eca7635', '2025-06-19 09:00:17', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Jumlah IKU Perangkat Daerah Tercapai', '2025-06-19 09:00:17'),
('14f2a182331371eb24d5fc4d0dd88607a79ebb49', '2025-06-11 14:28:10', 'UPDATE', 'rb_renaksi', 'Update Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-06-11 14:28:10'),
('14f7a4b0e84908fb5f833f5488d3b21349cee94e', '2025-06-16 10:04:48', 'INSERT', 'soal', 'Tambah Data Parameter : Laporan Capaian Indikator Kinerja Penyelenggaraan Urusan yang menjadi core Bisnis Perangkat Daerah/Raport Kinerja Perangkat Daerah pada Lingkup Penyelenggaraan Urusan yang menjadi core bisnis Perangkat Daerah', '2025-06-16 10:04:48'),
('153b9e23b1f3db882d5f9f8b10c885bc011d3565', '2025-06-19 10:09:00', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia tempat parkir dan memiliki 4 atau lebih fasilitas parkir', '2025-06-19 10:09:00'),
('156daeb127f494344a557526b80edb733b9664c5', '2025-06-13 13:04:17', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 13:04:17'),
('158568df92d652b51d478c88822c8a68e23737bb', '2025-06-13 10:48:34', 'UPDATE', 'undata', 'Update Data Jawaban : TIDAKParameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:48:34'),
('15abb3456562711e01fc0eb000acffb4b573ed7f', '2025-06-20 14:34:07', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 14:34:07'),
('15de295214262663a772fd609871ddd03d08f85f', '2025-06-11 16:03:38', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 16:03:38'),
('15e0764461a9cfa6903a460e5429f6d3e52885b4', '2025-06-16 10:34:50', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Pencatatan paket transaksional pada Toko Daring pada SPSE pada SPSE atau Laporan Pencatatan paket transaksional pada Toko Daring pada SPSE ,Indikator  : 3de9a291fe5be48c4d41d62d7e3598137675151a', '2025-06-16 10:34:50'),
('15f7563e1a1150cf181ed8fced29c2da8a6bde1d', '2025-06-20 09:04:04', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Laporan Hasil TIndak Lanjut Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Sebelumnya ,Indikator  : 4c8378c214c94d9085e88f953e0199ba8feae24c', '2025-06-20 09:04:04'),
('1605332af32c49858d8156ef82d2f6822f55b81d', '2025-06-13 09:20:35', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:20:35'),
('173495c7a2bd6c4025886443fb5716bae673bd7a', '2025-06-10 19:58:52', 'INSERT', 'admin', 'Tambah Data Aspek : C. Capaian Strategis Pelaksanaan RB General Bobot : 100', '2025-06-10 19:58:52'),
('1753eb73f3615b0a73180b0353887b48e2ffa408', '2025-06-18 14:46:06', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia Maklumat Pelayanan   ', '2025-06-18 14:46:06'),
('1807e12ce7ca94a9c346cb29e94ff222d173fc19', '2025-06-20 14:31:22', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014      ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 14:31:22'),
('181275057624001cf445c894b5b8604b6e5e0ae5', '2025-06-18 09:29:37', 'INSERT', 'sultan', 'Tambah Data Indikator : Nilai Hasil Survey Implementasi Kamus Kompetensi ASN BerAKHLAK', '2025-06-18 09:29:37'),
('1893f899325656bf768d6ebe4095640a3dc8cdd5', '2025-06-25 11:45:48', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-25 11:45:48'),
('18cd2b584110dc7aba282b26eef22dda37d68632', '2025-06-13 11:53:37', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan eKinerja dan KMOB ,Indikator  : 534b4f1b17fb66a0934dd6de2965307b36fdfd94', '2025-06-13 11:53:37'),
('1957ffd40eeeaacf1794da656b5016003d8ff184', '2025-06-11 19:20:13', 'UPDATE', 'admin', 'Edit Data Indikator : Aspek Perencanaan Kinerja', '2025-06-11 19:20:13'),
('19c27fc1b03880969c79d8787585c1437d96e6db', '2025-06-19 10:42:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Pemutakhiran data dan informasi pelayanan publik telah dilakukan secara tahunan', '2025-06-19 10:42:41'),
('1a793d3f6c3f9c9b004361e6b0ce2f06b75b0723', '2025-06-13 11:10:47', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Kearsipan Dinamis Berbasis Elektronik', '2025-06-13 11:10:47'),
('1a90cce1a0934bb91ce98378a2c5737aa7168076', '2025-06-18 09:32:46', 'INSERT', 'sultan', 'Tambah Data Parameter : -', '2025-06-18 09:32:46'),
('1a9338a85866d4bc8cd2b86bce850963ba1e97e5', '2025-06-11 15:33:03', 'INSERT', 'admin', 'Tambah Data Bukti Dukung : File Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah ,Indikator  : 060245c55fa1cdda77c0639b1978131ba5cab3dc', '2025-06-11 15:33:03'),
('1aa494f6d606ed461804618e2c5d2a9bbb2e9159', '2025-06-13 11:57:35', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN  ,Indikator  : d823766c948a1c8dc2c4fd700e48889192782492', '2025-06-13 11:57:35'),
('1aa7c92a2009ae5c1981629913ad7d15d7698ec4', '2025-06-19 11:45:33', 'INSERT', 'soal', 'Tambah Data Parameter : Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan', '2025-06-19 11:45:33'),
('1b063b52c3c4d53d205cda7de2c4f606468c7fd7', '2025-06-10 22:12:26', 'INSERT', 'admin', 'Tambah Data Indikator : l) Telah menerapkan Tanda Tangan Elektronik pada Naskah Dokumen Elektronik', '2025-06-10 22:12:26'),
('1b1fb2dce973af625d1b462a18969ba0d33b9ca3', '2025-06-18 14:52:32', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah melaksanakan SKM namun tidak sesuai dengan PermenPANRB yang berlaku ', '2025-06-18 14:52:32'),
('1b24f68f29fcc114a4d0ac218aafb4aaf3fcfe60', '2025-06-19 09:36:51', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 1 jenis mekanisme peningkatan motivasi kerja      ', '2025-06-19 09:36:51'),
('1b457955c5996cff17e45022ed7c21c98894ccd0', '2025-06-19 09:38:17', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada pemberian penghargaan berdasarkan 3-4 unsur termasuk kinerja ', '2025-06-19 09:38:17'),
('1b855ff2e5b09e09880b0834b287fafc7d03852c', '2025-06-13 12:57:34', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 12:57:34'),
('1bb9ecba63dfec5870a4f4688eddfacae1058154', '2025-06-11 18:40:41', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 18:40:41'),
('1bdce4a4a489276811fa0fa05e9d29a73bb1e290', '2025-06-10 19:54:49', 'INSERT', 'admin', 'Tambah Data Form : LKE 2025 Tahun : 2025', '2025-06-10 19:54:49'),
('1c7afe9116a903d5b05f7538e79e3157273bb827', '2025-06-23 12:21:27', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 12:21:27'),
('1c8cce3c7cb75c95f15eba32c06e7359d5cdc7b7', '2025-06-11 09:42:55', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Indeks Reformasi Hukum Bobot : 100', '2025-06-11 09:42:55'),
('1c960aae870494f38c6ad278bbc97a92e9e5158c', '2025-06-18 14:55:01', 'INSERT', 'sultan', 'Tambah Data Parameter :  SKM dipublikasikan pada lebih dari 4 (empat) media publikasi lainnya ', '2025-06-18 14:55:01'),
('1cc53cc9ecdfae99f9b88eef42bbeedf9a5a5385', '2025-06-19 10:27:45', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sarana FO informasi layanan dengan 5 atau lebih fasilitas', '2025-06-19 10:27:45'),
('1d2a918fa5c75f50c1d3417a0d6cc46b9eb72d51', '2025-06-23 12:47:00', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:47:00'),
('1d5183fb7f5644a8d4555840ef6e04731b6b9c58', '2025-06-11 22:39:42', 'INSERT', 'budker', 'Tambah Data Indikator : Telah membentuk Tim Pengelola SP4N-LAPOR Perangkat Daerah yang diformalkan dalam bentuk SK atau SP Kepala Perangkat Daerah', '2025-06-11 22:39:42'),
('1d5ea8004c5d4b1a497812362519b1e64a110f68', '2025-06-13 11:21:48', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah menggunakan Layanan Data Terbuka Berbasis Elektronik', '2025-06-13 11:21:48'),
('1d96cd97ddb642bcbc29a7faff644969898e0a27', '2025-06-13 10:12:26', 'UPDATE', 'rb_renaksi', 'Edit Data Indikator : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:12:26'),
('1dbb20413a483c901223a20524ddcff9e8bec567', '2025-06-11 09:38:27', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 09:38:27'),
('1e4dc7e5342f9f33a367ecf05a3642b7348d142f', '2025-06-16 09:46:04', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering', '2025-06-16 09:46:04'),
('1e629680b2cedc813446a42f130d14bd0b07a462', '2025-06-13 11:18:55', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan Sistem Pengawasan Internal Pemerintah (SPIP)', '2025-06-13 11:18:55'),
('1e734f41abe5c236662389ed4d5bab3725b5a441', '2025-06-16 10:40:47', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-16 10:40:47'),
('1e73cb5ee5357940e20707ec7b83f915674adb52', '2025-06-11 18:42:02', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:42:02'),
('1e8655c8e3b3e3c720c6559daa6cf10346315d62', '2025-06-11 19:54:41', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 19:54:41'),
('1e8e11ba3aedf9a26e920466ce073005df98433c', '2025-06-10 21:30:29', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 6.1 Tingkat Implementasi Kamus Kompetensi ASN BerAKHLAK Bobot : 100', '2025-06-10 21:30:29'),
('1ea0169ca36884ece69bb87969f5207accd78a07', '2025-06-20 09:12:32', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : Berita Acara Capaian Kinerja APBD Tahun Berjalan ,Indikator  : b0458145e51457abbcecfa494984e96c16d041a6', '2025-06-20 09:12:32'),
('1ecd092b64902be102565f73e4c4a0aa54461b29', '2025-06-23 13:01:30', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 13:01:30'),
('1f1e97b53c4ec7d68268afaf15504c50b8b4cb3e', '2025-06-19 10:38:02', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia sistem informasi pendukung operasional pelayanan publik', '2025-06-19 10:38:02'),
('1f291161a29544d9d636066b14e3a09f50540468', '2025-06-11 22:33:18', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Laporan Pengelolaan SP4N-LAPOR! Setiap Semester Bobot : 80', '2025-06-11 22:33:18'),
('1f85f4c2a2091b8b594a28872fd320a37646c4c9', '2025-06-10 21:47:17', 'INSERT', 'admin', 'Tambah Data Indikator : c) Telah mengalokasikan anggaran pelaksanaan SPBE setiap tahunnya', '2025-06-10 21:47:17'),
('1fe6fc2b4572a0452d47ef58e938d2f1ad702a31', '2025-06-10 21:22:28', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 1.2 Tingkat Kematangan Kapabilitas Layanan Bobot : 30', '2025-06-10 21:22:28'),
('2018377fa78c9cafd84973a0716a9c7053093602', '2025-06-11 09:19:20', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 09:19:20'),
('201ae194dcdb24674bac895ecea2819a7b880198', '2025-06-20 10:01:30', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014 ,Indikator  : 1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-20 10:01:30'),
('2034c1460d5c291b3a5ee0c0ff86caeb9cfa6043', '2025-06-13 08:22:04', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 08:22:04'),
('20833d9d459a8e8326427fd4dcb31ecc6180f64c', '2025-06-19 10:15:13', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-19 10:15:13'),
('2091db194442e4ad1f2dcaaf67096ab8e24736cd', '2025-06-11 23:10:36', 'INSERT', 'budker', 'Tambah Data Parameter : Terdapat Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 23:10:36'),
('2092d3b7da46ead51f6d72f4e4c82a1a8933513d', '2025-06-20 14:57:25', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Dokumen atau Screenshoot bukti pengelolaan pengaduan, jika tidak terdapat pengaduan melalui SP4N LAPOR, sarana ini dapat dimanfaatkan untuk pengelolaan konsultasi pengaduan secara manual guna mempermudah rekap konsultasi dan pengaduan ,Indikator  : 2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-20 14:57:25'),
('212870c8e8636f4802f8f8f7aab2741d4ac0352b', '2025-06-13 08:40:54', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 08:40:54'),
('21813d1944665b2abe39da222b1166d497aec8e5', '2025-06-19 10:22:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 10-12 sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-19 10:22:36'),
('224b2e8c6e01f702d11653022d35e86ef0bbf329', '2025-06-11 09:45:10', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-11 09:45:10'),
('22627d3dbb21be100679d0428b6247d2ea315996', '2025-06-13 10:06:05', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Indeks Profesionalitas ASN  Bobot : 100', '2025-06-13 10:06:05'),
('22bd18106cd794e592ab5e71780d8a14399a4d06', '2025-06-19 09:09:09', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-19 09:09:09'),
('22f79dd6574ed7828237bf0d2d5708f4d022885d', '2025-06-11 18:53:12', 'UPDATE', 'admin', 'Update Data Sub Aspek : Nilai SAKIP Perangkat Daerah Bobot : 100', '2025-06-11 18:53:12'),
('23dd9ad6bb21ec4062d55260dda220f572136347', '2025-06-13 11:29:24', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Persentase data prioritas yang terupdate sesuai waktu A = 100% terupdate B = 75% terupdate C = 50% terupdate D = 25% terupdate E = belum terupdate (0%)', '2025-06-13 11:29:24'),
('23fbab9c828519f33d06b9fc1ec9e4f307f5d49d', '2025-06-19 09:37:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada pemberian penghargaan berdasarkan 5-6 unsur termasuk kinerja ', '2025-06-19 09:37:58'),
('24631628e3ff4baae64b10a55f56246b7be80756', '2025-06-19 10:21:33', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia toilet pengguna layanan', '2025-06-19 10:21:33'),
('2475feb8cf362c331b30af37a124c6066773da1c', '2025-06-10 20:02:56', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 6. Indeks Budaya Kerja BerAKHLAK Bobot : 100', '2025-06-10 20:02:56'),
('24e3ce7359494e1e7dad6d00a241999a38d79d82', '2025-06-11 18:48:51', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tindaklanjut Rekomendasi (TLHP) Bobot : 100', '2025-06-11 18:48:51'),
('24e5c83e1f0be89507e16ba5adb76a6ad419d1c4', '2025-06-11 19:53:33', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 19:53:33'),
('252efbfc6b383e756f413fd85a793e375b68e85e', '2025-06-13 11:57:51', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen metadata IKU Perangkat Daerah sesuai dengan Peraturan BPS no. 5 Tahun 2020 tentang Petunjuk Teknis Metadata Statistik ,Indikator  : b3f348e5efc8ef54cff7d945a876410e1b329641', '2025-06-13 11:57:51'),
('2546860c1a689f14d48e405bde1ed54176d679b7', '2025-06-13 11:28:51', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-13 11:28:51'),
('25e951e7da663be88f80259fc508140f1a2656fd', '2025-06-11 18:54:41', 'UPDATE', 'admin', 'Update Data Sub Aspek : Capaian IKU Perangkat Daerah Bobot : 100', '2025-06-11 18:54:41'),
('262646abf97d403fa95e9777bee93d4520b17fc8', '2025-06-11 19:30:24', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:30:24'),
('264d97774d8ea9c767e9fd133399966ffcbb34d0', '2025-06-10 23:02:00', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-06-10 23:02:00'),
('266c38c244d02ee8f14f8624bc0e03036ed9889e', '2025-06-19 10:34:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Sistem informasi pelayanan publik berbasis online/website ', '2025-06-19 10:34:09'),
('26a63993197476c4edaf6fa2acbe36af0f80ddf3', '2025-06-11 15:30:32', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 15:30:32'),
('26b7279c2a3a24ddcb00230bc396aafcda3d0395', '2025-06-19 11:29:44', 'INSERT', 'sultan', 'Tambah Data Parameter : Inovasi yang dilaksanakan sudah mendapatkan prestasi pada level (apapun)', '2025-06-19 11:29:44'),
('26e16df3d367a758c4c961d3aae72177e9a47eb1', '2025-06-20 14:27:55', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-20 14:27:55'),
('271813daff655ffa20527e3257635fde86c1dfe8', '2025-06-19 09:41:48', 'INSERT', 'sultan', 'Tambah Data Parameter : Pelaksana pelayanan menerapkan4 (empat)  unsur budaya pelayanan', '2025-06-19 09:41:48'),
('27eda75f364d7d3359e04bdee4518fa635af3466', '2025-06-20 14:51:06', 'DELETE', 'sultan', 'Hapus Data Indikator  : Tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-20 14:51:06'),
('280a77754a082b5e46191450a7da86a722d074c6', '2025-06-11 19:53:26', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:53:26'),
('2824e7ebbb0ffc9f9126ae65e27ed7adae05a3ac', '2025-06-19 10:24:51', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 5 atau lebih fasilitas penunjang', '2025-06-19 10:24:51'),
('28a80b1fdb98ec83757dc84e92e00ca471b617ab', '2025-06-20 14:49:07', 'DELETE', 'sultan', 'Hapus Data Indikator  : Tersedia sarana toilet pengguna layanan yang layak pakai', '2025-06-20 14:49:07'),
('28b686fcf594b6feaa1841fd4f60e6a43503ab4a', '2025-06-19 10:40:31', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik tidak terhubung secara daring', '2025-06-19 10:40:31'),
('28bdceffb58200570eab19610a46f9ea17c50d7d', '2025-06-23 15:12:37', 'LOGIN', 'USER', 'User Login :penilai kominfo', '2025-06-23 15:12:37'),
('29034e7fb1927f26444e6359bc9f0dd19d30bfb1', '2025-06-16 09:51:32', 'INSERT', 'soal', 'Tambah Data Parameter : Rata-rata nilai dimensi kinerja ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 30 poin', '2025-06-16 09:51:32'),
('293ebc0827c0628bae51fb73fb47e7259d5fd9b7', '2025-06-23 12:29:58', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 12:29:58'),
('294db48aa873273629d03b75d9e566378ba7b1ab', '2025-06-11 23:12:09', 'UPDATE', 'budker', 'update Data Parameter : Terdapat Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 23:12:09'),
('298004dab5dbb03ea695b50bb6f7f2ad3aac81c5', '2025-06-11 22:57:09', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : SK Tim Analisis dan Evaluasi Hukum terhadap Produk Hukum Perda/Perkada ,Indikator  : 9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-11 22:57:09'),
('298b698e51ba8cf57f0db42b8dd5de6d45d92e62', '2025-06-13 11:26:52', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Persentase Data yang Memiliki Metadata', '2025-06-13 11:26:52'),
('29aff23bac20d4d8fced8f48729361003d780f32', '2025-06-18 15:02:48', 'INSERT', 'sultan', 'Tambah Data Parameter : Rekomendasi hasil SKM ditindaklanjuti seluruhnya 9 bulan setelah laporan SKM diterbitkan   ', '2025-06-18 15:02:48'),
('2a0475ced00d2b1a53dc6fa1f039178bc01dda39', '2025-06-13 10:22:54', 'UPDATE', 'rb_renaksi', 'Edit Data Indikator : Telah Menggunakan Layanan Keuangan Berbasis Elektronik', '2025-06-13 10:22:54'),
('2acdeb737c8757ec6624582023fa8e1f7931a885', '2025-06-13 10:58:34', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SIPD (Penganggaran) ,Indikator  : d19c3e6ed374d12a978546f90608c9d155d319bd', '2025-06-13 10:58:34'),
('2ad18aab5620b149c482184a184ee4ec24748775', '2025-06-19 10:04:58', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-19 10:04:58'),
('2aeebf84885972507f70f8d986b35db5a2b2fd9d', '2025-06-16 09:17:18', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-16 09:17:18'),
('2b491257161513d5a9fe998d5d0cda95b7a2d482', '2025-06-20 14:44:29', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. Publikasi Waktu Pelayanan ,Indikator  : a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-20 14:44:29'),
('2b85001a023985e6b42c0322fab168cdfb83776d', '2025-06-10 19:52:07', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 19:52:07'),
('2ba025f79e957246e62676790ef049d9aece2cad', '2025-06-20 09:09:47', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : Berita Acara Tindaklanjut Hasil Pemeriksaan/ Laporan Rekapitulasi Tindaklanjut Hasil Pemeriksaan yang di keluarkan oleh BPK RI ,Indikator  : bdfdfe3ff3f049f04205f465b68af41adab5f10d', '2025-06-20 09:09:47'),
('2bdce16c48e2eb54966e6a26ec06d7816d978d44', '2025-06-19 09:38:47', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada pemberian penghargaan berdasarkan 1-2 unsur termasuk kinerja ', '2025-06-19 09:38:47'),
('2c9e6f2292b76d1dcec3a8c22cbbd00f90fb82cd', '2025-06-18 15:12:14', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia waktu pelayanan yang memudahkan pengguna layanan', '2025-06-18 15:12:14'),
('2cbdae851d35ee3537b49ce745314ed0452c1811', '2025-06-19 10:41:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Pemutakhiran data dan informasi pelayanan publik dilakukan secara mingguan ', '2025-06-19 10:41:19'),
('2cca99d85105e61532aab2ebbe81df47236ca444', '2025-06-18 14:56:44', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak dipublikasikan   ', '2025-06-18 14:56:44'),
('2d1837718da21ce9527f1f2240508f919a16aae2', '2025-06-19 09:41:15', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak adPelaksana pelayanan menerapkan 5 (lima) unsur budaya pelayanana pemberian penghargaan', '2025-06-19 09:41:15'),
('2d39ec4203bc79b4c14e8469666d68cd73a52a87', '2025-06-13 10:05:30', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Indeks Tata Kelola Pengadaan Barang/Jasa Perangkat Daerah Bobot : 100', '2025-06-13 10:05:30'),
('2d4fcaf70e259f5308a08462720324bbdfa4ec1c', '2025-06-18 14:42:51', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Maklumat Pelayanan yang sudah ditetapkan, isinya telah sesuai dengan peraturan perundangan yang berlaku, dan dipublikasikan pada media non elektronik dan elektronik ', '2025-06-18 14:42:51'),
('2d503f41afe98f9f11933b4c197e09af0386046e', '2025-06-13 10:16:35', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:16:35'),
('2d6fc43d18905b8866de8b89d5aa6db9b47cf236', '2025-06-13 09:51:53', 'INSERT', 'budker', 'Tambah Data Parameter : 41-60% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:51:53'),
('2db40c293df9644a6f9fffad7a1d0d71ba919507', '2025-06-18 14:33:57', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-18 14:33:57'),
('2e06067a9dc56ff39dce79a9ed8f682e26727fa5', '2025-06-18 11:26:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Dilakukan peninjauan ulang 2 tahun sekali terhadap seluruh jenis layanan ', '2025-06-18 11:26:19'),
('2e8f2ce63dedca15fc42b833ea7cd4333e179323', '2025-06-16 08:11:21', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Bukti Dukung Disesuaikan dengan jawaban', '2025-06-16 08:11:21'),
('2e951dada06bc4b9cb24112e99ee06f795cf7804', '2025-06-13 10:59:10', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SIPD (Penatausahaan Keuangan Daerah) ,Indikator  : e614f202a3b5c0ca97de18c5c2ab930593270a0b', '2025-06-13 10:59:10'),
('2e9deeb585c0000e24966606c95c2ffa83c0ae0c', '2025-06-13 11:34:11', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Nota Dinas, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Pusat Data Pemerintah Daerah ,Indikator  : fa2adebb9a3e011b8e751c4c58f0c8f9a5246304', '2025-06-13 11:34:11'),
('2ef684505fa1a4a54a9d311aecc4950a775056b0', '2025-06-23 12:30:48', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 12:30:48'),
('2f848d878aec3ef4a6c31f740528ad7554425ae6', '2025-06-11 22:40:59', 'INSERT', 'budker', 'Tambah Data Indikator : Laju Tindak Lanjut Penyelesaian Aduan', '2025-06-11 22:40:59'),
('302b8698379a2b0e954f500005d99f23c92093d4', '2025-06-11 18:42:09', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:42:09'),
('305a1ffe9c04bf2b0f0b35fa7928ca24d664b31b', '2025-06-13 11:21:26', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Pengaduan Pelayanan Publik Berbasis Elektronik', '2025-06-13 11:21:26'),
('307ada203083ab8908186d80fa21ac771c54e649', '2025-06-13 10:42:26', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:42:26'),
('30d62870ff54ddf1ca5820a0d0ff6e342ddddc58', '2025-06-11 23:03:34', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll ,Indikator  : 23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-11 23:03:34'),
('30e4cf7bd21005017ff082301979352740b344c4', '2025-06-19 11:30:07', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah ada inovasi lebih dari 1 tahun dan sudah diikutsertakan dalam kompetisi level apapun ', '2025-06-19 11:30:07'),
('310038fc6a20424ae291451a1db4cbde20bb0b84', '2025-06-24 09:36:18', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-24 09:36:18'),
('310d5d0febf25666198c69e6fca51ee5be2110d0', '2025-06-19 11:31:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Belum ada inovasi, masih dalam proses pembelajaran berinovasi ', '2025-06-19 11:31:14'),
('3149514e6d6d9b136d0f6d873113dac52959510c', '2025-06-16 11:42:17', 'UPDATE', 'soal', 'update Data Parameter : Laporan Pelaksanaan Penggunaan Produk Dalam Negeri pada Pengadaan Barang/Jasa Pemerintah melalui aplikasi SIPD P3DN dan Aplikasi Bigbox LKPP', '2025-06-16 11:42:17'),
('3158f6021985b0e521e5edc97b3bb1716cd033ec', '2025-06-19 10:36:28', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pendukung operasional pelayanan dengan lebih dari 4 kondisi', '2025-06-19 10:36:28'),
('315d9bf5d3ec29556b5549ab094f4a47264898b7', '2025-06-18 14:55:26', 'INSERT', 'sultan', 'Tambah Data Parameter : SKM dipublikasikan pada 4 (empat) media publikasi ', '2025-06-18 14:55:26'),
('317094aa89aac45d6171b96ff380a0d588384d1f', '2025-06-10 21:26:49', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 3.1 Tingkat Ketercapaian IKU Perangkat Daerah Bobot : 100', '2025-06-10 21:26:49'),
('3189c51b718417423fcdced28ae1db6da036d2b9', '2025-06-19 10:37:07', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pendukung operasional pelayanan dengan 3 kondisi', '2025-06-19 10:37:07'),
('31b8e2c39ea03f93fc8f2ef1b6585e411e3bc3a2', '2025-06-10 21:34:10', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 1. Indeks Kualitas Pelayanan Publik Bobot : 100', '2025-06-10 21:34:10'),
('31ddeee60e2b7212cfbccca12fa99216a3c03782', '2025-06-19 10:57:21', 'INSERT', 'sultan', 'Tambah Data Parameter : < 50% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai ', '2025-06-19 10:57:21'),
('320a3c6af5b8d687857840460bafc55233b8824f', '2025-06-18 10:59:32', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia Standar Pelayanan', '2025-06-18 10:59:32'),
('320e8dd772941ca84f5cba763295f411fb782cc7', '2025-06-16 09:51:12', 'INSERT', 'soal', 'Tambah Data Parameter : Rata-rata nilai dimensi kompetensi ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 40 poin', '2025-06-16 09:51:12'),
('3225829c52011fbf67dc9d402b33214f038cfb78', '2025-06-19 09:27:52', 'INSERT', 'sultan', 'Tambah Data Parameter : Memiliki kebijakan jam pelayanan/kerja dan 1 unsur lainnya   ', '2025-06-19 09:27:52'),
('326a24e2fd05ebd97c1433a4b937963d1d94e7ca', '2025-06-19 09:36:12', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 3 jenis mekanisme peningkatan motivasi kerja', '2025-06-19 09:36:12'),
('32c1666796cde99e662e31ee9d7a78027824c982', '2025-06-16 09:02:59', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Respon PD terkait Form Permintaan Data', '2025-06-16 09:02:59'),
('32d13682e11113d2ea23803947613ab73c765fce', '2025-06-19 10:50:54', 'INSERT', 'sultan', 'Tambah Data Parameter : Hanya terdapat media konsultasi dan pengaduan secara offline namun terpisah dengan front office    ', '2025-06-19 10:50:54'),
('331a0606286cb98c51fb0be61c36aeed2a2068ba', '2025-06-19 11:35:16', 'INSERT', 'sultan', 'Tambah Data Parameter :  Tersedia sistem antrian dengan 2 fasilitas', '2025-06-19 11:35:16'),
('334dc6babfc0488c13557664a8d3f6b9592f66b0', '2025-06-20 09:11:12', 'DELETE', 'muftyabyan', 'Hapus Data Indikator  : cccccc', '2025-06-20 09:11:12'),
('336b7d015520db3aca52d3213b2b54eed49d4f1e', '2025-06-11 22:47:50', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : SK Pembentukan Panitia Antar Perangkat Daerah ,Indikator  : 18bcf56fc86cf0bacb9716b241247e385b294376', '2025-06-11 22:47:50'),
('33bdfb31a836fab789442a638ca8860d0adc95ce', '2025-06-18 14:58:39', 'INSERT', 'sultan', 'Tambah Data Parameter : Tindak lanjut hasil SKM dilaksanakan lebih dari 80%, dibuktikan dengan laporan pelaksanaannya ', '2025-06-18 14:58:39'),
('34331639cff88b0ab9028fe8a5b921eb8f1ce611', '2025-06-10 21:20:54', 'DELETE', 'admin', 'Hapus Data Sub Sub Aspek  : Tingkat Kematangan Kapabilitas Proses', '2025-06-10 21:20:54'),
('34d894e24aecd415229e37d7b31d750b7a56babd', '2025-06-23 12:50:20', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:50:20'),
('3520c3a23606b280a0bdd5a24af8a7bd1a3869f2', '2025-06-19 08:54:49', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Nilai Hasil Evaluasi Internal Akuntabilitas Kinerja Internal', '2025-06-19 08:54:49'),
('358f730a32af727226c716a59f89ad21eb3d1ccc', '2025-06-13 11:58:24', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : List data prioritas dari masing-masing Perangkat Daerah (dari Bappeda) ,Indikator  : fb090dae0186365c93dd6a97bee9fc96fe7ac3fb', '2025-06-13 11:58:24'),
('36d8fdc265bd3618d4643b6d6f471564e472ece5', '2025-06-19 11:43:00', 'INSERT', 'soal', 'Tambah Data Parameter : Sistem Informasi berbasis elektronik telah memberikan manfaat dan direspon positif oleh pengguna layanan', '2025-06-19 11:43:00'),
('36ec7dfcbb27fd581bc533d87bde6f9a87c4e204', '2025-06-11 17:44:55', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 17:44:55'),
('3731fd62883c067518d05ed6aa5b85aa4c7556ea', '2025-06-13 11:37:27', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 11:37:27'),
('37b02d74a0de018325ac92f61c5e832f39775b5a', '2025-06-20 14:52:00', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 3. SDM (SK Perorangan dan /atau tim yang menginisiasi penciptaan inovasi  ,Indikator  : bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-20 14:52:00'),
('37f1f52504fad4f13d9f06210470d9fe6f3b619b', '2025-06-13 13:12:45', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 13:12:45'),
('38514665ad4062fb3ea8757ab0bce9b19832c6a3', '2025-06-16 11:43:26', 'DELETE', 'soal', 'Hapus Parameter  : Data dan Informasi Capaian Kinerja RB Tematik yang disampaikan akan disandingkan dengan data dan informasi dari eksternal seperti; data BPS, data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah B. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai) C. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan D. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan E. Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '2025-06-16 11:43:26'),
('3858a0d7864ceeee2b0629ad83102c1985070581', '2025-06-20 09:57:38', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : 26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-20 09:57:38'),
('386c7ad8f68db29f70925f1104dbe7f3ee96698a', '2025-06-16 09:51:55', 'INSERT', 'soal', 'Tambah Data Parameter : Rata-rata nilai dimensi disiplin ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 5 poin', '2025-06-16 09:51:55'),
('387bd13b61d2e4aeedfebbe78c8a99314f479811', '2025-06-11 22:36:25', 'INSERT', 'budker', 'Tambah Data Indikator : Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:36:25');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('388a014c628273e79e25a3f72aa596d61bcc45c5', '2025-06-20 09:35:51', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                                     2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dok ,Indikator  : b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-20 09:35:51'),
('38a20c4c9cfbf4117916d3eab6f155e0447d0b2a', '2025-06-18 09:54:02', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-18 09:54:02'),
('39b3e93e6e966e4fa87257b7b5e1fcc2f069d1bb', '2025-06-11 10:34:29', 'UPDATE', 'admin', 'update Data Parameter : Proses pembangunan/pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', '2025-06-11 10:34:29'),
('39d3e0f7af92f59699908cac72d3ce2b88c26047', '2025-06-20 10:15:04', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-20 10:15:04'),
('39dbf4b7aeb8694bc4ab0d5baf2b6cbbd80fba24', '2025-06-19 09:17:11', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Tindaklanjut Hasil Pemerikaan BPK RI', '2025-06-19 09:17:11'),
('3ac5b1882d582c232756632348943bcde00818a9', '2025-06-11 09:44:15', 'DELETE', 'admin', 'Hapus Parameter  : F. Belum dilakukan Pencanangan Zona Integritas', '2025-06-11 09:44:15'),
('3b9fd8461a769b77e29daa0d57e188a1b7b8db61', '2025-06-18 14:51:43', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik ', '2025-06-18 14:51:43'),
('3bd2f322405e0fb39fa0bec65d85ba987f3c3017', '2025-06-10 23:27:39', 'UPDATE', 'admin', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-06-10 23:27:39'),
('3c1912d7e1d6e1b14ae0056c73116aa69df53935', '2025-06-19 10:39:09', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik berbasis website/aplikasi yang mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami, merupakan kanal digital resmi pemerintah (domain.go.id) ', '2025-06-19 10:39:09'),
('3c98a22357a0634094557fb9c8e55d5e9feb7958', '2025-06-18 10:42:06', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia Standar Pelayanan (SP) sesuai dengan ketentuan peraturan perundang-undangan yang berlaku', '2025-06-18 10:42:06'),
('3d367441297baf67569a6082d059750af4418dd0', '2025-06-10 22:41:29', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Layanan Jaringan Intra Pemerintah Daerah', '2025-06-10 22:41:29'),
('3d43d8c46257306dbab659cfb9bac0f0c38fa272', '2025-06-23 14:51:40', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 14:51:40'),
('3e077c5dedb9f8bf056743e243d60c41c6138399', '2025-06-16 10:48:50', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 10:48:50'),
('3e2942123eafb9e515567c14cd6bcbb03c0e699f', '2025-06-11 18:42:46', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 18:42:46'),
('3e401c76b13d697aefe086146cfc6c1eb4b4983b', '2025-06-10 23:24:06', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 23:24:06'),
('3ecad2aae0d112d797b6357d5ad8d5a6b857ffa5', '2025-06-13 11:41:03', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 11:41:03'),
('3ee02716fe968ac923a2487250d013c2b129406b', '2025-06-19 10:44:21', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana konsultasi dan pengaduan secara tatap muka yang berkualitas', '2025-06-19 10:44:21'),
('3f5474a2ecc7948515f3c594e44d9723e56ddae9', '2025-06-12 10:08:05', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-12 10:08:05'),
('3f634c90bf53d9d7733a8e4fb11212fd05c55d84', '2025-06-10 23:36:05', 'INSERT', 'undata', 'Tambah Data Jawaban : 7e72378453db872783e97cb2e37bc1442a36d51bParameter : a) Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-10 23:36:05'),
('3fdd38d72162a1dd762c05ddb219cfeb80e41752', '2025-06-13 15:06:09', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 15:06:09'),
('40665307993f10b53a4c5020b27a31e24ef08c3f', '2025-06-13 11:07:11', 'INSERT', 'budker', 'Tambah Data Parameter : 1. Nilai 90 s.d. 100 dengan kategori AA (Sangat Memuaskan) 2. Nilai lebih dari 80 s.d 90 dengan kategori A (Memuaskan) 3. Nilai lebih dari 70 s.d 80 dengan kategori BB (Sangat Baik) 4. Nilai lebih dari 60 s.d 70 dengan kategori B (Baik) 5. Nilai lebih dari 50 s.d 60 dengan kategori CC (Cukup) 6. Nilai lebih dari 30 s.d 50 dengan kategori C (Kurang) 7. Nilai 0 s.d 30 dengan kategori D (Sangat Kurang)', '2025-06-13 11:07:11'),
('407597bdbd9e872b8645b9c06e4129141ae2cf23', '2025-06-13 12:01:03', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 12:01:03'),
('40eccf7ed8e16068c8adb4ab827b49d394089c49', '2025-06-19 11:38:14', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-19 11:38:14'),
('412e16a8eb0359de85dc91dc850a7603f2ede81a', '2025-06-10 22:11:37', 'INSERT', 'admin', 'Tambah Data Indikator : j) Telah menerapkan Manajemen Risiko SPBE', '2025-06-10 22:11:37'),
('4154c6acc08ec38df26200d6bebba2e2ec82df15', '2025-06-11 23:18:28', 'UPDATE', 'budker', 'update Data Parameter : Terdapat SK Pembentukan Panitia Antar Perangkat Daerah', '2025-06-11 23:18:28'),
('416a4ca885983f0b54841bb4d96c4129cd2291c4', '2025-06-16 08:08:48', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi perencanaan', '2025-06-16 08:08:48'),
('419a609d9b9b095adecfb49dd4e2e31044fa4504', '2025-06-23 12:46:10', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:46:10'),
('41d564dc576b214037b49219e051507cbd2df2b7', '2025-06-10 23:27:15', 'UPDATE', 'admin', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-06-10 23:27:15'),
('41d6d0a58af39fa353cee6f65bb7782f87d46050', '2025-06-11 22:32:43', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Surat Keputusan/Surat Perintah Tim Pengelola SP4N Lapor Perangkat Daerah Bobot : 10', '2025-06-11 22:32:43'),
('4269ecfc98f47962868bfded0704f4f4a41faa09', '2025-06-19 09:59:16', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-19 09:59:16'),
('426da98f21e4140ae770c4b305b332184bd71eb2', '2025-06-16 10:33:42', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE atau Laporan Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE yang dikeluarkan oleh Biro PBJ ,Indikator  : a92b34d679d1c6f6e5aecc60bf20e8819b4c33b1', '2025-06-16 10:33:42'),
('4285119a67c436d2d5402aeb6deaf580a87c470f', '2025-06-10 19:03:34', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-10 19:03:34'),
('42f47c8d3df4324145e8e3b1aa8a4a1603aaf941', '2025-06-19 10:18:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia fasilitas wajib  ', '2025-06-19 10:18:41'),
('4313b5cd04ef3f257ac60d0c1164c64c6e4116f2', '2025-06-19 10:06:20', 'INSERT', 'sultan', 'Tambah Data Indikator : Sarana Front Office (FO) Informasi di unit layanan', '2025-06-19 10:06:20'),
('43273b3ee1a3cec4c2232f7375fc5890f70604ec', '2025-06-18 10:02:47', 'INSERT', 'sultan', 'Tambah Data Parameter : Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '2025-06-18 10:02:47'),
('432a67549b14c411670a57b1bf62c7e1e772a9a1', '2025-06-11 19:54:52', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 19:54:52'),
('435a36fc69ef16775b438a7575f53177d7ad75f8', '2025-06-20 10:02:31', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017ut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017okumentasi)   ,Indikator  : 1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-20 10:02:31'),
('4379ab1542e483736c7a6a4955f44cc75a2b5ae7', '2025-06-10 20:24:08', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-10 20:24:08'),
('439cb964b10779e69295992bc886ae2803abb8d1', '2025-06-10 22:52:49', 'INSERT', 'admin', 'Tambah Data Parameter : A. Telah memperoleh predikat menuju WBBM', '2025-06-10 22:52:49'),
('43d57e5d591902e434041378aea263a424d2d6ff', '2025-06-11 18:40:04', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:40:04'),
('443729b16eee28a1f62a2d83ce2d6df4b6cb2b87', '2025-06-11 14:03:06', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 14:03:06'),
('44605091f533ca68c6e1eef7f8daf1d36e4da43c', '2025-06-20 09:05:36', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal ,Indikator  : 26dabc885d6a369ceab60d138385533a50a22958', '2025-06-20 09:05:36'),
('448fced51ef9897a385f40ae38effa6edf967a28', '2025-06-19 09:02:12', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian besar IKU Perangkat Daerah tercapai (>50%)', '2025-06-19 09:02:12'),
('44998f9f9f0be3bb253de54d1d8f6a5874682ada', '2025-06-18 10:17:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Telah dilaksanakan evaluasi oleh TPN', '2025-06-18 10:17:09'),
('44a6ffe68769a925fc8957fdfa94592be79f5b94', '2025-06-23 13:29:25', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 13:29:25'),
('44ef327cf7687c66bfb065d592545254e97d96b2', '2025-06-10 23:34:30', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-10 23:34:30'),
('44fcc26c32330eae10641997780a1924a9f45796', '2025-06-13 08:43:00', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 08:43:00'),
('45693200b9486da967e31882a5a8b6df200efc7e', '2025-06-13 11:03:21', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 11:03:21'),
('4577b1d61a993e32e616c567d621a01f755118ac', '2025-06-16 10:43:11', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Cascading Kinerja Penyelenggaraan urusan yang menjadi core Bisnis Perangkat Daerah pada Bidang Teknis Perangkat Daerah ,Indikator  : 4581da6e1cc226decb6a880b7d4b68e1b553a520', '2025-06-16 10:43:11'),
('4621b1b47d4620aba0db95c1ceaf129745019e6a', '2025-06-18 10:47:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia SP yang memenuhi 14 komponen, melibatkan masyarakat dalam penyusunan SP, dilakukan penetapan, dan dilakukan monev ', '2025-06-18 10:47:19'),
('462ccefee182dfc69829b96190bd7b9ac0dc453f', '2025-06-19 10:28:04', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sarana FO informasi layanan dengan 4 fasilitas', '2025-06-19 10:28:04'),
('4633de08f0e7996018f8d62e9303f7bb6747a0ba', '2025-06-23 12:37:41', 'UPDATE', 'undata', 'Update Data Jawaban : 865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-23 12:37:41'),
('46501f560e8977dc4ec96ab65915cd71f33ef1bd', '2025-06-10 22:53:28', 'INSERT', 'admin', 'Tambah Data Parameter : B. Telah memperoleh predikat menuju WBK', '2025-06-10 22:53:28'),
('46a04c96ccb1f1292503b10475bac37154ebf969', '2025-06-19 11:41:33', 'INSERT', 'soal', 'Tambah Data Parameter : Menyampaikan/melaksanakan Continouous Improvment penerapan Sistem Informasi berbasis elektronik yang telah terintegrasi dalam satu sistem (single sign on)', '2025-06-19 11:41:33'),
('46c8511d56c4b3d81e38690c8c4f2088c2164ded', '2025-06-13 10:43:36', 'INSERT', 'budker', 'Tambah Data Parameter : Jumlah Pengaduan dibawah 5 aduan', '2025-06-13 10:43:36'),
('46eb8cee3f95e7ce93d6769ebc70180b4eb251a2', '2025-06-18 10:16:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Telah memperoleh predikat menuju WBK', '2025-06-18 10:16:13'),
('47158d06ec09638a0b04cd71a817684b320addfc', '2025-06-23 12:51:59', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:51:59'),
('472fea6a5ee0fc88ab675d3d55ebf903145790a7', '2025-06-11 19:28:06', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:28:06'),
('4750bee88ce766e9f3e2eb7153fae7e44615864b', '2025-06-11 23:58:00', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-11 23:58:00'),
('4761ae2ae8f11afc645042ef378b84b1f2b1825f', '2025-06-19 10:20:54', 'INSERT', 'sultan', 'Tambah Data Parameter : Toilet pengguna layanan dengan 2 kondisi  ', '2025-06-19 10:20:54'),
('476e78f01f6ad9f32b0b271537e9040317d5c92e', '2025-06-19 10:22:14', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Screenshot media Publikasi SP4N-LAPOR pada website, media sosial; ,Indikator  : 23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-19 10:22:14'),
('4795cc4d6a46f49cfcf24d0f37c34f38d3d763c0', '2025-06-18 14:44:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Maklumat Pelayanan yang sudah ditetapkan dan isinya telah sesuai dengan peraturan perundangan yang berlaku ', '2025-06-18 14:44:35'),
('479b964c3f4225187869570f3caf2ce888d04203', '2025-06-19 11:42:11', 'INSERT', 'soal', 'Tambah Data Parameter : Sistem Informasi berbasis elektronik telah mengintegrasikan seluruh/sebagaian layanan dalam satu sistem (single sign on)', '2025-06-19 11:42:11'),
('47de47105d3eeca3af4394868e58ffe1dcabdf11', '2025-06-13 10:01:00', 'DELETE', 'admin', 'Hapus Parameter  : vvvv', '2025-06-13 10:01:00'),
('47fda19d9c400c27ef5e43dd274d95786a2e19c2', '2025-06-10 22:54:53', 'INSERT', 'admin', 'Tambah Data Parameter : E. Telah dilaksanakan Pencananangan ZI Unit Kerja', '2025-06-10 22:54:53'),
('481eb2fa12aeb224d9b855155817f504eb792b5d', '2025-06-19 10:34:49', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pelayanan publik non elektronik melalui media lisan (pusat informasi) serta media papan pengumuman dan media cetak ', '2025-06-19 10:34:49'),
('488da8da8fa463e8cc5a160814ba09f7647d0602', '2025-06-13 09:47:31', 'INSERT', 'budker', 'Tambah Data Parameter : Evaluasi Produk Hukum dilakukan 2 (dua) kali dalam satu tahun anggaran', '2025-06-13 09:47:31'),
('48952e3ce0e1ee7ba945f712cb72d4379f664119', '2025-06-20 14:59:22', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan Fasilitas Penunjang (Fotokopi/ATK, Kotak P3K, APAR, Kantin, Ruang Ibadah, Area Merokok, Jalur Evaluasi, Tempat Sampah dan CCTV) ,Indikator  : e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-20 14:59:22'),
('4945d205c58c938d3db13af1288edf0700059080', '2025-06-10 22:12:56', 'INSERT', 'admin', 'Tambah Data Indikator : m) Telah melaksanakan Manajemen Data', '2025-06-10 22:12:56'),
('4989a76be778fac0c0ad7059bb081aed1daf64a7', '2025-06-20 14:39:41', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. SK/Peraturan yang berlaku terkait Penetapan Jam Kerja (Hari Kerja, Penambahan waktu diluar jam kerja ataupun kondisi tertentu) ,Indikator  : a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-20 14:39:41'),
('499fdba26dcada5bdf993cad3c1f1301543f0f5e', '2025-06-13 11:42:24', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Surat Perintah Tim Pengelola TIK/SPBE/Tim Layanan Digital ,Indikator  : c6ddd5c9cfb225fc4881f98607ebc677a34fd715', '2025-06-13 11:42:24'),
('49d483eae140f4fb286f8fdc97e61d5b64c84ad7', '2025-06-19 10:19:44', 'INSERT', 'sultan', 'Tambah Data Parameter : Toilet pengguna layanan dengan lebih dari 4 kondisi ', '2025-06-19 10:19:44'),
('4ac0556666acb39c032631363dee511d4b8a5891', '2025-06-10 22:24:45', 'INSERT', 'admin', 'Tambah Data Parameter : B. Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', '2025-06-10 22:24:45'),
('4ac9f93458183ea0fae97d0c7f5527f234c18a3f', '2025-06-19 11:32:31', 'INSERT', 'sultan', 'Tambah Data Parameter : Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 2 kondisi lainnya ', '2025-06-19 11:32:31'),
('4ace701d58e941a5cccd1491e78611c414cd4072', '2025-06-18 15:13:06', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia Kode Etik dan Kode Perilaku Pelaksana dan/atau Budaya Pelayanan di lingkungan instansi', '2025-06-18 15:13:06'),
('4ae2db4dfb3e1e7788a713820dfc5bb63c67fe33', '2025-06-13 11:55:02', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan JDIH (cek regulasi PD yang telah diterbitkan), Website/Sistem Informasi dari PD yang sudah diintegrasikan dengan JDIH khusus untuk produk hukumnya ,Indikator  : 05e92a67e5198493e3c0845daa851f48bad80241', '2025-06-13 11:55:02'),
('4b2e33b5b81bb93b114bc5b3343e860627e7daab', '2025-06-11 09:38:23', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 09:38:23'),
('4c3b62042f036e85f71cc27bd1cb71584c2eb4c2', '2025-06-10 20:03:22', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 7. Nilai Survei Kepuasan Masyarakat Bobot : 100', '2025-06-10 20:03:22'),
('4c5357239583184746ba12c3771c23bdb1555abb', '2025-06-13 11:17:19', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Akuntabilitas Kinerja Organisasi Berbasis Elektronik', '2025-06-13 11:17:19'),
('4c556f87c266dd495ddb07d8c46cc9c7ed3acef8', '2025-06-11 15:11:42', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 15:11:42'),
('4c78eb844745862cf2cc6f38971a5b83a5d5d7d3', '2025-06-23 12:47:39', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 12:47:39'),
('4c919f28dbac0d620f3dd58d38adf5bf9dcee437', '2025-06-16 10:46:49', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-16 10:46:49'),
('4cd03375bd346c5daf702b07021e60e23fa7a043', '2025-06-23 13:28:34', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 13:28:34'),
('4d09f0728e7df1754ced07125d01041ace9a7933', '2025-06-11 19:54:19', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 19:54:19'),
('4d5a139750da93d26d9341ae4a60761b91c30e20', '2025-06-13 11:51:35', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan Aplikasi SPIP ,Indikator  : b5c441f52388bcbb8ee5b4b1ac6dae1ff1da918e', '2025-06-13 11:51:35'),
('4d625bf9944dfda497d19add5abbfe5ee68672d7', '2025-06-11 22:29:28', 'UPDATE', 'budker', 'Update Data Sub Aspek : Tingkat Digitalisasi Arsip Bobot : 100', '2025-06-11 22:29:28'),
('4d9ffde867c4951fb2ece8887b994bd4ec1d5107', '2025-06-18 09:09:32', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-18 09:09:32'),
('4db6f3ea80bdc1368bd70d28ef0b11cb3a323bd3', '2025-06-18 11:03:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP telah melibatkan lebih dari 4 unsur masyarakat ', '2025-06-18 11:03:35'),
('4dd855060e8b25f1f192691ec69fc3c414b8630d', '2025-06-20 10:01:51', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)   ,Indikator  : 1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-20 10:01:51'),
('4e10c1864b7e67a2eb8294bb5600ddc72afe4592', '2025-06-11 19:28:03', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 19:28:03'),
('4e1be06cebfd8d48628bf39ed8c8f756527cd9c5', '2025-06-23 12:37:41', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1750653461_c122e1e653be107480eb.pdf ,bukti Dukung  : a545414d3973c500bb8de04f03ba89a387564b52', '2025-06-23 12:37:41'),
('4e2bdeddeb988ba66058738c092720210702800c', '2025-06-19 10:31:06', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sistem informasi pelayanan publik untuk informasi publik', '2025-06-19 10:31:06'),
('4e30b93107e2dbd3c194f297d8019900a92ec755', '2025-06-19 10:22:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 7-9 sarana prasarana bagi pengguna layanan kelompok rentan ', '2025-06-19 10:22:58'),
('4e808bc6e9b850a19733fe4d3f7f87a2c0334201', '2025-06-19 09:39:07', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada pemberian penghargaan berdasarkan 3-5 unsur kecuali kinerja ', '2025-06-19 09:39:07'),
('4eedcac90575c0d712da4142c668dc782aa22f78', '2025-06-11 22:39:04', 'INSERT', 'budker', 'Tambah Data Indikator : Tindaklanjut Hasil Evaluasi Produk Hukum', '2025-06-11 22:39:04'),
('4fdcc8f628a0b1e3dc6fa9b6ebdd77557af4b5a5', '2025-06-13 10:14:48', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:14:48'),
('501460cb5441f1e0bef27df9e6a9b2303d801164', '2025-06-13 11:30:44', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-13 11:30:44'),
('50181dfa823470eb19aef11c528c2cc91b9e85a1', '2025-06-13 11:22:57', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan SP4N-LAPOR', '2025-06-13 11:22:57'),
('50569c50d52dda0af15854fe9b130c0a7bdee353', '2025-06-10 22:59:36', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Sistem Penghubung Layanan Pemerintah Daerah', '2025-06-10 22:59:36'),
('507e9b4931cecd33513485e158f8cf43f8821b01', '2025-06-13 11:16:26', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Pengawasan Internal Pemerintah Berbasis Elektronik', '2025-06-13 11:16:26'),
('5098f3206a5a4148d5e0e6d22cac8f939be73fd4', '2025-06-10 22:31:45', 'INSERT', 'admin', 'Tambah Data Parameter : B. Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', '2025-06-10 22:31:45'),
('509ba8399c956471ff2cbf1ae4b25fe040b00645', '2025-06-13 11:51:07', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan Aplikasi Aset ,Indikator  : f2633c69c8df08f548c62656ab0a76483ba25942', '2025-06-13 11:51:07'),
('50b68a9ce862911b4ea2d333ff50cca437ed279f', '2025-06-20 14:57:54', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Dokumen tindaklanjut dari hasil Konsultasi ataupun pengaduan yang masuk ,Indikator  : b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-20 14:57:54'),
('5177b84c4a763dc63f36c7acf8e00538bc310f93', '2025-06-13 11:58:53', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen jumlah data prioritas yang telah terupdate (per 31 Desember n-1/tahun sebelumnya) pada 30 Juni tahun berjalan ,Indikator  : fb3fb9de5de3842714c3b79c47bf40fe774778f9', '2025-06-13 11:58:53'),
('519fc2210b017adc14f3da01255890919a11db60', '2025-06-11 14:10:05', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 14:10:05'),
('51a2bfffdf9621da04e7ecbb4476846600087a41', '2025-06-13 09:21:49', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:21:49'),
('51c0605fe5d29a462f4c3aff7b9f12f7a92ab19c', '2025-06-19 09:07:53', 'DELETE', 'muftyabyan', 'Hapus Parameter  : Seluruh IKU Perangkat Daerah tercapai (100%)', '2025-06-19 09:07:53'),
('51f2a6759c84d0942c0ebdb545022ae84aede489', '2025-06-16 09:55:48', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Persentase Capaian Rencana Aksi Pembangunan RB General Bobot : 100', '2025-06-16 09:55:48'),
('5209b90540675aa9933b4898550c2b2b86a55e33', '2025-06-18 11:10:58', 'INSERT', 'sultan', 'Tambah Data Indikator : Telah dilakukan peninjauan ulang secara berkala terhadap Standar Pelayanan', '2025-06-18 11:10:58'),
('527baf223448faddc7393338421ba0f66f2fd1d8', '2025-06-10 20:02:32', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 5. Laporan Realisasi APBD Perangkat Daerah Bobot : 100', '2025-06-10 20:02:32'),
('52b3425e57acbfefc21434fdee711a1d726deda7', '2025-06-13 10:26:52', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan Sistem Informasi Penatausahaan Keuangan Daerah (SIKD) ', '2025-06-13 10:26:52'),
('52c80cb8f206064b400557eee8850dfd58506eb0', '2025-06-19 09:59:46', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana prasarana penunjang', '2025-06-19 09:59:46'),
('53304661db647de6e923b57dd9f4307e43fd7c26', '2025-06-13 11:19:12', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan e-SAKIP/Saliara', '2025-06-13 11:19:12'),
('53319bbec0c51e36df92ce47f862a433e5f4d6c8', '2025-06-20 09:59:21', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014  ,Indikator  : 222918ef0072144df43126dd42d8946bfe37329e', '2025-06-20 09:59:21'),
('5345ad70e2b1c463ce948c98b7f8d5fd35370d64', '2025-06-10 23:29:25', 'UPDATE', 'admin', 'update Data Parameter : Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', '2025-06-10 23:29:25'),
('5369f0689fdfb67d40bf85229e64859532b12178', '2025-06-13 10:23:33', 'UPDATE', 'rb_renaksi', 'Edit Data Indikator : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:23:33'),
('53759210ecd119d49d4016598ad7e88b4a611149', '2025-06-14 19:15:45', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-14 19:15:45'),
('53d78d38365b43404c1acbe2f4e072869d743e1c', '2025-06-13 11:54:34', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Respon PD terkait Form Permintaan Data ,Indikator  : 7ced43deb489a53e67d08903c1d91d85b86de1f3', '2025-06-13 11:54:34'),
('53e37f8d60b19a40ea5cba685f02f6e1893b5c03', '2025-06-20 10:00:02', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : 222918ef0072144df43126dd42d8946bfe37329e', '2025-06-20 10:00:02'),
('547ae723be809bf734b8b20e55c5ee4e339f936c', '2025-06-13 10:44:03', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:44:03'),
('54a7a50b994396c7f11528a5dcea326041cb90f1', '2025-06-19 13:50:51', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4.4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 13:50:51'),
('555a1ade5d63ba693eb2d6814cdcb38e3b67241d', '2025-06-19 10:45:10', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia akuntabilitas hasil konsultasi dan/atau pengaduan', '2025-06-19 10:45:10'),
('55c28b674a045db7bca9831785e42880653f1a50', '2025-06-20 14:52:41', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Ketersediaan mesin antrian ,Indikator  : 91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-20 14:52:41'),
('56022d90579355f861284a61e5ad69487c89ba6d', '2025-06-20 09:56:50', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014       ,Indikator  : 26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-20 09:56:50'),
('566b0df47c6e2a53acb64c33e62044c7a178509a', '2025-06-10 21:47:42', 'INSERT', 'admin', 'Tambah Data Indikator : d) Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-06-10 21:47:42'),
('56f11894c0beadb22ff4e7f70ace7812331b008a', '2025-06-20 14:43:33', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 1. SK Launching / Penetapan Pelaksanaan Inovasi ,Indikator  : c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-20 14:43:33'),
('5709c7d03c13a649e829b89c8e82ab523d4acafa', '2025-06-18 10:09:55', 'UPDATE', 'sultan', 'update Data Parameter : Diisi dengan Nilai Hasil Survey Kepuasan Masyarakat terhadap layanan Perangkat Daerah', '2025-06-18 10:09:55'),
('57238a8e27293e17443cbfc379a13ed44ef11892', '2025-06-19 11:43:44', 'INSERT', 'soal', 'Tambah Data Parameter : Sistem informasi belum berfungsi/belum dapat digunakan/belum dapat diakses (sistem masih dalam bentuk konsep pengembangan atau prototype)', '2025-06-19 11:43:44'),
('5785e5022db641736e2e02b36f230facc7ce0348', '2025-06-13 08:59:21', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 08:59:21'),
('57ca9676cfd580e8b306e8eb16defed07a7d5f4f', '2025-06-11 20:16:05', 'INSERT', 'admin', 'Tambah Data Indikator : cccccc', '2025-06-11 20:16:05'),
('57ea985e4632287bc0b193272e1cb98743dd6c14', '2025-06-11 13:53:36', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 13:53:36'),
('57ff70ebb8afe627e3fea74ee0e15d739957f316', '2025-06-13 09:47:14', 'INSERT', 'budker', 'Tambah Data Parameter : Evaluasi Produk Hukum dilakukan lebih dari 2 (dua) kali dalam satu tahun anggaran', '2025-06-13 09:47:14'),
('5815c09874b94356723ad1664f99a7dc92efd5e3', '2025-06-20 14:52:18', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Dokumentasi Pelaksanaan Kegiatan Peningkatan Motivasi, antara lain dengan pemberian penghargaan, pemberian kesempatan mengikuti diklat, beasiswa, konseling, maupun mekanisme lainnya yang dapat meningkatkan motivasi kerja pegawai ,Indikator  : cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-20 14:52:18'),
('581fc7fb6557fd2ec7f05ed5ca877b73bff2c4df', '2025-06-23 12:42:26', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:42:26'),
('5825a29c5c481bb265fb6f4e149c8d7af4e7e4c2', '2025-06-19 09:15:32', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-19 09:15:32'),
('5883e18ad4f5347683d329e2cbba4957b96e39bb', '2025-06-19 10:05:42', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana prasarana penunjang', '2025-06-19 10:05:42'),
('5898a58ad8174a4e2cdb1484cadb7dee4a09d311', '2025-06-13 11:23:42', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah memiliki layanan berbasis elektronik sesuai dengan core bisnis Perangkat Daerah', '2025-06-13 11:23:42'),
('58cd2609f38c7bc553b420d0955bcee2fc60792c', '2025-06-16 09:57:10', 'INSERT', 'soal', 'Tambah Data Parameter : Laporan Capaian Indikator Kinerja Sekretaris Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah/Raport Kinerja Perangkat Daerah pada Lingkup Sekretariat Perangkat Daerah', '2025-06-16 09:57:10'),
('591a4cc6c40a171f3300525b21bc9847775e0fd8', '2025-06-19 14:01:53', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 14:01:53'),
('5929a358f0167ab36e93934b9b7f6674dff2374e', '2025-06-11 10:11:31', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 10:11:31'),
('59b8a664a1e0e39758e099fcd2e864f4aaa7ad26', '2025-06-16 10:13:37', 'INSERT', 'soal', 'Tambah Data Indikator : Tingkat Penerapan Digitalasasi Administrasi Pemerintahan dalam Pelaksanaan Tugas Pokok dan Fungsi ', '2025-06-16 10:13:37'),
('59c09ac4a7315efb8ebe091cb991f1da7ffcf786', '2025-06-13 10:47:17', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:47:17'),
('59c26adef78527ebb574fea94cc25d0a5a15abfc', '2025-06-11 10:52:00', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 10:52:00'),
('59d7e4d69315f217a90b3796b62a59d1ef35081d', '2025-06-12 08:32:12', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-12 08:32:12'),
('5a20be0ed19af7ca0c9ab2056312f4a696abee91', '2025-06-16 11:02:49', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi- ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-16 11:02:49'),
('5a53993d43161cf67e9e934e27396c982370689f', '2025-06-10 23:02:46', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Manajemen Aset TIK', '2025-06-10 23:02:46'),
('5aa7c00e80148043d10c057ff59428002858b775', '2025-06-19 10:32:26', 'INSERT', 'sultan', 'Tambah Data Indikator : Pemutakhiran data dan informasi kanal digital', '2025-06-19 10:32:26'),
('5b0ad93e9700c4d497e3b3fd31ef2c829597de52', '2025-06-19 11:35:46', 'UPDATE', 'soal', 'Edit Data Indikator : Tingkat Penerapan Digitalasasi Administrasi Pemerintahan dalam Pelaksanaan Tugas Pokok dan Fungsi ', '2025-06-19 11:35:46'),
('5b25a4ed8bae2f9eec2791763b2cb7b965919cfe', '2025-06-13 10:16:08', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:16:08'),
('5b58480beb6d6a2ec8530650990c7cc96c0190c9', '2025-06-20 14:59:08', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot  dari Sistem Informasi yang dimiliki (SIPPN) ,Indikator  : ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-20 14:59:08'),
('5ba545233f386ed639c763e5d11c0e5decdd76ce', '2025-06-16 08:49:22', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) 5. Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasion ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-16 08:49:22'),
('5be42a2d0506baadded3adb33d45cfc2f7e20168', '2025-06-10 22:27:48', 'INSERT', 'admin', 'Tambah Data Parameter : A. Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', '2025-06-10 22:27:48'),
('5c38d05e6b98cdcfa470e1948ed72b254c860cdb', '2025-06-20 14:38:58', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-20 14:38:58'),
('5c5222f103deb233601ce2603ebd95e57c3a1f3a', '2025-06-10 22:55:23', 'INSERT', 'admin', 'Tambah Data Parameter : F. Belum dilakukan Pencanangan Zona Integritas', '2025-06-10 22:55:23'),
('5c53c41e3297695d75752c3e55693c0cbed693e2', '2025-06-23 13:28:26', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 13:28:26'),
('5ce0d0df258fbc291efd23fe2b234538bb28ad73', '2025-06-10 23:21:31', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 23:21:31'),
('5d20fbe3549c41fffedd44c64638de6bcd5d1cbe', '2025-06-16 09:27:14', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : LHE Penilaian Kearsipan Internal (LAKI) Masing-masing perangkat daerah yang dikeluarkan oleh Dinas Perpustakaan dan Kearsipan Daerah  ,Indikator  : 936328e1dfe004e577c7e26d41681bd365fc6f09', '2025-06-16 09:27:14'),
('5d83b412af6ad0bb723b7963cb7de650498b6307', '2025-06-13 10:02:03', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Keuangan Berbasis Elektronik', '2025-06-13 10:02:03'),
('5dd62af263e25772b9131d0fa91b8d52532cce97', '2025-06-19 10:48:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia Sarana konsultasi pengaduan pengguna layanan', '2025-06-19 10:48:41'),
('5ddd4c26f96a47143545158f00a4a260a7441d9a', '2025-06-20 15:00:03', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : etersediaan Fasilitas Front Office  (Petugas Khusus, Meja/Kursi, Layar Display Informasi, Bahan Cetak Informasi layanan, serta Register Tamu baik manual maupun elektronik) ,Indikator  : 1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-20 15:00:03'),
('5fa4a3223a393517cc0721f648620f9a93e23d3a', '2025-06-20 09:03:55', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Laporan Hasil TIndak Lanjut Survey Kepuasan Masyarakat/screenshoot Aplikasi SKM Terintegrasi Real-Time Tahun Sebelumnya ,Indikator  : 4c8378c214c94d9085e88f953e0199ba8feae24c', '2025-06-20 09:03:55'),
('5fefa2a631ce3e5c1025a4ea425d697ab9e9915d', '2025-06-19 11:33:30', 'INSERT', 'sultan', 'Tambah Data Parameter : Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk rancangan payung hukum ', '2025-06-19 11:33:30'),
('600e28e7e70b84f7c8c434518b4afac9d43ec1ae', '2025-06-23 10:57:21', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-23 10:57:21'),
('602af2005d05a9148309a4bbf6e4100f80b1c3a5', '2025-06-11 09:41:10', 'UPDATE', 'admin', 'Update Data Form : LKE REFORMASI BIROKRASI PERANGKAT DAERAH  Tahun : 2025', '2025-06-11 09:41:10'),
('60991040556a409a804ccc74590799cebc7b3e8e', '2025-06-10 21:29:28', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 5.2 Persentasi Realisasi APBD Tahun Berjalan Bobot : 50', '2025-06-10 21:29:28'),
('60e1eb828dc5fc32c28f2909d2b854d7f5b2bea8', '2025-06-13 11:22:23', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Memiliki Layanan Berbasis Elektronik', '2025-06-13 11:22:23'),
('60f86f259cab99150d0e447df9fabd58e10e2639', '2025-06-16 09:46:24', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Pencatatan Paket e- Purchasing pada Katalog Elektronik', '2025-06-16 09:46:24'),
('60fc314514c1f8a56d8d19a33037c21f1d0b35bd', '2025-06-19 10:23:20', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 4-6 sarana prasarana bagi pengguna layanan kelompok rentan  ', '2025-06-19 10:23:20'),
('61182247f8c42c39205f6e59591814601d711cb6', '2025-06-11 18:55:26', 'UPDATE', 'admin', 'Update Data Sub Aspek : Laporan Realisasi APBD Perangkat Daerah Bobot : 100', '2025-06-11 18:55:26'),
('611aba323cafe1800ffff07909033f1075a8e87d', '2025-06-11 19:41:06', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-11 19:41:06'),
('6136b15127437c62666af13cada65f6a3761a054', '2025-06-20 14:50:36', 'DELETE', 'sultan', 'Hapus Data Indikator  : Tersedia ruang tunggu dengan fasilitas wajib dan pelengkap', '2025-06-20 14:50:36'),
('61539abe157bf3ba0bea49fa934c977a9b8887ea', '2025-06-13 10:45:29', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 10:45:29'),
('615c5f1c8285a4c5c702dcbb2c0213f7ff6815e8', '2025-06-23 09:39:51', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 09:39:51'),
('6248cc4cd788f70f2ed7ea35bdde4687e66efc99', '2025-06-10 23:02:23', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Dokumen Manajemen Data (mencakup pengelolaan arsitektur data (bid. statistik), data induk, data referensi (tiap PD berbeda, mengacu ke pusat), basis data, kualitas data, dan interoperabilitas data)', '2025-06-10 23:02:23'),
('6292e66d6c34b2df348ac73e3a091f395ddbae6a', '2025-06-11 09:41:01', 'UPDATE', 'admin', 'Update Data Form : LKE REFORMASI BIROKRASI PERANGKAT DAERAH  Tahun : 2025', '2025-06-11 09:41:01'),
('62a5b9486b4d8b445136e144df57c46f48135e77', '2025-06-19 10:03:37', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia tempat parkir dengan fasilitas pendukung yang memadai', '2025-06-19 10:03:37'),
('62b575404419f9a49d75716468da579d1eeb0888', '2025-06-13 10:06:55', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Rencana Aksi Pembangunan RB General Bobot : 100', '2025-06-13 10:06:55'),
('63c95216bd528e0ac847a55b5ca78a140c24e103', '2025-06-13 09:16:46', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:16:46'),
('642159917fd2e7a8696fab97a16e41d1bf55809e', '2025-06-18 10:13:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Telah memperoleh predikat menuju WBBM', '2025-06-18 10:13:58'),
('644ed567ec427f04e48c5f026f0e339d8338d7fe', '2025-06-19 13:59:52', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya) 4. Domain Data dan Informas ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 13:59:52'),
('6494df476240160d97e98f9724b1bc88a9f98f9b', '2025-06-16 11:07:19', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 11:07:19'),
('649df68e760a52c6b06739866422282abd179144', '2025-06-10 21:23:07', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 1.3 Penyelenggaraan Statistik Sektoral Bobot : 20', '2025-06-10 21:23:07'),
('64f7c32adb043d832a9c80bcaaea2a3bd59ae1e1', '2025-06-10 21:49:45', 'INSERT', 'admin', 'Tambah Data Indikator : f) Telah memanfaatkan Layanan Pusat Data Pemerintah Daerah ', '2025-06-10 21:49:45'),
('6515d20cea60a329ddc96365f364a1c653eebdc8', '2025-06-10 21:32:42', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 8.1 Capaian Pelaksanaan Pembangunan Zona Integritas Bobot : 100', '2025-06-10 21:32:42'),
('6552008aedb5a064f20f567aa9e426825a0c9586', '2025-06-13 10:12:11', 'UPDATE', 'rb_renaksi', 'Edit Data Indikator : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 10:12:11'),
('6571c769fd135138f82faddf96b89f0e16e4d56d', '2025-06-13 09:07:01', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-13 09:07:01'),
('65ae45e7a6e4a9eb4e7ecf03a0639d0ff9910513', '2025-06-23 14:59:05', 'LOGIN', 'USER', 'User Login :Admin Surabe', '2025-06-23 14:59:05'),
('66563e2bdcbe84642c966351454de39891344248', '2025-06-13 10:03:24', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:03:24'),
('66de91a36d99c9e934618027d951b4fe4f3b450f', '2025-06-16 10:04:15', 'INSERT', 'soal', 'Tambah Data Indikator : Capaian Rencana Aksi Pembangunan RB Tematik', '2025-06-16 10:04:15'),
('67280f64a7911fa5c27eba55bf31fa4d743b0616', '2025-06-19 09:03:05', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian IKU Perangkat Daerah tercapai (= 50%)', '2025-06-19 09:03:05'),
('6735a09061113f026a08a2ecb2aefd71880dcee6', '2025-06-11 18:55:05', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tindaklanjut Rekomendasi (TLHP) Bobot : 100', '2025-06-11 18:55:05'),
('67a21175bb5e2dc2b3eb13f22ae9aaffea68b99d', '2025-06-19 11:30:55', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah ada inovasi namun kurang dari 1 tahun', '2025-06-19 11:30:55'),
('67b47900beb320c7ee001b1cc68f1f1b186aefcb', '2025-06-13 10:09:41', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', '2025-06-13 10:09:41'),
('67b4b38b90704ccd5be5b5a17a6979c84dac802c', '2025-06-11 22:46:24', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Surat Permohonan pengusulan Pembentukan Peraturan Daerah/ Peraturan Kepala Daerah ,Indikator  : 45cf18e926282fc9b3211f0428052fbb760c2583', '2025-06-11 22:46:24'),
('67d67286072ddd393a67e97ae46be804fe080320', '2025-06-10 21:54:23', 'INSERT', 'admin', 'Tambah Data Indikator : h) Telah menggunakan Sistem Penghubung Layanan Pemerintah Daerah', '2025-06-10 21:54:23'),
('67da17fb4e77a612971ce453ef7b4e596be34962', '2025-06-19 10:47:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Sarana konsultasi pengaduan pengguna layanan dengan 2 fasilitas ', '2025-06-19 10:47:58'),
('67dc3452a2c5c67c4c6350d7f2efb4b790bd5081', '2025-06-23 13:01:13', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 13:01:13'),
('67f1aa8adf36a48c11d67bd0475414bf527d53ed', '2025-06-20 14:58:28', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan Fasilitas Sarpras bagi Kelompok Rentan sesuai dengan Surat Edaran Menteri PANRB Nomor 66 Tahun 2020 ,Indikator  : 0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-20 14:58:28'),
('68172e1a11a4b33629cf8e5bf51cbdf85a4a995b', '2025-06-16 09:53:03', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Pemenuhan Dokumen Rencana Aksi RB General Bobot : 100', '2025-06-16 09:53:03'),
('687fde5abf1431d0ed62f51f154028ab50f35915', '2025-06-11 22:48:19', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Rancangnan Peraturan Daerah/Peraturan Kepala Daerah ,Indikator  : 28a5d1b98409915a3b0e821647d8477e8687b4d7', '2025-06-11 22:48:19'),
('68d534d7ebe9af0b9dcefe613983a251094110ff', '2025-06-20 14:33:00', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 14:33:00'),
('6907c2606711e34f1128d36fe98325aa1cd57687', '2025-06-16 13:00:17', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-16 13:00:17'),
('6933263dd56086ce4f3bb215650dbdf4e7ea7ad4', '2025-06-10 23:34:24', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 23:34:24'),
('69403242acdeb8c7d3893d811c1edaf7831c0572', '2025-06-13 11:34:53', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Nota Dinas, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Jaringan Intra Pemerintah Daerah, Laporan Pemanfaatan  ,Indikator  : e0c4526e75ba296f19f1472590d0baf1f9b64e29', '2025-06-13 11:34:53'),
('696b093334f07b1d9c046616f265a3d993f0c8c1', '2025-06-19 10:27:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia fasilitas penunjang', '2025-06-19 10:27:09'),
('69dc88307306bc4a7114bf23e8b60332ace75c7f', '2025-06-13 11:19:34', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan eKinerja/KMOB', '2025-06-13 11:19:34'),
('6a5814b4b705c5b720cf79336153be3605f554cf', '2025-06-13 15:02:36', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-13 15:02:36'),
('6aa6a393206e4e0dddcf0b761f3b8173fad8de36', '2025-06-16 09:32:49', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-16 09:32:49'),
('6aafabc0977f8f8542aacab2cf5bd44fa8029638', '2025-06-11 19:04:43', 'INSERT', 'admin', 'Tambah Data Parameter : Telah memperoleh predikat menuju WBBM', '2025-06-11 19:04:43'),
('6acf059665084bf858b481d47925cb6cbfa36106', '2025-06-11 23:01:11', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : SK atau SP Tim Pengelola SP4N -LAPOR yang telah di formalkan oleh Kepala Perangkat Daerah ,Indikator  : a9069b289f2e0f78afa7d4ac8c6a98975e03e886', '2025-06-11 23:01:11'),
('6b5ab5e5dc7ce64b292fdf228debf4f5bbf155f0', '2025-06-13 11:08:48', 'DELETE', 'budker', 'Hapus Data Indikator  : hasil', '2025-06-13 11:08:48'),
('6b5ba14401404b66e4dfa3e02185a97c5930c465', '2025-06-23 10:59:19', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-23 10:59:19'),
('6b819d84dadebb5c3fb47c1ee29824cae29183dc', '2025-06-18 14:51:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik dan elektronik ', '2025-06-18 14:51:14'),
('6ba3d27630e721d91d0491a6177a8fbd62d28640', '2025-06-11 22:51:24', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Undangan Rapat ,Indikator  : 2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-11 22:51:24'),
('6bb06891c190f7c2f08e586b66d289d38c9a92e9', '2025-06-11 19:26:10', 'INSERT', 'admin', 'Tambah Data Parameter : Nilai Hasil Evaluasi Pengukuran Kinerja ', '2025-06-11 19:26:10'),
('6bb4ce2db1cd5f53eef94f81db7df674631e568f', '2025-06-18 14:56:22', 'INSERT', 'sultan', 'Tambah Data Parameter : SKM dipublikasikan pada 1 (satu) media publikasi    ', '2025-06-18 14:56:22'),
('6be2532335019b5892e5ae0dca10d23e7c7cb91f', '2025-06-10 23:01:36', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', '2025-06-10 23:01:36'),
('6bedd50cff2eee49ec5748c06887f8348a77dfd7', '2025-06-11 19:05:59', 'UPDATE', 'admin', 'update Data Parameter : Telah memperoleh predikat menuju WBBM', '2025-06-11 19:05:59'),
('6c43ec2d424f0a52dc9ead44db92f954e182aafb', '2025-06-19 10:04:05', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia ruang tunggu dengan fasilitas wajib dan pelengkap', '2025-06-19 10:04:05'),
('6cd34f2563d8f5b57f31167816b75f43a1c0322a', '2025-06-16 10:34:09', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Pencatatan paket transaksional pada e-Kontrak dalam SPSE atau Laporan Pencatatan paket transaksional pada e-Kontrak dalam SPSE yang dikeluarkan oleh Biro PBJ ,Indikator  : 2b557a8de90f11956d143d38ebb34f4f3e1517b7', '2025-06-16 10:34:09'),
('6cde263fa27bde421f1d86b6f3b19b175f49f3d3', '2025-06-16 09:49:07', 'INSERT', 'soal', 'Tambah Data Indikator : Dimensi Kompetensi', '2025-06-16 09:49:07'),
('6cf1d2f8f4bef7e58f40ee851a473d23429d4ccc', '2025-06-11 18:49:49', 'UPDATE', 'admin', 'Update Data Sub Aspek : Laporan Realisasi APBD Perangkat Daerah Bobot : 100', '2025-06-11 18:49:49'),
('6cfa4b105d7c2c9fb233bebff4fd2dc8e7041b36', '2025-06-18 11:24:53', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak dilaksanakan peninjauan ulang secara berkala terhadap Standar Pelayanan', '2025-06-18 11:24:53'),
('6d4a81058d9082c1a4b4c2a61a9c55c4f376a975', '2025-06-10 19:03:10', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-10 19:03:10'),
('6d8521126a2700244b1de49a4bd575a27b50ea9b', '2025-06-11 09:21:12', 'UPDATE', 'admin', 'Edit Data Indikator : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-11 09:21:12'),
('6d917ba8f0a307b1ae6c3eea24e6091ea8ddee57', '2025-06-19 09:28:15', 'INSERT', 'sultan', 'Tambah Data Parameter : Memiliki kebijakan jam pelayanan/kerja ', '2025-06-19 09:28:15'),
('6d977d02ff1b179b95729758c4a4f8ce1b406910', '2025-06-19 10:57:41', 'INSERT', 'sultan', 'Tambah Data Parameter : 50% konsultasi atau pengaduan ditindaklanjuti hingga selesai yang tidak menggunakan SP4N-LAPOR!  ', '2025-06-19 10:57:41'),
('6dbe04a4c1cae0210365a07d5b3a417203348fe5', '2025-06-18 11:13:36', 'INSERT', 'sultan', 'Tambah Data Indikator : Kecepatan tindak lanjut hasil SKM seluruh jenis pelayanan', '2025-06-18 11:13:36'),
('6dc11b8cb885149265e3503641251a7d51cbee1c', '2025-06-16 13:11:31', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-16 13:11:31'),
('6dc5ed9f0d15445cb2e2f7a2e426479a5fc4b7bd', '2025-06-20 10:11:07', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-20 10:11:07'),
('6e5d2ffc406332e5091c874d15ff681efd790e13', '2025-06-23 12:51:09', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:51:09'),
('6fba57583c0db64658d09db56b437603db2fc400', '2025-06-13 13:09:27', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 13:09:27'),
('700d7f05d7fc7e0c50ab9e8b4a9a6336b950a5ee', '2025-06-18 15:03:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Rekomendasi hasil SKM ditindaklanjuti seluruhnya 1 tahun setelah laporan SKM diterbitkan    ', '2025-06-18 15:03:14'),
('7057c4c03237f2e6aa980210665202cf7d8185be', '2025-06-19 09:39:40', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada pemberian penghargaan hanya berdasarkan 1-2 unsur kecuali kinerja  ', '2025-06-19 09:39:40'),
('70601d2aed5020bd54d02dda6f192147cf11c82f', '2025-06-10 21:20:47', 'DELETE', 'admin', 'Hapus Data Sub Sub Aspek  : Tingkat Kematangan Kapabilitas Layanan', '2025-06-10 21:20:47'),
('7061776b9aa9c1b4f9fbc429df5f958adb60791e', '2025-06-19 10:23:41', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-19 10:23:41'),
('7080d9491b501054a3c6ac4a9f13402a3636e09d', '2025-06-11 18:31:10', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:31:10'),
('70ab92e5b676ce7323b52f4178b0ae5ecdcadb49', '2025-06-19 09:01:40', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Seluruh IKU Perangkat Daerah tercapai (100%)', '2025-06-19 09:01:40'),
('710374c510eadcb7bfe664a9b728b314a2dadc97', '2025-06-20 10:05:52', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-20 10:05:52'),
('712fdf6718ab992f14a201ac0af56afe9512d891', '2025-06-20 14:38:05', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014  ,Indikator  : ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-20 14:38:05'),
('715c8fc98b1faab807e18834b569fd7cfeba0b58', '2025-06-20 09:06:11', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal ,Indikator  : 5fc1fe493b1f677a1075171f6248fe5f0c620e40', '2025-06-20 09:06:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('71d40f9e762d8001e85b7dbcbfaa314f15e0ed24', '2025-06-11 19:27:20', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 19:27:20'),
('727f0471d7b78646184a4d77090cfa27cf51e1cd', '2025-06-18 10:58:04', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia SP yang memenuhi 14 komponen', '2025-06-18 10:58:04'),
('7295fc475b76a67d75d97947f0f1d742311b53ad', '2025-06-16 08:47:04', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-', '2025-06-16 08:47:04'),
('729653f302e9a299fb941ce8184da61094059164', '2025-06-17 09:54:39', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-17 09:54:39'),
('72afabcd1c8a3f63cef8af6a127047c4c695616d', '2025-06-11 22:38:26', 'INSERT', 'budker', 'Tambah Data Indikator : Tingkat Kehadiran Pimpinan Tinggi Pemrakarsa dalam rapat Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:38:26'),
('72e76e3e264bc259758dbe7c6fa3ffa3b8d7d325', '2025-06-20 14:53:38', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Dokumentasi Petugas Layanan dengan Budaya Pelayanan yakni memakai seragam khusus, memakai Identitas nama, PIN/Atribut/Logo, menerapkan 5S  ,Indikator  : 23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-20 14:53:38'),
('749c0a72888eaaea37205302a39cc68075b87862', '2025-06-19 11:36:59', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-19 11:36:59'),
('74a6c977c39d00d647a9e91337a374f9bb727986', '2025-06-10 21:46:46', 'INSERT', 'admin', 'Tambah Data Indikator : b) Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-06-10 21:46:46'),
('74aa519755eea0e3e21685791d5bca84b9cce389', '2025-06-11 22:18:38', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-11 22:18:38'),
('74b7053afb2863ecfbdb1d1a3aba8c40f791373d', '2025-06-11 18:42:49', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:42:49'),
('74b9a18bb11aeb6194acd23b0701c9e19d86a245', '2025-06-13 10:43:22', 'INSERT', 'budker', 'Tambah Data Parameter : Jumlah Pengaduan diatas 5 sampai dengan 10 aduan', '2025-06-13 10:43:22'),
('74bb76552cb111eb259075a9844924dae2ea5dd6', '2025-06-20 14:55:19', 'DELETE', 'sultan', 'Hapus Data Indikator  : Sarana Front Office (FO) Informasi di unit layanan', '2025-06-20 14:55:19'),
('74c646d5b2437b36a428f66c497ce9c8e25294e1', '2025-06-19 11:35:06', 'UPDATE', 'soal', 'Edit Data Indikator : Capaian Kinerja Organisasi dalam Pengentasan Kemiskinan dan/atau Penanganan Stunting dan/atau Peningkatan Investasi dan/atau Pengendalian Laju Inflasi dan/atau kinerja lainnya yang merupakan core business perangkat daerah', '2025-06-19 11:35:06'),
('751505b81a4bea7b164a97643bc5a680955a44f5', '2025-06-18 11:19:29', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia publikasi SP seluruh komponen service delivery pada 2 atau lebih media publikasi namun belum dipublikasikan pada SIPP Nasiona', '2025-06-18 11:19:29'),
('7517a567a57203b6f015f537d319e073294fb524', '2025-06-20 09:16:38', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : 38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-20 09:16:38'),
('7563dd6a5f83d1a49a6356ee12008e7b80fb5c06', '2025-06-20 14:51:39', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 2. Sarana dan Prasarana (Dokumentasi Sarpras pendukung inovasi) ,Indikator  : bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-20 14:51:39'),
('75660fa7b635d98661e865eee229c7a9c2822ec7', '2025-06-13 10:16:24', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Rencana Aksi Pembangunan RB Tematik Bobot : 100', '2025-06-13 10:16:24'),
('7589d9625028434facbcb25d9052ab370a3a4112', '2025-06-20 14:36:10', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 14:36:10'),
('763fc4d6bc8f71447b6fc97c3189d7bade77022f', '2025-06-13 11:40:06', 'UPDATE', 'admin', 'UPDATE Password User  : admin Full Name : super admin', '2025-06-13 11:40:06'),
('766a41d91ac258f41eb9e2b96ad0069de35ef70b', '2025-06-11 19:30:31', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 19:30:31'),
('7684229d33a83e5323aa93be58582170c6dc0a46', '2025-06-19 11:45:13', 'INSERT', 'soal', 'Tambah Data Parameter : Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan', '2025-06-19 11:45:13'),
('768ba0bed5247c99e048581724b05d523a3183a1', '2025-06-23 13:02:39', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 13:02:39'),
('76a6151c41818b30abbc9431e12fb745d38ccb91', '2025-06-13 11:45:52', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen Manajemen Data PD (List user, log aktivitas, dataset PD) ,Indikator  : 54a6147d981a7d176e0c5dd43705569ba6db34fe', '2025-06-13 11:45:52'),
('76cffbe2e5faeccf3bf658ea1337713710d9d3d2', '2025-06-10 21:09:58', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-06-10 21:09:58'),
('76d2be04e8ad8dde62bd86491e45b21596c39cac', '2025-06-18 11:01:52', 'INSERT', 'sultan', 'Tambah Data Indikator : Proses penyusunan dan perubahan SP telah melibatkan unsur masyarakat', '2025-06-18 11:01:52'),
('772fccc5ca043b4d16e18b5c0eda893fef3c1f5c', '2025-06-19 10:22:11', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 13 atau lebih sarana prasarana bagi pengguna layanan kelompok rentan ', '2025-06-19 10:22:11'),
('77850b7235d26b66593393bb22171b4d30f7d1b4', '2025-06-13 09:51:06', 'INSERT', 'budker', 'Tambah Data Parameter : 91-100% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:51:06'),
('77e683c49bcba3e93f7689503f9a8e851c2fe54b', '2025-06-19 09:04:00', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Tidak ada IKU Perangkat Daerah tercapai (0%)', '2025-06-19 09:04:00'),
('77e7dc5f51b0745a9f341b608ebd7eea4a62c7a3', '2025-06-23 15:08:24', 'UPDATE', 'penilaikominfo', 'UPDATE Password User  : penilaikominfo Full Name : penilai kominfo', '2025-06-23 15:08:24'),
('7801025c9981be991ea1595302f782366443938f', '2025-06-13 11:18:37', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan aplikasi terkait aset (BMD)', '2025-06-13 11:18:37'),
('78037bb38cd86384e2e8d1f91ad0514fc4ba1b26', '2025-06-23 12:50:52', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:50:52'),
('7864c6de29289fb1dc4a97c142686bf89ac5559e', '2025-06-11 14:55:19', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-11 14:55:19'),
('790e1a4ac056a42dc493419f3fd35289901bce2d', '2025-06-16 10:53:27', 'INSERT', 'soal', 'Tambah Data Indikator : Capaian Kinerja Organisasi dalam Pengentasan Kemiskinan dan/atau Penanganan Stunting dan/atau Peningkatan Investasi dan/atau Pengendalian Laju Inflasi dan/atau kinerja lainnya yang merupakan core business perangkat daerah', '2025-06-16 10:53:27'),
('791da8b3e5ad71a051d3ef5730f8d34309ee54c3', '2025-06-19 11:32:12', 'INSERT', 'sultan', 'Tambah Data Parameter : Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 3 kondisi lainnya', '2025-06-19 11:32:12'),
('792b26b4c6422f437d37291f4e93a29df2eee21c', '2025-06-16 09:45:34', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Paket Pekerjaan yang diumumkan RUPnya melalai SiRUP', '2025-06-16 09:45:34'),
('7952ad000b6d6ec136b93b9d90ccca45702b1dd0', '2025-06-19 14:01:32', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 14:01:32'),
('79a78244b7c1e89fce491e9c85c7ddcc4b2a650e', '2025-06-16 09:49:26', 'INSERT', 'soal', 'Tambah Data Indikator : Dimensi Kinerja', '2025-06-16 09:49:26'),
('79b5049c4a5950c1f0ac31ca496188965e6047a1', '2025-06-20 10:04:26', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)   ,Indikator  : 9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-20 10:04:26'),
('7a1eb475aeeefa8bda35ff8775194a211a9bd539', '2025-06-19 10:18:20', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia fasilitas wajib dan 1 fasilitas pelengkap      ', '2025-06-19 10:18:20'),
('7a2c2a277d894d86cf617952dda7b50517d7994e', '2025-06-19 11:34:39', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem antrian dengan 4 fasilitas', '2025-06-19 11:34:39'),
('7a7e94bb690b82a9a775651537201e1659fb87b6', '2025-06-10 20:01:56', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 4. Tindaklanjut Rekomendasi (TLHP) Bobot : 100', '2025-06-10 20:01:56'),
('7acc538b010d2d7377a860e5a025dcc2e08bf690', '2025-06-11 09:44:35', 'DELETE', 'admin', 'Hapus Parameter  : B. Telah memperoleh predikat menuju WBK', '2025-06-11 09:44:35'),
('7aeeb38a278df5e20851febdfd890d37847688b0', '2025-06-16 09:05:18', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN ', '2025-06-16 09:05:18'),
('7afb67a17474d1fea2efd22c403d08090da7ac78', '2025-06-10 21:46:05', 'INSERT', 'admin', 'Tambah Data Indikator : a) Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-10 21:46:05'),
('7b42bf80345927fc9be044f7adad6ebfbbcb19fa', '2025-06-18 10:10:25', 'UPDATE', 'sultan', 'update Data Parameter : Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '2025-06-18 10:10:25'),
('7bb6131da78482ee9ff096093a15b2125217a09a', '2025-06-18 10:19:02', 'INSERT', 'sultan', 'Tambah Data Parameter : Telah dilaksanakan Pencananangan ZI Unit Kerja', '2025-06-18 10:19:02'),
('7bcf0e1c5bf47e0bf91d934a509da223dadd1ae0', '2025-06-19 09:07:58', 'DELETE', 'muftyabyan', 'Hapus Parameter  : Sebagian besar IKU Perangkat Daerah tercapai (>50%)', '2025-06-19 09:07:58'),
('7bcfa5369e0d8d7f0f396e174c979e31c15d8650', '2025-06-11 18:41:59', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 18:41:59'),
('7c13cc311a4fbd4067524e7c62237a2a926d4fb1', '2025-06-10 23:29:12', 'UPDATE', 'admin', 'update Data Parameter : Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', '2025-06-10 23:29:12'),
('7c3a9ce9dc8e99ee9ba79c917b9128254c35e9e6', '2025-06-20 09:08:28', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : Laporan Kinerja Instansi Pemerintah (LKIP) Perangkat Daerah Tahun sebelumnya ,Indikator  : 4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-20 09:08:28'),
('7c6f0bf121131c0de353868be7769ef519649db4', '2025-06-11 22:31:49', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Evaluasi Produk Hukum dan Tindaklanjutnya Bobot : 40', '2025-06-11 22:31:49'),
('7c82f4fbdbe70286b8186aa8d9c1380fbbaf91dd', '2025-06-11 19:08:04', 'INSERT', 'admin', 'Tambah Data Indikator : Nilai Hasil Evaluasi Perencanaan Kinerja ', '2025-06-11 19:08:04'),
('7ccbf65a1a2eae2e09b037b683fc36dde4be7a92', '2025-06-13 11:27:05', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Persentase Keterisian Data Prioritas (Relevansi)', '2025-06-13 11:27:05'),
('7d61dc68fd1b845f70c626b2f19773475ef07a71', '2025-06-13 10:52:20', 'INSERT', 'budker', 'Tambah Data Indikator : hasil', '2025-06-13 10:52:20'),
('7df23afcfea89cb26f3872367e6d2ffb18ee73f6', '2025-06-19 09:35:50', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 4 jenis mekanisme peningkatan motivasi kerja', '2025-06-19 09:35:50'),
('7e129c079bc2271bf894b0af3ac5a93340992777', '2025-06-16 09:49:44', 'INSERT', 'soal', 'Tambah Data Indikator : Dimensi Disiplin', '2025-06-16 09:49:44'),
('7e4a2ef43b5d0bcf450ad4747def6464bd40e558', '2025-06-18 09:59:38', 'DELETE', 'sultan', 'Hapus Parameter  : Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '2025-06-18 09:59:38'),
('7e7d59ae57ed6214d60c2432a95cecba49726ab1', '2025-06-11 09:31:35', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 09:31:35'),
('7e8e4622c4db0f80a855dea1cd9e9cc0588df040', '2025-06-19 09:32:05', 'INSERT', 'sultan', 'Tambah Data Parameter : Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 2 (dua) unsur lainnya ', '2025-06-19 09:32:05'),
('7e8f1a5a335e641c5854655e89cec9eac2baaf38', '2025-06-19 10:26:49', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 1 fasilitas penunjang', '2025-06-19 10:26:49'),
('7edf031bfe9507d146a646a8f2daf1a484678bca', '2025-06-11 18:40:09', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 18:40:09'),
('7ee0f7cb364675af3e5fd823c5564ef332abf31d', '2025-06-18 14:45:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Maklumat Pelayanan yang sudah ditetapkan namun isinya belum sesuai dengan peraturan perundangan yang berlaku     ', '2025-06-18 14:45:14'),
('7f923afc24af60b4c61a1c87a07fcf395d912d3c', '2025-06-20 10:18:11', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-20 10:18:11'),
('7fa63133f58ab7ee5e461bd76f2bb01b246b7450', '2025-06-20 09:15:50', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : 38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-20 09:15:50'),
('7fe4340a954179264ac8ed4963f7a24886b70c37', '2025-06-19 13:51:39', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4.4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta,', '2025-06-19 13:51:39'),
('7fee1df1b00cd491319732b2533aee367ac99f31', '2025-06-13 09:52:24', 'INSERT', 'budker', 'Tambah Data Parameter : kurang dari 21% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:52:24'),
('8007250ee2cc6e41ead2326db2647221bd33b522', '2025-06-10 21:29:02', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 5.1 Persentasi Realisasi APBD Tahun Sebelumnya Bobot : 50', '2025-06-10 21:29:02'),
('80d4050402e50b0a8e9bde5f601399b76cefe05a', '2025-06-11 22:37:13', 'INSERT', 'budker', 'Tambah Data Indikator : SK Pembentukan Panitia Antar Perangkat Daerah', '2025-06-11 22:37:13'),
('80e13873d321e5271891198353234abb66c716c9', '2025-06-13 11:09:20', 'DELETE', 'budker', 'Hapus Data Indikator  : Nilai Hasil Evaluasi Pengawasan Kearsipan Internal Perangkat Daerah', '2025-06-13 11:09:20'),
('80e8d05727fb898a975c5cb1e0c136eb431a0915', '2025-06-13 15:02:12', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 15:02:12'),
('8102ccc77287df828cf7a35a7dea45a48826ef0e', '2025-06-13 22:04:27', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 22:04:27'),
('819c16e7994d4ac30fd875278c5e077ff5e9c751', '2025-06-11 22:51:55', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Notulensi ,Indikator  : 2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-11 22:51:55'),
('81e3d25956db8e9661efc00a4d87f4646b7a64e6', '2025-06-11 16:05:34', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 16:05:34'),
('8200d3b307b54dd82a2af0677227711dcb56e074', '2025-06-16 10:51:51', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Capaian Kinerja Core Business Organisasi  Bobot : 100', '2025-06-16 10:51:51'),
('822d7f6f4f442c693f38ac40aaa986421395f075', '2025-06-23 13:29:12', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 13:29:12'),
('827421a7ce14cd1292cb392804ec934618fb83fd', '2025-06-19 11:28:09', 'INSERT', 'sultan', 'Tambah Data Indikator : Penciptaan Inovasi Pelayanan Publik', '2025-06-19 11:28:09'),
('82d300f82ab172e07b54fc95c1ea80a6107776cf', '2025-06-10 22:11:13', 'INSERT', 'admin', 'Tambah Data Indikator : i) Telah terdapat Tim Pelaksana SPBE Perangkat Daerah', '2025-06-10 22:11:13'),
('82e3afb914141bdac4216847d68d31f63f60b306', '2025-06-20 14:54:09', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Ketersediaan Sarana pada ruang Konsultasi dan Pengaduan, berupa Kotak Saran, Ruang Khusus, Petugas Khusus, Air Minum, Register Tamu, serta publikasi terkait informasi mekanisme konsultasi pengaduan (dapat berupa poster/spanduk/buku/bahan cetak lainnya) ,Indikator  : da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-20 14:54:09'),
('83061649b799dd1d1e94ee0b0e3384005454d925', '2025-06-13 11:45:16', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-06-13 11:45:16'),
('83719db378d07400afb7f36afe82e46fe1c0d4a9', '2025-06-18 14:59:29', 'INSERT', 'sultan', 'Tambah Data Parameter : Tindak lanjut hasil SKM dilaksanakan kurang dari 30%, dibuktikan dengan laporan pelaksanaannya', '2025-06-18 14:59:29'),
('838c00daae41063a186be03df4544b35ffa050bc', '2025-06-19 13:49:59', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-', '2025-06-19 13:49:59'),
('8403fa09bf377a15584c2fe723ffa0d04b7dc7a0', '2025-06-11 09:30:47', 'UPDATE', 'admin', 'Edit Data Indikator : a) Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-11 09:30:47'),
('841b01a88ebab2a396649eca4501b53bf94df0e4', '2025-06-19 11:33:46', 'INSERT', 'sultan', 'Tambah Data Parameter : Belum ada sumber daya yang mendukung keberlanjutan inovasi', '2025-06-19 11:33:46'),
('845656de4ac9abd98722fdd7de910ed388383b67', '2025-06-13 09:47:58', 'INSERT', 'budker', 'Tambah Data Parameter : Evaluasi Produk Hukum dilakukan 1 (satu) kali dalam satu tahun anggaran', '2025-06-13 09:47:58'),
('84865a84646fad0c869b42aeb0e39769898edf69', '2025-06-19 10:46:54', 'INSERT', 'sultan', 'Tambah Data Parameter : Sarana konsultasi pengaduan pengguna layanan dengan 5 atau lebih fasilitas ', '2025-06-19 10:46:54'),
('84beba0726c4d52bfac67f2ea4f59362f1e37742', '2025-06-18 09:05:48', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-18 09:05:48'),
('8535c439ab39ea4039a8563f99c1b967dd820c81', '2025-06-11 23:17:05', 'INSERT', 'budker', 'Tambah Data Parameter : Terdapat Naskah Akademik/penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 23:17:05'),
('85902012f9be95504884ca40c1681f30790b0792', '2025-06-10 20:24:01', 'DELETE', 'soal', 'Hapus Data Sub Sub Aspek  : Tingkat Kematangan Kapabilitas Proses', '2025-06-10 20:24:01'),
('85af149a28d0fdd12df52abf2a43465c65048a36', '2025-06-13 11:49:22', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SIAP Sulteng dan menu-menu layanan kepegawaian di dalam SiAP Sulteng (untuk PD lain) ,Indikator  : 479b03a54d5860c3494d9986e39767088a6ba472', '2025-06-13 11:49:22'),
('865745b5afd0dd4d311442685c919a338dd5d2b1', '2025-06-23 12:40:48', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1750653648_c58788b4b3d73292a7ef.pdf ,bukti Dukung  : 08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:40:48'),
('865a4806356de45795b0439b1052c8eb72c5aba2', '2025-06-11 23:05:59', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : LHE Penilaian Kearsipan Internal (LAKI) Masing-masing perangkat daerah yang dikeluarkan oleh Dinas Perpustakaan dan Kearsipan Daerah  ,Indikator  : 1b3163274f172d9cb971f32a5e224d38aad72f04', '2025-06-11 23:05:59'),
('86941963c805a711c225585cda83e2cf6da92f02', '2025-06-13 11:41:47', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik ,Indikator  : 3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2025-06-13 11:41:47'),
('86b75aec7e9f2a4b5450dc34293003f7a4692a43', '2025-06-18 15:02:00', 'INSERT', 'sultan', 'Tambah Data Parameter : Rekomendasi hasil SKM ditindaklanjuti seluruhnya 3 bulan setelah laporan SKM diterbitkan  ', '2025-06-18 15:02:00'),
('86c1052aabd1457920d8912ac0533e9fcc4b5fcd', '2025-06-19 10:04:38', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana toilet pengguna layanan yang layak pakai', '2025-06-19 10:04:38'),
('872ff995c8706fc5b3f901ea8d0d0b42567040c4', '2025-06-10 21:24:32', 'UPDATE', 'admin', 'Update Data Sub Aspek : 2. Nilai SAKIP Perangkat Daerah Bobot : 100', '2025-06-10 21:24:32'),
('8768e9c3d54ea86b4f91042df8a7322cdd07260d', '2025-06-12 08:47:37', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-12 08:47:37'),
('87994cbd4996ea926f7b82a5f314e2d610b14ddd', '2025-06-16 10:30:28', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Laporan RUP pada Aplikasi SiRUP atau Laporan Rekapitulasi RUP pada SiRUP yang dikeluarkan oleh Biro PBJ ,Indikator  : 5d87606c5eee137d90d291e708f3220790f6cbf5', '2025-06-16 10:30:28'),
('87c6c0d5c3d641017fba3e16eeeeacaa687594ba', '2025-06-10 20:01:33', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 3. Capaian IKU Perangkat Daerah Bobot : 100', '2025-06-10 20:01:33'),
('88081f79c0dc15575f98904195f72aee58f552d1', '2025-06-18 14:49:54', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik dan elektronik serta dilakukan tindak lanjut hasil SKM ', '2025-06-18 14:49:54'),
('88477b1afec5a0632586a88ac9c1a9de7d1f181b', '2025-06-18 10:18:11', 'INSERT', 'sultan', 'Tambah Data Parameter : Telah dilaksanakan evaluasi oleh TPI', '2025-06-18 10:18:11'),
('885a0db0df4e454b33ee2b9501bffc9a8a8f9ad6', '2025-06-19 11:28:31', 'INSERT', 'sultan', 'Tambah Data Indikator : Sumber daya yang mendukung keberlanjutan Inovasi Pelayanan Publik', '2025-06-19 11:28:31'),
('88638fc4c462c151de143ed03b81b3e9e301569d', '2025-06-13 09:59:01', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 09:59:01'),
('88700e7538701c41d4204a3a1d5b885a2ea18346', '2025-06-19 11:43:22', 'INSERT', 'soal', 'Tambah Data Parameter : Sistem Informasi Berbasis Elektronik telah Berfungsi dengan Baik/dapat dioperasikan/dapat diakses oleh pengguna layanan', '2025-06-19 11:43:22'),
('88b971e4e0f86c338db79b99bf35024007fa5503', '2025-06-19 10:24:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '2025-06-19 10:24:13'),
('88bac06cc05afa29a021da0f5aa3bbfc66806708', '2025-06-16 09:54:48', 'INSERT', 'soal', 'Tambah Data Parameter : Penetapan Indikator Kinerja Sekretariat Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah pada Cascading Kinerja', '2025-06-16 09:54:48'),
('89271e11052a1aeb2c267034219102892ef69bc1', '2025-06-20 14:29:59', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. Publikasi Waktu Pelayanan ,Indikator  : 8f1ee3f44f11f8330421dc9e3aa9d84ff3755489', '2025-06-20 14:29:59'),
('894a7a4eeb272d5c56d90379a3ecb348379223f4', '2025-06-13 09:04:59', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:04:59'),
('8974134d6a0b510421a82b3932b603b1c580c87e', '2025-06-11 18:56:43', 'UPDATE', 'admin', 'Update Data Sub Aspek : Indeks Budaya Kerja BerAKHLAK Bobot : 100', '2025-06-11 18:56:43'),
('89c8e60c4786b387ce78a27e506f9cfd0ca76246', '2025-06-11 22:59:48', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Dokumen Rancangan Perda/ Perkada Hasil Evaluasi ,Indikator  : 8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-11 22:59:48'),
('89dd5bbce066c1b1722532edac4dd4df5591cb0b', '2025-06-13 11:47:55', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen Okupasi Pemetaan Kompetensi SDM TIK PD ,Indikator  : 1e18d576a11913f59bb54c7cefef863406078720', '2025-06-13 11:47:55'),
('8a5fb54bd8a75207793d38644f5a744d6bdfa6a6', '2025-06-18 11:20:08', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia publikasi SP hanya sebagian dari komponen service delivery baik pada media cetak/non elektronik maupun media elektronik ', '2025-06-18 11:20:08'),
('8a726a352d0c51d216311371d968427e18b00881', '2025-06-19 09:50:57', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Sistem Informasi Pelayanan Publik Bobot : 11.00', '2025-06-19 09:50:57'),
('8ae612f00a6c1a496c79d91ff48eabf044e8d230', '2025-06-19 10:41:38', 'INSERT', 'sultan', 'Tambah Data Parameter : Pemutakhiran data dan informasi pelayanan publik secara bulanan ', '2025-06-19 10:41:38'),
('8b13aea0f25cb47356700f84078518acf54b9fc2', '2025-06-19 09:32:31', 'INSERT', 'sultan', 'Tambah Data Parameter : Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak kewajiban dan 1 (satu) unsur lainnya   ', '2025-06-19 09:32:31'),
('8b185621291e89e0156058643c923214a3cd84d5', '2025-06-18 14:43:45', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Maklumat Pelayanan yang sudah ditetapkan, isinya telah sesuai dengan peraturan perundangan yang berlaku, dan dipublikasikan pada media non elektronik', '2025-06-18 14:43:45'),
('8b28955c3376236d8e15da65d925744a89a47914', '2025-06-16 12:59:45', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 12:59:45'),
('8b56ffde31e32e93b5d1a9a7ca324b9a3adeea6e', '2025-06-11 13:35:50', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 13:35:50'),
('8b672d0a6bdf50afa299767007cb37444a2055b1', '2025-06-20 14:43:51', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 2. SK Inovator ,Indikator  : c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-20 14:43:51'),
('8b99f80450f96bfaeca089c3ac882fe638bd1510', '2025-06-19 10:55:59', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada dokumentasi', '2025-06-19 10:55:59'),
('8d804848be965c8e911791a700107590146d8749', '2025-06-16 08:06:40', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 08:06:40'),
('8d8ed83bc45b4bbdf165890e7b3dca6f8fd2d57d', '2025-06-16 11:41:36', 'INSERT', 'soal', 'Tambah Data Parameter : Laporan Pelaksanaan Penggunaan Produk Dalam Negeri pada Pengadaan Barang/Jasa Pemerintah melalui aplikasi SIPD P3DN dan Aplikasi Bigbox LKPP', '2025-06-16 11:41:36'),
('8d8f445afd3cb8a368efade5e3ad347fdb55cfc5', '2025-06-13 10:05:40', 'DELETE', 'rb_renaksi', 'Hapus Parameter  : Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', '2025-06-13 10:05:40'),
('8e09b640ee73081c2a2981cc95b21684bfff0069', '2025-06-16 11:41:06', 'INSERT', 'soal', 'Tambah Data Indikator : Realisasi Belanja Pengadaan Barang/Jasa Pemerintah pada setiap perangkat daerah yang menggunakan Produk Dalam Negeri/Tingkat Komponen Dalam Negeri (PDN/TKDN)', '2025-06-16 11:41:06'),
('8e516ec20f751c0e581c6fbc7870fadc08883353', '2025-06-12 10:46:05', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-12 10:46:05'),
('8e5e39d274e3239d59ee0c664ea34e37563785e8', '2025-06-11 14:10:16', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 14:10:16'),
('8e63fcb578304fbbd82c3d4000be8f744b3d24bd', '2025-06-16 10:42:08', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Raport Kinerja Perangkat Daerah pada Lingkup Sekretariat Perangkat Daerah ,Indikator  : 356adee25a1526c8f6deafff1ec564ad5a407623', '2025-06-16 10:42:08'),
('8e6c2440573b2ac41becb90cad2853b4d28f7852', '2025-06-13 09:42:27', 'INSERT', 'budker', 'Tambah Data Parameter : 81-90% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:42:27'),
('8e82eb8ca296d9f0891e96cc4ecea7f656965245', '2025-06-18 11:05:01', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP telah melibatkan minimal 3 unsur masyarakat', '2025-06-18 11:05:01'),
('8ee448c0e9e5ed8f39e78bb064159dcf5ef20ab6', '2025-06-11 18:51:52', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-06-11 18:51:52'),
('8f02300a4b96b7c5b1f7fc4e66a1398d614ff0ec', '2025-06-16 12:34:52', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 12:34:52'),
('8f07fd3679f0078642c7866c88b4ba963a27b700', '2025-06-23 12:36:38', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1750653398_c7416cea333f80dcb703.xlsx ,bukti Dukung  : 08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:36:38'),
('8f1152ca988bdaf70f1effd0c2c114494ecf2b5b', '2025-06-16 10:01:14', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Implementasi Rencana Aksi Pembangunan RB Tematik Bobot : 100', '2025-06-16 10:01:14'),
('8f3c5bbb194de282d02e0474f0765c4e501f2422', '2025-06-10 22:32:09', 'INSERT', 'admin', 'Tambah Data Parameter : C. Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', '2025-06-10 22:32:09'),
('8f482d6d19a423697aa5e1462ac0ae2f834448d8', '2025-06-11 17:45:57', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 17:45:57'),
('8fe080082e759cabeef16ccc99f51e40db8dbc25', '2025-06-11 18:43:56', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:43:56'),
('9021a4605730215e1111d52742731ccd437fe235', '2025-06-11 10:34:46', 'UPDATE', 'admin', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-11 10:34:46'),
('9050d72efd836a5e97abeada9b3eb138efe13d4a', '2025-06-13 10:42:10', 'INSERT', 'budker', 'Tambah Data Parameter : - ', '2025-06-13 10:42:10'),
('9063da147229254ad101272670e2ec59f12a02b4', '2025-06-16 09:31:35', 'DELETE', 'budker', 'Hapus Data Bukti Dukung  : Screenshot media Publikasi SP4N-LAPOR pada website, media sosial', '2025-06-16 09:31:35'),
('90889c072999d65748447d4b5595caac4fc3e101', '2025-06-16 10:12:29', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-16 10:12:29'),
('909722c2fb7c92463369d788f7422b100fb16e3d', '2025-06-23 12:44:03', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:44:03'),
('909cbb10d1eafb3549ac79cf4ba9817c2de50b71', '2025-06-19 09:20:37', 'DELETE', 'soal', 'Hapus Data Bukti Dukung  : Penyampaian 1 buah \"Praktek Baik\" Tata Kelola Pemerintahan Berbasis Elektronik (Digital Services)/ layanan administrasi pemerintah berbasis elektronik dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet yang dikemas secara informatif dan menar', '2025-06-19 09:20:37'),
('909f1a407aabb600c11306dd6b3f3c1013a437cc', '2025-06-20 10:00:23', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 222918ef0072144df43126dd42d8946bfe37329e', '2025-06-20 10:00:23'),
('91ba224f2ef7d858e03ec84b026408b3a8d36f71', '2025-06-23 12:42:50', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:42:50'),
('92d6b8138781f5a0472fe72b771df2d88419ced9', '2025-06-11 19:34:36', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-11 19:34:36'),
('93215fe59609bb1403c15ff3bc5cc5c7ffcdae0f', '2025-06-18 15:10:22', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Profesionalisme Sumber Daya Manusia (SDM) Bobot : 25.00', '2025-06-18 15:10:22'),
('93261fc4688aaeb532cde3779082d1abf594c512', '2025-06-13 10:14:50', 'INSERT', 'admin', 'Tambah Data Aspek : Capaian Dampak RB Tematik Bobot : 100', '2025-06-13 10:14:50'),
('933e0c334065d43d88d8988957b9d1d4b9651f38', '2025-06-13 10:47:12', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 10:47:12'),
('933e2a69cb6adc47f76e005f7e8dad72721904ef', '2025-06-13 11:48:50', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SPSE ,Indikator  : ec38526ca158862acf6403a395e855c723391f5d', '2025-06-13 11:48:50'),
('934241ce3b760687298bebb9ef184785425a03f0', '2025-06-19 09:12:01', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian IKU Perangkat Daerah tercapai (= 50%)', '2025-06-19 09:12:01'),
('935733d977ce830235603ba55426157bb60a1b7f', '2025-06-16 08:56:00', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Terdapat Dokumen Manajemen Risiko SPBE', '2025-06-16 08:56:00'),
('93d48c7eee69e63039856fcacbbd66339a2b249b', '2025-06-11 23:04:46', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Jumlah penyelesaian pengaduan pada aplikasi SP4N-LAPOR/ screenshot Jumlah Penyelesaian Pengaduan pada SP4N-LAPOR ,Indikator  : 02e0b378b75ccaeba97fb2a141e64480c5447297', '2025-06-11 23:04:46'),
('93ece1bc831008e5bd8c645c15a8aded828b1c61', '2025-06-23 13:29:07', 'UPDATE', 'penilai', 'UPDATE Data User  : penilai Full Name : PENILAI', '2025-06-23 13:29:07'),
('941413db8134cd963c6a7d1479894ca8b9388cd4', '2025-06-13 11:45:19', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-06-13 11:45:19'),
('9417cbafce45abfca732b16e072810cd797fa89a', '2025-06-16 10:07:42', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Realisasi Belanja Produk Dalam Negeri/Tingkat Komponen Dalam Negeri (PDN/TKDN) Bobot : 100', '2025-06-16 10:07:42'),
('9425b44e7a8a7c983ecb0cab324c03be5d401c64', '2025-06-18 11:16:47', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia publikasi SP seluruh komponen service delivery pada 4 atau lebih media publikasi dan pada SIPP Nasional ', '2025-06-18 11:16:47'),
('94450af86a6a0c56d558950449046f3bdf48a88a', '2025-06-13 11:57:25', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN  ,Indikator  : d823766c948a1c8dc2c4fd700e48889192782492', '2025-06-13 11:57:25'),
('945518aba975f50899098b2cb3456196c74cc060', '2025-06-10 22:25:53', 'INSERT', 'admin', 'Tambah Data Parameter : D. Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', '2025-06-10 22:25:53'),
('958134c6aff17c5d0941011afd011cf75f64b51f', '2025-06-19 10:57:00', 'INSERT', 'sultan', 'Tambah Data Parameter : 50% - 90% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai ', '2025-06-19 10:57:00'),
('95faaf4a96b23b12318a46292f9032f71b084b9c', '2025-06-13 09:03:18', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 09:03:18'),
('9616df9d19d5cc7466afc6837c0998706ee94920', '2025-06-11 09:19:02', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 09:19:02'),
('9655e23c95cb1664edaec63472066853f8895f13', '2025-06-18 09:56:24', 'INSERT', 'sultan', 'Tambah Data Parameter : Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '2025-06-18 09:56:24'),
('966f4b7905f187f338a97d5c1d76ef90b6c124fe', '2025-06-19 10:16:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia fasilitas wajib dan 4 atau lebih fasilitas pelengkap', '2025-06-19 10:16:41'),
('972a8f779a18b08d9c7919887e203d4a16059d1a', '2025-06-18 10:37:53', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Kebijakan Pelayanan Bobot : 24.00', '2025-06-18 10:37:53'),
('9780a1c52c0e95fbf738a4aa393fdd9402945bf8', '2025-06-23 13:02:36', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 13:02:36'),
('9786ddcac16e145ba63996db324eab27b7690070', '2025-06-11 09:25:16', 'UPDATE', 'admin', 'update Data Parameter : Proses pembangunan/pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', '2025-06-11 09:25:16'),
('97a1b191a79ea2293f4d1cbad23b1c84363a5428', '2025-06-20 09:08:02', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                                     2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dok ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 09:08:02'),
('97a2c87122f85b4f236900201a86bd59b22c8094', '2025-06-19 10:10:21', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia tempat parkir dan memiliki 1 atau lebih fasilitas parkir ', '2025-06-19 10:10:21'),
('9815f3e76852aa3de97fec854a6e8c499765559c', '2025-06-11 20:04:53', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 20:04:53'),
('98710ca5ac463b46fe100b058b185e23504e5a30', '2025-06-19 10:39:51', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik berbasis website/aplikasi mudah dioperasikan, mudah diakses  ', '2025-06-19 10:39:51'),
('9898672cbd5adcf8a8b2b6e5f22f1a6e53b009cc', '2025-06-16 10:37:36', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah ,Indikator  : 7791f5c1e867947c05b7761ad4cf5673e5cda607', '2025-06-16 10:37:36'),
('98c12905cb30ef85a20d2ba95f8c2bfa84903c91', '2025-06-13 09:15:18', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1749777318_759a14bcdd68f3d75621.docx ,bukti Dukung  : 2edf5d1b6c6d645bfe853de2199f7ffbb359214c', '2025-06-13 09:15:18'),
('98cafc9adf023abdcae19d94ec64c6e4afc37b65', '2025-06-20 14:59:57', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot  dari Sistem Informasi Pendukung Layanan (SP4N Lapor!, SKM, Website  Pengelola Kepegawaian, FAQ, Pengelolaan keuangan pelayanan publik bagi layanan berbayar) ,Indikator  : 72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-20 14:59:57'),
('9902006b02872af38859be338911913dc8c74eb6', '2025-06-16 11:39:59', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-16 11:39:59'),
('9929f125378c957fa0eefa7614bf638e0a1d0ed5', '2025-06-11 19:29:44', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tingkat Keberhasilan Pembangunan ZI Bobot : 100', '2025-06-11 19:29:44'),
('99464cd04ed7937c51cd7d9db810992c37ab0798', '2025-06-20 14:50:12', 'DELETE', 'sultan', 'Hapus Data Indikator  : Tersedia tempat parkir dengan fasilitas pendukung yang memadai', '2025-06-20 14:50:12'),
('99914d6fa7212f855c3a4d37054bdb0239e4787d', '2025-06-13 11:26:33', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Memiliki Standar Data Statistik', '2025-06-13 11:26:33'),
('9a0acf8392aa346d96625f6f1c1171153ae506d9', '2025-06-18 11:45:46', 'UPDATE', 'sultan', 'update Data Parameter : Dilakukan peninjauan ulang 1 Tahun sekali atau lebih cepat terhadap seluruh jenis layanan', '2025-06-18 11:45:46'),
('9ad64b942fa85b26fefa3c64915f38a9bcb73440', '2025-06-19 09:09:40', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Jumlah IKU Perangkat Daerah Tercapai', '2025-06-19 09:09:40'),
('9aea8f6f7acdf23f5c348d8d2eb29c8229dad047', '2025-06-19 10:50:26', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat media konsultasi dan pengaduan secara offline menyatu satu dengan front office dan tersedia secara online ', '2025-06-19 10:50:26'),
('9af51e4cffeb271ba6cd59cc5503746b17f547a6', '2025-06-19 09:36:31', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 2 jenis mekanisme peningkatan motivasi kerja     ', '2025-06-19 09:36:31'),
('9b5795e7e6498a018251fe8cbe47856542423d07', '2025-06-13 10:28:49', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:28:49'),
('9b5e258aa5bb25ba5ab87fea08b225aa4c48c686', '2025-06-11 09:44:29', 'DELETE', 'admin', 'Hapus Parameter  : C. Telah dilaksanakan evaluasi oleh TPN', '2025-06-11 09:44:29'),
('9bb5808fc0081ea3179c33feaaa5a06ec1da6ad6', '2025-06-13 10:47:32', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 10:47:32'),
('9ca61499b664e3fb7803e7b1a701001fd565be5c', '2025-06-18 11:26:53', 'INSERT', 'sultan', 'Tambah Data Parameter : Dilakukan peninjauan ulang 2 tahun sekali terhadap sebagian jenis layanan  ', '2025-06-18 11:26:53'),
('9cba77f3ef0b1c1e3ae5224fdcea27cc15f9517f', '2025-06-13 11:55:30', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumentasi pengembangan layanan berbasis elektronik (sesuai siklus SDLC, manualbook, vidio penggunaan) ,Indikator  : 4cc7c0d2808515a7deb6b967a47d749eddf4ca61', '2025-06-13 11:55:30'),
('9cd0cd7b34ec0842c1c41656918bb0b62ece1e94', '2025-06-19 13:26:07', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-19 13:26:07'),
('9cdb7eb301901ece09581b30dfd6e477cbece999', '2025-06-11 22:52:11', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Dokumentasi Foto ,Indikator  : 2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-11 22:52:11'),
('9ceeaae2661875e6b55797e399490ecf6cba9357', '2025-06-19 10:32:03', 'INSERT', 'sultan', 'Tambah Data Indikator : Kualitas penggunaan SIPP Elektronik (Website/Aplikasi)', '2025-06-19 10:32:03'),
('9d20506064fb7f489087165855d6d51787b4ddfc', '2025-06-20 09:16:19', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-20 09:16:19'),
('9d2d650bfa41633c48c9b97c3345c5e23a8bd075', '2025-06-20 14:36:45', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 14:36:45'),
('9d7a9e2a3f31abe350488c54011598c2d1348a41', '2025-06-13 11:36:33', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja ,Indikator  : c6ddd5c9cfb225fc4881f98607ebc677a34fd715', '2025-06-13 11:36:33'),
('9df93602a00900bf2a8282d37470aff069f1dff0', '2025-06-20 09:57:14', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)  ,Indikator  : 26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-20 09:57:14'),
('9e0104fe4780737c0dd451cf36d5342c0fbf35c0', '2025-06-18 11:11:33', 'INSERT', 'sultan', 'Tambah Data Indikator : Pemenuhan siklus Maklumat Pelayanan (ketersediaan, penetapan, dan publikasi)', '2025-06-18 11:11:33'),
('9e1ed1ef3f92ca98a67387aa4ee17acf404f11d5', '2025-06-11 19:22:27', 'UPDATE', 'admin', 'Edit Data Indikator : Aspek Perencanaan Kinerja', '2025-06-11 19:22:27'),
('9e468e87c979aca0fef818a2a2fc02539a88c3b7', '2025-06-16 11:39:40', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-16 11:39:40'),
('9e525f19c6537a4f47c19ac16d4bae4152e61944', '2025-06-11 14:52:28', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 14:52:28'),
('9e582776725093d17f504f04c85474474addde7e', '2025-06-20 14:32:28', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)  ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 14:32:28'),
('9e6f0e0d6085558006f1dfc737181099e837bfbf', '2025-06-13 09:43:29', 'INSERT', 'budker', 'Tambah Data Parameter : 21-40% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:43:29'),
('9e7334c132c85c56773b6f0424ef34f45560f40d', '2025-06-13 10:00:46', 'DELETE', 'admin', 'Hapus Parameter  : Telah memperoleh predikat menuju WBBM', '2025-06-13 10:00:46'),
('9eb884cd2157c72a0537ff20ebca7a0eade83e9c', '2025-06-19 10:58:01', 'INSERT', 'sultan', 'Tambah Data Parameter : < 50% konsultasi atau pengaduan ditindaklanjuti hingga selesai yang tidak menggunakan SP4N-LAPOR!   ', '2025-06-19 10:58:01'),
('9f0f5048d3ea647feef041b9dbb6b0e7bf1a1c19', '2025-06-13 09:48:50', 'INSERT', 'budker', 'Tambah Data Parameter : Belum pernah dilakukan Evaluasi Produk Hukum', '2025-06-13 09:48:50'),
('9f232f2f49a40e29e52fd568a5d79de3444f398f', '2025-06-19 09:23:03', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Realisasi APBD Tahun Sebelumnya', '2025-06-19 09:23:03'),
('9f2b6db5f0521564709743cc55a7b8a5663464a7', '2025-06-19 11:34:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem antrian dengan lebih dari 4 fasilitas ', '2025-06-19 11:34:19'),
('9f4be32e2385e7fba6c7f08c6b1441d105a48e92', '2025-06-19 09:43:43', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak menerapkan budaya layanan', '2025-06-19 09:43:43'),
('9f764e35cc92f71be13a4280c359f3c7e9a91323', '2025-06-18 11:47:24', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak dilaksanakan peninjauan ulang secara berkala terhadap Standar Pelayanan', '2025-06-18 11:47:24'),
('9f7e01a99c037d9354ca6135e133f6bb57acedb8', '2025-06-18 14:55:45', 'INSERT', 'sultan', 'Tambah Data Parameter : SKM dipublikasikan pada 3 (tiga) media publikasi  ', '2025-06-18 14:55:45'),
('9fa18249e087091fc65b0e0e06d63638866a40ef', '2025-06-18 11:05:38', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP telah melibatkan minimal 2 unsur masyarakat    ', '2025-06-18 11:05:38'),
('9fff8cf92a1dedd2188aaaadb64a1983c88b147a', '2025-06-11 23:11:07', 'UPDATE', 'budker', 'update Data Parameter : Terdapat Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 23:11:07'),
('a026fb9eb7703d7f3c4f06c7263c9d2ae6d6489f', '2025-06-11 23:17:26', 'INSERT', 'budker', 'Tambah Data Parameter : terdapat SK Pembentukan Panitia Antar Perangkat Daerah', '2025-06-11 23:17:26'),
('a0a70f4a7e91dfecb2d0432bb7565ce3fa387828', '2025-06-18 14:56:04', 'INSERT', 'sultan', 'Tambah Data Parameter : SKM dipublikasikan pada 2 (dua) media publikasi    ', '2025-06-18 14:56:04'),
('a100fbc575af77c87401619b3411f05e5857a784', '2025-06-19 08:44:16', 'LOGIN', 'USER', 'User Login :muhammad mufti abyan', '2025-06-19 08:44:16'),
('a10aabfa43e132a692f49627aeede0599bdd1261', '2025-06-11 19:24:29', 'INSERT', 'admin', 'Tambah Data Indikator : Aspek Pengukuran Kinerja', '2025-06-11 19:24:29'),
('a1755f1d67ead49bb25c92dbee8cdff169e4ee70', '2025-06-10 22:18:54', 'INSERT', 'admin', 'Tambah Data Parameter : B. Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-06-10 22:18:54'),
('a1828c4c1720a4d9a3456597a2b04028c36e3d36', '2025-06-18 11:27:42', 'INSERT', 'sultan', 'Tambah Data Parameter : Dilakukan peninjauan ulang 3 tahun atau lebih terhadap seluruh jenis layanan    ', '2025-06-18 11:27:42'),
('a197464b5d69e6fbe0d1df869988cf7279544b45', '2025-06-18 11:04:15', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP telah melibatkan minimal 4 unsur masyarakat     ', '2025-06-18 11:04:15'),
('a1d4af6dc79acce315fb5ff35a59fa2815924f5b', '2025-06-18 15:01:34', 'INSERT', 'sultan', 'Tambah Data Parameter :  Rekomendasi hasil SKM ditindaklanjuti seluruhnya 1 bulan setelah laporan SKM diterbitkan ', '2025-06-18 15:01:34'),
('a1f1c29e73acd5c2347b6946cbbbc98e7ba4e295', '2025-06-13 11:54:04', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Rekap pengelolaan pengaduan ,Indikator  : bdf634491a8ee3ad5404841758b381bd1a9f40d8', '2025-06-13 11:54:04'),
('a2028977cba12a3b32ebeba931c5b3a7779bf942', '2025-06-19 09:33:22', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia aturan kode etik dan kode perilaku', '2025-06-19 09:33:22'),
('a20a1758aafc67a8e50c7bd001d61b28e6112933', '2025-06-19 10:23:54', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 1-3 sarana prasarana bagi pengguna layanan kelompok rentan  ', '2025-06-19 10:23:54'),
('a2e8ac3de296717b8586c51d7c46bac70ebe149d', '2025-06-19 10:49:47', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat media konsultasi dan pengaduan secara offline terpisah dari front office, dan terhubung dengan SP4N-LAPOR! ', '2025-06-19 10:49:47'),
('a2f68c5f32a57cbd731f5d3a0ab94ab258183559', '2025-06-19 08:53:58', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Nilai Hasil Evaluasi Pelaporan Kinerja ', '2025-06-19 08:53:58'),
('a3176124c3f9f0235b95ca55624c4a13403c9e49', '2025-06-16 09:31:31', 'DELETE', 'budker', 'Hapus Data Bukti Dukung  : Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll', '2025-06-16 09:31:31'),
('a32c3f286cae7af96c50211f28555067e220c77f', '2025-06-11 22:57:23', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Laporan Hasil Evaluasi Produk Hukum Perda/Perkada ,Indikator  : 9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-11 22:57:23'),
('a33855707271dc50241997d07b61d6c333ba08a1', '2025-06-19 11:30:31', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah ada inovasi lebih dari 1 tahun namun belum diikutsertakan dalam kompetisi (level apapun) ', '2025-06-19 11:30:31'),
('a3b5859ed3f363e16f0a545a11e79797690018fc', '2025-06-20 14:34:33', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-20 14:34:33'),
('a3b67867a7e7726b43f583e9327abc6898e43ae7', '2025-06-10 23:33:22', 'INSERT', 'admin', 'Tambah Data Bukti Dukung : Bukti Dukung Disesuaikan dengan jawaban ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-10 23:33:22'),
('a3f72c792290c4178e2c4da20870f550a8591f68', '2025-06-20 09:14:56', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014    ,Indikator  : 38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-20 09:14:56'),
('a422d7c6cd29b4a51ca5b31ce11003b2bdd1ada8', '2025-06-11 22:30:50', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah Bobot : 36', '2025-06-11 22:30:50'),
('a43f1092a362d66d18fb777712b9c79a980d21cc', '2025-06-20 09:59:41', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi) ,Indikator  : 222918ef0072144df43126dd42d8946bfe37329e', '2025-06-20 09:59:41'),
('a4559bd2abf37910bc3af50e0d6a3ba79186d12c', '2025-06-23 12:46:00', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:46:00'),
('a4aa56965401f59fa1038aed857f92658809591f', '2025-06-13 08:33:30', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-06-13 08:33:30'),
('a53a31858f3c278995db6a965ada17e13513c2af', '2025-06-19 10:23:20', 'DELETE', 'budker', 'Hapus Data Bukti Dukung  : 1. Screenshot media Publikasi SP4N-LAPOR pada website, media sosial;  2. Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll', '2025-06-19 10:23:20'),
('a53db11ef0a1eeb61020dfd20dbb3a8452b32dce', '2025-06-11 18:57:46', 'UPDATE', 'admin', 'Update Data Sub Aspek : Nilai Survei Kepuasan Masyarakat Bobot : 100', '2025-06-11 18:57:46'),
('a549625f6078d33c7f428d9ad1a0c2cf0c43e133', '2025-06-11 22:33:50', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Nilai Pengawasan Kearsipan Internal Bobot : 100', '2025-06-11 22:33:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('a54e0269255aec2b4814d313bc55f2857009b6fc', '2025-06-10 22:20:09', 'INSERT', 'admin', 'Tambah Data Parameter : D. Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-06-10 22:20:09'),
('a58b8dba9e614470d9acac44b161929b384257ce', '2025-06-16 10:41:26', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Cascading Kinerja Sekretariat Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah  ,Indikator  : 29cf25bb5ea0d1b0c8ef68c1e401765ba6d6651f', '2025-06-16 10:41:26'),
('a5e2b5c79b89a3d64cf4558c84e340dbc85b1c8f', '2025-06-10 23:03:05', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', '2025-06-10 23:03:05'),
('a5fc2b91cc15f4e4475f72ba88bdd62df636fbbc', '2025-06-19 11:35:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem antrian dengan 1 fasilitas', '2025-06-19 11:35:35'),
('a644d08b6bf29206728636d4d59dff5324893f91', '2025-06-20 14:59:06', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan Fasilitas Penunjang (Fotokopi/ATK, Kotak P3K, APAR, Kantin, Ruang Ibadah, Area Merokok, Jalur Evaluasi, Tempat Sampah dan CCTV) ,Indikator  : e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-20 14:59:06'),
('a661910f339af97f666bb3e4f752bc975658e041', '2025-06-19 10:39:28', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik berbasis website/aplikasi mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami ', '2025-06-19 10:39:28'),
('a675e8c21a1f136ae9fff2245352e03e80ab8e3b', '2025-06-20 14:45:15', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen Penetapan (SK) terkait Kode Etik (Dengan unsur meliputi Hak & Kewajiban, Larangan KKN, Larangan Diskriminasi, Sanksi dan Penghargaan) ,Indikator  : de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-20 14:45:15'),
('a6bf1a2162fdeaec3f97b5cb2919fcd3c7d039ee', '2025-06-16 10:38:45', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah ,Indikator  : f56c31c955255c249de67a93de07093489b5f250', '2025-06-16 10:38:45'),
('a6ef97ebd1cbdeb3d7f9420b99e03f1f22cfb80f', '2025-06-20 09:15:27', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi)   ,Indikator  : 38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-20 09:15:27'),
('a70ff3e80838c6431a7b45cedf1a7c084625a8c5', '2025-06-19 10:37:46', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pendukung operasional pelayanan dengan 1 kondisi ', '2025-06-19 10:37:46'),
('a7e9babd31f6e3afceee1ae6a8deb6ae1339bae1', '2025-06-13 11:17:34', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Kinerja Pegawai Berbasis Elektronik', '2025-06-13 11:17:34'),
('a813accac1a58e692052c230abfce39c070bd696', '2025-06-19 09:31:10', 'INSERT', 'sultan', 'Tambah Data Parameter : Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 4 (empat) unsur lainnya ', '2025-06-19 09:31:10'),
('a8a19fc4adc4e0473cc52fa9a6d951e3811938c9', '2025-06-13 09:58:43', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 09:58:43'),
('a8abf9797e58f4780b234c8475bb0f8743c94121', '2025-06-11 19:19:07', 'UPDATE', 'admin', 'Edit Data Indikator : Aspek Perencanaan Kinerja', '2025-06-11 19:19:07'),
('a8c210d961f1e42976d6aa79bcd95672a09cdda6', '2025-06-19 10:40:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Pemutakhiran data dan informasi pelayanan publik dilakukan secara harian dan detail/sangat lengkap ', '2025-06-19 10:40:58'),
('a8fb5534ce94abb5d5b3e71b2749fb8af4359f36', '2025-06-13 10:03:21', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:03:21'),
('a9535d1836d5a91b6d4fe07e26b1799d52716ea3', '2025-06-13 11:43:33', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik ,Indikator  : 3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2025-06-13 11:43:33'),
('a99aff0a708fc9fe700effbc38f2c801a3655c67', '2025-06-11 14:33:15', 'UPDATE', 'rb_renaksi', 'Update Data Sub Aspek : Nilai SAKIP Perangkat Daerah Bobot : 100', '2025-06-11 14:33:15'),
('a9aae0f4e1a74f390e8351e3902876c02e511f30', '2025-06-13 11:58:02', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen metadata IKU Perangkat Daerah sesuai dengan Peraturan BPS no. 5 Tahun 2020 tentang Petunjuk Teknis Metadata Statistik ,Indikator  : b3f348e5efc8ef54cff7d945a876410e1b329641', '2025-06-13 11:58:02'),
('a9ae9202665bb43fa10a59c7de876cf53ecff425', '2025-06-11 09:48:05', 'DELETE', 'admin', 'Hapus Parameter  : Telah memperoleh predikat menuju WBBM', '2025-06-11 09:48:05'),
('a9c561933a658334a4e232247361f30288363459', '2025-06-16 08:48:56', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) 5. Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasion', '2025-06-16 08:48:56'),
('a9ff5835d64008919986ab7e56465eafc40a1fe5', '2025-06-10 23:03:46', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 23:03:46'),
('aa0db2e7881f46112f9104d95c312fb9b1d13fae', '2025-06-16 09:54:19', 'INSERT', 'soal', 'Tambah Data Indikator : Dokumen Rencana Aksi Pembangunan RB General telah disusun dan ditetapkan sebagai dokumen formal', '2025-06-16 09:54:19'),
('aa1467c1b4e2405ba6a3091d49bec6a37f6696e0', '2025-06-19 09:18:49', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Persentase Hasil Tindaklanjut Rekomendasi (TLHP) APIP', '2025-06-19 09:18:49'),
('aa99157f3da250ed977b71f0a97f7522ab851287', '2025-06-19 09:32:59', 'INSERT', 'sultan', 'Tambah Data Parameter : Aturan kode etik dan kode perilaku Pelaksana Pelayanan hanya meliputi nilai dasar hak dan kewajiban  ', '2025-06-19 09:32:59'),
('aab3b1179a7f922a38673625f45ff3eebc3dc01c', '2025-06-11 22:28:54', 'UPDATE', 'budker', 'Update Data Sub Aspek : Indeks Reformasi Hukum Bobot : 100', '2025-06-11 22:28:54'),
('aabe1c7a0079649a877d834dfe5054cb9e72aaa9', '2025-06-18 11:25:29', 'INSERT', 'sultan', 'Tambah Data Parameter : Dilakukan peninjauan ulang 1 tahun sekali atau lebih cepat terhadap sebagian jenis layanan', '2025-06-18 11:25:29'),
('aae976261a7b803a45f5a787361cf65da80c769d', '2025-06-18 10:56:57', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia SP yang memenuhi 14 komponen dan dilakukan penetapan ', '2025-06-18 10:56:57'),
('aaf27e23ef233abbfc904425606cb76722d2e351', '2025-06-13 10:16:47', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Tingkat Implementasi Rencana Aksi Pembangunan RB Tematik Bobot : 100', '2025-06-13 10:16:47'),
('aba4d4abe9f7c442aa1efb9e662df983142958cb', '2025-06-13 11:27:32', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Persentase Data yang Dirilis sesuai Jadwal (Aktualisasi & Ketepatan Waktu)', '2025-06-13 11:27:32'),
('abac35ef9fb46f73c0326742fa2fc32f973895ee', '2025-06-13 11:32:30', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-13 11:32:30'),
('abbd02e11a57ad03c364cdbb3314136f0c961a05', '2025-06-20 09:58:21', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : 26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-20 09:58:21'),
('abeb911219d0f33a5248e9a6da93d68914e48a00', '2025-06-19 10:43:08', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia data dan informasi pelayanan publik yang tidak dimutakhirkan', '2025-06-19 10:43:08'),
('ac37498ee028d0427ebeae097410302c7b6d5d00', '2025-06-16 09:36:46', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Pencatatan Paket e- Purchasing pada Katalog Elektronik', '2025-06-16 09:36:46'),
('ac74d2c1e380a4fcdb055c897d72cd3f19744db4', '2025-06-11 10:30:54', 'DELETE', 'admin', 'Hapus Data Aspek  : Capaian Strategis Pelaksanaan RB General', '2025-06-11 10:30:54'),
('ac803f6d54f72e3a9d32306f07ef5b744a98e09a', '2025-06-20 14:35:32', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014 ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 14:35:32'),
('accb33455cef773e31a5bb5312452256cb9cb4e9', '2025-06-19 10:37:26', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pendukung operasional pelayanan dengan 2 kondisi ', '2025-06-19 10:37:26'),
('ace76d068a434e7d2a69d49354bc850da2c25746', '2025-06-13 11:10:03', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Pengadaan Barang/Jasa Berbasis Elektronik', '2025-06-13 11:10:03'),
('ad22fc14f0176dc66999dff9ef5aeafd20fcb8c6', '2025-06-10 23:00:22', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', '2025-06-10 23:00:22'),
('ad308522d19585534e499e6b18198037b5726e53', '2025-06-19 10:25:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 4 fasilitas penunjang', '2025-06-19 10:25:36'),
('ad6bf8739d991ca32e6ccde8aaccd1279f3b81c1', '2025-06-13 11:10:28', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Kepegawaian Berbasis Elektronik', '2025-06-13 11:10:28'),
('ad6f896a2e094804dd0673feb6010538925373bb', '2025-06-11 20:03:44', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 20:03:44'),
('ad96fd5881d2b666992d3df92d65ae8e0a98e819', '2025-06-20 14:45:39', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Bentuk Pelembagaan Inovasi 1. Anggaran (Bahwa Inovasi tersebut dianggarkan) ,Indikator  : bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-20 14:45:39'),
('ad9bd360c29b682eb27010815ff8891b9026e9c2', '2025-06-16 08:55:05', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', '2025-06-16 08:55:05'),
('adf2eeb02e36266ae8a81cedc8321ccd904684b4', '2025-06-23 10:52:36', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-23 10:52:36'),
('ae1e45e6c1423c9dd1c809b844a4ea31a5b8ed69', '2025-06-13 10:36:37', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : Nilai Rata-Rata Indeks Profesionalitas ASN Perangkat Daerah Bobot : 100', '2025-06-13 10:36:37'),
('ae7261de4806b3619bddd8fe2035a94a203ef82f', '2025-06-10 22:31:22', 'INSERT', 'admin', 'Tambah Data Parameter : A. Proses pembangunan/ pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', '2025-06-10 22:31:22'),
('ae9dcc337eb0f5c6387410c6639b7bfdf3edc5ba', '2025-06-16 09:48:45', 'INSERT', 'soal', 'Tambah Data Indikator : Dimensi Kualifikasi', '2025-06-16 09:48:45'),
('aebbe49f5a995580ee8912a55a71f2cad8503ca4', '2025-06-13 13:01:15', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 13:01:15'),
('aed3c8c1da710869757a5083b2086ff2a5fd2c5e', '2025-06-19 11:44:52', 'INSERT', 'soal', 'Tambah Data Parameter : Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai)', '2025-06-19 11:44:52'),
('af5294caafcf368e5cda25b537570981efeecd94', '2025-06-11 09:24:07', 'UPDATE', 'admin', 'update Data Parameter : Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-06-11 09:24:07'),
('af73cc5ffc13cb0aa2afc4568b28b71880a864ee', '2025-06-11 14:25:42', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-11 14:25:42'),
('af978785d596456f211d6193b25cfd73d3ed79c1', '2025-06-19 10:42:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Pemutakhiran data dan informasi pelayanan publik telah dilakukan secara semesteran   ', '2025-06-19 10:42:13'),
('af9badb4a76e06da585c6b1fd1f9df4724fcb67b', '2025-06-19 10:47:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Sarana konsultasi pengaduan pengguna layanan dengan 3 fasilitas', '2025-06-19 10:47:35'),
('afb0c27be9159d3c02355a6eccc54dc1457de40e', '2025-06-11 11:54:14', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-11 11:54:14'),
('afef3e9fed050d855d85c092d27b89699698271e', '2025-06-13 11:22:03', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Jaringan Dokumentasi dan Informasi Hukum (JDIH) Berbasis Elektronik', '2025-06-13 11:22:03'),
('b0036ba6ee7733801efb385576bdae9f1bd2d7b4', '2025-06-20 10:00:41', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN)cara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 222918ef0072144df43126dd42d8946bfe37329e', '2025-06-20 10:00:41'),
('b00ede68054b68c33e819b04bd49298d250bdf73', '2025-06-19 09:26:10', 'INSERT', 'sultan', 'Tambah Data Parameter : Memiliki kebijakan jam pelayanan/kerja dan 4 atau lebih unsur lainnya ', '2025-06-19 09:26:10'),
('b03a8f11f223a0a9187f2dd357a361ac42930af2', '2025-06-19 10:55:43', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat dokumentasi yang diarsipkan  ', '2025-06-19 10:55:43'),
('b1327e8f32c644c810f431390aaad1df3110b410', '2025-06-11 23:02:11', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Screenshot media Publikasi SP4N-LAPOR pada website, media sosial ,Indikator  : 23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-11 23:02:11'),
('b165b8fcbfcdd091acabbd3869690d7dbbbc98a5', '2025-06-13 10:15:10', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:15:10'),
('b1b59152fb232cf8a930f361d2ba4102e8202051', '2025-06-16 13:11:35', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 13:11:35'),
('b1b747d52b79fa0acfbd7744c6648324b58f3227', '2025-06-19 09:40:01', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada pemberian penghargaan', '2025-06-19 09:40:01'),
('b1d0ea912c5dd97516897be2fbfe83f6795d7d52', '2025-06-11 16:03:42', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 16:03:42'),
('b1e5512e67903bb1d73b197f1337c60a44d1aba1', '2025-06-10 22:47:05', 'INSERT', 'admin', 'Tambah Data Indikator : a) Pembangunan Zona Integritas Unit Kerja/Perangkat Daerah', '2025-06-10 22:47:05'),
('b245a2392da71fb966e833da481592775aa6c4d0', '2025-06-13 10:41:19', 'INSERT', 'budker', 'Tambah Data Parameter : - terdapat SK atau SP tim', '2025-06-13 10:41:19'),
('b27c83b44d4ce01a3716a5aa962c92795afba88c', '2025-06-11 22:27:35', 'INSERT', 'budker', 'Tambah Data Sub Aspek : Tingkat tindak lanjut pengaduan masyarakat (LAPOR) Bobot : 100', '2025-06-11 22:27:35'),
('b2b24ba70a99dbf707d320be839daf3f83715c4d', '2025-06-10 19:58:14', 'INSERT', 'admin', 'Tambah Data Aspek : B. Capaian Pelaksanaan Kebijakan RB Bobot : 100', '2025-06-10 19:58:14'),
('b2b870b294665a3486256380cfcc271bb725b79b', '2025-06-11 09:05:26', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-11 09:05:26'),
('b2f96114f7efde2ea306cfc711a64219431fd83f', '2025-06-19 10:35:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia sistem informasi pelayanan publik baik elektronik maupun non elektronik', '2025-06-19 10:35:41'),
('b32791b9936b943a8d0e90cac1c0592ad2c011f2', '2025-06-19 09:12:31', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', '2025-06-19 09:12:31'),
('b3718ae061e4a40706d46fb4a74edd2d8c111836', '2025-06-13 11:53:07', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan Aplikasi Sistem AKIP (Biro Organisasi dan Kemenpanrb) ,Indikator  : 208565ef7e96a72f09425ef5a7cb30bbe24a3243', '2025-06-13 11:53:07'),
('b371f66eb436d2b15b36613b82e17868f77353d6', '2025-06-19 09:17:33', 'INSERT', 'soal', 'Tambah Data Parameter : Data dan Informasi Capaian Kinerja RB Tematik yang disampaikan akan disandingkan dengan data dan informasi dari eksternal seperti; data BPS, data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah B. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai) C. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan D. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan E. Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '2025-06-19 09:17:33'),
('b3a88dfefe0034fbb79cf1aa90c557d9fc0e54a6', '2025-06-16 10:12:28', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-16 10:12:28'),
('b3b763bf96e04329e8bb690bc6f0bf02d64413b3', '2025-06-23 12:36:38', 'INSERT', 'undata', 'Tambah Data Jawaban : 865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-23 12:36:38'),
('b3ddcd68f78d4fe07b09e5918ac012ff91072b37', '2025-06-13 11:16:04', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Pengelolaan Barang Milik Daerah Berbasis Elektronik', '2025-06-13 11:16:04'),
('b4088f8c77af0ca1ed5d2002993c0a2a2048b1d5', '2025-06-19 09:11:31', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian besar IKU Perangkat Daerah tercapai (>50%)', '2025-06-19 09:11:31'),
('b418d99721d102a2a4be4bb1238a74787a7bf5d9', '2025-06-16 10:55:35', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Penyampaian 1 buah \"Praktek Baik\" Tata Kelola Pemerintahan Berbasis Elektronik (Digital Services)/ layanan administrasi pemerintah berbasis elektronik dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet yang dikemas secara informatif dan menar ,Indikator  : 413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-16 10:55:35'),
('b41b837d2214eccc6359140e3095a643fa5063e3', '2025-06-19 09:53:11', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Inovasi Bobot : 12.00', '2025-06-19 09:53:11'),
('b4566f3c868a8578fdea719acf59e7161c1c249a', '2025-06-18 11:06:55', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP tanpa melibatkan unsur masyarakat dan pihak terkait (stakeholder)', '2025-06-18 11:06:55'),
('b49a84f4bb889ed1a2a91c4fbab3119f21c88954', '2025-06-18 14:45:41', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Maklumat Pelayanan namun belum ditetapkan     ', '2025-06-18 14:45:41'),
('b4bd1aa4f0548b424dacbf71744ae0f1f88d2405', '2025-06-13 10:51:09', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:51:09'),
('b4d959e0f552cf3b1a4a80c56f18dd9cdc6cd662', '2025-06-19 09:03:33', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', '2025-06-19 09:03:33'),
('b5234811ffbea7b486e8eb2ab9b1441a9322b0af', '2025-06-10 19:57:43', 'INSERT', 'admin', 'Tambah Data Aspek : A. Capaian Sasaran Strategis Bobot : 100', '2025-06-10 19:57:43'),
('b5791cc07decaf02a827cd7fd5d8ff3eed41ba39', '2025-06-19 10:38:46', 'INSERT', 'sultan', 'Tambah Data Parameter : SIPP Elektronik berbasis website/aplikasi yang mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami, merupakan kanal digital resmi pemerintah (domain.go.id) dan kompatibel', '2025-06-19 10:38:46'),
('b58ca70df3427c51ae1c23c9a8273d902ff633a9', '2025-06-10 22:28:18', 'INSERT', 'admin', 'Tambah Data Parameter : B. Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-06-10 22:28:18'),
('b591dfce0a37a9d4f4ebfaa4e7bcde46b2c482cc', '2025-06-20 15:00:59', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot  Pemutakhiran/Unggahan Berkala yang dilakukan oleh Unit Pelayanan ,Indikator  : 31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-20 15:00:59'),
('b5a8551479bd8eba1c5ac16d30e033ba41bb0b6d', '2025-06-19 08:58:33', 'INSERT', 'muftyabyan', 'Tambah Data Sub Sub Aspek : Tingkat Ketercapaian IKU Perangkat Daerah Bobot : 100', '2025-06-19 08:58:33'),
('b615c7530731c9861fae35c1b624d2a14bcffe49', '2025-06-11 15:15:15', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 15:15:15'),
('b63f4ae69f79575587d0d738cf3b659036d6fb89', '2025-06-13 08:40:46', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 08:40:46'),
('b6690568b3b2225cbf8234e72485e0130a587ca7', '2025-06-11 10:37:47', 'INSERT', 'admin', 'Tambah Data Aspek : Capaian Strategis Pelaksanaan RB General Bobot : 100 ', '2025-06-11 10:37:47'),
('b6786972c8359c806610638e2aba795c8523ff7f', '2025-06-11 19:22:37', 'UPDATE', 'admin', 'Edit Data Indikator : Aspek Perencanaan Kinerja', '2025-06-11 19:22:37'),
('b6dcb31cf43ee3f5ac46f867ea53213e25be8278', '2025-06-14 23:02:12', 'DELETE', 'rb_renaksi', 'Hapus Parameter  : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi penganggaran', '2025-06-14 23:02:12'),
('b7251ec6d9d57b57b692266964a1646960fd7111', '2025-06-10 23:36:05', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1749569765_0ce2855f56993482f29e.jpg ,bukti Dukung  : 585934884a1cb559e68b4e28b9a173ad8ecd48b4', '2025-06-10 23:36:05'),
('b757abc83a1621108576666c70c02e86e0979950', '2025-06-18 15:14:00', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia kriteria pemberian penghargaan bagi pegawai yang berprestasi', '2025-06-18 15:14:00'),
('b76416b34e041470c57683bd03a4c3296dcac7ed', '2025-06-19 10:28:31', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sarana FO informasi layanan dengan 3 fasilitas', '2025-06-19 10:28:31'),
('b837d5bcab27da281a5a137c8cd255da8de1eea5', '2025-06-16 10:54:21', 'INSERT', 'soal', 'Tambah Data Parameter : Data dan Informasi Capaian Kinerja RB Tematik yang disampaikan akan disandingkan dengan data dan informasi dari eksternal seperti; data BPS, data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah B. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai) C. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan D. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan E. Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '2025-06-16 10:54:21'),
('b8985d340400dd03d653405e72d628bda8ffb322', '2025-06-16 10:16:27', 'UPDATE', 'soal', 'Update Data Sub Aspek : Persentase Capaian Rencana Aksi Pembangunan RB Tematik Bobot : 100', '2025-06-16 10:16:27'),
('b8e8706952a720b526dcc944b07e9ec43fb0f959', '2025-06-13 10:14:26', 'UPDATE', 'rb_renaksi', 'Edit Data Indikator : Telah Menggunakan Layanan Keuangan Berbasis Elektronik', '2025-06-13 10:14:26'),
('b94485091fb9c7b14a1816a006ebf000d8ecf13b', '2025-06-13 10:52:56', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:52:56'),
('b95be21d0b3fb438ea2978cf2805884d2510ac76', '2025-06-11 15:23:57', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 15:23:57'),
('b9dae4712f61994aa7420422a9b213220ba55aa1', '2025-06-19 09:37:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia mekanisme peningkatan motivasi kerja', '2025-06-19 09:37:09'),
('baccf866bff735f09fdebbb2e7325016c280a0fe', '2025-06-19 11:32:52', 'INSERT', 'sultan', 'Tambah Data Parameter : Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 1 kondisi lainnya ', '2025-06-19 11:32:52'),
('bb0c268c6abfeb9d06ba1e4d34d5a1740fd3d93b', '2025-06-19 09:42:53', 'INSERT', 'sultan', 'Tambah Data Parameter : Pelaksana pelayanan menerapkan 2 (dua) unsur budaya pelayanan  ', '2025-06-19 09:42:53'),
('bb42116371d7cc498a055aa9623a9e6dcb2bebfa', '2025-06-20 09:11:45', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : Buku Laporan Realisasi Akhir APBD Tahun Sebelumnya ,Indikator  : bf29c2c0ebb5bf5f234eb273a94f4bfc198e2f3f', '2025-06-20 09:11:45'),
('bb59f05d2065eae65209856ea860416aabbc0d4c', '2025-06-18 15:03:33', 'INSERT', 'sultan', 'Tambah Data Parameter : Rekomendasi hasil SKM tidak ditindaklanjuti', '2025-06-18 15:03:33'),
('bb612205edfb27c3e72860d0c6784c3f6fa057de', '2025-06-11 09:25:58', 'UPDATE', 'admin', 'update Data Parameter : Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', '2025-06-11 09:25:58'),
('bc0f38a7c72a2add27a4198acdfcc83c23efb17f', '2025-06-11 20:05:33', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-11 20:05:33'),
('bc30569402576906641946e399f8b594eac15bca', '2025-06-10 22:22:07', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat dokumen peta rencana (roadmap) SPBE ', '2025-06-10 22:22:07'),
('bcc05d6d95d13e7f02ffa829a4c03b0f36bed70e', '2025-06-13 11:11:06', 'INSERT', 'budker', 'Tambah Data Parameter : 1. Nilai 90 s.d. 100 dengan kategori AA (Sangat Memuaskan) 2. Nilai lebih dari 80 s.d 90 dengan kategori A (Memuaskan) 3. Nilai lebih dari 70 s.d 80 dengan kategori BB (Sangat Baik) 4. Nilai lebih dari 60 s.d 70 dengan kategori B (Baik) 5. Nilai lebih dari 50 s.d 60 dengan kategori CC (Cukup) 6. Nilai lebih dari 30 s.d 50 dengan kategori C (Kurang) 7. Nilai 0 s.d 30 dengan kategori D (Sangat Kurang)', '2025-06-13 11:11:06'),
('bd6fcc83a43f701da49712df5308af15db3a4ed0', '2025-06-11 16:05:26', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-11 16:05:26'),
('bd858489ad6aa645343ee0da2e1037dc55656968', '2025-06-13 11:41:13', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Laporan pelaksanaan Indeks KAMI (Diskominfo), Dashboard Indeks KAMI (PD lain) ,Indikator  : 4936f4074cfdb199ef8064f699a81f1c53662e6f', '2025-06-13 11:41:13'),
('bd8e4b68eea26b00d40df8de6b6443231af5092e', '2025-06-11 09:25:35', 'UPDATE', 'admin', 'update Data Parameter : Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', '2025-06-11 09:25:35'),
('bd94c2f802d3a035e5bbc103ce4f66cd5b9951be', '2025-06-20 14:56:07', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan Fasilitas Parkir antara lain Parkir Roda 2 dan Roda 4 yang terpisah dan diberi marka, petugas perkir jika ada, karcis parkir, CCTV, penitipan jaket/helm, dan  Kanopi ,Indikator  : 054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-20 14:56:07'),
('bdbbaaaf046b3658b0e15c5e93834e57b46e12a1', '2025-06-16 09:50:49', 'INSERT', 'soal', 'Tambah Data Parameter : Rata-rata nilai dimensi kualifikasi ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 25 poin', '2025-06-16 09:50:49'),
('be27c082ffb7d2e89e6f4270ddf39c4c7c68cbff', '2025-06-11 18:43:59', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 18:43:59'),
('be62ee01b07acde6f90f53b0588257cb0bc0ce62', '2025-06-18 14:52:10', 'INSERT', 'sultan', 'Tambah Data Parameter : Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku  ', '2025-06-18 14:52:10'),
('be9c272b1fbff0bc5073c53a574045820a18ac2c', '2025-06-11 15:36:26', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-11 15:36:26'),
('beab0f8fb24502d556bf9400c8f1390d3e62374f', '2025-06-20 14:56:52', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Ketersediaan Fasilitas Ruang Tunggu, dibagi menjadi Fasilitas Wajib (Kursi Tunggu dan Pendingin/sirkulasi ruangan) dan Fasilitas Penunjang (Mesin Antrian, TV, Bahan Bacaan, Pengisi Daya, Wifi, Air Minum dll) ,Indikator  : 5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-20 14:56:52'),
('bfa9853c1ad44727d457206262fa4cdf345380a9', '2025-06-13 09:15:18', 'UPDATE', 'undata', 'Update Data Jawaban : YAParameter : Tingkat Kematangan Kapabilitas Layanan', '2025-06-13 09:15:18'),
('bfce0e4a99500b4d21ff3164a7fd32178ea0b19d', '2025-06-13 11:10:15', 'INSERT', 'budker', 'Tambah Data Indikator : Nilai Hasil Evaluasi Pengawasan Kearsipan Internal Perangkat Daerah', '2025-06-13 11:10:15'),
('c02a5f364c7433a9ed78fb2c64ed63a3d6a56324', '2025-06-11 22:33:02', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Diseminasi SP4N-LAPOR! Kepada Masyarakat Bobot : 10', '2025-06-11 22:33:02'),
('c034d0baf0ad6e7f3cfb6b646517b39649d6dfd9', '2025-06-11 18:58:18', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tingkat Keberhasilan Pembangunan ZI Bobot : 100', '2025-06-11 18:58:18'),
('c04932f39c86cb06f828006d1ba5b0d22b097049', '2025-06-13 15:36:36', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 15:36:36'),
('c094db949041d2e2ff1fcef6c1736edec90048d8', '2025-06-13 09:58:40', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 09:58:40'),
('c098216083e0f4e31c9b5268728310a00ff59c87', '2025-06-16 10:12:32', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Implementasi Digitalasasi Administrasi Pemerintahan Bobot : 100', '2025-06-16 10:12:32'),
('c11434ae47a4a6c488219bd48bd14ee00fc1a4dd', '2025-06-11 22:28:02', 'INSERT', 'budker', 'Tambah Data Sub Aspek : Tingkat Digitalisasi Arsip Bobot : 100', '2025-06-11 22:28:02'),
('c11594bcf9e8291b53ba54ee98ee0eb3732c765d', '2025-06-10 21:49:16', 'INSERT', 'admin', 'Tambah Data Indikator : e) Telah menerapkan proses pembangunan Aplikasi SPBE sesuai siklus pembangunan aplikasi', '2025-06-10 21:49:16'),
('c14762d429f931b8447853c6fc3d4add9c2b1d87', '2025-06-11 18:50:57', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 18:50:57'),
('c18b39d528de3b9aac5633078d16ddabd68873ec', '2025-06-13 11:46:53', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen Manajemen Aset TIK PD ,Indikator  : ed4052a793493ad6e117034f1a47e15e4ec4308a', '2025-06-13 11:46:53'),
('c1c3b4cc2f18a5ac66e5330906a4d5f78988cce6', '2025-06-16 09:47:16', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '2025-06-16 09:47:16'),
('c1fad5fd74b423a225ba2a78a2816bb16601aba4', '2025-06-13 11:52:49', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Respon PD terkait Form Permintaan Data ,Indikator  : 208565ef7e96a72f09425ef5a7cb30bbe24a3243', '2025-06-13 11:52:49'),
('c20d311f1f126647f5c7b254b39a29bac8089262', '2025-06-18 09:19:56', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-18 09:19:56'),
('c2cd884c01f42a26a7a7abdab2a03bbd4195553d', '2025-06-11 09:24:47', 'UPDATE', 'admin', 'update Data Parameter : Sudah Memiliki Peta Proses Bisnis', '2025-06-11 09:24:47'),
('c2ed5cf89b809f5e9cb841bf64c287bb420419cc', '2025-06-11 09:27:15', 'UPDATE', 'admin', 'update Data Parameter : Telah memperoleh predikat menuju WBBM', '2025-06-11 09:27:15'),
('c302372fa8f7b13c44572aec05ad1715b75a5a26', '2025-06-11 22:40:21', 'INSERT', 'budker', 'Tambah Data Indikator : Jumlah Laporan yang Diterima/Masuk pada SP4N - LAPOR', '2025-06-11 22:40:21'),
('c364c1ffb65c8496e89c8f1b791e2103c6dadd99', '2025-06-19 09:58:51', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana toilet pengguna layanan yang layak pakai', '2025-06-19 09:58:51'),
('c37145391ae681f041ecc27d5b5c9ff3c62e6f28', '2025-06-19 10:36:46', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pendukung operasional pelayanan dengan 4 kondisiondisi', '2025-06-19 10:36:46'),
('c374dd29bdcc8e59459b5b8e46167a2fa1b1a553', '2025-06-18 14:59:50', 'INSERT', 'sultan', 'Tambah Data Parameter : Ada rencana tindak lanjut tapi belum dilaksanakan ', '2025-06-18 14:59:50'),
('c39a29715027b9a5ebf369eee4f304aaf415b243', '2025-06-13 08:41:23', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 08:41:23'),
('c3f7032ca9fd26579b855799818b5fb5cacf9b1e', '2025-06-13 09:51:22', 'INSERT', 'budker', 'Tambah Data Parameter : 81-90% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:51:22'),
('c41d996ea7aa25d09bb71f4ad0c7452791620391', '2025-06-19 10:47:16', 'INSERT', 'sultan', 'Tambah Data Parameter : Sarana konsultasi pengaduan pengguna layanan dengan 4 fasilitas', '2025-06-19 10:47:16'),
('c44672d8ce1a748e2980a4a3ee1b19991aeeecb2', '2025-06-16 10:34:43', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 10:34:43'),
('c4cb1899f677d985774bf81850ace5482dbb4bf8', '2025-06-20 14:29:39', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. SK/Peraturan yang berlaku terkait Penetapan Jam Kerja (Hari Kerja, Penambahan waktu diluar jam kerja ataupun kondisi tertentu) ,Indikator  : 8f1ee3f44f11f8330421dc9e3aa9d84ff3755489', '2025-06-20 14:29:39'),
('c4d3e1384695bcfe02a278fbf1faa4d0ea9c7eaa', '2025-06-20 09:07:53', 'DELETE', 'muftyabyan', 'Hapus Data Indikator  : Jumlah IKU Perangkat Daerah Tercapai', '2025-06-20 09:07:53'),
('c4d92909bc4bf7efdf91e1705e0e569ae5f1ca89', '2025-06-16 09:56:38', 'INSERT', 'soal', 'Tambah Data Indikator : Capaian Rencana Aksi Pembangunan RB General', '2025-06-16 09:56:38'),
('c4e46eaf1b21903583fd2004a26827030913cf57', '2025-06-16 10:38:36', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 10:38:36'),
('c557478274678e6404adffd63b13e738a64f0912', '2025-06-18 09:54:34', 'INSERT', 'sultan', 'Tambah Data Indikator : Hasil Tindak Lanjut SKM Tahun Sebelumnya', '2025-06-18 09:54:34'),
('c55772b1cc5f259857746ba36667a802fff165f9', '2025-06-18 15:02:28', 'INSERT', 'sultan', 'Tambah Data Parameter : Rekomendasi hasil SKM ditindaklanjuti seluruhnya 6 bulan setelah laporan SKM diterbitkan ', '2025-06-18 15:02:28'),
('c5fab108db9e3da770d606c370e4224e28378e82', '2025-06-20 09:01:44', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : Berita Acara Hasil Evaluasi TPI dan/atau Laporan Hasil Evaluasi TPN dan/atau Piagam Penghargaan Capaian Predikat WBK/WBBM pada unit kerja ,Indikator  : 5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-20 09:01:44'),
('c60b78f30a6d68dfa96aa132a6a33745e0b72025', '2025-06-23 13:28:29', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 13:28:29'),
('c60b88e97a2616fdcca70e98178742428e8da7a2', '2025-06-11 18:42:15', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 18:42:15'),
('c66af0a549b9fba7af822078c071ead68f7cd7d0', '2025-06-19 13:40:29', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-19 13:40:29'),
('c76df403628a8bfac62efb81b8a3e583874047fa', '2025-06-11 15:16:14', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 15:16:14'),
('c78abe91bdd7b787ca1206e35ab476e111c4157f', '2025-06-13 11:37:00', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Terdapat Dokumen Manajemen Risiko SPBE ,Indikator  : 2017b67bb7ec425721f4f39badb0cc1766dd6359', '2025-06-13 11:37:00'),
('c7931c1596fced374d796f165b9309989ab95994', '2025-06-11 09:31:28', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 09:31:28'),
('c8107afc77ecb32c628c6b82dd85ff0af5add9d3', '2025-06-20 09:11:42', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                            3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut has ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 09:11:42'),
('c8618b6bbf73f8d5412396c675168dbf34a36218', '2025-06-23 12:39:02', 'UPDATE', 'undata', 'Update Data Jawaban : 865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-23 12:39:02'),
('c87c7e6cb809d3cbf585291e029991c12e144d4a', '2025-06-18 11:20:40', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada publikasi SP', '2025-06-18 11:20:40'),
('c896c87d7b9be6108886c48f75fc2057d099b1e7', '2025-06-13 12:50:24', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 12:50:24'),
('c8a08cd21c75a043d0cc6e14435b1feb979a4b99', '2025-06-11 15:33:23', 'DELETE', 'admin', 'Hapus Data Bukti Dukung  : Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD', '2025-06-11 15:33:23'),
('c905456f628fbef2ba6ed57abe445a57aa2ee75a', '2025-06-13 08:34:55', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Screenshot Pemanfaatan SIPD (Perencanaan) ,Indikator  : 6aee4cc780191317ea55ac6e0cf353f0a1588182', '2025-06-13 08:34:55'),
('c910734e83e4443c168b735cb6981c299c961266', '2025-06-23 13:27:49', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 13:27:49'),
('c95c89c1698256fff0cfc315b3999d9bc5e6cd21', '2025-06-19 09:11:05', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Seluruh IKU Perangkat Daerah tercapai (100%)', '2025-06-19 09:11:05'),
('c9a26f809d3bf4c54771b16ec2ac5a3443c76777', '2025-06-13 10:01:17', 'DELETE', 'admin', 'Hapus Parameter  : Nilai Hasil Evaluasi Pengukuran Kinerja ', '2025-06-13 10:01:17'),
('c9baf5b36e61736dbcddbfb90a25cc9d8d282687', '2025-06-20 10:14:45', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-20 10:14:45'),
('c9ce8f0d839af0495449e2fcd10b1bb55c32b2f0', '2025-06-20 14:36:27', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 4. Laporan pelaksanaan FKP (Surat undangan rapat/pertemuan/ FGD, Berita Acara, Daftar Hadir, Notulensi, Dokumentasi) sesuai PermenPANRB No. 14 Tahun 2017 ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 14:36:27'),
('ca2028f839e6b9acabb07f479391f994f6d9b9f0', '2025-06-13 11:40:56', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 11:40:56'),
('cabfc51506aef97d28db677232584af7d956bff4', '2025-06-19 10:31:44', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sistem informasi pelayanan publik pendukung operasional pelayanan', '2025-06-19 10:31:44'),
('caf40f8bba001814c0908066ce576bc50a884323', '2025-06-16 09:36:05', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Paket Pekerjaan yang diumumkan RUPnya melalai SiRUP', '2025-06-16 09:36:05'),
('cb193f48a6f9408fe8a9d6fa4072fa25f9744787', '2025-06-11 22:31:24', 'INSERT', 'budker', 'Tambah Data Sub Sub Aspek : Tingkat Kehadiran Pimpinan Tinggi Pemrakarsa Bobot : 24', '2025-06-11 22:31:24'),
('cb396c989b7a800c0d9175eb5b45fb0c5c83bd69', '2025-06-23 12:52:28', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:52:28'),
('cb57a7e3f015660236d2354b6cd7eff64e2bab20', '2025-06-16 09:46:41', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE', '2025-06-16 09:46:41'),
('cb5ea424f3a2a81da7854be2c3f1cbae724d2f02', '2025-06-11 19:55:56', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:55:56'),
('cb92b01487d95d33367f1754bbe8ca45d14cfbf4', '2025-06-13 10:12:08', 'INSERT', 'admin', 'Tambah Data Aspek : Strategi Membangunan RB Tematik Bobot : 100', '2025-06-13 10:12:08'),
('cc14d537cd28241ddccfb8a81c0304231d09bb4b', '2025-06-11 23:17:53', 'INSERT', 'budker', 'Tambah Data Parameter : Terdapat Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 23:17:53'),
('cc2ead00ffc7e97a893c504d58b604adb75154c5', '2025-06-16 11:02:20', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-', '2025-06-16 11:02:20'),
('cc4f077b332c3d4fd859ea7302430cd679ce6214', '2025-06-19 10:33:44', 'INSERT', 'sultan', 'Tambah Data Parameter : Sistem informasi pelayanan publik telah online/website dan terhubung dengan sistem informasi pelayanan publik nasional serta telah menginput layanan yang ditetapkan ke dalam sistem informasi pelayanan publik nasional', '2025-06-19 10:33:44'),
('cc5fe0abe33e853990ef5ebca88962140a3e9ab4', '2025-06-13 08:31:59', 'INSERT', 'rb_renaksi', 'Tambah Data Indikator : Tingkat Kematangan Kapabilitas Layanan', '2025-06-13 08:31:59'),
('ccbb4b2d20a06420197219147a6cc1a3bf6f47a1', '2025-06-18 11:18:24', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia publikasi SP seluruh komponen service delivery pada 2 media publikasi dan pada SIPP Nasional', '2025-06-18 11:18:24'),
('ccee865940ff5d7a0cefa568cfb0f1ddef23794e', '2025-06-19 11:46:02', 'INSERT', 'soal', 'Tambah Data Parameter :  Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '2025-06-19 11:46:02'),
('cd36c18cb48c3bfd276d63f241b2a1b87d1d2673', '2025-06-10 20:03:46', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 8. Tingkat Keberhasilan Pembangunan ZI Bobot : 100', '2025-06-10 20:03:46'),
('cd3fa462d035d3c2984faf02628db5829aad1c04', '2025-06-16 08:37:01', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : File Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-06-16 08:37:01'),
('cd61ae779317b7bc52c721ea1059c464c2c6335b', '2025-06-11 10:03:42', 'DELETE', 'rb_renaksi', 'Hapus Data Sub Aspek  : Indeks Reformasi Hukum', '2025-06-11 10:03:42'),
('cd6dff2acfe1f0dfb429e715b469cdce61deba95', '2025-06-13 15:55:05', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 15:55:05'),
('cd9eb6116a57eb1f0a0da07b6c1cfe0f6824f004', '2025-06-19 10:08:35', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia tempat parkir dan memiliki 5 atau lebih fasilitas parkir ', '2025-06-19 10:08:35'),
('ce74cee8aba37efa0b8eebd0d8afa42af0a7275c', '2025-06-19 09:49:32', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Sarana dan Prasarana Bobot : 18.00', '2025-06-19 09:49:32'),
('cec217d8c7640df444db8d14885c2413a0c87b86', '2025-06-20 14:38:43', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-20 14:38:43'),
('cf1e733613b3b660fcc0349c0272fdc8701aa007', '2025-06-10 22:13:40', 'INSERT', 'admin', 'Tambah Data Indikator : o) Telah dilakukan pemenuhan kompetensi Sumber Daya Manusia TIK', '2025-06-10 22:13:40'),
('cf267bbebad46e6845d567de9f73b101da190f81', '2025-06-11 14:34:20', 'UPDATE', 'rb_renaksi', 'Update Data Sub Aspek : Capaian IKU Perangkat Daerah Bobot : 100', '2025-06-11 14:34:20'),
('cf7aa1750fcc9f89bdfec4b333e85d966436da40', '2025-06-10 20:23:50', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-06-10 20:23:50'),
('cfabed9fc8bd31bbe287c9717f96dee6d4c9a1d6', '2025-06-18 11:12:20', 'INSERT', 'sultan', 'Tambah Data Indikator : SKM yang dilaksanakan sesuai dengan PermenPANRB', '2025-06-18 11:12:20'),
('cfbd4b08be91fa80c2628af921154ab2186438a8', '2025-06-11 19:28:40', 'UPDATE', 'admin', 'Update Data Sub Aspek : Tingkat Keberhasilan Pembangunan ZI Bobot : 100', '2025-06-11 19:28:40'),
('cfe479dd97ded2f428b235e61c68159e989ee062', '2025-06-19 09:08:04', 'DELETE', 'muftyabyan', 'Hapus Parameter  : Sebagian IKU Perangkat Daerah tercapai (= 50%)', '2025-06-19 09:08:04'),
('cff0be4dfa60e4ce8b9cab17a4a422e0195ae9a1', '2025-06-10 22:34:05', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Layanan Pusat Data Pemerintah Daerah', '2025-06-10 22:34:05'),
('cff10e4632f9618dda2b028cff035ceb0293f9df', '2025-06-13 09:07:18', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:07:18'),
('cff84bd59655a346255a47fac78838203e0a62e8', '2025-06-11 15:32:10', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 15:32:10'),
('d03b227ec0e29cb1c5301dcfb5c1eafbdd2e194c', '2025-06-13 11:37:18', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-13 11:37:18'),
('d0762490c8c1a9f1008b04e0e13f98ea525020e1', '2025-06-23 12:39:02', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1750653542_636b1a3f0788fe13449b.xlsx ,bukti Dukung  : 08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:39:02'),
('d10e32c6c7cff924895e7073d86704cbc91ee056', '2025-06-16 08:43:14', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi-', '2025-06-16 08:43:14'),
('d10ff70501586437a6ff9e2a79c1034c9a32c901', '2025-06-19 09:31:40', 'INSERT', 'sultan', 'Tambah Data Parameter : Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 3 (tiga) unsur lainnya', '2025-06-19 09:31:40'),
('d1229bf6e7a6bb6f992405af0b51e33cabffc078', '2025-06-19 10:18:00', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia fasilitas wajib dan 2 fasilitas pelengkap', '2025-06-19 10:18:00'),
('d1842d42306256f76294b458e0a2ba1fe532fe63', '2025-06-23 12:59:23', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 12:59:23'),
('d1bb3fac0c4950a3d2bed41b711c1a00aeee7192', '2025-06-18 10:10:18', 'UPDATE', 'sultan', 'update Data Parameter : Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '2025-06-18 10:10:18'),
('d2966cbaee1c094d122cd65ef142a5f09b6a816d', '2025-06-19 10:17:04', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia fasilitas wajib dan 3 fasilitas pelengkap ', '2025-06-19 10:17:04'),
('d2bd4f8fdc9f6d0187536bbd759fb709e62816f8', '2025-06-18 09:23:04', 'UPDATE', 'soal', 'update Data Parameter : Penetapan Indikator Kinerja Sekretariat Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah pada Cascading Kinerja', '2025-06-18 09:23:04'),
('d2cdbf2df9f56f56fd604e459fa6ff595ceebfd1', '2025-06-13 09:07:57', 'INSERT', 'undata', 'Tambah Data Jawaban : TIDAKParameter : Tingkat Kematangan Kapabilitas Layanan', '2025-06-13 09:07:57'),
('d2e965f3af7b7b7b41a5476c66bec0cca145c566', '2025-06-13 09:51:39', 'INSERT', 'budker', 'Tambah Data Parameter : 61-80% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:51:39'),
('d2f83405c7937bbf51838c31f7f7a16972aac493', '2025-06-20 14:28:26', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-20 14:28:26'),
('d3388901bcb4e03d843bdf04b5d7d628f48a559d', '2025-06-16 08:57:04', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', '2025-06-16 08:57:04'),
('d342ab8da71fdb7c192620c3af0c2a71d2d544fd', '2025-06-23 12:40:48', 'UPDATE', 'undata', 'Update Data Jawaban : 865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-23 12:40:48'),
('d39b11c49d162149575300144945636c07c94c81', '2025-06-19 11:28:54', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sistem antrian untuk menunjang pelayanan', '2025-06-19 11:28:54'),
('d4033e3f863ac4468c751152f1a0811cd7156a21', '2025-06-11 16:12:22', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-11 16:12:22'),
('d43ceb14749f1484b1f46f107a94cb7217e33d23', '2025-06-19 10:54:44', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dan dilakukan monev ', '2025-06-19 10:54:44'),
('d466610786b36b3c8152cd40b1a0721a7caffcbf', '2025-06-16 09:06:15', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Dokumen metadata IKU Perangkat Daerah sesuai dengan Peraturan BPS no. 5 Tahun 2020 tentang Petunjuk Teknis Metadata Statistik', '2025-06-16 09:06:15'),
('d49b2c5a8d6a3f6b948dc99e67e7899fe53a42e2', '2025-06-23 13:46:26', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 13:46:26'),
('d4b1fe3661b528af9085d4f6a5db7ba985d82a14', '2025-06-19 13:59:26', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, d', '2025-06-19 13:59:26'),
('d4bfc008e2b0a155f61772e8138bb7fc22a85dd4', '2025-06-18 10:55:58', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia SP yang memenuhi 14 komponen, melibatkan masyarakat dalam penyusunan SP, dan dilakukan penetapan  ', '2025-06-18 10:55:58'),
('d50b011390e98244d9d12422e7612ecf899093fe', '2025-06-18 14:52:53', 'INSERT', 'sultan', 'Tambah Data Parameter : Belum melaksanakan SKM', '2025-06-18 14:52:53'),
('d51694b8cd19b6baa401829185138674f3b69cfe', '2025-06-11 15:33:32', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 15:33:32'),
('d51ab4ee010f8682902f38bab9944698ea3eae70', '2025-06-11 19:23:51', 'INSERT', 'admin', 'Tambah Data Parameter : Nilai Hasil Evaluasi Perencanaan Kinerja', '2025-06-11 19:23:51'),
('d51ca0f1f1f791493d2dd7ec3bd15cee4fa17206', '2025-06-13 22:05:57', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-13 22:05:57'),
('d57ce089556de2b2663640d6c20e3376bfad2ca9', '2025-06-13 09:42:04', 'INSERT', 'budker', 'Tambah Data Parameter : 91-100% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:42:04'),
('d62750e00cf7512a71b649dc9f17f8675823b249', '2025-06-10 19:56:13', 'INSERT', 'admin', 'Tambah Data RB : II. RB Tematik Perangkat Daerah Bobot : 100', '2025-06-10 19:56:13'),
('d649b65146e084836fb0126d5f98e07f0c0963f3', '2025-06-20 14:45:31', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 2. Publikasi Kode Etik di ruang pelayanan  ,Indikator  : de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-20 14:45:31'),
('d6750ebd63f3df66d7e23afe749792462c2a779d', '2025-06-16 09:37:29', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '2025-06-16 09:37:29'),
('d6ce107613a0bd5369b6e8533a61928c9fa86e61', '2025-06-16 09:58:38', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Pemenuhan Dokumen Rencana Aksi RB Tematik Bobot : 100', '2025-06-16 09:58:38'),
('d7195ac932078aef9b0970e6fb215fc777e92353', '2025-06-19 10:44:47', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia sarana dan media konsultasi serta pengaduan yang bisa dimanfaatkan semua lapisan masyarakat', '2025-06-19 10:44:47'),
('d728b2c4c38602deda9f75a74570e7bb9313f0bd', '2025-06-13 11:42:50', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Dokumen Manajemen Risiko SPBE PD ,Indikator  : 2017b67bb7ec425721f4f39badb0cc1766dd6359', '2025-06-13 11:42:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('d7717785072a4275bed4112419c2cb2d2f6e08b9', '2025-06-13 11:45:23', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-06-13 11:45:23'),
('d7dbe536a0b5f5852db85925f4d73b5dbc70ac61', '2025-06-19 10:29:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sarana FO informasi layanan dengan 1 fasilitas     ', '2025-06-19 10:29:09'),
('d7fa0686fdaf7ed4a72272c0430c6e1353b8a7b2', '2025-06-23 13:08:39', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-23 13:08:39'),
('d8b0ee0ed13eca821d014125f6f040b8dc8d79f7', '2025-06-23 11:06:37', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 11:06:37'),
('d948d944a1d7d72a65ba0e8652c815f1bf0ba716', '2025-06-19 10:54:25', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dilakukan monev, dan ditindaklanjuti ', '2025-06-19 10:54:25'),
('d953409b549c9aa061c981d5aa9daa0b4eb7868e', '2025-06-10 21:15:47', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Layanan Bobot : 30', '2025-06-10 21:15:47'),
('d9ad4dfdb6a0ab3ff783a34f7fc5e9f4755bd846', '2025-06-11 22:51:42', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Daftar Hadir Pimpinan Tinggi Pratama ,Indikator  : 2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-11 22:51:42'),
('d9eda05cd4c135b05f34cff4e3cc689cc404c5da', '2025-06-18 14:58:18', 'INSERT', 'sultan', 'Tambah Data Parameter : Tindak lanjut hasil SKM dilaksanakan 100%, dibuktikan dengan laporan pelaksanaannya ', '2025-06-18 14:58:18'),
('da00779e4b59fb6bad99accf5ccc5778d29f8988', '2025-06-11 19:27:07', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:27:07'),
('da43f42f21f3442d5bb469a9410430aa0bcb3a1e', '2025-06-10 21:27:51', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 4.1 Persentasi Penyelesaian Tindaklanjut Hasil Pemerikaan (TLHP) Bobot : 100', '2025-06-10 21:27:51'),
('da69b6c64f2b00365193ba942f0485549e66f301', '2025-06-23 13:21:21', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 13:21:21'),
('da9592854b17d37dfe2adc4b356c53c580efc614', '2025-06-11 14:42:33', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD ,Indikator  : 060245c55fa1cdda77c0639b1978131ba5cab3dc', '2025-06-11 14:42:33'),
('daa57ea5ce36b6ad88c5d8dcda0ab29f11cd1d1b', '2025-06-11 09:44:19', 'DELETE', 'admin', 'Hapus Parameter  : E. Telah dilaksanakan Pencananangan ZI Unit Kerja', '2025-06-11 09:44:19'),
('dac509ad05610e5e8aa4cd2fc8c5e54c2a48dec4', '2025-06-11 10:24:45', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 10:24:45'),
('db074795a552168139c1ebf56f7273ebf57cbcaa', '2025-06-19 10:34:30', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia Sistem informasi pelayanan publik elektronik namun belum online (e-kiosk/ display TV/ layar monitor)', '2025-06-19 10:34:30'),
('db137ed8e6e6044dc6b8a961fa3a3ca556c29cab', '2025-06-19 11:44:25', 'INSERT', 'soal', 'Tambah Data Parameter : Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah', '2025-06-19 11:44:25'),
('db47e5d5b5cc1bea3faaf1f83f15175b6f2bf5e5', '2025-06-11 22:58:24', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Surat Keputusan/Naskah Dinas Penetapan Propemperda ,Indikator  : 8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-11 22:58:24'),
('db6d7c6117546925eec896206fe26b1c3ffdd6b9', '2025-06-13 10:51:59', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 10:51:59'),
('db89cacbbf1ee3341f29be7664904508a21a3ef7', '2025-06-13 11:38:04', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI ,Indikator  : 4936f4074cfdb199ef8064f699a81f1c53662e6f', '2025-06-13 11:38:04'),
('db89edef734057af7acede86005fe6e10d9013dd', '2025-06-19 10:28:50', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sarana FO informasi layanan dengan 2 fasilitas    ', '2025-06-19 10:28:50'),
('db8f89c55c0743b493102c91423003547823149a', '2025-06-13 11:08:25', 'DELETE', 'budker', 'Hapus Parameter  : 1. Nilai 90 s.d. 100 dengan kategori AA (Sangat Memuaskan) 2. Nilai lebih dari 80 s.d 90 dengan kategori A (Memuaskan) 3. Nilai lebih dari 70 s.d 80 dengan kategori BB (Sangat Baik) 4. Nilai lebih dari 60 s.d 70 dengan kategori B (Baik) 5. Nilai lebih dari 50 s.d 60 dengan kategori CC (Cukup) 6. Nilai lebih dari 30 s.d 50 dengan kategori C (Kurang) 7. Nilai 0 s.d 30 dengan kategori D (Sangat Kurang)', '2025-06-13 11:08:25'),
('db9b847abfcf4cb79bb7883033e0428859f210b2', '2025-06-19 10:45:29', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia tindak lanjut atas konsultasi dan pengaduan dari semua lapisan masyarakat', '2025-06-19 10:45:29'),
('dc5ca69f7c6e9a0505c1ce3cb8a3bfba317b59eb', '2025-06-23 13:08:53', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 13:08:53'),
('dcce1f8227cd20c4c4784f8b0cf51ba8ee26b0e0', '2025-06-13 10:16:55', 'UPDATE', 'rb_renaksi', 'update Data Parameter : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi penganggaran', '2025-06-13 10:16:55'),
('dce2a59ee7b29d9e0a94cf2f4a4496bc2947bd1d', '2025-06-23 12:20:06', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:20:06'),
('ddb2e7a86b0217c5cb41100ce2ffecb3225e8200', '2025-06-16 11:29:25', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-16 11:29:25'),
('ddb920232071ab9da095c306059fb08eb9e3bb49', '2025-06-20 09:06:49', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal ,Indikator  : 95e18a732238ea906e25d348f878f80b7d9345c2', '2025-06-20 09:06:49'),
('ddcddb09aedb78dc216cf62717f924c786afbdbc', '2025-06-18 15:00:14', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak ada rencana tindak lanjut SKM', '2025-06-18 15:00:14'),
('ddd39442ca2e039abdfa6ead368b6f55bdda9fd5', '2025-06-20 10:05:32', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : 3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut hasil SKM sesuai PermenPANRB No. 16 Tahun 2017 ,Indikator  : 9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-20 10:05:32'),
('de352271f9a91d4413ab9b79adace4cf38ed6d3b', '2025-06-10 23:27:03', 'UPDATE', 'admin', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-10 23:27:03'),
('de40d4de93367c361a341f30ae457c62b6288541', '2025-06-10 20:00:59', 'INSERT', 'admin', 'Tambah Data Sub Aspek : 2. Nilai Sakit Perangkat Daerah Bobot : 100', '2025-06-10 20:00:59'),
('de6c0741c0dfd19ed88369e53e343c19c577efce', '2025-06-16 09:36:26', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering', '2025-06-16 09:36:26'),
('defaf59584622ce1a9ea31975e3e2f22e504d0f3', '2025-06-11 18:50:52', 'UPDATE', 'admin', 'Update Data Form : LKE REFORMASI BIROKRASI PERANGKAT DAERAH  Tahun : 2025', '2025-06-11 18:50:52'),
('df41da388c28a8e080b5cdbad914fe1368fe3413', '2025-06-13 12:50:07', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 12:50:07'),
('df516daf9a42fc30ca7956e8658fd3d4fad7a46b', '2025-06-10 22:54:24', 'INSERT', 'admin', 'Tambah Data Parameter : D. Telah dilaksanakan evaluasi oleh TPI', '2025-06-10 22:54:24'),
('dffa3d073fce08b8d88919db3c056fad30d1e386', '2025-06-19 10:10:40', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia tempat parkir', '2025-06-19 10:10:40'),
('e01bdd533bbb46939aadae962164b045f3fbe515', '2025-06-19 09:30:13', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Diisi dengan Persentasi realisasi APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Berjalan Rumus = Realisasi APBD Tahun Berjalan / Total APBD x 100%', '2025-06-19 09:30:13'),
('e05c5cf7b9500572d2b5b86b391643b583f0ab65', '2025-06-13 11:29:04', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Persentase keterisian data prioritas Rumus: (Jumlah data prioritas yang tersedia di Satu Data dibagi Potensi data prioritas) * 100%', '2025-06-13 11:29:04'),
('e0849b9f705de742b3cfa97b9b89a01053e4bb9c', '2025-06-18 14:59:05', 'INSERT', 'sultan', 'Tambah Data Parameter : Tindak lanjut hasil SKM dilaksanakan 30-80%, dibuktikan dengan laporan pelaksanaannya Tindak lanjut hasil SKM dilaksanakan kurang dari 30%, dibuktikan dengan laporan pelaksanaannya', '2025-06-18 14:59:05'),
('e08b1e7d93820108e778855fbf2279e196f55e2a', '2025-06-10 23:27:25', 'UPDATE', 'admin', 'update Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-06-10 23:27:25'),
('e0a0fe9972999aec5bbb939d5bdf1ce41618ba13', '2025-06-10 22:29:22', 'INSERT', 'admin', 'Tambah Data Parameter : D. Sudah Memiliki Peta Proses Bisnis', '2025-06-10 22:29:22'),
('e0b886ac0c39b6d004dc6d5a75663ea4232e369e', '2025-06-10 22:32:41', 'INSERT', 'admin', 'Tambah Data Parameter : D. Perangkat Daerah konsultasi dengan Diskominfo dalam proses Pembangunan/ Pengembangan Aplikasi ', '2025-06-10 22:32:41'),
('e0dace583a2ceaca7b68df9f15789e06340bbd40', '2025-06-10 23:29:00', 'UPDATE', 'admin', 'update Data Parameter : Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', '2025-06-10 23:29:00'),
('e156e88b741a8b5d73a0da5a496bb86bbd0a24a6', '2025-06-13 09:43:13', 'INSERT', 'budker', 'Tambah Data Parameter : 41-60% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:43:13'),
('e1574993a3dfff3513a86ba7385a331345421f32', '2025-06-19 09:08:08', 'DELETE', 'muftyabyan', 'Hapus Parameter  : Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', '2025-06-19 09:08:08'),
('e1820841fb35846971a8da6a2350ff737f97f12d', '2025-06-10 19:56:45', 'UPDATE', 'admin', 'Update Data RB : I. RB General Perangkat Daerah Bobot : 100', '2025-06-10 19:56:45'),
('e24051aea2e02702a4351367c190c7c942a19abe', '2025-06-10 22:25:16', 'INSERT', 'admin', 'Tambah Data Parameter : C. Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', '2025-06-10 22:25:16'),
('e2737ff775c10093acafeb54b0d8f99a59cd94ca', '2025-06-20 14:56:50', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot media konsultasi pengaduan maupun keterhubugan Instansi dengan SP4N Lapor diambil dari tampilan login admin ,Indikator  : 773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-20 14:56:50'),
('e28c36e16e16e2ef76b90a6698ecec151dfe5124', '2025-06-16 09:37:49', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Pencatatan paket transaksional pada Toko Daring', '2025-06-16 09:37:49'),
('e28f10cf38b67ac9ed7657407e01d12e22a7d59a', '2025-06-13 11:12:05', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah mengunakan Sistem Pengadaan Secara Elektronik (SPSE)', '2025-06-13 11:12:05'),
('e31d1768ea3b540963be9d2ee7a696d07df6389d', '2025-06-16 09:37:07', 'INSERT', 'soal', 'Tambah Data Indikator : Persentase Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE', '2025-06-16 09:37:07'),
('e3468d1a3d49c75a5632feb698b9601c808e5b59', '2025-06-19 09:21:47', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Penyampaian 1 buah \"Praktek Baik\" Tata Kelola Pemerintahan Berbasis Elektronik (Digital Services)/ layanan administrasi pemerintah berbasis elektronik dalam bentuk Media Publikasi (booklet, brosur, e-books, pamplet dikemas secara informatif dan menarik) ,Indikator  : 413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 09:21:47'),
('e35087508addfac182ad63477f97bda474201d69', '2025-06-19 11:29:28', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-19 11:29:28'),
('e354b3f71cc11cad796816d6675bbf18388101e6', '2025-06-16 10:43:52', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Raport Kinerja Perangkat Daerah pada Lingkup Penyelenggaraan Urusan yang menjadi core bisnis Perangkat Daerah pada Bidang Teknis Perangkat Daerah ,Indikator  : bef033f1d4dfe3a1cc60dd728acf7a3530b4a396', '2025-06-16 10:43:52'),
('e38eb161c403d294aa282e507267f4aa99e3a5c5', '2025-06-10 21:21:53', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 1.1 Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-06-10 21:21:53'),
('e3b4529d8d17b7ac6f2020fa365887ca0b01dc80', '2025-06-19 09:08:12', 'DELETE', 'muftyabyan', 'Hapus Parameter  : Tidak ada IKU Perangkat Daerah tercapai (0%)', '2025-06-19 09:08:12'),
('e3d3b8f79c73bfc679c28ab9733eeaeaa0371066', '2025-06-20 08:55:11', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-20 08:55:11'),
('e45b4f128762cf1c5a6491f0d8cd02501626ac12', '2025-06-19 13:52:15', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, d ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 13:52:15'),
('e4fb6ed2193f9e34156a4505d474c8a4b11886ae', '2025-06-11 23:04:19', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Jumlah pengaduan pada aplikasi SP4N-LAPOR/ screenshot Jumlah Pengaduan pada SP4N-LAPOR ,Indikator  : dc396ec8de0dba70307b0bf352b614202622f75e', '2025-06-11 23:04:19'),
('e579a2c5dd5981898a9e4c16f38f2bd16d0363e9', '2025-06-19 10:19:02', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia fasilitas apapun', '2025-06-19 10:19:02'),
('e5caeeab37d3a1d241b925321a1113ec59a06fd9', '2025-06-19 09:17:34', 'INSERT', 'muftyabyan', 'Tambah Data Indikator : Tindaklanjut Hasil Pemerikaan APIP ', '2025-06-19 09:17:34'),
('e5d1f43696c9b27bb22d7ea56a77284c07ab9f8c', '2025-06-13 09:13:38', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:13:38'),
('e5d48f711c0bf66695261cf70d13c18eb52f727b', '2025-06-11 15:32:05', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 15:32:05'),
('e5eb070a2ea335f3af416e365d514d2be0cb53de', '2025-06-16 10:20:34', 'INSERT', 'soal', 'Tambah Data Parameter : Data dan Informasi Implementasi Transformasi digital administrasi pemerintahan yang disampaikan akan disandingkan dengan data dan informasi seperti; Reviu/tanggapan publik (google reviu terkait kualitas layanan), data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Menyampaikan/melaksanakan Continouous Improvment penerapan Sistem Informasi berbasis elektronik yang telah terintegrasi dalam satu sistem (single sign on) B. Sistem Informasi berbasis elektronik telah mengintegrasikan seluruh/sebagaian layanan dalam satu sistem (single sign on) C. Sistem Informasi berbasis elektronik telah berkontribusi terhadap tercapainya kinerja Pemerintah Daerah dan/atau Perangkat Daerah D. Sistem Informasi berbasis elektronik telah memberikan manfaat dan direspon positif oleh pengguna layanan E. Sistem Informasi Berbasis Elektronik telah Berfungsi dengan Baik/dapat dioperasikan/dapat diakses oleh pengguna layanan F. Sistem informasi belum berfungsi/belum dapat digunakan/belum dapat diakses (sistem masih dalam bentuk konsep pengembangan atau prototype)', '2025-06-16 10:20:34'),
('e5f33c37b800f2f2225bd569e77bd596320271bd', '2025-06-11 22:59:35', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Surat Keputusan/Naskah Dinas Pengusulan Perubahan/Pencabutan/ Penggabungan Perda/Perkada hasil evaluasi ,Indikator  : 8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-11 22:59:35'),
('e610ffd1650c4400e3daaf6a33eb8aeaf151e0e4', '2025-06-13 10:19:42', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Capaian Kinerja Core Business Organisasi  Bobot : 100', '2025-06-13 10:19:42'),
('e628c1afb5513bc06f5cb84891d1dd5ca83c9617', '2025-06-10 21:11:01', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-10 21:11:01'),
('e690ffffc5091809761e19035fae00ddaab05aa7', '2025-06-13 09:08:23', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-13 09:08:23'),
('e698ea03bc1b97fc777dcc5b6fdadc74b70677ff', '2025-06-11 19:52:47', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 19:52:47'),
('e6bada5ff649b51682f97fe780f7eb1bcb196cb9', '2025-06-14 23:01:37', 'DELETE', 'rb_renaksi', 'Hapus Parameter  : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-14 23:01:37'),
('e6ea61aab808ad127c6ce707b4118fb54aab7089', '2025-06-19 10:26:17', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 2 fasilitas penunjang', '2025-06-19 10:26:17'),
('e7491917179a8cc762ffb123519d9e24c0010458', '2025-06-19 09:13:00', 'INSERT', 'muftyabyan', 'Tambah Data Parameter : Tidak ada IKU Perangkat Daerah tercapai (0%)', '2025-06-19 09:13:00'),
('e78b53a423133d476ad7d3600e6d2b74319aa4f4', '2025-06-10 22:53:59', 'INSERT', 'admin', 'Tambah Data Parameter : C. Telah dilaksanakan evaluasi oleh TPN', '2025-06-10 22:53:59'),
('e7c9f765fb374baa09d081877951fa336e2ed741', '2025-06-23 12:47:00', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:47:00'),
('e866e94a5d75e46931dd282619407256142238fe', '2025-06-13 11:44:47', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik ,Indikator  : 3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2025-06-13 11:44:47'),
('e873b4c2b2570cf0b13cbe069d48e58c49322c41', '2025-06-19 13:40:26', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-19 13:40:26'),
('e8a48cc5f79add9163df8f463c0454f17be6e275', '2025-06-23 12:50:58', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 12:50:58'),
('e9068bc195ab860bfe6d0ab8fe1c979087ef3517', '2025-06-11 22:47:28', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Naskah Akademik/ penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah ,Indikator  : bdc31064087319d26c08507f5f3dbaaaa8d5205c', '2025-06-11 22:47:28'),
('e9316dc9c18ad9c658bf828f58f13918bd43519d', '2025-06-16 09:32:37', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : 1. Screenshot media Publikasi SP4N-LAPOR pada website, media sosial;  2. Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll ,Indikator  : 23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-16 09:32:37'),
('e9b3d277876bd222f57703aa10f8a986c7b157d4', '2025-06-19 09:57:38', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia tempat parkir dengan fasilitas pendukung yang memadai', '2025-06-19 09:57:38'),
('e9d24fd9407da5b156cd973fee0e3dee0665485f', '2025-06-11 16:07:41', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-11 16:07:41'),
('ea1eccd4f995ff80b996057d533cf191fc8343d0', '2025-06-19 09:51:31', 'INSERT', 'sultan', 'Tambah Data Sub Sub Aspek : Konsultasi dan Pengaduan Bobot : 10.00', '2025-06-19 09:51:31'),
('ea44a85e3ce39449908fb5be96b3f84914a4b5d7', '2025-06-10 22:19:35', 'INSERT', 'admin', 'Tambah Data Parameter : C. Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-06-10 22:19:35'),
('ea5e6f64aaa6aa367224c33af9157fb4ee5095fd', '2025-06-13 11:35:47', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Surat Edaran, Surat Permohonan, Surat Balasan, dan Berita Acara Pemanfaatan Sistem Penghubung Layanan Pemerintah Daerah ,Indikator  : e130a0fb0ce28f10c4f0f1c54249077fe30ed8ef', '2025-06-13 11:35:47'),
('ea60ed2e9d5f4fd8af605a1200b7373365f6aa24', '2025-06-11 15:33:40', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 15:33:40'),
('eaae722bbac32b329abb076600affa08d2616469', '2025-06-13 10:43:08', 'INSERT', 'budker', 'Tambah Data Parameter : Jumlah Pengaduan diatas 10 sampai dengan 20 aduan', '2025-06-13 10:43:08'),
('eac5365b6b01ab0f31286efda04449cc7cde3782', '2025-06-20 09:36:18', 'DELETE', 'soal', 'Hapus Data Bukti Dukung  : 1. Dokumen yang menunjukkan ketersediaan Standar Pelayanan dan Maklumat Pelayanan (SK Penetapan) Sesuai PermenPANRB No. 15 Tahun 2014                                            3. Laporan Hasil Survei Kepuasan Masyarakat dan Laporan hasil tindaklanjut has', '2025-06-20 09:36:18'),
('eacf687912559c462c92b7f592f058ee6404acc5', '2025-06-19 10:25:56', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia 3 fasilitas penunjang', '2025-06-19 10:25:56'),
('ead1b90b76be5bf0570dd8621d44b2bb29d913f1', '2025-06-18 11:12:42', 'INSERT', 'sultan', 'Tambah Data Indikator : Jumlah media publikasi hasil SKM', '2025-06-18 11:12:42'),
('eae5978dea095e63121868e53b5690092c5ddbf5', '2025-06-10 22:28:43', 'INSERT', 'admin', 'Tambah Data Parameter : C. Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-06-10 22:28:43'),
('eb0ea2a13db93dd88a98c7cced4a47ee19221568', '2025-06-18 11:06:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Penyusunan SP telah melibatkan minimal 1 unsur masyarakat     ', '2025-06-18 11:06:13'),
('eb8ae6903d4ad20d4432c50619bece2561634fc7', '2025-06-11 22:38:49', 'INSERT', 'budker', 'Tambah Data Indikator : Evaluasi Produk Hukum', '2025-06-11 22:38:49'),
('ebaf7765e2de5c61e18479b7c95fd8caf4ce274f', '2025-06-11 19:25:31', 'INSERT', 'admin', 'Tambah Data Indikator : Aspek Evaluasi Akuntabilitas Kinerja Internal', '2025-06-11 19:25:31'),
('ec069ba79089b48884726aed7ad52a6ee317fe2d', '2025-06-16 10:37:56', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi Indeks Profesional ASN pada Aplikasi SIAP Sulteng/ My SAPK masing-masing perangkat daerah ,Indikator  : 26fa43a7b899b315dd5f4677400867f2103d9a87', '2025-06-16 10:37:56'),
('ec78e5c802a9676b0962f2e96be4f2a84a58fa7c', '2025-06-11 22:59:22', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Surat Keputusan/Naskah Dinas Penetapan Propemperkada ,Indikator  : 8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-11 22:59:22'),
('ecaef4bcdeed4cf1446345b4c6535cdc8e3454d9', '2025-06-13 12:56:18', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 12:56:18'),
('ecc87bc17f9e196a4e024d158075f7035b2a3de5', '2025-06-18 09:37:17', 'INSERT', 'sultan', 'Tambah Data Indikator : Hasil Survey Kepuasan Masyarakat pada Aplikasi SKM Terintegrasi', '2025-06-18 09:37:17'),
('ece59978ddecea403caa5c409b1710f4661587d3', '2025-06-13 11:32:30', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Telah mengisi form  pembangunan / pengembangan aplikasi di lingkungan Pemerintah Provinsi Sulawesi Tengah  ,Indikator  : 1ff16ba78f665f700312c31ca80da58389e7a81b', '2025-06-13 11:32:30'),
('ecf5d9162f23870065337346b8d26dfa34f26b6f', '2025-06-20 14:35:53', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 2. *Jika ada* Dokumen hasil Reviu SP (Berita Acara, Notulensi dan Dokumentasi) ,Indikator  : 4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-20 14:35:53'),
('ed1ab8160dcfd4b7f94763211a79521a58f430ee', '2025-06-16 09:59:59', 'INSERT', 'soal', 'Tambah Data Parameter : Penetapan Indikator Kinerja Penyelenggaraan Urusan yang menjadi core Bisnis Perangkat Daerah pada Cascading Kinerja', '2025-06-16 09:59:59'),
('ed31174d00cfcf73233f416a783b3f37c4e583bf', '2025-06-13 09:40:40', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi penganggaran', '2025-06-13 09:40:40'),
('ed6176fbefb63f1b6505c87d4e34ef10a2a5b61a', '2025-06-13 10:35:21', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : Nilai Kepatuhan Pencatatan Pengadaan Barang/Jasa Pemerintah pada SPSE  Bobot : 100', '2025-06-13 10:35:21'),
('edf59d29e55f0035b0534d7b09a0747c6d8e56fc', '2025-06-10 20:16:27', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-10 20:16:27'),
('ee3ae1ff87ac36a2945ce8f842825df5ade704bb', '2025-06-19 10:20:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Toilet pengguna layanan dengan 3 kondisi', '2025-06-19 10:20:36'),
('ee88f271e01dd60a24cee9d5f5f3d1eaa263c095', '2025-06-11 18:40:46', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-11 18:40:46'),
('ef4eb273d6ab8bf0c41497d582d214af93dced4c', '2025-06-13 10:07:14', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Tingkat Implementasi Rencana Aksi Pembangunan RB General Bobot : 100', '2025-06-13 10:07:14'),
('ef50488de3cec4e4acf3b944fc454b8c954f8fe2', '2025-06-16 14:42:11', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 14:42:11'),
('ef5bfb0fc4abcb00b6798878f69307db7db22f05', '2025-06-13 09:52:07', 'INSERT', 'budker', 'Tambah Data Parameter : 21-40% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '2025-06-13 09:52:07'),
('efae75a6ad5a022f18de76f3c256748c7cb31462', '2025-06-23 14:57:46', 'UPDATE', 'adminku', 'UPDATE Password User  : adminku Full Name : Admin Surabe', '2025-06-23 14:57:46'),
('efd2ddbf9b74bf9de8444c51c7c51745b1ee9f92', '2025-06-20 09:07:21', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : LHE Hasil Evaluasi Akuntabilitas Kinerja Internal masing-masing perangkat daerah dan/ atau Berita Acara Hasil Evaluasi Akuntabilitas Kinerja Internal ,Indikator  : 89a3cfcafdb60bf04616631ab63464418ff7367c', '2025-06-20 09:07:21'),
('efdd1c7e5c6a2bbb3bfd768fea0b63483ff8743d', '2025-06-13 11:13:00', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan SRIKANDI', '2025-06-13 11:13:00'),
('f018e19b9cd9df1c3a24e0615dc60583c54a16df', '2025-06-19 10:21:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Toilet pengguna layanan dengan 1 kondisi ', '2025-06-19 10:21:13'),
('f03b5109ab70274ff9224f61b4a0d77445f7198a', '2025-06-11 22:36:56', 'INSERT', 'budker', 'Tambah Data Indikator : Naskah Akademik/penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:36:56'),
('f05ee0c05e70560328d00ea1bbbf1e82488f630f', '2025-06-10 23:01:13', 'INSERT', 'admin', 'Tambah Data Parameter : Terdapat Dokumen Manajemen Risiko SPBE', '2025-06-10 23:01:13'),
('f08b681de57e1e1a6989c58ee3ecebda796ffc06', '2025-06-11 18:59:18', 'UPDATE', 'admin', 'Update Data Sub Aspek : Indeks Kualitas Pelayanan Publik Bobot : 100', '2025-06-11 18:59:18'),
('f0a2d9d6c04beeeee83aa17ae785916154dd92af', '2025-06-10 21:53:47', 'INSERT', 'admin', 'Tambah Data Indikator : g) Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-06-10 21:53:47'),
('f0aa1687ccdf399eda632a178f24757c10f8299a', '2025-06-18 10:19:55', 'INSERT', 'sultan', 'Tambah Data Parameter : Belum dilakukan Pencanangan Zona Integritas', '2025-06-18 10:19:55'),
('f0cf65e806a30411340c3caf29f10998aa1a7faa', '2025-06-19 13:30:55', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-19 13:30:55'),
('f1213abb94d964ed084a4f08ed05b185e7fc8a03', '2025-06-19 10:35:09', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia sistem informasi pelayanan publik non elektronik melalui media lisan (pusat informasi)     ', '2025-06-19 10:35:09'),
('f1828624c2e784a28a1f27c07f7e4c8954751adf', '2025-06-13 11:38:32', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik ,Indikator  : 3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2025-06-13 11:38:32'),
('f19ba0345c8b88be1f95ee42b4cdf6fbbf3e1ceb', '2025-06-13 09:20:12', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-13 09:20:12'),
('f19fd557d8fa6c4b5741f59181543970fe70c1bc', '2025-06-11 22:40:01', 'INSERT', 'budker', 'Tambah Data Indikator : Telah melakukan diseminasi/sosialisasi SP4N-LAPOR kepada masyarakat/pengguna layanan', '2025-06-11 22:40:01'),
('f24d3b92e567e22a529a33bcc520d195def60487', '2025-06-16 10:33:14', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot Pencatatan Paket e- Purchasing pada Katalog Elektronik atau Laporan Pencatatan Paket e- Purchasing pada Katalog Elektronik yang dikeluarkan oleh Biro PBJ ,Indikator  : 4b3401518bf31cce72ee049f1d8f63a440b13e0c', '2025-06-16 10:33:14'),
('f2664b394fea8c2604f4fe04f19c124e5c267ce8', '2025-06-13 11:31:34', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Identifikasi inovasi berbasis TIK baru yang berbeda dengan proses bisnis sebelumnya ,Indikator  : 6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2025-06-13 11:31:34'),
('f2d06c840810536b204756be409902354aaa7655', '2025-06-10 21:25:40', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 2.1 Nilai Evaluasi Akuntabilitas Kinerja Internal  Bobot : 100', '2025-06-10 21:25:40'),
('f2f0c6c13f1eb3bbb61d0eca25fbd7864e6c5952', '2025-06-11 23:05:14', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Laporan Rekapitulasi rata-rata lama hari penyelesaian pengaduan pada aplikasi SP4N-LAPOR/ screenshot rata-rata lama Penyelesaian Pengaduan pada SP4N-LAPOR ,Indikator  : 333624b6008c5fda79189d98f043ec0763db0355', '2025-06-11 23:05:14'),
('f31250f779f32bb87499d0b979bd4de3c8e241d8', '2025-06-13 10:35:56', 'DELETE', 'rb_renaksi', 'Hapus Data Indikator  : Telah Menggunakan Layanan Penganggaran Berbasis Elektronik', '2025-06-13 10:35:56'),
('f346ab6a9d0f3c1966a02d30c87a7fd5653a230e', '2025-06-19 10:50:08', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat media konsultasi dan pengaduan secara offline secara terpisah dari front office, serta tersedia secara online ', '2025-06-19 10:50:08'),
('f37d9efe1da5b8d130d194365634cc1ab291bd71', '2025-06-13 11:03:00', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 11:03:00'),
('f3c822765b7a75b97c316958556ef902a05d9c1b', '2025-06-18 10:58:39', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia SP namun tidak memenuhi 14 Komponen    ', '2025-06-18 10:58:39'),
('f3f8059d236a5dd14d712b711139e9dba77ec277', '2025-06-17 08:59:21', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-17 08:59:21'),
('f405206241a573340325db01d3893d7a4a9ebf91', '2025-06-19 10:56:38', 'INSERT', 'sultan', 'Tambah Data Parameter : 90% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai', '2025-06-19 10:56:38'),
('f4060c640fe1ad8a16da593b6be9a4c6d7c67c0b', '2025-06-11 14:53:07', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi- ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-11 14:53:07'),
('f40b9e25feef3ee12e4d59e376a36606e30094c7', '2025-06-13 11:06:49', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 11:06:49'),
('f423bf7f508597143e804d6d2207411199944703', '2025-06-11 22:26:43', 'INSERT', 'budker', 'Tambah Data Sub Aspek : Indeks Reformasi Hukum Bobot : 100', '2025-06-11 22:26:43'),
('f428a0429a1b03bea59ec0cf1cc789a70380bf5c', '2025-06-10 21:31:35', 'INSERT', 'admin', 'Tambah Data Sub Sub Aspek : 7.1 Nilai Survey Kepuasan Masyarakat Perangkat Daerah Bobot : 100', '2025-06-10 21:31:35'),
('f4414a3f63cf97e2d363e2a66fabf73adff28aae', '2025-06-19 10:22:45', 'INSERT', 'budker', 'Tambah Data Bukti Dukung : Dokumentasi foto publikasi media luar ruang seperti spanduk, banner, baliho, xbanner, dll ,Indikator  : 23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-19 10:22:45'),
('f46241783668f3ac8af969d43e3dd35df3fabe9f', '2025-06-18 11:10:12', 'INSERT', 'sultan', 'Tambah Data Indikator : Jumlah media publikasi untuk komponen Service Delivery', '2025-06-18 11:10:12'),
('f4857e1b92bc63221b577e74480eea6c9a504c22', '2025-06-16 11:00:14', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-16 11:00:14'),
('f548e590326207316e06e33c578ba7b2af5e1fbd', '2025-06-19 11:32:12', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Screenshot progres pelaksanaan penggunaan  produk dalam negeri  pada Pengadaan Barang/Jasa Pemerintah melalui aplikasi SIPD P3DN dan Aplikasi Bigbox LKPP ,Indikator  : e235d1e25296c5f4a241e55993abcb72b24ee4b9', '2025-06-19 11:32:12'),
('f58e12d5591e23c65e4fda3854b99cd0c4487299', '2025-06-20 14:39:12', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : 5. Publikasi baik SP, MP, dan Nilai SKM (Media Cetak/Non Elektronik, Media Elektronik, Media Sosial, SIPPN) ,Indikator  : ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-20 14:39:12'),
('f59755636e8b78ec4980ae4fa13e47200bf7ef78', '2025-06-19 11:35:55', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak tersedia sistem antrian', '2025-06-19 11:35:55'),
('f5a54d0ac86b96c6ecbbd8058887f7bfb7cdd835', '2025-06-23 12:31:00', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:31:00'),
('f696a072b04949ec30b11512058d446b2d686f54', '2025-06-23 12:44:12', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:44:12'),
('f6ee26e4efe5626f187419313d156bd32b3ad683', '2025-06-11 09:24:22', 'UPDATE', 'admin', 'update Data Parameter : Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-06-11 09:24:22'),
('f6fa70d0a23c6eb5e1c5376f1c247a767c8205e2', '2025-06-16 09:59:30', 'INSERT', 'soal', 'Tambah Data Indikator : Dokumen Rencana Aksi Pembangunan RB Tematik telah disusun dan ditetapkan sebagai dokumen formal dengan memuat logical framework', '2025-06-16 09:59:30'),
('f748a3e9772ce2a448ee5080d40b37c8e50c011d', '2025-06-11 19:25:04', 'INSERT', 'admin', 'Tambah Data Indikator : Aspek Pelaporan Kinerja', '2025-06-11 19:25:04'),
('f75260bb55c39fd4a185d907972b626a4d450606', '2025-06-19 10:55:19', 'INSERT', 'sultan', 'Tambah Data Parameter : Terdapat dokumentasi yang diarsipkan dan dituangkan dalam laporan  ', '2025-06-19 10:55:19'),
('f75904f005f683737019eb54c6480ece111dcb4d', '2025-06-13 09:42:54', 'INSERT', 'budker', 'Tambah Data Parameter : 61-80% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2025-06-13 09:42:54'),
('f76c773146699da54944295053341deef8fc1ec0', '2025-06-11 22:40:43', 'INSERT', 'budker', 'Tambah Data Indikator : Persentase Penyelesaian Pengaduan pada SP4N-LAPOR! dengan Status Selesai', '2025-06-11 22:40:43'),
('f7a191af06dbbc59ab3debb4403bba77e21d164c', '2025-06-18 09:47:52', 'INSERT', 'sultan', 'Tambah Data Parameter : Diisi dengan Nilai Hasil Survey Kepuasan Masyarakat terhadap layanan Perangkat Daerah', '2025-06-18 09:47:52'),
('f7c7355d3a980fad89c3727c74f0a035d5cde853', '2025-06-20 14:55:28', 'DELETE', 'sultan', 'Hapus Data Indikator  : Tersedia sarana prasarana penunjang', '2025-06-20 14:55:28'),
('f828bdcdb9b91e5341da543eb2567bfed31101f9', '2025-06-19 10:48:16', 'INSERT', 'sultan', 'Tambah Data Parameter : Sarana konsultasi pengaduan pengguna layanan dengan 1 fasilitas   ', '2025-06-19 10:48:16'),
('f85a9ae9b79cfa2caac41e53bff3d0f108700c2a', '2025-06-20 14:53:02', 'INSERT', 'sultan', 'Tambah Data Bukti Dukung : SK Penetapan oleh Kepala Unit terkait Kriteria Penerima Penghargaan (Umumnya dilihat dari Kinerja Pegawai, Kehadiran, Kerjasama tim, memiliki inovasi, berpenampilan menarik ataupun belum pernah mendapat komplain dari penerima layanan) ,Indikator  : e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-20 14:53:02'),
('f861f98600318185c8d7605ad7425871719b027f', '2025-06-13 11:23:13', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah menggunakan aplikasi Open Data', '2025-06-13 11:23:13'),
('f8633a49572e56e20d0d9ba6ac185a94d902422f', '2025-06-19 10:09:55', 'INSERT', 'sultan', 'Tambah Data Parameter : Tersedia tempat parkir dan memiliki 2 atau lebih fasilitas parkir  ', '2025-06-19 10:09:55'),
('f8fd8439e60b9e7b87ad6f560870d1dcd818f0cc', '2025-06-17 09:54:25', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-17 09:54:25'),
('f9103df5bb071eda89f193edc4ab6f1c58c74b0d', '2025-06-18 15:13:35', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia mekanisme yang dibangun untuk menjaga dan meningkatkan motivasi kerja Pelaksana pelayanan', '2025-06-18 15:13:35'),
('f95073675f78b5efdb3e34e70ffa19a95276a04e', '2025-06-11 09:44:24', 'DELETE', 'admin', 'Hapus Parameter  : D. Telah dilaksanakan evaluasi oleh TPI', '2025-06-11 09:44:24'),
('f983abc1c691023c3b76ac098d1f2aac492c9f29', '2025-06-16 10:02:50', 'UPDATE', 'soal', 'update Data Parameter : Penetapan Indikator Kinerja Penyelenggaraan Urusan yang menjadi core Bisnis Perangkat Daerah pada Cascading Kinerja', '2025-06-16 10:02:50'),
('f9995d9856b4002b71cb6a71f538806f948c04d7', '2025-06-20 09:16:07', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-20 09:16:07'),
('fa1962e07adc83fd669337bbee380dfae14dab41', '2025-06-11 18:49:29', 'UPDATE', 'admin', 'Update Data Form : LKE REFORMASI BIROKRASI PERANGKAT DAERAH  Tahun : 2025', '2025-06-11 18:49:29'),
('fa241ef8a29db51ae89a871275c8b62c02e65786', '2025-06-16 10:48:29', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-16 10:48:29'),
('fa2ecb2cef7a8dbf99c247b6c539232627da45e7', '2025-06-19 13:58:39', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 4. 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-19 13:58:39'),
('fa6b8b1d5876b55c72bf0ebf17b4196935dfed45', '2025-06-13 09:19:37', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-13 09:19:37'),
('fa87a6e063675bbf864f3947ca244fba761f5be3', '2025-06-23 09:16:46', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 09:16:46'),
('fad501082b1d488348b4848f496a0b6cf172669b', '2025-06-13 12:53:45', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 12:53:45'),
('fadb28949ff363f67d77b5a840a8bbbc1ad915b8', '2025-06-13 09:06:44', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-13 09:06:44'),
('fb3d4e9444bf915ee5a010ebd8c2905f86262708', '2025-06-13 11:28:32', 'INSERT', 'rb_renaksi', 'Tambah Data Parameter : Telah memiliki standar data statistik yang lengkap untuk semua Indikator Kinerja Utama (IKU) yang diampu dinas Rumus: (Jumlah IKU yang memiliki standar data dibagi jumlah total IKU) * 100%', '2025-06-13 11:28:32'),
('fb426962dcb6fdad357f3e3908698e58053877e1', '2025-06-16 10:49:36', 'DELETE', 'rb_renaksi', 'Hapus Data Bukti Dukung  : 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) 5. Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasion', '2025-06-16 10:49:36'),
('fb5a01f4795f9b73eff378d9a23d7626523e6cbe', '2025-06-13 10:18:22', 'INSERT', 'admin', 'Tambah Data Sub Aspek : Digitalisasi Administrasi Pemerintahan Bobot : 100', '2025-06-13 10:18:22'),
('fb7633ed30405afbc0f9ab26fc19b67ba74464f8', '2025-06-20 09:10:27', 'INSERT', 'muftyabyan', 'Tambah Data Bukti Dukung : Berita Acara Tindaklanjut Hasil Pemeriksaan/ Laporan Rekapitulasi Tindaklanjut Hasil Pemeriksaan yang dikeluarkan oleh Inspektorat ,Indikator  : 124e174eab918098602fc8b5c503877d45dc8037', '2025-06-20 09:10:27'),
('fb8f1e82a6c3e22be9edaad70a3d3aeec43193b5', '2025-06-13 11:06:53', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-13 11:06:53'),
('fbb150a4511737d748ba8ecb38d017b997caf315', '2025-06-19 11:42:33', 'INSERT', 'soal', 'Tambah Data Parameter : Sistem Informasi berbasis elektronik telah berkontribusi terhadap tercapainya kinerja Pemerintah Daerah dan/atau Perangkat Daerah', '2025-06-19 11:42:33'),
('fbcc3194ec7c098cbfdd292bcd04ae11578240e2', '2025-06-19 09:58:16', 'INSERT', 'sultan', 'Tambah Data Indikator : Tersedia ruang tunggu dengan fasilitas wajib dan pelengkap', '2025-06-19 09:58:16'),
('fc5757a75b2cb62d32e28ad63e9f23a241fbc3d6', '2025-06-23 12:53:07', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 12:53:07'),
('fc5f2a0740ffaeb71d69b2b430414be35c247ae1', '2025-06-13 10:44:17', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 10:44:17'),
('fc8d0da6915cf8ce420a0df0cb53189dcc17fdc2', '2025-06-16 08:47:40', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Template excel versi Kemanpanrb 1. Domain Proses Bisnis (sampai level n dan kelengkapan metadata) 2. Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) 3. Domain Aplikasi (selaras dengan Layanan dan data/informasi- ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-16 08:47:40'),
('fcde424261a743ac8d20f5620b2585d506052ce3', '2025-06-23 12:55:01', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-06-23 12:55:01'),
('fce5e6ad8d34104b8ff3730a3e01aa571d5f864b', '2025-06-13 10:50:49', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 10:50:49'),
('fcf2c906aaf16007b669158e47b8f04a236775f4', '2025-06-19 09:28:36', 'INSERT', 'sultan', 'Tambah Data Parameter : Tidak memiliki kebijakan jam pelayanan/kerja ', '2025-06-19 09:28:36'),
('fd016d11f7119584ace9ec82e617670092e48256', '2025-06-13 09:06:24', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:06:24'),
('fd3b548cad4ce0b9873475fca04c142bd624e582', '2025-06-11 18:52:12', 'UPDATE', 'admin', 'Update Data Form : LKE REFORMASI BIROKRASI PERANGKAT DAERAH  Tahun : 2025', '2025-06-11 18:52:12'),
('fdf798cd9109853c08aa3dab4f70dbd9310668da', '2025-06-19 09:43:13', 'INSERT', 'sultan', 'Tambah Data Parameter : Pelaksana pelayanan menerapkan 1 (satu)  unsur budaya pelayanan   ', '2025-06-19 09:43:13'),
('fe18fa758fcf62fb1bb106c39714cb55b1511b0e', '2025-06-18 11:13:04', 'INSERT', 'sultan', 'Tambah Data Indikator : Persentase rencana tindak lanjut hasil SKM yang telah selesai ditindaklanjuti', '2025-06-18 11:13:04'),
('fe3a91e9401aa1ec67182b2eb4feed8d0238167d', '2025-06-19 11:33:10', 'INSERT', 'sultan', 'Tambah Data Parameter : Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum     ', '2025-06-19 11:33:10'),
('fe4a39bed4bd92ad8d600f8f8e1a8f9c59cddd74', '2025-06-11 15:27:27', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-11 15:27:27'),
('fe61ff6b29765604a6ab1a102b6afb643eeb04e0', '2025-06-16 08:42:09', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : 4. Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) 5. Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasion ,Indikator  : 45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-16 08:42:09'),
('fea550b16e25b1c2c985be260711723aae81aaed', '2025-06-13 09:08:06', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-13 09:08:06'),
('fead8ba6825ddbce6285ba35d84395ba5b3f5db9', '2025-06-23 13:16:49', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-23 13:16:49'),
('feede03b0b88c6f41585c0c728dadb73d732a021', '2025-06-11 15:00:02', 'INSERT', 'rb_renaksi', 'Tambah Data Bukti Dukung : Alokasi anggaran TIK diselaraskan antara roadmap dengan renstra ,Indikator  : abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2025-06-11 15:00:02'),
('ff72b7f657f82faadeadf60a982eb98681936b5f', '2025-06-23 12:54:34', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-06-23 12:54:34');

-- --------------------------------------------------------

--
-- Table structure for table `lke_log_user`
--

CREATE TABLE `lke_log_user` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loged_at` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_log_user`
--

INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES
('002cb6b3d26d34e46ce4869375e0fb698ab2eec6', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 12:59:23', '103.148.29.67', 'LOGIN'),
('0080491365e48929883214e0e7672cfa7be3c9fb', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 11:06:37', '103.148.29.67', 'LOGIN'),
('01037cff926e6f116063330c1a9111761ca9f322', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:44:03', '103.148.29.67', 'LOGOUT'),
('0136dba0b1f076ebf1e73dd25078d647824f75e6', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 12:53:07', '103.148.29.67', 'LOGOUT'),
('02b5c9634989450e9ac4046175138a285c129c5c', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-16 13:11:31', '103.148.29.67', 'LOGOUT'),
('033870ed7976c30a838bf8013b4eb59a168b1082', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:51:59', '103.148.29.67', 'LOGOUT'),
('03b5f7ce75d1dd4e53f747f1e41af0e1dd6fbb6f', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 10:24:45', '114.10.134.128', 'LOGIN'),
('087fbb67b3e222fef629e961a6b0716d50204bd2', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 13:08:39', '103.148.29.67', 'LOGOUT'),
('0ae81b9bcffa7f5c4c9900fa80265354d0176a2b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:40:04', '140.213.216.83', 'LOGOUT'),
('0bfef8cba8c6c9611fc940adcc9523157ab4b73e', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-11 22:18:38', '103.176.252.18', 'LOGIN'),
('0cad18ef14a3dcf9409ce13053927d18c9b6ee3a', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 15:11:42', '127.0.0.1', 'LOGIN'),
('0e79aa38116b583c2deeef8ba76c85cd9f6db2da', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:30:24', '140.213.216.83', 'LOGOUT'),
('0ee0d2f77aeb523faab205b09be7f7759da40d4d', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 10:50:49', '103.148.29.67', 'LOGOUT'),
('0fc4deb6791047d363253599b61c0ba4d4ffcb58', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-16 11:39:40', '103.148.29.67', 'LOGIN'),
('0fde922159c65b7823df6b516f9a26b5bbf30bd9', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-18 10:05:22', '103.148.29.67', 'LOGOUT'),
('10557571ca5a2dc72f3a1ce049d70373afd3b3f1', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-17 08:59:21', '103.148.29.67', 'LOGIN'),
('11f62abdcec6d640859e9034fa699849b510ad2e', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 16:12:22', '127.0.0.1', 'LOGIN'),
('13d3119b3cd6d2fabe0a7df9c73c5054fce05533', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 11:40:56', '103.148.29.67', 'LOGIN'),
('13d546bab6080721b721609b67db58d464487864', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-19 11:38:14', '103.148.29.67', 'LOGIN'),
('14d4859ab481361175cfc72d556f62ee2c6ecd75', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 13:08:53', '103.148.29.67', 'LOGIN'),
('1535634e4d6e90b0b25566615c82cb7fc865ca2d', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 10:11:31', '114.10.134.128', 'LOGIN'),
('1539353fa57b1ae9293273945c26938ef9102a43', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:16:46', '103.148.29.67', 'LOGOUT'),
('15c619b806166e75292d7fe19ec064a9eb96a2c0', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 13:11:35', '103.148.29.67', 'LOGIN'),
('15f4f09b13eeeef8b78c3ac3b91b89e972969f20', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-20 14:27:55', '182.2.235.8', 'LOGIN'),
('16f231bbcec29b9a54d5283c5cac1000051a2c06', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-10 19:03:10', '114.10.135.234', 'LOGIN'),
('19a55b78dc3577807b3178ddf198af437756d00b', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:50:20', '127.0.0.1', 'LOGIN'),
('19c6662d4fae484c314647b43cf89ba185b05c08', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:53:26', '140.213.216.83', 'LOGOUT'),
('19d93ff194837289ecc32db4409b40fb9fa82086', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:42:49', '140.213.216.83', 'LOGIN'),
('1a0fcdc3d9b9257c51eab017d03e50d2ed3c58d7', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-17 09:54:25', '180.247.45.130', 'LOGIN'),
('1a1efd132f7f39e6c25b50bd5f47402dbfe09136', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-16 09:32:49', '103.148.29.67', 'LOGIN'),
('1b0f4bfc293d9e7fc401085d08196d4d27302caa', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 19:53:33', '140.213.216.83', 'LOGIN'),
('1ca68fd1c76a4dc4008e063bf28ebf15dae00bbf', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 17:45:57', '114.10.135.1', 'LOGOUT'),
('1d2c57cb79a521e704d74d11c865652408217dd3', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 10:44:17', '103.148.29.67', 'LOGIN'),
('1df6c88d81883345e402c8bc0ff05fb527b0e6b5', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 13:46:26', '127.0.0.1', 'LOGIN'),
('1fcd558027d36924803881cc8a649d4dce71e1fe', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 18:40:46', '140.213.216.83', 'LOGIN'),
('20cf5d27415611119e166dacb03da798a7480c0e', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:28:06', '140.213.216.83', 'LOGIN'),
('21014976d070c00aaa40dd2b258f31802dfdc6ad', '400287b9dbd5310785484fc6e23f1ed312767494', 'Admin Surabe', '2025-06-23 14:59:05', '103.148.29.67', 'LOGOUT'),
('221613da206b304d244c2449a8f0b624143f910c', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-18 09:54:02', '103.148.29.67', 'LOGIN'),
('231d85d1840a2c52f9ee32ce7204cade1df00254', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:51:09', '103.148.29.67', 'LOGIN'),
('245061f5e9a351087ec3fb3bd17a2279e43fd886', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-19 11:29:28', '103.148.29.67', 'LOGIN'),
('25242b24a5ca9e229d9c0e6aef8c5486c3752fc9', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:13:38', '103.148.29.67', 'LOGIN'),
('2582caf450ab754402cbe45c9bc5e7202a096ba2', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-11 16:05:26', '114.10.135.1', 'LOGOUT'),
('273c71cf52bf92beb13ee976a11e08e1a39f8e43', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 13:12:45', '103.148.29.67', 'LOGIN'),
('2a7a1ca1db48ca4d588829b1914f7650d9bbc461', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 18:42:15', '140.213.216.83', 'LOGIN'),
('2a7cdf1cd812001ae1f0823a100d7cbbd57ad50a', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:44:12', '103.148.29.67', 'LOGIN'),
('2b1fef44a00dab18be1f4055b312160c691d1832', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 20:03:44', '140.213.216.83', 'LOGIN'),
('2bb85ebb8707afd306d1f3b2710a79f3d547ae33', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:08:06', '103.148.29.67', 'LOGOUT'),
('2bb9bfaf3e4afd7126099f2038c4738f9f02aa19', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 19:54:41', '140.213.216.83', 'LOGIN'),
('2bcb56d7d7f5e1f0303c8d739e8a2f58fa4d8681', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 10:45:29', '103.148.29.67', 'LOGIN'),
('2bdb92db7ea11fd80a0225464fc9e8f26ee89885', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 16:03:38', '103.148.29.67', 'LOGOUT'),
('2c095eef663d565de09e2ae6fbb97363532617df', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-10 23:21:39', '140.213.10.139', 'LOGIN'),
('2db313a1fc8f6c191b2c8733b0ae4ae39ecfc960', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:42:50', '103.148.29.67', 'LOGIN'),
('2e0055e30b9fa78a37da28232a0895361798221b', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-13 11:30:44', '103.148.29.67', 'LOGOUT'),
('2e1b973cfa7f78e34cdb9010d2a0e3f82f2b9958', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-10 23:24:02', '140.213.10.139', 'LOGOUT'),
('2eb53a5f0530745fe092f9e4775a23836b657247', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-16 11:39:59', '114.10.135.179', 'LOGOUT'),
('2f1d079d635270a0c79bf4765618bd1d7ec5c80e', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 11:40:47', '103.148.29.67', 'LOGOUT'),
('2f758d2fa8db3b5ac60cfe1d78ca95b16c6500e7', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 18:41:59', '140.213.216.83', 'LOGOUT'),
('31a181a7bdcff812304442a99a77b1ba014994fd', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-19 13:30:59', '103.148.29.67', 'LOGIN'),
('328fd71aeee292ff546d3029856dd42b775aa154', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 10:38:36', '103.148.29.67', 'LOGOUT'),
('32ecfab4e8faf5ec83b5d4be6273f8396505089b', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 11:00:14', '103.148.29.67', 'LOGOUT'),
('335d342d889b45899c1124d002b349ff58f8d161', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:50:52', '127.0.0.1', 'LOGOUT'),
('3365ee37ffb80cbe1b510cfa7fd694361989f200', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 15:36:36', '103.148.29.67', 'LOGIN'),
('3523a471545e851c6958372f0810460d49cf67a0', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-19 09:15:32', '103.148.29.67', 'LOGIN'),
('362d41c71f482b5c1d3f18d73c99881ad5d94559', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-19 13:26:07', '103.148.29.67', 'LOGIN'),
('3693789f5591a98a9ecd95595e4982826f82f985', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 12:29:58', '103.148.29.67', 'LOGIN'),
('370baf7a85f5c53a33a19772e35efed00103433f', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 13:21:21', '103.148.29.67', 'LOGOUT'),
('38bbe823213042abcdf815257173a69086d1af9c', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 13:35:50', '114.10.135.1', 'LOGIN'),
('3b90f4a8b905af4e655011453876b310c65525c6', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 13:16:49', '127.0.0.1', 'LOGIN'),
('3bad288e8c6226997e51927fc07289714cb31123', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-12 10:46:05', '103.148.29.67', 'LOGIN'),
('3bbb26dc6e780608296f036aeb3d7e689e221255', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 09:58:43', '103.148.29.67', 'LOGIN'),
('3d677e7e96402fdd082a3f7b7c2eeb3bf5f817c6', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 23:03:46', '140.213.10.139', 'LOGIN'),
('3e03ba89ea07e82b5f6da06e7c805bd9282b42dc', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 16:03:42', '103.148.29.67', 'LOGIN'),
('3e4eb360961e3c768466f0b9fdeda49aaa0c7a9b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-12 10:08:05', '103.148.29.67', 'LOGIN'),
('3e98ad522cfe2b45959ad1de3867502cb1404a3a', '12c2130d7b2d29e0930b2d3fccf97d978b0e821c', 'penilai kominfo', '2025-06-23 15:12:37', '103.148.29.67', 'LOGIN'),
('3f64bba606bbde0257572cccb9d8ffa2f990d648', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-18 14:33:57', '103.148.29.67', 'LOGIN'),
('40b7d3294149cbb85294828a716d0e70b6c0deff', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 08:57:45', '103.148.29.67', 'LOGOUT'),
('41f6b8e994a42e237f9d78f3ba59b726f1dec99b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:31:10', '140.213.216.83', 'LOGIN'),
('423e95388d22bb67c311be50292a675456f60924', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-16 10:40:47', '103.148.29.67', 'LOGIN'),
('430795e7579261f5680b8ea2d9eb0107fcd86f87', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 11:41:03', '103.148.29.67', 'LOGOUT'),
('43d84735846d9d8cbb2add9ee726e489c7df74d2', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-11 11:54:14', '103.148.29.67', 'LOGIN'),
('440557c4ee3d29d8a1f2b5df29dad08c9ef77d9f', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 22:04:27', '114.10.135.235', 'LOGIN'),
('45a95e9d78acbf1f2ebc9fe73a9dab4ca5247ba8', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 09:59:01', '103.148.29.67', 'LOGIN'),
('462c3079f48a54d8db9e0e582162ee9f069c71c0', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 19:27:20', '140.213.216.83', 'LOGIN'),
('488631d65b8ec0d380dd613d0c66e3da285c6cde', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 09:21:55', '103.148.29.67', 'LOGIN'),
('48db65ebe9e27f329c0984ad7e3ba486c0924ae7', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:20:06', '103.148.29.67', 'LOGIN'),
('4a0b802f2f3f383580d0e6547797f8c8de8f0376', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-18 09:19:56', '103.148.29.67', 'LOGIN'),
('4b541b0c27f91b6809de9b027a3c95f41c053fa0', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-24 09:36:18', '103.148.29.67', 'LOGIN'),
('4b927d1d8b7b26b1981f6be0fd5508717252f44b', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 20:05:33', '140.213.216.83', 'LOGIN'),
('4be3851eb194a15d3bb289a1afae59f48d8362ce', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:42:09', '140.213.216.83', 'LOGOUT'),
('4cd35c68fae27da64075b5e57ecc73eac1080f4a', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 23:21:31', '140.213.10.139', 'LOGOUT'),
('4e0246b53736057885ec1ad4bb1be2459265635b', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-13 15:02:36', '103.148.29.67', 'LOGIN'),
('4e1da801810047f3434c2b04f1c4f8f13b9c1bb9', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:43:56', '140.213.216.83', 'LOGOUT'),
('4fa995571ff69447a04e22f06064f68a9a278470', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 13:02:39', '103.148.29.67', 'LOGIN'),
('4fae449b1628284b358cec051f997aa2e0512ef2', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 10:48:50', '103.148.29.67', 'LOGIN'),
('50b4fe254d3d4e02578dfae4cdc353fc0901ee10', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 14:03:06', '127.0.0.1', 'LOGIN'),
('50e78be0806e865075eb96a79055f42b10c49969', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-16 13:00:17', '103.148.29.67', 'LOGIN'),
('51431ee9d475240da596f4fdcfccbcc1b9d04620', '660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', 'muhammad mufti abyan', '2025-06-19 08:44:16', '103.148.29.67', 'LOGIN'),
('52d36b4fb48737fa858fb02176acd261112da510', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 09:03:18', '103.148.29.67', 'LOGOUT'),
('5378cbc75bd5b40e4371c5084084d8499a04dfca', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 14:50:16', '127.0.0.1', 'LOGOUT'),
('5452a77a4396e44f28ffa3e42d8d2fa23c8c2d92', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:31:00', '103.148.29.67', 'LOGIN'),
('54694f293eef6e72e5b684bfeb00c7c8afeb381a', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 11:03:21', '103.148.29.67', 'LOGIN'),
('54fc804d9d9ce972826920c5ad5bea927d5b0437', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:52:47', '140.213.216.83', 'LOGIN'),
('557c0ce3674adb6497eaa65f8c7e069173127f5c', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 13:28:26', '127.0.0.1', 'LOGIN'),
('5621dbe00c9179f5c68535fbabbeba5ca723cd25', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 13:29:25', '103.148.29.67', 'LOGIN'),
('5633e12351d1ce335079c36dbae150b7be747427', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-19 10:15:13', '103.148.29.67', 'LOGIN'),
('5649b68415b4aedc4ca5ddb6b16978aa47325422', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-14 19:15:45', '182.2.235.31', 'LOGIN'),
('5671856b1f97066046371b7f5accff19b73c53c8', '400287b9dbd5310785484fc6e23f1ed312767494', 'Admin Surabe', '2025-06-23 14:58:16', '103.148.29.67', 'LOGIN'),
('5751daf567d2a5d36164c384fe725086e6932128', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:52:28', '103.148.29.67', 'LOGIN'),
('57b1a0df26fe178fecdd33779682ac768e14feeb', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 15:55:05', '103.148.29.67', 'LOGOUT'),
('582bdd1243a1541ce11749818bbb23ffd76225ed', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-20 10:14:45', '103.148.29.67', 'LOGOUT'),
('5836fd966003f189da53aa75a9f1b23574cd5bff', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-16 10:48:29', '103.148.29.67', 'LOGOUT'),
('58a89a66e7a6345d501c9e9925562f0e053863a1', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 16:07:41', '114.10.135.1', 'LOGOUT'),
('598f92e8f851853d296bbdc1d1d2fc51d4138ba6', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-13 09:06:44', '103.148.29.67', 'LOGIN'),
('5a0c7328a6786e7823b391d2fc45cf42f931e623', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 12:47:39', '103.148.29.67', 'LOGIN'),
('5a1cb6239d19ae357215356d64561d01268af149', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-25 11:45:48', '127.0.0.1', 'LOGIN'),
('5d36dbf3ea5bbdb139679bbaee650ab7d7d5f13d', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 09:38:23', '103.148.29.67', 'LOGOUT'),
('5f8477c8e17d5a9e4b85f520c232aa79c2c4e706', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 12:50:24', '103.148.29.67', 'LOGOUT'),
('60405191152bfae503151701908d6e6a29d98c37', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-20 10:18:11', '103.148.29.67', 'LOGOUT'),
('61542e69420b0dc3aae01ba95fc64296d2cb9183', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:54:55', '140.213.216.83', 'LOGIN'),
('6232df6a301558dd53ec7ec10b0e281117491360', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 15:32:10', '103.148.29.67', 'LOGIN'),
('62f829d96bacaf1a6c2c9f6e40ec1c3adeaf239e', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 09:39:51', '103.148.29.67', 'LOGIN'),
('63324912f3e0e65292062ea82b750670a4297d5a', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 23:34:24', '140.213.10.139', 'LOGOUT'),
('637dbf3a6788caae5ade62fdf42f249868f9c9b9', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 12:30:48', '103.148.29.67', 'LOGOUT'),
('653143425aa93f542f47863123cf3b26197e194c', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 14:42:11', '103.148.29.67', 'LOGOUT'),
('65e69308c02e5bd3d15b27b4af3d3492d8fd119e', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 12:50:58', '103.148.29.67', 'LOGOUT'),
('6734fe61a95a0666de9f9289c5fb80e4bed6ab34', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:54:15', '103.148.29.67', 'LOGIN'),
('68191d080420b173a276c150ac0bbefad070b532', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 10:47:12', '103.148.29.67', 'LOGOUT'),
('68e6f4961675f157cd77f6f5a5584dbef31fff73', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-11 09:05:26', '103.148.29.67', 'LOGIN'),
('69206040bdf10179af142ae3109b9d8b4f1f71a0', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-17 09:54:39', '127.0.0.1', 'LOGIN'),
('6a2757f460f0bb80b9d0ccd8f656c171c1bd10b6', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 12:59:45', '103.148.29.67', 'LOGOUT'),
('6f4cd019570ea358de91699c14c172c0df0132e1', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 15:15:15', '114.10.135.1', 'LOGIN'),
('6fd9f1218347fec68debafab5784de6eeabc2b9f', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:21:49', '103.148.29.67', 'LOGOUT'),
('703747a928a25f6714d7e9c1fac5b7302adb8d3b', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 12:34:52', '103.148.29.67', 'LOGIN'),
('7264395c6339b0fbd6f7f9e8f5fbfb5ee4632181', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 10:47:32', '103.148.29.67', 'LOGIN'),
('736cbfd01e3b4dfacdfe751923c291f3046e6912', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-14 23:01:14', '180.247.46.8', 'LOGIN'),
('73712dd7dc8ae73dc1cf1eae904f9cbee55d46e5', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-11 23:58:00', '103.176.252.18', 'LOGOUT'),
('74c801a083c5dbb1050751776911927e25a7ce9a', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 15:32:05', '103.148.29.67', 'LOGOUT'),
('753067cd324ed3f74c72718030e7358782b185ec', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-19 11:36:59', '103.148.29.67', 'LOGOUT'),
('782588f9f54b641f31c3e84f9b7d20b37b676485', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-11 14:25:42', '103.148.29.67', 'LOGIN'),
('7835cdd6e77824f681324b005fe178f7581bc6a4', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-23 10:59:19', '103.148.29.67', 'LOGIN'),
('7a3488e43f66db1a3d4143decdf398c32e3577f0', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 23:24:06', '140.213.10.139', 'LOGIN'),
('7bdce47ac1697c362754dd9d780d8c1f240b7ef9', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:46:00', '103.148.29.67', 'LOGOUT'),
('7ced5905b769ef1caa00a14a01af874454fb878f', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-13 11:37:18', '103.148.29.67', 'LOGOUT'),
('7d808922a8ce57c86dfa23dd2a1e0dca02d4ecf4', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:51:59', '103.148.29.67', 'LOGOUT'),
('7ed5fbf24fc7d199677f8aa77c9599c0fa0c322d', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-10 19:03:34', '114.10.135.234', 'LOGOUT'),
('7fb1432c491d439d2d2a130b9b00bfe98eb5dd91', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 12:57:34', '103.148.29.67', 'LOGIN'),
('8353da236997fb49414f227118e5945f4be07435', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 12:01:03', '103.148.29.67', 'LOGOUT'),
('83a7ac14ea60375879cb713ade79c8e7aca1a1d9', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-12 08:32:12', '103.148.29.67', 'LOGIN'),
('83ce1e6cf49dfeb146dc084b1d21507f15bb8ca2', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 18:40:41', '140.213.216.83', 'LOGOUT'),
('845b2afbc8ef447b3d25c40a8f53484f577ac60b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 22:05:57', '114.10.135.235', 'LOGOUT'),
('870951f41d1bdea0ef0334b542c098b35ea33487', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-13 09:31:36', '103.148.29.67', 'LOGIN'),
('88a63561ca2f179f0a3c810a9be7318bb23b22b9', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 09:31:35', '103.148.29.67', 'LOGIN'),
('88cf6ed2e3f80a510f70950b46c47c8ab782e889', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 15:33:32', '103.148.29.67', 'LOGOUT'),
('8ba322e06db69fbbb985c18eb9c23205c4bcf56c', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-20 14:28:26', '103.148.29.67', 'LOGIN'),
('8f7867b310dc0cd2fefc3384d10419b7a77580bf', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-13 11:32:30', '103.148.29.67', 'LOGIN'),
('8f998aec118f9db3a7aebea001c5c098601a749e', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 13:02:36', '103.148.29.67', 'LOGOUT'),
('901a344ceef919b0c8c38a5331747d4e27f82715', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 12:50:07', '103.148.29.67', 'LOGIN'),
('94e36766f910e45491f37e9f9fc75ee408c13194', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-23 10:57:21', '103.148.29.67', 'LOGOUT'),
('95b3f083dd3c6eec72dd965bc0558c904591e41d', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-20 10:15:04', '103.148.29.67', 'LOGIN'),
('96d88fec0d9580e523dc61c71ad588ae186cdcf8', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:47:00', '103.148.29.67', 'LOGOUT'),
('98e5c09f43d74f9dd59f30c5102bb2fcf0b1da6e', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 15:33:40', '103.148.29.67', 'LOGIN'),
('98ec269d5f857b56fdd306783341a5ed2f7e2559', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 14:10:16', '127.0.0.1', 'LOGIN'),
('9abaed8191d6f42c85cfc1ef860503eb4134edef', '660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', 'muhammad mufti abyan', '2025-06-20 09:13:41', '103.148.29.67', 'LOGOUT'),
('9aca897606cc9db70520a2ecebfe41cba79fcb7f', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 11:37:27', '103.148.29.67', 'LOGIN'),
('9bdad2ff6935b58bfceefb653ec11ca6907f9e47', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:27:07', '140.213.216.83', 'LOGOUT'),
('9eb5f71f4ad7ebc394215a7aa4c34ac26a5ef3f2', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 13:28:29', '103.148.29.67', 'LOGOUT'),
('9ebd44ccc55fb17ffef68ccce6452ec8ebe224b5', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:47:19', '103.148.29.67', 'LOGOUT'),
('9fdb39a88a36f10f695e2419690cf9cabe6bff35', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-20 08:55:11', '182.2.234.24', 'LOGIN'),
('a0a09715387fa6864bd6e49d1d66a93ac28a6f23', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:20:35', '103.148.29.67', 'LOGIN'),
('a2379ba10d04d8fc63b09c8dc3bc7bc846fe6adb', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-19 09:09:09', '103.148.29.67', 'LOGIN'),
('a35c839825780e0933e35e8b790b947fcb7f765b', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 18:50:57', '127.0.0.1', 'LOGIN'),
('a40ceaf128f2a186ff441f837c6b4d41d0845645', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 21:11:01', '140.213.10.139', 'LOGIN'),
('a65c1dca06e4267d8bc6517ccc9cccc869bc2205', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 15:30:21', '103.148.29.67', 'LOGOUT'),
('aa55095b2f089558fca7fa3a39defc8ac7b91f51', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 13:29:12', '103.148.29.67', 'LOGOUT'),
('ab47c193bf1749cfe16ddcb41d38310e9b7287f3', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 10:52:00', '103.148.29.67', 'LOGIN'),
('acbf18826bee603bb0eff4441a43a9484813bb4c', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 13:27:49', '127.0.0.1', 'LOGOUT'),
('acd56cd620556df676498690dca7a9363c52ebba', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-16 10:12:28', '103.148.29.67', 'LOGOUT'),
('ad0a273c15973afa71c5dd09e05eb4894b44c886', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:42:26', '103.148.29.67', 'LOGOUT'),
('aec0d85cefa74ea0c3b1ddb56c4e89c7eb25631b', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-16 09:17:18', '103.148.29.67', 'LOGIN'),
('b0381233e54adc875f614c077a2ec5b8c5653a61', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-18 09:05:48', '103.148.29.67', 'LOGIN'),
('b16a6696c27e5358b6e3920916a958c157c25e21', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:44:03', '103.148.29.67', 'LOGOUT'),
('b2cfac02404ef9602f1a663906351f55bedd4adf', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 15:23:57', '103.148.29.67', 'LOGIN'),
('b449f627b6133e244572707141b6bce3a6f5c8f5', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-13 15:02:12', '103.148.29.67', 'LOGIN'),
('b4f8886a42648a615d3ff26f51921e78171bc610', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 13:01:15', '103.148.29.67', 'LOGOUT'),
('b7c1678dd9bdedfe4f5465dc7f1780349ed530eb', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-10 23:34:30', '140.213.10.139', 'LOGIN'),
('b880c20c19008987c2e4358dd218cc5c8a0721f3', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-20 10:11:07', '103.148.29.67', 'LOGIN'),
('b8ad4b73e8d3c2cc06ba6d7a6a13f290bdcb3ab7', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-13 09:07:01', '103.148.29.67', 'LOGOUT'),
('b93e4e7440d040ac1f8a148f93cb9266b15de763', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-13 11:28:51', '103.148.29.67', 'LOGIN'),
('bc6f76c51c55e9c50be408283b2d0b517a01ef40', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 13:01:13', '103.148.29.67', 'LOGOUT'),
('be390277efa83afc7c6af09a3f5705d7d913ac8e', '660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', 'muhammad mufti abyan', '2025-06-20 08:59:03', '103.148.29.67', 'LOGIN'),
('be6b5ec25525f68cea0733975e115729151f2e5f', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:46:10', '103.148.29.67', 'LOGIN'),
('bea210e96aec91a1e1f3c813b14a6700cb5b970c', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:52:02', '103.148.29.67', 'LOGIN'),
('bf42bf07f8b19db33a22c0b0c8c0af933f6cef64', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 15:30:32', '103.148.29.67', 'LOGIN'),
('c1819b691997a53dba3277b71ee4ce68c26fb992', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-11 15:36:26', '114.10.135.1', 'LOGIN'),
('c693fe5814e2e2cbade97b7ee08cf95fda986d95', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 14:52:28', '127.0.0.1', 'LOGIN'),
('c7560872c8da3e31bd0851c5595f4e55c55d87d2', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 12:56:18', '103.148.29.67', 'LOGOUT'),
('c9e6e10ca2bfe5a7393b5b7e96f5204e10a24641', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 09:16:46', '103.148.29.67', 'LOGIN'),
('cad0dc86261ec2bee244a447cd4f7aee26a9c9d9', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-16 11:29:25', '114.10.135.179', 'LOGIN'),
('cbc1fcb2857e819ce4237584d8b885848acaf8be', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 11:06:49', '103.148.29.67', 'LOGOUT'),
('cbc9e982d1b2a59e0b26c5d9a3e3dd528418b64f', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-11 15:27:27', '103.148.29.67', 'LOGOUT'),
('cc021c39b0f3df240ee973aa6d2df51da004f45b', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:03:21', '103.148.29.67', 'LOGOUT'),
('cc9ce62247ebfbfde4bc375bb4d47492b6f6800a', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 18:40:09', '140.213.216.83', 'LOGIN'),
('ce821b9e4d6bd4f97eeeacdb482a0ae07ea2ef00', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-13 09:19:37', '103.148.29.67', 'LOGIN'),
('cf17c9a83a0fbc0da5506dd6ff1a5a9ffbcf3aa4', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:07:18', '103.148.29.67', 'LOGIN'),
('cf5731c714a1b9282b65a9a9e80644bc968588c8', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 08:06:40', '103.148.29.67', 'LOGIN'),
('d06102d616cb21cc3e3557baed20f78563940289', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 08:59:21', '103.148.29.67', 'LOGIN'),
('d07e09ff8a97c0b0ff9fa2ac371f97aa9be29ad2', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 11:10:47', '103.148.29.67', 'LOGIN'),
('d20eb397c8cc4fc8193eb39c7c7a1b7b0f636691', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 09:19:02', '103.148.29.67', 'LOGIN'),
('d4065d8ccd1ccfe952fb6257ea8d53992a6b8fe6', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 19:55:56', '140.213.216.83', 'LOGOUT'),
('d6354e62d16674156958f0e904219620995ba011', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-13 09:20:12', '103.148.29.67', 'LOGOUT'),
('d64fab32ec38f04e05cdf538453de36842b1e2a4', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-19 10:23:41', '103.148.29.67', 'LOGOUT'),
('d6f69f6060a6bf492a6575691ea99150de892b9a', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:54:34', '103.148.29.67', 'LOGOUT'),
('d7d272efea2846a26f1f8dcc1fce5375bebbac36', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 11:07:19', '103.148.29.67', 'LOGOUT'),
('d83a2a1c732a0ea6e5ca097f3adb5a55e386ef78', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 09:58:40', '103.148.29.67', 'LOGOUT'),
('d8b039c1d20ac634cc22f96add25c8938f6ab1ea', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 13:01:30', '103.148.29.67', 'LOGIN'),
('d91e86ab0306ccda0dc403dd5801610cc128f1ba', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-16 10:34:43', '103.148.29.67', 'LOGIN'),
('da0648de9e51323cd053012c5054540af1d5fc68', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 15:16:14', '114.10.135.1', 'LOGOUT'),
('da08bba58a1289c0acc894d971120a5416c6e8a7', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-11 19:34:36', '114.10.135.239', 'LOGIN'),
('daa7d6c70a63b752d2f5f4f0181508f2ee831952', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 10:45:20', '103.148.29.67', 'LOGOUT'),
('dad3bcbb0a55f296fcd15e80a29e0eb5d1ed7212', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:43:59', '140.213.216.83', 'LOGIN'),
('dbfba3a2c4147074be4399ca8af2509347de5f7a', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-11 18:42:46', '140.213.216.83', 'LOGOUT'),
('df1d48760c77e756378f77f4f3b71454e83d7869', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-19 13:40:26', '103.148.29.67', 'LOGOUT'),
('e0917f1afd5c567df114d6f8a0aa57d937d32f85', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 15:06:09', '103.148.29.67', 'LOGOUT'),
('e0e27b1cf82bf4dd3f1d92a0dc4b1c97331feda3', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-23 12:47:00', '103.148.29.67', 'LOGOUT'),
('e16ccb2700299210a27c04bdab015bce576b2d19', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 18:42:02', '140.213.216.83', 'LOGIN'),
('e181f8b51ebc270a794907247ccee0cf1d20724a', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 09:19:20', '103.148.29.67', 'LOGIN'),
('e1ba99b8f2f21e59bc51d6cb81ad1405eb0794e7', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:04:59', '103.148.29.67', 'LOGIN'),
('e1efdd5a5b5c5c27816984f0b68e8f63d64a3149', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 09:31:28', '103.148.29.67', 'LOGOUT'),
('e3a02e8bb5be478693b52160fcd3330039a097cf', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 16:05:34', '114.10.135.1', 'LOGIN'),
('e3a9b5a8689dfcc04c987996d3c6aa6d50c862b9', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 13:53:36', '114.10.135.1', 'LOGOUT'),
('e44c4cf923a841d83503c3d58426b9bfe9acd274', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 19:30:31', '140.213.216.83', 'LOGIN'),
('e47dc2c277bd1b5b970f15dbe34dbc7b2725f258', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:03:24', '103.148.29.67', 'LOGIN'),
('e52cb08e9989f88dd3fe12173b5f1a5bced17385', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 13:28:34', '103.148.29.67', 'LOGIN'),
('e563a26de7ded6e1051375225a40b567e0479e2a', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 13:04:17', '103.148.29.67', 'LOGIN'),
('e570f93c8714c49f2c8a74f0c9eb59c7f16f03ce', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 08:22:04', '103.148.29.67', 'LOGIN'),
('e5ed10f3caaf54cbfee74b82931003983ed093a5', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-23 14:51:40', '103.148.29.67', 'LOGIN'),
('e6639a6ef92cead6d25954cef26cb461da70075c', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 13:09:27', '103.148.29.67', 'LOGOUT'),
('e6ada249f50ce9062796b66c0fba7c819d1cfe0d', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 09:38:27', '103.148.29.67', 'LOGIN'),
('e7a564b8f4570f1fa225d5b8415b55ead9fcaef3', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 09:06:24', '103.148.29.67', 'LOGOUT'),
('e7ef32eec94b0ef34fbabeb3f5a3e0ff8cac7cba', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-10 20:16:27', '114.10.135.140', 'LOGIN'),
('e9eecbacb28dd906147ab87c66e07560c124e3de', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 19:54:19', '140.213.216.83', 'LOGOUT'),
('ebb53a6e39a9c8acf151d4c07206cfb1102b0291', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-10 19:52:07', '140.213.10.139', 'LOGIN'),
('ec8b56da4cd24edfa06bd8e56cf4cdfd04e4b481', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-11 20:04:53', '114.10.135.239', 'LOGIN'),
('eef43ae4545a7f1de6a13fc1c1d9c2f33e81dc82', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:47:17', '103.148.29.67', 'LOGIN'),
('ef057d7edde817cad2162a82f4f3c45072b46b0a', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-16 10:46:49', '103.148.29.67', 'LOGIN'),
('ef1d23141dc1677a0e9e66161b1bcf60f488ae8d', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-19 13:40:29', '103.148.29.67', 'LOGIN'),
('ef41dd1b3918e764f771098506bb962138fa17c5', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-13 09:08:23', '103.148.29.67', 'LOGIN'),
('ef8c59de98cab2401ab90791482f9bf13ca62a15', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 19:28:03', '140.213.216.83', 'LOGOUT'),
('f0574c6f16cdf775f17e7f759517f718241e772d', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-11 09:45:10', '103.148.29.67', 'LOGIN'),
('f08d81d1b7c63897fbfe47928e04e8c6f15a4eb5', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-13 12:53:45', '103.148.29.67', 'LOGIN'),
('f1436dc7c9d24908844e1da5494b02a2d47121d6', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-23 10:52:36', '103.148.29.67', 'LOGIN'),
('f15567cdb9544279592288719a57377617a39102', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-06-23 12:55:01', '103.148.29.67', 'LOGIN'),
('f17b0586573bde673806341f4523d9ec1a825e14', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 17:44:55', '114.10.135.1', 'LOGIN'),
('f52c872dea7c39c6e5dac6934e3074b0c4a15600', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-16 10:12:29', '103.148.29.67', 'LOGOUT'),
('f5ddbe681ebae60d8ae891f8453e4d3ccd726322', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 11:03:00', '103.148.29.67', 'LOGOUT'),
('f975a0bdf489185c45ea7a58b35201c74515534e', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-12 08:47:37', '103.148.29.67', 'LOGIN'),
('f9b6c77a011435c11adbf3805970d6b606a7f2c4', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-11 19:41:06', '114.10.135.239', 'LOGOUT'),
('f9c7001860d69c0deac8c7875ebc5cee31a94bb3', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-12 11:16:39', '103.148.29.67', 'LOGIN'),
('fa073907e3673c6e7f4e1d8d442f71163cfe8689', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 10:11:39', '114.10.134.128', 'LOGOUT'),
('fa10e9fd142c2562a2aae7ad14b618d6b0f01efb', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-11 19:54:52', '140.213.216.83', 'LOGOUT'),
('fbee7221c34d963438b0e02564660bba73856cc2', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 11:06:53', '103.148.29.67', 'LOGIN'),
('fc43b9a5b95bb178c287ffc3030a22df21c7a0c1', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-13 10:51:09', '103.148.29.67', 'LOGIN'),
('fd2c6fd116768e3bfb36d442f1340f82176d28c4', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-06-19 13:30:55', '103.148.29.67', 'LOGOUT'),
('fd8fb31f9e8331b52153a0638762d0645a87678f', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-20 09:16:07', '103.148.29.67', 'LOGIN'),
('fdbddc01d49ee78703b2f89f7f20f3b2cba0f4c7', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-23 12:21:27', '103.148.29.67', 'LOGIN'),
('fdd22d028b3829c582d7870270d719e47d263931', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-11 14:10:05', '127.0.0.1', 'LOGOUT'),
('ff83abc1fe5375b23407ce730dccc7723b5f2241', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-18 09:09:32', '103.148.29.67', 'LOGIN'),
('ffa3f1cb2c7f7d2f869b7880c6871e94b99839ab', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-10 20:24:08', '114.10.135.140', 'LOGOUT');

-- --------------------------------------------------------

--
-- Table structure for table `lke_nilai_jawaban_user`
--

CREATE TABLE `lke_nilai_jawaban_user` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdJawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PenilaiId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Nilai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Aproved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Ket` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `AproveBy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lke_opd`
--

CREATE TABLE `lke_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_opd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `singkatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_opd`
--

INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES
('00f7cb1efba969ab849609d70409b58e9c93ec77', 'Biro Administrasi Pengadaan Barang dan Jasa Setda Provinsi Sulawesi Tengah', 'Biro PBJ Sulteng', '2025-02-12 12:04:15', '2025-02-12 12:04:15'),
('056dd8b1762b5e8195fb91c3525d05b79bf6e3a2', 'Rumah Sakit Umum Daerah MADANI', 'RSUD Madani', '2025-02-12 12:04:55', '2025-02-12 12:04:55'),
('11fb4836238f14f9133810ea97bc2224660d532c', 'Biro Hukum Setda Provinsi Sulawesi Tengah', 'Biro Hukum Sulteng', '2025-02-12 12:03:25', '2025-02-12 12:03:25'),
('18d74facbd4ea6d62d6ea88c50a179eb6e38d0b9', 'Dinas Kependudukan dan Pencatatan Sipil Daerah Provinsi Sulawesi Tengah', 'Dukcapil Sulteng', '2025-02-12 11:59:55', '2025-02-12 11:59:55'),
('1d97af161eae1b2bb6b3371c058f1896c97c00c3', 'Dinas Tenaga Kerja dan Transmigrasi Daerah Provinsi Sulawesi Tengah', 'Disnakertrans Sulteng', '2025-02-12 12:00:35', '2025-02-12 12:00:35'),
('229df29c4750bc7b56a66e41552c8cf29441a56b', 'Satuan Polisi Pamong Praja Daerah Provinsi Sulawesi Tengah', 'Satpol PP Sulteng', '2025-02-12 12:03:15', '2025-02-12 12:03:15'),
('269a81eec6f4ab48b6e2ae6a1965b03f4dbbd770', 'Biro Administrasi Pemerintahan dan Otonomi Daerah Setda Provinsi Sulawesi Tengah', 'Biro Pem Otda Sulteng', '2025-02-12 12:03:35', '2025-02-12 12:03:35'),
('2d3607cf04d37e2a1a453fee95449aafa4205d1e', 'Badan Kesatuan Bangsa dan Politik Daerah Provinsi Sulawesi Tengah', 'Bakesbangpol Sulteng', '2025-02-12 11:58:45', '2025-02-12 11:58:45'),
('3538043ccb8ea3a4d00a2f20009d97e841f6a8ff', 'Biro Administrasi Pembangunan Setda Provinsi Sulawesi Tengah', 'Biro Pembangunan Sulteng', '2025-02-12 12:03:55', '2025-02-12 12:03:55'),
('357b7a3a95c974142eb4f8b2ad4460d2db0b79e3', 'Dinas Perhubungan Daerah Provinsi Sulawesi Tengah', 'Dishub Sulteng', '2025-02-12 12:02:05', '2025-02-12 12:02:05'),
('3872c1e77e3457745db8ca3e11b6ab8ea1190fcb', 'Dinas Perpustakaan dan Arsip Daerah Provinsi Sulawesi Tengah', 'Dispusarda Sulteng', '2025-02-12 12:02:55', '2025-02-12 12:02:55'),
('3905a80e31e615e287f3e4ce0af3c5bf20f8ad57', 'Dinas Kebudayaan Provinsi Sulawesi Tengah', 'Disbud Sulteng', '2025-02-12 12:02:45', '2025-02-12 12:02:45'),
('49f31573998d313cf8eb752591cb7645d8afbdcc', 'Dinas Perindustrian dan Perdagangan Daerah Provinsi Sulawesi Tengah', 'Disperindag Sulteng', '2025-02-12 12:02:15', '2025-02-12 12:02:15'),
('4af2f901606ac6e6cb969d37e8c891de965ebc73', 'Badan Pengembangan Sumber Daya Manusia Daerah Provinsi Sulawesi Tengah', 'BPSDM Sulteng', '2025-02-12 11:58:15', '2025-02-12 11:58:15'),
('4cc85b5e0f704694c0ec7902b6dc8175f16de3da', 'Inspektorat Daerah Provinsi Sulawesi Tengah', 'Inspektorat Sulteng', '2025-02-12 11:57:25', '2025-02-12 11:57:25'),
('54aec085ce82ada2303b17c408efd781ffdbdaa2', 'Dinas Pariwisata Daerah Provinsi Sulawesi Tengah', 'Dispar Sulteng', '2025-02-12 12:00:55', '2025-02-12 12:00:55'),
('5949fd7a71646b8c3be3e85490e249bbfea24167', 'Energi dan Sumber Daya Mineral Daerah Provinsi Sulawesi Tengah', 'DESDM Sulteng', '2025-02-12 11:59:25', '2025-02-12 11:59:25'),
('5965169ae79f622b85a29c3f7b70ba93e718f0d4', 'Badan Pengelola Keuangan dan Aset Daerah Provinsi Sulawesi Tengah', 'BPKAD Sulteng', '2025-02-12 11:58:05', '2025-02-12 11:58:05'),
('619577ef9777f6503fdd23b17d0794c21f81cd35', 'Badan Kepegawaian Daerah Provinsi Sulawesi Tengah', 'BKD Sulteng', '2025-02-12 11:57:55', '2025-02-12 11:57:55'),
('640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', 'DINAS KOMINIKASI, INFORMATIKA, PERSANDIAN DAN STATISTIK', 'DISKOMINFO', '2025-03-13 11:01:03', NULL),
('6686a23dc70f803c723f3e2119ecc7979a244061', 'Biro Administrasi Perekonomian Setda Provinsi Sulawesi Tengah', 'Biro Ekonomi Sulteng', '2025-02-12 12:03:45', '2025-02-12 12:03:45'),
('68b7605db3caef1f9adccf40a35e08cbe7a3f4ec', 'Dinas Perkebunan dan Peternakan Daerah Provinsi Sulawesi Tengah', 'Disbunak Sulteng', '2025-02-12 12:01:45', '2025-02-12 12:01:45'),
('6a674853b7c5e54cd19140c17cca792811418c1b', 'Rumah Sakit Umum Daerah UNDATA', 'RSUD Undata', '2025-02-12 12:05:05', '2025-02-12 12:05:05'),
('6fd95b74eeb739d4f89dff22d4619553aac9f86d', 'Dinas Sosial Daerah Provinsi Sulawesi Tengah', 'Dinsos Sulteng', '2025-02-12 12:02:35', '2025-02-12 12:02:35'),
('738eac1965252fce8879b4e8330249f3a7805144', 'Badan Riset dan Inovasi Daerah Provinsi Sulawesi Tengah', 'Brida Sulteng', '2025-02-12 11:58:25', '2025-02-12 11:58:25'),
('7f8158b7de091c350242946af9aaebb59bf4951a', 'Dinas Kehutanan Daerah Provinsi Sulawesi Tengah', 'Dishut Sulteng', '2025-02-12 11:59:35', '2025-02-12 11:59:35'),
('81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', 'Biro Organisasi Setda Provinsi Sulawesi Tengah', 'Biro Organisasi Sulteng', '2025-02-12 12:04:25', '2025-02-12 12:04:25'),
('81d34ff19cb808237949c4eb97b7fbfbc71e882a', 'Dinas Pemberdayaan Perempuan dan Perlindungan Anak Daerah Provinsi Sulawesi Tengah', 'DP3A Sulteng', '2025-02-12 11:58:55', '2025-02-12 11:58:55'),
('88f63ff1fcc928275fb82ca2ed4bdfab3c2938e8', 'Dinas Perumahan, Kawasan Permukiman dan Pertanahan Daerah Provinsi Sulawesi Tengah', 'Disperkimtan Sulteng', '2025-02-12 12:02:25', '2025-02-12 12:02:25'),
('9308e1c48ff13eea5974ead68ded9381a2e0a86e', 'Dinas Lingkungan Hidup Daerah Provinsi Sulawesi Tengah', 'DLH Sulteng', '2025-02-12 12:00:25', '2025-02-12 12:00:25'),
('959ca482f3987260a47151bc0e65b218b2a2a053', 'Dinas Pangan Daerah Provinsi Sulawesi Tengah', 'Dinas Pangan Sulteng', '2025-02-12 12:00:45', '2025-02-12 12:00:45'),
('9839d63518cdd1c60d91ea7d1a867458ea85d355', 'Biro Umum Setda Provinsi Sulawesi Tengah', 'Biro Umum Sulteng', '2025-02-12 12:04:35', '2025-02-12 12:04:35'),
('9aa9bf4246b23d88a32b2a3d78b653313302458b', 'Dinas Koperasi dan UMKM Daerah Provinsi Sulawesi Tengah', 'Dinkop UMKM Sulteng', '2025-02-12 12:00:15', '2025-02-12 12:00:15'),
('9d96ed0051325bde885fe36bdbdda79ad5e2658e', 'Dinas Cipta Karya dan Sumber Daya Air Daerah Provinsi Sulawesi Tengah', 'Cikasda Sulteng', '2025-02-12 11:59:15', '2025-02-12 11:59:15'),
('a0273bdaccf0ae9621dfbc422aa50f72f60ecb06', 'Dinas Pengendalian Penduduk dan KB Daerah Provinsi Sulawesi Tengah', 'DP2KB Sulteng', '2025-02-12 12:01:55', '2025-02-12 12:01:55'),
('adb7c8b773ef4c90822fae0ea17824b6235d1105', 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu Daerah Provinsi Sulawesi Tengah', 'DPMPTSP Sulteng', '2025-02-12 12:01:05', '2025-02-12 12:01:05'),
('b35abd913c34eb630af419ca52eecb9dbdbf9a95', 'Dinas Kelautan dan Perikanan Daerah Provinsi Sulawesi Tengah', 'DKP Sulteng', '2025-02-12 11:59:45', '2025-02-12 11:59:45'),
('b8761775d1f704dde563c40b0d0e1736a031fc29', 'Dinas Bina Marga dan Penataan Ruang Daerah Provinsi Sulawesi Tengah', 'Bimataru Sulteng', '2025-02-12 11:59:05', '2025-02-12 11:59:05'),
('ba273eab7dc54d995b5ee2ca958b5c447f277d84', 'Sekretariat DPRD Provinsi Sulawesi Tengah', 'Setwan DPRD Sulteng', '2025-02-12 11:57:15', '2025-02-12 11:57:15'),
('c307f7a5e8b996c1fa660bd6f2ed2899d06ea5e8', 'Badan Penanggulangan Bencana Daerah Provinsi Sulawesi Tengah', 'BPBD Sulteng', '2025-02-12 11:58:35', '2025-02-12 11:58:35'),
('c7cab4aba2daf5d075e679cbb1964c51591a04d0', 'Badan Perencanaan Pembangunan Daerah Provinsi Sulawesi Tengah', 'Bappeda Sulteng', '2025-02-12 11:57:35', '2025-02-12 11:57:35'),
('d01a5d5271416cb1eb6c0e03f19e2ac8ef72c6f1', 'Biro Administrasi Kesejahteraan Sosial dan Kemasyarakatan Setda Provinsi Sulawesi Tengah', 'Biro Kesra Sulteng', '2025-02-12 12:04:05', '2025-02-12 12:04:05'),
('d3e50dbec5a2ec941598bc77b3744c659692ce46', 'Dinas Pemuda dan Olahraga Daerah Provinsi Sulawesi Tengah', 'Dispora Sulteng', '2025-02-12 12:01:25', '2025-02-12 12:01:25'),
('d9193f6ac2dc1839d234588a751ff0d87d74cf26', 'Dinas Tanaman Pangan dan Hortikultura Daerah Provinsi Sulawesi Tengah', 'DTPH Sulteng', '2025-02-12 12:03:05', '2025-02-12 12:03:05'),
('daeaf6821f866a8957ba4a517cb53b88693e811b', 'Dinas Pemberdayaan Masyarakat dan Desa Daerah Provinsi Sulawesi Tengah', 'DPMD Sulteng', '2025-02-12 12:01:15', '2025-02-12 12:01:15'),
('e355d70deaa0490695b1b6f872e9f74f066488fa', 'Dinas Pendidikan Daerah Provinsi Sulawesi Tengah', 'Disdik Sulteng', '2025-02-12 12:01:35', '2025-02-12 12:01:35'),
('e6691bb69d9339b0326efc581701063712faf48d', 'Badan Pendapatan Daerah Provinsi Sulawesi Tengah', 'Bapenda Sulteng', '2025-02-12 11:57:45', '2025-02-12 11:57:45'),
('f4908ba9cd41d1c207d2702fc46c467edb27aa3e', 'Dinas Kesehatan Daerah Provinsi Sulawesi Tengah', 'Dinkes Sulteng', '2025-02-12 12:00:05', '2025-02-12 12:00:05'),
('f7f2e7addb9b4d046d15dc74675f2e984416df0d', 'Biro Administrasi Pimpinan Setda Provinsi Sulawesi Tengah', 'Biro Adpim Sulteng', '2025-02-12 12:04:45', '2025-02-12 12:04:45');

-- --------------------------------------------------------

--
-- Table structure for table `lke_parameter`
--

CREATE TABLE `lke_parameter` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nilai` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_parameter`
--

INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`, `nums`, `nilai`) VALUES
('021bee5a29538fa225942e82bab58ea97a4bc5b6', 'Belum melaksanakan SKM', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:52:53', NULL, 'F', '0'),
('0297ac51411cf9cd0276500532d0830cb12973c8', 'Tersedia sistem antrian dengan 1 fasilitas', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:35:35', NULL, 'E', '20'),
('02bd66c13677e9f4bd8496748f3e44bb1de37fce', 'Ada pemberian penghargaan berdasarkan 1-2 unsur termasuk kinerja ', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:38:47', NULL, 'C', '60'),
('02ed9565c4f617954612d8ce880b6a682e8a9e23', 'Tersedia sarana FO informasi layanan dengan 2 fasilitas    ', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:28:50', NULL, 'D', '40'),
('044c8f7db53056822571f42f746095d69fa5b94f', 'Tidak adPelaksana pelayanan menerapkan 5 (lima) unsur budaya pelayanana pemberian penghargaan', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:41:15', NULL, 'A', '100'),
('066cf0dd2853ab8e202208b82ccbe98883280fb1', 'Terdapat dokumentasi yang diarsipkan  ', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:55:43', NULL, 'E', '20'),
('086c42b6e5a17362e94199219e21daab9516e69f', 'Tidak tersedia sarana FO informasi layanan', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:29:27', NULL, 'F', '0'),
('08d65c11a8d84366027e7aae6d6950acf81ab73a', 'Sistem informasi belum berfungsi/belum dapat digunakan/belum dapat diakses (sistem masih dalam bentuk konsep pengembangan atau prototype)', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:43:44', NULL, 'F', '40'),
('0d0e2b0dd177c2f5864c080fd5ff6bd43eafcdb3', 'Sudah ada inovasi lebih dari 1 tahun dan sudah diikutsertakan dalam kompetisi level apapun ', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:30:07', NULL, 'B', '80'),
('0d81d4106b15c2f4a4594cfa6bb9a67b74386edf', 'Tersedia 4-6 sarana prasarana bagi pengguna layanan kelompok rentan  ', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:23:20', NULL, 'D', '40'),
('0dabc170ca1412f518c8e8c0e26d8b3a478c97e3', 'Sudah ada inovasi namun kurang dari 1 tahun', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:30:55', NULL, 'D', '40'),
('0e82cb9939bbaaf693d406c007a2d42da8ca0907', 'Tersedia tempat parkir dan memiliki 1 atau lebih fasilitas parkir ', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:10:21', NULL, 'E', '20'),
('0eb319a7ec5805e14e9efb45046307e4e4ab82dc', 'Dilakukan peninjauan ulang 1 tahun sekali atau lebih cepat terhadap sebagian jenis layanan', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:25:29', NULL, 'B', '80'),
('0fa6fe0d6409b881d432a30ccebcf42dca22e178', 'Telah menggunakan SiAP Sulteng', '479b03a54d5860c3494d9986e39767088a6ba472', '2025-06-13 11:12:29', NULL, '1', '100'),
('107c1a36052bc33aea0cee499812371f6975f42f', 'Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku  ', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:52:10', NULL, 'D', '40'),
('113b1808d4119d61a41c2254d1184ac1146cc943', 'Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 11:45:13', NULL, 'C', '80'),
('11ae5e955fcfd2c3306299eedfaabd22a775699b', 'Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 3 kondisi lainnya', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:32:12', NULL, 'A', '100'),
('11e28e3125b3ad1c708e2ca44fa42571c4129fdd', 'Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 2 kondisi lainnya ', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:32:31', NULL, 'B', '80'),
('1436bbcda7918cebfe6bfeffd9b88bfedb03aa34', 'Tersedia 1 jenis mekanisme peningkatan motivasi kerja      ', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:36:51', NULL, 'E', '20'),
('1497af56d37541b63deed853682f1ec97a2abd1d', 'Tersedia 2 jenis mekanisme peningkatan motivasi kerja     ', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:36:31', NULL, 'D', '40'),
('150d57003800569c71f19bc9b7feb63a839b514e', 'Pemutakhiran data dan informasi pelayanan publik telah dilakukan secara tahunan', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:42:41', NULL, 'E', '20'),
('154508554aee72df5ea54f5642ffaeea752dba4c', 'Tersedia sistem informasi pendukung operasional pelayanan dengan 3 kondisi', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:37:07', NULL, 'C', '60'),
('163795905a431e1ce4cd6a47e3617797b662e6d5', 'Telah menggunakan JDIH', '05e92a67e5198493e3c0845daa851f48bad80241', '2025-06-13 11:23:25', NULL, '1', '100'),
('166be80a491a693d89dc1287cb543d58a7da757f', ' Rekomendasi hasil SKM ditindaklanjuti seluruhnya 1 bulan setelah laporan SKM diterbitkan ', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:01:34', NULL, 'A', '100'),
('18388897542823b5066e3b8f741e3d3c82090678', 'Sistem informasi pelayanan publik telah online/website dan terhubung dengan sistem informasi pelayanan publik nasional serta telah menginput layanan yang ditetapkan ke dalam sistem informasi pelayanan publik nasional', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:33:44', NULL, 'A', '100'),
('18d3f97d1c4e3ad4b32a1d0fc774cf0c7d36affb', 'Tidak ada konsultasi atau pengaduan yang ditindaklanjuti', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:58:19', NULL, 'F', '0'),
('18ec8e7892d0059580cc0e4bc8c4c90f366d9975', 'Terdapat media konsultasi dan pengaduan secara offline terpisah dari front office, dan terhubung dengan SP4N-LAPOR! ', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:49:47', NULL, 'A', '100'),
('1a3fbda61250850f8740c530314fe38efae7bc99', 'Tersedia Sistem informasi pelayanan publik elektronik namun belum online (e-kiosk/ display TV/ layar monitor)', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:34:30', NULL, 'C', '60'),
('1b9bc9d26e6109d2be510eed789cccd2d02c7848', 'Sudah melaksanakan SKM namun tidak sesuai dengan PermenPANRB yang berlaku ', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:52:32', NULL, 'E', '20'),
('1c301cb219f89984ad7ccf832903294047ad0177', 'Tersedia fasilitas wajib  ', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:18:41', NULL, 'E', '20'),
('1ea740d22f04cd0f2bca8d73071e3202cb2579c6', 'Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', '1ff16ba78f665f700312c31ca80da58389e7a81b', '2025-06-10 22:32:09', '2025-06-11 09:25:58', '3', '35'),
('1f518ad44c0b372524bd7b3a4f624fbd38b00df3', 'Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2025-06-10 22:28:43', '2025-06-11 09:24:22', '3', '35'),
('2003c8c82e9944c7f87c9edc7464e43142e002aa', '1. Nilai 90 s.d. 100 dengan kategori AA (Sangat Memuaskan) 2. Nilai lebih dari 80 s.d 90 dengan kategori A (Memuaskan) 3. Nilai lebih dari 70 s.d 80 dengan kategori BB (Sangat Baik) 4. Nilai lebih dari 60 s.d 70 dengan kategori B (Baik) 5. Nilai lebih dari 50 s.d 60 dengan kategori CC (Cukup) 6. Nilai lebih dari 30 s.d 50 dengan kategori C (Kurang) 7. Nilai 0 s.d 30 dengan kategori D (Sangat Kurang)', '936328e1dfe004e577c7e26d41681bd365fc6f09', '2025-06-13 11:11:06', NULL, '-', '0-100'),
('210679d475f2c4aa10b4501e98fd005e463a2ea4', 'Tersedia sistem informasi pendukung operasional pelayanan dengan 4 kondisiondisi', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:36:46', NULL, 'B', '80'),
('226898fa18d0d3fbeea3162b2d57e47386ec8d61', 'Memiliki kebijakan jam pelayanan/kerja dan 2 unsur lainnya ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:27:28', NULL, 'C', '60'),
('22910b9a7e5573486fffa14c0840bc4220575ecc', 'Sudah ada inovasi lebih dari 1 tahun namun belum diikutsertakan dalam kompetisi (level apapun) ', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:30:31', NULL, 'C', '60'),
('2329acf2563022e15b8db4d77a9a22528b735536', 'Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', 'abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2025-06-10 22:23:44', '2025-06-10 23:29:00', '1', '100'),
('2333ccd0ca0b8549b6b431fffc6d681e3d31b8e1', 'SIPP Elektronik berbasis website/aplikasi mudah dioperasikan, mudah diakses  ', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:39:51', NULL, 'D', '40'),
('24197aebacbeb4d28de9855ec22cd567f857eecc', 'Diisi dengan Persentasi realisasi APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Berjalan Rumus = Realisasi APBD Tahun Berjalan / Total APBD x 100%', 'b0458145e51457abbcecfa494984e96c16d041a6', '2025-06-19 09:30:13', NULL, 'a)', '100'),
('2437db6b6dcc267a48d5c71c084a0da772f2b718', 'Telah memiliki layanan berbasis elektronik sesuai dengan core bisnis Perangkat Daerah', '4cc7c0d2808515a7deb6b967a47d749eddf4ca61', '2025-06-13 11:23:42', NULL, '1', '100'),
('24cff762b94e1e271741ad48ba828e76cd272db4', 'Terdapat Surat Permohonan pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '45cf18e926282fc9b3211f0428052fbb760c2583', '2025-06-11 23:10:36', '2025-06-11 23:12:09', '-', '100'),
('2638bf3b7d8ca327c97e1935c6aa77002162f44d', 'Tersedia fasilitas wajib dan 2 fasilitas pelengkap', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:18:00', NULL, 'C', '60'),
('2726eecb79bbc2c22f726ea64a7ee117bf3a3ed7', 'Diisi dengan Persentase tindak lanjut hasil SKM tahun sebelumnya', '4c8378c214c94d9085e88f953e0199ba8feae24c', '2025-06-18 10:02:47', '2025-06-18 10:10:25', '1', '100'),
('27ea6dbfbfae366e93d25012f26c4cdc0fe163ca', 'Toilet pengguna layanan dengan 3 kondisi', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-19 10:20:36', NULL, 'C', '60'),
('2970d7815c1331540fb478d20528062402ecf8eb', 'Dilakukan peninjauan ulang 1 Tahun sekali atau lebih cepat terhadap seluruh jenis layanan', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:24:53', '2025-06-18 11:45:46', 'A', '100'),
('29afe73f8eb3cf21a709274ac999268480b38c70', 'kurang dari 21% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:52:24', NULL, 'F', '10'),
('2bcb1e30f350b7f221bb52a36366d8643f5e9bfd', 'Tersedia Sistem informasi pelayanan publik berbasis online/website ', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:34:09', NULL, 'B', '80'),
('2bcbc47e43f76ffe698c4c0f3808728c6d9d20f5', 'Terdapat media konsultasi dan pengaduan secara offline menyatu satu dengan front office dan tersedia secara online ', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:50:26', NULL, 'C', '60'),
('2cbfa71f9a3605d6f220c4bcec50515394943810', 'Persentase data prioritas yang terupdate sesuai waktu A = 100% terupdate B = 75% terupdate C = 50% terupdate D = 25% terupdate E = belum terupdate (0%)', 'fb3fb9de5de3842714c3b79c47bf40fe774778f9', '2025-06-13 11:29:24', NULL, '1', '0,100'),
('2cf3126e7a9984118ad6dbf4b1cb4b25ce3b2092', 'Tindak lanjut hasil SKM dilaksanakan kurang dari 30%, dibuktikan dengan laporan pelaksanaannya', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 14:59:29', NULL, 'D', '40'),
('2d0929198d853afe6f6cb667e0e6c11f372ebcef', 'Tersedia 2 fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:26:17', NULL, 'D', '40'),
('2e352444ff244b2abf6424a27fd38edd36776cf3', '- ', '23f08c7833dcc8775fc86ac0682e7d2472af3267', '2025-06-13 10:42:10', NULL, '-', '100'),
('30973137b24129adea9aac12f47ff5fe0129fc7f', 'Tersedia sarana FO informasi layanan dengan 5 atau lebih fasilitas', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:27:45', NULL, 'A', '100'),
('3214ff5ffc37220a4ce15916b588e0e9548eefdb', 'Nilai Hasil Evaluasi Perencanaan Kinerja ', '26dabc885d6a369ceab60d138385533a50a22958', '2025-06-19 08:51:32', NULL, '1', '30'),
('32174dd04a9bbaf1b6128777c2955b645be2aa99', 'Diisi dengan nilai hasil survei ASN BerAKHLAK', 'b3050198a0311b2fd1e1521bda8cecd00f63d4e4', '2025-06-18 09:32:46', '2025-06-20 09:47:27', 'A', '100'),
('326b85b364d74f3c6d1552cefa6cea683b3a5216', 'Tersedia publikasi SP hanya sebagian dari komponen service delivery baik pada media cetak/non elektronik maupun media elektronik ', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:20:08', NULL, 'E', '20'),
('3318ef3b8e72588b8428061c2ba622525319a63d', 'Tersedia tempat parkir dan memiliki 3 atau lebih fasilitas parkir', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:09:36', NULL, 'C', '60'),
('35e04de618077f8007414d517e9bbcd889a0a3f6', 'Telah mengunakan Sistem Pengadaan Secara Elektronik (SPSE)', 'ec38526ca158862acf6403a395e855c723391f5d', '2025-06-13 11:12:05', NULL, '1', '100'),
('360f4f343a70b720514d741874782719c17f3404', '91-100% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:42:04', NULL, 'A', '100'),
('361394dc3aa22f3bc5d51b2da0123bd7be06a18f', '21-40% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:52:07', NULL, 'E', '20'),
('36723a9cae651dec2f433ecfa162c90e518a501d', 'Dilakukan peninjauan ulang 2 tahun sekali terhadap seluruh jenis layanan ', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:26:19', NULL, 'C', '60'),
('36e10523cfc09378d444353e40f4326967b124e1', 'Diisi dengan Persentasi realisasi total APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Sebelumnya Rumus = Realisasi Akhir APBD Tahun Sebelumnya / Total APBD x 100%', 'bf29c2c0ebb5bf5f234eb273a94f4bfc198e2f3f', '2025-06-19 09:26:42', NULL, 'a)', '100'),
('372f9cfc187c4722a4f519c885cba8c001df9a33', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-10 22:18:14', '2025-06-11 14:55:19', '1', '100'),
('378318d03f746088ddf0430bf2fe49f1717590b5', 'Pelaksana pelayanan menerapkan 1 (satu)  unsur budaya pelayanan   ', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:43:13', NULL, 'E', '20'),
('38271c6c5b9be45957a3c1cd66865b2bda36edf1', 'Tersedia 3 jenis mekanisme peningkatan motivasi kerja', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:36:12', NULL, 'C', '60'),
('3904392f80ae3fe782bd5a2983d94f523c95642c', 'Sarana konsultasi pengaduan pengguna layanan dengan 3 fasilitas', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:47:35', NULL, 'C', '60'),
('3a8ac0b881be96d22f0737948169290c2c1f0924', 'Tersedia fasilitas wajib dan 3 fasilitas pelengkap ', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:17:04', NULL, 'B', '80'),
('3b12f2cf78837477c9319eae9436246b5cd9faa7', 'Rekomendasi hasil SKM ditindaklanjuti seluruhnya 9 bulan setelah laporan SKM diterbitkan   ', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:02:48', NULL, 'D', '40'),
('3b86197e392441a312660b815901a268dd10b89a', '50% - 90% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai ', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:57:00', NULL, 'B', '80'),
('3bb47201fa8180f4946ea17e6f4e1e27483bfa1e', ' Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 11:46:02', NULL, 'E', '40'),
('3c5a5bd67af627cd5d028dea2062649477333c42', 'Tidak tersedia inovasi', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:31:35', NULL, 'F', '0'),
('40fd29837c418d2db8f4098def5ed38aee01e63a', 'Perangkat Daerah konsultasi dengan Diskominfo dalam proses Pembangunan/ Pengembangan Aplikasi ', '1ff16ba78f665f700312c31ca80da58389e7a81b', '2025-06-10 22:32:41', '2025-06-11 09:28:03', '4', '0'),
('410790bac08834b499eaeea264de975c717cc5da', 'Telah menggunakan Sistem Pengawasan Internal Pemerintah (SPIP)', 'b5c441f52388bcbb8ee5b4b1ac6dae1ff1da918e', '2025-06-13 11:18:55', NULL, '1', '100'),
('4164f6a52da12430631694af79c5eeda872a58e6', 'Seluruh IKU Perangkat Daerah tercapai (100%)', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-19 09:11:05', NULL, 'A', '100'),
('434df8bdbb33d1c214608fe49fccae1d80993714', 'Tersedia 3 fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:25:56', NULL, 'C', '60'),
('441987149985b1670a5f3377f49bf38e2a05aa6d', 'Laporan Pelaksanaan Penggunaan Produk Dalam Negeri pada Pengadaan Barang/Jasa Pemerintah melalui aplikasi SIPD P3DN dan Aplikasi Bigbox LKPP', 'e235d1e25296c5f4a241e55993abcb72b24ee4b9', '2025-06-16 11:41:36', '2025-06-16 11:42:17', '1', ''),
('4625ba059877d4368e6741271a8ea1d3d6bac558', 'Tersedia sarana FO informasi layanan dengan 3 fasilitas', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:28:31', NULL, 'C', '60'),
('4639e053f37031f962d5b7b8f0aee0d69157ea8c', 'Rekomendasi hasil SKM ditindaklanjuti seluruhnya 6 bulan setelah laporan SKM diterbitkan ', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:02:28', NULL, 'C', '60'),
('47e83e06afce72b0eb6810170ccb4ead598fa993', 'Persentase Paket Pekerjaan yang diumumkan RUPnya melalai SiRUP', '5d87606c5eee137d90d291e708f3220790f6cbf5', '2025-06-16 09:45:34', NULL, '1', '100'),
('482c52fbb01e76df2a2f0d10c5fbe02e141ee473', 'Rekomendasi hasil SKM ditindaklanjuti seluruhnya 3 bulan setelah laporan SKM diterbitkan  ', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:02:00', NULL, 'B', '80'),
('4a504a76d6b11f7742e2bb74e0e54592300f2de0', 'Tersedia SP yang memenuhi 14 komponen', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:58:04', NULL, 'D', '40'),
('4acc2da1ea60bd4862169ff18b91351190aff0d2', 'Tersedia 4 jenis mekanisme peningkatan motivasi kerja', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:35:50', NULL, 'B', '80'),
('4afe608a3f7aca039447db7400bf6a5882b9e218', 'Tersedia lebih dari 4 jenis mekanisme peningkatan motivasi kerja ', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:35:12', NULL, 'A', '100'),
('4b4e11e192a0aa2136aa34ac497a9dd5df153c10', 'Tersedia sarana FO informasi layanan dengan 4 fasilitas', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:28:04', NULL, 'B', '80'),
('4c8696c7e35d52a697705c9e4e8ef39aa0b3bcb6', 'Terdapat SK Pembentukan Panitia Antar Perangkat Daerah', '18bcf56fc86cf0bacb9716b241247e385b294376', '2025-06-11 23:17:26', '2025-06-11 23:18:28', '-', '100'),
('4d4a77444f32857e81aa424316f16d44c1dc7cb2', 'Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik ', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:51:43', NULL, 'C', '60'),
('4dc44d9c43105df71509ec489eea5e98de634619', 'Tersedia publikasi SP seluruh komponen service delivery pada 2 atau lebih media publikasi namun belum dipublikasikan pada SIPP Nasiona', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:19:29', NULL, 'D', '40'),
('4eba78d6f858fcc75cfcad934e46de9022365f2a', '< 50% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai ', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:57:21', NULL, 'C', '60'),
('4f681c9c0283a6b85f46350283f0725784305426', 'Tidak tersedia toilet pengguna layanan', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-19 10:21:33', NULL, 'F', '0'),
('4f916ba6cd2a64b3127e795bd7edac66bfb8545d', 'Terdapat dokumen peta rencana (roadmap) SPBE ', '060245c55fa1cdda77c0639b1978131ba5cab3dc', '2025-06-10 22:22:07', NULL, '1', '100'),
('4f92b6d4339005adefc90985bc90d53c8c2e4f5b', 'SIPP Elektronik tidak terhubung secara daring', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:40:31', NULL, 'F', '0'),
('5044916743f60be000375d9a77bcdd047fd812bf', 'Tidak dilaksanakan peninjauan ulang secara berkala terhadap Standar Pelayanan', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:47:24', NULL, 'F', '0'),
('52b8d20c2889e85461443f5965b8807bfde6e68b', 'Laporan Capaian Indikator Kinerja Sekretaris Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah/Raport Kinerja Perangkat Daerah pada Lingkup Sekretariat Perangkat Daerah', '356adee25a1526c8f6deafff1ec564ad5a407623', '2025-06-16 09:57:10', NULL, '1', '100'),
('5352e644af1c4b2ce8daa257d623f18ed7d3adc4', 'Sistem Informasi berbasis elektronik telah memberikan manfaat dan direspon positif oleh pengguna layanan', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:43:00', NULL, 'D', '70'),
('53578d73c62de9f9f7110f2817bc83e5aecb5562', 'Penetapan Indikator Kinerja Penyelenggaraan Urusan yang menjadi core Bisnis Perangkat Daerah pada Cascading Kinerja', '4581da6e1cc226decb6a880b7d4b68e1b553a520', '2025-06-16 09:59:59', '2025-06-16 10:02:50', '1', ''),
('5555534791dfc43d174162e9d694ca767b643d62', '61-80% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:42:54', NULL, 'C', '60'),
('5858b699d7431a8a9a7d7a4747b72658f0099b86', 'Rata-rata nilai dimensi disiplin ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 5 poin', 'f56c31c955255c249de67a93de07093489b5f250', '2025-06-16 09:51:55', NULL, '1', '5'),
('58b4db2f7fefd8bacf30dd6b641cca04e83a1f9a', 'Terdapat media konsultasi dan pengaduan secara offline secara terpisah dari front office, serta tersedia secara online ', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:50:08', NULL, 'B', '80'),
('58d60de045c9904b2e960a16dcfd4481c0ce9720', 'Tersedia tempat parkir dan memiliki 4 atau lebih fasilitas parkir', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:09:00', NULL, 'B', '80'),
('5921c44880d4e6d713728ed2e1e4003b3c11186a', 'Tindak lanjut hasil SKM dilaksanakan lebih dari 80%, dibuktikan dengan laporan pelaksanaannya ', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 14:58:39', NULL, 'B', '80'),
('592fd525eced42146ebd2f3189fa5865838a2b22', 'Persentase keterisian data prioritas Rumus: (Jumlah data prioritas yang tersedia di Satu Data dibagi Potensi data prioritas) * 100%', 'fb090dae0186365c93dd6a97bee9fc96fe7ac3fb', '2025-06-13 11:29:04', NULL, '1', '0,100'),
('599b8bd6779bdd475de6d1889ea8685d96b2a069', 'Inovasi yang dilaksanakan sudah mendapatkan prestasi pada level (apapun)', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:29:44', NULL, 'A', '100'),
('5c011b6edd96ccc7b7697f3af13dcb2fbe6d8308', 'Sarana konsultasi pengaduan pengguna layanan dengan 5 atau lebih fasilitas ', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:46:54', NULL, 'A', '100'),
('5c9166069dba58f4c7c8dad22d284e00eb7ee4e6', 'dibawah 21% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:43:53', NULL, 'F', '10'),
('5dd07e5a671d8faae5658b8e4ea3773c95d38a21', 'Tersedia 4 fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:25:36', NULL, 'B', '80'),
('5e90db5da0a606d2f048d782ba1162c571c4f9b8', 'Persentase Pencatatan Paket e- Purchasing pada Katalog Elektronik', '4b3401518bf31cce72ee049f1d8f63a440b13e0c', '2025-06-16 09:46:24', NULL, '1', '100'),
('5ea843184c9d48b9bf94dd5d2117eda61143abbf', 'Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-19 09:12:31', NULL, 'D', '25'),
('6164d0a8a82ffb955c6e346bf254aeb4c344bbc1', 'Tersedia 13 atau lebih sarana prasarana bagi pengguna layanan kelompok rentan ', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:22:11', NULL, 'A', '100'),
('6325ca45e65d7dd32876816c20a166c3ada2d3b0', 'Sebagian IKU Perangkat Daerah tercapai (= 50%)', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-19 09:12:01', NULL, 'C', '50'),
('63770f26b052a0063397633368ad808095414dec', 'Tersedia sistem informasi pendukung operasional pelayanan dengan 2 kondisi ', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:37:26', NULL, 'D', '40'),
('65298d30e4cb00a166bfc94cacd33e80415ca9ee', 'Persentase Pencatatan paket Non e-Tendering dan Non e-Purchasing pada SPSE', 'a92b34d679d1c6f6e5aecc60bf20e8819b4c33b1', '2025-06-16 09:46:41', NULL, '1', '100'),
('6685526dde4e42453e0e85577a273608995ac332', 'Diisi dengan Nilai Hasil Survey Kepuasan Masyarakat terhadap layanan Perangkat Daerah', '7f93d7c672515bec3b590bf3d39c1a77dd376f15', '2025-06-18 09:47:52', '2025-06-18 10:09:55', '1', '100'),
('68a49c693fcbf478be0599a379e85e4b4eeed968', 'Tidak ada sarana dan petugas', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:51:43', NULL, 'F', '0'),
('69db28e463ab15f15bec473db1250ed9c85a2e5f', 'Jumlah Pengaduan diatas 5 sampai dengan 10 aduan', 'dc396ec8de0dba70307b0bf352b614202622f75e', '2025-06-13 10:43:22', NULL, 'C', '50'),
('6c021c82a5c39ef69322747d6dd0526dd628393c', 'Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', '4936f4074cfdb199ef8064f699a81f1c53662e6f', '2025-06-10 23:01:36', NULL, '1', '100'),
('6c32dfeaf80effca7e2fad74c55fe3b8f1f90046', 'Tidak tersedia mekanisme peningkatan motivasi kerja', 'cc426e33d29c9393353bc051ba24720a1709a2af', '2025-06-19 09:37:09', NULL, 'F', '0'),
('6c439bcb6b19c719f24a7cdf6fab5bd7d3b7778b', 'Belum ada sumber daya yang mendukung keberlanjutan inovasi', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:33:46', NULL, 'F', '0'),
('6cdda3bced914c38e43deb577fa0bd94125cf115', 'Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '2b557a8de90f11956d143d38ebb34f4f3e1517b7', '2025-06-16 09:46:58', NULL, '1', '100'),
('6ce1b9d52f3df492dc66909d68bd20b9bd88c1b1', 'Memiliki kebijakan jam pelayanan/kerja dan 3 unsur lainnya  unsur lainnya ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:26:43', NULL, 'B', '80'),
('6dcacd74bde69bbb35169e4eb0713da85130400e', 'Hanya terdapat media konsultasi dan pengaduan secara offline menyatu dengan front office  ', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:51:24', NULL, 'E', '20'),
('6e5dd92d041025b91e3167d08b8c5498ac856099', 'SKM dipublikasikan pada 2 (dua) media publikasi    ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:56:04', NULL, 'D', '40'),
('6f0c355b9d97889f3ff74b91870b44bea46203e3', 'Evaluasi Produk Hukum dilakukan 2 (dua) kali dalam satu tahun anggaran', '9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-13 09:47:31', NULL, 'B', '75'),
('6f0c9b1db125e50c56bbad77b8c8aa353c67328b', 'Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '3ced595e127adccf449ddf78bbbda0b1e1a2cc9d', '2025-06-10 23:02:00', NULL, '1', '100'),
('6f6e1a5a3b1e4ee604564c06c8033441232f553b', 'Jumlah Pengaduan diatas 10 sampai dengan 20 aduan', 'dc396ec8de0dba70307b0bf352b614202622f75e', '2025-06-13 10:43:08', NULL, 'B', '75'),
('6fe939dcf574cbb427637a473727c2a7f56a3ac6', 'Tindak lanjut hasil SKM dilaksanakan 30-80%, dibuktikan dengan laporan pelaksanaannya Tindak lanjut hasil SKM dilaksanakan kurang dari 30%, dibuktikan dengan laporan pelaksanaannya', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 14:59:05', NULL, 'C', '60'),
('706de38108d2451bca734308217db05fce2f1a32', 'Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai)', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 11:44:52', NULL, 'B', '90'),
('70a902e1f54d09d2657d803ded3ade27d5718bc1', 'Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak kewajiban dan 1 (satu) unsur lainnya   ', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:32:31', NULL, 'D', '40'),
('7225da92cc77cee98c58de22d84c504af859181f', 'Penyusunan SP telah melibatkan minimal 4 unsur masyarakat     ', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:04:15', NULL, 'B', '80'),
('723d5e07d71c528f16a9890fac13443be0b9c2dd', '41-60% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:43:13', NULL, 'D', '40'),
('72859c8603b1feb3787be38c293f77f8bdb9054f', 'Data dan Informasi Capaian Kinerja RB Tematik yang disampaikan akan disandingkan dengan data dan informasi dari eksternal seperti; data BPS, data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah B. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh masyarakat secara luas (seluruh/sebagian besar target sasaran tercapai) C. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian masyarakat yang menjadi sasaran target program/kegiatan D. Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan E. Capaian kinerja Program/Kegiatan belum berdampak dan dirasakan manfaatnya oleh masyarakat', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 09:17:33', NULL, '1', '100'),
('734226a2685818e68a48c0208e861fb942675403', 'Tidak ada publikasi SP', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:20:40', NULL, 'F', '0'),
('73c042cb1554db1099aa454f933ac4739a4a927d', 'Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik dan elektronik ', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:51:14', NULL, 'B', '80'),
('7442c1bd2e3bb3860561815788388e9ea05680ed', 'Telah memperoleh predikat menuju WBBM', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:13:58', NULL, 'A', '100'),
('749abfa26133e309879648fcb3faaee3f0f2ebfb', 'Toilet pengguna layanan dengan lebih dari 4 kondisi ', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-19 10:19:44', NULL, 'A', '100'),
('7563231cab2298abc6e6881b18008d8c1c9e51b2', 'Tersedia sistem informasi pendukung operasional pelayanan dengan lebih dari 4 kondisi', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:36:28', NULL, 'A', '100'),
('7587f4883a4a0d694750c6a8c09c4580f827f7b6', 'Hanya terdapat media konsultasi dan pengaduan secara offline namun terpisah dengan front office    ', '773967cf70fb968c9e52d268d06c1e6abdc530e6', '2025-06-19 10:50:54', NULL, 'D', '40'),
('75cc3688bfbe4b1370cc9482642b9a59f7e97b0a', 'Terdapat Dokumen Manajemen Risiko SPBE', '2017b67bb7ec425721f4f39badb0cc1766dd6359', '2025-06-10 23:01:13', NULL, '1', '100'),
('765833723c8ded3a0574b4a6081b4ef25d732665', 'Tidak ada pemberian penghargaan', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:40:01', NULL, 'F', '0'),
('768fd778ce613b84935de693ecc79c6fe6b0b73a', 'Data dan Informasi Implementasi Transformasi digital administrasi pemerintahan yang disampaikan akan disandingkan dengan data dan informasi seperti; Reviu/tanggapan publik (google reviu terkait kualitas layanan), data publikasi pada media massa, dan sebagainnya serta dari hasil reviu dan pendalaman yang dilakukan oleh Tenaga Ahli Independen/Tim Penilai Independen dengan parameter sebagai berikut: A. Menyampaikan/melaksanakan Continouous Improvment penerapan Sistem Informasi berbasis elektronik yang telah terintegrasi dalam satu sistem (single sign on) B. Sistem Informasi berbasis elektronik telah mengintegrasikan seluruh/sebagaian layanan dalam satu sistem (single sign on) C. Sistem Informasi berbasis elektronik telah berkontribusi terhadap tercapainya kinerja Pemerintah Daerah dan/atau Perangkat Daerah D. Sistem Informasi berbasis elektronik telah memberikan manfaat dan direspon positif oleh pengguna layanan E. Sistem Informasi Berbasis Elektronik telah Berfungsi dengan Baik/dapat dioperasikan/dapat diakses oleh pengguna layanan F. Sistem informasi belum berfungsi/belum dapat digunakan/belum dapat diakses (sistem masih dalam bentuk konsep pengembangan atau prototype)', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-16 10:20:34', NULL, '1', '100'),
('76b19c61e640e7adf5f3401876a8ec8563c96e7c', ' Tersedia sistem antrian dengan 3 fasilitas', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:34:58', NULL, 'C', '60'),
('78043a9d4cb32ff6c368705fd2ebc4c562087d8f', 'Tersedia publikasi SP seluruh komponen service delivery pada 3 media publikasi dan pada SIPP Nasional ', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:17:36', NULL, 'B', '80'),
('7912705ea1b9addcb12d3d8a90335eb5f9efaacc', 'Telah menggunakan aplikasi terkait aset (BMD)', 'f2633c69c8df08f548c62656ab0a76483ba25942', '2025-06-13 11:18:37', NULL, '1', '100'),
('791500b370c7f2f10023c04dc74f70cec6f81d46', 'Pemutakhiran data dan informasi pelayanan publik secara bulanan ', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:41:38', NULL, 'C', '60'),
('797aa471ca48a5ac84acfe8587c8d2de5a3d559f', 'Memiliki kebijakan jam pelayanan/kerja dan 1 unsur lainnya   ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:27:52', NULL, 'D', '40'),
('7b2d2fcfed9f9f9dfc20e735c540ac24a4f6a3d8', '50% konsultasi atau pengaduan ditindaklanjuti hingga selesai yang tidak menggunakan SP4N-LAPOR!  ', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:57:41', NULL, 'D', '40'),
('7d2dc96d32ab666c83632993954174fd9ae65c47', 'Tidak tersedia fasilitas apapun', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:19:02', NULL, 'F', '0'),
('7dda172892ee9194ca6e720e7eecee3ccbb66c13', 'Ada pemberian penghargaan berdasarkan 3-4 unsur termasuk kinerja ', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:38:17', NULL, 'B', '80'),
('7df7bd139375230543f13415e9db5838127e0a2c', 'Ada rencana tindak lanjut tapi belum dilaksanakan ', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 14:59:50', NULL, 'E', '20'),
('7e72378453db872783e97cb2e37bc1442a36d51b', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-10 22:19:35', '2025-06-10 23:27:25', '3', '35'),
('7ea89dcd7845e9d2b5f34ad2584a4e102c667d2e', 'Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 2 (dua) unsur lainnya ', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:32:05', NULL, 'C', '60'),
('7eb913d9f1ae1104d309ac9153df7f61c8e5df0c', 'Ada pemberian penghargaan berdasarkan 5-6 unsur termasuk kinerja ', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:37:58', NULL, 'A', '100'),
('7f72e8b1299464fd18e5f4fc7e10715bc166d16e', 'Dilakukan peninjauan ulang 2 tahun sekali terhadap sebagian jenis layanan  ', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:26:53', NULL, 'D', '40'),
('7f8105801edf53843d4f39569de2918cf6b30da0', 'Memiliki kebijakan jam pelayanan/kerja dan 4 atau lebih unsur lainnya ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:26:10', NULL, 'A', '100'),
('803cc7a7adb080b1d7af50419d98efc1f9b8cf1f', 'Tersedia SP yang memenuhi 14 komponen, melibatkan masyarakat dalam penyusunan SP, dilakukan penetapan, dan dilakukan monev ', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:47:19', NULL, 'A', '100'),
('805b3b25ecee6faf435efe74b82f2da469695b80', 'Terdapat Naskah Akademik/penjelasan dan/atau keterangan mengenai urgensi dan pokok pikiran Rancangan Peraturan Daerah/Peraturan Kepala Daerah', 'bdc31064087319d26c08507f5f3dbaaaa8d5205c', '2025-06-11 23:17:05', NULL, '-', '100'),
('815b09b326fbe0d42b68f03e5ff7cd6ac49650f6', 'Tersedia Maklumat Pelayanan namun belum ditetapkan     ', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:45:41', NULL, 'E', '20'),
('819156f0ffd3d4f83a0171528da02234e5a4730d', 'Capaian Kinerja Program/Kegiatan telah berdampak terhadap capaian kinerja pemerintah daerah', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 11:44:25', NULL, 'A', '100'),
('831f0cf469edf2ee69a195091a5c3b82e33e8102', 'Telah memiliki standar data statistik yang lengkap untuk semua Indikator Kinerja Utama (IKU) yang diampu dinas Rumus: (Jumlah IKU yang memiliki standar data dibagi jumlah total IKU) * 100%', 'd823766c948a1c8dc2c4fd700e48889192782492', '2025-06-13 11:28:32', NULL, '1', '0,100'),
('83322e04bede5840e33d6069e5e8fc9111c7af3a', 'Telah menggunakan e-SAKIP/Saliara', '208565ef7e96a72f09425ef5a7cb30bbe24a3243', '2025-06-13 11:19:12', NULL, '1', '100'),
('8425720d4d4ae359a9cddc09e173425bed921b4d', 'Tersedia sistem informasi pelayanan publik non elektronik melalui media lisan (pusat informasi) serta media papan pengumuman dan media cetak ', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:34:49', NULL, 'D', '40'),
('849e9d915514371fceee381b79659189f1fcf3bb', 'Tidak tersedia Sarana konsultasi pengaduan pengguna layanan', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:48:41', NULL, 'F', '0'),
('84e06b32ce749ce93e63213aafc96588ed75e529', 'Telah menggunakan aplikasi Open Data', '7ced43deb489a53e67d08903c1d91d85b86de1f3', '2025-06-13 11:23:13', NULL, '1', '100'),
('84ec0cc65544570778821fdfe2fecb480a02b7d7', 'Penyusunan SP telah melibatkan lebih dari 4 unsur masyarakat ', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:03:35', NULL, 'A', '100'),
('85af2e500a7b0506cfdb16b8ce582ccf6fa31c98', 'Tidak tersedia sistem informasi pelayanan publik baik elektronik maupun non elektronik', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:35:41', NULL, 'F', '0'),
('85c649b33f3a4288071da3dbb9c2fa22af0623ee', 'Terdapat Dokumen/Laporan Manajemen Aset TIK', 'ed4052a793493ad6e117034f1a47e15e4ec4308a', '2025-06-10 23:02:46', NULL, '1', '100'),
('865dfb5d43c3789eaaeb7de0531dda1cd1cf5fe4', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-10 22:20:09', '2025-06-10 23:27:39', '4', '0'),
('86a0011c09c284e670430ef014fd2d204406f2af', 'Rata-rata nilai dimensi kompetensi ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 40 poin', '26fa43a7b899b315dd5f4677400867f2103d9a87', '2025-06-16 09:51:12', NULL, '1', '40'),
('86e9d6fe5b0731fc4309a4a530ca299fa2d4e546', 'Tersedia Maklumat Pelayanan yang sudah ditetapkan, isinya telah sesuai dengan peraturan perundangan yang berlaku, dan dipublikasikan pada media non elektronik dan elektronik ', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:42:51', NULL, 'A', '100'),
('8741c55e26f86507803175fa6fd27a0efee1d7b7', 'Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2025-06-10 22:28:18', '2025-06-11 09:24:07', '2', '65'),
('879db80350223fb89d689e8577b632e6a8070e23', 'Telah memperoleh predikat menuju WBK', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:16:13', NULL, 'B', '80'),
('87df462c81706eaec1e0c77f686fadcdcfbd8850', '- ', 'a9069b289f2e0f78afa7d4ac8c6a98975e03e886', '2025-06-13 10:41:19', '2025-06-13 10:59:18', '-', '100'),
('895d623cdb6e4f58a2b53e3bd421d9dc0a010326', 'Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi penganggaran', 'd19c3e6ed374d12a978546f90608c9d155d319bd', '2025-06-13 10:54:43', NULL, '1', '100'),
('8ba6493e78c81eb77265c6d6bba8c9653e89bec8', 'Tidak tersedia aturan kode etik dan kode perilaku', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:33:22', NULL, 'F', '0'),
('8e9d5dfa7ae805377aecb7fe3f3b1068b5eb07c5', 'Persentase Pencatatan Paket e-Tendering pada SPSE sesuai pagu RUP e- Tendering', '5c8040f3ac32bd6e074d0897d3d130d41ac839d2', '2025-06-16 09:46:04', NULL, '1', '100'),
('8fcc9850bfb2782936ec08d8f2b443dc7bb16441', 'Tidak memiliki kebijakan jam pelayanan/kerja ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:28:36', NULL, 'F', '0'),
('8ff373978a8c9f7e11eba85038e7d5765c4ce0ce', '91-100% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:51:06', NULL, 'A', '100'),
('910083bead48fcfac63c0d6fc2df174ba6f7d743', 'Persentase Hasil Tindaklanjut Rekomendasi (TLHP) BPK RI', 'bdfdfe3ff3f049f04205f465b68af41adab5f10d', '2025-06-19 09:18:19', NULL, '1', '100'),
('91fa2325a438b007a3598eb8b4469635e0bd1a1d', 'Pemutakhiran data dan informasi pelayanan publik dilakukan secara harian dan detail/sangat lengkap ', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:40:58', NULL, 'A', '100'),
('92dd654093331f9031d26677a4eefa98bf286342', 'Tersedia Maklumat Pelayanan yang sudah ditetapkan namun isinya belum sesuai dengan peraturan perundangan yang berlaku     ', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:45:14', NULL, 'D', '40'),
('9329dd8727799d2656ecbf2fb4c0d867161f42f1', 'Telah dilaksanakan evaluasi oleh TPI', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:18:11', NULL, 'D', '40'),
('9425ddb2b12a7ef095a72262598bc509910ba58d', 'Telah menggunakan SRIKANDI', '397a7dbe2fd7b34ab6ebed2a09fee9c3ded5d8d5', '2025-06-13 11:13:00', NULL, '1', '100'),
('962c813f244837f3b5e104d8525149a6aa4df8a9', 'Tersedia sistem antrian dengan 4 fasilitas', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:34:39', NULL, 'B', '80'),
('9642af341f7dc480adedaeb9ef537a80c30ad978', 'Tersedia fasilitas wajib dan 4 atau lebih fasilitas pelengkap', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:16:41', NULL, 'A', '100'),
('9767bafd3dba94f87be858bfae51c062b51336b8', 'Tersedia 7-9 sarana prasarana bagi pengguna layanan kelompok rentan ', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:22:58', NULL, 'C', '60'),
('97b79af7ad5862d4b58969d30f79561051542f1f', 'Terdapat Rancangan Peraturan Daerah/Peraturan Kepala Daerah', '28a5d1b98409915a3b0e821647d8477e8687b4d7', '2025-06-11 23:17:53', NULL, '-', '100'),
('98db70250764d441b3fbb16fb3e40c649baf89b8', 'Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', 'c6ddd5c9cfb225fc4881f98607ebc677a34fd715', '2025-06-10 23:00:22', NULL, '1', '100'),
('9b97694300bba960735cf17577e840b26021b131', 'Penyusunan SP telah melibatkan minimal 1 unsur masyarakat     ', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:06:13', NULL, 'E', '20'),
('9d60f5f31ff27f9f0f602269188ffbda5626f74d', 'Tidak ada dokumentasi', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:55:59', NULL, 'F', '0'),
('9e7887afe76fb704f922cb5027d7a79305c5ccc2', 'Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', '6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2025-06-10 22:27:48', '2025-06-11 09:23:49', '1', '100'),
('9eb922a8c9fea140b30792e3bf379e57ffa218e0', '81-90% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:42:27', NULL, 'B', '80'),
('a27b29590c5d9ecffda299cc03af82407978cd36', 'Evaluasi Produk Hukum dilakukan lebih dari 2 (dua) kali dalam satu tahun anggaran', '9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-13 09:47:14', NULL, 'A', '100'),
('a2a9c71f241318625763e8b68c5c3c72ed541042', 'SKM dipublikasikan pada 1 (satu) media publikasi    ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:56:22', NULL, 'E', '20'),
('a2b44aebb1b89a06accf34bcd46f548cfb5bbc81', 'Tersedia SP yang memenuhi 14 komponen, melibatkan masyarakat dalam penyusunan SP, dan dilakukan penetapan  ', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:55:58', NULL, 'B', '80'),
('a32fc05326f738f5ffbe48ebdf1f83e127fb0ae0', 'Terdapat aktivitas penggunaan Sistem Penghubung Layanan Pemerintah Daerah', 'e130a0fb0ce28f10c4f0f1c54249077fe30ed8ef', '2025-06-10 22:59:36', NULL, '1', '100'),
('a4a87730340d5c2a30169bdc51c7d6e81ff8e5e8', '41-60% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:51:53', NULL, 'D', '40'),
('a6440c3f61f4c36c40df150d3c8b042c5f7676b4', 'Belum ada inovasi, masih dalam proses pembelajaran berinovasi ', 'c198acc0217854f3958d6a4f4969260c1934a185', '2025-06-19 11:31:14', NULL, 'E', '20'),
('a66e1224c0b627ddbed51bdaa24b20c431b4ac82', 'Persentase Hasil Tindaklanjut Rekomendasi (TLHP) APIP', '124e174eab918098602fc8b5c503877d45dc8037', '2025-06-19 09:18:49', NULL, '1', '100'),
('a69810fddf1e3758cf00579b1be0839935480c6e', 'Tersedia data dan informasi pelayanan publik yang tidak dimutakhirkan', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:43:08', NULL, 'F', '0'),
('a71831e46fc9e243cd13279b482bb54838bb6fc7', 'Toilet pengguna layanan dengan 1 kondisi ', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-19 10:21:13', NULL, 'E', '20'),
('a77d82f2cef46bed99bc7cf5a5327ab6363113b5', 'Tidak tersedia tempat parkir', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:10:40', NULL, 'F', '0'),
('a78acf7bf02737ef2e3e82813a9a46838bfd5b33', 'Pemutakhiran data dan informasi pelayanan publik telah dilakukan secara semesteran   ', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:42:13', NULL, 'D', '40'),
('a8173c816ab221c5bdd45f766d4c26fc103fe364', 'Pemutakhiran data dan informasi pelayanan publik dilakukan secara mingguan ', '31328f434366f016ada5b7ce753da81b9887fda0', '2025-06-19 10:41:19', NULL, 'B', '80'),
('a850f7541826469d65bb8bfa7805ec13117359c4', 'Belum dilakukan Pencanangan Zona Integritas', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:19:55', NULL, 'F', '0'),
('a89dc429c729a6587eaae07f1d4a48bcde860c5e', 'Ada pemberian penghargaan hanya berdasarkan 1-2 unsur kecuali kinerja  ', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:39:40', NULL, 'E', '20'),
('a8bfba671448ddad558048c521a04f8a059fb8c4', 'Sistem Informasi berbasis elektronik telah mengintegrasikan seluruh/sebagaian layanan dalam satu sistem (single sign on)', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:42:11', NULL, 'B', '90'),
('a9530ddd20c77f13f073dee5bdec6d20915e01aa', 'Persentase Pencatatan paket transaksional pada e-Kontrak dalam SPSE', '3de9a291fe5be48c4d41d62d7e3598137675151a', '2025-06-16 09:47:16', NULL, '1', '100'),
('a9595b382b859830ae308579d0b3609c26557308', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '45f97ccdac1690930227c6b1e656c7d73afb0ed4', '2025-06-10 22:18:54', '2025-06-10 23:27:15', '2', '65'),
('a9b47e1090ca056267df9d9bc5b88b66d953a0b3', 'SKM dipublikasikan pada 4 (empat) media publikasi ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:55:26', NULL, 'B', '80'),
('a9ee4ca45a68128636606c9b52dd43cd04d55311', 'Aturan kode etik dan kode perilaku Pelaksana Pelayanan hanya meliputi nilai dasar hak dan kewajiban  ', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:32:59', NULL, 'E', '20'),
('abdf90e5ac813d5f8bcc139b889fb5f3de2df766', 'Rekomendasi hasil SKM tidak ditindaklanjuti', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:03:33', NULL, 'F', '0'),
('afd91808cc4bb12e3ebb7858d9e33404c1a6c20e', 'Penyusunan SP telah melibatkan minimal 3 unsur masyarakat', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:05:01', NULL, 'C', '60'),
('b0716753c6b9dd260219f8dc402beb1706ce1ed0', 'Terdapat aktivitas penggunaan Layanan Pusat Data Pemerintah Daerah', 'fa2adebb9a3e011b8e751c4c58f0c8f9a5246304', '2025-06-10 22:34:05', NULL, '1', '100'),
('b21f13a9137cdd9e2325072d37f25d86c37d2895', 'Tindak lanjut hasil SKM dilaksanakan 100%, dibuktikan dengan laporan pelaksanaannya ', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 14:58:18', NULL, 'A', '100'),
('b34e26557a51b581c7317e94fa8067af90ca4520', 'Laporan Capaian Indikator Kinerja Penyelenggaraan Urusan yang menjadi core Bisnis Perangkat Daerah/Raport Kinerja Perangkat Daerah pada Lingkup Penyelenggaraan Urusan yang menjadi core bisnis Perangkat Daerah', 'bef033f1d4dfe3a1cc60dd728acf7a3530b4a396', '2025-06-16 10:04:48', NULL, '1', '100'),
('b3ba9f4ecf88f4447d5e930ce1285f3271fe40ae', 'Sistem Informasi Berbasis Elektronik telah Berfungsi dengan Baik/dapat dioperasikan/dapat diakses oleh pengguna layanan', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:43:22', NULL, 'E', '60'),
('b3e91f73c80e8edaaed8fb0d8860ee4383558aa0', 'SIPP Elektronik berbasis website/aplikasi yang mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami, merupakan kanal digital resmi pemerintah (domain.go.id) dan kompatibel', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:38:46', NULL, 'A', '100'),
('b4e9d5efd87f359d1874f6689c880a9add51b566', 'Tidak menerapkan budaya layanan', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:43:43', NULL, 'F', '0'),
('b63dceb246006ec86a94678e0269af6ce34c06a7', 'Jumlah Pengaduan diatas 20 aduan', 'dc396ec8de0dba70307b0bf352b614202622f75e', '2025-06-13 10:42:45', NULL, 'A', '100'),
('b64c62a3bc7587962ea32105c786c1e431298162', '21-40% Pimpinan Tinggi Pratama pemrakarsa hadir dalam setiap rapat pengambilan keputusan', '2b2ef798eabc83589bc73dfb7fc80f13bb9867f8', '2025-06-13 09:43:29', NULL, 'E', '20'),
('b6d2bc308c535ff1be1ff578a82374e56fde82f3', '61-80% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:51:39', NULL, 'C', '60'),
('b6fcdd1d35b21d18b4077730850e159f1f48fc51', 'Tidak dipublikasikan   ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:56:44', NULL, 'F', '0'),
('b73db35fc3059e9922ce6189aa046c65ce8acc37', 'Telah menggunakan SP4N-LAPOR', 'bdf634491a8ee3ad5404841758b381bd1a9f40d8', '2025-06-13 11:22:57', NULL, '1', '100'),
('b796fd4d66b6a7f0d67d5ba1c147e802c99805f7', 'Tidak ada rencana tindak lanjut SKM', '1462e56acf3115229e54b5930b24730eb5613efc', '2025-06-18 15:00:14', NULL, 'F', '0'),
('b7c5bec97284225ab7cdfd9f32dd5b9b4df91bdc', 'Rata-rata nilai dimensi kinerja ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 30 poin', '564e33091fb99843c88bf568e7c137ee45a0b025', '2025-06-16 09:51:32', NULL, '1', '30'),
('b8f69f40a173ae54e271678a19395867270f7b9f', 'Pelaksana pelayanan menerapkan 3 (tiga)  unsur budaya pelayanan', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:42:14', NULL, 'C', '60'),
('b92903c3c19dc0c40e43e84d9af8bec7ba5c4342', 'Tersedia SP yang memenuhi 14 komponen dan dilakukan penetapan ', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:56:57', NULL, 'C', '60');
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`, `nums`, `nilai`) VALUES
('b961e97e569e0bcda6bd5ad3460b0652227bbd5e', 'Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', '1e18d576a11913f59bb54c7cefef863406078720', '2025-06-13 10:09:41', NULL, '1', '100'),
('b9f2b02c3f65261d937c86bc0d55a90f1eb62d87', 'Tersedia 1 fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:26:49', NULL, 'E', '20'),
('ba468ca8d412a1a8ed6fc276cf32a82089a75d41', 'Sudah melaksanakan SKM sesuai dengan PermenPANRB yang berlaku dan dipublikasikan pada media non-elektronik dan elektronik serta dilakukan tindak lanjut hasil SKM ', '26bb65c06a82d70329ae01ac36be312c38974880', '2025-06-18 14:49:54', NULL, 'A', '100'),
('bb6fe786c2d042c417a0390be17ea9326748969d', 'Sudah Memiliki Peta Proses Bisnis', '6f631f04f7b084a37b914fcbeb5ef3ad16ef0693', '2025-06-10 22:29:22', '2025-06-11 09:24:47', '4', '0'),
('bc0bfefe5d3be75a083311d803adfc167b18c336', 'Nilai Hasil Evaluasi Pengukuran Kinerja ', '5fc1fe493b1f677a1075171f6248fe5f0c620e40', '2025-06-19 08:53:06', NULL, '1', '30'),
('bcfb62741b4b934b978f1ab6e8dcc5949627b256', 'Terdapat dokumentasi yang diarsipkan dan dituangkan dalam laporan  ', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:55:19', NULL, 'D', '40'),
('bda82922b473b954295e54c4860ecdaa5a9adb5a', 'Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', '1ff16ba78f665f700312c31ca80da58389e7a81b', '2025-06-10 22:31:45', '2025-06-11 09:25:35', '2', '65'),
('be7c236be17f6abb187d777fc6f2dfb3a9f0b0f2', 'Tersedia publikasi SP seluruh komponen service delivery pada 4 atau lebih media publikasi dan pada SIPP Nasional ', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:16:47', NULL, 'A', '100'),
('bf17fda6a9a98d67194489d2beba1c1641c71542', 'Tersedia sistem informasi pendukung operasional pelayanan dengan 1 kondisi ', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:37:46', NULL, 'E', '20'),
('c0efab32208609c06c486777bff3c248a6945787', 'Capaian kinerja Program/Kegiatan telah berdampak dan dirasakan manfaatnya oleh sebagian kecil masyarakat yang menjadi sasaran target program/kegiatan', '93cd1583f20318aba4ed3cabeb9e9a9994332480', '2025-06-19 11:45:33', NULL, 'D', '60'),
('c14ba67550eb981caed852e8bc40c66e924b2992', ' SKM dipublikasikan pada lebih dari 4 (empat) media publikasi lainnya ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:55:01', NULL, 'A', '100'),
('c249331be306def1cabbf3b01e8c691b3dcb899a', 'Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', 'abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2025-06-10 22:25:53', '2025-06-10 23:29:34', '4', '0'),
('c281eba8cf2ed42de4c056200a6aa43b094b357e', 'Tersedia sistem antrian dengan lebih dari 4 fasilitas ', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:34:19', NULL, 'A', '100'),
('c3eb6ac9683f25aefd26c99c8e93574f9b02fd98', 'Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dilakukan monev, ditindaklanjuti, dan dipublikasikan', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:54:06', NULL, 'A', '100'),
('c51cfdab90b88d62f820a42710354122dffb8a0c', 'Rekomendasi hasil SKM ditindaklanjuti seluruhnya 1 tahun setelah laporan SKM diterbitkan    ', '9688074a1777e6aa64f154f0483f6edb7fd8c234', '2025-06-18 15:03:14', NULL, 'E', '20'),
('c555f884d3ccbc4bec2f86be960d7637ae8eaae8', '< 50% konsultasi atau pengaduan ditindaklanjuti hingga selesai yang tidak menggunakan SP4N-LAPOR!   ', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:58:01', NULL, 'E', '20'),
('c5833f6fc9759d8d3890ff10d1786b6e0295781e', 'Toilet pengguna layanan dengan 2 kondisi  ', 'd515540f163958822b5b8fadb89c591bcaf6f0bb', '2025-06-19 10:20:54', NULL, 'D', '40'),
('c6c1afd83aa8e558b14b00b72a5376668a8da091', 'Tersedia fasilitas wajib dan 1 fasilitas pelengkap      ', '5960276e7f70ab58a8d3cc27f57ab9bdacb4b253', '2025-06-19 10:18:20', NULL, 'D', '40'),
('c790fa2a164b7b77f40229db715675ba9b98c586', 'Tersedia sarana FO informasi layanan dengan 1 fasilitas     ', '1672b51208686e126770604c791bfd67d0ea7dcc', '2025-06-19 10:29:09', NULL, 'E', '20'),
('c9624b6cd0c547b6244042d7e02229cbba128cfc', 'Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum     ', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:33:10', NULL, 'D', '40'),
('c9d6c5cf85f64f66229171ebadd9eec556f0f7a1', 'Rata-rata nilai dimensi kualifikasi ASN pada setiap Perangkat Daerah dengan bobot nilai maksimal 25 poin', '7791f5c1e867947c05b7761ad4cf5673e5cda607', '2025-06-16 09:50:49', NULL, '1', '25'),
('ca1f64a2d4e18606d600b07306c3df46ace5cb47', 'Tersedianya metadata terstandar (sesuai Perka BPS No. 5 Tahun 2020) untuk semua IKU Rumus: (Jumlah metadata IKU yang tersedia dibagi jumlah total IKU) * 100%', 'b3f348e5efc8ef54cff7d945a876410e1b329641', '2025-06-13 11:28:52', NULL, '1', '0,100'),
('cb189eacc9e6feaf126a7d3d1a1bf340aa692385', 'Terdapat Dokumen Manajemen Data (mencakup pengelolaan arsitektur data (bid. statistik), data induk, data referensi (tiap PD berbeda, mengacu ke pusat), basis data, kualitas data, dan interoperabilitas data)', '54a6147d981a7d176e0c5dd43705569ba6db34fe', '2025-06-10 23:02:23', NULL, '1', '100'),
('cb40f969ea6389d2496d62f5136d68cddb57f7da', 'SKM dipublikasikan pada 3 (tiga) media publikasi  ', '222918ef0072144df43126dd42d8946bfe37329e', '2025-06-18 14:55:45', NULL, 'C', '60'),
('cb4b7802834b51db31d44c2594fb6253e63973b9', 'Penyusunan SP tanpa melibatkan unsur masyarakat dan pihak terkait (stakeholder)', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:06:55', NULL, 'F', '0'),
('cc2bf11d9374581e4256d1dc13ae0b00f54cc6df', '81-90% Hasil Evaluasi Produk Hukum yang ditindaklanjuti dalam program pembentukan Perda/Perkada', '8419f961c95170927dc5a0221dd924eedf99569b', '2025-06-13 09:51:22', NULL, 'B', '80'),
('ccfa9c3d695d8eb110209e054258d7b2bf0ead50', 'Tersedia 1-3 sarana prasarana bagi pengguna layanan kelompok rentan  ', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:23:54', NULL, 'E', '20'),
('cd3bf3b8968ebc87958bb09cf5ea68da78c07d5b', 'Dilakukan peninjauan ulang 3 tahun atau lebih terhadap seluruh jenis layanan    ', 'ba0c92bd194b67fb1e4e3047ffb33090242db4fd', '2025-06-18 11:27:42', NULL, 'E', '20'),
('cdeb064303c383460b7963267db8e48f14e7ac93', 'Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 4 (empat) unsur lainnya ', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:31:10', NULL, 'A', '100'),
('cff9e28563a7e9d6f1a0afde69e3dddf214ef01b', 'Tersedia Maklumat Pelayanan yang sudah ditetapkan dan isinya telah sesuai dengan peraturan perundangan yang berlaku ', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:44:35', NULL, 'C', '60'),
('d01aa8301a52fdccf27964cdbc4f2f21c6fc5691', 'Terdapat aktivitas penggunaan Layanan Jaringan Intra Pemerintah Daerah', 'e0c4526e75ba296f19f1472590d0baf1f9b64e29', '2025-06-10 22:41:29', NULL, '1', '100'),
('d139602fb8d12b2575d1945fe188d097db7ead3b', 'Telah dilaksanakan evaluasi oleh TPN', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:17:09', NULL, 'C', '60'),
('d1ce1348f03facc1158f8d05b925fa4ca1b3b00f', 'Penyusunan SP telah melibatkan minimal 2 unsur masyarakat    ', '4303ed643b3bec9dd0e0c3a742b08d6e9f7f3fd9', '2025-06-18 11:05:38', NULL, 'D', '40'),
('d3e6fe83fa3e963f34abdb89ca57b9eed1b6ed0d', 'Telah dilaksanakan Pencananangan ZI Unit Kerja', '5ab92f78db60f19538f40fa37c44bfc79ddf67a0', '2025-06-18 10:19:02', NULL, 'E', '20'),
('d3fa0d291d0f5a994b9414a179a8d58d62b59c35', 'Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk rancangan payung hukum ', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:33:30', NULL, 'E', '20'),
('d4542dbacb52fd0d6ed33daca06f81670a63ebae', 'Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', 'abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2025-06-10 22:24:45', '2025-06-10 23:29:12', '2', '65'),
('d547c9bf181689c6da03c438090604cfe4c3cade', 'Tersedia publikasi SP seluruh komponen service delivery pada 2 media publikasi dan pada SIPP Nasional', '38c860642d8faf7029945cb902fb9beaf59f8a15', '2025-06-18 11:18:24', NULL, 'C', '60'),
('d66e813a7beeac8811a6cf98f5898e8c269bc5f5', 'Tidak tersedia Maklumat Pelayanan   ', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:46:06', NULL, 'F', '0'),
('d74f54db55e46f449748c5c43d123c5a08792a5d', 'Sarana konsultasi pengaduan pengguna layanan dengan 4 fasilitas', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:47:16', NULL, 'B', '80'),
('d7552aaf945cce06d93f8f802973cf727dc6533d', 'Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dan dilakukan monev ', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:54:44', NULL, 'C', '60'),
('d7aad52f983bcd41e75888298f464e0b5db248cf', 'Tersedia SP namun tidak memenuhi 14 Komponen    ', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:58:39', NULL, 'E', '20'),
('d97efbd37392e1e6581b33a4806299e61dc45544', 'Sarana konsultasi pengaduan pengguna layanan dengan 1 fasilitas   ', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:48:16', NULL, 'E', '20'),
('da848770e9dd6bd2a2730867ea7a09c869321896', 'Tidak ada IKU Perangkat Daerah tercapai (0%)', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-19 09:13:00', NULL, 'E', '0'),
('dae2cc0e5f7397f9a0dbe80d07c6ba056643d665', 'Tersedia 10-12 sarana prasarana bagi pengguna layanan kelompok rentan', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:22:36', NULL, 'B', '80'),
('dd5ec3e93ed68335059b07ae1ae26dd8fb1cfdc3', 'Tidak tersedia Standar Pelayanan', 'fb50aefb093247f432cb57343143ae7fa60be3bc', '2025-06-18 10:59:32', NULL, 'F', '10'),
('dd6921e7ee0db6ab72830e4ec4e88eacbb0214b5', 'Memiliki kebijakan jam pelayanan/kerja ', 'a7f919001f45b9a552a6ffcd418ea4273bfce467', '2025-06-19 09:28:15', NULL, 'E', '20'),
('de0251b9004ef1597c64ca8a694c503c27ec27bb', 'Sumber daya yang mendukung keberlanjutan inovasi dalam bentuk payung hukum dan 1 kondisi lainnya ', 'bbd6766844c62b32f026fd274cb4ca16a94fb4ba', '2025-06-19 11:32:52', NULL, 'C', '60'),
('dec846374051401647f8d8dad0582e55f2e764bf', 'Penetapan Indikator Kinerja Sekretariat Perangkat Daerah tentang Indeks Reformasi Birokrasi Perangkat Daerah pada Cascading Kinerja', '29cf25bb5ea0d1b0c8ef68c1e401765ba6d6651f', '2025-06-16 09:54:48', '2025-06-18 09:23:04', '1', ''),
('ded40a9c1afeda920c8ff179b71e1a79cb6d6fd2', 'Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi perencanaan', '6aee4cc780191317ea55ac6e0cf353f0a1588182', '2025-06-13 08:33:30', '2025-06-16 08:08:48', '1', '100'),
('df8a1572f4bbc600ae84fb5b354c98a2c0f4ab10', 'Evaluasi Produk Hukum dilakukan 1 (satu) kali dalam satu tahun anggaran', '9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-13 09:47:58', NULL, 'C', '50'),
('dfa1b255c48b5c781609f3a481a72964dcacb71a', 'Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', 'abdcb370678c9efebdae43a6d0edd6ef227f3aca', '2025-06-10 22:25:16', '2025-06-10 23:29:25', '3', '35'),
('e045b51b5258c7745a3b5632702ef1c35088458e', 'Telah menggunakan eKinerja/KMOB', '534b4f1b17fb66a0934dd6de2965307b36fdfd94', '2025-06-13 11:19:34', NULL, '1', '100'),
('e1fefebe747a9e6e3f9f72fd49e761ea3969935c', 'Tersedia tempat parkir dan memiliki 5 atau lebih fasilitas parkir ', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:08:35', NULL, 'A', '100'),
('e2f47e79a6d45ffdae3410bf85a5f04905e1f8ee', 'Nilai Hasil Evaluasi Internal Akuntabilitas Kinerja Internal', '89a3cfcafdb60bf04616631ab63464418ff7367c', '2025-06-19 08:54:49', NULL, '1', '25'),
('e341592ab00405217d7e3655b4a71b42306e1c2b', 'Nilai Hasil Evaluasi Pelaporan Kinerja ', '95e18a732238ea906e25d348f878f80b7d9345c2', '2025-06-19 08:53:58', NULL, '1', '15'),
('e4b98d8fdacb203ae8c3e6fdedb39c29bc221f96', 'Tersedia Maklumat Pelayanan yang sudah ditetapkan, isinya telah sesuai dengan peraturan perundangan yang berlaku, dan dipublikasikan pada media non elektronik', 'b2b39157592e921b7a4893ec51e37e01688327dc', '2025-06-18 14:43:45', NULL, 'B', '80'),
('e663ec5af15c69e3c301472cc1d8fb3d0e73d133', 'Sistem Informasi berbasis elektronik telah berkontribusi terhadap tercapainya kinerja Pemerintah Daerah dan/atau Perangkat Daerah', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:42:33', NULL, 'C', '80'),
('e6f1669ddf3ce8466655b678523a802ba18193b2', 'Menyampaikan/melaksanakan Continouous Improvment penerapan Sistem Informasi berbasis elektronik yang telah terintegrasi dalam satu sistem (single sign on)', '413464b84908505e7d4fcbe8e802d6a44da902b4', '2025-06-19 11:41:33', NULL, 'A', '100'),
('ea225e597c1ecf96f84f61d13447f9e305c9a02c', 'Belum pernah dilakukan Evaluasi Produk Hukum', '9d065032e5205e2ac9d88a57f95608179707ec61', '2025-06-13 09:48:50', NULL, 'D', '25'),
('eb4ca7efb7d56ba01775b6f64e5d31bcb8becc68', '90% konsultasi atau pengaduan yang masuk ke SP4N-LAPOR! dan ditindaklanjuti hingga selesai', 'b5c2e88ff32ee16765c3b7c79bc69066b64e7f6b', '2025-06-19 10:56:38', NULL, 'A', '100'),
('eb73adcf939f317722492c883c4ddc2a122de0b7', 'Tidak tersedia sarana prasarana bagi pengguna layanan kelompok rentan', '0133e2eaecfbdd0b86264e90740661739847444a', '2025-06-19 10:24:13', NULL, 'F', '0'),
('eb86f7888ec429c0e428470f1c72caf31f1f7caf', 'Pelaksana pelayanan menerapkan 2 (dua) unsur budaya pelayanan  ', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:42:53', NULL, 'D', '40'),
('ebc674b101899799835fa3f38b67c87cbed9eaa0', 'Jumlah Pengaduan dibawah 5 aduan', 'dc396ec8de0dba70307b0bf352b614202622f75e', '2025-06-13 10:43:36', NULL, 'D', '25'),
('ec8a18d0c3ab7e346ec2f3e94936864d560c9a93', 'SIPP Elektronik berbasis website/aplikasi mudah dioperasikan  ', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:40:09', NULL, 'E', '20'),
('eddd6c5233d1b0648718b3e2365b3effae8f2354', 'Tidak tersedia sistem informasi pendukung operasional pelayanan publik', '72c74e606e4d873d6f94f0030a06946590352cbc', '2025-06-19 10:38:02', NULL, 'F', '0'),
('eeeb78e55711bceed52fd03bc717d6d54f4f98a3', 'Sarana konsultasi pengaduan pengguna layanan dengan 2 fasilitas ', 'da31f7996d51add8aa2dda4aeb587896bd9af816', '2025-06-19 10:47:58', NULL, 'D', '40'),
('f17d5bf09b81cc49b635618f10d7377ff6c7bd1d', 'Terdapat dokumentasi diarsipkan, dituangkan dalam laporan, dilakukan monev, dan ditindaklanjuti ', '2b7af354328c5e03b48e33a9e62978f4b0124629', '2025-06-19 10:54:25', NULL, 'B', '80'),
('f1e5b2fa8f2a6b5b0a45c03ddbab31afbf55d04e', 'Sebagian besar IKU Perangkat Daerah tercapai (>50%)', '4219bff5e3201b7b0bdf2b212e1edd1e1fd17c5c', '2025-06-19 09:11:31', NULL, 'B', '75'),
('f1e8974f4df350c3f4bed6879294e386153324f9', 'Tersedia 5 atau lebih fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:24:51', NULL, 'A', '100'),
('f2868345c34b7677107bbcf28f60a080df036988', 'Proses pembangunan/pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', '1ff16ba78f665f700312c31ca80da58389e7a81b', '2025-06-10 22:31:22', '2025-06-11 10:34:29', '1', '100'),
('f393bce8920d68372dd489cc068f6f4383ce2765', 'SIPP Elektronik berbasis website/aplikasi yang mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami, merupakan kanal digital resmi pemerintah (domain.go.id) ', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:39:09', NULL, 'B', '80'),
('f40200f3d82315d7e782ff3f8d80517b6c695985', 'Tersedia sistem informasi pelayanan publik non elektronik melalui media lisan (pusat informasi)     ', 'ab30c4d31d794eb8439a7977cce5bd3b9c2f13fc', '2025-06-19 10:35:09', NULL, 'E', '20'),
('f6cb4e0b19e53fc73391eac03d1e675886183fe0', 'Pelaksana pelayanan menerapkan4 (empat)  unsur budaya pelayanan', '23166a8ae4d427fe718a1ae565cbd72a19aa3392', '2025-06-19 09:41:48', NULL, 'B', '80'),
('f71244be83a683801316d49926d0e033bf537b0d', 'Tidak tersedia sistem antrian', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:35:55', NULL, 'F', '0'),
('faca51741ca37f79d462ed9f6449c5bba6457aee', 'Aturan kode etik dan kode perilaku Pelaksana Pelayanan meliputi nilai dasar hak dan kewajiban dan 3 (tiga) unsur lainnya', 'de00b6ee2d401b13b6576ee14c1ddbb96c7a4820', '2025-06-19 09:31:40', NULL, 'B', '80'),
('faecdac496febe881893eaa1ef681a0571b7e2b8', 'Tidak tersedia fasilitas penunjang', 'e02be12b2244cfb5b6eb22080f7caf366e9d607d', '2025-06-19 10:27:09', NULL, 'F', '0'),
('fef3141372852afc45de9f8a6aba1262c64fcc08', 'Tersedia tempat parkir dan memiliki 2 atau lebih fasilitas parkir  ', '054a031448fee205ada507d5fa566fd9e001bc70', '2025-06-19 10:09:55', NULL, 'D', '40'),
('ff2f3da8e1795b4dcd37fcffdf2721c6ec73b420', ' Tersedia sistem antrian dengan 2 fasilitas', '91abd3afcd2747a8c0e261587c1eef09351d09d6', '2025-06-19 11:35:16', NULL, 'D', '40'),
('ff3436841eed92aff352664b4416ec06feeae484', 'SIPP Elektronik berbasis website/aplikasi mudah dioperasikan, mudah diakses, navigasi yang mudah dipahami ', '1c2c2b8dad484483b8e643700c597e24b054ce97', '2025-06-19 10:39:28', NULL, 'C', '60'),
('ffb50bf2e1f0c80136d950b8f2d82bba2f32c4da', 'Telah menggunakan Sistem Informasi Penatausahaan Keuangan Daerah (SIKD) ', 'e614f202a3b5c0ca97de18c5c2ab930593270a0b', '2025-06-13 10:26:52', NULL, '1', '100'),
('ffe82af0ad30b356499be9f8e91cc7f177ba8d53', 'Ada pemberian penghargaan berdasarkan 3-5 unsur kecuali kinerja ', 'e6c3f34ae501e033efe0a84932f24dad6b0f18e4', '2025-06-19 09:39:07', NULL, 'D', '40');

-- --------------------------------------------------------

--
-- Table structure for table `lke_rb`
--

CREATE TABLE `lke_rb` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT ' ',
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `form_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_rb`
--

INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`, `form_id`, `nums`) VALUES
('41f64d8b77d2170f551799a3cc3b38e9e8e1aae8', 'RB General Perangkat Daerah', '100', '2025-06-10 19:55:38', '2025-06-10 19:56:45', 'ca637035f0a5396d1cc11662a8c674a1aec6f3a6', 'I'),
('d3477629f57db96c6819ab2887528ee80b810e91', 'RB Tematik Perangkat Daerah', '100', '2025-06-10 19:56:13', NULL, 'ca637035f0a5396d1cc11662a8c674a1aec6f3a6', 'II');

-- --------------------------------------------------------

--
-- Table structure for table `lke_role`
--

CREATE TABLE `lke_role` (
  `Uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_role`
--

INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES
('08a62fdb70f816447cbb4488ed1626653233851f', '49bc74a69d7256191ab4d953a6516e73c70f08db', '2025-03-13 11:09:13', NULL, NULL),
('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('c895f123acea93c7dc34d334eadf6cf086474170', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('b083d8a22edda3ceba2daed7a003569542017f94', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('3dea52e293fb809251abd6b2a3bb8bdeec71265d', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('a8dfbd890507edce5df5425d990883ad144967fd', 'ae7deb37b1eac722afda8c431c677662afd57af9', NULL, NULL, '4f5630e17ea4f990ad84e94355b75a423289ed90'),
('a8dfbd890507edce5df5425d990883ad144967fd', 'ae7deb37b1eac722afda8c431c677662afd57af9', NULL, NULL, '2529da654aeb9502fe645a174aefcc4e71571b76'),
('400287b9dbd5310785484fc6e23f1ed312767494', '49bc74a69d7256191ab4d953a6516e73c70f08db', NULL, NULL, NULL),
('12c2130d7b2d29e0930b2d3fccf97d978b0e821c', 'ae7deb37b1eac722afda8c431c677662afd57af9', '2025-06-23 07:08:24', NULL, '4f5630e17ea4f990ad84e94355b75a423289ed90'),
('12c2130d7b2d29e0930b2d3fccf97d978b0e821c', 'ae7deb37b1eac722afda8c431c677662afd57af9', '2025-06-23 07:08:24', NULL, '661969cb29d371dfbccbb2d515434414b4e716dd');

-- --------------------------------------------------------

--
-- Table structure for table `lke_roles`
--

CREATE TABLE `lke_roles` (
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `acs` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_roles`
--

INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES
('49bc74a69d7256191ab4d953a6516e73c70f08db', 'Super Admin', '2025-01-07 11:55:47', NULL, '1'),
('618d4897a69c737080de4216b15b64e1909ecba0', 'User', '2025-01-07 13:57:02', NULL, '5'),
('8fdad4894c55a3dbfb4fe280c02bd55512df3803', 'Soal', '2025-01-07 13:56:55', NULL, '3'),
('ae7deb37b1eac722afda8c431c677662afd57af9', 'Penilai', '2025-01-07 13:56:45', NULL, '2'),
('cfcc17f00a840c2bf60d19ab5e2975ae52fb6c00', 'Verifikator', '2025-01-28 08:53:04', NULL, '4');

-- --------------------------------------------------------

--
-- Table structure for table `lke_sub_aspek`
--

CREATE TABLE `lke_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batas_waktu` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_sub_aspek`
--

INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`, `nums`, `batas_waktu`) VALUES
('02d0f839f8e00feb1cd00c0440381c1699dea084', 'Indeks Kualitas Pelayanan Publik', '2025-06-10 21:34:10', '2025-06-11 18:59:18', 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '1', '2025-10-15 12:00:00'),
('0b85229db15ed350ca6924f0e5b46493b78532b1', 'Tingkat Implementasi Rencana Aksi Pembangunan RB General', '2025-06-13 10:07:14', NULL, 'ac40ca513bf374d82b4540e1aab40a64abeb5045', '100', '2', '2025-10-15 12:01:00'),
('2529da654aeb9502fe645a174aefcc4e71571b76', 'Nilai Survei Kepuasan Masyarakat', '2025-06-10 20:03:22', '2025-06-11 18:57:46', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '7', '2025-10-15 12:00:00'),
('28319916f57dc42d74bcbeea47c402092306d594', 'Rencana Aksi Pembangunan RB General', '2025-06-13 10:06:55', NULL, 'ac40ca513bf374d82b4540e1aab40a64abeb5045', '100', '1', '2025-10-15 12:01:00'),
('4f5630e17ea4f990ad84e94355b75a423289ed90', 'Tingkat Kematangan SPBE Perangkat Daerah', '2025-06-10 20:00:19', '2025-06-11 18:51:52', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '1', '2025-10-15 12:00:00'),
('661969cb29d371dfbccbb2d515434414b4e716dd', 'Tingkat tindak lanjut pengaduan masyarakat (LAPOR)', '2025-06-11 22:27:35', '2025-06-11 22:29:11', 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '3', '2025-06-11 23:59:00'),
('78ad313a6cd91a022641a5825eae1997d2fdf397', 'Peningkatan Penggunaan Produk Dalam Negeri', '2025-06-13 10:18:00', NULL, '5b7bbdd04ecbd22db45c48f5b18c8b03f52c3699', '100', '1', '2025-10-15 12:00:00'),
('7e6475b6b7c0e943ceb16296fc277e94695f72e9', 'Tindaklanjut Rekomendasi (TLHP)', '2025-06-10 20:01:56', '2025-06-11 18:55:05', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '4', '2025-10-15 12:00:00'),
('8e27d3b0961a8314e8fea5b29237ac202574daa6', 'Indeks Tata Kelola Pengadaan Barang/Jasa Perangkat Daerah', '2025-06-13 10:05:30', NULL, 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '5', '2025-10-15 12:01:00'),
('9ea4a689a871115b5e3dd1c8660ed3eba3c01c2d', 'Nilai SAKIP Perangkat Daerah', '2025-06-10 20:00:59', '2025-06-11 18:53:12', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '2', '2025-10-15 12:00:00'),
('a5b9e8ef637b4bd06373e8d6e525d84abff41730', 'Rencana Aksi Pembangunan RB Tematik', '2025-06-13 10:16:24', NULL, '47116ecef80d2b99adafd531a5bd9070746c7f5c', '100', '1', '2025-10-15 12:00:00'),
('ac3b5808079752da3c1b486f799b3bc109c84f39', 'Capaian Kinerja Core Business Organisasi ', '2025-06-13 10:19:42', NULL, '5b7bbdd04ecbd22db45c48f5b18c8b03f52c3699', '100', '3', '2025-10-15 12:00:00'),
('c95e2b02f55c3c89668a2bc4b042a83e7cbc56ea', 'Persentase Capaian Rencana Aksi Pembangunan RB Tematik', '2025-06-13 10:16:47', '2025-06-16 10:16:27', '47116ecef80d2b99adafd531a5bd9070746c7f5c', '100', '2', '2025-10-15 12:00:00'),
('cd3ec24f582c7b0e63df396e843ac35b44f8b122', 'Tingkat Digitalisasi Arsip', '2025-06-11 22:28:02', '2025-06-11 22:29:28', 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '4', '2025-06-11 23:59:00'),
('cdd78a5ab2c6a86c1d536bbabd9f08a3f72d73a9', 'Indeks Profesionalitas ASN ', '2025-06-13 10:06:05', NULL, 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '6', '2025-10-15 12:01:00'),
('d4b6738337a5648921a684624a42624065c859cd', 'Indeks Reformasi Hukum', '2025-06-11 22:26:43', '2025-06-11 22:28:54', 'a10caed3d3670153b16cde164bbf348fd2ce643a', '100', '2', '2025-06-11 23:59:00'),
('d52066813ed835b41662fe4fcf1ae5734b3caa94', 'Capaian IKU Perangkat Daerah', '2025-06-10 20:01:33', '2025-06-11 18:54:41', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '3', '2025-10-15 12:00:00'),
('d8290e3e10b509444b3affc12f10a0c54adbd6f4', 'Digitalisasi Administrasi Pemerintahan', '2025-06-13 10:18:22', NULL, '5b7bbdd04ecbd22db45c48f5b18c8b03f52c3699', '100', '2', '2025-10-15 12:00:00'),
('e287965ff2c99e5e13f38609d599c902f4dcbb09', 'Indeks Budaya Kerja BerAKHLAK', '2025-06-10 20:02:56', '2025-06-11 18:56:43', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '6', '2025-10-15 12:00:00'),
('e81daac526b0df120f541ae49435bce941dd23f0', 'Tingkat Keberhasilan Pembangunan ZI', '2025-06-10 20:03:46', '2025-06-11 19:29:44', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '8', '2025-10-15 12:00:00'),
('efdad76a27bdd2d8687fcc5251402ab594ea6894', 'Laporan Realisasi APBD Perangkat Daerah', '2025-06-10 20:02:32', '2025-06-11 18:55:26', 'c9cb6fd2e2f16bd56c2880dff64f85d185e2e792', '100', '5', '2025-10-15 12:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lke_sub_sub_aspek`
--

CREATE TABLE `lke_sub_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nums` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_sub_sub_aspek`
--

INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`, `nums`) VALUES
('01b9f45ad2a0fb7dccdbdc646a0821c23f27cb1b', 'Nilai Survey Kepuasan Masyarakat Perangkat Daerah', '2025-06-10 21:31:35', NULL, '2529da654aeb9502fe645a174aefcc4e71571b76', '100', '7.1'),
('057226d2d134fa7f7d12730846d47ea91c482d83', 'Laporan Pengelolaan SP4N-LAPOR! Setiap Semester', '2025-06-11 22:33:18', NULL, '661969cb29d371dfbccbb2d515434414b4e716dd', '80', '3.3'),
('08f9b667ed43041f853956fcab74908204072d69', 'Surat Keputusan/Surat Perintah Tim Pengelola SP4N Lapor Perangkat Daerah', '2025-06-11 22:32:43', NULL, '661969cb29d371dfbccbb2d515434414b4e716dd', '10', '3.1'),
('0b5c8fa0d034429574ebd1fec5cea98a0a08fc69', 'Pengusulan Pembentukan Peraturan Daerah/Peraturan Kepala Daerah', '2025-06-11 22:30:50', NULL, 'd4b6738337a5648921a684624a42624065c859cd', '36', '2.1'),
('1ec675aeeb3ed00af2269a6a3aede471a428b161', 'Pemenuhan Dokumen Rencana Aksi RB Tematik', '2025-06-16 09:58:38', NULL, 'a5b9e8ef637b4bd06373e8d6e525d84abff41730', '100', '1.1'),
('1f2d995999594443cc5ea4edae3ced8d3e16bbcd', 'Nilai Pengawasan Kearsipan Internal', '2025-06-11 22:33:50', NULL, 'cd3ec24f582c7b0e63df396e843ac35b44f8b122', '100', '4.1'),
('255b7ce5c32637bee13941cfbf05fcd35957a4a8', 'Tingkat Implementasi Kamus Kompetensi ASN BerAKHLAK', '2025-06-10 21:30:29', NULL, 'e287965ff2c99e5e13f38609d599c902f4dcbb09', '100', '6.1'),
('2928673966d41805cb642c2f4060ec78af0114c7', 'Diseminasi SP4N-LAPOR! Kepada Masyarakat', '2025-06-11 22:33:02', NULL, '661969cb29d371dfbccbb2d515434414b4e716dd', '10', '3.2'),
('2d92920988e321f741f783fce665e30f30c188e5', 'Tingkat Kematangan Kapabilitas Proses', '2025-06-10 21:21:53', NULL, '4f5630e17ea4f990ad84e94355b75a423289ed90', '50', '1.1'),
('380f62689db0a9dea250a9c361827dc5944ef251', 'Tingkat Kematangan Kapabilitas Layanan', '2025-06-10 21:22:28', NULL, '4f5630e17ea4f990ad84e94355b75a423289ed90', '30', '1.2'),
('4180c76ad2a00cb809b55f763eda4151dc37cc86', 'Nilai Evaluasi Akuntabilitas Kinerja Internal ', '2025-06-10 21:25:40', NULL, '9ea4a689a871115b5e3dd1c8660ed3eba3c01c2d', '100', '2.1'),
('43f884162b5470fcce60d5124eebc4ad201cdae6', 'Sarana dan Prasarana', '2025-06-19 09:49:32', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '18.00', '1.3'),
('465a2a1b56cb873fec41cdfd2ef659d474a59b93', 'Tingkat Ketercapaian IKU Perangkat Daerah', '2025-06-19 08:58:33', NULL, '9ea4a689a871115b5e3dd1c8660ed3eba3c01c2d', '100', '3.1'),
('49683c6f2acfeb6c075fed2f6c0b06b010beea0f', 'Kebijakan Pelayanan', '2025-06-18 10:37:53', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '24.00', '1.1'),
('4cadf397a1a3f85cf769b91d9c0e3c063a355384', 'Pemenuhan Dokumen Rencana Aksi RB General', '2025-06-16 09:53:03', NULL, '28319916f57dc42d74bcbeea47c402092306d594', '100', '1.1'),
('4f01cbe6d105283f43490afeee3f9ecfd2dd4a4c', 'Persentasi Realisasi APBD Tahun Berjalan', '2025-06-10 21:29:28', NULL, 'efdad76a27bdd2d8687fcc5251402ab594ea6894', '50', '5.2'),
('50b2c319a07d11a546718361b885977af6f7001b', 'Nilai Kepatuhan Pencatatan Pengadaan Barang/Jasa Pemerintah pada SPSE ', '2025-06-13 10:35:21', NULL, '8e27d3b0961a8314e8fea5b29237ac202574daa6', '100', '5.1'),
('5242c03179064bdbbe544bc4e318963af585bf32', 'Capaian Kinerja Core Business Organisasi ', '2025-06-16 10:51:51', NULL, 'ac3b5808079752da3c1b486f799b3bc109c84f39', '100', '3.1'),
('56a54e1832dc68831bcca696e66c80cb56fd64e0', 'Implementasi Digitalasasi Administrasi Pemerintahan', '2025-06-16 10:12:32', NULL, 'd8290e3e10b509444b3affc12f10a0c54adbd6f4', '100', '2.1'),
('6b73c827ee8be49cb9a2d61e0651cd0f3eef11d3', 'Konsultasi dan Pengaduan', '2025-06-19 09:51:31', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '10.00', '1.5'),
('747c28476e689b3a321f8c527aaf2a37489a874a', 'Realisasi Belanja Produk Dalam Negeri/Tingkat Komponen Dalam Negeri (PDN/TKDN)', '2025-06-16 10:07:42', NULL, '78ad313a6cd91a022641a5825eae1997d2fdf397', '100', '1.1'),
('829f8f418b567768a9065d723d4dbc1025f11c25', 'Tingkat Implementasi Rencana Aksi Pembangunan RB Tematik', '2025-06-16 10:01:14', NULL, 'c95e2b02f55c3c89668a2bc4b042a83e7cbc56ea', '100', '2.1'),
('a6eb6aa1a78a957d36ce9932e03e80662d7c430b', 'Persentase Capaian Rencana Aksi Pembangunan RB General', '2025-06-16 09:55:48', NULL, '0b85229db15ed350ca6924f0e5b46493b78532b1', '100', '2.1'),
('b10a47f65bf169dca8dd07aa4376453992b7ba6f', 'Persentasi Penyelesaian Tindaklanjut Hasil Pemerikaan (TLHP)', '2025-06-10 21:27:51', NULL, '7e6475b6b7c0e943ceb16296fc277e94695f72e9', '100', '4.1'),
('bcaa314592885431f94270f39f1b6cda138a9348', 'Penyelenggaraan Statistik Sektoral', '2025-06-10 21:23:07', NULL, '4f5630e17ea4f990ad84e94355b75a423289ed90', '20', '1.3'),
('c068df47a0481354b6283c9cf910e3235e68e3a0', 'Profesionalisme Sumber Daya Manusia (SDM)', '2025-06-18 15:10:22', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '25.00', '1.2'),
('d6020f1eb35d3442dbb2f6cf20338fe4e50ea0db', 'Nilai Rata-Rata Indeks Profesionalitas ASN Perangkat Daerah', '2025-06-13 10:36:37', NULL, 'cdd78a5ab2c6a86c1d536bbabd9f08a3f72d73a9', '100', '6.1'),
('daaa5c6a688167eef7f272370c794f469382e734', 'Persentasi Realisasi APBD Tahun Sebelumnya', '2025-06-10 21:29:02', NULL, 'efdad76a27bdd2d8687fcc5251402ab594ea6894', '50', '5.1'),
('e5266f7bdc984ff804e99a1d67b4cde04ff70350', 'Tingkat Kehadiran Pimpinan Tinggi Pemrakarsa', '2025-06-11 22:31:24', NULL, 'd4b6738337a5648921a684624a42624065c859cd', '24', '2.2'),
('e87a0405f07d0319c900e09843a592128f94286c', 'Evaluasi Produk Hukum dan Tindaklanjutnya', '2025-06-11 22:31:49', NULL, 'd4b6738337a5648921a684624a42624065c859cd', '40', '2.3'),
('ea7358c7806920c8efafd2112c0db8e010196627', 'Tingkat Ketercapaian IKU Perangkat Daerah', '2025-06-10 21:26:49', NULL, 'd52066813ed835b41662fe4fcf1ae5734b3caa94', '100', '3.1'),
('ece1165f2445dac8cd6e55eda12ac57bb822e4e3', 'Sistem Informasi Pelayanan Publik', '2025-06-19 09:50:57', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '11.00', '1.4'),
('f8cb84a75af5b3b14d1f5094d2b3ec1598eb660e', 'Capaian Pelaksanaan Pembangunan Zona Integritas', '2025-06-10 21:32:42', NULL, 'e81daac526b0df120f541ae49435bce941dd23f0', '100', '8.1'),
('f8d46c4490720c9a7d64660ab2b996c88ea2e110', 'Inovasi', '2025-06-19 09:53:11', NULL, '02d0f839f8e00feb1cd00c0440381c1699dea084', '12.00', '1.6');

-- --------------------------------------------------------

--
-- Table structure for table `lke_tahun`
--

CREATE TABLE `lke_tahun` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lke_upload_bukti`
--

CREATE TABLE `lke_upload_bukti` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `files` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_upload_bukti`
--

INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES
('37787d500d0bf0892217726873950daea7c3ca9b', '1750653461_c122e1e653be107480eb.pdf', 'a545414d3973c500bb8de04f03ba89a387564b52', '2025-06-23 12:37:41', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('7c3c84d54451a8c988486e6ec330a2921069e101', '1750653542_636b1a3f0788fe13449b.xlsx', '08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:39:02', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('8ef40202713333718a60202258d00ebfa7719c2f', '1750653398_c7416cea333f80dcb703.xlsx', '08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:36:38', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('f45230190dce5e52463da609ab779594cae86665', '1750653648_c58788b4b3d73292a7ef.pdf', '08d1e20ff227a7d627448374f8626592571de5ef', '2025-06-23 12:40:48', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170');

-- --------------------------------------------------------

--
-- Table structure for table `lke_user`
--

CREATE TABLE `lke_user` (
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PassEnc` varbinary(255) DEFAULT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmailAdds` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `actv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lke_user`
--

INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES
('08a62fdb70f816447cbb4488ed1626653233851f', 'admin', 'super admin', 0xbadf0573c890a9fd2ddfc3031b4c849d, '-', 'admin@surabe.com', '2025-03-13 11:09:13', '2025-06-13 11:40:06', 'TRUE'),
('12c2130d7b2d29e0930b2d3fccf97d978b0e821c', 'penilaikominfo', 'penilai kominfo', 0x9a80dc549e76f8443ae5c6323cc232bf, '000000000000', 'penilaikominfo@surabe.sultengprov.go.id', '2025-06-23 07:08:23', '2025-06-23 15:08:24', 'TRUE'),
('3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'budker', 'Irfan', 0x7527dd9073a45ab8ce56059f6076ca01, '082187020149', 'sajairfan3@gmail.com', '2025-06-05 02:57:19', '2025-06-05 10:57:19', 'TRUE'),
('400287b9dbd5310785484fc6e23f1ed312767494', 'adminku', 'Admin Surabe', 0x69654634b45770c743053029deb08d3f, '000000000000', 'adminku@surabe.sultengprov.go.id', '2025-06-23 06:57:46', '2025-06-23 14:57:46', 'TRUE'),
('660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', 'muftyabyan', 'muhammad mufti abyan', 0x3835a6e75c78849bc6ddc3799a35c527, '08134119555', 'muftyabyan@gmail.com', '2025-06-05 02:59:00', '2025-06-05 10:59:00', 'TRUE'),
('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', 'dprd', 0xd69aeaed31b2ef9d2d4338276965f075, '93278923424242', 'dprd@mail.com', '2025-05-15 07:02:00', '2025-05-15 15:02:00', 'TRUE'),
('a8dfbd890507edce5df5425d990883ad144967fd', 'penilai', 'PENILAI', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'penilai@mail.com', '2025-03-13 04:46:43', '2025-06-23 13:29:07', 'TRUE'),
('b083d8a22edda3ceba2daed7a003569542017f94', 'rb_renaksi', 'Mohammad azim purwana ', 0x11556bf7ffe8d571a42572bd82a097c7, '085212409490', 'azimpurwana@gmail.com', '2025-06-05 02:48:55', '2025-06-05 10:48:55', 'TRUE'),
('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'madani', 'MADANI', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'madani@mail.com', '2025-03-13 03:42:15', '2025-03-13 11:42:15', 'TRUE'),
('bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan', 'sultan sirajuddin', 0x7c85c671838f8bfe00b8ecc99bef791c, '085241349838', 'sirajuddinsultan666@gmail.com', '2025-06-05 03:01:06', '2025-06-05 11:01:07', 'TRUE'),
('c895f123acea93c7dc34d334eadf6cf086474170', 'undata', 'UNDATA', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'undata@mail.com', '2025-03-13 03:41:41', '2025-03-13 11:41:41', 'TRUE'),
('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'soal', 'Pengisi Soal', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'soal@surabe.com', '2025-03-13 03:11:55', '2025-03-13 11:11:55', 'TRUE');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lke_aspek`
--
ALTER TABLE `lke_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_bobot`
--
ALTER TABLE `lke_bobot`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_bukti_dukung`
--
ALTER TABLE `lke_bukti_dukung`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_detail_opd`
--
ALTER TABLE `lke_detail_opd`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_form`
--
ALTER TABLE `lke_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_indikator`
--
ALTER TABLE `lke_indikator`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_jawaban`
--
ALTER TABLE `lke_jawaban`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_Jenis_Jawaban`
--
ALTER TABLE `lke_Jenis_Jawaban`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `lke_logs`
--
ALTER TABLE `lke_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_log_user`
--
ALTER TABLE `lke_log_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_nilai_jawaban_user`
--
ALTER TABLE `lke_nilai_jawaban_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_opd`
--
ALTER TABLE `lke_opd`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_parameter`
--
ALTER TABLE `lke_parameter`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_rb`
--
ALTER TABLE `lke_rb`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_roles`
--
ALTER TABLE `lke_roles`
  ADD PRIMARY KEY (`RoleId`);

--
-- Indexes for table `lke_sub_aspek`
--
ALTER TABLE `lke_sub_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_sub_sub_aspek`
--
ALTER TABLE `lke_sub_sub_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_tahun`
--
ALTER TABLE `lke_tahun`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_upload_bukti`
--
ALTER TABLE `lke_upload_bukti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lke_user`
--
ALTER TABLE `lke_user`
  ADD PRIMARY KEY (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
