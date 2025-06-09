-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3309
-- Waktu pembuatan: 09 Jun 2025 pada 11.15
-- Versi server: 8.0.42-0ubuntu0.22.04.1
-- Versi PHP: 8.3.12

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
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmas` VARCHAR(255), `bbt` VARCHAR(255), `rbx` VARCHAR(255))   BEGIN
  
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
			INSERT INTO lke_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmas, NOW(), null, bbt, NULL, rbx);
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
		UPDATE lke_aspek SET nama_aspek = nmas, bobot = bbt, update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data Aspek : ',nmas,' Bobot : ',bbt), NOW());
	END IF;
	
	COMMIT;
	SELECT res, msg;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Bukti_dukung_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idindk` VARCHAR(255), `bkdk` VARCHAR(255))   BEGIN
  
	
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

				INSERT INTO lke_bukti_dukung VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), idindk, bkdk, NOW(), NULL);
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
			UPDATE lke_bukti_dukung SET id_indikator = idindk, bukti_dukung = bkdk, update_at = NOW() WHERE id = idx;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Bukti_dukung_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Form_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmx` VARCHAR(255), `thnx` VARCHAR(255), `desk` VARCHAR(255), `evls` VARCHAR(255), `btwkt` DATETIME)   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Form_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Indikator_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idssa` VARCHAR(255), `nmind` VARCHAR(255), `jjwb` VARCHAR(255))   BEGIN
  
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
				INSERT INTO lke_indikator VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), idssa, nmind, NOW(), NULL, jjwb);
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
			UPDATE lke_indikator SET indikator= nmind, id_sub_sub_aspek = idssa, jenis_jawaban = jjwb 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Indikator_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Jawaban_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `jwb` VARCHAR(255), `idindx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Jawaban_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Jenis_Jawaban_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `jnjwb` VARCHAR(255))   BEGIN
  
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

	END IF;
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Jenis_Jawaban_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `log_user` (`uidx` VARCHAR(255), `ipx` VARCHAR(255), `stsx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Opd_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmopd` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Opd_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Parameter_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmpar` TEXT, `idind` VARCHAR(255))   BEGIN
  
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
				INSERT INTO lke_parameter VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmpar, idind, NOW(), NULL);
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
			UPDATE lke_parameter SET nama_parameter = nmpar, id_indikator = idind, update_at = NOW()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Parameter_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idk` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rb_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmx` VARCHAR(255), `bbt` VARCHAR(255), `frmx` VARCHAR(255))   BEGIN
  
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
			INSERT INTO lke_rb VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmx, bbt, NOW(), NULL, frmx);
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
		UPDATE lke_rb SET nama = nmx, bobot = bbt , update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1),
		 CONCAT('Update Data RB : ',nmx,' Bobot : ',bbt), NOW());
	END IF;
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Rb_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sub_Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmsub` VARCHAR(255), `idasp` VARCHAR(255), `bbt` VARCHAR(255))   BEGIN
  
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

		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id= idasp LIMIT 1);
		IF (ada IS NOT NULL ) THEN
			SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id_aspek=idasp AND nama_sub_aspek=nmsub LIMIT 1);
			IF(ada IS NULL)THEN
				INSERT INTO lke_sub_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmsub, NOW(), NULL, idasp, bbt);
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
			UPDATE lke_sub_aspek SET nama_sub_aspek = nmsub , id_aspek = idasp ,bobot = bbt, update_at = NOW()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sub_Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Sub_Sub_Aspek_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `nmsub` VARCHAR(255), `idasp` VARCHAR(255), `bbt` VARCHAR(255))   BEGIN
  
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
				INSERT INTO lke_sub_sub_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmsub, NOW(), NULL, idasp, bbt);
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
			UPDATE lke_sub_sub_aspek SET nama_sub_sub_aspek = nmsub , id_sub_aspek = idasp ,bobot = bbt, update_at = NOW()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sub_Sub_Aspek_delete` (`uidx` VARCHAR(255), `idx` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `upload_bukti_add_edit` (`uidx` VARCHAR(255), `idx` VARCHAR(255), `idbkt` VARCHAR(255), `flnm` VARCHAR(255))   BEGIN
  
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


			INSERT INTO lke_upload_bukti VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), flnm, idbkt, NOW(), NULL, uidx);
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data File Bukti Dukung : ',flnm, ' ,bukti Dukung  : ',(SELECT id FROM lke_bukti_dukung WHERE id = idbkt) ), NOW());







	END IF;

	
	
	COMMIT;
	SELECT res, msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `User_Auth` (`usrnm` VARCHAR(255), `pswd` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `User_Cretae_new` (`uidx` VARCHAR(255), `uname` VARCHAR(255), `fname` VARCHAR(255), `pswd` VARCHAR(255), `phn` VARCHAR(255), `eml` VARCHAR(255), `rlid` VARCHAR(255), `opid` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `User_Update_data` (`uidx` VARCHAR(255), `uname` VARCHAR(255), `fname` VARCHAR(255), `phn` VARCHAR(255), `eml` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `User_update_password` (`uidx` VARCHAR(255), `pswd` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
				res,
				msg,
				(
					SELECT nama FROM lke_rb 
					WHERE lke_rb.id = a.rb_id
				) AS rb,
				a.id, 
				a.nama_aspek, 
				a.create_at, 
				a.update_at, 
				a.bobot,
				(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,

				(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id
			FROM
				lke_aspek AS a
				ORDER BY a.nama_aspek ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT nama FROM lke_rb WHERE id = idx);
		IF (ada IS NOT NULL) THEN
			SET res = 1;
				SET msg = 'success';
				SELECT
					res,
					msg,
					(
						SELECT nama FROM lke_rb 
						WHERE lke_rb.id = a.rb_id
					) AS rb,
					a.id, 
					a.nama_aspek, 
					a.create_at, 
					a.update_at, 
					a.bobot,
				
					(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
			
					(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id
				FROM
					lke_aspek AS a
					WHERE a.rb_id = idx
					ORDER BY a.nama_aspek ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET res = 1;
			SET msg = 'success';
			SELECT
				res,
				msg,
				(
					SELECT nama FROM lke_rb 
					WHERE lke_rb.id = a.rb_id
				) AS rb,
				a.id, 
				a.nama_aspek, 
				a.create_at, 
				a.update_at, 
				a.bobot,
		
				(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
				(SELECT id FROM lke_rb WHERE id = a.rb_id) AS rb_id
			FROM
				lke_aspek AS a
				WHERE a.id = idx
				ORDER BY a.nama_aspek ASC LIMIT lmtx OFFSET ofset;
				
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Bukti_dukung` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
			(SELECT indikator FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
			a.bukti_dukung, 
			a.create_at, 
			a.update_at
		FROM
			lke_bukti_dukung AS a
			ORDER BY a.bukti_dukung ASC LIMIT lmtx OFFSET ofset;
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
				(SELECT indikator FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
				a.bukti_dukung, 
				a.create_at, 
				a.update_at
			FROM
				lke_bukti_dukung AS a
				WHERE a.id = idx
				ORDER BY a.bukti_dukung ASC LIMIT lmtx OFFSET ofset;
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
					(SELECT indikator FROM lke_indikator WHERE id = a.id_indikator) AS indikator, 
					a.bukti_dukung, 
					a.create_at, 
					a.update_at
				FROM
					lke_bukti_dukung AS a
					WHERE a.id_indikator = idx
					ORDER BY a.bukti_dukung ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Dashboard_Soal` ()   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Dashboard_User` (`uidx` VARCHAR(255), `thnx` VARCHAR(255), `aprv` VARCHAR(255))   BEGIN
  
	
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET res='1';
	SET msg= 'success';
	IF (aprv = 'yes') THEN
		SELECT
			res,msg,
			a.nama AS nama_rb,
			b.nama_aspek,
			h.tahun,
			h.deskripsi,
			h.evaluasi,
			h.bataswaktu,
			'' AS tahapan,

			b.bobot AS bobot_aspek,
			d.nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			e.nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			f.indikator,
			( SELECT GROUP_CONCAT(nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = f.id ) AS parameter,
		
		
		
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
			WHERE h.tahun = thnx AND f.id IN (SELECT id_indikator FROM lke_parameter);
	ELSE
		SELECT
			res,msg,
			a.nama AS nama_rb,
			
			b.nama_aspek,
			h.tahun,
			h.deskripsi,
			h.evaluasi,
			h.bataswaktu,
			'' AS tahapan,

			b.bobot AS bobot_aspek,
			d.nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			e.nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			f.indikator,
			( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = f.id ) AS parameter,
		
		
		
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
			WHERE h.tahun = thnx AND f.id IN (SELECT id_indikator FROM lke_parameter);
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Data_List_Soal` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
			res,msg,
			a.nama AS nama_form,
			a.tahun,
			a.deskripsi,
			a.evaluasi,
			a.bataswaktu,
			b.nama AS nama_rb,
			c.nama_aspek,
			d.nama_sub_aspek,
			e.nama_sub_sub_aspek,
			f.indikator,
			f.id AS id_ind,
			g.nama_parameter,
			g.id AS id_parameter,
			g.create_at,
			a.active
			 
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			INNER JOIN lke_parameter AS g ON f.id = g.id_indikator
			ORDER BY g.create_at, nama_sub_aspek ASC LIMIT lmtx OFFSET ofset;
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
				b.nama AS nama_rb,
				c.nama_aspek,
				d.nama_sub_aspek,
				e.nama_sub_sub_aspek,
				f.indikator,
				f.id AS id_ind,
				g.nama_parameter,
				g.id AS id_parameter,
				g.create_at,
				a.active
				 
			FROM
				lke_form AS a
				INNER JOIN lke_rb AS b ON a.id = b.form_id
				INNER JOIN lke_aspek AS c ON b.id = c.rb_id
				INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
				INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
				INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
				INNER JOIN lke_parameter AS g ON f.id = g.id_indikator
				WHERE f.id = idx
				ORDER BY f.create_at, nama_sub_aspek ASC LIMIT lmtx OFFSET ofset;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_File_For_Upload` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Forms` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
	
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
			ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
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
			ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Indikator` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
			SELECT nama FROM lke_rb 
			INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS rb,
			(
			SELECT nama_aspek FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS aspek,
			
			(
			SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS nama_sub_aspek,
			
			(SELECT lke_sub_sub_aspek.nama_sub_sub_aspek FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
			WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
			) AS nama_sub_sub_aspek,
			
			a.id,
			a.id_sub_sub_aspek,
			a.indikator,
			a.create_at,
			a.update_at,
			( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br> ' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
			( SELECT GROUP_CONCAT( bukti_dukung SEPARATOR ',<br> ' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
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
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx
				 
				 
				 
		FROM
			lke_indikator AS a
			INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
			ORDER BY a.indikator ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_indikator WHERE id =idx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				a.id,
				(
					SELECT nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS rb,
				(
				SELECT nama_aspek FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS aspek,
				(
				SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS nama_sub_aspek,
				
				(SELECT lke_sub_sub_aspek.nama_sub_sub_aspek FROM lke_aspek 
				INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
				INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
				WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
				) AS nama_sub_sub_aspek,
				
				a.id_sub_sub_aspek,
				a.indikator,
				a.create_at,
				a.update_at,
				( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br> ' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
				( SELECT GROUP_CONCAT(bukti_dukung SEPARATOR ',<br> ' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
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
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx
			FROM
				lke_indikator AS a
				INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
				WHERE a.id = idx
				ORDER BY a.indikator ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_sub_sub_aspek WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					a.id,
					(
						SELECT nama FROM lke_rb 
						INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
						INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
						INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
						WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
						) AS rb,
					(
					SELECT nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS aspek,
					(
					SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nama_sub_aspek,
					
					(SELECT lke_sub_sub_aspek.nama_sub_sub_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					INNER JOIN lke_sub_sub_aspek ON lke_sub_aspek.id = lke_sub_sub_aspek.id_sub_aspek
					WHERE lke_sub_sub_aspek.id = a.id_sub_sub_aspek
					) AS nama_sub_sub_aspek,
					a.id_sub_sub_aspek,
					a.indikator,
					a.create_at,
					a.update_at,
					( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
					( SELECT GROUP_CONCAT(bukti_dukung SEPARATOR ',<br>' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
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
				 null,(SELECT ket FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx)) AS ketsx
				 
				FROM
					lke_indikator AS a
					INNER JOIN lke_Jenis_Jawaban AS b ON a.jenis_jawaban = b.id
					WHERE id_sub_sub_aspek = idx
					ORDER BY a.indikator ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Jawaban` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Jawaban_By_OPD` (IN `idx` VARCHAR(255), IN `id_opd` VARCHAR(255), IN `lmt` VARCHAR(255), IN `ofst` VARCHAR(255))   BEGIN
    
    DECLARE lmtx INT DEFAULT 200;
    DECLARE ofset INT DEFAULT 0;
    DECLARE res INT DEFAULT 1;
    DECLARE msg VARCHAR(255) DEFAULT 'success';

    
    IF (lmt REGEXP '^-?[0-9]+$') THEN
        SET lmtx = CAST(lmt AS SIGNED);
    END IF;

    IF (ofst REGEXP '^-?[0-9]+$') THEN
        SET ofset = CAST(ofst AS SIGNED);
    END IF;

    
    IF (idx IS NULL OR idx = '') THEN
        
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
        WHERE (id_opd IS NULL OR id_opd = '' OR d.id = id_opd)  
        LIMIT lmtx OFFSET ofset;
    
    ELSE
        
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
          AND (id_opd IS NULL OR id_opd = '' OR d.id = id_opd);  
    
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Jenis_Jawaban` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_List_Data_Soal_User` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255), `uidx` VARCHAR(255))   BEGIN
  
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
			b.nama AS nama_rb,
			c.nama_aspek,
			d.nama_sub_aspek,
			(SELECT COUNT(*) FROM lke_sub_sub_aspek WHERE lke_sub_sub_aspek.id_sub_aspek = d.id) AS jum_subSubaspek,
			e.nama_sub_sub_aspek,
			f.indikator,
			f.id AS ind_id,
			IF((( SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id LIMIT 1) IS NOT NULL ) AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = f.id LIMIT 1) <= 
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
 							IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0','1'),NULL) AS tombol,
							
	
			CONCAT(
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
					' / ',
				( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = f.id ) 
						) AS kemajuan  
						, IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = idx AND userid = uidx) = 'no','0',NULL) as tolak
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			ORDER BY f.create_at DESC LIMIT lmtx OFFSET ofset;
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
			b.nama AS nama_rb,
			c.nama_aspek,
			d.nama_sub_aspek,
			e.nama_sub_sub_aspek,
			f.indikator,
			f.id AS ind_id,
			IF((( SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id LIMIT 1) IS NOT NULL ) AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = f.id LIMIT 1) <= 
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
 							IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0','1'),NULL) AS tombol,

			CONCAT(
				( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = f.id AND upl.userid = uidx LIMIT 1),
					' / ',
				( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = f.id ) 
						) AS kemajuan  
						, IF((SELECT aprove FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) = 'no','0',NULL) as tolak
		FROM
			lke_form AS a
			INNER JOIN lke_rb AS b ON a.id = b.form_id
			INNER JOIN lke_aspek AS c ON b.id = c.rb_id
			INNER JOIN lke_sub_aspek AS d ON c.id = d.id_aspek
			INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
			INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
			WHERE a.id = idx AND f.id IN (SELECT id_indikator FROM lke_parameter)
			ORDER BY f.create_at DESC LIMIT lmtx OFFSET ofset;
			
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Opd` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Parameter` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
			ORDER BY a.create_at ASC LIMIT lmtx OFFSET ofset;
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
				ORDER BY a.create_at ASC LIMIT lmtx OFFSET ofset;
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
					ORDER BY a.create_at ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Penilaian_Mandiri` (`thn` VARCHAR(255), `uidx` VARCHAR(255))   BEGIN
  
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
	WHERE a.tahun = thn AND a.active = 1
	ORDER BY a.create_at;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Rb` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
	DECLARE lmtx INT;
	DECLARE ofset INT;
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE ada VARCHAR(255);
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
			a.nama,
			a.bobot,
			a.create_at 
		FROM
			lke_rb AS a
			ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
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
				a.nama,
				a.bobot,
				a.create_at 
			FROM
				lke_rb AS a
				WHERE form_id = idx
				ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
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
				a.nama,
				a.bobot,
				a.create_at 
			FROM
				lke_rb AS a
				WHERE id = idx
				ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
		END if;
	END IF;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Roles` ()   BEGIN
  
	SELECT * FROM lke_roles
	ORDER BY acs ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Sub_Aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
				SELECT nama FROM lke_rb 
				INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
				WHERE lke_aspek.id =a.id_aspek
			) AS rb,
			(
				SELECT nama_aspek FROM lke_aspek 
				WHERE lke_aspek.id =a.id_aspek
			) AS aspek,
			a.id, 
			a.nama_sub_aspek, 
			a.create_at, 
			a.update_at, 
			a.bobot, 
			(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
			a.id_aspek
		FROM
			lke_sub_aspek AS a
			ORDER BY a.nama_sub_aspek ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id from lke_sub_aspek WHERE id = idx LIMIT 1);
		IF (ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				(
					SELECT nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					WHERE lke_aspek.id =a.id_aspek
				) AS rb,
				(
					SELECT nama_aspek FROM lke_aspek 
					WHERE lke_aspek.id =a.id_aspek
				) AS aspek,
				a.id, 
				a.nama_sub_aspek, 
				a.create_at, 
				a.update_at, 
				a.bobot, 
				(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
				a.id_aspek
			FROM
				lke_sub_aspek AS a
				WHERE id = idx
				ORDER BY a.nama_sub_aspek ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id from lke_aspek WHERE id = idx LIMIT 1);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					(
						SELECT nama FROM lke_rb 
						INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
						WHERE lke_aspek.id =a.id_aspek
					) AS rb,
					(
						SELECT nama_aspek FROM lke_aspek 
						WHERE lke_aspek.id =a.id_aspek
					) AS aspek,
					a.id, 
					a.nama_sub_aspek, 
					a.create_at, 
					a.update_at, 
					a.bobot, 
					(SELECT GROUP_CONCAT(nama_sub_sub_aspek SEPARATOR '.<br>') FROM lke_sub_sub_aspek WHERE id_sub_aspek = a.id) AS sub_sub_aspek,
					a.id_aspek
				FROM
					lke_sub_aspek AS a
					WHERE a.id_aspek = idx
					ORDER BY a.nama_sub_aspek ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	
	END IF;
			
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_sub_sub_aspek` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
			SELECT nama FROM lke_rb 
			INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS rb,
			(
			SELECT nama_aspek FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS aspek,
			
			(
			SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
			INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
			WHERE lke_sub_aspek.id = a.id_sub_aspek
			) AS nama_sub_aspek,
			
			a.id, 
			a.nama_sub_sub_aspek, 
			a.create_at, 
			a.update_at, 
			a.id_sub_aspek,
			(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator, 
			a.bobot
		FROM
			lke_sub_sub_aspek AS a
			ORDER BY a.nama_sub_sub_aspek ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id from lke_sub_sub_aspek WHERE id = idx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				(
					SELECT nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS rb,
					(
					SELECT nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS aspek,
					
					(
					SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS nama_sub_aspek,
				a.id, 
				a.nama_sub_sub_aspek, 
				a.create_at, 
				a.update_at, 
				a.id_sub_aspek, 
				(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator,
				a.bobot
			FROM
				lke_sub_sub_aspek AS a
				WHERE id = idx
				ORDER BY a.nama_sub_sub_aspek ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_sub_aspek WHERE id = idx LIMIT 1);
			IF (ada IS NOT NULL) THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					(
					SELECT nama FROM lke_rb 
					INNER JOIN lke_aspek ON lke_aspek.rb_id = lke_rb.id
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS rb,
					(
					SELECT nama_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS aspek,
					
					(
					SELECT lke_sub_aspek.nama_sub_aspek FROM lke_aspek 
					INNER JOIN lke_sub_aspek on lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_sub_aspek.id = a.id_sub_aspek
					) AS nama_sub_aspek,
					a.id, 
					a.nama_sub_sub_aspek, 
					a.create_at, 
					a.update_at, 
					a.id_sub_aspek, 
					(SELECT GROUP_CONCAT(indikator) FROM lke_indikator WHERE id_sub_sub_aspek = a.id) AS indikator,
					a.bobot
				FROM
					lke_sub_sub_aspek AS a
					WHERE a.id_sub_aspek = idx
					ORDER BY a.nama_sub_sub_aspek ASC LIMIT lmtx OFFSET ofset;
			ELSE
				SET res = 0;
				SET msg = 'Data Tidak Ditemukan.';
				SELECT
					res, msg;
			END IF;
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_UploadFile` (`idx` VARCHAR(255), `uidx` VARCHAR(255), `idind` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
					ORDER BY a.Create_at ASC LIMIT lmtx OFFSET ofset;
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
						ORDER BY a.Create_at ASC LIMIT lmtx OFFSET ofset;
			
				END IF;
			END IF;
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `View_Users` (`idx` VARCHAR(255), `lmt` VARCHAR(255), `ofst` VARCHAR(255))   BEGIN
  
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
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `EncPass` (`psxc` VARCHAR(255)) RETURNS VARBINARY(255)  BEGIN
  
	DECLARE EncPs VARBINARY(255);

	SET EncPs = AES_ENCRYPT(psxc,UNHEX(SHA2('EVALUASISPBEOPD2025',256)),'', 'hkdf','JAN2025', 'DISKOMINFOSULTENG' );
RETURN EncPs;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_aspek`
--

CREATE TABLE `lke_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penilaiid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rb_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_aspek`
--

INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `penilaiid`, `rb_id`) VALUES
('72e05391085a4d9388a8f62f0bf7488e4a7646c9', 'Capaian Sasaran Strategis', '2025-06-05 11:10:52', NULL, '100', NULL, '4c0fead19e5a75ae9fd087662f9148d4496a8558');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_bobot`
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
-- Struktur dari tabel `lke_bukti_dukung`
--

CREATE TABLE `lke_bukti_dukung` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_dukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_bukti_dukung`
--

INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES
('21c3e985e73695d807032ad5a197c120d8eb1113', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP)', '2025-06-05 11:33:06', NULL),
('3bebd35d690955c3d217d82ebd8d8c718e443ba8', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API)', '2025-06-05 11:33:33', NULL),
('72b168e43ff073e7d0150380d9c1990b809648f4', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya)', '2025-06-05 11:33:18', NULL),
('78068fd61a37bb257ef92e800a0041d1fe5f1736', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001)', '2025-06-05 11:33:57', NULL),
('c712c21797d240829ea51276e0eea00bb7695487', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional)', '2025-06-05 11:33:46', NULL),
('d6a08b103b16f2f9c63d0efc447e1684db01d5fa', '67af90c1e201ce82df494bed359e38771f261c26', 'Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN ', '2025-06-05 11:34:31', NULL),
('d873f3da19916111786c65b015a5457fcda5b903', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'Domain Proses Bisnis (sampai level n dan kelengkapan metadata)', '2025-06-05 11:32:51', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_detail_opd`
--

CREATE TABLE `lke_detail_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opdid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_detail_opd`
--

INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES
('03e7da95b52f070890de6eb195569d824cb53e6d', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '056dd8b1762b5e8195fb91c3525d05b79bf6e3a2', '2025-03-13 03:42:15', NULL),
('43a3d5ed7d8be4cfe72939f234aaac54e8035ffb', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 03:11:55', NULL),
('48d7528e2ca2d3c8aaf10002a7ee98a97112e490', '660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', '81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', '2025-06-05 02:59:00', NULL),
('5d508db0e81bf8e0eae18b996b8a208e927b3300', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', '81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', '2025-06-05 02:57:19', NULL),
('8c2f59a415e0244e36e04c60d91d19729439eb84', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', '81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', '2025-06-05 03:01:06', NULL),
('c202274f678efde74a8015b24691a1945f7ac772', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'ba273eab7dc54d995b5ee2ca958b5c447f277d84', '2025-05-15 07:02:00', NULL),
('cc0bd82ca92dce73e533301b262409202d296dc5', 'c895f123acea93c7dc34d334eadf6cf086474170', '6a674853b7c5e54cd19140c17cca792811418c1b', '2025-03-13 03:41:41', NULL),
('d7337fc416527508037c7bea5b1dc7881fbcef59', 'a8dfbd890507edce5df5425d990883ad144967fd', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 04:46:43', NULL),
('dfebaec58a33ea0bfd2f9cb7282b181aa47f3e70', '08a62fdb70f816447cbb4488ed1626653233851f', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 11:09:13', NULL),
('fb96d4f1034fb8f6c55c67be2b27fb412ebd0135', 'b083d8a22edda3ceba2daed7a003569542017f94', '81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', '2025-06-05 02:48:55', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_form`
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
-- Dumping data untuk tabel `lke_form`
--

INSERT INTO `lke_form` (`id`, `nama`, `tahun`, `deskripsi`, `evaluasi`, `bataswaktu`, `create_at`, `active`, `update_at`) VALUES
('733bad7a91fcfb6ee09fd6c96b85afa00ae78712', 'Form Penilaian 2025', '2025', '-', 'Evaluasi LKE 2025', '2025-10-31 00:00:00', '2025-06-05 11:09:33', '1', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_indikator`
--

CREATE TABLE `lke_indikator` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_indikator`
--

INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES
('67af90c1e201ce82df494bed359e38771f261c26', '647efd552c9b129e2a606e4b9b127cd378de974c', 'Telah Memiliki Standar Data Statistik', '2025-06-05 11:22:59', NULL, '2908a111a94b52d770dbe8db5800d71706463811'),
('d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', 'ba910e076b957c0bce7ee6f47f67a6b62800b4ea', 'Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:17:04', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_jawaban`
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
-- Dumping data untuk tabel `lke_jawaban`
--

INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`, `aproveby`) VALUES
('a4d937e508cb87aab0428bb831106c1e1b7d94fe', '65687941cd3f37939fe5aae3357f6e91cececf66', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:38:17', '2025-06-05 11:39:20', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_Jenis_Jawaban`
--

CREATE TABLE `lke_Jenis_Jawaban` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_Jenis_Jawaban`
--

INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES
('2908a111a94b52d770dbe8db5800d71706463811', 'Skala Linear', 1, '2025-01-10 14:40:06', NULL),
('b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'Pilihan Ganda', 4, '2025-01-10 14:32:35', NULL),
('cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'Ya/Tidak', 2, '2025-01-16 13:39:02', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_logs`
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
-- Dumping data untuk tabel `lke_logs`
--

INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES
('00a435cf028dcc730bec04e8185cfb3bc37e9924', '2025-06-05 11:10:15', 'INSERT', 'soal', 'Tambah Data RB : RB General pd Bobot : 100', '2025-06-05 11:10:15'),
('021b2dfbda7c4543c6a44b018c9ad98b989b8e1a', '2025-06-05 12:16:57', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 12:16:57'),
('02783befd5447b0dea471c72bb7de838271edef1', '2025-06-06 19:55:21', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-06 19:55:21'),
('03a0b89977124d94f0b47d89aecde79292e97680', '2025-05-14 13:18:06', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-14 13:18:06'),
('04fbfb4afdf236404f40e341a73378cfc184ab25', '2025-06-05 11:58:08', 'UPDATE', 'soal', 'Update Data Sub Sub Aspek : 1.3. Penyelenggaraan Statistik Sektoral Bobot : 20', '2025-06-05 11:58:08'),
('05f68b43c0304a5612a734bd76c57c1825681cf4', '2025-05-15 13:26:24', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 13:26:24'),
('06d8ffebf531ba95796ea5a740941e4a59329fa3', '2025-06-05 11:38:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1749094730_52af81e14ae5d4a2d97f.xlsx ,bukti Dukung  : d873f3da19916111786c65b015a5457fcda5b903', '2025-06-05 11:38:50'),
('0700ed6b272ec7858a327e304dd57789ea45a17f', '2025-05-23 13:09:24', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-23 13:09:24'),
('0718612d325a724112ff245077356abad4ba8168', '2025-06-05 11:04:54', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 11:04:54'),
('07ddcd553eccc3dff43e0553c46d2a02ecfb8bd5', '2025-05-15 11:37:05', 'UPDATE', 'madani', 'Update Data Jawaban : 9d2a1dfcbc89b0fc46cae6c8c3918bbe4855c9dfParameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-05-15 11:37:05'),
('08032618e102e14d45bf8fdf65107b42b3536f4f', '2025-03-13 11:32:40', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-03-13 11:32:40'),
('0839e5f6e11197dd2ac468f3ca5568fd117043f5', '2025-03-13 12:46:43', 'UPDATE', 'penilai', 'UPDATE Password User  : penilai Full Name : PENILAI', '2025-03-13 12:46:43'),
('0bb7999eab59e54a147c8c8b3dde073c16678f7d', '2025-03-13 12:46:51', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 12:46:51'),
('0ca15a8230d119105f67fbad97b512e72226809d', '2025-06-05 12:37:23', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-05 12:37:23'),
('0d2e6ec3bdde06021d6c6a74cee97766c9ab6506', '2025-06-05 11:33:46', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:33:46'),
('0eb3ace95447c9a4cd717bd6ac2882f162c576e7', '2025-03-13 12:37:46', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:37:46'),
('0ed8c788b5032b855524f8c041ed33161f5cd01e', '2025-05-14 13:27:59', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-05-14 13:27:59'),
('0fbd34ed771730bf5311ff5ff7d93d0dfaaaca4f', '2025-03-13 11:12:14', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 11:12:14'),
('0fda2fb7ef8bf8d2f6830311f6c83fa3300c9ff0', '2025-03-13 11:42:15', 'UPDATE', 'madani', 'UPDATE Password User  : madani Full Name : MADANI', '2025-03-13 11:42:15'),
('1077f859e212c94fbd8a22f2b1d2a2e0061c4314', '2025-05-15 11:11:55', 'INSERT', 'madani', 'Tambah Data Jawaban : 9d2a1dfcbc89b0fc46cae6c8c3918bbe4855c9dfParameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-05-15 11:11:55'),
('12f7898e94f7f21bdc71413c5f244d49d6c4dbd3', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data Jawaban : 73beda09404211b0a1d7257e9a117d681c747953Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-03-13 12:01:24'),
('15132046f84ab34f89c9efb308e84ed1eb1c5858', '2025-03-13 11:38:06', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:38:06'),
('15f9c54ba144a18f97d84ca3f11c83b6c143e840', '2025-03-13 11:12:22', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-03-13 11:12:22'),
('165a3218af80fc768bfedad20276338d54b18153', '2025-05-15 11:28:10', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:28:10'),
('16c3ce86c4078b4f7d64c138c8fd1baff8c97fe8', '2025-06-06 16:36:15', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-06 16:36:15'),
('177e384592ef5e620e80b5792cb64deee0fc4362', '2025-06-04 23:17:56', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-04 23:17:56'),
('17bbca3c27c17b81675a4104935daf79d152dcdc', '2025-06-09 10:16:51', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-09 10:16:51'),
('1a15bfd7773f9a1ca040cd7460cde4c998494345', '2025-06-05 09:13:12', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 09:13:12'),
('1a1b29a71870ad01ceceb825250301dfcfad1b15', '2025-06-05 11:32:51', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Proses Bisnis (sampai level n dan kelengkapan metadata) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:32:51'),
('1a1f6723f6109e4514538ebde479581ea8d46946', '2025-06-05 11:49:40', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 11:49:40'),
('1d1eeee66e7bc9048b3f608f376e8cc29ab7b613', '2025-03-13 11:42:31', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-03-13 11:42:31'),
('1d8206cd8a1d59b7a75e96896ac1eea20a11c98c', '2025-03-13 12:02:23', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-03-13 12:02:23'),
('2288f6b67d62f612adc0794afb9ee390066e8d99', '2025-03-13 12:02:48', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:02:48'),
('2338ae9bba624fa8ff03e004fd2e69ce74ac5086', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_2f8ac6a9281c5ba7bc05.pdf ,bukti Dukung  : 1dbb0abcd298b6c9eb7bd73a5952d6477772fc5f', '2025-03-13 12:01:24'),
('2349abf7fd32ab2085996df0579e16306039c892', '2025-03-13 11:24:17', 'INSERT', 'soal', 'Tambah Data RB : RB TEMATIK PERANGKAT DAERAH Bobot : 35', '2025-03-13 11:24:17'),
('2470545262b0d3f9aa9ca08843b3153d041e340c', '2025-05-14 13:18:16', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-14 13:18:16'),
('248fb728f75680b94975f72249511c23cfa3c329', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_a2cab1e21f79e0806550.png ,bukti Dukung  : 7dae0b13cc5cc2e0eea1ce0b22bd7d966ef85970', '2025-03-13 12:01:24'),
('2613d18680e1243ca37a418edefc3718eab31698', '2025-06-05 11:39:20', 'UPDATE', 'madani', 'Update Data Jawaban : 65687941cd3f37939fe5aae3357f6e91cececf66Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:39:20'),
('276cfd6c0829e9553d80e4de15189e964e6526ce', '2025-06-05 09:48:12', 'INSERT', 'soal', 'Tambah Data Indikator : Telah Mengalokasikan Anggaran Pelaksanaan SPBE Setiap Tahunnya', '2025-06-05 09:48:12'),
('29ef5802631a8740f70077c3b5ee62f401d8fd47', '2025-05-15 10:52:35', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 10:52:35'),
('2a8bd0b73e0d07ff94091721761900b6837a42a5', '2025-06-05 11:06:07', 'DELETE', 'admin', 'Hapus Data RB  : RB TEMATIK PERANGKAT DAERAH', '2025-06-05 11:06:07'),
('2cb5d906a1546b8598bac0e2e16e69e5648c0b13', '2025-05-15 15:06:58', 'LOGIN', 'USER', 'User Login :dprd', '2025-05-15 15:06:58'),
('2e96a5e1273aeb70c889d6be9c6dd97051a2e585', '2025-06-05 11:06:20', 'DELETE', 'admin', 'Hapus Data Form  : F-SPBE-01', '2025-06-05 11:06:20'),
('2ec2b82a669308ad5c9706ab7e47a584074b22c4', '2025-06-05 11:33:57', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:33:57'),
('2fce99b3361e2598522f12b0c98f2b042030c8d5', '2025-06-05 10:25:29', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:25:29'),
('33a554b98a1bfa8937b37d5dadbacdc579e898bb', '2025-05-15 15:02:00', 'UPDATE', 'dprd', 'UPDATE Password User  : dprd Full Name : dprd', '2025-05-15 15:02:00'),
('33d68ba582a2a39210285bf49eff28c92df56257', '2025-06-07 01:57:51', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-07 01:57:51'),
('341cd356794bfc171fd110a27f5cc61d970640fe', '2025-03-13 11:24:58', 'ERROR', 'System', 'add Aspek :Unknown column \'tahun\' in \'where clause\'', '2025-03-13 11:24:58'),
('346fc8f4b0aa096728b1ea88de8480eeec91d804', '2025-06-05 11:53:42', 'LOGIN', 'USER', 'User Login :sultan sirajuddin', '2025-06-05 11:53:42'),
('370cc2790b64dce3cab2d9d5629142b33741eae2', '2025-05-15 11:03:33', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 11:03:33'),
('3764e5287f4c490484f6b23cf615c6c16f1ffdb6', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_87d79e1d65ae42a1cbf5.jpg ,bukti Dukung  : 0665675915f6dab5d875f7f229f7acd906f15b23', '2025-03-13 12:01:24'),
('37d8976b6129aaf430c33241f9749a994eb7441c', '2025-03-13 11:38:21', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:38:21'),
('385ecce2d1c703a34b76be51df30468c29d7a962', '2025-03-13 11:38:30', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-03-13 11:38:30'),
('38ef711819b72290cdeec8bb70f0109d62eae91d', '2025-06-06 20:07:57', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-06 20:07:57'),
('3950ca971c2f06c057d834c0f32fbf02f477a536', '2025-06-05 11:04:47', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 11:04:47'),
('39b578f780b21e63288cd24f2d60fef901bbbf4d', '2025-05-15 14:39:21', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 14:39:21'),
('3ab2d44d264d07abeec9f09c3752b3bdfdc1aee7', '2025-05-15 14:38:22', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 14:38:22'),
('3d328f54c15705e4098209c079223479505ec742', '2025-05-15 13:30:31', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-05-15 13:30:31'),
('3e6b117d71c3ffeb2da57624c443aea41ae1b313', '2025-06-05 12:34:00', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 12:34:00'),
('3f4062ff24a6d91b739794d702dcf9ae0f10e6e4', '2025-06-05 11:33:06', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:33:06'),
('3f874923c586726fce0717dbc09664690af8c7b9', '2025-06-05 09:16:32', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 09:16:32'),
('3ffda33d359288fc8a8262782d0f517a95dfeb7e', '2025-06-05 12:13:09', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 12:13:09'),
('418630e5c62696e6ba9f2bcf860b00e01f3f5a6f', '2025-03-13 11:42:22', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 11:42:22'),
('41d2140ed451f785fcef1b98f67607a2b9171e10', '2025-03-13 11:31:33', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-03-13 11:31:33'),
('4301af8b9fc8901a7ad7a4da9f111f79a7bc0c60', '2025-05-23 13:07:42', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-23 13:07:42'),
('43c70ca92450569699429070299319f54d42fdf0', '2025-03-13 12:03:15', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-03-13 12:03:15'),
('450b0c0d05c04110b7553b5fb8f7e9e8da578194', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_e63fe719336474f447d2.png ,bukti Dukung  : 089b2bd74d106ef34028d6bd1dd70f2efc238838', '2025-03-13 12:01:24'),
('48da4b1f1185b22655184c3898aedcf2e264d839', '2025-05-15 13:03:04', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 13:03:04'),
('4a03dfb9a80f3f797b37f2cbbc15c7980c5782fb', '2025-05-15 15:00:39', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 15:00:39'),
('4c8dbb86d97b2d28de1bc5da332a5e48a20603c4', '2025-03-13 12:04:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838690_79f3b905065f07ad5cbc.xlsx ,bukti Dukung  : 0665675915f6dab5d875f7f229f7acd906f15b23', '2025-03-13 12:04:50'),
('4cea7b057d96e52a9a4181d0a96d67ebaa8cab5e', '2025-05-15 11:04:42', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 11:04:42'),
('4e93dc6dfb61a964c2c9d8acf7c680ba0d89ac42', '2025-03-13 11:37:48', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:37:48'),
('4fd2d07d6b183c7b60da5b600cab365528bed502', '2025-05-15 11:26:20', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:26:20'),
('5239f755745d7153234a7a39d1d5429be41c280c', '2025-06-05 11:20:09', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-06-05 11:20:09'),
('524d93e58e1fcc5b97f1368415178c15a608f04d', '2025-06-05 11:38:50', 'UPDATE', 'madani', 'Update Data Jawaban : 65687941cd3f37939fe5aae3357f6e91cececf66Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:38:50'),
('525f3d5b3051ba312b2293f8a9aed070e9c238f7', '2025-05-15 10:52:44', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 10:52:44'),
('57625b1233e421fab64ee1df8ca05bef9606321b', '2025-03-13 12:16:19', 'INSERT', 'madani', 'Tambah Data Jawaban : 9d2a1dfcbc89b0fc46cae6c8c3918bbe4855c9dfParameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-03-13 12:16:19'),
('58886d2fd6b0d9d332586134cc42897dc3fccc4b', '2025-06-06 22:53:38', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-06 22:53:38'),
('58e875dac23e11d35baac8dbaa39aebdb2a53500', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_4bcf7a782d7eff2f1c24.jpg ,bukti Dukung  : 9b8e9c13774632cff36e912434164de3b415fde2', '2025-03-13 12:01:24'),
('5a556c44b4d5da7c2229c5bd40495df567453e7d', '2025-05-23 13:04:06', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-23 13:04:06'),
('5a7fc87071c4e2c6348183d1b5555c33680a2a6c', '2025-06-05 09:06:36', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 09:06:36'),
('5acf2f033459f1aecbb52c09df70219019ac7e8b', '2025-05-15 14:37:57', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 14:37:57'),
('5b3b7ab03a1eb125c6bbb716b82987b9862864d6', '2025-03-13 11:03:38', 'ERROR', 'System', 'add user :Column count doesn\'t match value count at row 1', '2025-03-13 11:03:38'),
('5b439e1752949ce7c7acbd209248e0ceccdb6853', '2025-03-13 11:04:31', 'ERROR', 'System', 'add user :Column count doesn\'t match value count at row 1', '2025-03-13 11:04:31'),
('5d86f39e958bffdc587db1fbe8b0fb738ecf3ed3', '2025-06-05 10:59:00', 'UPDATE', 'muftyabyan', 'UPDATE Password User  : muftyabyan Full Name : muhammad mufti abyan', '2025-06-05 10:59:00'),
('5d8dfd030989b2f227a7fbe60a33418b6f1b97e0', '2025-05-15 15:27:21', 'LOGIN', 'USER', 'User Login :dprd', '2025-05-15 15:27:21'),
('5ed27b9c5a3cc57890dfaddbdbc6e8de3afc4e5d', '2025-05-15 11:33:20', 'UPDATE', 'madani', 'Update Data Jawaban : 73beda09404211b0a1d7257e9a117d681c747953Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-05-15 11:33:20'),
('5fb2751a602b37a220b23bb7cde1c1fbe5e3eebc', '2025-06-05 09:07:14', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 09:07:14'),
('5fd3d9f384cefd988faff842c3d30129c859b366', '2025-03-13 14:58:57', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-03-13 14:58:57'),
('610cbe23f2e0e813286293130274024458dd2dcb', '2025-06-05 11:04:26', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 11:04:26'),
('63489fc748caf440de9bc63d651481dd42723ef7', '2025-05-23 13:08:37', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-23 13:08:37'),
('64d5c56dd5758b93bd612f5fd1f8359af08dfa2a', '2025-05-15 14:37:45', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 14:37:45'),
('6603f7a56d64284011822311572854d174e8dbea', '2025-05-23 13:06:29', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-23 13:06:29'),
('668300e9a41bad6fdda8aac0ea89d5812e4377e9', '2025-06-05 11:06:12', 'DELETE', 'admin', 'Hapus Data RB  : RB GENERAL PD', '2025-06-05 11:06:12'),
('68048ebbf91fd2f8585b0953c2bcbe97a7c67f94', '2025-03-13 11:34:20', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:34:20'),
('6808eac7ec0291f72f863a0e7393d95fa5008f26', '2025-03-13 11:33:07', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-03-13 11:33:07'),
('69b382de9909f4b33742ce7adf8425ee830c4904', '2025-06-05 10:48:55', 'UPDATE', 'rb_renaksi', 'UPDATE Password User  : rb_renaksi Full Name : Mohammad azim purwana ', '2025-06-05 10:48:55'),
('6a173373e108a201ada026b9c4fab98cb462edbd', '2025-03-13 11:30:59', 'INSERT', 'soal', 'Tambah Data Indikator : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-03-13 11:30:59'),
('6a55eaa3d129a80d8f2cc8cd8704dd7e4fc3bbc6', '2025-06-05 10:19:09', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:19:09'),
('6ba55cc098f168196fafdb25a9c5fc9ca2b417a7', '2025-05-15 10:55:58', 'INSERT', 'madani', 'Tambah Data Jawaban : 73beda09404211b0a1d7257e9a117d681c747953Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-05-15 10:55:58'),
('6c313f8e24f5f6ca1b7469c9e552f65d8aa0f897', '2025-03-13 11:10:22', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 11:10:22'),
('6ff934b61034ff8350f9b9e79540605f08874574', '2025-06-05 11:05:33', 'DELETE', 'admin', 'Hapus Data Indikator  : Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-06-05 11:05:33'),
('71fb87eb97aca588853aec6a008cc269b8b15abd', '2025-06-05 10:31:11', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:31:11'),
('721d0e6f8fc884047437693002d23e41254a17e7', '2025-05-15 12:59:53', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 12:59:53'),
('722516a793bf3f4ff8368dffed1ac11805e0caa6', '2025-06-05 09:23:21', 'INSERT', 'soal', 'Tambah Data Parameter : Terdapat Dokumen Peta Rencana (Roadmap) SPBE', '2025-06-05 09:23:21'),
('73a4d36bce57d1d5763040cfecdf90faf0fdee23', '2025-05-15 11:37:33', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 11:37:33'),
('74c1d7dd0ec2b3ec8960457401eed0e75cea5eda', '2025-05-15 13:30:24', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-05-15 13:30:24'),
('74f96b1e7dd6426b66c9d8f6ae6f254c97ab5c51', '2025-05-15 13:30:16', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 13:30:16'),
('76fd3436be71bd9c0d46ec5bea9c29563921453f', '2025-05-15 13:11:50', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 13:11:50'),
('77177f3e54d9efa67efef51c0f316c642731aeee', '2025-03-13 11:27:22', 'INSERT', 'soal', 'Tambah Data Aspek : Capaian Sasaran Strategis Bobot : 36', '2025-03-13 11:27:22'),
('77cc081f8d8607cd8ca4710d485b80a1848782fd', '2025-05-15 13:44:44', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 13:44:44'),
('787486b09562d26148868727ccfe8be8bb26ccf4', '2025-05-15 11:38:34', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 11:38:34'),
('78e440a57eebb0fce0ca7d5b865041aabdd5efd7', '2025-03-13 12:04:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838690_65d388ebe1866f099400.jpg ,bukti Dukung  : 9b8e9c13774632cff36e912434164de3b415fde2', '2025-03-13 12:04:50'),
('7a22408084cdc480622a1a54ce28477bacb5f61d', '2025-06-05 11:05:52', 'DELETE', 'admin', 'Hapus Data Sub Aspek  : Tingkat Kematangan SPBE Perangkat Daerah', '2025-06-05 11:05:52'),
('7b1bddde13bb9835afafe43c58d467635f2e0e67', '2025-03-13 12:03:36', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-03-13 12:03:36'),
('7b7b7b6095e9a93083a01d1422d643e482b9ae91', '2025-05-15 11:30:26', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:30:26'),
('7d8bbbb7c656683bc0b9bb217cf31ef76cf08c7e', '2025-03-13 12:04:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838690_2d0c9d7a1957da026252.jpg ,bukti Dukung  : 7dae0b13cc5cc2e0eea1ce0b22bd7d966ef85970', '2025-03-13 12:04:50'),
('7de971ba74de6528c307762756b87a5df0510a04', '2025-06-07 00:57:22', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-07 00:57:22'),
('81867b62c6eb1af6b7be7e3c92978aa7a7a4da53', '2025-06-05 11:19:42', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-06-05 11:19:42'),
('81a7e49cf37adcc1c2d3b1e9ba74b89930c00a27', '2025-03-13 11:02:46', 'ERROR', 'System', 'add user :Column count doesn\'t match value count at row 1', '2025-03-13 11:02:46'),
('81fe940e837c26ae9bcfa27789221ac748a30441', '2025-06-06 23:56:31', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-06 23:56:31'),
('83a305a578946de80768738f9d361a046c825ec2', '2025-06-05 11:18:45', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-06-05 11:18:45'),
('83ee35a32129b2473deaf52f4cd6c42e9ca35a4e', '2025-03-13 12:56:41', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:56:41'),
('854a9cf981a3fb27f481a8ec52eca89c52378274', '2025-05-15 11:37:44', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 11:37:44'),
('87895066b1e793a521d4b3100ac1df76d5ab73d3', '2025-03-13 12:07:12', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838832_f1ca55ada9dd9f05e8ef.png ,bukti Dukung  : 1dbb0abcd298b6c9eb7bd73a5952d6477772fc5f', '2025-03-13 12:07:12'),
('87fc319b0c01e18970f5e2c80dd8d49dafe35e7e', '2025-06-05 10:13:46', 'DELETE', 'admin', 'Hapus Parameter  : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-06-05 10:13:46'),
('88333a14fccb652d7b1034c469f7eac24afd8ae6', '2025-03-13 12:04:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838690_4dbaaf13493420f80567.jpeg ,bukti Dukung  : 5063552ad731cd4f4e539c3a7983b9670b44e5c6', '2025-03-13 12:04:50'),
('885c59aa6d697faf40c90a863199038565c35d0a', '2025-05-23 13:12:16', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-23 13:12:16'),
('8c1c645759c76e27e74826bd0c1d1eaf7ffb03d7', '2025-06-05 11:22:06', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Penyelenggaraan Statistik Sektoral Bobot : 20', '2025-06-05 11:22:06'),
('8c62706953da6889d876d6145ff4aa84bf23f6d5', '2025-06-05 14:13:42', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 14:13:42'),
('8cb6e0f709d28b927b0cabfab4f627f26bd9c537', '2025-06-05 11:01:07', 'UPDATE', 'sultan', 'UPDATE Password User  : sultan Full Name : sultan sirajuddin', '2025-06-05 11:01:07'),
('8cde425129a607a23c32c956e09d4588f58a8b43', '2025-03-13 12:01:24', 'INSERT', 'undata', 'Tambah Data File Bukti Dukung : 1741838484_b90d5479bdd36dc90ca2.jpg ,bukti Dukung  : 5063552ad731cd4f4e539c3a7983b9670b44e5c6', '2025-03-13 12:01:24'),
('8f0ffc9db197037e9675ebaa507ef43b40e2bd85', '2025-03-13 11:38:40', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 11:38:40'),
('8f1168c6b4d8b8c50b6c94c315714ab057b95dfb', '2025-06-05 11:05:29', 'DELETE', 'admin', 'Hapus Data Indikator  : Telah Mengalokasikan Anggaran Pelaksanaan SPBE Setiap Tahunnya', '2025-06-05 11:05:29'),
('90cdae2ccac4687bbceef7a5ce278b486f1f2ea5', '2025-06-05 11:12:11', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-06-05 11:12:11'),
('926f970580a755689a6e78e88a46f6a6322fd515', '2025-05-15 13:27:00', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 13:27:00'),
('92d58c8a0ef2ae852174c907d8fbfc9653412365', '2025-06-05 11:23:33', 'INSERT', 'soal', 'Tambah Data Parameter : Telah memiliki standar data statistik yang lengkap untuk semua Indikator Kinerja Utama (IKU) yang diampu dinas Rumus: (Jumlah IKU yang memiliki standar data dibagi jumlah total IKU) * 100%', '2025-06-05 11:23:33'),
('9383a3f0833be795c62a63df0ef6c439b0761beb', '2025-03-13 11:33:58', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Proses Bisnis (sampai level n dan kelengkapan metadata) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:33:58'),
('96debe43e9ca909a697a32f3b7df0f73635248c5', '2025-03-13 12:46:59', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-03-13 12:46:59'),
('980eb2fa25269f0b7a1d6a2f56ed731285593f57', '2025-05-15 14:37:27', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 14:37:27'),
('9936c48645f3f780abdd8567cff08846b029e4e4', '2025-05-14 13:29:16', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-05-14 13:29:16'),
('99cb09b6550dcc570646b4e76ee60ed2f48a59a2', '2025-06-05 09:07:18', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 09:07:18'),
('9a5763c039bc48f6b477993ece42b46bc60e91d0', '2025-05-15 15:02:13', 'LOGIN', 'USER', 'User Login :dprd', '2025-05-15 15:02:13'),
('9cd53e5f745c7a40f60da1770557a6e1bcf06805', '2025-05-15 15:01:03', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 15:01:03'),
('9f2737635a17416ceb2aeecda53808fc74683ea3', '2025-06-05 14:13:44', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 14:13:44'),
('a1f23cca8a0f10fb2ade97cb857a51dbd73155af', '2025-05-15 13:00:20', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 13:00:20'),
('a2ce5e32905336634f8d4d63a1f8afced9485c9e', '2025-06-05 12:34:09', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 12:34:09'),
('a36e7feab2b3559217a9489d1d020fb2e320dea5', '2025-06-05 11:06:01', 'DELETE', 'admin', 'Hapus Data Aspek  : Capaian Sasaran Strategis', '2025-06-05 11:06:01'),
('a4d592247fa16139bbfbfbadacdd73f6ea30227f', '2025-06-05 11:38:17', 'INSERT', 'madani', 'Tambah Data Jawaban : 65687941cd3f37939fe5aae3357f6e91cececf66Parameter : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:38:17'),
('a70c40cfa0dff0c19b2f3bda28566019a622e87f', '2025-06-05 11:34:31', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Dokumen standar data IKU Perangkat Daerah yang sesuai dengan Peraturan BPS no. 4 Tahun 2021 tentang SDSN  ,Indikator  : 67af90c1e201ce82df494bed359e38771f261c26', '2025-06-05 11:34:31'),
('a877ffc4815b3aff5dff14bc989d076bd1d2b4a8', '2025-03-13 12:45:17', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:45:17'),
('a878f2e691182ad16008f4061d893f73ab913134', '2025-05-15 11:32:24', 'ERROR', 'System', 'add Jawaban :Unknown column \'nli\' in \'field list\'', '2025-05-15 11:32:24'),
('a8e1b4c744f46bbdc3cd8b4914058769c5fab500', '2025-03-13 11:23:46', 'INSERT', 'soal', 'Tambah Data RB : RB GENERAL PD Bobot : 65', '2025-03-13 11:23:46'),
('a9f31b8458182ed887019dedb092053c27ceb29b', '2025-05-23 13:07:51', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-23 13:07:51'),
('ab45bb05769d38632ba3eb8a88521980a9916582', '2025-03-13 11:09:13', 'INSERT', NULL, 'Tambah Data Berhasil : admin Full Name : super admin', '2025-03-13 11:09:13'),
('acb27ce60776d8bc3a712003097430aab0fda04f', '2025-05-15 13:26:45', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 13:26:45'),
('adb2039311e9845cd6bf569511a6428700a8b578', '2025-05-15 15:27:11', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 15:27:11'),
('ae37723400b108464e53806ef4662e8bf8f0e4dd', '2025-05-23 13:08:45', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-23 13:08:45'),
('afd0455db8138061f184efc529681cc98a097a67', '2025-05-15 11:30:37', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:30:37'),
('b0858352ef40ca92714ce400d29bc20ee70e9d17', '2025-06-05 10:13:58', 'DELETE', 'admin', 'Hapus Parameter  : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-06-05 10:13:58'),
('b182deb45fc46c77f34e842acf30379637af9082', '2025-06-05 11:33:33', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:33:33'),
('b1b508b8b6be2be750ea17866e35924154bbcfea', '2025-05-15 13:26:52', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 13:26:52'),
('b20f460cfe276253936803366883af5e977fd3e1', '2025-06-05 09:21:21', 'INSERT', 'soal', 'Tambah Data Indikator : Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-06-05 09:21:21'),
('b3912efb94522272540733cc5466af21605f8aff', '2025-05-15 11:03:21', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 11:03:21'),
('b5114febbed0a15dbb32364cf0dda6365513dbce', '2025-05-23 13:12:08', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-23 13:12:08'),
('b5c6e22aefd1f55a995012c0126b28d0f94a72b0', '2025-03-13 12:03:46', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:03:46'),
('b625a9c5daf1c090bc507aafc74b6301ecfcffe4', '2025-03-13 12:45:26', 'LOGIN', 'USER', 'User Login :super admin', '2025-03-13 12:45:26'),
('bb06eb6551a396cc75e6f0de8b4460d7f94130ef', '2025-05-15 15:07:07', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-15 15:07:07'),
('bbc8d5c759a2562b536c756eca37eb2dc1f8d83e', '2025-06-05 12:37:17', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-05 12:37:17'),
('bc110d2032f621ee7c3590fefbb375c61b10cecb', '2025-03-13 12:03:06', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:03:06'),
('bc6555e417b5f8090f9b46697e173a58764b56e9', '2025-03-13 11:34:43', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya) ,Indikator  : 9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:34:43'),
('bc694ee4837513a69577ce370a4beca81e5667b0', '2025-06-04 17:16:42', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-04 17:16:42'),
('bf0b5ba6f83007d4ef174f4b85eca1f315f5f168', '2025-06-05 11:10:52', 'INSERT', 'soal', 'Tambah Data Aspek : Capaian Sasaran Strategis Bobot : 100', '2025-06-05 11:10:52'),
('bfc92fe45ec0957274660654dc452d6c9445106a', '2025-03-13 11:17:14', 'INSERT', 'soal', 'Tambah Data Form : F-SPBE-01 Tahun : 2025', '2025-03-13 11:17:14'),
('c01d7730078fbb6cad6f935e1e886c976a939a65', '2025-05-15 14:38:45', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 14:38:45'),
('c0439051ca5f2759c7236e1428377cd574c9ae71', '2025-06-05 11:05:37', 'DELETE', 'admin', 'Hapus Data Indikator  : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:05:37'),
('c31f91c0e377a8eaad3d52f588f21620b26feccf', '2025-06-08 22:37:11', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-08 22:37:11'),
('c4a89ecdb58effbdc1c1c05aea1cc2ac158a475d', '2025-05-15 11:38:44', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 11:38:44'),
('c5201c61538d40efaf6aea0811fe3dde97ad4c5c', '2025-03-13 11:11:55', 'UPDATE', 'soal', 'UPDATE Password User  : soal Full Name : Pengisi Soal', '2025-03-13 11:11:55'),
('c591f06f3199c5022ebc5e3857d3680e2944554e', '2025-05-15 11:30:11', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:30:11'),
('c64e7346be1a1be236cca60557ac68ea39c43d54', '2025-06-05 10:10:48', 'DELETE', 'soal', 'Hapus Parameter  : Terdapat Dokumen Peta Rencana (Roadmap) SPBE', '2025-06-05 10:10:48'),
('c6bf250b612b274bbeac151a8ec67e3f90f3b4f9', '2025-06-04 17:16:18', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-04 17:16:18'),
('c71138a540fbe82837d30eae9dd4a675f3721451', '2025-06-05 10:13:52', 'DELETE', 'admin', 'Hapus Parameter  : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-06-05 10:13:52'),
('c71337d8636fe07ffcaab1dbf940bdd044f11480', '2025-06-05 11:33:18', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya) ,Indikator  : d97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:33:18'),
('c7cdfebc1d6390e5c04d70c7aa481103e480a011', '2025-05-15 14:38:10', 'LOGIN', 'USER', 'User Login :UNDATA', '2025-05-15 14:38:10'),
('cab562b374d123e5f417255a32da4bb430a0e530', '2025-05-14 13:17:43', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-14 13:17:43'),
('cb383f54cac7afb8ca632371742e382c670ae08e', '2025-06-05 12:00:16', 'UPDATE', 'soal', 'Update Data Sub Sub Aspek : 1.1. Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-06-05 12:00:16'),
('cd991e283f15f01ac554c4f31c36c5851b1ccbcd', '2025-06-05 11:15:27', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-06-05 11:15:27'),
('ceca11cd51dcd1277f540e2029303a8b75b37a27', '2025-05-15 11:28:58', 'ERROR', 'System', 'add Jawaban :Unknown column \'idprmt\' in \'where clause\'', '2025-05-15 11:28:58'),
('d0bd8ffd06e482849f483ac3e3d1e1b068c67fa5', '2025-03-13 12:56:27', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-03-13 12:56:27'),
('d1013c4a72211e37aad4051390d127bfc229e98d', '2025-06-05 11:39:20', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1749094760_064bae64b9362cf084fb.xlsx ,bukti Dukung  : 21c3e985e73695d807032ad5a197c120d8eb1113', '2025-06-05 11:39:20'),
('d2f96117784a3953fbc693cda656d02d561ced85', '2025-05-15 11:04:34', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 11:04:34'),
('d356bc1d1e24e1a1e6ff1c7534bff211c4f0fed7', '2025-06-05 11:04:25', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 11:04:25'),
('d469f557811a1dfb66b64a5733ae9aba3ddc4ed7', '2025-03-13 12:58:27', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:58:27'),
('d5ca0927989ef18bc78b9ae16313d5f4f8d190b1', '2025-05-23 13:06:21', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-23 13:06:21'),
('d61f4bd5db5f8dd1bf6f212b9825a2ddf3fbcdd0', '2025-03-13 11:28:00', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 6', '2025-03-13 11:28:00'),
('d6511976adc1f77455052fc19836b3b374c763aa', '2025-05-15 13:04:07', 'LOGIN', 'USER', 'User Login :PENILAI', '2025-05-15 13:04:07'),
('da92e89a95076cfab1012e107f3dd3b7f029ee0e', '2025-06-05 11:17:04', 'INSERT', 'soal', 'Tambah Data Indikator : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-06-05 11:17:04'),
('dbb0e46494261cade9d3f3fb48dcc1eb0e5b9757', '2025-06-05 11:05:45', 'DELETE', 'admin', 'Hapus Data Sub Sub Aspek  : Tingkat Kematangan Kapabilitas Proses', '2025-06-05 11:05:45'),
('dee461eecb65b2d0487c2409c262cb56344cedd2', '2025-06-05 10:11:57', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:11:57'),
('df140270275c127d886e6c6490106a567ca1a156', '2025-06-05 11:09:33', 'INSERT', 'soal', 'Tambah Data Form : Form Penilaian 2025 Tahun : 2025', '2025-06-05 11:09:33'),
('df2d7adaa8653b9b940c5d3ad939edda113d8abe', '2025-06-04 17:16:25', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-04 17:16:25'),
('e0e299cc6b2df4724e692989dc28ef0f25c77b66', '2025-05-15 15:02:05', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 15:02:05'),
('e2f389f16e66c7aa3cbf83204828a6a31dbf43a1', '2025-05-15 13:44:49', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 13:44:49'),
('e89ed7008d3d6e45ee8dbfef3e2240aabc105351', '2025-06-05 12:37:12', 'LOGIN', 'USER', 'User Login :Mohammad azim purwana ', '2025-06-05 12:37:12'),
('e926b8ddfb0ba05388da1ea5519e42ad42c12c37', '2025-05-15 10:51:13', 'LOGIN', 'USER', 'User Login :super admin', '2025-05-15 10:51:13'),
('e972248a4db3badf7f07277952c834d4c510606c', '2025-03-13 12:04:50', 'INSERT', 'madani', 'Tambah Data File Bukti Dukung : 1741838690_a78082a95b9c93d02d54.png ,bukti Dukung  : 089b2bd74d106ef34028d6bd1dd70f2efc238838', '2025-03-13 12:04:50'),
('ec0832fd32aa8ddb53a05d299e04aed822f5f228', '2025-06-06 20:08:10', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-06 20:08:10'),
('ed7ecf7ac3759efe03df722b4ce1d48212f0900d', '2025-06-05 11:22:59', 'INSERT', 'soal', 'Tambah Data Indikator : Telah Memiliki Standar Data Statistik', '2025-06-05 11:22:59'),
('ed977ee3890f27356eec42f21d87c129b4828880', '2025-06-05 10:57:19', 'UPDATE', 'budker', 'UPDATE Password User  : budker Full Name : Irfan', '2025-06-05 10:57:19'),
('ef0058515b70ed4ef815bb5abd05585229591425', '2025-05-23 13:09:32', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-23 13:09:32'),
('ef3fa271689bb29e101f4006cde5d722450fa2fc', '2025-06-06 20:08:03', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-06 20:08:03'),
('f2ae990c0b4af97781b155a02c6981c24f3b45ba', '2025-03-13 11:41:41', 'UPDATE', 'undata', 'UPDATE Password User  : undata Full Name : UNDATA', '2025-03-13 11:41:41'),
('f2c6bb032b2e8c0ca9b0ea5bfc39807d4b460b79', '2025-06-08 22:36:28', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-08 22:36:28'),
('f40a0acafe65e6f5589383c3c25cdc0109c12a72', '2025-06-05 11:25:01', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-05 11:25:01'),
('f4100761bb8b8e911aa228d31a9c5c7be466619c', '2025-05-14 13:27:50', 'LOGIN', 'USER', 'User Login :MADANI', '2025-05-14 13:27:50'),
('f464c7c197c547a9c70fe44608af301bb702fc96', '2025-06-05 13:30:00', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-05 13:30:00'),
('f4bdf485b68dd8575f571ee5b2403bf2f7a97fc3', '2025-03-13 12:38:06', 'LOGIN', 'USER', 'User Login :MADANI', '2025-03-13 12:38:06'),
('f506131bae033b781ebfb16ccbb17054e080c823', '2025-06-05 10:46:16', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:46:16'),
('f57360508b3bb834c8bc53c670b69d360b803070', '2025-03-13 11:28:49', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 50', '2025-03-13 11:28:49'),
('f72f5d94344e23a35616bd74981e8a1185dbf33e', '2025-03-13 11:32:06', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-03-13 11:32:06'),
('f9ff8238fe57879816976f1b45e7356126abe759', '2025-06-05 11:18:11', 'INSERT', 'soal', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-05 11:18:11'),
('fa4b253a0484b700623e549031091ecf7fe0ed9a', '2025-06-09 10:16:21', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-09 10:16:21'),
('fb25bccce68f3525595b60070c9d0b325887b63a', '2025-06-05 13:03:07', 'LOGIN', 'USER', 'User Login :Irfan', '2025-06-05 13:03:07'),
('fdd8b262a96f17e56d33199249b0bb6df4aa2704', '2025-06-05 10:14:03', 'DELETE', 'admin', 'Hapus Parameter  : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-06-05 10:14:03'),
('fec653faeece5d8dd3adab05910815a93b3c5f0a', '2025-05-15 15:28:32', 'LOGIN', 'USER', 'User Login :dprd', '2025-05-15 15:28:32');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_log_user`
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
-- Dumping data untuk tabel `lke_log_user`
--

INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES
('001bbbc04b5eee516465465aebaf2764dd7363ee', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 14:38:22', '::1', 'LOGIN'),
('00d5619308a145dac501a6fcabaf7eaa84d7c017', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 14:13:42', '103.148.29.67', 'LOGIN'),
('0320bd914e95504382f00feeafa00888ad15ad88', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 15:27:11', '::1', 'LOGOUT'),
('0421a6f150657d7d7ae11f2b99e1fd2a0816ac87', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-23 13:09:32', '::1', 'LOGIN'),
('044035f5853296504f5f4b67324d5accc8c637e1', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:56:41', '::1', 'LOGIN'),
('04ecfc7d617ef03b270a8b6e69b0a13b2cb2601a', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-05 13:30:00', '103.148.29.67', 'LOGOUT'),
('0877dee3ed2bb072518357906dbabf741f5c5846', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-14 13:17:43', '::1', 'LOGIN'),
('098d9a0964f17f7ddf634c466d5074f0897e0c5b', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-23 13:07:51', '::1', 'LOGIN'),
('0c22a369b402bdaab3127e3ed4c90466bdaf020c', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 11:03:21', '::1', 'LOGOUT'),
('0dedfcf76484d4e882c8ed8f5a564bf6d48b52fa', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 11:12:14', '::1', 'LOGOUT'),
('0e9a5146e3f8e62e79b4bdc4a8bd16f2e645aafd', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 13:26:24', '::1', 'LOGOUT'),
('0fd1e6596555212fc761d18ef21716e6ef8bd9d1', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 15:00:39', '::1', 'LOGOUT'),
('10a5b6d059e65f8d452487cbf8c9b4e73cde8949', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-03-13 12:03:15', '::1', 'LOGIN'),
('10fadefcdc4e6fd0ec27e4a7ad541a0c93ecc2a5', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-23 13:12:16', '::1', 'LOGIN'),
('12083a39a4cad5ef52d81e8ac9bab756dc7d0d8a', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 14:13:44', '103.148.29.67', 'LOGIN'),
('1227ce19953d4cddf1f2cd0e962739faeda6ab7a', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 14:37:45', '::1', 'LOGOUT'),
('14d74ba737e7b111d13bd1465a04cef98e0ce732', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-23 13:06:21', '::1', 'LOGOUT'),
('170ff6c15ecc52eb48cd93e2fdd7784d49def091', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 13:00:20', '::1', 'LOGOUT'),
('1776a05e5a0a8efe6f949dc4e234efa6c96c4d76', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 14:37:57', '::1', 'LOGIN'),
('186c1dc727ebd959963c6c1b63209a19b1890027', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 12:46:51', '::1', 'LOGOUT'),
('1b14b72f19afbc6006b339e998643e36a1e79bd2', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 11:04:54', '103.148.29.67', 'LOGIN'),
('1bebe71cf6bb8cf11fc1d3b9efa6b42af3d7d129', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 09:07:18', '103.148.29.67', 'LOGIN'),
('20bdf13d68756a4661b3dba2741c0d7eda852568', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:31:11', '103.148.29.67', 'LOGIN'),
('20ce5a096f7258a6e811104ec360efbaf21b65ac', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-03-13 11:12:22', '::1', 'LOGIN'),
('21323177635934590b371be67c9b030533544693', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-05 12:37:17', '103.148.29.67', 'LOGIN'),
('22734bcb14506704d9a79031927da5daf17e183c', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-08 22:37:11', '180.247.47.123', 'LOGIN'),
('24c72eedd7cacdda5aa8b2cd30137e9fa512aef4', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-04 17:16:18', '103.148.29.67', 'LOGIN'),
('24e7b34a1b55b97753b5a7d25ca46958565eaf2f', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 12:16:57', '103.148.29.67', 'LOGIN'),
('290e3bd156381c4fc9f537a62c47b8f1abac0e06', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-05 12:37:12', '103.148.29.67', 'LOGIN'),
('2ca8121623fe8910179f5f9209574ead81e26314', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 11:04:25', '103.148.29.67', 'LOGOUT'),
('2e464cf6fbb4d58f807c1749bff1f076be99be5c', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-23 13:07:42', '::1', 'LOGOUT'),
('360fc675c0b6b88f113d45733c5fe1315e0efee8', '3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'Irfan', '2025-06-05 13:03:07', '103.148.29.67', 'LOGIN'),
('37d39fe8d02f9b47d0620b62a71cf8166d7c8880', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-23 13:09:24', '::1', 'LOGOUT'),
('38ae6041e64d0c73812de2b89c5298a3aa7508eb', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 15:07:07', '::1', 'LOGIN'),
('39aac58a2f004f97bbb4eb3fc7631cfe0ad5f2a8', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:03:46', '::1', 'LOGIN'),
('3aa6fb03ee0477afb53d438c8b7cc1f9a1569aa3', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-05-15 13:30:31', '::1', 'LOGOUT'),
('3b1afa78d974c97f0d42e67a8e5b6ac9986c75d5', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-06 20:07:57', '114.10.134.137', 'LOGIN'),
('3b2e5242b9da97ba26165b333756fd3976df0d56', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:02:48', '::1', 'LOGIN'),
('3b73c3045782103ba28485592664af163a47c79f', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', '2025-05-15 15:06:58', '::1', 'LOGOUT'),
('3b86e0090d930885ed2ab1296b642015103d28c5', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 14:37:27', '::1', 'LOGIN'),
('3b9df19e2ec32e9984c96db68e588ea9c66b49b0', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-03-13 14:58:57', '::1', 'LOGIN'),
('3f25b010d1b9c0e5e4ed2184d61ba12713b833a2', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 11:38:40', '::1', 'LOGIN'),
('4014aea49b6b4d921e16a154cd39f8c8b116c8a6', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 11:49:40', '103.148.29.67', 'LOGIN'),
('411de3e6c3a976d89c23e6199f54631ea76e4851', 'b083d8a22edda3ceba2daed7a003569542017f94', 'Mohammad azim purwana ', '2025-06-05 12:37:23', '103.148.29.67', 'LOGOUT'),
('41662a7d68c53c5a6c2568342fcff9e0c020db68', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-03-13 11:38:30', '::1', 'LOGOUT'),
('41f9af0929a47158068cdcd5ac29de5787b48e0c', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-03-13 12:03:36', '::1', 'LOGOUT'),
('424782a3532b3a5dada9476bfa0d0f423bb5bc30', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-07 00:57:22', '::1', 'LOGIN'),
('4ee328e7ff17aa5688be3860621c85e431053f82', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 13:44:44', '::1', 'LOGIN'),
('5126f2fb8a2864dd7d76545aff84447fa57001ad', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-05 11:25:01', '103.148.29.67', 'LOGIN'),
('554c8d99a6b2fb16533044bb2f6316f7c2467331', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 09:16:32', '103.148.29.67', 'LOGIN'),
('56053bac9de4eff1c189cbe63631ced7c85e7e8a', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 11:04:42', '::1', 'LOGIN'),
('577090711d2914fd04fcf5d4a2d4de7f1985c552', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-23 13:06:29', '::1', 'LOGIN'),
('577b9973b55faee51fc53c6f4a254476132b5e2a', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-03-13 12:46:59', '::1', 'LOGIN'),
('587cdd8b85522954e4a8838aeb3c28f7cdcc1609', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-23 13:08:45', '::1', 'LOGIN'),
('5afb42a28b9edd98414bf62f540a5a45816ed7c9', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-04 17:16:42', '103.148.29.67', 'LOGIN'),
('5c1153469c2e56563f4600da3a777a40225b82eb', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 15:01:03', '::1', 'LOGIN'),
('5c93dcf82e258cee94c178dbf50a9bdb43fd63ed', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-14 13:18:06', '::1', 'LOGOUT'),
('615ae8cafbbda84a3f28d7b4d9466006add1f4ee', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-14 13:27:50', '::1', 'LOGOUT'),
('62cbf9504d80b1616473fa0969313fd04eb3515c', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-08 22:36:28', '::1', 'LOGIN'),
('64cf1b368c8d9a275b06e356fbc240d13e5b4dbd', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', '2025-05-15 15:02:13', '::1', 'LOGIN'),
('7221f1d836748c25bc84475b58b80fcc54ed9519', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-03-13 12:02:23', '::1', 'LOGOUT'),
('7523a340c00e5ae7a544935183dde672026f5bcf', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', '2025-05-15 15:27:21', '::1', 'LOGIN'),
('75a5648cdfc4d3596e3291b9d81849e4f84c5620', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:25:29', '103.148.29.67', 'LOGIN'),
('75d9a666c1fcc33243d1eb1c7de0a1628c32d70a', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-03-13 11:42:31', '::1', 'LOGIN'),
('76ed8abe3e5840fe03123572b56557ad233e0e76', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 13:44:49', '::1', 'LOGOUT'),
('78954e8da05e1bf3a9c19d080cbb1263cc1701c6', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-06 23:56:31', '::1', 'LOGIN'),
('7c087c90be5d33045d044786c3e84ea172e25703', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:46:16', '103.148.29.67', 'LOGOUT'),
('7cbedb79de0ce74bbc76f385fdfb0648779bf935', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-06 16:36:15', '180.247.47.123', 'LOGIN'),
('829f6888ecf51813b9241293d327e700845c6780', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 10:51:13', '::1', 'LOGIN'),
('84535f32aa6313bdb18bfe00b69132f983a928b5', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 13:26:45', '::1', 'LOGIN'),
('84d73266460016ad13d5ab7ae77858dd1089d5d3', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 11:03:33', '::1', 'LOGIN'),
('8f31d454fe86a8612fe9ad32d6cab2b802771822', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-05-14 13:29:16', '::1', 'LOGOUT'),
('8ffa9188e2f5b6335a280070e7ff9f8230b8dd27', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:45:17', '::1', 'LOGOUT'),
('971f32e53691adecf35fa7767b05f7eaf44abdd6', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 11:04:26', '103.148.29.67', 'LOGOUT'),
('99e7a90d60c778fe33c409b07fab1a9ac7d967f7', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 11:04:34', '::1', 'LOGOUT'),
('99f29dc87c5be20b997b69b1544b52fd64827de1', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-23 13:08:37', '::1', 'LOGOUT'),
('9ac54af36a4831692af254ce0c65120035d8442d', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-04 17:16:25', '103.148.29.67', 'LOGOUT'),
('9da7972a1704207a43d248c5cd08dd7ae3a20347', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 14:39:21', '::1', 'LOGIN'),
('9dd3830fb24d99ea14cc4bf9f5f63a70ad5f9aef', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 11:37:33', '::1', 'LOGOUT'),
('9f433624ae89d6e8bbeb0948b92caa2d3a82f32b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 11:04:47', '103.148.29.67', 'LOGIN'),
('a2784a7f736c98b613a2db50c4032c6e672d6104', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 11:38:34', '::1', 'LOGOUT'),
('a7abe5e780618461b3905307bab3aabdfa84afab', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 11:37:44', '::1', 'LOGIN'),
('a8be927b77edbdc3ad6e9f14774ac1857591cce5', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-05-14 13:27:59', '::1', 'LOGIN'),
('a901505984c2bda2db07bbb01f71191fd48a78f8', 'bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan sirajuddin', '2025-06-05 11:53:42', '103.148.29.67', 'LOGIN'),
('a9d3d16b8904f231b9f51a2e218cac39b69781c8', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:19:09', '103.148.29.67', 'LOGIN'),
('ab2e1ae62638c4ff1b5639ec69d990a4dbaa9c60', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-06 19:55:21', '140.213.216.64', 'LOGIN'),
('abab6c3a703581f8ba0b7c8f39558e17cafc6b54', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:38:06', '::1', 'LOGIN'),
('ad795e5a2d8d7d958bd4c3e6fbc49a4a3c6b8b25', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-05-15 13:30:24', '::1', 'LOGIN'),
('aea8018d9f43a078ba9f569f4a7246cb52951e67', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 09:07:14', '103.148.29.67', 'LOGOUT'),
('b2e2b29dc31b573f33345744eaf8c326955a35d9', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 14:38:45', '::1', 'LOGOUT'),
('b337ba232e54551b87ed22b3fad8960fa14db11a', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 11:10:22', '::1', 'LOGIN'),
('b39f13e0a290499fcd28fdba4e62fccd74ac08ad', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 09:13:12', '103.148.29.67', 'LOGOUT'),
('b405ecf9f10c6b696ef6765e9cf55d2ce934b365', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-07 01:57:51', '::1', 'LOGIN'),
('b4b6d81dccc198c6b4fea29c5caf133d35252dfe', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-14 13:18:16', '::1', 'LOGIN'),
('b64ad3afe91737a1be1aa388fbdf210797fe754f', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', '2025-05-15 15:28:32', '::1', 'LOGOUT'),
('b66e39bbd3429572b474f0a9dfe5e1884b928a72', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-09 10:16:51', '114.10.135.37', 'LOGOUT'),
('b84fb9c062a5826850f817c4f4bfbacdb25898a1', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 10:52:44', '::1', 'LOGIN'),
('ba6a453d4e58adeed860eab979784e057a551358', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 09:06:36', '103.148.29.67', 'LOGIN'),
('bad1c5db70d39922650b42d290aa3a49cb39dc7c', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 12:34:00', '103.148.29.67', 'LOGOUT'),
('bd02299457d49fa47c1bc91661582b70e7b8efbc', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 12:59:53', '::1', 'LOGIN'),
('c0ee996ee9ac467be40b450c9c6366587f52efcd', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 13:04:07', '::1', 'LOGOUT'),
('c76700fe9efde06ed7f8fc35a5a707bab7271dab', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 13:26:52', '::1', 'LOGOUT'),
('c7c091b83596d44e8d3f22475bedad70b91b1b2f', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-23 13:12:08', '::1', 'LOGOUT'),
('c8b6da29c6fd869eae20726e2f0a065e7e2a513d', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:58:27', '::1', 'LOGOUT'),
('c999eaea448aec1c08f341afa61833e34a7064da', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 12:45:26', '::1', 'LOGIN'),
('cee38b332178c6ed25692541a5262ba85b890923', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 14:38:10', '::1', 'LOGOUT'),
('cfc49e0327986aebf37c273f360c8d611f3ea76e', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-06 20:08:03', '112.215.242.114', 'LOGIN'),
('d062f5ed87953424b082605cdb70b9e51926a5ce', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 12:13:09', '103.148.29.67', 'LOGIN'),
('d290a64110b81923f118d03f8183a11d4f2e9590', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:03:06', '::1', 'LOGOUT'),
('d74ce7c281413875cac2ea47a93abfde62f0c2df', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-03-13 12:37:46', '::1', 'LOGOUT'),
('df9146910438c8b31ad46dd843ce1c4d0f86da7b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 15:02:05', '::1', 'LOGOUT'),
('e164016838d8944fd228043589e6e05dca721690', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-09 10:16:21', '114.10.135.37', 'LOGIN'),
('e1cfe098f634a42ae8c686461b492484a3ca36ac', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-23 13:04:06', '::1', 'LOGIN'),
('e3224af28a2ecb4030db97291bc6b7661c89c4ff', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 13:30:16', '::1', 'LOGOUT'),
('e3bdd47be338918ab31b86fee3e9f74ca203940f', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 13:03:04', '::1', 'LOGIN'),
('e3c2d4f3916873f385e0d1c7478402cfe767ddab', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-03-13 11:42:22', '::1', 'LOGOUT'),
('e9146404db7865a71f1f80bb3513333fff5a786f', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-04 23:17:56', '140.213.10.124', 'LOGIN'),
('ee149cb4f009278b2d2845e0491b8021b401e7b3', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-05-15 10:52:35', '::1', 'LOGOUT'),
('ef4fe6f156de98a0d4fbfbdafeb41864466ef5b5', 'c895f123acea93c7dc34d334eadf6cf086474170', 'UNDATA', '2025-05-15 13:27:00', '::1', 'LOGIN'),
('efc0967b4892d797b4307e7a3e55d8b2b077552e', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-05-15 13:11:50', '::1', 'LOGIN'),
('f1a1f4076240a8862a1fd47ce18c3fc27dc7a27b', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-06 20:08:10', '114.10.134.137', 'LOGOUT'),
('f39ad0a07f9eeeacc35d1ff2c6d36e540e3fee06', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-06 22:53:38', '::1', 'LOGIN'),
('f85ee8bb20e755b921d18bd0f96c88e6164b6525', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-05-15 11:38:44', '::1', 'LOGIN'),
('f8802893079b2e9c5eeea80274863414690ac396', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 12:34:09', '103.148.29.67', 'LOGIN'),
('fb684c4f66f5aef80943d9dd384c5a931025710b', 'a8dfbd890507edce5df5425d990883ad144967fd', 'PENILAI', '2025-03-13 12:56:27', '::1', 'LOGOUT'),
('feb9349f48613db4aec240882de00cd12b94558c', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:11:57', '103.148.29.67', 'LOGIN');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_opd`
--

CREATE TABLE `lke_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_opd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `singkatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_opd`
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
-- Struktur dari tabel `lke_parameter`
--

CREATE TABLE `lke_parameter` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_parameter`
--

INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES
('1d517a847cf8e8e4dcd3737e262b6770bb77bfc0', 'Telah memiliki standar data statistik yang lengkap untuk semua Indikator Kinerja Utama (IKU) yang diampu dinas Rumus: (Jumlah IKU yang memiliki standar data dibagi jumlah total IKU) * 100%', '67af90c1e201ce82df494bed359e38771f261c26', '2025-06-05 11:23:33', NULL),
('65687941cd3f37939fe5aae3357f6e91cececf66', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:18:11', NULL),
('a1cb74ed605812c31d08a2da35c74068f986c05b', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:18:45', NULL),
('c8bd5042fc297713a4e12ab9ed72e1b76599ec27', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:19:42', NULL),
('ecaf3796b7dc51198b3b96325d1c6ce452c857f9', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', 'd97d80fa092ecfb7eb2f9dcb806f2da1bd02699c', '2025-06-05 11:20:09', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_rb`
--

CREATE TABLE `lke_rb` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT ' ',
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `form_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_rb`
--

INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`, `form_id`) VALUES
('4c0fead19e5a75ae9fd087662f9148d4496a8558', 'RB General pd', '100', '2025-06-05 11:10:15', NULL, '733bad7a91fcfb6ee09fd6c96b85afa00ae78712');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_role`
--

CREATE TABLE `lke_role` (
  `Uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_role`
--

INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES
('08a62fdb70f816447cbb4488ed1626653233851f', '49bc74a69d7256191ab4d953a6516e73c70f08db', '2025-03-13 11:09:13', NULL, NULL),
('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('c895f123acea93c7dc34d334eadf6cf086474170', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('a8dfbd890507edce5df5425d990883ad144967fd', 'ae7deb37b1eac722afda8c431c677662afd57af9', '2025-03-13 04:46:43', NULL, '05c3a4feeca1677fc6efe39a7efa9d37bb3db84a'),
('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL),
('b083d8a22edda3ceba2daed7a003569542017f94', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('3dea52e293fb809251abd6b2a3bb8bdeec71265d', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL),
('bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_roles`
--

CREATE TABLE `lke_roles` (
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `acs` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_roles`
--

INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES
('49bc74a69d7256191ab4d953a6516e73c70f08db', 'Super Admin', '2025-01-07 11:55:47', NULL, '1'),
('618d4897a69c737080de4216b15b64e1909ecba0', 'User', '2025-01-07 13:57:02', NULL, '5'),
('8fdad4894c55a3dbfb4fe280c02bd55512df3803', 'Soal', '2025-01-07 13:56:55', NULL, '3'),
('ae7deb37b1eac722afda8c431c677662afd57af9', 'Penilai', '2025-01-07 13:56:45', NULL, '2'),
('cfcc17f00a840c2bf60d19ab5e2975ae52fb6c00', 'Verifikator', '2025-01-28 08:53:04', NULL, '4');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_sub_aspek`
--

CREATE TABLE `lke_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_sub_aspek`
--

INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES
('9be761b69921877321aa4ebb0d87c5440f29d528', 'Tingkat Kematangan SPBE Perangkat Daerah', '2025-06-05 11:12:11', NULL, '72e05391085a4d9388a8f62f0bf7488e4a7646c9', '100');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_sub_sub_aspek`
--

CREATE TABLE `lke_sub_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `lke_sub_sub_aspek`
--

INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES
('647efd552c9b129e2a606e4b9b127cd378de974c', '1.3. Penyelenggaraan Statistik Sektoral', '2025-06-05 11:22:06', '2025-06-05 11:58:08', '9be761b69921877321aa4ebb0d87c5440f29d528', '20'),
('ba910e076b957c0bce7ee6f47f67a6b62800b4ea', '1.1. Tingkat Kematangan Kapabilitas Proses', '2025-06-05 11:15:27', '2025-06-05 12:00:16', '9be761b69921877321aa4ebb0d87c5440f29d528', '50');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_tahun`
--

CREATE TABLE `lke_tahun` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_upload_bukti`
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
-- Dumping data untuk tabel `lke_upload_bukti`
--

INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES
('176046b472dd232bc1c129d880867eba093261df', '1741838484_4bcf7a782d7eff2f1c24.jpg', '9b8e9c13774632cff36e912434164de3b415fde2', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('1aceb46941378b87bc37a96522abc28a1cb085f0', '1741838484_87d79e1d65ae42a1cbf5.jpg', '0665675915f6dab5d875f7f229f7acd906f15b23', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('37cbdb421f4d015865ead3ad7946c3ffa731e6ee', '1749094760_064bae64b9362cf084fb.xlsx', '21c3e985e73695d807032ad5a197c120d8eb1113', '2025-06-05 11:39:20', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('445af2b99bfd4deb9ac4773e835fc228ef288a7f', '1741838484_e63fe719336474f447d2.png', '089b2bd74d106ef34028d6bd1dd70f2efc238838', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('460d3ffb2d969a7ed5995f7a0e520277de12d82f', '1741838484_2f8ac6a9281c5ba7bc05.pdf', '1dbb0abcd298b6c9eb7bd73a5952d6477772fc5f', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('4d1142504daf9190d5d60053fe719ae7f232444a', '1741838690_65d388ebe1866f099400.jpg', '9b8e9c13774632cff36e912434164de3b415fde2', '2025-03-13 12:04:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('53d93a630c21ff0bc8c293f78e70b2fc16febd0a', '1741838690_4dbaaf13493420f80567.jpeg', '5063552ad731cd4f4e539c3a7983b9670b44e5c6', '2025-03-13 12:04:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('5cd6372edc689f9ee636b77ee0b44758525e80ce', '1741838690_a78082a95b9c93d02d54.png', '089b2bd74d106ef34028d6bd1dd70f2efc238838', '2025-03-13 12:04:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('73a076a9a95ca73ca534ef9c95d97a298ab20621', '1741838832_f1ca55ada9dd9f05e8ef.png', '1dbb0abcd298b6c9eb7bd73a5952d6477772fc5f', '2025-03-13 12:07:12', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('847bbe07f63311795d9e85237e247496b4671940', '1741838690_79f3b905065f07ad5cbc.xlsx', '0665675915f6dab5d875f7f229f7acd906f15b23', '2025-03-13 12:04:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('c1a533312e9b334f2204078cc035036dd9909457', '1741838484_b90d5479bdd36dc90ca2.jpg', '5063552ad731cd4f4e539c3a7983b9670b44e5c6', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170'),
('d4c9cd14c42b147c95b04cf5b0b44987a99956ad', '1741838690_2d0c9d7a1957da026252.jpg', '7dae0b13cc5cc2e0eea1ce0b22bd7d966ef85970', '2025-03-13 12:04:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('d7557d7a1d89d84331c8cc5a98da90f0ce657279', '1749094730_52af81e14ae5d4a2d97f.xlsx', 'd873f3da19916111786c65b015a5457fcda5b903', '2025-06-05 11:38:50', NULL, 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a'),
('e5d43d0e9a996c8ef990ef97af065a8209d18be3', '1741838484_a2cab1e21f79e0806550.png', '7dae0b13cc5cc2e0eea1ce0b22bd7d966ef85970', '2025-03-13 12:01:24', NULL, 'c895f123acea93c7dc34d334eadf6cf086474170');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lke_user`
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
-- Dumping data untuk tabel `lke_user`
--

INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES
('08a62fdb70f816447cbb4488ed1626653233851f', 'admin', 'super admin', 0xd69aeaed31b2ef9d2d4338276965f075, '-', 'admin@surabe.com', '2025-03-13 11:09:13', NULL, 'TRUE'),
('3dea52e293fb809251abd6b2a3bb8bdeec71265d', 'budker', 'Irfan', 0x7527dd9073a45ab8ce56059f6076ca01, '082187020149', 'sajairfan3@gmail.com', '2025-06-05 02:57:19', '2025-06-05 10:57:19', 'TRUE'),
('660bebf5ecdab34df655a3d590c1e3e0c2ca2f1e', 'muftyabyan', 'muhammad mufti abyan', 0x3835a6e75c78849bc6ddc3799a35c527, '08134119555', 'muftyabyan@gmail.com', '2025-06-05 02:59:00', '2025-06-05 10:59:00', 'TRUE'),
('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', 'dprd', 0xd69aeaed31b2ef9d2d4338276965f075, '93278923424242', 'dprd@mail.com', '2025-05-15 07:02:00', '2025-05-15 15:02:00', 'TRUE'),
('a8dfbd890507edce5df5425d990883ad144967fd', 'penilai', 'PENILAI', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'penilai@mail.com', '2025-03-13 04:46:43', '2025-03-13 12:46:43', 'TRUE'),
('b083d8a22edda3ceba2daed7a003569542017f94', 'rb_renaksi', 'Mohammad azim purwana ', 0x5d8627fa868abff911e4242545dfb76b, '085212409490', 'azimpurwana@gmail.com', '2025-06-05 02:48:55', '2025-06-05 10:48:55', 'TRUE'),
('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'madani', 'MADANI', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'madani@mail.com', '2025-03-13 03:42:15', '2025-03-13 11:42:15', 'TRUE'),
('bdc2d29cbd309ee18c494bdd976c1ad6009a6b0f', 'sultan', 'sultan sirajuddin', 0x7c85c671838f8bfe00b8ecc99bef791c, '085241349838', 'sirajuddinsultan666@gmail.com', '2025-06-05 03:01:06', '2025-06-05 11:01:07', 'TRUE'),
('c895f123acea93c7dc34d334eadf6cf086474170', 'undata', 'UNDATA', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'undata@mail.com', '2025-03-13 03:41:41', '2025-03-13 11:41:41', 'TRUE'),
('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'soal', 'Pengisi Soal', 0xd69aeaed31b2ef9d2d4338276965f075, '0987654321', 'soal@surabe.com', '2025-03-13 03:11:55', '2025-03-13 11:11:55', 'TRUE');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `lke_aspek`
--
ALTER TABLE `lke_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_bobot`
--
ALTER TABLE `lke_bobot`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_bukti_dukung`
--
ALTER TABLE `lke_bukti_dukung`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_detail_opd`
--
ALTER TABLE `lke_detail_opd`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_form`
--
ALTER TABLE `lke_form`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_indikator`
--
ALTER TABLE `lke_indikator`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_jawaban`
--
ALTER TABLE `lke_jawaban`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_Jenis_Jawaban`
--
ALTER TABLE `lke_Jenis_Jawaban`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indeks untuk tabel `lke_logs`
--
ALTER TABLE `lke_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_log_user`
--
ALTER TABLE `lke_log_user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_opd`
--
ALTER TABLE `lke_opd`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_parameter`
--
ALTER TABLE `lke_parameter`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_rb`
--
ALTER TABLE `lke_rb`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_roles`
--
ALTER TABLE `lke_roles`
  ADD PRIMARY KEY (`RoleId`);

--
-- Indeks untuk tabel `lke_sub_aspek`
--
ALTER TABLE `lke_sub_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_sub_sub_aspek`
--
ALTER TABLE `lke_sub_sub_aspek`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_tahun`
--
ALTER TABLE `lke_tahun`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_upload_bukti`
--
ALTER TABLE `lke_upload_bukti`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lke_user`
--
ALTER TABLE `lke_user`
  ADD PRIMARY KEY (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
