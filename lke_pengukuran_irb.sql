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

 Date: 23/01/2025 13:02:50
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
  `tahun` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_form` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `evaluasi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `batas_waktu` datetime DEFAULT NULL,
  `tahapan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`) VALUES ('0d94dc2a709e6902b75bb2bbdb03c64b754f6061', 'Capaian Sasaran Strategis', '2025-01-07 15:21:08', NULL, '100', '2025', 'Evaluasi SPBE ', 'Evaluasi SPBE 2025', 'Evaluasi', '2025-01-31 11:06:50', NULL);
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`) VALUES ('50f4b22980b235473e0aec170a1d7674d9c1cf8b', 'nama aspeknya', '2025-01-22 14:37:56', NULL, '100', '2026', 'Evaluasi SOPBE 2026', 'Deskripsinya ', 'Evaluasi SPBE', '2025-02-01 14:37:00', '');
COMMIT;

-- ----------------------------
-- Table structure for lke_bukti_dukung
-- ----------------------------
DROP TABLE IF EXISTS `lke_bukti_dukung`;
CREATE TABLE `lke_bukti_dukung` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bukti_dukung` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_bukti_dukung
-- ----------------------------
BEGIN;
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('5017aab44f2e1a342e1ffb695c221963cf774398', '123338438afd46814a983f6dd03618590f3c651a', 'apalah', '2025-01-22 15:42:16', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('d9ed9ac462344cdeeb684b937b68b6ff625f7d7a', 'd8a56e0d7385ab924e714644a879d617ec28ff91', 'Dokumen Okupasi Pemetaan Kompetensi SDM TIK PD', '2025-01-22 11:32:15', NULL);
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
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('123338438afd46814a983f6dd03618590f3c651a', '32da4f783e3ae10d3c5397b70286d2cf0da24e10', 'nama indikatornya', '2025-01-22 14:39:17', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-01-16 13:04:21', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('374367084e673af84bcbf2f998198f6e2e02770d', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Manajemen Risiko SPBE', '2025-01-17 13:15:42', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menggunakan Sistem Penghubung Layanan Pemerintah Daerah', '2025-01-17 13:15:15', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('4abb0d7caa97e312fd7bc64f9c546c8aac281776', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melaksanakan Manajemen Data', '2025-01-17 13:16:28', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('57582a6e64400efe1f3cf9d9b7ba026dc76e9b51', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah terdapat Tim Pelaksana SPBE Perangkat Daerah', '2025-01-17 13:15:28', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('7da5fbc0249bd6ea50b43fac211ae09911eba00e', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-01-16 13:36:47', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('8435c182e666a3078b9406a9291767a4e5553a05', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Manajemen Aset TIK', '2025-01-17 13:16:40', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('8de2575da7ddfcb955d14e62558d057fd37f3cea', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah memanfaatkan Layanan Pusat Data Pemerintah Daerah', '2025-01-17 13:13:43', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('9024b1bbd1b0dce4e0f0bc02eb53a57e5e1321c6', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Tanda Tangan Elektronik pada Naskah Dokumen Elektronik', '2025-01-17 13:16:13', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah mengalokasikan anggaran pelaksanaan SPBE setiap tahunnya', '2025-01-17 11:37:54', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan proses pembangunan Aplikasi SPBE sesuai siklus pembangunan aplikasi', '2025-01-17 13:11:58', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('b867ddd425115a848c40deb6631c671efb3af975', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melakukan self-assessment Indeks KAMI', '2025-01-17 13:15:55', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-17 13:14:58', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('d39a3d69e310f99b1f244bc750956ee64c8a7bc0', '81510049dbd401f5f40714a0e289c94df3616532', 'Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-01-21 15:29:37', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('d8a56e0d7385ab924e714644a879d617ec28ff91', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah dilakukan pemenuhan kompetensi Sumber Daya Manusia TIK', '2025-01-17 13:16:52', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('db7b9d7ccdeedc960210ce3347895d1397dfa347', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-01-17 13:10:15', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
COMMIT;

-- ----------------------------
-- Table structure for lke_jawaban
-- ----------------------------
DROP TABLE IF EXISTS `lke_jawaban`;
CREATE TABLE `lke_jawaban` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Jawaban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_indikator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
-- Table structure for lke_Jenis_Jawaban
-- ----------------------------
DROP TABLE IF EXISTS `lke_Jenis_Jawaban`;
CREATE TABLE `lke_Jenis_Jawaban` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_jawaban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `num` int DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_Jenis_Jawaban
-- ----------------------------
BEGIN;
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('2908a111a94b52d770dbe8db5800d71706463811', 'Skala Linear', 2, '2025-01-10 14:40:06', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'Pilihan Ganda', 1, '2025-01-10 14:32:35', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'Ya/Tidak', 3, '2025-01-16 13:39:02', NULL);
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
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0932fe503e8a680caa87647f08e322d390fd5125', '2025-01-17 13:19:12', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Sistem Penghubung Layanan Pemerintah Daerah', '2025-01-17 13:19:12');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '2025-01-07 15:21:08', 'INSERT', 'administrator', 'Tambah Data Aspek : Capaian Sasaran Strategis Bobot : 100', '2025-01-07 15:21:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('15545e9f68fc9f11e2c090db6646879a61e2b4ec', '2025-01-17 13:10:44', 'INSERT', 'administrator', 'Tambah Data Parameter : Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', '2025-01-17 13:10:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('161592987a6e85820f20a0df5297245df808e07e', '2025-01-17 13:05:39', 'INSERT', 'administrator', 'Tambah Data Parameter : Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', '2025-01-17 13:05:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('17fd850a367a6c2d45f29ff28054e76be1b11468', '2025-01-08 20:55:35', 'INSERT', 'administrator', 'Tambah Data OPD  : tesajah', '2025-01-08 20:55:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('18f50f48cdc51492c44eb58835f5621044400fd2', '2025-01-17 13:11:13', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-01-17 13:11:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1c944b7f832167d2e9478199d61cee29a966b6f5', '2025-01-16 13:36:47', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-01-16 13:36:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1f5fae9e9befdeee9ecb8df55f21b40135030c2d', '2025-01-16 13:09:05', 'INSERT', 'administrator', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2025-01-16 13:09:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2115b6974d6c936a962ba9a7404fd5108b28c575', '2025-01-17 13:21:51', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Manajemen Aset TIK', '2025-01-17 13:21:51');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('21a6f2a121235fa1da2f9a0eeee73f62005c5133', '2025-01-17 13:13:43', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah memanfaatkan Layanan Pusat Data Pemerintah Daerah', '2025-01-17 13:13:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('273b4d746b31f607508b4c2866d3299d9db9f9cc', '2025-01-17 11:37:54', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah mengalokasikan anggaran pelaksanaan SPBE setiap tahunnya', '2025-01-17 11:37:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('27d962d511c3512103b51c653eb4c9cccd906517', '2025-01-17 13:10:15', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-01-17 13:10:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2a472681abd19448a768af4e88619945771c2ecd', '2025-01-17 13:20:45', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', '2025-01-17 13:20:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2ceabf5abf1837754bf02a20da948c87703423e9', '2025-01-17 11:44:18', 'INSERT', 'administrator', 'Tambah Data Parameter : Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', '2025-01-17 11:44:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3efbcd0e5a0ea72404d810897dc26c563657673e', '2025-01-17 13:21:30', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Dokumen Manajemen Data (mencakup pengelolaan arsitektur data (bid. statistik), data induk, data referensi (tiap PD berbeda, mengacu ke pusat), basis data, kualitas data (data ada di JDS), dan interoperabilitas data) ', '2025-01-17 13:21:30');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4b9a75bc10d79a749fd97448941c3488b55fc9c7', '2025-01-17 13:12:34', 'INSERT', 'administrator', 'Tambah Data Parameter : Proses pembangunan/ pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', '2025-01-17 13:12:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5107305d09cdbdf4976111f84c7a4911293c9a82', '2025-01-17 13:16:13', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menerapkan Tanda Tangan Elektronik pada Naskah Dokumen Elektronik', '2025-01-17 13:16:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('536d054a3ef8b2be00e7629b94765bd74a3ddba4', '2025-01-17 13:14:27', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Layanan Pusat Data Pemerintah Daerah', '2025-01-17 13:14:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('557abc5ff6ab2481f7f60d094dcd445fbf667d4b', '2025-01-22 11:31:37', 'ERROR', 'System', 'add Jawaban :Unknown column \'idjwb\' in \'where clause\'', '2025-01-22 11:31:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5b6735a165c84da340d85e9cf9b3586e685a1ca0', '2025-01-17 13:16:40', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menerapkan Manajemen Aset TIK', '2025-01-17 13:16:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6190b829b403c3e7edc9707ef50b133f0a20993e', '2025-01-16 11:55:49', 'INSERT', 'administrator', 'Tambah Data Aspek : Capaian Pelaksanaan Kebijakan RB Bobot : 100', '2025-01-16 11:55:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('63f2e5ede4ad6abc50b7e6f9423881119cec0145', '2025-01-17 13:20:28', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Dokumen Manajemen Risiko SPBE', '2025-01-17 13:20:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('644df1d523a9d71af1dbc292a046b5be1bd6a9a6', '2025-01-17 13:19:51', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', '2025-01-17 13:19:51');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('66ae75710912c3842a6ede4f28848127c87f8fb1', '2025-01-16 13:08:35', 'INSERT', 'administrator', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2025-01-16 13:08:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('682ccaf47b4270e3f65334007eb30f3e60c7a8fb', '2025-01-22 14:38:22', 'INSERT', 'administrator', 'Tambah Data Sub Aspek : nama sub aspek Bobot : 100', '2025-01-22 14:38:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('69bf1736a37e4ebba36f27a4a5e567ca76dfce09', '2025-01-16 13:08:14', 'INSERT', 'administrator', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2025-01-16 13:08:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6bf7bcc87c3af2ef277c1e2334a503cc155dee91', '2025-01-22 11:32:15', 'INSERT', 'administrator', 'Tambah Data Bukti Dukung : Dokumen Okupasi Pemetaan Kompetensi SDM TIK PD ,Indikator  : d8a56e0d7385ab924e714644a879d617ec28ff91', '2025-01-22 11:32:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6bfe7de35b487135f8cfe0ab3efef486462346be', '2025-01-17 13:15:15', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menggunakan Sistem Penghubung Layanan Pemerintah Daerah', '2025-01-17 13:15:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6e6472e9173db07ecd0e3c04aba7e668d2b8f04d', '2025-01-22 14:39:36', 'INSERT', 'administrator', 'Tambah Data Parameter : nama parametrnya', '2025-01-22 14:39:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7229bce2230b49e3cab4afeeb8d4e486aabda672', '2025-01-07 14:43:47', 'UPDATE', 'administrator', 'Update Data OPD  : DISKOMINFOSANTIK', '2025-01-07 14:43:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7e837a5f73ef82fcda2078d4e0d408284d48414f', '2025-01-16 11:54:39', 'INSERT', 'administrator', 'Tambah Data Aspek : Capaian Pelaksanaan Kebijakan RB Bobot : 100', '2025-01-16 11:54:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('81510049dbd401f5f40714a0e289c94df3616532', '2025-01-10 11:29:04', 'INSERT', 'administrator', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Layanan Bobot : 30', '2025-01-10 11:29:04');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('81de2c127b7a519f438589e48950cc32097355ec', '2025-01-17 13:14:58', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-17 13:14:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('88051fe016645359530a7d30618ac3f6bf1ce4cd', '2025-01-17 13:22:15', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', '2025-01-17 13:22:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8be0400d5cff585da10711e0807eb596076f785c', '2025-01-21 15:29:37', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-01-21 15:29:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8cd1af04c6f488666bb5055ded9ccd399c12270a', '2025-01-17 13:15:55', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah melakukan self-assessment Indeks KAMI', '2025-01-17 13:15:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8ce0643a28c6aa73c8a2b8af55ecf09ded048317', '2025-01-17 13:11:58', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menerapkan proses pembangunan Aplikasi SPBE sesuai siklus pembangunan aplikasi', '2025-01-17 13:11:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8d2a7aab81b2f5d6125706560623c3aae509401f', '2025-01-17 13:03:28', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', '2025-01-17 13:03:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9db2df5f1326c591a809d00b35d6845258a9f5a6', '2025-01-17 13:10:59', 'INSERT', 'administrator', 'Tambah Data Parameter : Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', '2025-01-17 13:10:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9e65a2e119ae38e81cd1bc498467477f431632f9', '2025-01-10 14:39:00', 'ERROR', 'System', 'add Aspek :You can\'t specify target table \'lke_Jenis_Jawaban\' for update in FROM clause', '2025-01-10 14:39:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9f4982610c48cb62c81883f90954397e845c1f46', '2025-01-17 13:15:42', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah menerapkan Manajemen Risiko SPBE', '2025-01-17 13:15:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', '2025-01-07 19:10:31', 'INSERT', 'administrator', 'Tambah Data Berhasil : user Full Name : user', '2025-01-10 13:25:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a42044d556d08536730256e32b8e9f38ea5a4edd', '2025-01-17 13:13:10', 'INSERT', 'administrator', 'Tambah Data Parameter : Perangkat Daerah konsultasi dengan Diskominfo dalam proses Pembangunan/ Pengembangan Aplikasi ', '2025-01-17 13:13:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a4b65f2efda348dd7dc8756a3998ca80bb5a237f', '2025-01-17 13:07:02', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', '2025-01-17 13:07:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b2204176be358b5295f436706d740b9dd18348bd', '2025-01-22 15:42:16', 'INSERT', 'administrator', 'Tambah Data Bukti Dukung : apalah ,Indikator  : 123338438afd46814a983f6dd03618590f3c651a', '2025-01-22 15:42:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bbf8c36c281c64eff17638077fef1df249362961', '2025-01-17 13:11:25', 'INSERT', 'administrator', 'Tambah Data Parameter : Sudah Memiliki Peta Proses Bisnis', '2025-01-17 13:11:25');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', '2025-01-07 13:47:03', 'INSERT', NULL, 'Tambah Data Berhasil : administrator Full Name : Super Admin', '2025-01-07 13:47:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c0d12296859859d8a149c1bc74e3613c6f621225', '2025-01-10 11:29:44', 'INSERT', 'administrator', 'Tambah Data Sub Sub Aspek : Penyelenggaraan Statistik Sektoral Bobot : 20', '2025-01-10 11:29:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c19bc65d2b83d71ba794723feb3c87fb29db71ea', '2025-01-17 13:16:52', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah dilakukan pemenuhan kompetensi Sumber Daya Manusia TIK', '2025-01-17 13:16:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c5d5d6d5e388a25ca6868807b648d87d474bdaae', '2025-01-17 13:16:28', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah melaksanakan Manajemen Data', '2025-01-17 13:16:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d323f6db37542ede4c850531478e39bf0d5ac660', '2025-01-16 13:39:02', 'INSERT', 'administrator', 'Tambah Data Jenis Jawaban : Ya/Tidak Nomor : 3', '2025-01-16 13:39:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d34529179bed3b05fcc46501b1d5a776701aba2a', '2025-01-17 13:12:58', 'INSERT', 'administrator', 'Tambah Data Parameter : Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', '2025-01-17 13:12:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d54cd4c21fe643907dd2b2eefd856cdb31e3a88f', '2025-01-21 15:30:06', 'INSERT', 'administrator', 'Tambah Data Parameter : Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi perencanaan', '2025-01-21 15:30:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d615d604113db9d5c5624a837b9df2798c76b9ea', '2025-01-16 13:04:21', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-01-16 13:04:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d7670cf22a9a19154d932875f68dce442db797a4', '2025-01-22 14:39:17', 'INSERT', 'administrator', 'Tambah Data Indikator : nama indikatornya', '2025-01-22 14:39:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d9dfb23d83628dae0cf31b5e86e388d74c71d9f4', '2025-01-16 13:08:51', 'INSERT', 'administrator', 'Tambah Data Parameter : Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2025-01-16 13:08:51');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('dfa101730e5a74d76a401f372feca8412ec6c8d8', '2025-01-22 14:37:56', 'INSERT', 'administrator', 'Tambah Data Aspek : nama aspeknya Bobot : 100', '2025-01-22 14:37:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', '2025-01-07 15:27:54', 'INSERT', 'administrator', 'Tambah Data Sub Sub Aspek : Tingkat Kematangan Kapabilitas Proses Bobot : 100', '2025-01-07 15:27:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e372838de68e9a4ee5c8378452c640599d5beeae', '2025-01-17 13:18:29', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat aktivitas penggunaan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-17 13:18:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e48d1a7bc22dd82154396da7de879e7a725a1304', '2025-01-17 13:21:08', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-01-17 13:21:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e5343d9ab79b46e6754a6b4a0533425069e07240', '2025-01-16 13:37:48', 'INSERT', 'administrator', 'Tambah Data Parameter : Terdapat dokumen peta rencana (roadmap) SPBE ', '2025-01-16 13:37:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '2025-01-07 15:25:53', 'INSERT', 'administrator', 'Tambah Data Sub Aspek : Tingkat Kematangan SPBE Perangkat Daerah Bobot : 100', '2025-01-07 15:25:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ee15484b3827c2b00d2fcbd22a39cc4a1a0d79ae', '2025-01-17 13:15:28', 'INSERT', 'administrator', 'Tambah Data Indikator : Telah terdapat Tim Pelaksana SPBE Perangkat Daerah', '2025-01-17 13:15:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f0dc55976676c13304f0fc322812d091dfbd7824', '2025-01-07 14:43:22', 'INSERT', 'administrator', 'Tambah Data OPD  : DISKOMINFO', '2025-01-07 14:43:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f72f440a9212096f27e4dc6f90e8b697aa60b412', '2025-01-22 14:38:50', 'INSERT', 'administrator', 'Tambah Data Sub Sub Aspek : nama sub sub aspeknya Bobot : 50', '2025-01-22 14:38:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fb9beae7e3dc75c0aff726a35cb2858b2943fa27', '2025-01-17 13:12:47', 'INSERT', 'administrator', 'Tambah Data Parameter : Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', '2025-01-17 13:12:47');
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
INSERT INTO `lke_opd` (`id`, `nama_opd`, `create_at`, `update_at`) VALUES ('17fd850a367a6c2d45f29ff28054e76be1b11468', 'tesajah', '2025-01-08 20:55:35', NULL);
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
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('00dcacfd0dd99d456c3ec1f9a21302223403c748', 'Terdapat Dokumen Manajemen Data (mencakup pengelolaan arsitektur data (bid. statistik), data induk, data referensi (tiap PD berbeda, mengacu ke pusat), basis data, kualitas data (data ada di JDS), dan interoperabilitas data) ', '4abb0d7caa97e312fd7bc64f9c546c8aac281776', '2025-01-17 13:21:30', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('00e763860f1f9b1025732b79980f1b7370e46c52', 'Perangkat Daerah konsultasi dengan Diskominfo dalam proses Pembangunan/ Pengembangan Aplikasi ', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:13:10', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('0b104b0abaaf9c61d3a29eb9d55f1a56a049823e', 'Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:07:02', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('1550920921b701a11edab7d646e66e549548c859', 'Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', 'd8a56e0d7385ab924e714644a879d617ec28ff91', '2025-01-17 13:22:15', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('15e972b180ccf97e4313c198cf95b2c335454e67', 'Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:10:44', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('1b3ba97b13df5e0f71750cf5f79ea9cbf211c4c6', 'Terdapat Dokumen Manajemen Risiko SPBE', '374367084e673af84bcbf2f998198f6e2e02770d', '2025-01-17 13:20:28', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('28354703a22c7f2cb17900af7d4b22fd24373ccf', 'Proses pembangunan/ pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:34', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('29805b986f273119e139de3443ea4a7b40282ee5', 'Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', 'b867ddd425115a848c40deb6631c671efb3af975', '2025-01-17 13:20:45', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3322bc4f397ba50978ba2c32ec99de714d3b6f99', 'Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:10:59', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3bbd6314e1bc4e02d773dc7f37cf4877520a56b4', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:09:05', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3f57ba5f1f04d1b60b02d1ade89536e5c5bb3b9f', 'Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:05:39', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('5c66f10a6b0be41013e0dbbb95a3119f3d900cec', 'Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:47', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('5d3810440701af9dd4f9145197d321cc5ca5c6a0', 'Terdapat Dokumen/Laporan Manajemen Aset TIK', '8435c182e666a3078b9406a9291767a4e5553a05', '2025-01-17 13:21:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('65a1b03f3997cd2374eee79a30e439da2d683b02', 'Terdapat aktivitas penggunaan Layanan Jaringan Intra Pemerintah Daerah', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', '2025-01-17 13:18:29', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('792bdad9dfdbe4ab166ebfb6a67f992bc55bbb98', 'Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi perencanaan', 'd39a3d69e310f99b1f244bc750956ee64c8a7bc0', '2025-01-21 15:30:06', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('930af2b030555b911d7d64043f3a7b768d0e251c', 'Terdapat aktivitas penggunaan Sistem Penghubung Layanan Pemerintah Daerah', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', '2025-01-17 13:19:12', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('9d836e97b2d37d445c2e50bdc3735e3646b52a83', 'Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '9024b1bbd1b0dce4e0f0bc02eb53a57e5e1321c6', '2025-01-17 13:21:08', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('a1d4902c462b55d1bce1629e071f3394dda8a7ef', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:14', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('af52cc01457e3eba7c9a52e5f9be4c0704e021ff', 'Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', '57582a6e64400efe1f3cf9d9b7ba026dc76e9b51', '2025-01-17 13:19:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('bf25fc91ea29e730d97b5636396772fd97519de8', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('c066050688723f1fbf6084244afd86aa8e49d2fd', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:35', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('c7231afee6a9bc39c1a110635a0e101b26339e62', 'Terdapat aktivitas penggunaan Layanan Pusat Data Pemerintah Daerah', '8de2575da7ddfcb955d14e62558d057fd37f3cea', '2025-01-17 13:14:27', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('cceee1544b9f881b983a2ccc596d3825a76d7d4f', 'Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 11:44:18', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('d2f23a2e9177dc07c8b233b69a9906094b66970b', 'nama parametrnya', '123338438afd46814a983f6dd03618590f3c651a', '2025-01-22 14:39:36', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('d69345353d64290432fa681bc68972d4f5f5aad3', 'Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:03:28', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('d727716d08b319bfa184a2b227bacb6c6d5d1b95', 'Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:11:13', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ea6500c96f48ae31b6c235d10dba92b9b6f838f9', 'Terdapat dokumen peta rencana (roadmap) SPBE ', '7da5fbc0249bd6ea50b43fac211ae09911eba00e', '2025-01-16 13:37:48', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('fb1fe5cb5d6f8487e7944a412ac9fe291111811e', 'Sudah Memiliki Peta Proses Bisnis', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:11:25', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ff55b3437e44f8fc0188bdf45df91127ee77d571', 'Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:58', NULL);
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
  `acs` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_roles
-- ----------------------------
BEGIN;
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('49bc74a69d7256191ab4d953a6516e73c70f08db', 'Super Admin', '2025-01-07 11:55:47', NULL, '1');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('618d4897a69c737080de4216b15b64e1909ecba0', 'User', '2025-01-07 13:57:02', NULL, '4');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('8fdad4894c55a3dbfb4fe280c02bd55512df3803', 'Soal', '2025-01-07 13:56:55', NULL, '3');
INSERT INTO `lke_roles` (`RoleId`, `RoleName`, `Create_at`, `Update_at`, `acs`) VALUES ('ae7deb37b1eac722afda8c431c677662afd57af9', 'Penilai', '2025-01-07 13:56:45', NULL, '2');
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
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('572a502a62ab5241d2e05c743def9df76fcac29c', 'nama sub aspek', '2025-01-22 14:38:22', NULL, '50f4b22980b235473e0aec170a1d7674d9c1cf8b', '100');
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
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('32da4f783e3ae10d3c5397b70286d2cf0da24e10', 'nama sub sub aspeknya', '2025-01-22 14:38:50', NULL, '572a502a62ab5241d2e05c743def9df76fcac29c', '50');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('81510049dbd401f5f40714a0e289c94df3616532', 'Tingkat Kematangan Kapabilitas Layanan', '2025-01-10 11:29:04', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '30');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('c0d12296859859d8a149c1bc74e3613c6f621225', 'Penyelenggaraan Statistik Sektoral', '2025-01-10 11:29:44', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '20');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Tingkat Kematangan Kapabilitas Proses', '2025-01-07 15:27:54', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '50');
COMMIT;

-- ----------------------------
-- Table structure for lke_tahun
-- ----------------------------
DROP TABLE IF EXISTS `lke_tahun`;
CREATE TABLE `lke_tahun` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `files` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_bukti` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
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
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', 'user', 0x7EF5AEF6EC64ED55130AFF0AA468981B, '-', '-', '2025-01-07 19:10:31', NULL);
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', 'administrator', 'Super Admin', 0xD69AEAED31B2EF9D2D4338276965F075, '-', '-', '2025-01-07 13:47:03', NULL);
COMMIT;

-- ----------------------------
-- Procedure structure for Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Aspek_add_edit`(uidx VARCHAR(255),idx VARCHAR(255),nmas VARCHAR(255), bbt VARCHAR(255), thn VARCHAR(255),
nmfom VARCHAR(255), desk TEXT, eval VARCHAR(255), btswkt DATETIME, thpn VARCHAR(255))
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
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE nama_aspek = nmas AND tahun = thn);
		IF (ada IS NULL) THEN
			INSERT INTO lke_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmas, NOW(), null, bbt, thn, nmfom, desk, eval, btswkt, thpn);
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
		UPDATE lke_aspek SET nama_aspek = nmas, bobot = bbt, update_at = NOW(), tahun = thn, nama_form = nmfom, deskripsi = desk,
		evaluasi = eval, batas_waktu = btswkt, tahapan = thpn WHERE id = idx;
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
	SET ada = (SELECT id FROM lke_bukti_dukung WHERE id = idx);
	IF (ada IS NULL)THEN
		SET ada = (SELECT id FROM lke_indikator WHERE id = idindk);
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
		SET ada = (SELECT id FROM lke_indikator WHERE id = idindk);
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
	SET ada = (SELECT bukti_dukung FROM lke_bukti_dukung WHERE id = idx);
	IF(ada IS NOT NULL)THEN
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Hapus Data Bukti Dukung  : ',(SELECT bukti_dukung FROM lke_bukti_dukung WHERE id=idx LIMIT 1)), NOW());
			DELETE FROM lke_bukti_dukung WHERE id = idx;
			SET res = 1;
			SET msg ='success';
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
	SET ada = (SELECT id FROM lke_indikator WHERE id=idx);
	IF (ada IS NULL) THEN
		set ada = (SELECT id from lke_sub_sub_aspek WHERE id = idssa);
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
		set ada = (SELECT id from lke_sub_sub_aspek WHERE id = idssa);
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
		SET ada = (SELECT id FROM lke_indikator WHERE id = idx);
		IF (ada IS NOT NULL) THEN
			SET ada = (SELECT id_indikator FROM lke_parameter WHERE id_indikator=idx);
			IF (ada IS NULL)THEN
				INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'DELETE', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Hapus Data Indikator  : ',(SELECT indikator FROM lke_indikator WHERE id=idx LIMIT 1)), NOW());
				DELETE FROM lke_indikator WHERE id = idx;
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
	SET ada = (SELECT id FROM lke_jawaban WHERE id = idx);
	IF(ada IS NULL)THEN
		SET ada = (SELECT indikator FROM lke_indikator WHERE id= idindx);
		IF(ada IS NOT NULL)THEN
			SET ada = (SELECT Jawaban FROM lke_jawaban WHERE Jawaban = jwb AND id_indikator = idindx);
			IF(ada IS NULL)THEN
				INSERT INTO lke_jawaban VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), jwb, idindx, NOW(), NULL, uidx, NULL);
				SET res = 1;
				SET msg = 'Tambah Data Berhasil';
				INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'INSERT', 
				(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
				CONCAT('Tambah Data Jawaban : ',jwb, 'Parameter : ',(SELECT indikator FROM lke_indikator WHERE id= idindx) ), NOW());
			ELSE
				SET res = 0;
				SET msg = 'Jawaban Sudah Ada.';
			END IF;
		ELSE
			SET res = 0;
			SET msg = 'Data Parameter Tidak Ditemukan.';
		END IF;
	ELSE
		SET ada = (SELECT nama_parameter FROM lke_parameter WHERE id= idprmt);
		IF(ada IS NOT NULL)THEN
			UPDATE lke_jawaban SET Jawaban = jwb, id_indikator = idindx, nilai = nli WHERE id = idx;
			SET res = 1;
			SET msg = 'Update Data Berhasil';
			INSERT INTO lke_logs VALUES(SHA(CONCAT(NOW(),RAND(),uidx)),NOW(), 'UPDATE', 
			(SELECT UserName FROM lke_user WHERE uid = uidx LIMIT 1), 
			CONCAT('Update Data Jawaban : ',jwb, 'Parameter : ',(SELECT indikator FROM lke_indikator WHERE id= idindx) ), NOW());
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
	SET ada = (SELECT Jawaban FROM lke_jawaban WHERE id= idx);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT id_jawaban FROM lke_bukti_dukung WHERE id_jawaban = idx);
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
	SET ada = (SELECT id FROM lke_Jenis_Jawaban WHERE id = idx);
	IF(ada IS NULL)THEN
		SET ada = (SELECT jenis_jawaban FROM lke_Jenis_Jawaban WHERE jenis_jawaban = jnjwb);
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
		CONCAT('Update Data Jenis Jawaban : ',jnjwb,' Nomor : ',(SELECT num FROM lke_Jenis_Jawaban WHERE id = idx)), NOW());
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
	SET ada = (SELECT id FROM lke_Jenis_Jawaban WHERE id = idx);
	IF(ada IS NOT NULL)THEN
		SET ada =(SELECT jenis_jawaban FROM lke_indikator WHERE jenis_jawaban=idx);
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
CREATE PROCEDURE `Parameter_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), nmpar VARCHAR(255), idind VARCHAR(255))
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
	SET ada = (SELECT id FROM lke_parameter WHERE id=idx);
	IF(ada IS NULL)THEN
		SET ada = (SELECT indikator FROM lke_indikator WHERE id=idind);
		IF(ada IS NOT NULL)THEN
			SET ada= (SELECT nama_parameter FROM lke_parameter WHERE id_indikator = idind AND nama_parameter = nmpar);
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
		SET ada = (SELECT indikator FROM lke_indikator WHERE id=idind);
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
CREATE PROCEDURE `Parameter_delete`(uidx VARCHAR(255), idx VARCHAR(255))
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
	SET ada = (SELECT id FROM lke_parameter WHERE id = idx);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT id_parameter FROM lke_jawaban WHERE id_parameter=idx);
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
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id= idasp);
		IF (ada IS NOT NULL ) THEN
			SET ada = (SELECT nama_sub_aspek FROM lke_sub_aspek WHERE id_aspek=idasp AND nama_sub_aspek=nmsub);
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
		SET ada = (SELECT nama_aspek FROM lke_aspek WHERE id= idasp);
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
		SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm AND PassEnc = EncPass(pswd));
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
				a.PassEnc = EncPass(pswd);
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
		SET ada = (SELECT RoleId FROM lke_roles WHERE RoleId = rlid);
		if (ada IS NOT NULL) THEN
			SET ada = (SELECT id from lke_opd WHERE id = opid);
			IF (ada IS NOT NULL) THEN
				INSERT INTO lke_user VALUES(uids, uname, fname, 
				EncPass(pswd)
				,phn, eml, NOW(), NULL);
				
				INSERT INTO lke_role VALUES(uids, rlid, NOW(), NULL);
				
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
		INSERT INTO lke_logs VALUES(SHA(NOW()),NOW(), 'ERROR', 'System', CONCAT('edit password user :',(SELECT @p2)), NOW());
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
			a.id, 
			a.tahun,
			a.nama_aspek, 
			a.create_at, 
			a.update_at, 
			a.bobot,
			a.nama_form, 
			a.deskripsi, 
			a.evaluasi, 
			(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
			a.batas_waktu,
			a.tahapan
		FROM
			lke_aspek AS a
			ORDER BY a.nama_aspek ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res,
			msg,
			a.id, 
			a.tahun,
			a.nama_aspek, 
			a.create_at, 
			a.update_at, 
			a.bobot,
			a.nama_form, 
			a.deskripsi, 
			a.evaluasi, 
			(select GROUP_CONCAT(nama_sub_aspek) FROM lke_sub_aspek WHERE id_aspek = a.id) AS sub_aspek,
			a.batas_waktu,
			a.tahapan
		FROM
			lke_aspek AS a
			WHERE a.id = idx
			ORDER BY a.nama_aspek ASC LIMIT lmtx OFFSET ofset;
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Bukti_dukung
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Bukti_dukung`;
delimiter ;;
CREATE PROCEDURE `View_Bukti_dukung`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
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
				a.bukti_dukung, 
				a.create_at, 
				a.update_at
			FROM
				lke_bukti_dukung AS a
				WHERE id = idx
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
					a.bukti_dukung, 
					a.create_at, 
					a.update_at
				FROM
					lke_bukti_dukung AS a
					WHERE id_indikator = idx
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
			res, msg,
			( SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id = a.id_sub_sub_aspek LIMIT 1 ) AS sub_sub_aspek,
			a.indikator,
			a.create_at,
			b.nama_parameter,
			b.create_at,
			(
				SELECT
					y.tahun 
				FROM
					lke_aspek AS y
					INNER JOIN lke_sub_aspek AS z ON y.id = z.id_aspek
					INNER JOIN lke_sub_sub_aspek AS c ON z.id = c.id_sub_aspek 
				WHERE
					c.id = a.id_sub_sub_aspek 
					LIMIT 1 
				) AS tahun,
			a.id,
			b.id AS id_parameter 
		FROM
			lke_indikator AS a
			INNER JOIN lke_parameter AS b ON a.id = b.id_indikator
				ORDER BY a.create_at DESC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			( SELECT nama_sub_sub_aspek FROM lke_sub_sub_aspek WHERE id = a.id_sub_sub_aspek LIMIT 1 ) AS sub_sub_aspek,
			a.indikator,
			a.create_at,
			b.nama_parameter,
			b.create_at,
			(
				SELECT
					y.tahun 
				FROM
					lke_aspek AS y
					INNER JOIN lke_sub_aspek AS z ON y.id = z.id_aspek
					INNER JOIN lke_sub_sub_aspek AS c ON z.id = c.id_sub_aspek 
				WHERE
					c.id = a.id_sub_sub_aspek 
					LIMIT 1 
				) AS tahun,
			a.id, 
			b.id AS id_parameter 
		FROM
			lke_indikator AS a
			INNER JOIN lke_parameter AS b ON a.id = b.id_indikator
				WHERE a.id = idx
				ORDER BY a.create_at DESC LIMIT lmtx OFFSET ofset;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for View_Indikator
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Indikator`;
delimiter ;;
CREATE PROCEDURE `View_Indikator`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
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
			a.id_sub_sub_aspek, 
			a.indikator, 
			a.create_at, 
			a.update_at, 
			(SELECT GROUP_CONCAT(nama_parameter SEPARATOR ',<br>') FROM lke_parameter WHERE id_indikator = a.id) AS parameter,
			(SELECT GROUP_CONCAT(bukti_dukung SEPARATOR ',<br>') FROM lke_bukti_dukung WHERE id_indikator = a.id) AS bukti_dukung,
			a.jenis_jawaban
		FROM
			lke_indikator AS a
			ORDER BY a.indikator ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_indikator WHERE id =idx LIMIT 1);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				a.id, 
				a.id_sub_sub_aspek, 
				a.indikator, 
				a.create_at, 
				a.update_at, 
				(SELECT GROUP_CONCAT(nama_parameter SEPARATOR '.<br>') FROM lke_parameter WHERE id_indikator = a.id) AS parameter,
				(SELECT GROUP_CONCAT(bukti_dukung SEPARATOR '.<br>') FROM lke_bukti_dukung WHERE id_indikator = a.id) AS bukti_dukung,
				a.jenis_jawaban
			FROM
				lke_indikator AS a
				WHERE id = idx
				ORDER BY a.indikator ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_sub_sub_aspek WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					a.id, 
					a.id_sub_sub_aspek, 
					a.indikator, 
					a.create_at, 
					a.update_at, 
					(SELECT GROUP_CONCAT(nama_parameter SEPARATOR '.<br>') FROM lke_parameter WHERE id_indikator = a.id) AS parameter,
					(SELECT GROUP_CONCAT(bukti_dukung SEPARATOR '.<br>') FROM lke_bukti_dukung WHERE id_indikator = a.id) AS bukti_dukung,
					a.jenis_jawaban
				FROM
					lke_indikator AS a
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
CREATE PROCEDURE `View_List_Data_Soal_User`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
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
			(SELECT
			nama_sub_sub_aspek
		FROM
			lke_sub_sub_aspek where id = a.id_sub_sub_aspek LIMIT 1) AS sub_sub_aspek,
			a.indikator, 
			a.create_at,  
			(SELECT
			y.tahun
		FROM
			lke_aspek AS y
			INNER JOIN
			lke_sub_aspek AS z
			ON 
				y.id = z.id_aspek
			INNER JOIN
			lke_sub_sub_aspek AS c
			ON 
				z.id = c.id_sub_aspek
				WHERE c.id = a.id_sub_sub_aspek LIMIT 1
				) AS tahun,
				a.id
		FROM
			lke_indikator AS a
			INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
			INNER JOIN lke_sub_aspek AS c on b.id_sub_aspek = c.id
			INNER JOIN lke_aspek AS d ON c.id_aspek = d.id
				ORDER BY a.create_at DESC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			(SELECT
			nama_sub_sub_aspek
		FROM
			lke_sub_sub_aspek where id = a.id_sub_sub_aspek LIMIT 1) AS sub_sub_aspek,
			a.indikator, 
			a.create_at,  
			(SELECT
			y.tahun
		FROM
			lke_aspek AS y
			INNER JOIN
			lke_sub_aspek AS z
			ON 
				y.id = z.id_aspek
			INNER JOIN
			lke_sub_sub_aspek AS c
			ON 
				z.id = c.id_sub_aspek
				WHERE c.id = a.id_sub_sub_aspek LIMIT 1
				) AS tahun,
				a.id
		FROM
			lke_indikator AS a
			INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
			INNER JOIN lke_sub_aspek AS c on b.id_sub_aspek = c.id
			INNER JOIN lke_aspek AS d ON c.id_aspek = d.id
				WHERE d.id = idx
				ORDER BY a.create_at DESC LIMIT lmtx OFFSET ofset;
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
		SELECT
			a.id, 
			a.nama_opd, 
			a.create_at, 
			a.update_at
		FROM
			lke_opd AS a
			ORDER BY a.nama_opd ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SELECT
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
			a.nama_parameter, 
			a.id_indikator, 
			a.create_at, 
			a.update_at
		FROM
			lke_parameter AS a
			ORDER BY a.nama_parameter ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SET ada = (SELECT id FROM lke_parameter WHERE id = idx);
		IF(ada IS NOT NULL)THEN
			SET res = 1;
			SET msg = 'success';
			SELECT
				res, msg,
				a.id, 
				a.nama_parameter, 
				a.id_indikator, 
				a.create_at, 
				a.update_at
			FROM
				lke_parameter AS a
				WHERE a.id = idx
				ORDER BY a.nama_parameter ASC LIMIT lmtx OFFSET ofset;
		ELSE
			SET ada = (SELECT id FROM lke_indikator WHERE id = idx);
			IF(ada IS NOT NULL)THEN
				SET res = 1;
				SET msg = 'success';
				SELECT
					res, msg,
					a.id, 
					a.nama_parameter, 
					a.id_indikator, 
					a.create_at, 
					a.update_at
				FROM
					lke_parameter AS a
					WHERE a.id_indikator = idx
					ORDER BY a.nama_parameter ASC LIMIT lmtx OFFSET ofset;
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
CREATE PROCEDURE `View_Penilaian_Mandiri`()
BEGIN
  #Routine body goes here...
	SELECT
	a.id, 
	a.tahun, 
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
				WHERE lke_aspek.id = a.id
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
				WHERE lke_aspek.id = a.id
			 ) 
		) AS kemajuan, 
	a.nama_form, 
	a.deskripsi, 
	a.evaluasi, 
	a.batas_waktu,
	a.tahapan
FROM
	lke_aspek AS a
ORDER BY
	a.nama_aspek ASC;
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
-- Procedure structure for View_Users
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_Users`;
delimiter ;;
CREATE PROCEDURE `View_Users`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
BEGIN
  #Routine body goes here...
	DECLARE lmtx INT;
	DECLARE ofset INT;
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
		SELECT
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
				ORDER BY b.acs ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SELECT
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
				WHERE a.Uid =idx
				ORDER BY b.acs ASC LIMIT lmtx OFFSET ofset;
	
	END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
