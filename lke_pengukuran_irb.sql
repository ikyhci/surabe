/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : lke

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 05/06/2025 11:10:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lke_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_aspek`;
CREATE TABLE `lke_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `penilaiid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rb_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `penilaiid`, `rb_id`) VALUES ('5a6bd3bb04881db622fbacfd4222bb12ebe16cc4', 'nama Aspek', '2025-06-04 14:22:52', NULL, '100', NULL, '3f8d9cfabaf2a28135dacdc942f6513f0c725652');
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `penilaiid`, `rb_id`) VALUES ('e4f5574bb633fe896a42d7f75d57bbb0a947894a', 'Capaian Sasaran Strategis', '2025-03-13 11:27:22', NULL, '36', NULL, '8cf0440082c809805dbc45976a8e9bf65e7b4cb3');
COMMIT;

-- ----------------------------
-- Table structure for lke_bobot
-- ----------------------------
DROP TABLE IF EXISTS `lke_bobot`;
CREATE TABLE `lke_bobot` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `idx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot_akhir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_bobot
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_bukti_dukung
-- ----------------------------
DROP TABLE IF EXISTS `lke_bukti_dukung`;
CREATE TABLE `lke_bukti_dukung` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_dukung` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_bukti_dukung
-- ----------------------------
BEGIN;
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('0665675915f6dab5d875f7f229f7acd906f15b23', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional)', '2025-03-13 11:38:06', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('089b2bd74d106ef34028d6bd1dd70f2efc238838', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API)', '2025-03-13 11:37:48', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('1dbb0abcd298b6c9eb7bd73a5952d6477772fc5f', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Proses Bisnis (sampai level n dan kelengkapan metadata)', '2025-03-13 11:33:58', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('5063552ad731cd4f4e539c3a7983b9670b44e5c6', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya)', '2025-03-13 11:34:43', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('7dae0b13cc5cc2e0eea1ce0b22bd7d966ef85970', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP)', '2025-03-13 11:34:20', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('9b8e9c13774632cff36e912434164de3b415fde2', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', 'Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001)', '2025-03-13 11:38:21', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_detail_opd
-- ----------------------------
DROP TABLE IF EXISTS `lke_detail_opd`;
CREATE TABLE `lke_detail_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opdid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_detail_opd
-- ----------------------------
BEGIN;
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('03e7da95b52f070890de6eb195569d824cb53e6d', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '056dd8b1762b5e8195fb91c3525d05b79bf6e3a2', '2025-03-13 03:42:15', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('43a3d5ed7d8be4cfe72939f234aaac54e8035ffb', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 03:11:55', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('c202274f678efde74a8015b24691a1945f7ac772', '8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'ba273eab7dc54d995b5ee2ca958b5c447f277d84', '2025-05-15 07:02:00', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('cc0bd82ca92dce73e533301b262409202d296dc5', 'c895f123acea93c7dc34d334eadf6cf086474170', '6a674853b7c5e54cd19140c17cca792811418c1b', '2025-03-13 03:41:41', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('d7337fc416527508037c7bea5b1dc7881fbcef59', 'a8dfbd890507edce5df5425d990883ad144967fd', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 04:46:43', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('dfebaec58a33ea0bfd2f9cb7282b181aa47f3e70', '08a62fdb70f816447cbb4488ed1626653233851f', '640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', '2025-03-13 11:09:13', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_form
-- ----------------------------
DROP TABLE IF EXISTS `lke_form`;
CREATE TABLE `lke_form` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `evaluasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bataswaktu` datetime DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `active` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_form
-- ----------------------------
BEGIN;
INSERT INTO `lke_form` (`id`, `nama`, `tahun`, `deskripsi`, `evaluasi`, `bataswaktu`, `create_at`, `active`, `update_at`) VALUES ('14daacb695c4f79a944928f39bd5290e6eeb1d80', 'PENILAIAN 2025', '2025', '-', 'Evaluasi LKE 2025', '2025-08-30 00:00:00', '2025-06-05 11:00:13', '1', NULL);
INSERT INTO `lke_form` (`id`, `nama`, `tahun`, `deskripsi`, `evaluasi`, `bataswaktu`, `create_at`, `active`, `update_at`) VALUES ('51497dab24601984f92267a5600070e96b8ddfa7', 'F-SPBE-01', '2025', 'Penilaian SPBE 2025', 'Evaluasi SPBE', '2025-07-16 00:00:00', '2025-03-13 11:17:14', '1', NULL);
INSERT INTO `lke_form` (`id`, `nama`, `tahun`, `deskripsi`, `evaluasi`, `bataswaktu`, `create_at`, `active`, `update_at`) VALUES ('fd145710314504e3075a2c7894e89659b75f811c', 'FOM 2', '2025', 'Deskripsi', 'SPBE', '2025-06-30 00:00:00', '2025-06-04 14:21:45', '1', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_indikator
-- ----------------------------
DROP TABLE IF EXISTS `lke_indikator`;
CREATE TABLE `lke_indikator` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_indikator
-- ----------------------------
BEGIN;
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('9ee30bb303b521b35f6a1b177df2d7b7888a744b', '051d12e3ad56c4a8b87415df29add04a3ae69802', 'Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-03-13 11:30:59', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
COMMIT;

-- ----------------------------
-- Table structure for lke_jawaban
-- ----------------------------
DROP TABLE IF EXISTS `lke_jawaban`;
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
  `aproveby` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_jawaban
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_Jenis_Jawaban
-- ----------------------------
DROP TABLE IF EXISTS `lke_Jenis_Jawaban`;
CREATE TABLE `lke_Jenis_Jawaban` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_jawaban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_Jenis_Jawaban
-- ----------------------------
BEGIN;
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('2908a111a94b52d770dbe8db5800d71706463811', 'Skala Linear', 1, '2025-01-10 14:40:06', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'Pilihan Ganda', 4, '2025-01-10 14:32:35', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'Ya/Tidak', 2, '2025-01-16 13:39:02', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_log_user
-- ----------------------------
DROP TABLE IF EXISTS `lke_log_user`;
CREATE TABLE `lke_log_user` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loged_at` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_log_user
-- ----------------------------
BEGIN;
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('36c160f45ce3e6ee22b8c63e013149923781de9a', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-05 10:43:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4ce276b9ec1f07d6f1acffd348bcd5c23bf8582f', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:56:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4d115066f47d267908688697fd92b148e5e304a9', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:42:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4d4f27e635fa30663f33746ddc70980ec4d280b5', 'ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'MADANI', '2025-06-05 10:43:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('57c324cf68ef87818a648f154fc53b4ef3b9fc37', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 10:43:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6740442e773ad5064c34d479b823ddb8f7d46995', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 10:56:14', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('85e593570011808434799931af54349799fecf90', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 10:42:49', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ad064dc874511b06aa5da35fe2708d055d144d8e', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-05 10:42:41', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b29965f2190f8fe2808cc4073da5bbfdf0a56a74', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-04 16:38:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bd22371a138f2f650cea8fc4789a086dbd4451e7', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-04 16:38:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e866bb04518ae25f40ac6e0cf3881c6737e5a47e', '08a62fdb70f816447cbb4488ed1626653233851f', 'super admin', '2025-06-04 15:57:29', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f5563ec02c805aad1e65355ea3ac3bdb57164508', 'cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'Pengisi Soal', '2025-06-05 10:43:02', '::1', 'LOGOUT');
COMMIT;

-- ----------------------------
-- Table structure for lke_logs
-- ----------------------------
DROP TABLE IF EXISTS `lke_logs`;
CREATE TABLE `lke_logs` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `log` datetime DEFAULT NULL,
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `create_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_logs
-- ----------------------------
BEGIN;
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('03640e76546bde0834469640065a608ac9b84cff', '2025-06-05 10:42:41', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:42:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('07438eb73ff191bd410ee9e6b1cffac47d233d51', '2025-06-05 11:00:13', 'INSERT', 'admin', 'Tambah Data Form : PENILAIAN 2025 Tahun : 2025', '2025-06-05 11:00:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0e78cb2f778f239080a0fb3ba75e6b3eb1240664', '2025-06-05 10:56:28', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:56:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('283f587a68e89431ae2b131e7a37b1bee0d465d6', '2025-06-05 10:42:28', 'LOGIN', 'USER', 'User Login :super admin', '2025-06-05 10:42:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('945aff414a6bb38279d23c0f483bb324f9edd7f1', '2025-06-05 10:43:52', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 10:43:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a740b5c18bf237fa4145701dad3294ccd4d2aee6', '2025-06-05 10:43:10', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-05 10:43:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b2299abc6541e22d26475418e965dbccc155c643', '2025-06-05 10:42:49', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 10:42:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b31cccf86b47ff052e320669c4211a84a517cada', '2025-06-05 10:43:02', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 10:43:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b434639de0828f6b353179df5cb2e5d158ec54d0', '2025-06-05 10:43:19', 'LOGIN', 'USER', 'User Login :MADANI', '2025-06-05 10:43:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e2676c80e7cc59f6c38cc7f653443a2f04987943', '2025-06-05 10:56:14', 'LOGIN', 'USER', 'User Login :Pengisi Soal', '2025-06-05 10:56:14');
COMMIT;

-- ----------------------------
-- Table structure for lke_opd
-- ----------------------------
DROP TABLE IF EXISTS `lke_opd`;
CREATE TABLE `lke_opd` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_opd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `singkatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_opd
-- ----------------------------
BEGIN;
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('00f7cb1efba969ab849609d70409b58e9c93ec77', 'Biro Administrasi Pengadaan Barang dan Jasa Setda Provinsi Sulawesi Tengah', 'Biro PBJ Sulteng', '2025-02-12 12:04:15', '2025-02-12 12:04:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('056dd8b1762b5e8195fb91c3525d05b79bf6e3a2', 'Rumah Sakit Umum Daerah MADANI', 'RSUD Madani', '2025-02-12 12:04:55', '2025-02-12 12:04:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('11fb4836238f14f9133810ea97bc2224660d532c', 'Biro Hukum Setda Provinsi Sulawesi Tengah', 'Biro Hukum Sulteng', '2025-02-12 12:03:25', '2025-02-12 12:03:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('18d74facbd4ea6d62d6ea88c50a179eb6e38d0b9', 'Dinas Kependudukan dan Pencatatan Sipil Daerah Provinsi Sulawesi Tengah', 'Dukcapil Sulteng', '2025-02-12 11:59:55', '2025-02-12 11:59:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('1d97af161eae1b2bb6b3371c058f1896c97c00c3', 'Dinas Tenaga Kerja dan Transmigrasi Daerah Provinsi Sulawesi Tengah', 'Disnakertrans Sulteng', '2025-02-12 12:00:35', '2025-02-12 12:00:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('229df29c4750bc7b56a66e41552c8cf29441a56b', 'Satuan Polisi Pamong Praja Daerah Provinsi Sulawesi Tengah', 'Satpol PP Sulteng', '2025-02-12 12:03:15', '2025-02-12 12:03:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('269a81eec6f4ab48b6e2ae6a1965b03f4dbbd770', 'Biro Administrasi Pemerintahan dan Otonomi Daerah Setda Provinsi Sulawesi Tengah', 'Biro Pem Otda Sulteng', '2025-02-12 12:03:35', '2025-02-12 12:03:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('2d3607cf04d37e2a1a453fee95449aafa4205d1e', 'Badan Kesatuan Bangsa dan Politik Daerah Provinsi Sulawesi Tengah', 'Bakesbangpol Sulteng', '2025-02-12 11:58:45', '2025-02-12 11:58:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('3538043ccb8ea3a4d00a2f20009d97e841f6a8ff', 'Biro Administrasi Pembangunan Setda Provinsi Sulawesi Tengah', 'Biro Pembangunan Sulteng', '2025-02-12 12:03:55', '2025-02-12 12:03:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('357b7a3a95c974142eb4f8b2ad4460d2db0b79e3', 'Dinas Perhubungan Daerah Provinsi Sulawesi Tengah', 'Dishub Sulteng', '2025-02-12 12:02:05', '2025-02-12 12:02:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('3872c1e77e3457745db8ca3e11b6ab8ea1190fcb', 'Dinas Perpustakaan dan Arsip Daerah Provinsi Sulawesi Tengah', 'Dispusarda Sulteng', '2025-02-12 12:02:55', '2025-02-12 12:02:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('3905a80e31e615e287f3e4ce0af3c5bf20f8ad57', 'Dinas Kebudayaan Provinsi Sulawesi Tengah', 'Disbud Sulteng', '2025-02-12 12:02:45', '2025-02-12 12:02:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('49f31573998d313cf8eb752591cb7645d8afbdcc', 'Dinas Perindustrian dan Perdagangan Daerah Provinsi Sulawesi Tengah', 'Disperindag Sulteng', '2025-02-12 12:02:15', '2025-02-12 12:02:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('4af2f901606ac6e6cb969d37e8c891de965ebc73', 'Badan Pengembangan Sumber Daya Manusia Daerah Provinsi Sulawesi Tengah', 'BPSDM Sulteng', '2025-02-12 11:58:15', '2025-02-12 11:58:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('4cc85b5e0f704694c0ec7902b6dc8175f16de3da', 'Inspektorat Daerah Provinsi Sulawesi Tengah', 'Inspektorat Sulteng', '2025-02-12 11:57:25', '2025-02-12 11:57:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('54aec085ce82ada2303b17c408efd781ffdbdaa2', 'Dinas Pariwisata Daerah Provinsi Sulawesi Tengah', 'Dispar Sulteng', '2025-02-12 12:00:55', '2025-02-12 12:00:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('5949fd7a71646b8c3be3e85490e249bbfea24167', 'Energi dan Sumber Daya Mineral Daerah Provinsi Sulawesi Tengah', 'DESDM Sulteng', '2025-02-12 11:59:25', '2025-02-12 11:59:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('5965169ae79f622b85a29c3f7b70ba93e718f0d4', 'Badan Pengelola Keuangan dan Aset Daerah Provinsi Sulawesi Tengah', 'BPKAD Sulteng', '2025-02-12 11:58:05', '2025-02-12 11:58:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('619577ef9777f6503fdd23b17d0794c21f81cd35', 'Badan Kepegawaian Daerah Provinsi Sulawesi Tengah', 'BKD Sulteng', '2025-02-12 11:57:55', '2025-02-12 11:57:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('640b6e5c65a3835437fca8a7dc5f1a9eb71d37e6', 'DINAS KOMINIKASI, INFORMATIKA, PERSANDIAN DAN STATISTIK', 'DISKOMINFO', '2025-03-13 11:01:03', NULL);
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('6686a23dc70f803c723f3e2119ecc7979a244061', 'Biro Administrasi Perekonomian Setda Provinsi Sulawesi Tengah', 'Biro Ekonomi Sulteng', '2025-02-12 12:03:45', '2025-02-12 12:03:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('68b7605db3caef1f9adccf40a35e08cbe7a3f4ec', 'Dinas Perkebunan dan Peternakan Daerah Provinsi Sulawesi Tengah', 'Disbunak Sulteng', '2025-02-12 12:01:45', '2025-02-12 12:01:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('6a674853b7c5e54cd19140c17cca792811418c1b', 'Rumah Sakit Umum Daerah UNDATA', 'RSUD Undata', '2025-02-12 12:05:05', '2025-02-12 12:05:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('6fd95b74eeb739d4f89dff22d4619553aac9f86d', 'Dinas Sosial Daerah Provinsi Sulawesi Tengah', 'Dinsos Sulteng', '2025-02-12 12:02:35', '2025-02-12 12:02:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('738eac1965252fce8879b4e8330249f3a7805144', 'Badan Riset dan Inovasi Daerah Provinsi Sulawesi Tengah', 'Brida Sulteng', '2025-02-12 11:58:25', '2025-02-12 11:58:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('7f8158b7de091c350242946af9aaebb59bf4951a', 'Dinas Kehutanan Daerah Provinsi Sulawesi Tengah', 'Dishut Sulteng', '2025-02-12 11:59:35', '2025-02-12 11:59:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('81ae938dce3ce9dd72ddee0a18cdc72ef3a54caf', 'Biro Organisasi Setda Provinsi Sulawesi Tengah', 'Biro Organisasi Sulteng', '2025-02-12 12:04:25', '2025-02-12 12:04:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('81d34ff19cb808237949c4eb97b7fbfbc71e882a', 'Dinas Pemberdayaan Perempuan dan Perlindungan Anak Daerah Provinsi Sulawesi Tengah', 'DP3A Sulteng', '2025-02-12 11:58:55', '2025-02-12 11:58:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('88f63ff1fcc928275fb82ca2ed4bdfab3c2938e8', 'Dinas Perumahan, Kawasan Permukiman dan Pertanahan Daerah Provinsi Sulawesi Tengah', 'Disperkimtan Sulteng', '2025-02-12 12:02:25', '2025-02-12 12:02:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('9308e1c48ff13eea5974ead68ded9381a2e0a86e', 'Dinas Lingkungan Hidup Daerah Provinsi Sulawesi Tengah', 'DLH Sulteng', '2025-02-12 12:00:25', '2025-02-12 12:00:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('959ca482f3987260a47151bc0e65b218b2a2a053', 'Dinas Pangan Daerah Provinsi Sulawesi Tengah', 'Dinas Pangan Sulteng', '2025-02-12 12:00:45', '2025-02-12 12:00:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('9839d63518cdd1c60d91ea7d1a867458ea85d355', 'Biro Umum Setda Provinsi Sulawesi Tengah', 'Biro Umum Sulteng', '2025-02-12 12:04:35', '2025-02-12 12:04:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('9aa9bf4246b23d88a32b2a3d78b653313302458b', 'Dinas Koperasi dan UMKM Daerah Provinsi Sulawesi Tengah', 'Dinkop UMKM Sulteng', '2025-02-12 12:00:15', '2025-02-12 12:00:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('9d96ed0051325bde885fe36bdbdda79ad5e2658e', 'Dinas Cipta Karya dan Sumber Daya Air Daerah Provinsi Sulawesi Tengah', 'Cikasda Sulteng', '2025-02-12 11:59:15', '2025-02-12 11:59:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('a0273bdaccf0ae9621dfbc422aa50f72f60ecb06', 'Dinas Pengendalian Penduduk dan KB Daerah Provinsi Sulawesi Tengah', 'DP2KB Sulteng', '2025-02-12 12:01:55', '2025-02-12 12:01:55');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('adb7c8b773ef4c90822fae0ea17824b6235d1105', 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu Daerah Provinsi Sulawesi Tengah', 'DPMPTSP Sulteng', '2025-02-12 12:01:05', '2025-02-12 12:01:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('b35abd913c34eb630af419ca52eecb9dbdbf9a95', 'Dinas Kelautan dan Perikanan Daerah Provinsi Sulawesi Tengah', 'DKP Sulteng', '2025-02-12 11:59:45', '2025-02-12 11:59:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('b8761775d1f704dde563c40b0d0e1736a031fc29', 'Dinas Bina Marga dan Penataan Ruang Daerah Provinsi Sulawesi Tengah', 'Bimataru Sulteng', '2025-02-12 11:59:05', '2025-02-12 11:59:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('ba273eab7dc54d995b5ee2ca958b5c447f277d84', 'Sekretariat DPRD Provinsi Sulawesi Tengah', 'Setwan DPRD Sulteng', '2025-02-12 11:57:15', '2025-02-12 11:57:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('c307f7a5e8b996c1fa660bd6f2ed2899d06ea5e8', 'Badan Penanggulangan Bencana Daerah Provinsi Sulawesi Tengah', 'BPBD Sulteng', '2025-02-12 11:58:35', '2025-02-12 11:58:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('c7cab4aba2daf5d075e679cbb1964c51591a04d0', 'Badan Perencanaan Pembangunan Daerah Provinsi Sulawesi Tengah', 'Bappeda Sulteng', '2025-02-12 11:57:35', '2025-02-12 11:57:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('d01a5d5271416cb1eb6c0e03f19e2ac8ef72c6f1', 'Biro Administrasi Kesejahteraan Sosial dan Kemasyarakatan Setda Provinsi Sulawesi Tengah', 'Biro Kesra Sulteng', '2025-02-12 12:04:05', '2025-02-12 12:04:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('d3e50dbec5a2ec941598bc77b3744c659692ce46', 'Dinas Pemuda dan Olahraga Daerah Provinsi Sulawesi Tengah', 'Dispora Sulteng', '2025-02-12 12:01:25', '2025-02-12 12:01:25');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('d9193f6ac2dc1839d234588a751ff0d87d74cf26', 'Dinas Tanaman Pangan dan Hortikultura Daerah Provinsi Sulawesi Tengah', 'DTPH Sulteng', '2025-02-12 12:03:05', '2025-02-12 12:03:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('daeaf6821f866a8957ba4a517cb53b88693e811b', 'Dinas Pemberdayaan Masyarakat dan Desa Daerah Provinsi Sulawesi Tengah', 'DPMD Sulteng', '2025-02-12 12:01:15', '2025-02-12 12:01:15');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('e355d70deaa0490695b1b6f872e9f74f066488fa', 'Dinas Pendidikan Daerah Provinsi Sulawesi Tengah', 'Disdik Sulteng', '2025-02-12 12:01:35', '2025-02-12 12:01:35');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('e6691bb69d9339b0326efc581701063712faf48d', 'Badan Pendapatan Daerah Provinsi Sulawesi Tengah', 'Bapenda Sulteng', '2025-02-12 11:57:45', '2025-02-12 11:57:45');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('f4908ba9cd41d1c207d2702fc46c467edb27aa3e', 'Dinas Kesehatan Daerah Provinsi Sulawesi Tengah', 'Dinkes Sulteng', '2025-02-12 12:00:05', '2025-02-12 12:00:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('f7f2e7addb9b4d046d15dc74675f2e984416df0d', 'Biro Administrasi Pimpinan Setda Provinsi Sulawesi Tengah', 'Biro Adpim Sulteng', '2025-02-12 12:04:45', '2025-02-12 12:04:45');
COMMIT;

-- ----------------------------
-- Table structure for lke_parameter
-- ----------------------------
DROP TABLE IF EXISTS `lke_parameter`;
CREATE TABLE `lke_parameter` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_parameter
-- ----------------------------
BEGIN;
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('1d8486743ebfc9ed52c240082e4c3e5cfa7ef0ad', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:33:07', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('73beda09404211b0a1d7257e9a117d681c747953', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:31:33', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('9d2a1dfcbc89b0fc46cae6c8c3918bbe4855c9df', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:32:06', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ebf4d93e29de2125b7f2c52c4274dfd1d81da0b7', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '9ee30bb303b521b35f6a1b177df2d7b7888a744b', '2025-03-13 11:32:40', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_rb
-- ----------------------------
DROP TABLE IF EXISTS `lke_rb`;
CREATE TABLE `lke_rb` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT ' ',
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `form_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_rb
-- ----------------------------
BEGIN;
INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`, `form_id`) VALUES ('3f8d9cfabaf2a28135dacdc942f6513f0c725652', 'NAMA RB 1', '100', '2025-06-04 14:22:23', NULL, 'fd145710314504e3075a2c7894e89659b75f811c');
INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`, `form_id`) VALUES ('8cf0440082c809805dbc45976a8e9bf65e7b4cb3', 'RB GENERAL PD', '65', '2025-03-13 11:23:46', NULL, '51497dab24601984f92267a5600070e96b8ddfa7');
INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`, `form_id`) VALUES ('a6979d740d638761d21c34fe319e75d13fa4a6b8', 'RB TEMATIK PERANGKAT DAERAH', '35', '2025-03-13 11:24:17', NULL, '51497dab24601984f92267a5600070e96b8ddfa7');
COMMIT;

-- ----------------------------
-- Table structure for lke_role
-- ----------------------------
DROP TABLE IF EXISTS `lke_role`;
CREATE TABLE `lke_role` (
  `Uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_role
-- ----------------------------
BEGIN;
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('08a62fdb70f816447cbb4488ed1626653233851f', '49bc74a69d7256191ab4d953a6516e73c70f08db', '2025-03-13 11:09:13', NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', NULL, NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('c895f123acea93c7dc34d334eadf6cf086474170', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('a8dfbd890507edce5df5425d990883ad144967fd', 'ae7deb37b1eac722afda8c431c677662afd57af9', '2025-03-13 04:46:43', NULL, '05c3a4feeca1677fc6efe39a7efa9d37bb3db84a');
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', '618d4897a69c737080de4216b15b64e1909ecba0', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_roles
-- ----------------------------
DROP TABLE IF EXISTS `lke_roles`;
CREATE TABLE `lke_roles` (
  `RoleId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `RoleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `acs` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_roles
-- ----------------------------
BEGIN;
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('49bc74a69d7256191ab4d953a6516e73c70f08db', 'Super Admin', '2025-01-07 11:55:47', NULL, '1');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('618d4897a69c737080de4216b15b64e1909ecba0', 'User', '2025-01-07 13:57:02', NULL, '5');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('8fdad4894c55a3dbfb4fe280c02bd55512df3803', 'Soal', '2025-01-07 13:56:55', NULL, '3');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('ae7deb37b1eac722afda8c431c677662afd57af9', 'Penilai', '2025-01-07 13:56:45', NULL, '2');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('cfcc17f00a840c2bf60d19ab5e2975ae52fb6c00', 'Verifikator', '2025-01-28 08:53:04', NULL, '4');
COMMIT;

-- ----------------------------
-- Table structure for lke_sub_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_sub_aspek`;
CREATE TABLE `lke_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_sub_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('05c3a4feeca1677fc6efe39a7efa9d37bb3db84a', 'Tingkat Kematangan SPBE Perangkat Daerah', '2025-03-13 11:28:00', NULL, 'e4f5574bb633fe896a42d7f75d57bbb0a947894a', '6');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('95084fddd944b9680938ae42f216e9755f1abf60', 'nama sub aspelk', '2025-06-04 14:23:41', NULL, '5a6bd3bb04881db622fbacfd4222bb12ebe16cc4', '100');
COMMIT;

-- ----------------------------
-- Table structure for lke_sub_sub_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_sub_sub_aspek`;
CREATE TABLE `lke_sub_sub_aspek` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_sub_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `id_sub_aspek` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_sub_sub_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('051d12e3ad56c4a8b87415df29add04a3ae69802', 'Tingkat Kematangan Kapabilitas Proses', '2025-03-13 11:28:49', NULL, '05c3a4feeca1677fc6efe39a7efa9d37bb3db84a', '50');
COMMIT;

-- ----------------------------
-- Table structure for lke_tahun
-- ----------------------------
DROP TABLE IF EXISTS `lke_tahun`;
CREATE TABLE `lke_tahun` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_tahun
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_upload_bukti
-- ----------------------------
DROP TABLE IF EXISTS `lke_upload_bukti`;
CREATE TABLE `lke_upload_bukti` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `files` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_upload_bukti
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lke_user
-- ----------------------------
DROP TABLE IF EXISTS `lke_user`;
CREATE TABLE `lke_user` (
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FullName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PassEnc` varbinary(255) DEFAULT NULL,
  `Phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EmailAdds` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `actv` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_user
-- ----------------------------
BEGIN;
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('08a62fdb70f816447cbb4488ed1626653233851f', 'admin', 'super admin', 0xD69AEAED31B2EF9D2D4338276965F075, '-', 'admin@surabe.com', '2025-03-13 11:09:13', NULL, 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('8a6874dbfd3f52cae02d5f387f5605b4d671e2ac', 'dprd', 'dprd', 0xD69AEAED31B2EF9D2D4338276965F075, '93278923424242', 'dprd@mail.com', '2025-05-15 07:02:00', '2025-05-15 15:02:00', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('a8dfbd890507edce5df5425d990883ad144967fd', 'penilai', 'PENILAI', 0xD69AEAED31B2EF9D2D4338276965F075, '0987654321', 'penilai@mail.com', '2025-03-13 04:46:43', '2025-03-13 12:46:43', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('ba314087a5f23dca7e4c4abc3e55fc74bb3c341a', 'madani', 'MADANI', 0xD69AEAED31B2EF9D2D4338276965F075, '0987654321', 'madani@mail.com', '2025-03-13 03:42:15', '2025-03-13 11:42:15', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('c895f123acea93c7dc34d334eadf6cf086474170', 'undata', 'UNDATA', 0xD69AEAED31B2EF9D2D4338276965F075, '0987654321', 'undata@mail.com', '2025-03-13 03:41:41', '2025-03-13 11:41:41', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('cc8f678d9dcc320d8a60cb307b6304564f5b7f33', 'soal', 'Pengisi Soal', 0xD69AEAED31B2EF9D2D4338276965F075, '0987654321', 'soal@surabe.com', '2025-03-13 03:11:55', '2025-03-13 11:11:55', 'TRUE');
COMMIT;

-- ----------------------------
-- Procedure structure for Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Aspek_add_edit`(uidx VARCHAR(255),idx VARCHAR(255),nmas VARCHAR(255), bbt VARCHAR(255), rbx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Bukti_dukung_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Bukti_dukung_add_edit`;
delimiter ;;
CREATE PROCEDURE `Bukti_dukung_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), idindk VARCHAR(255), bkdk VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Bukti_dukung_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Bukti_dukung_delete`;
delimiter ;;
CREATE PROCEDURE `Bukti_dukung_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Function structure for EncPass
-- ----------------------------
DROP FUNCTION IF EXISTS `EncPass`;
delimiter ;;
CREATE FUNCTION `EncPass`(psxc VARCHAR(255))
 RETURNS varbinary(255)
BEGIN
  #Routine body goes here...
	DECLARE EncPs VARBINARY(255);
-- 	SET EncPs = AES_ENCRYPT(psxc,UNHEX(SHA2('EVALUASISPBEOPD2025',256)),'E31C32B22EA452B0F2959E296827CE59');
	SET EncPs = AES_ENCRYPT(psxc,UNHEX(SHA2('EVALUASISPBEOPD2025',256)),'', 'hkdf','JAN2025', 'DISKOMINFOSULTENG' );
RETURN EncPs;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Form_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Form_add_edit`;
delimiter ;;
CREATE PROCEDURE `Form_add_edit`(uidx VARCHAR(255), idx VARCHAR(255),nmx VARCHAR(255), thnx VARCHAR(255), desk VARCHAR(255), evls VARCHAR(255),
 btwkt DATETIME)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Form_add_edit2
-- ----------------------------
DROP PROCEDURE IF EXISTS `Form_add_edit2`;
delimiter ;;
CREATE PROCEDURE `Form_add_edit2`(uidx VARCHAR(255), idx VARCHAR(255),nmx VARCHAR(255), thnx VARCHAR(255), desk VARCHAR(255), evls VARCHAR(255),
 btwkt DATETIME)
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Form_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Form_delete`;
delimiter ;;
CREATE PROCEDURE `Form_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Jawaban_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Jawaban_add_edit`;
delimiter ;;
CREATE PROCEDURE `Jawaban_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), jwb VARCHAR(255), idindx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Jawaban_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Jawaban_delete`;
delimiter ;;
CREATE PROCEDURE `Jawaban_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Jenis_Jawaban_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Jenis_Jawaban_add_edit`;
delimiter ;;
CREATE PROCEDURE `Jenis_Jawaban_add_edit`(uidx VARCHAR(255),idx VARCHAR(255), jnjwb VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Jenis_Jawaban_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Jenis_Jawaban_delete`;
delimiter ;;
CREATE PROCEDURE `Jenis_Jawaban_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for log_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `log_user`;
delimiter ;;
CREATE PROCEDURE `log_user`(uidx VARCHAR(255), ipx VARCHAR(255), stsx VARCHAR(255))
BEGIN
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

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Parameter_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Parameter_add_edit`;
delimiter ;;
CREATE PROCEDURE `Parameter_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), nmpar TEXT, idind VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Parameter_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Parameter_delete`;
delimiter ;;
CREATE PROCEDURE `Parameter_delete`(uidx VARCHAR(255), idx VARCHAR(255), idk VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Rb_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Rb_add_edit`;
delimiter ;;
CREATE PROCEDURE `Rb_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), nmx VARCHAR(255), bbt VARCHAR(255),frmx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Rb_delete
-- ----------------------------
DROP PROCEDURE IF EXISTS `Rb_delete`;
delimiter ;;
CREATE PROCEDURE `Rb_delete`(uidx VARCHAR(255), idx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for upload_bukti_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `upload_bukti_add_edit`;
delimiter ;;
CREATE PROCEDURE `upload_bukti_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), idbkt VARCHAR(255), flnm VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for User_Update_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `User_Update_data`;
delimiter ;;
CREATE PROCEDURE `User_Update_data`(uidx VARCHAR(255), uname VARCHAR(255), fname VARCHAR(255), phn VARCHAR(255), eml VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Aspek
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Aspek`;
delimiter ;;
CREATE PROCEDURE `View_Aspek`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Bukti_dukung
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Bukti_dukung`;
delimiter ;;
CREATE PROCEDURE `View_Bukti_dukung`(idx VARCHAR(255),uidx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Dashboard_Soal
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Dashboard_Soal`;
delimiter ;;
CREATE PROCEDURE `View_Dashboard_Soal`()
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Dashboard_User
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Dashboard_User`;
delimiter ;;
CREATE PROCEDURE `View_Dashboard_User`(uidx VARCHAR(255), thnx VARCHAR(255), aprv VARCHAR(255))
BEGIN
  #Routine body goes here...
	
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
-- 			b.tahapan,
			b.bobot AS bobot_aspek,
			d.nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			e.nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			f.indikator,
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
-- 			b.tahapan,
			b.bobot AS bobot_aspek,
			d.nama_sub_aspek,
			d.bobot AS bobot_subAspek,
			e.nama_sub_sub_aspek,
			e.bobot AS bobot_subSubAspek,
			f.indikator,
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
			WHERE h.tahun = thnx AND f.id IN (SELECT id_indikator FROM lke_parameter);
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Data_List_Soal
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Data_List_Soal`;
delimiter ;;
CREATE PROCEDURE `View_Data_List_Soal`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
			ORDER BY g.create_at DESC LIMIT lmtx OFFSET ofset;
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
				ORDER BY f.create_at DESC LIMIT lmtx OFFSET ofset;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_File_For_Upload
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_File_For_Upload`;
delimiter ;;
CREATE PROCEDURE `View_File_For_Upload`(idx VARCHAR(255),uidx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Forms
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Forms`;
delimiter ;;
CREATE PROCEDURE `View_Forms`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Indikator
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Indikator`;
delimiter ;;
CREATE PROCEDURE `View_Indikator`(idx VARCHAR(255),uidx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Jawaban
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Jawaban`;
delimiter ;;
CREATE PROCEDURE `View_Jawaban`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Jawaban_By_OPD
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Jawaban_By_OPD`;
delimiter ;;
CREATE PROCEDURE `View_Jawaban_By_OPD`(IN idx VARCHAR(255), 
    IN id_opd VARCHAR(255),  -- Tambahkan parameter untuk ID OPD
    IN lmt VARCHAR(255), 
    IN ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Jenis_Jawaban
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Jenis_Jawaban`;
delimiter ;;
CREATE PROCEDURE `View_Jenis_Jawaban`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_List_Data_Soal_User
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_List_Data_Soal_User`;
delimiter ;;
CREATE PROCEDURE `View_List_Data_Soal_User`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255), uidx VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Opd
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Opd`;
delimiter ;;
CREATE PROCEDURE `View_Opd`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Parameter
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Parameter`;
delimiter ;;
CREATE PROCEDURE `View_Parameter`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Penilaian_Mandiri
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Penilaian_Mandiri`;
delimiter ;;
CREATE PROCEDURE `View_Penilaian_Mandiri`(thn VARCHAR(255), uidx VARCHAR(255))
BEGIN
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
	WHERE a.tahun = thn AND a.active = 1
	ORDER BY a.create_at;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Rb
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Rb`;
delimiter ;;
CREATE PROCEDURE `View_Rb`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
  #Routine body goes here...
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
		
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Roles
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Roles`;
delimiter ;;
CREATE PROCEDURE `View_Roles`()
BEGIN
  #Routine body goes here...
	SELECT * FROM lke_roles
	ORDER BY acs ASC;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Sub_Aspek
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Sub_Aspek`;
delimiter ;;
CREATE PROCEDURE `View_Sub_Aspek`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
			
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_sub_sub_aspek
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_sub_sub_aspek`;
delimiter ;;
CREATE PROCEDURE `View_sub_sub_aspek`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_UploadFile
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_UploadFile`;
delimiter ;;
CREATE PROCEDURE `View_UploadFile`(idx VARCHAR(255),uidx VARCHAR(255), idind VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Users
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Users`;
delimiter ;;
CREATE PROCEDURE `View_Users`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
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
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
