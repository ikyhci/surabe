/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : lke_pengukuran_irb

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 08/01/2025 13:01:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lke_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_aspek`;
CREATE TABLE `lke_aspek` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `bobot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`) VALUES ('0d94dc2a709e6902b75bb2bbdb03c64b754f6061', 'Capaian Sasaran Strategis', '2025-01-07 15:21:08', NULL, '100');
COMMIT;

-- ----------------------------
-- Table structure for lke_bukti_dukung
-- ----------------------------
DROP TABLE IF EXISTS `lke_bukti_dukung`;
CREATE TABLE `lke_bukti_dukung` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_parameter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_dukung` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_bukti_dukung
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_detail_opd
-- ----------------------------
DROP TABLE IF EXISTS `lke_detail_opd`;
CREATE TABLE `lke_detail_opd` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opdid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_detail_opd
-- ----------------------------
BEGIN;
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'f0dc55976676c13304f0fc322812d091dfbd7824', '2025-01-07 19:10:31', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_indikator
-- ----------------------------
DROP TABLE IF EXISTS `lke_indikator`;
CREATE TABLE `lke_indikator` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_indikator
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_jawaban
-- ----------------------------
DROP TABLE IF EXISTS `lke_jawaban`;
CREATE TABLE `lke_jawaban` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Jawaban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_parameter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `userid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nilai` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_jawaban
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_logs
-- ----------------------------
DROP TABLE IF EXISTS `lke_logs`;
CREATE TABLE `lke_logs` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `log` datetime DEFAULT NULL,
  `info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `create_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_logs
-- ----------------------------
BEGIN;
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '2025-01-07 15:21:08', 'INSERT', 'administrator', 'Tambah Data Aspek : Capaian Sasaran Strategis Bobot : 100', '2025-01-07 15:21:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7229bce2230b49e3cab4afeeb8d4e486aabda672', '2025-01-07 14:43:47', 'UPDATE', 'administrator', 'Update Data OPD  : DISKOMINFOSANTIK', '2025-01-07 14:43:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', '2025-01-07 19:10:31', 'INSERT', NULL, 'Tambah Data Berhasil : user Full Name : user', '2025-01-07 19:10:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', '2025-01-07 13:47:03', 'INSERT', NULL, 'Tambah Data Berhasil : administrator Full Name : Super Admin', '2025-01-07 13:47:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', '2025-01-07 15:27:54', 'INSERT', 'administrator', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 100', '2025-01-07 15:27:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '2025-01-07 15:25:53', 'INSERT', 'administrator', 'Tambah Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-01-07 15:25:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f0dc55976676c13304f0fc322812d091dfbd7824', '2025-01-07 14:43:22', 'INSERT', 'administrator', 'Tambah Data OPD  : DISKOMINFO', '2025-01-07 14:43:22');
COMMIT;

-- ----------------------------
-- Table structure for lke_opd
-- ----------------------------
DROP TABLE IF EXISTS `lke_opd`;
CREATE TABLE `lke_opd` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_opd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_opd
-- ----------------------------
BEGIN;
INSERT INTO `lke_opd` (`id`, `nama_opd`, `create_at`, `update_at`) VALUES ('f0dc55976676c13304f0fc322812d091dfbd7824', 'DISKOMINFOSANTIK', '2025-01-07 14:43:22', '2025-01-07 14:43:47');
COMMIT;

-- ----------------------------
-- Table structure for lke_parameter
-- ----------------------------
DROP TABLE IF EXISTS `lke_parameter`;
CREATE TABLE `lke_parameter` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_parameter` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_indikator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_parameter
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_role
-- ----------------------------
DROP TABLE IF EXISTS `lke_role`;
CREATE TABLE `lke_role` (
  `Uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_role
-- ----------------------------
BEGIN;
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', '49bc74a69d7256191ab4d953a6516e73c70f08db', '2025-01-07 13:47:03', NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', '618d4897a69c737080de4216b15b64e1909ecba0', '2025-01-07 19:10:31', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_roles
-- ----------------------------
DROP TABLE IF EXISTS `lke_roles`;
CREATE TABLE `lke_roles` (
  `RoleId` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_roles
-- ----------------------------
BEGIN;
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`) VALUES ('49bc74a69d7256191ab4d953a6516e73c70f08db', 'Super Admin', '2025-01-07 11:55:47', NULL);
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`) VALUES ('618d4897a69c737080de4216b15b64e1909ecba0', 'User', '2025-01-07 13:57:02', NULL);
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`) VALUES ('8fdad4894c55a3dbfb4fe280c02bd55512df3803', 'Soal', '2025-01-07 13:56:55', NULL);
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`) VALUES ('ae7deb37b1eac722afda8c431c677662afd57af9', 'Penilai', '2025-01-07 13:56:45', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_sub_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_sub_aspek`;
CREATE TABLE `lke_sub_aspek` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_sub_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', 'Tingkat Kematangan SPBE Perangkat Daerah', '2025-01-07 15:25:53', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
COMMIT;

-- ----------------------------
-- Table structure for lke_sub_sub_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_sub_sub_aspek`;
CREATE TABLE `lke_sub_sub_aspek` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_sub_aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_sub_aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_sub_sub_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Tingkat Kematangan Kapabilitas Proses', '2025-01-07 15:27:54', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '100');
COMMIT;

-- ----------------------------
-- Table structure for lke_user
-- ----------------------------
DROP TABLE IF EXISTS `lke_user`;
CREATE TABLE `lke_user` (
  `uid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FullName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PassEnc` varbinary(255) DEFAULT NULL,
  `Phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmailAdds` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_user
-- ----------------------------
BEGIN;
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', 'user', 0xA3E79C4A517BEBDBC576B8FAC9850902, '', '', '2025-01-07 19:10:31', NULL);
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', 'administrator', 'Super Admin', 0xBDB4DB71C0667E973BA510581572B3CC, '-', '-', '2025-01-07 13:47:03', NULL);
COMMIT;

-- ----------------------------
-- Procedure structure for Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Aspek_add_edit`(uidx VARCHAR(255),idx VARCHAR(255),nmas VARCHAR(255), bbt VARCHAR(255))
BEGIN
  #Routine body goes here...
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
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Aspek_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Aspek_delete`;
delimiter ;;
CREATE PROCEDURE `Aspek_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
  #Routine body goes here...
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
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Indikator_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Indikator_add_edit`;
delimiter ;;
CREATE PROCEDURE `Indikator_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), idssa VARCHAR(255), nmind VARCHAR(255), jjwb VARCHAR(255))
BEGIN
  #Routine body goes here...
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
	SET ada = (SELECT id FROM lke_indikator WHERE id=idx);
	IF (ada IS NULL) THEN
		set ada = (SELECT id from lke_sub_sub_aspek WHERE id = idssa);
		IF (ada IS NOT NULL) THEN
			INSERT INTO lke_indikator VALUES(SHA(NOW()), idssa, nmind, NOW(), NULL, jjwb);
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Tambah Data Indikator : ',nmind), NOW());
			SET res = 1;
			SET msg = 'Tambah Data Berhasil';
		ELSE
			SET res = 0;
			SET msg = 'Sub Sub Aspek Tidak Di Temukan';
		END IF;
	ELSE
		UPDATE lke_indikator SET indikator= nmind, id_sub_sub_aspek = idssa, jenis_jawaban = jjwb 
		WHERE id = idx;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Edit Data Indikator : ',nmind), NOW());
		SET res = 1;
		SET msg = 'Update Data Berhasil';
	END IF;
	
	COMMIT;
	SELECT res,msg;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Indikator_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Indikator_delete`;
delimiter ;;
CREATE PROCEDURE `Indikator_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
  #Routine body goes here...
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
		SET ada = (SELECT id FROM lke_indikator WHERE id = idx);
		IF (ada IS NOT NULL) THEN
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data Indikator  : ',(SELECT indikator FROM lke_indikator WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_indikator WHERE id = idx;
			SET res = 1;
			SET msg ='success';
		ELSE
			SET res = 0 ;
			SET msg = 'Data Indikator Tidak Di Temukan.';
		END IF;
	COMMIT;
	SELECT res, msg;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Opd_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Opd_add_edit`;
delimiter ;;
CREATE PROCEDURE `Opd_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), nmopd VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add, edit OPD :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_opd FROM lke_opd WHERE id=idx LIMIT 1);
	IF (ada IS NULL) THEN
		INSERT INTO lke_opd VALUES(SHA(NOW()), nmopd, NOW(), NULL);
		SET res = 1;
		SET msg = 'Tambah Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Tambah Data OPD  : ',nmopd), NOW());
	ELSE
		UPDATE lke_opd SET nama_opd = nmopd, update_at = NOW() WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Update Data OPD  : ',nmopd), NOW());
	END IF;

	
	COMMIT;
	SELECT res, msg;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Opd_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Opd_delete`;
delimiter ;;
CREATE PROCEDURE `Opd_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del OPD :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_opd FROM lke_opd WHERE id = idx LIMIT 1);
	IF (ada IS not null) THEN	
		SET ada = (SELECT id from lke_detail_opd WHERE opdid = idx);
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Parameter_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Parameter_add_edit`;
delimiter ;;
CREATE PROCEDURE `Parameter_add_edit`(param1 int)
BEGIN
  #Routine body goes here...
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Parameter_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Parameter_delete`;
delimiter ;;
CREATE PROCEDURE `Parameter_delete`(param1 int)
BEGIN
  #Routine body goes here...
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Sub_Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Sub_Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Sub_Aspek_add_edit`(uidx VARCHAR(255), idx VARCHAR(255),nmsub VARCHAR(255), idasp VARCHAR(255), bbt VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Sub Aspek :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
-- 		SET ada = (SELECT id FROM )
		INSERT INTO lke_sub_aspek VALUES(SHA(NOW()), nmsub, NOW(), NULL, idasp, bbt);
		SET res = 1;
		SET msg = 'Tambah Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Tambah Data Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
	ELSE
		UPDATE lke_sub_aspek SET nama_sub_aspek = nmsub , id_aspek = idasp ,bobot = bbt, update_at = NOW()
		WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Update Data Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
	END IF;
	COMMIT;
	SELECT res, msg;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Sub_Aspek_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Sub_Aspek_delete`;
delimiter ;;
CREATE PROCEDURE `Sub_Aspek_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Sub_Sub_Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Sub_Sub_Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Sub_Sub_Aspek_add_edit`(uidx VARCHAR(255), idx VARCHAR(255),nmsub VARCHAR(255), idasp VARCHAR(255), bbt VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add Sub Sub Aspek :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT id FROM lke_sub_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NULL) THEN
		INSERT INTO lke_sub_sub_aspek VALUES(SHA(NOW()), nmsub, NOW(), NULL, idasp, bbt);
		SET res = 1;
		SET msg = 'Tambah Data Berhasil.';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Tambah Data Sub Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
	ELSE
		UPDATE lke_sub_sub_aspek SET nama_sub_sub_aspek = nmsub , id_sub_aspek = idasp ,bobot = bbt, update_at = NOW()
		WHERE id = idx;
		SET res = 1;
		SET msg = 'Update Data Berhasil.';
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
		(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
		CONCAT('Update Data Sub Sub Aspek : ',nmsub,' Bobot : ',bbt), NOW());
	END IF;
	COMMIT;
	SELECT res, msg;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sub_Sub_Aspek_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `sub_Sub_Aspek_delete`;
delimiter ;;
CREATE PROCEDURE `sub_Sub_Aspek_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('del Sub Sub Aspek :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg; 
  END;
		
	START TRANSACTION;
	SET ada = (SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id = idx LIMIT 1);
	IF (ada IS NOT NULL) THEN	
		SET ada = (SELECT id_sub_sub_aspek FROM lke_indikator WHERE id_sub_sub_aspek = idx);
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for User_Auth
-- ----------------------------
DROP PROCEDURE IF EXISTS `User_Auth`;
delimiter ;;
CREATE PROCEDURE `User_Auth`(usrnm VARCHAR(255), pswd VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm);
	
	IF (ada IS NOT NULL) THEN
		SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm AND PassEnc = AES_ENCRYPT(pswd,UNHEX(SHA2('EVALUASISPBEOPD2025',256)), 'E31C32B22EA452B0F2959E296827CE59'));
		IF (ada IS not NULL) THEN
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
				IF(e.nama_opd IS NULL,'-',e.nama_opd ) AS nama_opd
			FROM
				lke_user AS a
				INNER JOIN lke_role AS c ON a.uid = c.Uid
				INNER JOIN lke_roles AS b ON c.RoleId = b.RoleId
				LEFT JOIN lke_detail_opd AS d ON a.uid = d.userid
				LEFT JOIN lke_opd AS e ON d.opdid = e.id
				WHERE a.UserName = usrnm AND 
				a.PassEnc = 
				AES_ENCRYPT(pswd,UNHEX(SHA2('EVALUASISPBEOPD2025',256)), 'E31C32B22EA452B0F2959E296827CE59');
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for User_Cretae_new
-- ----------------------------
DROP PROCEDURE IF EXISTS `User_Cretae_new`;
delimiter ;;
CREATE PROCEDURE `User_Cretae_new`(uidx VARCHAR(255), uname VARCHAR(255), fname VARCHAR(255), pswd VARCHAR(255),
 phn VARCHAR(255), eml VARCHAR(255), rlid VARCHAR(255), opid VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	DECLARE uids VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
	 ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('add user :',(SELECT @p2)), NOW());
     SET res = 0;
		 SET msg = (SELECT @p2);
		 SELECT res, msg;
  END;
		
	START TRANSACTION;
	
	SET ada = (select uid from lke_user WHERE UserName = uname LIMIT 1);
	SET uids = SHA(NOW());
	
	IF (ada is NULL) THEN
		SET ada = (SELECT RoleId FROM lke_roles WHERE RoleId = rlid);
		if (ada IS NOT NULL) THEN
			SET ada = (SELECT id from lke_opd WHERE id = opid);
			IF (ada IS NOT NULL) THEN
				INSERT INTO lke_user VALUES(uids, uname, fname, 
				AES_ENCRYPT(pswd,UNHEX(SHA2('EVALUASISPBEOPD2025',256)), 'E31C32B22EA452B0F2959E296827CE59')
				,phn, eml, NOW(), NULL);
				
				INSERT INTO lke_role VALUES(uids, rlid, NOW(), NULL);
				
				INSERT INTO lke_detail_opd VALUES(SHA(NOW()), uids, opid, NOW(), NULL);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				
				INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'INSERT', 
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for User_Update
-- ----------------------------
DROP PROCEDURE IF EXISTS `User_Update`;
delimiter ;;
CREATE PROCEDURE `User_Update`(uidx VARCHAR(255), uname VARCHAR(255), fname VARCHAR(255), phn VARCHAR(255), eml VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for User_update_password
-- ----------------------------
DROP PROCEDURE IF EXISTS `User_update_password`;
delimiter ;;
CREATE PROCEDURE `User_update_password`(uidx VARCHAR(255), pswd VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE ada VARCHAR(255);
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
		ROLLBACK;
		GET DIAGNOSTICS CONDITION 1
		@p2 = MESSAGE_TEXT;
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('edit password user :',(SELECT @p2)), NOW());
    SET res = 0;
		SET msg = (SELECT @p2);
		SELECT res, msg;
  END;
		
	START TRANSACTION;
	SET ada = (SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1);
	IF (ada is not NULL) THEN
		UPDATE lke_user SET PassEnc = AES_ENCRYPT(pswd,UNHEX(SHA2('EVALUASISPBEOPD2025',256)), 'E31C32B22EA452B0F2959E296827CE59'), Update_at=NOW() 
		WHERE uid = uidx;
			SET res = 1;
			SET msg ='success'; 
			INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'UPDATE', 
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
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
