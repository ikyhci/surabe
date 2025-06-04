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

 Date: 04/06/2025 11:52:42
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
  `penilaiid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rb_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_aspek
-- ----------------------------
BEGIN;
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`, `penilaiid`, `rb_id`) VALUES ('0d94dc2a709e6902b75bb2bbdb03c64b754f6061', 'Capaian Sasaran Strategis', '2025-01-07 15:21:08', NULL, '100', '2025', 'Evaluasi SPBE ', 'Evaluasi SPBE 2025', 'Evaluasi', '2025-02-28 15:06:50', NULL, NULL, '2586ca21d09a4c19773dcc46c2f8fac393dbfef7');
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`, `penilaiid`, `rb_id`) VALUES ('3eb1f0f3852a5696685ec451a53b6d1f573a9da5', 'namabaru tematik', '2025-02-18 14:03:51', NULL, '100', '2025', 'Evaluasi SOPBE 2026', 'adasdsa', 'Evaluasi SPBE', '2025-03-01 14:03:00', '', NULL, 'be0de372b2e236b15723d4556a38fa10030be20a');
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`, `penilaiid`, `rb_id`) VALUES ('76b488c6d646e0ce95868c5ceaa3faeff9567cb8', 'Nama Aspek Baru', '2025-02-03 15:04:39', NULL, '100', '2026', 'ASP 02', 'Deskripsi', 'Evaluasi SPBE', '2025-02-28 15:04:00', '', NULL, '2586ca21d09a4c19773dcc46c2f8fac393dbfef7');
INSERT INTO `lke_aspek` (`id`, `nama_aspek`, `create_at`, `update_at`, `bobot`, `tahun`, `nama_form`, `deskripsi`, `evaluasi`, `batas_waktu`, `tahapan`, `penilaiid`, `rb_id`) VALUES ('b08bcaebcd91ab974aaf071c67d1ab58dcee9361', 'nama aspek tes', '2025-02-25 10:17:43', NULL, '100', '2025', 'FM 1', 'deskripsi', 'Evaluasi SPBE', '2025-02-28 10:17:00', '', NULL, '2586ca21d09a4c19773dcc46c2f8fac393dbfef7');
COMMIT;

-- ----------------------------
-- Table structure for lke_bobot
-- ----------------------------
DROP TABLE IF EXISTS `lke_bobot`;
CREATE TABLE `lke_bobot` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idx` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bobot_akhir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('01a75049450717a248822411267e350e1556869b', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001)', '2025-01-26 09:19:57', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('036014ab1a3061359e34ecf3596e7d34ddcb83a5', '374367084e673af84bcbf2f998198f6e2e02770d', 'Dokumen Manajemen Risiko SPBE PD', '2025-01-26 09:21:59', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('07c52bc24fd731b35d4b0a06e24aebd4af75c2b7', '8de2575da7ddfcb955d14e62558d057fd37f3cea', 'Nota Dinas', '2025-01-26 09:16:04', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('1ba86412761491a8ba9816dcef83087b0c772356', '7da5fbc0249bd6ea50b43fac211ae09911eba00e', 'Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD', '2025-01-26 09:20:58', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('250fd68d20187f3f6fec8214a693f1ac5e4b9b0e', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Surat Permohonan', '2025-01-26 09:27:36', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('2ac7a07aa5bd59892125f98d23fec8cce41b9742', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'Nota Dinas', '2025-01-26 09:24:25', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('36c27dbf736d1e4def8879f7e4fa242a18155b2a', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Surat Edaran', '2025-01-26 09:27:20', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('37bb12e2bf176d0a9901a514f11677398bf3a93e', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', 'Alokasi anggaran TIK diselaraskan antara roadmap dengan renstra', '2025-01-26 09:23:49', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('3e1a20af7dd4dae3b50951af199ff52ca6baf532', '09e5806d7e9c7be177de2a3e5268ead52f0e0b68', 'Berkas Gambar', '2025-02-03 15:07:31', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('446b1f1826c499438e5997be8c45a327e84054a9', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional)', '2025-01-26 09:19:42', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('44a34b88ce5f271041782b9680bfc87eff207b8c', 'a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', 'berkas upload', '2025-02-03 15:23:15', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('44d91bfe6df3bddc9ea50b56113bc0ee6a8b6246', '4abb0d7caa97e312fd7bc64f9c546c8aac281776', 'Dokumen Manajemen Data PD (List user, log aktivitas, dataset PD)', '2025-01-26 09:14:33', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('4c1eb8e041367470eaded5434cff0d8a359520b0', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya)', '2025-01-26 09:19:10', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('5087cbcf9ae0b8ebcefadbe026c1a0e250db6023', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', 'Sesuai dengan standar teknis pembangunan/pengembangan aplikasi di lingkungan Pemerintah Provinsi Sulawesi Tengah (Koordinasi dengan bidang aptika diskominfo)', '2025-01-26 09:22:40', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('57986fad3194affd91a723cd2a19775f85ae432c', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Proses Bisnis (sampai level n dan kelengkapan metadata)', '2025-01-26 09:18:33', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('5b162be176913d3202291a04f6f0b417c127ca0d', '8435c182e666a3078b9406a9291767a4e5553a05', 'Dokumen Manajemen Aset TIK PD', '2025-01-26 09:21:28', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('672d5d3a8ed198b62c992ed1e56784e8665d3e43', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', 'Identifikasi inovasi berbasis TIK baru yang berbeda dengan proses bisnis sebelumnya', '2025-01-26 09:14:00', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('7b3f2f3c3be15de407ff4d02881c424482970ad9', 'd39a3d69e310f99b1f244bc750956ee64c8a7bc0', 'Screenshot Pemanfaatan SIPD (Perencanaan)', '2025-01-26 09:26:39', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('7c9dc94945176e5be51ae7a406eae63832bbfdc2', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Berita Acara Pemanfaatan Sistem Penghubung Layanan Pemerintah Daerah', '2025-01-26 09:28:11', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('824e4d749060cd5c9df75b27a2f350a6c596beda', '8de2575da7ddfcb955d14e62558d057fd37f3cea', 'Surat Balasan', '2025-01-26 09:16:39', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('83910dc94440e1aa175aa3b85953dfad6a8fcb54', '9024b1bbd1b0dce4e0f0bc02eb53a57e5e1321c6', 'Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '2025-01-26 09:23:11', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('88c8840576082ee2dad4a97b6ed8548f7673d6a5', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Surat Balasan', '2025-01-26 09:27:54', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('89dffecba42d250ecebf3069a7ccda4ae0b8f913', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', ' Surat Balasan', '2025-01-26 09:25:02', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('902a4e0089cd367efe697af19800046642c4d0a6', '8de2575da7ddfcb955d14e62558d057fd37f3cea', 'Berita Acara Pemanfaatan Pusat Data Pemerintah Daerah', '2025-01-26 09:16:59', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('905581f631c76d3596863f4e0419c153a2f31751', '57582a6e64400efe1f3cf9d9b7ba026dc76e9b51', 'Surat Perintah Tim Pengelola TIK/SPBE/Tim Layanan Digital', '2025-01-26 09:28:43', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('937f97cd6e43b4aca872c533af3b3cd49afb6b5d', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Data dan Informasi (selaras dengan Aplikasi layanan, Aplikasi Satu Data/Satu Peta, dan Sistem Penghubung Layanan/SPL ataupun API)', '2025-01-26 09:19:27', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('977b05b274a6de6a6ec396188724c87d3bbe4e33', '09e5806d7e9c7be177de2a3e5268ead52f0e0b68', 'Berkas PDF', '2025-02-03 15:07:17', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('9b3203aee839a2872366ee3a1788d86abf72a175', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'Laporan Pemanfaatan ', '2025-01-26 09:26:00', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('9b9ea56c956f7290f483c3dbf6e7a1d15f2dbf98', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'Surat Permohonan', '2025-01-26 09:24:46', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('9e5bc6078382260ab7ed706b1898e3ebe98afd03', '8de2575da7ddfcb955d14e62558d057fd37f3cea', 'Surat Permohonan', '2025-01-26 09:16:22', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('acac9cdf43ba395bd326e140a68e12d09356cdf8', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Layanan (selaras dengan Standar Pelayanan Minimal/SPM dan/atau Standar Pelayanan/SP)', '2025-01-26 09:18:52', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('c3ac63f6fcbba758aafc6bdcb0abdb25b31c9244', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'Berita Acara Pemanfaatan Jaringan Intra Pemerintah Daerah', '2025-01-26 09:25:30', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('d9ed9ac462344cdeeb684b937b68b6ff625f7d7a', 'd8a56e0d7385ab924e714644a879d617ec28ff91', 'Dokumen Okupasi Pemetaan Kompetensi SDM TIK PD', '2025-01-22 11:32:15', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('f737458dabd786c5ee52d6f60a7715862172b135', 'b867ddd425115a848c40deb6631c671efb3af975', 'Laporan pelaksanaan Indeks KAMI (Diskominfo), Dashboard Indeks KAMI (PD lain)', '2025-01-26 09:15:05', NULL);
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
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('4020ed4e44627c775afaabcfb931112dcf1004f9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'f0dc55976676c13304f0fc322812d091dfbd7824', '2025-01-30 11:02:07', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('6d42d552c12ccf6aeea164309e5a661064e3f43d', 'f7f863ce2daece6b85b8195447d6a8fb17e3aad3', 'f0dc55976676c13304f0fc322812d091dfbd7824', '2025-02-06 07:22:57', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'f0dc55976676c13304f0fc322812d091dfbd7824', '2025-01-07 19:10:31', NULL);
INSERT INTO `lke_detail_opd` (`id`, `userid`, `opdid`, `create_at`, `update_at`) VALUES ('bc0b0cae6f113fe1227907685874a215d3bae2ed', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'f0dc55976676c13304f0fc322812d091dfbd7824', '2025-02-01 09:25:06', NULL);
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
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('09e5806d7e9c7be177de2a3e5268ead52f0e0b68', 'd3e31e1406816e1ae0b44b9b95fb167538f07632', 'Nama Indikatornya', '2025-02-03 15:06:43', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('1c021a93d1f4957a0712be899e0e023402cb9e90', '6452cc454dccb3ab72bb8e7d37791253218e2820', 'Aspek Pelaporan Kinerja', '2025-02-14 10:36:59', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah Memiliki Dokumen Arsitektur SPBE Perangkat Daerah', '2025-01-16 13:04:21', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('37181b66e0e44b529f7798fb4335b1e692a33f92', '6452cc454dccb3ab72bb8e7d37791253218e2820', 'Aspek Perencanaan Kinerja', '2025-02-14 10:32:13', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('374367084e673af84bcbf2f998198f6e2e02770d', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Manajemen Risiko SPBE', '2025-01-17 13:15:42', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menggunakan Sistem Penghubung Layanan Pemerintah Daerah', '2025-01-17 13:15:15', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('38dcafc4bc1233ea212400d05b16ea12c0f741b2', '1116f190fb78a04423117f9471e8e144ec43fdce', 'Realisasi APBD Tahun Sebelumnya', '2025-02-14 10:48:20', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('41d439f79d1d564a1036430373c0edd231137b7e', '6452cc454dccb3ab72bb8e7d37791253218e2820', 'Aspek Pengukuran Kinerja', '2025-02-14 10:35:53', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('4abb0d7caa97e312fd7bc64f9c546c8aac281776', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melaksanakan Manajemen Data', '2025-01-17 13:16:28', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('4b0cf21acec6d60db6d8ff8fa3ba5385f6b5add6', '8eca64139e0d04c43a4e8e76c46d4d989f2f5cb9', 'Tindaklanjut Hasil Pemerikaan APIP ', '2025-02-14 10:44:19', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('4ec586c38ea345a86f06702ad9958d2ec7b16060', '95ab269ae0e8958c970e91dfd864462207e1fd52', 'Realisasi APBD Tahun Berjalan', '2025-02-14 10:48:45', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('57582a6e64400efe1f3cf9d9b7ba026dc76e9b51', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah terdapat Tim Pelaksana SPBE Perangkat Daerah', '2025-01-17 13:15:28', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('7da5fbc0249bd6ea50b43fac211ae09911eba00e', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah Memiliki Dokumen Peta Rencana (Roadmap) Penerapan SPBE Perangkat Daerah', '2025-01-16 13:36:47', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('7fa4e0a35cc998d05b18e630e0482e07b313ce72', '3eeab69c1b2a80f4409937c96a373e3086602e49', 'indikator tematik', '2025-02-18 14:31:57', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('8435c182e666a3078b9406a9291767a4e5553a05', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Manajemen Aset TIK', '2025-01-17 13:16:40', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('8d9e0f70a1a51a68b990df042abdf6b38ed525b9', '6452cc454dccb3ab72bb8e7d37791253218e2820', 'Aspek Evaluasi Akuntabilitas Kinerja Internal', '2025-02-14 10:37:22', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('8de2575da7ddfcb955d14e62558d057fd37f3cea', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah memanfaatkan Layanan Pusat Data Pemerintah Daerah', '2025-01-17 13:13:43', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('9024b1bbd1b0dce4e0f0bc02eb53a57e5e1321c6', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan Tanda Tangan Elektronik pada Naskah Dokumen Elektronik', '2025-01-17 13:16:13', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah mengalokasikan anggaran pelaksanaan SPBE setiap tahunnya', '2025-01-17 11:37:54', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', 'd3e31e1406816e1ae0b44b9b95fb167538f07632', 'skala 1 - 100', '2025-02-03 15:22:35', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menerapkan proses pembangunan Aplikasi SPBE sesuai siklus pembangunan aplikasi', '2025-01-17 13:11:58', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('b23716a52d8b96dab91e9816b789e3c4639e3a37', '8eca64139e0d04c43a4e8e76c46d4d989f2f5cb9', 'Tindaklanjut Hasil Pemeriksaan BPK RI', '2025-02-14 10:43:54', NULL, '2908a111a94b52d770dbe8db5800d71706463811');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('b867ddd425115a848c40deb6631c671efb3af975', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melakukan self-assessment Indeks KAMI', '2025-01-17 13:15:55', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-17 13:14:58', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('d39a3d69e310f99b1f244bc750956ee64c8a7bc0', '81510049dbd401f5f40714a0e289c94df3616532', 'Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-01-21 15:29:37', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('d8a56e0d7385ab924e714644a879d617ec28ff91', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah dilakukan pemenuhan kompetensi Sumber Daya Manusia TIK', '2025-01-17 13:16:52', NULL, 'cadc4eff78bea93969d1f94ea7816656ad5d80a2');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('db7b9d7ccdeedc960210ce3347895d1397dfa347', 'e067c3695db1f4a537fbced4ef5b1e0fdbcd4413', 'Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-01-17 13:10:15', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
INSERT INTO `lke_indikator` (`id`, `id_sub_sub_aspek`, `indikator`, `create_at`, `update_at`, `jenis_jawaban`) VALUES ('f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', 'c6f7dda51be2d285aeba752a34166c49c41e5039', 'Jumlah IKU Perangkat Daerah Tercapai', '2025-02-14 10:40:25', NULL, 'b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307');
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
  `aprove` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ket` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_jawaban
-- ----------------------------
BEGIN;
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`) VALUES ('7907a4c2f96b3b6b88d21797a2b9584c8ae07d63', 'A', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-02-07 13:48:17', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL, NULL, NULL);
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`) VALUES ('870b68cf8d61cf8bb2ae217c591ed4b2dadc2376', '51', 'a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', '2025-02-03 15:35:31', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL, NULL, NULL);
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`) VALUES ('8d417d314fb55d22059b4fa1729a0021033542d6', 'YA', 'd39a3d69e310f99b1f244bc750956ee64c8a7bc0', '2025-01-27 13:42:06', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL, NULL, NULL);
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`, `aprove`, `ket`) VALUES ('dab21673045d094c124e830afc928e45756b906f', 'YA', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', '2025-01-27 14:20:15', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL, NULL, NULL);
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
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('2908a111a94b52d770dbe8db5800d71706463811', 'Skala Linear', 1, '2025-01-10 14:40:06', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('b7be0e8c9a91dc2bfe3fd36e915731a0e32a1307', 'Pilihan Ganda', 4, '2025-01-10 14:32:35', NULL);
INSERT INTO `lke_Jenis_Jawaban` (`id`, `jenis_jawaban`, `num`, `create_at`, `update_at`) VALUES ('cadc4eff78bea93969d1f94ea7816656ad5d80a2', 'Ya/Tidak', 2, '2025-01-16 13:39:02', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_log_user
-- ----------------------------
DROP TABLE IF EXISTS `lke_log_user`;
CREATE TABLE `lke_log_user` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loged_at` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_log_user
-- ----------------------------
BEGIN;
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0004379069c4ac3cdae68184da50caa38663fb80', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:05:58', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('01ade587c85ee983ea19f5273352795e7cc5aa00', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 11:02:16', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('01e9b2c87eba43f19929ed32e01f429daa2fe2b3', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 12:19:18', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('02ee58450210b4dd9bc7d7c36450d5a133483633', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-01 08:28:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0375131efa966fd30a3f396a8be100198c788de2', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 08:00:47', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('05d0e59c0dcfc7cc033edc28ca1bc9d873a8b5df', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:18:55', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('076b1dcc52074f6c7dcfa24522c4b447514673a7', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 11:11:50', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('07739431eda54b0237c0b491d30176fa8ac15c48', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-01 09:25:47', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('07d6e5fcd46f2a5e696c679c7687a0e08d3967d7', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 11:12:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('08257816fdb5640d63778f228e9cb94a63a73b9a', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:44:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('099fd1fa4cdeeb8d34e6a8a9c39a67361b22a540', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-07 15:32:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0a0af0efa326ade725e494a86c7b0b4b6e36ac72', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-04 13:46:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0a81e9accfd9110a87f5925ba5344fba36c6b03d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-01 12:26:20', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0ac513e7645f98ad3ee9df36400da1df04046781', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-14 10:34:15', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0b54bd11acb265cb03e607429b51d090ab297fe4', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:54:44', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0c7df1d8d5be9a5647b94a10e1287bd25c4d9fe7', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 12:18:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0cd0fa870b5ef67bb8fa991f24eccbd809b264e0', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 14:51:11', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0cf7ea5cc872e9ee87509fd05030bff055e415c0', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:36:46', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0d31e2741e37e51b8ee67799f85828351599baa6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 13:47:18', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0d960570a29024f7d5d963658a82742aac10024b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:23:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0db4a607a45ab06256b5de840f0f132fa69a9dea', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-14 14:24:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0e9b010612b52f2b024dddc993cddaf332cb51d9', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 15:13:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('0f64f4461cdca82240c948dd80e19e76d9d4a949', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 14:24:15', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('105930577753cf46a70f393e58bcd5b739cd1015', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 11:30:57', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('11c1dbc9e2781c6b874b6ad56902d5268ab20ac4', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-15 10:50:57', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1219b19995ae5a993e7a535d87186d15015807c5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 10:38:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1383e4bcc1d2921811ca9cbbd9c4b093bfb30ea0', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 11:04:26', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('13bf3d44623a68e755f0cd88517ae634eba66622', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:34:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('13c0183791f608193d0f1204411e61456c835ed9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-18 16:10:47', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('153123473b0a440cf49e89741ba31fbb2b91ee4c', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-12 11:36:46', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('16089cbfc10023741c69f76ac3f9f67be9bdfd8b', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 07:53:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('163ab9cd002bdee377b04a5dc4402f78ee365a3f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:03:47', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('16a65c40b50af8085e71bec5646b6fc3019e6218', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:39:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('17013431bef652446717b4d1fb50790ad5b8a77f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-22 20:29:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1730d3a9ae04c68c9d78533adfbf22749003ad70', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 11:23:09', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('194848c0cf4696e5f1fc53b0cc1e23d76053887d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-01 08:05:30', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('197427bdbfa434050fdc4e3e52494ee58af05998', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-07 12:03:09', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1a2c7140a89951bdb52a6b90c1328f009a181430', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:17:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1f9b4d304ed80b0a8d21ccac9ab50a8a6cd04c64', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 10:59:26', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1fb69de0bb52d16ed76974809335fa2d04430bb3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-04 13:45:40', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1fce37d33284e935fbcf9f7c69d2cd2019362302', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:45:19', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2033beafd8b7116ff37659f11b0374ad938052fc', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-18 14:01:26', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('20443f9b0746b3ea594d9b466aecbc06b89a8caf', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-11 06:25:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('207e3a437d4b0f32d83cb4c75b9b495627d59c8e', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-14 11:37:10', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('20b69d79c0d51b6748f06c7e789c387f62f0db2f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 13:05:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('215d9fb605243f3bed4bdab47c2130c5f201aa1e', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 08:28:44', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('223212854c0bc5c91c141f39b1072b7e05f1b4cf', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 13:05:39', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('233d9aab7cf0b4a534c5b08608e9c86cc4bdd87f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 13:56:08', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('237504a0cfbb2b0edcd9b3c9317e55d5e03051c2', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:05:38', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2413599611cdbda187c4db678503f69bf3fdd831', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 11:24:23', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('25bc86b836eaf7cfd23b02fe8dc6d7c7823b548f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:35:55', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2851afd6a02a1234cc455b7adda17de410035dc3', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 09:26:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('28593806021d0a1301294f8757757b0b6307f5b9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 11:37:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('28a61fff60b678498255ca49725f62c7cedf8d11', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 06:42:09', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('290e0fa0be778798c3d2f8b6b558a38feab37b4a', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 11:11:42', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2eb602477aff3299bc52a845626d13b3901aaeb5', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-09 10:00:01', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2eb7f5fb9a7716b49cad2f984d7f20854b475906', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 08:00:52', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('2f55182417daa78f4cb3ba2f2c9a986139851c00', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:35:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('332ff573c16fe95b9140666552a0ac29974df42a', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-09 10:01:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('34fb621d189a05e519c3719b59fe63f5a0d596cf', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-12 11:58:21', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3570c3386bc5fb2fd25baca67715f88154cdf8d1', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 14:43:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('35bdc3ec9cc8ae5e16eec6bad126ef1436f94fbb', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 17:22:15', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('37370561649955e31efc975fe12d9f8e9990623f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:25:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('38f8a336d864627e473608e15782eb644df7317a', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:34:59', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3bf97aa06fd8e31fca274dc8766e3d652066a3ae', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:12:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3c1973e49c21038c3292c0aad5a84e779a9342f3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:54:55', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3e2730714fff924b0c88f21b6b6e7b537e336f3a', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 10:03:27', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3e88cf16c5fb64876114afa3ed2ba4897941c2db', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:37:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3f34dc4a971e42dbd5f098d0379fa4278dfd0c53', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:45:56', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('40945b9dbe1c744a893895e3397c193e6692db05', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 08:28:24', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('42a2eae7b3deb7c7549cec7e14a2e6786f2e5e82', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-09 10:00:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('43c9f5fcdd7f9c169b5be2b4c26bcefc980c3cca', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 18:07:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('43d0596da3d83a3f6dccff6ecd1041d46945dd98', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:02:18', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('447ccd2575f19459985739ef8403757001cb8901', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 07:23:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('45a8ab716951ea4d40a9ebf3d48951c1585060be', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:46:04', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4615e8bc8a04f2796edfb8e45c166db121ed3dbe', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:37:15', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('46711298eae7079e0aee7dc9a27694338a99cd97', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 12:52:17', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('46d7355acc2313a58156eaa579da63515aeed0d5', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 11:12:51', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4814b00145cf6a2e672b2b8d7051701c2b3aec65', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 10:56:09', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('48a6d010efd164b9c44656fe71103559c2c52c5d', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 08:05:20', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('48c70bb7a8b700c99e74726537d8e82ecaa44fce', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:23:28', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('495ad206fc6a67932a17dc59c43b2db2503a6504', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-07 15:33:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4a0858b0b6114a45693aabcc710271e60020fb7e', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 08:34:04', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4a6a927fd5c60500bb9fb7b66d79ad703c77fc4d', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 14:23:42', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4a958e35aa35c2f6f82f3b678663b50a0c29e6cb', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 11:02:42', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4b4fabaf6e780135eaff82fbeacfe4a089b2d7ca', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 13:58:41', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4b83a504670583c8828927dd856eaf0360a8e45b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 08:28:00', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4d2e78924268576bb748e45ed71778e767e471c5', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 08:35:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4d4ffe89b1bbe0335c3e08d8f6c3764f21c9fc9c', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 13:15:32', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4ec38afd007f614be0fa548fbd7b7fa355284e68', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 11:36:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('4f9d2f811dc658d563d305731a7654eb8fe36c61', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 14:18:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('501e9beb500ba627af5ca9499d29eb97afff87c1', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 11:20:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5040fe5837fee8a821adfd9fc9ec7c176cd798cd', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 16:37:28', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('532590f3ff2f13e6cca5e6414b60a86aa2ba15a1', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-04 13:46:33', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('532a0e003fd57f818078817589a4acb15f58f212', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 14:51:26', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('532f4f661cf6d2ba24ddebd9f872bdb8f73b84d3', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 08:56:59', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('557c59db384186cb6fa89a7e390b5593fce3f478', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 06:41:25', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('55a52b342310fc1d9855eb216fa6d97b2ab73067', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 11:27:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('56227ac435cccde954fbc5a138645fcd72371766', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 12:55:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5a31463109331051af5d0c8367281ec02eb212dc', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:06:01', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5b56261f266f0a93a3b5eacb32dafa51cf89233b', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:43:22', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5bd90e4f1882c3ecc4285ba5863822ebce64965c', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 11:17:16', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5bf0fb0a3101476183f2022163c209c8f83a536e', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 11:32:16', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5db4c5bd5cbf242ca9ffd3e01e72a81f8193b1d2', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 14:58:50', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5e21bda1df9510cfdebe50e62c7a9b3fe681a656', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-25 10:10:53', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5e6218f561856dbec3eec97229a575936c407813', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:10:23', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('602095bfc36bb41e96330a79fca8166d508dac90', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-20 13:56:56', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('604da4821ead5a8aee802019212508b7144a7726', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 14:49:57', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('651425d805ae3d8de3e89a549486e8521898c579', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:21:38', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('66d834a7fa1866e9b546577e5b93644f07d1dce9', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-23 21:39:37', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6723ffb365ca80a844ee4fc12a87e69ff9d379f8', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:41:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('679258574282bcb2061ccc619b6d978c14601cd6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:10:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('67c01e3cf0712dd8fe7d553823b9d7526c4dc6d6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 08:35:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('67ef262f1f3208ba4593b4b8bb177f0b81973a25', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-04 12:18:38', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('69430f11cea1556e01327b81e8337b3d3a9f7eae', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 08:35:15', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('694beb84459084d0cf94e42adf1fa927f32b7461', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 13:45:16', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('696be67ec782a0c2aa1ad925c2ec352f60e7cab0', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 10:32:55', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('69d86040b3e618ae406e5703fc22bc5ae186100e', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-05 16:10:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('69fe001a1ec93c178c24f3cf6ee6bbaa11681e8a', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-04 12:19:27', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6b9496abd6b6deccd7814574f14fa147532be810', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 08:27:14', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6bab7835cdadec9581c0b64f8fc3cd79cfb2b1dc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:32:21', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6bfa4098850bbb4e3f7f8ccb3739516be9bea533', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:02:02', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6ce18697eaf7af7e2832addfbb0f02a1bdde35ce', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-14 14:23:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('73edc6b2ccacdd8ae680ec71a6414dc5bc3c394f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:38:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7413f7006ddeefe085b217e0d092fa8d0291ae95', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-20 11:47:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('756e3f88dc88b9e8c48c0e59f807941edc629771', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 14:52:35', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('76f478472f543d2a37b78c4130c53b83a5c45cde', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 06:41:35', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('778f11bea021c71b2e6f706e11c39078fd809b46', 'f7f863ce2daece6b85b8195447d6a8fb17e3aad3', 'user ke 2', '2025-02-06 07:52:53', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7897143972cffbdbaf71323c97e1ce6a443f831b', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-06 14:50:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('78a5c4c1ccc6681df7ea107d40c08f99998ed6e3', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 06:42:31', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('78b7f7cd86790f775c8e32441f190c35edd0f7a5', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 11:15:31', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7a0a0ee3a85c261697e2de2d99ceffeb538a81da', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-01 09:26:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7adcd632724d063b6ff8c57b9f3fb244ab4a2068', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 15:13:20', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7b8ac608ad869478ec85a056ca3cfd819904b648', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 12:18:42', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7c102c874748a7fea9e3b232752d90b1b6afb4b9', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:45:34', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7c326e4b836c92c0f806402c24288b3ea8586838', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 17:02:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7c4405e7838f60f8ff7d31ebc2730e8006bc660d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-22 21:32:45', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7c6d8b5e8ece24e541365a3a4006bfc4cfe29eb6', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 11:30:46', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7cd95939bc4e38a47b5ecfc1e824a1b101c1a82f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:01:21', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7d50d350aac733ec5b4c94e0d306806868908d1b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 14:56:57', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7dbfca349c74926594cb7b255cf26e1286ea747f', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-23 18:38:37', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7e65ed2dc44bceae1b24d4a0c3e7aaf35fe36079', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 16:13:04', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7efd3cc39473b05c3a7f6a7e987f0777b3fb2867', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 11:04:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7f337b50afc191aa857fff1939baf7ccc3c0fc26', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 08:26:49', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('80b5cb0ef4e5490acaca5d93923ad8eace4c8df0', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 11:17:26', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('813280066c99eefea08e39cac0164d224016c259', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 14:43:18', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('817c46c0adf288a68b36531581555d32a5bbfde6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:25:27', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('81988b4bc2e232c0851ded3a9bd6220c94905bd9', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 08:28:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('843723da31a02be377fd64ada7d46fa79141d39e', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 10:29:11', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('859b3fea3732221fa19e68d4db40d164cb97d43c', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 11:37:44', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('863928942b7a04a717cc10dfaf89319dc654314a', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-25 11:05:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('86fbf2adae48025d7e203cc2c8690199ed9a7340', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 18:11:08', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('87ad1fa3ec3d6b1ccd03f45fb1a8b834988485f3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:11:17', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('87e8356b398debc3d2be3952ed5449447b52e0a1', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 08:05:09', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('88d815d6ac5427eaceb0f44fffb46e189d7adeea', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:11:15', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('891345bb5cddb04aea23788799918a355efacb6b', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:10:16', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8ae4cdd57bfe785e506d81a197e65b52b6a9e932', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 10:34:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8b01491c98823f58c114e9eea9d64b3fd4f05781', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 13:05:49', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8b03f8b1976632b57a79779fe878566b354f4e24', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-25 10:11:00', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8b1c0f3b6687096ade58d30fc2182a7f590e23fb', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-09 09:03:54', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8be37c97ca0ed046233e61a8e00ea133ed20b7c6', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:53:17', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8bef506b0ca1c620ac30262e7fe14c5877fc9a76', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 12:01:28', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8c83b7c3a923f8b2bfa6c3b3d08843b8ab42ab59', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 14:57:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8cddb139047835dbd3d429b2a39f46da0f731dd3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 15:19:05', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8d285720fa37d92ccd2b8a0e60049f8bf534a74d', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 10:59:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8deabe83481944cf9ad641e50690d1750b3043eb', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-25 10:08:28', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8f411de4c51b7f9cbe9b135254e07ccbf75035c3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 08:58:47', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8fae82985f6ba0f9c1b6ecb62c8137e8f59a3c05', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:05:52', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('90ad95af053b8737d1fd628c8c127b3521ca3375', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-09 10:00:32', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('90fdef8e147dd5fc238a517cde4c7064bd2eae84', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-04 12:20:31', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9104f222d9d7e4d47c7e075e257b2044ac14571d', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:34:50', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('91af97ac5e1d039f7c403ee14a1d818aa3fb5d30', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 09:21:27', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('920967cb3bdfc00a566545be8c0a3f51c408b9ca', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-08 18:54:55', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('92097fb2058b42e73d65f8949ef2fe8f82984cd2', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 14:18:42', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9337f6829bbd71b2c6ecc1528276dd445ab86211', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-06 14:51:03', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('94e8fa57521a3eb9c97e8390aca61f353af1db55', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 13:44:13', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('967346b81a5eb4e2b0f0b1f66f2381b6673ad47a', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 11:15:46', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('96ff57b234eefd590b896705044dc9f43c936ef6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:19:31', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('97558ab8ab7d3d4f1b1ee963ad0866336d36e9fe', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-25 10:23:56', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('97f44f8b963af3069de717d84797a28307a415ef', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:22:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('97fb455f93e4307c0971ff09171e23426d0dc18f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:39:14', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('99110080380c102056a5e394929a1b76e6c2457b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 06:38:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9a60e2fbad4d233c8854f9863dd36ccc10cfb0ab', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-23 19:41:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9a9e469f6a98e8dd8ebb2c121c9bfcfa0fbb47e7', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 08:27:05', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9c07d0fd660413220d0c8cd068f1e882885c08c1', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 13:04:56', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9c83da9b01cc63faffa82f480d736eda275d3e63', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-07 15:32:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9c8c4ca4523a084e0555ff6ba1aee23f05081aac', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 13:15:54', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9cea3e4023bdf4e2f5a599d8a1bbdeac6fb2c8a8', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-05 16:12:53', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9d1788d812af3f48f77851c041b037bff3663580', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 08:32:08', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9d59927f0a017146a11adce605850c5c5f5c13d0', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 13:05:32', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('9e2db8bbdb90aa1177bcc16d4afc458c2d11f3c4', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-04 12:17:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a1aba678f81c8fd8b9b634afa39f9a2ebb11a593', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:08:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a1ace3b345c07fd9ec709b1e77fb94d36b4d2dc2', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-09 10:00:45', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a1d8a6d0d8e19a95317036ac0df7f277969c88f3', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 14:17:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a1fa3001fbc29cfa548b75d41072c16c535d4c8f', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-04 13:46:16', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a215e1dfa78a1d9cd1ce6cad7ec45a3533ef500e', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 16:04:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a22e469b345c82621c6ffdf006d478edfc1a1701', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 14:49:44', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a2b3b2f9322bc9dfb56b82da1b60866631652767', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 11:39:20', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a47c18194851462eca04d419c4e0cc254780e1cf', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:18:43', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a48d01ca030ba240f241082d0956b15ec38f9acc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 09:32:46', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a4d3f6857087c4bbec72a719f2bbaaebb2cafd15', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:12:40', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a653404b2502821e36aff213923919d1fe2e1274', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 11:02:54', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a910d294390b7bf8f4635ea791ac0aaad9ffd270', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 14:15:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a9b6cf075c1628d5a76b86edb32505937c2f2277', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 17:41:16', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('aa2cd6731047488e5cabceadf96fd036ec4bbf6d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:33:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('aa7d71854dc738db49c31c27307dc89eedfea8b0', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-09 10:00:23', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('aacf51dded837e827d05fb26c775c5c3a1ad9306', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 12:26:29', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ab9c544591e923e80ae118f39d19c9de252af861', 'f7f863ce2daece6b85b8195447d6a8fb17e3aad3', 'user ke 2', '2025-02-06 07:23:18', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ae9abc586ab0bc4cfee9c0d4cd33e6773c5d1ee0', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 13:46:41', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('af2df3601b16ee5c439b34bd99b22ce604852fb5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-14 14:23:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('afad48ef67a563a6aa9cf11b5496f93e9698f97b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 13:15:41', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b00b0c616a24b7c7fe8735bc3ceeb9a13888efa8', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-07 12:03:31', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b0ba296eec072a1c7bf7f20fc860d183ad6ce97d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:45:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b152e63878dd30345e58f56883256ecaf450c3c7', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 07:17:14', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b17495b3f1017f51d029c6711a6122a317fe5497', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 14:55:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b34d34032e548bfc0f677faa6d7e884e49d108cb', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-25 09:55:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b3869e313a57ab34b53fcadddf8e1dfc5b5400dd', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 11:37:19', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b419dab26858f2ac7f8b3727c2812ac2cae875bd', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-07 16:13:35', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b46eb40c844b1b04f171591f2c1026eda5be6d6d', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-15 11:53:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b4a5540d971d65793e7f5ac3741fe9079c1613a9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 14:51:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b69495c662de5767e6cdeea4885f943009390d2e', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 16:15:18', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b6fc2e1c4a80df6d0143b5fc810041537619e317', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:44:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b705235beea9cec8b3a1cd26a18a23f74efbc7aa', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:03:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b7f879ef1336d6636cca0bbbae13eb30e3666759', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-14 10:33:18', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b83a8a94b57e844d63f7e37541fb34174db12623', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 14:30:20', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b88cd2b5fd73e24e4919986ea1220e4c9a859776', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 13:57:08', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b9144b31dd5b3228da4c8c223b1b7b3f17b4685c', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-06 13:05:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b99ae62500f36ef45a06e53f8138ffed341688fb', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 14:02:24', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ba1bd673411f2760803cde744007f222b3c35431', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-23 18:41:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bae7e5996b67b79fe62aa48393f924b8852090f6', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-05 17:22:38', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bb5f81783939f5b86cd904d2c2712ed5007357ad', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-01 12:26:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bc02ec48b9a56c635fa70a3eeb433c9608177572', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:45:25', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bd9dc6cc2eee4b1e9e2b7925ea229eab6c3d0dba', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 06:43:29', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('bde76b847b54c5b5c3e0f3cdfbe9ac35383b3d26', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:43:21', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('be6dbc298de703051542bba6efb28a47df1a31e9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 11:12:15', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c070ec60722bf06c74d9952f6b85e7bb7a4400ad', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:32:11', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c11a21cb08686909f2c8e340e506291b681e6945', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:01:26', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c19a19eeb5782fcb29134c3bda068b05608ca55f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:23:36', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c1ef09f5fc12be7a3c58ad946e2b8edf403b23bd', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:13:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c2dc195c9f4cd0baf56918dd04afbf893667a101', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-06 11:20:40', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c2f7097cb56216a5458e5346a521d5f3f15e94b3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-29 14:23:05', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c2f9b112c76eda73373359143eb5cbc437257818', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:01:53', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c3116a1067b2dc6411b0f96c423764cd7b0464b4', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-18 11:49:13', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c3bc09cd6c7160949d2cb57703d0b6779cfbb563', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 14:52:24', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c424636f5f7196bc0702d61384d6e4beeba7a6f5', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 13:16:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c46a7b55b4056ce0efbff21f86e81c415f33d9ea', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 13:45:01', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c58030a1ca5cd3fa7cb2f6c73ddcab5908293762', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:09:55', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c5b9e8859926d041c0edd58e1818e785a1d44f59', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:29:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c5ec0c862d6bd41b9704849264bf40444f206fb9', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:37:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c70c5db9a3e521bfa1b74206e8de78e1d99f6586', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 17:53:40', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c93894ba72b04d70c7e236230a58982cb4b630dc', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 11:36:38', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ca3b5187c4b695c902c3419340e3f3a026a023f9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-14 14:24:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ca818c0df5ab1b194b16df948e0d5661ab56df5f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-25 10:21:54', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('cc14ed3b2da83437da795996afd925d7dd159ee3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 14:12:34', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('cc7dea88449380dd6b7b0b32614950392465e310', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 19:01:15', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ce127aafe16c74adbe98b46d55e4a99c892d34dc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:29:28', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ce63da483abd9f0017ff74e628dd5ffb3c1e736f', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-25 10:08:47', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('cf2e21296734dabccac98d66e10f5c5914f14bd0', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 09:25:38', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('cf6ec60415ac2b519070cd9d1df5c342d957139f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 09:21:14', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d19d360f988bb0172bb45c51be5b62351943a1d9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 10:27:14', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d1fa07cec2f8a625718d1a9e18fc240506f72ca9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 13:44:02', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d24b2befb8fe4fdef33d9dff3494a9b986134074', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 11:11:27', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d30b6c49feb2af22afa1a48490d328cb03f83a9c', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 19:01:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d4610f56c77129f4f1da3826851c5399ed3735b5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 15:31:16', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d4caac633a7932f89f55fe03c770212f29954400', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:21:09', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d6a9f35e6167e994573f06033ef89c80a26ec012', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-20 10:43:54', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d7a53ffacc3f9c1a1e38924e8be579c75dc0008c', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 12:27:41', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d828d9df4705a50153c0e63d49b42818da3fc718', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-23 18:40:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d8a278c0195ec39ad59a09a010c8beabffac85b1', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-12 11:41:09', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('d8bafda52212a0f3f1bcc5c1a6e2f34c8ae107b1', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 09:01:11', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dbe7cee8743249e59de79278f6eceaf304ca0ba9', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:03:58', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dc4a72f365dc60ea8d0ea0d31da514521eb4d667', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:21:02', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dce143a339053a8edc7fbb29fedea1d3e040ad0a', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 12:14:49', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dd7cac1d12cfe50f75f946dd224cc4ae01d086b7', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:13:05', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('df1d5265a2faaee6d9214e7574cb6fd4713caf63', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:05:49', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dfd6429f025f0951a1516e75c34acf98e7bc74ad', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 09:01:22', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dfe969d78691a6be5514d05baa0cbab815dcf06f', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-23 21:39:29', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e0812d2bf8bc4bdd2a70363cb53fcbf23a66b2b5', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-01 12:25:54', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e1d5986b4d18c80ef93aebf66f48a522b7248ee6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal1', '2025-02-12 11:02:05', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e226dc60611a1c5b1463da6f41947595da1f0652', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 14:45:29', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e287e1daecfdea59c5fcce3bc62f045ad084bf84', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 11:27:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e2dcf32b58108119d351aa1bb32a3fe9ac69c4bb', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-12 11:42:33', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e3171902fc74bc07d8247c3911817697f6b39fc2', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:47:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e3c21cfb18788c996d7d7b33c39c6c6fd568e949', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-11 06:27:11', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e449fe03b770e7bf2666b92ee6cd870d0b5cac15', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 08:27:50', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e63ef74f803528ca4d27b707a99b7742092f1f3f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-23 21:26:07', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e691460cadf0f99e21d7799b3b0aba5277394096', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-06 14:47:06', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e6bde6283b049cb4bf2f4da7e1c0c14dde14ba40', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:40:00', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e6d79bb189663d78bbaa1ff65db6103c27d67764', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:07:38', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e83482b9d49781209afa86f10b7b64ac1a4110df', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:07:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e9e0bc4a05ae10479bff52a2866915a74fcf5d67', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-06 13:05:04', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ea54530ea3b4bf2dde2004fa22f0cd7e365f3f57', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 15:37:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('eaee3a15831495ee314497f1d0d2b6e40ed5485e', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:49:41', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ebaef111cd7a6018bca6d076ac1358b947261f4a', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 15:21:52', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ebbf42f5025f7776884ae325ea9ecc24ea1e8030', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-03 13:21:59', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('edbd82ed1ed65da5efa7b8adf603bc98a829273d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-14 10:56:19', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ee9c871d5b63d58067d3842565b67846b229bf60', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 12:47:34', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('eecf2749c39ada2f4e3ad938435983ab776f7c37', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 08:34:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f4b0c5b7909910ef5333585543933202c20bf27e', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-23 21:26:15', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f4de8857bc2ce5ed5aac112eb8a1307bda8b3fc1', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-20 12:52:53', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f519b85eb5764720279eab2bbc1937f260c9739e', '6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', '2025-02-06 13:05:13', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f54dfff593a4b009deacee8f32f69743a04e8e5d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-25 11:05:31', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f616aecab6a75a2a31bba64f9c891e313a53ea33', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-12 11:04:15', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f6c47024bd657179a2481488f5ce3845d0b37bff', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-03 08:34:42', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f6f98af441ea09e50ea5b65d22f9147ebadc4f32', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-09 10:00:09', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f7082e35df330b535a6dd366adee3cd1953a4d6e', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 11:23:19', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f70d8f5c3c7acc5ac2f7d05c585c7539694b432b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 17:22:05', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f79d8ce1e0351c7685b5a31426b711f7a421638f', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 13:57:17', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f7b3a5a00cf77a3937eb98a1e1dbe2d6084b4439', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-03 15:05:29', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f7d500878184b24c0dde10d3e42a861537c78a95', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-07 16:38:01', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f979f476b2569b9d1d24ee3ef222da8ad27db292', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-05 16:35:45', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('f9cccd25138241bb91b8f17232c486f84bf70312', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:59:40', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('fa672135327978f7469b433d9ee49d2eeaed23e8', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-07 13:44:58', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('fe1ff201afed641d72e12b1a666c0e5b7f240fb1', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-02-04 10:19:17', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('fe6c7137ed0a87b72b5cc2273fa401e20188ead2', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-02-03 08:35:05', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ff100a71828bec0970f5f2ad38cd7da3e09d5ed9', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-02-07 11:29:59', '::1', 'LOGIN');
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
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0000e04b4b5daebd2d91422eaf1499b342c8f322', '2025-02-18 16:10:47', 'LOGIN', 'USER', 'User Login :soal', '2025-02-18 16:10:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('00034df0b4462ad22a9130ccb112561ae5a0ec21', '2025-01-30 14:57:10', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 14:57:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('008015372962c84f1bd3b7b5d30edc6751d15b70', '2025-02-03 15:04:57', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Sub Aspek Baru Bobot : 100', '2025-02-03 15:04:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('008bdbae5687837e2d4ad4d34796caa2c6e51cf8', '2025-02-14 10:41:11', 'INSERT', 'soal', 'Tambah Data Parameter : Sebagian besar IKU Perangkat Daerah tercapai (>50%)', '2025-02-14 10:41:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('00caf3a318963c9eb7827acfe1d38f81d01ba651', '2025-02-15 10:50:57', 'LOGIN', 'USER', 'User Login :soal', '2025-02-15 10:50:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('00fc783eb5a4e47db2a26da88c8da68cac0d2749', '2025-01-30 18:21:02', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:21:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0277550fe67b42a9db15d6652963a7e03eaa6084', '2025-02-09 10:00:53', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-09 10:00:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('02a5fbacfc00c123253ec813e4fcd8a41e2778d4', '2025-02-14 10:54:27', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Indeks Budaya Kerja BerAKHLAK Bobot : 100', '2025-02-14 10:54:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('04066884473598c734c2045c7850623b4eb9a00a', '2025-02-25 11:05:39', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-25 11:05:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('040995b16fecf72f486ea3b59a382753fdd7bc7c', '2025-02-06 14:51:03', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-06 14:51:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('05142b181390ecfc5664216e71d60de96cf31620', '2025-02-14 10:44:41', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Hasil Tindaklanjut Rekomendasi (TLHP) BPK RI', '2025-02-14 10:44:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0814b7377ea4be3c86058cfcd61b343874a0ac09', '2025-02-01 09:06:05', 'DELETE', 'soal', 'Hapus Data Aspek  : nama aspeknya', '2025-02-01 09:06:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('08e8232778514422456ed711c0a60bbe63957293', '2025-02-06 07:23:07', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 07:23:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('09141bf6fb832ad82ba349fc9a1ed66d1998da6a', '2025-02-07 16:13:35', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-07 16:13:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0939396c3ca9a2aaf28f9d5a6841009a98c05dd3', '2025-02-05 15:45:56', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:45:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('096ed2d81ca6f169451339ad780e7365ca3a1978', '2025-02-03 13:16:07', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 13:16:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0996233d3c74988370234c6728e3b58b45a99cc4', '2025-02-06 14:50:06', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-06 14:50:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0aaa0002228a6e7b174c7bfef38540cbdcdd88b9', '2025-02-03 11:30:57', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 11:30:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0bca1baa405451f3b706305b23325fa85527b979', '2025-02-14 10:56:19', 'LOGIN', 'USER', 'User Login :user', '2025-02-14 10:56:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0ea652ac40624b379300ec8a16966781f55d6a4a', '2025-02-20 13:56:56', 'LOGIN', 'USER', 'User Login :soal', '2025-02-20 13:56:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0eb2ad98120a0f94d53aef7a4af05392b48f8486', '2025-01-30 15:40:00', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:40:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0f0cfc28a854c6a42c99c571f9bc9ac8a5675154', '2025-02-14 10:45:45', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Laporan Realisasi APBD Perangkat Daerah Bobot : 100', '2025-02-14 10:45:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0f7e7028169911ed995e77daac2382e4c9274c6b', '2025-01-30 15:10:36', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:10:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0f8829cbae09809698ff7aeb870e1fada3b7882f', '2025-02-14 10:38:01', 'INSERT', 'soal', 'Tambah Data Parameter : Nilai Hasil Evaluasi PengukurNilai Hasil Evaluasi Pelaporan Kinerja an Kinerja ', '2025-02-14 10:38:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('105469ecb2f6edb08ac4a339d7f240459a38996d', '2025-02-11 06:27:11', 'LOGIN', 'USER', 'User Login :soal', '2025-02-11 06:27:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('112fce82d7b6cfc0edeca2422a8981ccb6818602', '2025-02-03 15:07:38', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:07:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('11a09aeb705d4a8a06c298d3e0ea245866a28af9', '2025-01-30 13:52:49', 'ERROR', 'System', 'del Parameter :Unknown column \'id_parameter\' in \'field list\'', '2025-01-30 13:52:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('11ad6d0cb52cc59995cb36d562ced24ef824a337', '2025-02-05 17:19:31', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:19:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('11ca13270b10fcdfc44e37bddac5eeb596c9d251', '2025-02-14 10:30:41', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Nilai Evaluasi Akuntabilitas Kinerja Internal  Bobot : 100', '2025-02-14 10:30:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('124c354654eedda6615650fade045dd36576d5a7', '2025-02-12 11:07:37', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal', '2025-02-12 11:07:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('125ee473ca7b3d7f175d03be37474b66e851ee21', '2025-02-12 12:14:49', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 12:14:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('132dbb29a83b951ec5f6b875df26b62a1ac7a628', '2025-02-04 12:18:48', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 12:18:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('13e16b9ed7b2fd06c48c29c872918bc5a2824e1b', '2025-01-27 14:20:15', 'INSERT', 'user', 'Tambah Data Jawaban : YAParameter : Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-27 14:20:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('13f39a3965ae44cb1e7cac22a3ed7e670135557b', '2025-02-15 11:48:53', 'INSERT', 'soal', 'Tambah Data RB : RB TEMATIK PERANGKAT DAERAH Bobot : 100', '2025-02-15 11:48:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('146692f632eed741f234ee559987d84ae051cd2e', '2025-02-07 13:57:08', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 13:57:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('14bdc2e7944a425096aff61a2114b2a1a93fe74a', '2025-02-06 07:17:14', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 07:17:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('15112527c5b42ca00bbb1704aaf9a0761e97eb1f', '2025-02-03 08:32:08', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 08:32:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('15a3d7543fa2d608442589649de2753b4ae4105f', '2025-02-04 12:19:18', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 12:19:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('15b5bcf709b9aacd32db5d1f2a5677f48e464f53', '2025-02-14 14:24:07', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 14:24:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('16110f0fa92172b54101ac090b70150761fbe4b7', '2025-02-05 15:37:52', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:37:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('175dabb388ee72fbb4c37af98a6aa118368df509', '2025-02-14 10:41:34', 'INSERT', 'soal', 'Tambah Data Parameter : Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', '2025-02-14 10:41:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('18c2bfaafc0da44e42085acf074d10da61a980e8', '2025-02-23 18:41:06', 'LOGIN', 'USER', 'User Login :user', '2025-02-23 18:41:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('19fefcc95c08ce64556cbfcd601f546f4daada63', '2025-02-14 10:35:53', 'INSERT', 'soal', 'Tambah Data Indikator : Aspek Pengukuran Kinerja', '2025-02-14 10:35:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1a6f59ddd837b998ab0dd489104c59aa1237add4', '2025-02-18 14:01:26', 'LOGIN', 'USER', 'User Login :soal', '2025-02-18 14:01:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1a942189a41a65b878f9905dfd65efd403f36642', '2025-02-05 15:45:25', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:45:25');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1a9c4f837abb320d95e500c78192d7e11e39f029', '2025-02-20 13:39:30', 'DELETE', 'soal', 'Hapus Data Bukti Dukung  : bukti 2', '2025-02-20 13:39:30');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1abb8fcccbcde7769f2fdc9e2716564710d9f61f', '2025-02-05 16:01:26', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:01:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1b6791fa92185d1b41f55394486815752470b9ef', '2025-02-12 10:03:27', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 10:03:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1c3fe931225f24b26aa9119c678db4d25400de45', '2025-02-01 09:26:43', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 09:26:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1d5fbb546b4c8e2fc870c705ed9a2dc1126c82fa', '2025-02-03 15:07:17', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Berkas PDF ,Indikator  : 09e5806d7e9c7be177de2a3e5268ead52f0e0b68', '2025-02-03 15:07:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1de761004cf717cad97d41c33fad26f50250f426', '2025-02-03 11:30:46', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 11:30:46');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1dee8e29ac3b61f5e19de7aa15633ee82fe2e45a', '2025-02-04 13:46:07', 'LOGIN', 'USER', 'User Login :user', '2025-02-04 13:46:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1e43f7e1c6da11862b4b25d897234d91cb0f2af4', '2025-02-05 15:18:55', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:18:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1e5a9b74ffb6be144fafe266acb2ad3c0a67d4d9', '2025-02-05 15:21:09', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:21:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1ed9a7c8ac3c212baaf64cc4334e0891f79a07de', '2025-02-01 09:25:06', 'INSERT', 'administrator', 'Tambah Data Berhasil : penilai Full Name : penilai', '2025-02-01 09:25:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1f43ed6739828110cf7767751756a63883e739f4', '2025-02-06 13:05:32', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 13:05:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('1f9cea75fed81de4bf01131d89cc0a758590722a', '2025-02-03 11:37:53', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:37:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('20b1de531f98743ae2e0a7933f6aebacf9aa3fff', '2025-01-30 17:34:59', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:34:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('23abe31cd5c2e56a664b33f61c588c540110756a', '2025-02-03 12:47:34', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 12:47:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('23b7321a9bca82f2e60ec8690b3d311da011467c', '2025-02-01 09:25:38', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 09:25:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2463af148d2be3d4e13031d14500bbe3433cdf9a', '2025-02-03 15:22:02', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:22:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('25247227eb48305cd9ca8bd8927113996db50741', '2025-02-07 11:32:16', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 11:32:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('25523361e26d040f5f3172aaaff805671a5415e2', '2025-02-05 16:34:50', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:34:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2610f57e2ec08a1c2ded78db7f8d29b5f5a242f0', '2025-01-30 11:27:19', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 11:27:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('265dcbb3866c154b323a4b0488cb0cdf7788b44d', '2025-02-05 17:25:27', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:25:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('266cd2e7c00572ff2c54f3da335e93c0d2865f44', '2025-02-06 14:43:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 14:43:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('270934c25d173a248e0f86c87657614bf4d4de7e', '2025-02-07 13:57:17', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 13:57:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('271c6c9d33428e56c4b5e4923be47b632c2329de', '2025-02-12 10:54:03', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal1', '2025-02-12 10:54:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('281d28c9a9cb9b47a619add70d2efee0ac14e6a6', '2025-02-12 11:41:09', 'LOGIN', 'USER', 'User Login :user', '2025-02-12 11:41:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('296a9353d03846d9023d3903169ed3322507e2b2', '2025-02-12 11:04:11', 'UPDATE', 'soal', 'UPDATE Password User  : soal Full Name : soal', '2025-02-12 11:04:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2a4cbcb6fc6de9a444b638f2c7b84c6325de85b4', '2025-02-20 14:04:21', 'UPDATE', 'soal', 'update Data Parameter : ya atau tidak yes no', '2025-02-20 14:04:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2a755834a8d6dcaa3688355b2a8b81fb8cde93c1', '2025-02-03 11:10:16', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:10:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2b11cee2d4133275d723b2c1e550962323e1396b', '2025-02-06 14:30:20', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 14:30:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2b9a15d0029d9268b2c4c60b7c191c7c2cf6e865', '2025-02-18 14:31:03', 'INSERT', 'soal', 'Tambah Data Sub Aspek : tematik sub Bobot : 100', '2025-02-18 14:31:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2bcd3f355a06fe15997d8a77f1cb65adf2fcaa6f', '2025-02-06 14:52:35', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 14:52:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2c77e4707c1e5f1003e3c0f0f3febbc6a84d5004', '2025-02-07 15:13:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 15:13:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2cb2d17a39f7abed4669cc490663e8d5e0f867f9', '2025-01-30 14:08:34', 'ERROR', 'System', 'del Parameter :Unknown column \'odk\' in \'where clause\'', '2025-01-30 14:08:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2d21166edcd39d89719df0ecb0d25820d3a51716', '2025-01-30 15:38:48', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:38:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2d220f5afb34189569b5b828fc6f708386375dd9', '2025-02-01 09:05:39', 'DELETE', 'soal', 'Hapus Data Sub Aspek  : nama sub aspek', '2025-02-01 09:05:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2dc9bf8f2f9bf7582785a169e6a7d5fbcbdd5df0', '2025-02-23 18:40:58', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-23 18:40:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2e2199585c7dca1bd021a761a0aa82310768c4b6', '2025-02-07 15:32:58', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-07 15:32:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2e9375d5f30fccc59e4416b122dafee3fe048eb7', '2025-01-30 11:27:52', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 11:27:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2ecd07b47ceeed6811217b8d834689fffb6fec67', '2025-02-05 15:34:39', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:34:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2efd66ac5b3f902377dd318602e2e508ead522d7', '2025-01-30 17:53:40', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 17:53:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2f4c7ee2ac619d95f3726bfc4d763da75f4c3fda', '2025-01-30 15:39:48', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:39:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2fae0e40269e0908aa411e20e37285b698cde574', '2025-02-14 10:38:22', 'INSERT', 'soal', 'Tambah Data Parameter : Nilai Hasil Evaluasi Internal Akuntabilitas Kinerja Internal', '2025-02-14 10:38:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('30586642d6cfd7c2f6c93866ac0cb1aada66bf93', '2025-02-07 15:13:20', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 15:13:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('32087c37116e845474a29298560735d3dce7ee6f', '2025-02-14 10:37:22', 'INSERT', 'soal', 'Tambah Data Indikator : Aspek Evaluasi Akuntabilitas Kinerja Internal', '2025-02-14 10:37:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('324efc0dceb32550b7edf4092f6ee03dd43ee938', '2025-01-29 13:45:19', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:45:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('327088f81b30120764768ee75d60bc4667303f8d', '2025-02-01 12:18:42', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 12:18:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('327249190e9a32fa92661d123dc5e0af1c4c453b', '2025-02-03 08:35:34', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 08:35:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('334eb8f6377484ef9be81663d704df986aca47f3', '2025-02-07 15:33:10', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-07 15:33:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('336b7f13f53a324ee2def3fedda2a75d6f57275f', '2025-02-03 06:42:09', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 06:42:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3496f34d695e48c35b521243078388680618876e', '2025-02-14 10:48:20', 'INSERT', 'soal', 'Tambah Data Indikator : Realisasi APBD Tahun Sebelumnya', '2025-02-14 10:48:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('35f5100bbcee28f36922ea61668643f24189e331', '2025-02-05 16:44:36', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:44:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('369fc775a8a0c80912cc948996b90dbe13fbbd84', '2025-02-06 14:51:26', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 14:51:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('36b6b928cd476ff7ff1dee84cd2e9d07a1440b6e', '2025-02-03 13:15:32', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 13:15:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('36fcbe650b13c57c6ffba95d23ff8f7fe7a80d3c', '2025-02-03 15:21:52', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:21:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('37408f5a1bcb9da617498fe8ab93119847913644', '2025-01-30 13:45:01', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 13:45:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3887f51154cae298a55c526b6fc2a91a9a46fdd2', '2025-02-09 10:00:45', 'LOGIN', 'USER', 'User Login :soal', '2025-02-09 10:00:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3a0e70b6682e3cfc7a6eef0c17d9f8ba4f3060b5', '2025-02-23 21:39:37', 'LOGIN', 'USER', 'User Login :user', '2025-02-23 21:39:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3a9daa513f5f3d916a9bcd7403b2b33482bb545d', '2025-02-15 11:53:22', 'DELETE', 'soal', 'Hapus Data RB  : RB TEMATIK PERANGKAT DAERAH', '2025-02-15 11:53:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3ac3f305f80276edae260b7428012cc711dfb9b1', '2025-02-12 14:18:34', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 14:18:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3b4ac52957b60bc2d0129c577ef5e870084bfee2', '2025-02-01 09:21:14', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 09:21:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3b7f3fc81e87568e8fd259339b5e6f6d6f926b7b', '2025-02-04 14:45:29', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 14:45:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3ba5a330bf8cf089681f35e6097bbaaa899a99e6', '2025-02-20 10:43:54', 'LOGIN', 'USER', 'User Login :soal', '2025-02-20 10:43:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3bb0aa9f0b83fa5596cc2d14b369d168f357d255', '2025-02-01 08:05:20', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 08:05:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3bb4e228fd4a98de3f1da84416abdc272998816c', '2025-02-18 13:58:31', 'DELETE', 'soal', 'Hapus Data RB  : RB TEMATIK PERANGKAT DAERAH', '2025-02-18 13:58:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3c806fa5c23a9fa9b8477ff10d70d2f7d6abbab8', '2025-01-30 15:32:11', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:32:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3d025cd7db27daa6c22dc018c11020a7131c7dac', '2025-02-06 13:04:56', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 13:04:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3e7a835964a4c6f90f2e6099f1082c2dcfca1a55', '2025-02-03 15:02:02', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:02:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3ec11a451035df7a4dec8521be46ea89620d6d15', '2025-02-12 10:59:19', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 10:59:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3ee57c47709f1e7396497f3c5a378961f637fd7e', '2025-02-03 15:06:23', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Nama Sub Sub Aspek Bobot : 100', '2025-02-03 15:06:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3ef16c9d461d68dd1e6ff0cc4b16b92843dd6f46', '2025-02-14 14:23:53', 'LOGIN', 'USER', 'User Login :user', '2025-02-14 14:23:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3f966b802b07fe104020d8cc61ef872a27f4f5e6', '2025-02-14 14:23:58', 'LOGIN', 'USER', 'User Login :user', '2025-02-14 14:23:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4044fa87ea91a9de351dda612f8a8736ca2e2e4a', '2025-01-30 14:10:32', 'INSERT', 'soal', 'Tambah Data Parameter : nama parameternya', '2025-01-30 14:10:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('41200155019ff47d0b6e8da1ebb8173cbfe9fd1f', '2025-02-12 11:04:11', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal', '2025-02-12 11:04:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('416cb0093cb21cc7728da1bd805da3630364c2b5', '2025-02-20 12:52:53', 'LOGIN', 'USER', 'User Login :soal', '2025-02-20 12:52:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4228e20cf8655609e6ca803b95ceb60c86aa3327', '2025-02-01 12:26:20', 'LOGIN', 'USER', 'User Login :user', '2025-02-01 12:26:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('435ce62e2a2807a7b5660566c6fa0269e284fad4', '2025-02-25 10:10:53', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-25 10:10:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4461c7538e9fae22e72252bc0b7e9223890146d5', '2025-02-25 10:08:47', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-25 10:08:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('44f53ab6bbc566ce007e3755c20171477693e7a4', '2025-02-03 08:35:05', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 08:35:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4551fec220a782407eba49b1016ab1ce64aa9b3d', '2025-02-14 14:24:15', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 14:24:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4659116e1f9d81570cb5e646d0190ecf59688595', '2025-02-06 14:49:57', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 14:49:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('46c8367f6f57cf25ad7a9786c083837cfadb28fb', '2025-02-14 10:30:05', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Nilai SAKIP Perangkat Daerah Bobot : 100', '2025-02-14 10:30:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('472e34b6e850111e314d2814bca94d362b2e7ab7', '2025-02-12 11:05:58', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal', '2025-02-12 11:05:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('494a047ee60a16e12aa5491b11343aa078ff0f57', '2025-02-03 13:15:54', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 13:15:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4bd0814459eaf34aa14d3337bd3067ee254d7e50', '2025-02-12 11:03:58', 'UPDATE', 'soal1', 'UPDATE Data User  : soal1 Full Name : soal1', '2025-02-12 11:03:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4bd92c83bb10405412cf36e38272835e1b167f43', '2025-02-14 10:38:58', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Capaian IKU Perangkat Daerah Bobot : 100', '2025-02-14 10:38:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4c1e477ac57eb236f3d89117fed3b94c42f4bd41', '2025-02-01 09:26:34', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-01 09:26:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4cd6b4474a12ea4ff2c0a0cc9ddca992d6b174a3', '2025-02-09 10:00:01', 'LOGIN', 'USER', 'User Login :soal', '2025-02-09 10:00:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4d58d0d537150fc188ab34565cc78f30965001ef', '2025-01-30 19:01:15', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 19:01:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4e029183d8b693ab506c0bb35b5b246d1f3b0fdd', '2025-02-01 12:26:02', 'LOGIN', 'USER', 'User Login :user', '2025-02-01 12:26:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4f693f920dbe4ff178b81ccdf3d6cceee9c1cdc7', '2025-02-03 14:12:34', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 14:12:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4fc6d14e6461c76b2f991ae313a23180d9d17509', '2025-02-03 15:03:47', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:03:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('50851d08d087b4adbfabc5193bae6ef9ebfe0790', '2025-01-30 18:59:40', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:59:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('50d9e770fd18afb6f61384260dfdd999633db791', '2025-02-03 13:14:13', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1738559653_c0255453deb4e94e5d3a.jpg ,bukti Dukung  : 7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-02-03 13:14:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5103fd517c8e2c9a96ede05f064aec0243ce239e', '2025-02-14 14:24:24', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-14 14:24:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('51243280afdcb02e894596b4e8b399c5a49ef393', '2025-02-14 10:34:15', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-14 10:34:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('513a1b14be1c78375d25eb95d8027c26cc887a80', '2025-02-06 13:05:58', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 13:05:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('51fd7c566e7597640620801c5ff60b136c1e6121', '2025-02-06 14:43:18', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 14:43:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5203e0d6bb14983202157b7adeeb7952ac5a5d73', '2025-02-12 11:05:58', 'UPDATE', 'soal', 'UPDATE Password User  : soal Full Name : soal', '2025-02-12 11:05:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('525786bee801eb4c5e3e020da885d993d35b08fc', '2025-02-14 10:41:45', 'INSERT', 'soal', 'Tambah Data Parameter : Tidak ada IKU Perangkat Daerah tercapai (0%)', '2025-02-14 10:41:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('52f471237c6a0334e1453312b4122b1e1678a4fc', '2025-01-30 18:11:17', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:11:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('53477ed82fd8c92a8f1e86181c59deea65ba0e37', '2025-02-01 08:28:34', 'LOGIN', 'USER', 'User Login :user', '2025-02-01 08:28:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('55a6953eee23dc4a93d931b31c2cfe32c33ef13d', '2025-02-04 12:19:27', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-04 12:19:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('57f5b0d9ff9fc7f94d09edf2483d334497289416', '2025-02-07 16:38:01', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-07 16:38:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5940a07598957b5e4ecba17480116cccd5d55277', '2025-02-25 10:21:54', 'LOGIN', 'USER', 'User Login :soal', '2025-02-25 10:21:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('59594cf7496d215eb02d0ee50d9bc659aad66a59', '2025-02-03 12:10:36', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1738555836_169f920f7bfcaa2645aa.jpeg ,bukti Dukung  : 89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-02-03 12:10:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5a18f9d29d6978982e83dc45fa0e5657036c6491', '2025-01-30 19:01:07', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 19:01:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5a3bbf38033fbe2743486173c6d8fa675e54e0f9', '2025-02-14 11:37:10', 'LOGIN', 'USER', 'User Login :user', '2025-02-14 11:37:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5b0e5c2e7fbf37d386948af2994ac14dae56bf81', '2025-02-06 07:22:57', 'INSERT', 'administrator', 'Tambah Data Berhasil : user2 Full Name : user ke 2', '2025-02-06 07:22:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5b62475324a85cae713e929a4969ef4dcda7c9da', '2025-02-23 21:39:29', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-23 21:39:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5c4f7e9759f045f2563a6e5e82dc51a5885c03bd', '2025-02-05 16:09:55', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:09:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5d17a20488ad63faa4f5d839a7ca959f5b2d0327', '2025-02-18 14:31:23', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : tematik sub sub Bobot : 100', '2025-02-18 14:31:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5eb8d0e25238c7541d62609982b196e019e04919', '2025-01-30 14:56:57', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 14:56:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5f8fb73a73f38e6abd26af297146b49eaf60a5a3', '2025-02-14 10:33:18', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-14 10:33:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('602bc917acaefedfbc302e8dd988c68b0d0e18c2', '2025-02-01 08:00:52', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 08:00:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6104e3c1b25d1f51fe08b0cf75dfd110f125e62a', '2025-02-09 10:00:09', 'LOGIN', 'USER', 'User Login :user', '2025-02-09 10:00:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('61328e61aaf221b3686476e550a052530f5e34fc', '2025-02-03 08:27:14', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 08:27:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('61b4ed86051ce18ce88d46f4e92ced253e6e8a16', '2025-02-12 10:52:37', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal', '2025-02-12 10:52:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('624a20c06aa86c76b108076e54840e6c91f5fb63', '2025-02-05 18:07:34', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 18:07:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6260f303557fb271af7e848069bbeb6637cb7a5f', '2025-02-15 11:53:43', 'INSERT', 'soal', 'Tambah Data RB : RB TEMATIK PERANGKAT DAERAH Bobot : 100', '2025-02-15 11:53:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('629a5e07039012ba3d6c5ed61f20120d36c281b4', '2025-02-12 11:02:54', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 11:02:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('637fd165c3345618c4432cb9bb5706e4cd004caf', '2025-01-30 16:08:03', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:08:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('63997be0caefaa2a798dd039159f5197083570e0', '2025-02-14 14:23:42', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 14:23:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('63c2ea325c5b5604f98692a446428a40b3a02bfc', '2025-02-06 07:53:02', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 07:53:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('63ee965f1c99e68c78050c87c65e12d3020fbc66', '2025-02-05 14:58:50', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 14:58:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('64a2872ff94c54b63076a1dabd4bb1c52fa1efe4', '2025-02-12 11:00:17', 'UPDATE', 'soal1', 'UPDATE Data User  : soal1 Full Name : soal1', '2025-02-12 11:00:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('64bc33f57f0274e520e23695a36bef11c4b9a568', '2025-02-14 10:32:55', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 10:32:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('64d9c349fc912119b4991457c474382653c2ee2b', '2025-02-04 12:17:43', 'LOGIN', 'USER', 'User Login :user', '2025-02-04 12:17:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('64edfed7be43e515d43f8d5811f8c99e26bc582f', '2025-02-03 08:28:00', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 08:28:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('65291209b53474690663c5465271e9be3b10789f', '2025-02-07 11:29:59', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 11:29:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('65a0b4baf924330eac7a8ba0fd10529c734a6380', '2025-02-06 14:52:03', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : bukti 2 ,Indikator  : a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', '2025-02-06 14:52:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('65fd1b4110f19c476a9dda05fbfb55cc4eb99d7e', '2025-02-01 09:05:09', 'DELETE', 'soal', 'Hapus Data Sub Sub Aspek  : nama sub sub aspeknya', '2025-02-01 09:05:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('66654e15ef7c55c2b010d15a9331217b7118c821', '2025-02-12 11:04:26', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 11:04:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('67b17559273a20dfd1b9384aec67a94aead9155e', '2025-02-05 15:45:34', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:45:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('67f2ef6a15caa1361bf7982455f9c66c3b9dd342', '2025-02-03 15:22:35', 'INSERT', 'soal', 'Tambah Data Indikator : skala 1 - 100', '2025-02-03 15:22:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6883692c95bda06bb91b6f60f4c960bbb86f8470', '2025-02-03 11:37:44', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 11:37:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6927c466edf4af4b3aa9811e847f9fcf1201ec04', '2025-02-14 10:46:34', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Persentasi Realisasi APBD Tahun Sebelumnya Bobot : 50', '2025-02-14 10:46:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6b70ff4921b89bd4365accc70f08fa9239f891a5', '2025-02-07 11:39:20', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 11:39:20');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6bfca3d203fb45209a20fb05812beb9e4b132b46', '2025-02-14 10:42:10', 'INSERT', 'soal', 'Tambah Data Sub Aspek : Tindaklajut Rekomendasi (TLHP) Bobot : 100', '2025-02-14 10:42:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6e0016a6a66c8adfac6d017ea0b79eb3141333d6', '2025-02-03 08:26:49', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 08:26:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6e3a98e58fdba5d440e880eaf4354585b0b99c6f', '2025-01-30 16:13:36', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:13:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6eec8f3ad86fbecf31969353ab00afff1d649647', '2025-02-12 11:04:15', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 11:04:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6fe944488970254292bbf2e110ab55749d0af9c3', '2025-02-14 10:36:59', 'INSERT', 'soal', 'Tambah Data Indikator : Aspek Pelaporan Kinerja', '2025-02-14 10:36:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7127456f64c29e48b4eab9cf2f9fb6af52177ec8', '2025-02-09 10:00:23', 'LOGIN', 'USER', 'User Login :user', '2025-02-09 10:00:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('716e8482fc1656bf2bc1d9839bdeff533883a699', '2025-01-29 13:47:03', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:47:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('72716fbc2acba7279d468d9d0f1ff00105a89eae', '2025-02-03 15:06:01', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:06:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('73a565a505d54ce9ac3c82c041439f5cab7ec52b', '2025-02-06 13:05:13', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-06 13:05:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7416de49565495aa7d74cd8413bac3b76ac9f77b', '2025-01-30 14:09:00', 'DELETE', 'soal', 'Hapus Parameter  : nama parametrnya', '2025-01-30 14:09:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('743146c83c87d29796a359c15bf4e8e3e8a1ef82', '2025-02-07 13:44:58', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 13:44:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('76024e5e09a55b7828a895da19d66cffb2e2839a', '2025-01-30 15:10:23', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:10:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('76d3d73ba210fabb26c59faa2cb604f80e2d235a', '2025-02-12 10:59:26', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 10:59:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('77361f2fcc36bd1b42bbcd7c79d278551611751e', '2025-02-06 07:52:53', 'LOGIN', 'USER', 'User Login :user ke 2', '2025-02-06 07:52:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7747818acf1d3cfcfa05638e4d23f83c89dcb8f7', '2025-02-03 15:02:18', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:02:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7792c341b916f14b141fd8192930eb8a8f30f080', '2025-02-12 11:02:42', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 11:02:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('77c4de0fda00cb313995ea4a5f0a2e897d51e64e', '2025-02-03 11:12:51', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 11:12:51');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('78b227ffc6d9080b2e8ee08ea64bea136ced6880', '2025-02-12 11:01:59', 'UPDATE', 'soal1', 'UPDATE Password User  : soal1 Full Name : soal1', '2025-02-12 11:01:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('78dbed25ef4304b05e97d001ec47d51a663ce532', '2025-02-03 15:33:13', 'INSERT', 'user', 'Tambah Data Jawaban : Parameter : skala 1 - 100', '2025-02-03 15:33:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('78ee5ada858d6ebf008be3bfa652d41a97288a00', '2025-02-18 11:49:13', 'LOGIN', 'USER', 'User Login :soal', '2025-02-18 11:49:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7ca5e9b2cc0fa670e6cf4a69c77d97834585b1e0', '2025-02-22 20:29:39', 'LOGIN', 'USER', 'User Login :user', '2025-02-22 20:29:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7cabeda8b26a47611a05045a0c709d4c8722addc', '2025-02-03 15:07:31', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : Berkas Gambar ,Indikator  : 09e5806d7e9c7be177de2a3e5268ead52f0e0b68', '2025-02-03 15:07:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7cf6a60bb096ea503aa08d6e52613107e3a5f2c7', '2025-02-14 10:39:52', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Ketercapaian IKU Perangkat Daerah Bobot : 100', '2025-02-14 10:39:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7cfb218ce4739438841948acf729874970477ea6', '2025-02-04 13:45:40', 'LOGIN', 'USER', 'User Login :user', '2025-02-04 13:45:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7d1def8cec2c1b97314ca92ffb6a06390399c3f1', '2025-02-03 08:56:59', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 08:56:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7eb66375d5ce518ba404857dffa1ca23eefc7a52', '2025-02-03 08:27:50', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 08:27:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7ef2e247911412dffeeba9159742d6acc9cab6bf', '2025-02-03 11:37:10', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:37:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7efcd5dabfa731b278affab6f6faf4f0245ff85b', '2025-02-12 11:02:38', 'UPDATE', 'soal1', 'UPDATE Password User  : soal1 Full Name : soal1', '2025-02-12 11:02:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7fb695087b6ec8424c68aab50a3736ad2622aba1', '2025-02-15 11:53:07', 'LOGIN', 'USER', 'User Login :soal', '2025-02-15 11:53:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7fdfed2fb47538d5129ca26541788d542b4f8a4d', '2025-02-07 16:15:18', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 16:15:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('80b59b0dfda2f2c49036af3535fc8b7b035124cc', '2025-01-30 18:21:38', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:21:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8158c8de93351fce876eb48c1ea87ca0fceeef52', '2025-02-12 14:17:53', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 14:17:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('841a82dfd6722e26a5e3c34a573a8ca66b130a7f', '2025-02-12 10:57:42', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal1', '2025-02-12 10:57:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8456a7d8e053b3c557928647f0dcb324ffb91fe2', '2025-02-05 15:05:49', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:05:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('84d7cdd09074e5b0d339124eec8ca4f47bbed607', '2025-01-30 09:32:47', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 09:32:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('859c7e5d4732b72e9fa3e7c01e1940549f58b573', '2025-01-29 14:15:43', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 14:15:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8604f30b87ad0fcdddb6f3cc73c09f8138cb187a', '2025-01-30 14:09:56', 'DELETE', 'soal', 'Hapus Parameter  : nama parameternya', '2025-01-30 14:09:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('87271febbd3349612262e24270ee157c76fd9dd8', '2025-02-12 11:42:33', 'LOGIN', 'USER', 'User Login :user', '2025-02-12 11:42:33');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8747866c57e69233356e417d32a965baf8408a83', '2025-02-23 19:41:39', 'LOGIN', 'USER', 'User Login :user', '2025-02-23 19:41:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8840f1c575f709a8f612feb3acb999d0a91f9f02', '2025-02-25 10:17:43', 'INSERT', 'soal', 'Tambah Data Aspek : nama aspek tes Bobot : 100', '2025-02-25 10:17:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('889354e7bc9e96c58e6f63f4c9699de77102e5a5', '2025-01-30 16:01:21', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:01:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8940391d4ba547e94522f7c6b9457622d237fc5b', '2025-02-07 13:45:16', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 13:45:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('89c7447903289f559312ee368edb2858a0303366', '2025-02-05 15:35:55', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:35:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('89eeb6aa0a95b189e9e179f8bb4fa7de5f70719f', '2025-02-07 13:48:18', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1738907298_f404ade6e9ff8b79de0a.jpeg ,bukti Dukung  : 672d5d3a8ed198b62c992ed1e56784e8665d3e43', '2025-02-07 13:48:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('89f5ab781a7b21eca738fbf8ddaf35f26fb06eb5', '2025-02-03 09:01:22', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 09:01:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8a166909b67ac7bbd93e42a2bf66e8da741253dd', '2025-01-30 18:23:36', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:23:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8a5827ff31c3c4f56768827cfb506be8f3472f17', '2025-02-03 06:41:35', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 06:41:35');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8ae4390d7f752fe7ead2f31dab0643cf428f09bb', '2025-02-05 15:05:58', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:05:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8b3d5f66c7c59694c5f83c1a644425cf205bdccc', '2025-01-30 15:13:05', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:13:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8b524ff9cefd233e74c0a7a7943cf9b4b0704b37', '2025-02-18 14:03:51', 'INSERT', 'soal', 'Tambah Data Aspek : namabaru tematik Bobot : 100', '2025-02-18 14:03:51');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8bb6b8b78a7ce08fe6c5c84403b4ddaf3d76e6da', '2025-02-06 13:05:04', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 13:05:04');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8c13e67cb49245400bdecae2f44eb9cbf05bcce6', '2025-02-05 17:17:03', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:17:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8de3b692a2bf95dabdaf44fe49ad23b7bc478d1a', '2025-02-03 13:15:41', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 13:15:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8deb9810b891358f018628ef2683ae83367d5584', '2025-02-14 10:34:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 10:34:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8e61308b6dc43da3ac960cc2006469b8e76fb9dc', '2025-02-14 10:47:05', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Persentasi Realisasi APBD Tahun Berjalan Bobot : 50', '2025-02-14 10:47:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8f833daf6f1765dbc99a5c714b3c39c19abe38a0', '2025-02-15 11:01:32', 'UPDATE', 'soal', 'Update Data RB : RB GENERAL PD 1 Bobot : 100', '2025-02-15 11:01:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8ff464eb9c42e1ed207129ef3c690750df4b3723', '2025-02-14 10:43:02', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Persentasi Penyelesaian Tindaklanjut Hasil Pemerikaan (TLHP) Bobot : 100', '2025-02-14 10:43:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('905f3b22920b89b48944a0c4e21406962ff73058', '2025-02-07 15:31:16', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 15:31:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9154bcc700429d4195004285c6a34c5f93520dd1', '2025-02-12 11:58:21', 'LOGIN', 'USER', 'User Login :user', '2025-02-12 11:58:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('91ba1865d01ba816506c31baae6b2fa29ca28f9d', '2025-02-25 11:05:31', 'LOGIN', 'USER', 'User Login :user', '2025-02-25 11:05:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('91f875d596e9462ef4d8b27b1d1e0239ff36ee7b', '2025-02-25 10:09:41', 'DELETE', 'administrator', 'Hapus Parameter  : ya atau tidak yes no', '2025-02-25 10:09:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9332a7ccc3e5fd759c777b7640ade3857dc8ccce', '2025-01-29 13:49:41', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:49:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('933fc5803cf8207bf9da4c09181873b4a25d2f0f', '2025-02-06 11:20:40', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 11:20:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('947316f4be1b67ba3a76972b6357d9fb1e50b3ee', '2025-01-30 17:33:03', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:33:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('956a91fb1e1d440f22360c85477f7ad23c498d6c', '2025-01-30 10:38:07', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 10:38:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('95adf03a40490e91cca45a092c1480fe03704bfc', '2025-02-05 15:35:36', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:35:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('95edf7a353b0f0c23d89de3e3fbdb504d9736b1e', '2025-02-14 10:36:23', 'INSERT', 'soal', 'Tambah Data Parameter : Nilai Hasil Evaluasi Pengukuran Kinerja ', '2025-02-14 10:36:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9622450e8be20acac386f104815c56f8303be39a', '2025-01-30 11:02:07', 'INSERT', 'administrator', 'Tambah Data Berhasil : soal Full Name : soal', '2025-01-30 11:02:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('97b3482e260ae55db13565c87af35e2b263a97e7', '2025-01-27 14:20:15', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737958815_73d000c2efbc76785db7.jpeg ,bukti Dukung  : 89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-01-27 14:20:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('98fd4cc436a9bdae916b1c8ecd4ab433e8c1ec26', '2025-02-03 06:41:25', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 06:41:25');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9988a888b99abd7f2c3356aefb391bdaf3a96417', '2025-02-06 11:11:50', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 11:11:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('99d4f3817655db9dc0fba81b1725721b6a86e0c3', '2025-02-03 08:58:47', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 08:58:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('99e0ec3ef40beec8da9427fc90ec259f693fcfa9', '2025-02-12 11:02:05', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 11:02:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9a1d018d64a07214495cc695d41d4f3848be9a72', '2025-02-03 08:28:36', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 08:28:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9a5f0c201af0dfe764d7b6137e452fa09066e092', '2025-02-01 10:27:14', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 10:27:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9a71c00fd79b03a56cddcbc9870a6098a60d9d1e', '2025-02-18 14:34:08', 'INSERT', 'soal', 'Tambah Data Parameter : ya atau tidak', '2025-02-18 14:34:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9a7bb15779039e6a0440aabadc67448bb8b8f06a', '2025-02-05 16:13:04', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 16:13:04');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9a8e41f24d13755ff23093a775cef9674ec38954', '2025-02-03 08:27:05', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 08:27:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9acd0351549e6844ab444ec68eb28203dd3b1d8e', '2025-02-03 11:15:46', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 11:15:46');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9e1edffc2248b41727f8ae0eabb6d8cc9b6d88f9', '2025-02-07 13:44:13', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 13:44:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9e796823dc1393697cc6cfc0fc75b6758194a62c', '2025-02-06 13:05:19', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-06 13:05:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9f06a26ba0d935439665b5dc4a941312e4accf9b', '2025-02-05 16:35:45', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:35:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a1ce120d656c4049346296e9cb41cb9c14fb650b', '2025-02-03 15:03:58', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:03:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a22879f67bc3e15f235074f0f8e2abdde2363df0', '2025-02-03 08:35:15', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 08:35:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a24e4c51bfc8b82f74143f138f44af6cfe0b12f5', '2025-02-04 13:46:33', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-04 13:46:33');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a3c116eb5dd6275335849e7887d9336204cf231b', '2025-02-12 10:53:02', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal1', '2025-02-12 10:53:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a4145aa7c51e4330de35c3d227b31b92bdf1181d', '2025-02-05 17:41:16', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 17:41:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a431afc745a8e63a52759fb57971fcb1072a1975', '2025-02-18 14:00:17', 'INSERT', 'soal', 'Tambah Data Aspek : aspek tematik Bobot : 100', '2025-02-18 14:00:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a45ec3d5e60ca4111b70fa41be98276a0228ce97', '2025-02-14 10:56:09', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 10:56:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a4ec1302da18d13e80e2d2c56d9fb8623c3ba179', '2025-02-01 12:25:54', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 12:25:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a63edde07b2050613255df3668c51d1e0b8d888b', '2025-02-03 15:23:19', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:23:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a67ce61d7d5839bdb6cae237ebb422098f814a8f', '2025-02-05 17:02:02', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 17:02:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a7284f0d9bfe6c04b168adbae2aa6b40cc729afb', '2025-02-06 11:24:23', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 11:24:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a869fbaddf90935244ccf1018ce4b0759f88ed10', '2025-02-04 12:20:31', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-04 12:20:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a8c8763647028207975f2f90ca87f4bbaeb68cfc', '2025-01-29 14:23:05', 'LOGIN', 'USER', 'User Login :user', '2025-01-29 14:23:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('aa7f94e592ce4abfdbf03db53a07a9d0910b43f1', '2025-02-18 14:31:57', 'INSERT', 'soal', 'Tambah Data Indikator : indikator tematik', '2025-02-18 14:31:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ac2d8c524d140d25b6847769f47a99eb66b50b0f', '2025-02-15 11:01:11', 'INSERT', 'soal', 'Tambah Data RB : RB GENERAL PD Bobot : 100', '2025-02-15 11:01:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ac6f05075f1f47ac7ce70d7f703ea487d43a1090', '2025-02-06 11:12:15', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 11:12:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ac8f414b0d88e1b40eaab179bce3d29235aaec81', '2025-02-05 16:12:53', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-05 16:12:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('acb5927d06decb68eaec6340d4b5d163c4ddef8b', '2025-02-12 14:18:42', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 14:18:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ada297d683a8c00b5c9cf9b6121418a85e04888f', '2025-02-06 13:05:39', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 13:05:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('adaabe4867d8774048668813156113cc75959102', '2025-02-12 11:02:38', 'UPDATE', 'soal1', 'UPDATE Data User  : soal1 Full Name : soal1', '2025-02-12 11:02:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ae56cb6841d6f0423ff453baae323b5551ce3d53', '2025-02-23 18:38:37', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-23 18:38:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ae9e17c1a0d95b129fccf63417615a26cd6fcbd1', '2025-02-03 15:23:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:23:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('aebad5dd0fabf0d6c52ed090045c708acea4ab24', '2025-02-06 11:20:53', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 11:20:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('aefebf8dbf9b692788eb9d61a3e82a372fabf6d4', '2025-02-14 10:40:25', 'INSERT', 'soal', 'Tambah Data Indikator : Jumlah IKU Perangkat Daerah Tercapai', '2025-02-14 10:40:25');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('af5bd13392a044c38a394341737da2f8a1f53b79', '2025-02-03 08:35:43', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 08:35:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b0a5d974c36ad5dce15969ea27c60f4808f6809d', '2025-02-03 15:05:38', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:05:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b213e6e3f307eea733e7073fe7337c6d838a26d1', '2025-02-05 15:19:05', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:19:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b34958290638d668836ff2ccdc6aa33e85a835cf', '2025-02-03 11:23:09', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 11:23:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b39809f187589cf6fc830878a15b08c0de1d3d57', '2025-02-11 06:25:52', 'LOGIN', 'USER', 'User Login :soal', '2025-02-11 06:25:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b3ffe7c4784a1c096cb183d13ba13c18cc3b8972', '2025-02-06 14:51:11', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 14:51:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b402807eeb8c7db3f0893b66eefae6a40ca14571', '2025-02-12 11:02:16', 'LOGIN', 'USER', 'User Login :soal1', '2025-02-12 11:02:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b417ced6fbb2cb8146a4041690e8db84c70ef920', '2025-02-25 09:55:43', 'LOGIN', 'USER', 'User Login :user', '2025-02-25 09:55:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b574f7fb3fb47c59c9926f9ae66e1032b2c2bf8f', '2025-02-04 10:19:17', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 10:19:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b5c9d94043039860fc7f1cdbb0dc6f1e81c4e1ac', '2025-02-07 16:37:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 16:37:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b75c2ab07ed2f3bf9afc866bb589648b1d5477e0', '2025-02-01 12:26:29', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 12:26:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b7d2e895c879923289d411b590063216b85d9254', '2025-02-05 15:54:44', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:54:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b7f78e3e5b239e5e23fcc589240991104921719a', '2025-01-30 16:03:24', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:03:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b81ebf683406ca470594f5e3d081f885a49ca3fe', '2025-02-25 10:08:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-25 10:08:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b8248ecdc27e659b7764ad419a95cb8d0e208f3d', '2025-02-03 06:43:29', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 06:43:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b8481ada5192c6da1d6a3ea568f93d6e3dce0018', '2025-02-25 10:11:00', 'LOGIN', 'USER', 'User Login :soal', '2025-02-25 10:11:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b84ceaf20556e00229cd587455368efdceee4f7b', '2025-02-03 15:05:52', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:05:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b86d10d4cbc52ae38068c124ed42c8971cb6585a', '2025-02-14 10:43:54', 'INSERT', 'soal', 'Tambah Data Indikator : Tindaklanjut Hasil Pemeriksaan BPK RI', '2025-02-14 10:43:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b8d4d9e6b5789cb6092accea65269e14aefa1755', '2025-02-07 15:32:52', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-07 15:32:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b9212470f4f44f162c4d557729b4c725b012e70e', '2025-02-09 10:01:07', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-09 10:01:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b962fddc2fc80dcef42b210e6c8313b1678505db', '2025-02-03 13:21:59', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 13:21:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b9b4d19d78cea5d2252441fe5bcb736d3c4df6fe', '2025-02-12 11:36:38', 'LOGIN', 'USER', 'User Login :soal', '2025-02-12 11:36:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bad8a896cefd2916738a749f9cdb9f40f2ce5662', '2025-01-30 17:53:17', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:53:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bb90333d62d7b7d4c2a27d798fb900e2b391329f', '2025-02-03 11:37:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 11:37:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bbe6ff0d2430c7acdfdebe433a4e9aff5a0fd438', '2025-02-25 10:23:56', 'LOGIN', 'USER', 'User Login :user', '2025-02-25 10:23:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bc3d82f83e5cab441891e2ba6e6373b9974e1fac', '2025-02-14 10:49:34', 'INSERT', 'soal', 'Tambah Data Parameter : Diisi dengan Persentasi realisasi total APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Sebelumnya Rumus = Realisasi Akhir APBD Tahun Sebelumnya x 100%                                               Total APBD', '2025-02-14 10:49:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bde1cb33ff23507e2de5c1d986e2f21c8966478c', '2025-02-14 10:29:11', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 10:29:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('be6ec397efd4fdfe85b0f24074e9ccd3711f780b', '2025-02-08 18:54:55', 'LOGIN', 'USER', 'User Login :soal', '2025-02-08 18:54:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bf352c6104ad6e758bc6216bcc6f719fd3a9ff8e', '2025-02-01 08:28:44', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 08:28:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bf9e44fb8ab1935869dc60cb8ba3332a8f26da55', '2025-02-23 21:26:07', 'LOGIN', 'USER', 'User Login :user', '2025-02-23 21:26:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bfbc29aa16f1cf1ddaac3af0933e90ef92cf1712', '2025-02-03 15:06:59', 'INSERT', 'soal', 'Tambah Data Parameter : Parameter BArunya', '2025-02-03 15:06:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bfcd382cb869ea9ed20d739602c6867d2d3e85e1', '2025-02-07 12:52:17', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 12:52:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c050ce33e31ad62f9266bf9eed6784ea29e8904a', '2025-02-04 12:19:07', 'DELETE', 'soal', 'Hapus Parameter  : Parameter BArunya', '2025-02-04 12:19:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c0fd6424651c3aaa2b1c028045579734d602f498', '2025-02-05 15:54:55', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 15:54:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c126822affa8db96d83ebfd248301e48e9bc8ffe', '2025-02-03 15:22:54', 'INSERT', 'soal', 'Tambah Data Parameter : skala linear', '2025-02-03 15:22:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c33cbda9c892f1ab41637c57942e96e6f8ed3f09', '2025-02-14 10:44:19', 'INSERT', 'soal', 'Tambah Data Indikator : Tindaklanjut Hasil Pemerikaan APIP ', '2025-02-14 10:44:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c3582f68bc86e26586e4da35cfd5789ebf613718', '2025-02-06 13:05:49', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 13:05:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c3cf4ac2e5bef4a372a23ddb7a73b1c13fde4b04', '2025-01-30 14:10:37', 'DELETE', 'soal', 'Hapus Parameter  : nama parameternya', '2025-01-30 14:10:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c4b6b3763b9c6dfff12de087f83517e855d50184', '2025-02-05 17:22:05', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:22:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c4b93559838abe8f7b7d4d3ab37463bd3138c11c', '2025-02-12 11:36:46', 'LOGIN', 'USER', 'User Login :user', '2025-02-12 11:36:46');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c54212ab12594c2dcd2f7e4772581e1932d92741', '2025-02-14 16:04:10', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 16:04:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c598c554f1a38177981f4838ffb59c69dc6666f6', '2025-02-06 07:23:18', 'LOGIN', 'USER', 'User Login :user ke 2', '2025-02-06 07:23:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c5994cc99d459f289b59681f1c5501a1b72c1b30', '2025-02-14 10:54:55', 'INSERT', 'soal', 'Tambah Data Sub Sub Aspek : Tingkat Implementasi Kamus Kompetensi ASN BerAKHLAK Bobot : 100', '2025-02-14 10:54:55');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c5c412c6cd44920afe25162af2e231df2a4ac094', '2025-02-05 15:39:14', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:39:14');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c6107da9c1dbb1691da2dda589f9faac6b5ccc29', '2025-02-03 15:33:13', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1738567993_d83dd1c0a0bc44415b8d.jpeg ,bukti Dukung  : 44a34b88ce5f271041782b9680bfc87eff207b8c', '2025-02-03 15:33:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c66b957b5d280d1c723e37e15821cc6747f40364', '2025-02-03 15:23:15', 'INSERT', 'soal', 'Tambah Data Bukti Dukung : berkas upload ,Indikator  : a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', '2025-02-03 15:23:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c670bc58f922fd873cf70f462da964ba1dbfb0ad', '2025-02-01 08:56:19', 'DELETE', NULL, 'Hapus Data Indikator  : nama indikatornya', '2025-02-01 08:56:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c6f23426255f25364ef3ac641d7471a5b56f8089', '2025-02-01 08:05:09', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 08:05:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c88189f03614a06c3641c90b56e15bd53fcf170f', '2025-01-30 14:09:50', 'INSERT', 'soal', 'Tambah Data Parameter : nama parameternya', '2025-01-30 14:09:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c8eb7062f74099c2c783013eae94e0b56578e981', '2025-02-03 08:34:53', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 08:34:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c97cedab5fe7d39fb19cc563e20ebaa6e6cbae2b', '2025-01-27 14:25:15', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737959115_a2aa9578e9a43de60a27.xlsx ,bukti Dukung  : 2ac7a07aa5bd59892125f98d23fec8cce41b9742', '2025-01-27 14:25:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ca55832caaa9e30ace0aa336201b64d04ddabf54', '2025-02-07 12:03:31', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-07 12:03:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('caf73088495bb27e9d8c5f04c2a6bfe7e49a0ee9', '2025-02-03 08:34:42', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 08:34:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('cb0645733bca614f7c813bf10b13322de6f4eb04', '2025-02-03 06:42:31', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 06:42:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('cc043660c81441d4648de4a4a770b37b62f1cef4', '2025-02-07 13:48:17', 'INSERT', 'user', 'Tambah Data Jawaban : AParameter : Telah melaksanakan Inovasi Peta Proses Bisnis ', '2025-02-07 13:48:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ccac54d8eae830052127ef1eda17553eaced825a', '2025-02-04 13:46:16', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-04 13:46:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ccfac67ab04f9864867abf28b9f8781d6ae3f191', '2025-02-03 15:05:29', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 15:05:29');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('cdcc11a107cb576d180c290e7c89e9e9b80c9723', '2025-02-04 13:46:41', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 13:46:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('cdf2ff86e2e9e45277f6f78a73deab55c66b9e35', '2025-02-03 11:11:27', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:11:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ced63cbde55b7cac0cedfdcde5335b80430eb037', '2025-02-01 08:05:30', 'LOGIN', 'USER', 'User Login :user', '2025-02-01 08:05:30');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d12a265c48b5975b68355d48b2c5915b69c5e5f2', '2025-02-14 10:32:13', 'INSERT', 'soal', 'Tambah Data Indikator : Aspek Perencanaan Kinerja', '2025-02-14 10:32:13');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d17e9e5ccbd7e25d1b244c706e928f3f35db9046', '2025-01-30 18:11:08', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 18:11:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d24d2506d6c40f0cce521e23c94734f457a3cf49', '2025-02-05 17:41:07', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:41:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d28956086b50fd4c7b11dba0c1229b96654b50f3', '2025-01-30 15:29:39', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:29:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d2d54895014c6e0c751879f1aacf30e1e46df2f1', '2025-02-03 11:11:15', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:11:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d396aaf7ae4d63a72f10022ce0578161e64ebdea', '2025-02-09 10:00:32', 'LOGIN', 'USER', 'User Login :soal', '2025-02-09 10:00:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d3b94263f84148f39175e23e9b20564f9fe3c252', '2025-02-03 08:28:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 08:28:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d3dcb6455aae36f4cf07342ba9b0fb2861eadf74', '2025-02-03 11:36:58', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-03 11:36:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d44264c64e1f5e013fb8d01bd2c703393253f11a', '2025-01-27 13:42:06', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737956526_5572248522f278d4fe7f.jpeg ,bukti Dukung  : 7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-01-27 13:42:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d49fb6a7aaedb816fdef3f128f986ee25662c35d', '2025-02-01 08:00:47', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 08:00:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d519c56fd33b5b87e2db3d3c0cadc18d2e63bebb', '2025-02-14 10:48:45', 'INSERT', 'soal', 'Tambah Data Indikator : Realisasi APBD Tahun Berjalan', '2025-02-14 10:48:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d51a8a9194792bd385b94af774997c3c0641a87e', '2025-02-14 10:50:00', 'INSERT', 'soal', 'Tambah Data Parameter : Diisi dengan Persentasi realisasi APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Berjalan Rumus = Realisasi APBD Tahun Berjalan x 100%                                     Total APBD', '2025-02-14 10:50:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d5893b56e0d60728c1d1e5d1aec06d5d727cc819', '2025-02-14 10:44:54', 'INSERT', 'soal', 'Tambah Data Parameter : Persentase Hasil Tindaklanjut Rekomendasi (TLHP) APIP', '2025-02-14 10:44:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d5a0735f0c6fbf85fff4a4a6dc8aad79d9ee809f', '2025-02-20 11:47:06', 'LOGIN', 'USER', 'User Login :soal', '2025-02-20 11:47:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d5dbc1011bac14f8a12ca8fafec4be1b38bef4e4', '2025-02-14 11:37:19', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 11:37:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d61cef6298f6a81404ba5c7bc08e8e179749b8f6', '2025-02-03 14:02:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 14:02:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d65a357483c0357856835b02da90992d373d71dd', '2025-02-06 14:47:06', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 14:47:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d82f7cd2d8cdc1a379c200a31fc9c9fed4c2ee4b', '2025-02-14 10:32:50', 'INSERT', 'soal', 'Tambah Data Parameter : Nilai Hasil Evaluasi Perencanaan Kinerja ', '2025-02-14 10:32:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d854c32726a8a1a26a28b6781f0724e8aac98898', '2025-02-05 16:44:06', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:44:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d86a16d4684b352e0b31392694071e5ba0e32307', '2025-02-12 11:03:58', 'UPDATE', 'soal1', 'UPDATE Password User  : soal1 Full Name : soal1', '2025-02-12 11:03:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d94e97ce1a5b3a9b204958531f78c67158c1e14f', '2025-02-07 12:01:28', 'LOGIN', 'USER', 'User Login :user', '2025-02-07 12:01:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d9816d11117cbbc4651ed9ab34d0c0b5d61cb31d', '2025-02-01 12:27:41', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 12:27:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d9d06bbf310ee3f73a2f9db4e6612545ea2d2387', '2025-02-06 11:04:24', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 11:04:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('da341315a9978769fef6539a759eebbe0dcdb9c3', '2025-02-03 15:35:31', 'INSERT', 'user', 'Tambah Data Jawaban : 51Parameter : skala 1 - 100', '2025-02-03 15:35:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('da7433a16f01b5586fc877e4538c245d48e36093', '2025-01-30 17:25:02', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:25:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('daa828d61edfcd6a50d0fae205ac7180a23e578a', '2025-02-05 17:22:38', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 17:22:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('dab570ab7d41b9c22abc0e497204d6e3da014992', '2025-02-06 11:17:16', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 11:17:16');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('dc8f31223f4dfde4778ffc50b94bf51cc236f04c', '2025-02-03 15:06:43', 'INSERT', 'soal', 'Tambah Data Indikator : Nama Indikatornya', '2025-02-03 15:06:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('dccc543c99baeb17f1f3b7c56a9230f043752acd', '2025-02-01 12:55:39', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 12:55:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ddea7b9c9a9a20d0c3e91c7389918b75495f1af7', '2025-02-06 14:52:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 14:52:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ddfed29240813026a6d09c59d07eed2e9171f26b', '2025-02-03 11:12:40', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:12:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('de0f225826816781f264448414b48aba67d655cc', '2025-02-06 11:12:07', 'LOGIN', 'USER', 'User Login :user', '2025-02-06 11:12:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ded5428fe404b2d93fdad136cbb230eec39f485c', '2025-02-03 11:37:15', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 11:37:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('dff8cff5bcc639b8e5c6de45c0f8547664f4f641', '2025-02-09 09:03:54', 'LOGIN', 'USER', 'User Login :soal', '2025-02-09 09:03:54');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e00f4e8dffedb6acae22c9b0b8e5ab0b6c40b2bd', '2025-02-06 14:49:44', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 14:49:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e02dc4a487027dbea50e73a3dfbfa7175c130f2c', '2025-02-14 13:58:41', 'LOGIN', 'USER', 'User Login :soal', '2025-02-14 13:58:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e165a83534f597a9cd518434ebd2d3efeeab965b', '2025-02-01 09:21:27', 'LOGIN', 'USER', 'User Login :soal', '2025-02-01 09:21:27');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e1a88c14d9ef1fc4226d1a32be1eac7e90e9975c', '2025-02-12 10:59:02', 'UPDATE', 'soal1', 'UPDATE Data User  : soal1 Full Name : soal1', '2025-02-12 10:59:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e1e69597d004fca5e4ef07cca971f442228ca3f6', '2025-02-15 11:01:47', 'UPDATE', 'soal', 'Update Data RB : RB GENERAL PD  Bobot : 100', '2025-02-15 11:01:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e240318ceabb4c8c9db2d986c835be365af57f37', '2025-02-12 11:01:59', 'UPDATE', 'soal1', 'UPDATE Data User  : soal1 Full Name : soal1', '2025-02-12 11:01:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e2e57d23b69affdb02807c46c56adde385b6dc4a', '2025-02-04 12:18:38', 'LOGIN', 'USER', 'User Login :user', '2025-02-04 12:18:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e3606e69e35629f1f911164ba321c459b7d42160', '2025-01-29 14:22:59', 'UPDATE', 'user', 'UPDATE Password User  : user Full Name : user', '2025-01-29 14:22:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e3662e9c7b75fec31b16c3137f8c8f7ac4ff99e6', '2025-02-05 17:01:53', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:01:53');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e43407082d20ce2c94f62e86d60679208c2efd30', '2025-02-03 08:34:04', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 08:34:04');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e53e90d58b3ffca69789feed748b67241a2ec67f', '2025-02-03 06:38:24', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 06:38:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e6373405196983f3681c94b09af742021a0f3588', '2025-02-03 15:07:48', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 15:07:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e73e5edc6fe532e5cecfb13424d988167fef76e9', '2025-02-22 21:32:45', 'LOGIN', 'USER', 'User Login :user', '2025-02-22 21:32:45');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e7faffaf37e9302013a0c6866e8c14866d8501cd', '2025-01-27 13:42:06', 'INSERT', 'user', 'Tambah Data Jawaban : YAParameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-01-27 13:42:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e8fc661be792b18570745e5666c49e01fea6b423', '2025-02-05 16:10:07', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-05 16:10:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e97cce90c817298bf53cb3fdb08cd8d0492ee726', '2025-02-06 11:11:42', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 11:11:42');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ea6ae764c7c6a0fe2f6ac41078c78538b8054a93', '2025-02-23 21:26:15', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-23 21:26:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ea8bf5179c45a6203358a1c658fba1bd2f0960c6', '2025-02-03 11:23:19', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-03 11:23:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('eb89e10be69bca7a618160c6c6e15dfd5d83bc96', '2025-02-01 09:25:47', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-01 09:25:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ed448ba5e6f112ae7cabcf8afb499d6ea6228b03', '2025-02-14 10:40:58', 'INSERT', 'soal', 'Tambah Data Parameter : Seluruh IKU Perangkat Daerah tercapai (100%)', '2025-02-14 10:40:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ed68367b8712d9d525b32575622e286adeaacb0c', '2025-02-05 16:43:21', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 16:43:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ed93d009e3a4354f1198a1e0c51c30937268d509', '2025-02-03 15:04:39', 'INSERT', 'soal', 'Tambah Data Aspek : Nama Aspek Baru Bobot : 100', '2025-02-03 15:04:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ee2105616e37e88f12b6fce7d62e49cf4021260e', '2025-02-05 15:46:04', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:46:04');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ef2e06c724a5c3ca6392abec380b666af8484901', '2025-01-30 15:32:21', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:32:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f1b712487e0566e9ffa274f87b2220c261d292b7', '2025-02-06 14:51:36', 'LOGIN', 'USER', 'User Login :soal', '2025-02-06 14:51:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f212685b50d06711988914fe53d044be091f540e', '2025-02-14 10:41:22', 'INSERT', 'soal', 'Tambah Data Parameter : Sebagian IKU Perangkat Daerah tercapai (= 50%)', '2025-02-14 10:41:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f2e980e104c002d1943eb97e55d886f3e846e1db', '2025-01-30 15:45:06', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:45:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f46c2658a3b7b30efdf78b6f49fe00e4aa2d920d', '2025-02-18 13:58:58', 'INSERT', 'soal', 'Tambah Data RB : RB TEMATIK PERANGKAT DAERAH Bobot : 100', '2025-02-18 13:58:58');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f49e810eeb27445bfd7c54ee50bfb8b7420440be', '2025-02-05 17:18:43', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 17:18:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f506542580fdbe3afb401c97c8c1d25b05e18404', '2025-02-04 13:47:18', 'LOGIN', 'USER', 'User Login :soal', '2025-02-04 13:47:18');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f53e3999169842e9aa6570513def7999271beaac', '2025-01-30 15:29:28', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:29:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f6770a60a6406fc19f8eba139393b61212afa5a7', '2025-02-03 11:15:31', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 11:15:31');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f69e5fa7bfe9e36e6afed26b5ac8a48e964a5366', '2025-02-05 17:22:15', 'LOGIN', 'USER', 'User Login :user', '2025-02-05 17:22:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f771df0c04cfb5a79dab4867b04d3c5fc963772b', '2025-02-12 10:56:44', 'UPDATE', 'soal', 'UPDATE Data User  : soal Full Name : soal1', '2025-02-12 10:56:44');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f7f45814dbc086859ad2b79bd268d78c62e7211b', '2025-02-06 11:17:26', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-02-06 11:17:26');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f89963426f3e6dad0490d80383d77923cdb3b055', '2025-02-07 13:44:02', 'LOGIN', 'USER', 'User Login :soal', '2025-02-07 13:44:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f944a6fd23d1510c410c61810f585eb8c61e522e', '2025-01-30 15:12:34', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:12:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fbcf1d623d8673311e176d27de3ee474aabc5aff', '2025-01-30 15:43:22', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:43:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fbcf845295120f6415c9878a07b1f6f7f3c265f1', '2025-01-30 14:55:24', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 14:55:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fcf51f921897a6c7a581813268376910b4a2d833', '2025-02-05 15:36:46', 'LOGIN', 'USER', 'User Login :soal', '2025-02-05 15:36:46');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fd959d1e685efc70ddb9d9942a1433936c2af0e2', '2025-02-07 12:03:09', 'LOGIN', 'USER', 'User Login :penilai', '2025-02-07 12:03:09');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fe3a16d38a5498e674ba3653ceb09ca96846dbd0', '2025-02-03 13:56:08', 'LOGIN', 'USER', 'User Login :soal', '2025-02-03 13:56:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ffefb573049689a7e5700ea8d903420d618686ca', '2025-02-03 09:01:11', 'LOGIN', 'USER', 'User Login :user', '2025-02-03 09:01:11');
COMMIT;

-- ----------------------------
-- Table structure for lke_opd
-- ----------------------------
DROP TABLE IF EXISTS `lke_opd`;
CREATE TABLE `lke_opd` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_opd` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `singkatan` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
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
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('17fd850a367a6c2d45f29ff28054e76be1b11468', '-', '', '2025-01-08 20:55:35', NULL);
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
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('f0dc55976676c13304f0fc322812d091dfbd7824', 'DISKOMINFOSANTIK', 'DISKOMINFOSANTIK', '2025-01-07 14:43:22', '2025-01-07 14:43:47');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('f4908ba9cd41d1c207d2702fc46c467edb27aa3e', 'Dinas Kesehatan Daerah Provinsi Sulawesi Tengah', 'Dinkes Sulteng', '2025-02-12 12:00:05', '2025-02-12 12:00:05');
INSERT INTO `lke_opd` (`id`, `nama_opd`, `singkatan`, `create_at`, `update_at`) VALUES ('f7f2e7addb9b4d046d15dc74675f2e984416df0d', 'Biro Administrasi Pimpinan Setda Provinsi Sulawesi Tengah', 'Biro Adpim Sulteng', '2025-02-12 12:04:45', '2025-02-12 12:04:45');
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
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('024de0ea58b75a492e6063197d001569cbc213c4', 'Nilai Hasil Evaluasi Internal Akuntabilitas Kinerja Internal', '8d9e0f70a1a51a68b990df042abdf6b38ed525b9', '2025-02-14 10:38:22', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('0b104b0abaaf9c61d3a29eb9d55f1a56a049823e', 'Terdapat Alokasi anggaran pelaksanaan SPBE setiap tahunnya pada Dokumen Pelaksanaan Anggaran', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:07:02', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('1550920921b701a11edab7d646e66e549548c859', 'Terdapat Dokumen/Laporan Pemenuhan Kompetensi Sumber Daya Manusia TIK', 'd8a56e0d7385ab924e714644a879d617ec28ff91', '2025-01-17 13:22:15', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('15e972b180ccf97e4313c198cf95b2c335454e67', 'Tindak Lanjut Evaluasi Proses Bisnis diterapkan kembali ke Sistem Elektronik Versi Berikutnya', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:10:44', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('165debcb8f10511abc3324ee4df1d82024378e18', 'Nilai Hasil Evaluasi PengukurNilai Hasil Evaluasi Pelaporan Kinerja an Kinerja ', '1c021a93d1f4957a0712be899e0e023402cb9e90', '2025-02-14 10:38:01', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('1b3ba97b13df5e0f71750cf5f79ea9cbf211c4c6', 'Terdapat Dokumen Manajemen Risiko SPBE', '374367084e673af84bcbf2f998198f6e2e02770d', '2025-01-17 13:20:28', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('2454e9a96d3bc3e8286025b01890c64c7e40a79b', 'skala linear', 'a7ecd38b2fc4f11d2bee91c71418bdcac19e0034', '2025-02-03 15:22:54', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('26ac818fba7ea2a6a6d92f24075b39797337758c', 'Seluruh IKU Perangkat Daerah tercapai (100%)', 'f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', '2025-02-14 10:40:58', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('28354703a22c7f2cb17900af7d4b22fd24373ccf', 'Proses pembangunan/ pengembangan aplikasi telah direviu dan dievaluasi serta ditindaklanjuti', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:34', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('29805b986f273119e139de3443ea4a7b40282ee5', 'Terdapat Dokumen/Laporan Self-Assessment Indeks KAMI', 'b867ddd425115a848c40deb6631c671efb3af975', '2025-01-17 13:20:45', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3322bc4f397ba50978ba2c32ec99de714d3b6f99', 'Reviu dan Evaluasi Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:10:59', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('34c8c22e844dcd8538c7e690a0aa65ac316cabbe', 'Diisi dengan Persentasi realisasi APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Berjalan Rumus = Realisasi APBD Tahun Berjalan x 100%                                     Total APBD', '4ec586c38ea345a86f06702ad9958d2ec7b16060', '2025-02-14 10:50:00', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3bbd6314e1bc4e02d773dc7f37cf4877520a56b4', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:09:05', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3d92fed4af56a3ae87bff84b2f5a4ceb757a06c7', 'Nilai Hasil Evaluasi Perencanaan Kinerja ', '37181b66e0e44b529f7798fb4335b1e692a33f92', '2025-02-14 10:32:50', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('3f57ba5f1f04d1b60b02d1ade89536e5c5bb3b9f', 'Rencana dan Anggaran SPBE dikonsultasikan ke Diskominfo', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:05:39', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('43860b5510eaeee41fa0b4cd361ac832c043c889', 'Sebagian IKU Perangkat Daerah tercapai (= 50%)', 'f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', '2025-02-14 10:41:22', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('5c66f10a6b0be41013e0dbbb95a3119f3d900cec', 'Perangkat Daerah melakukan Pembangunan/Pengembangan Aplikasi sesuai Rekomendasi Kementerian PAN RB', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:47', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('5d3810440701af9dd4f9145197d321cc5ca5c6a0', 'Terdapat Dokumen/Laporan Manajemen Aset TIK', '8435c182e666a3078b9406a9291767a4e5553a05', '2025-01-17 13:21:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('65a1b03f3997cd2374eee79a30e439da2d683b02', 'Terdapat aktivitas penggunaan Layanan Jaringan Intra Pemerintah Daerah', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', '2025-01-17 13:18:29', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('792bdad9dfdbe4ab166ebfb6a67f992bc55bbb98', 'Telah menggunakan Sistem Informasi Pembangunan Daerah (SIPD) dimensi perencanaan', 'd39a3d69e310f99b1f244bc750956ee64c8a7bc0', '2025-01-21 15:30:06', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('82486144fe4fb9d6cdcc773d37346b53194af06f', 'Sebagian kecil IKU Perangkat Daerah tercapai (≤50%)', 'f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', '2025-02-14 10:41:34', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('930af2b030555b911d7d64043f3a7b768d0e251c', 'Terdapat aktivitas penggunaan Sistem Penghubung Layanan Pemerintah Daerah', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', '2025-01-17 13:19:12', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('9d836e97b2d37d445c2e50bdc3735e3646b52a83', 'Terdapat Laporan Rekapitulasi Pemanfaatan Penggunaan Tanda Tangan Elektronik', '9024b1bbd1b0dce4e0f0bc02eb53a57e5e1321c6', '2025-01-17 13:21:08', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('a1d4902c462b55d1bce1629e071f3394dda8a7ef', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan, Data dan Informasi, dan Aplikasi', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:14', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('af52cc01457e3eba7c9a52e5f9be4c0704e021ff', 'Terdapat Tim Pelaksana SPBE Perangkat Daerah yang salah satu fungsinya adalah melakukan koordinasi dengan Instansi Penganggungjawab SPBE terkait penerapan SPBE di Perangkat Daerah/Unit Kerja', '57582a6e64400efe1f3cf9d9b7ba026dc76e9b51', '2025-01-17 13:19:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('b185952206f52e78966fefe2a68c1ae52a22f781', 'Persentase Hasil Tindaklanjut Rekomendasi (TLHP) BPK RI', 'b23716a52d8b96dab91e9816b789e3c4639e3a37', '2025-02-14 10:44:41', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('bc3e900f7f59169ce5860582153ab506f9130c75', 'Diisi dengan Persentasi realisasi total APBD dibagi dengan Total APBD masing-masing Perangkat Daerah dikali 100% pada Tahun Sebelumnya Rumus = Realisasi Akhir APBD Tahun Sebelumnya x 100%                                               Total APBD', '38dcafc4bc1233ea212400d05b16ea12c0f741b2', '2025-02-14 10:49:34', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('bf25fc91ea29e730d97b5636396772fd97519de8', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis dan Layanan ', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:51', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('c066050688723f1fbf6084244afd86aa8e49d2fd', 'Sudah Menyusun Arsitektur SPBE Domain Proses Bisnis, Layanan dan Data dan Informasi', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', '2025-01-16 13:08:35', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('c653cfa1e5e3c773e7896b04f01f2db3f980f265', 'Sebagian besar IKU Perangkat Daerah tercapai (>50%)', 'f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', '2025-02-14 10:41:11', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('c7231afee6a9bc39c1a110635a0e101b26339e62', 'Terdapat aktivitas penggunaan Layanan Pusat Data Pemerintah Daerah', '8de2575da7ddfcb955d14e62558d057fd37f3cea', '2025-01-17 13:14:27', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('cceee1544b9f881b983a2ccc596d3825a76d7d4f', 'Tindak lanjut hasil evaluasi Anggaran SPBE dalam bentuk RKA/ DPA TA berikutnya', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 11:44:18', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('d69345353d64290432fa681bc68972d4f5f5aad3', 'Terdapat dokumentasi hasil reviu dan evaluasi Anggaran SPBE', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', '2025-01-17 13:03:28', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('d727716d08b319bfa184a2b227bacb6c6d5d1b95', 'Terdapat Proses Bisnis yang sudah diterapkan ke dalam Sistem Elektronik', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:11:13', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ded846f26e7a2d4a4d95590c009820dd06f76b89', 'Tidak ada IKU Perangkat Daerah tercapai (0%)', 'f1eb9f0c60df6522e8ab71e0c82d04d0d8a9042c', '2025-02-14 10:41:45', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('e135110f3f5dd9332b79509c28c4a89029ea03b5', 'Persentase Hasil Tindaklanjut Rekomendasi (TLHP) APIP', 'b23716a52d8b96dab91e9816b789e3c4639e3a37', '2025-02-14 10:44:54', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ea6500c96f48ae31b6c235d10dba92b9b6f838f9', 'Terdapat dokumen peta rencana (roadmap) SPBE ', '7da5fbc0249bd6ea50b43fac211ae09911eba00e', '2025-01-16 13:37:48', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('f91281b025bc1d809111f605b8585146f0f1a2cc', 'Nilai Hasil Evaluasi Pengukuran Kinerja ', '41d439f79d1d564a1036430373c0edd231137b7e', '2025-02-14 10:36:23', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('fb1fe5cb5d6f8487e7944a412ac9fe291111811e', 'Sudah Memiliki Peta Proses Bisnis', 'db7b9d7ccdeedc960210ce3347895d1397dfa347', '2025-01-17 13:11:25', NULL);
INSERT INTO `lke_parameter` (`id`, `nama_parameter`, `id_indikator`, `create_at`, `update_at`) VALUES ('ff55b3437e44f8fc0188bdf45df91127ee77d571', 'Dokumentasi Proses Pembangunan/Pengembangan Aplikasi sesuai Siklus Pembangunan Aplikasi / SDLC secara lengkap. ', 'ad6f0561a6f4e19729f13e0a1afa3858c249cf2a', '2025-01-17 13:12:58', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_rb
-- ----------------------------
DROP TABLE IF EXISTS `lke_rb`;
CREATE TABLE `lke_rb` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT ' ',
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bobot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_rb
-- ----------------------------
BEGIN;
INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`) VALUES ('2586ca21d09a4c19773dcc46c2f8fac393dbfef7', 'RB GENERAL PD ', '100', '2025-02-15 11:01:11', '2025-02-15 11:01:47');
INSERT INTO `lke_rb` (`id`, `nama`, `bobot`, `create_at`, `update_at`) VALUES ('be0de372b2e236b15723d4556a38fa10030be20a', 'RB TEMATIK PERANGKAT DAERAH', '100', '2025-02-18 13:58:58', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lke_role
-- ----------------------------
DROP TABLE IF EXISTS `lke_role`;
CREATE TABLE `lke_role` (
  `Uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RoleId` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Create_at` datetime DEFAULT NULL,
  `Update_at` datetime DEFAULT NULL,
  `aspek` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_role
-- ----------------------------
BEGIN;
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', '49bc74a69d7256191ab4d953a6516e73c70f08db', '2025-01-07 13:47:03', NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', '618d4897a69c737080de4216b15b64e1909ecba0', '2025-01-07 19:10:31', NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('85adeb743adbcd35b7cf642df747d5f128e6125a', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', '2025-01-30 11:02:07', NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'ae7deb37b1eac722afda8c431c677662afd57af9', '2025-02-01 09:25:06', NULL, NULL);
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`, `aspek`) VALUES ('f7f863ce2daece6b85b8195447d6a8fb17e3aad3', '618d4897a69c737080de4216b15b64e1909ecba0', '2025-02-06 07:22:57', NULL, NULL);
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
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('1a6fe17c1bead9a6dcdf3a5d59d5464d2dc39ad7', 'Sub Aspek Baru', '2025-02-03 15:04:57', NULL, '76b488c6d646e0ce95868c5ceaa3faeff9567cb8', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('55db040cba71da74305480fecc1249a7001fef9a', 'Capaian IKU Perangkat Daerah', '2025-02-14 10:38:58', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('5d00fa04e69c0b1adaf29537f8e7d812ef5aff2e', 'Nilai SAKIP Perangkat Daerah', '2025-02-14 10:30:05', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('803a1bcecbd9451e1de745abba7dd05d83cb747f', 'Laporan Realisasi APBD Perangkat Daerah', '2025-02-14 10:45:45', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('a0042c9848dd50f661ad168bdd7cc3c17b1ea836', 'Tindaklajut Rekomendasi (TLHP)', '2025-02-14 10:42:10', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('b60aaf44bf0cdc80902900cb9f090d94fee3d217', 'Indeks Budaya Kerja BerAKHLAK', '2025-02-14 10:54:27', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', 'Tingkat Kematangan SPBE Perangkat Daerah', '2025-01-07 15:25:53', NULL, '0d94dc2a709e6902b75bb2bbdb03c64b754f6061', '100');
INSERT INTO `lke_sub_aspek` (`id`, `nama_sub_aspek`, `create_at`, `update_at`, `id_aspek`, `bobot`) VALUES ('eea5e6611f15bd87d170a4ed427b6906fdb5580e', 'tematik sub', '2025-02-18 14:31:03', NULL, '3eb1f0f3852a5696685ec451a53b6d1f573a9da5', '100');
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
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('1116f190fb78a04423117f9471e8e144ec43fdce', 'Persentasi Realisasi APBD Tahun Sebelumnya', '2025-02-14 10:46:34', NULL, '803a1bcecbd9451e1de745abba7dd05d83cb747f', '50');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('3eeab69c1b2a80f4409937c96a373e3086602e49', 'tematik sub sub', '2025-02-18 14:31:23', NULL, 'eea5e6611f15bd87d170a4ed427b6906fdb5580e', '100');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('6452cc454dccb3ab72bb8e7d37791253218e2820', 'Nilai Evaluasi Akuntabilitas Kinerja Internal ', '2025-02-14 10:30:41', NULL, '5d00fa04e69c0b1adaf29537f8e7d812ef5aff2e', '100');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('81510049dbd401f5f40714a0e289c94df3616532', 'Tingkat Kematangan Kapabilitas Layanan', '2025-01-10 11:29:04', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '30');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('8eca64139e0d04c43a4e8e76c46d4d989f2f5cb9', 'Persentasi Penyelesaian Tindaklanjut Hasil Pemerikaan (TLHP)', '2025-02-14 10:43:02', NULL, 'a0042c9848dd50f661ad168bdd7cc3c17b1ea836', '100');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('95ab269ae0e8958c970e91dfd864462207e1fd52', 'Persentasi Realisasi APBD Tahun Berjalan', '2025-02-14 10:47:05', NULL, '803a1bcecbd9451e1de745abba7dd05d83cb747f', '50');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('c0d12296859859d8a149c1bc74e3613c6f621225', 'Penyelenggaraan Statistik Sektoral', '2025-01-10 11:29:44', NULL, 'edb9ad9b75699c50ae95aa5309e6ff14387dcbbe', '20');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('c6f7dda51be2d285aeba752a34166c49c41e5039', 'Tingkat Ketercapaian IKU Perangkat Daerah', '2025-02-14 10:39:52', NULL, '55db040cba71da74305480fecc1249a7001fef9a', '100');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('d1118d17c85f86e03152d16a4a4ba2d0b39f99c5', 'Tingkat Implementasi Kamus Kompetensi ASN BerAKHLAK', '2025-02-14 10:54:55', NULL, 'b60aaf44bf0cdc80902900cb9f090d94fee3d217', '100');
INSERT INTO `lke_sub_sub_aspek` (`id`, `nama_sub_sub_aspek`, `create_at`, `update_at`, `id_sub_aspek`, `bobot`) VALUES ('d3e31e1406816e1ae0b44b9b95fb167538f07632', 'Nama Sub Sub Aspek', '2025-02-03 15:06:23', NULL, '1a6fe17c1bead9a6dcdf3a5d59d5464d2dc39ad7', '100');
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
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_upload_bukti
-- ----------------------------
BEGIN;
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('28553b83e28cf7067b326b9a9b6ad72f0ef6ea2f', '1737958815_73d000c2efbc76785db7.jpeg', '89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-01-27 14:20:15', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('2b4e8ff757a111d437786848e5490ad4c21de238', '1737956526_5572248522f278d4fe7f.jpeg', '7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-01-27 13:42:06', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('36c97a1f8d824b78fa735ce1f4ff1b6aa3a7a96c', '1738555836_169f920f7bfcaa2645aa.jpeg', '89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-02-03 12:10:36', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('72c1be8e3bb98b1be4b05d3acf71ad1d1338be93', '1738559653_c0255453deb4e94e5d3a.jpg', '7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-02-03 13:14:13', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('a54a83680d98976858c652b4db0768b84b623164', '1738567993_d83dd1c0a0bc44415b8d.jpeg', '44a34b88ce5f271041782b9680bfc87eff207b8c', '2025-02-03 15:33:13', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('c814eacbed401a1b511db6a5d0608b960034571d', '1738907298_f404ade6e9ff8b79de0a.jpeg', '672d5d3a8ed198b62c992ed1e56784e8665d3e43', '2025-02-07 13:48:18', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('ec3bc68ed239c796a285649a56fe0e7cdbd30537', '1737959115_a2aa9578e9a43de60a27.xlsx', '2ac7a07aa5bd59892125f98d23fec8cce41b9742', '2025-01-27 14:25:15', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
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
  `actv` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_user
-- ----------------------------
BEGIN;
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('6d7c668a43ecfcf2baeafad0a48ec1ba17748f13', 'penilai', 'penilai', 0xD69AEAED31B2EF9D2D4338276965F075, '0', 'penilai@mail.com', '2025-02-01 09:25:06', NULL, 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', 'soal', 0xD69AEAED31B2EF9D2D4338276965F075, '0855551', 'soal@mail.com', '2025-01-30 11:02:07', '2025-02-12 11:07:37', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', 'user', 0xD69AEAED31B2EF9D2D4338276965F075, '-', '-', '2025-01-07 19:10:31', '2025-01-29 14:22:59', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', 'administrator', 'Super Admin', 0xD69AEAED31B2EF9D2D4338276965F075, '-', '-', '2025-01-07 13:47:03', NULL, 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('f7f863ce2daece6b85b8195447d6a8fb17e3aad3', 'user2', 'user ke 2', 0xD69AEAED31B2EF9D2D4338276965F075, '0', 'user2@mail.com', '2025-02-06 07:22:57', NULL, 'TRUE');
COMMIT;

-- ----------------------------
-- Procedure structure for Aspek_add_edit
-- ----------------------------
DROP PROCEDURE IF EXISTS `Aspek_add_edit`;
delimiter ;;
CREATE PROCEDURE `Aspek_add_edit`(uidx VARCHAR(255),idx VARCHAR(255),nmas VARCHAR(255), bbt VARCHAR(255), thn VARCHAR(255),
nmfom VARCHAR(255), desk TEXT, eval VARCHAR(255), btswkt DATETIME, thpn VARCHAR(255), rbx VARCHAR(255))
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
			INSERT INTO lke_aspek VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmas, NOW(), null, bbt, thn, nmfom, desk, eval, btswkt, thpn, NULL, rbx);
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
		SET ada = (SELECT id_bukti FROM lke_upload_bukti WHERE id_bukti = idx);
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
	SET ada = (SELECT id FROM lke_jawaban WHERE id = idx);
	IF(ada IS NULL)THEN
		SET ada = (SELECT indikator FROM lke_indikator WHERE id= idindx);
		IF(ada IS NOT NULL)THEN
			SET ada = (SELECT Jawaban FROM lke_jawaban WHERE  id_indikator = idindx);
			IF(ada IS NULL)THEN
				INSERT INTO lke_jawaban VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), jwb, idindx, NOW(), NULL, uidx, NULL, NULL, NULL);
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
	SET ada = (SELECT id FROM lke_parameter WHERE id = idx);
	IF(ada IS NOT NULL)THEN
		SET ada = (SELECT Jawaban FROM lke_jawaban INNER JOIN lke_indikator ON lke_jawaban.id_indikator = lke_indikator.id 
		WHERE lke_indikator.id = idk
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
CREATE PROCEDURE `Rb_add_edit`(uidx VARCHAR(255), idx VARCHAR(255), nmx VARCHAR(255), bbt VARCHAR(255))
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
	
	SET ada = (SELECT id FROM lke_rb WHERE id = idx);
	IF (ada IS NULL) THEN
		SET ada = (SELECT nama FROM lke_rb WHERE nama = nmx);
		IF(ada IS NULL) THEN
			INSERT INTO lke_rb VALUES(SHA(CONCAT(NOW(),RAND(),uidx)), nmx, bbt, NOW(), NULL);
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
	
	SET ada = (SELECT id FROM lke_rb WHERE id = idx);
	IF(ada IS NOT NULL) THEN
		SET ada = (SELECT id FROM lke_aspek WHERE rb_id = idx);
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
	SET ada = (SELECT id FROM lke_upload_bukti WHERE id = idx);
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
	
	SET ada = (SELECT UserName from lke_user WHERE UserName= usrnm);
	
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
					a.PassEnc = EncPass(pswd);
-- 			
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
		SET ada = (SELECT RoleId FROM lke_roles WHERE RoleId = rlid);
		if (ada IS NOT NULL) THEN
			SET ada = (SELECT id from lke_opd WHERE id = opid);
			IF (ada IS NOT NULL) THEN
				INSERT INTO lke_user VALUES(uids, uname, fname, 
				EncPass(pswd)
				,phn, eml, NOW(), NULL, 'TRUE');
				
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
				a.tahapan,
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
					a.tahapan,
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
				a.tahapan,
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
			a.bukti_dukung, 
-- 			IF(uidx IS NULL,0,
-- 				IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 			) 
-- 			 AS filesx,
-- 			 IF(uidx IS NULL,0,
-- 				IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 			) 
-- 			 AS fl_id,
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
-- 				IF(uidx IS NULL,0,
-- 					IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 				) 
-- 				 AS filesx,
-- 				 IF(uidx IS NULL,0,
-- 				IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 			) 
-- 			 AS fl_id,
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
					a.bukti_dukung, 
-- 					IF(uidx IS NULL,0,
-- 						IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 					) 
-- 					 AS filesx,
-- 					 IF(uidx IS NULL,0,
-- 						IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
-- 					) 
-- 					 AS fl_id,
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
CREATE PROCEDURE `View_Dashboard_User`(uidx VARCHAR(255), thnx VARCHAR(255))
BEGIN
  #Routine body goes here...
	
	DECLARE res VARCHAR(255);
	DECLARE msg VARCHAR(255);
	
	SET res='1';
	SET msg= 'success';
	
	
	SELECT
	res,msg,
	a.nama,
	
	b.nama_aspek,
	b.tahun,
	b.deskripsi,
	b.evaluasi,
	b.batas_waktu,
	b.tahapan,
	b.bobot AS bobot_aspek,
	d.nama_sub_aspek,
	d.bobot AS bobot_subAspek,
	e.nama_sub_sub_aspek,
	e.bobot AS bobot_subSubAspek,
	f.indikator,
-- 	g.jenis_jawaban,
-- -- 	user Jawaban
-- 
	IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx) IS NULL,
	'BELUM DI ISI',
	(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = f.id AND userid = uidx)) AS Jawabanx
	
FROM
	lke_rb AS a
	INNER JOIN lke_aspek AS b ON a.id = b.rb_id
	INNER JOIN lke_sub_aspek AS d ON b.id = d.id_aspek
	INNER JOIN lke_sub_sub_aspek AS e ON d.id = e.id_sub_aspek
	INNER JOIN lke_indikator AS f ON e.id = f.id_sub_sub_aspek
	INNER JOIN lke_Jenis_Jawaban AS g ON f.jenis_jawaban = g.id 
	WHERE b.tahun = thnx;
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
			
			a.id,
			a.id_sub_sub_aspek,
			a.indikator,
			a.create_at,
			a.update_at,
			( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
			( SELECT GROUP_CONCAT( bukti_dukung SEPARATOR ',<br>' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
			IF(uidx IS NULL, 0 ,
				IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
			) AS jwbx,
			b.jenis_jawaban,
			a.jenis_jawaban AS jwbid,
			b.num,
-- 			IF
-- 				(((
-- 						SELECT
-- 							Jawaban 
-- 						FROM
-- 							lke_jawaban 
-- 						WHERE
-- 							id_indikator = a.id 
-- 							) IS NOT NULL 
-- 						) 
-- 					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
-- 					'1',
-- 					'0' 
-- 				) AS tombol 
			IF(
				(SELECT
					lke_aspek.batas_waktu
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_indikator.id = a.id) > NOW()
			,0,1) AS tombol
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
				
				a.id_sub_sub_aspek,
				a.indikator,
				a.create_at,
				a.update_at,
				( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
				( SELECT GROUP_CONCAT( bukti_dukung SEPARATOR ',<br>' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
				IF(uidx IS NULL, 0 ,
					IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
				) AS jwbx,
				b.jenis_jawaban,
				a.jenis_jawaban AS jwbid,
				b.num,
-- 				IF
-- 				(((
-- 						SELECT
-- 							Jawaban 
-- 						FROM
-- 							lke_jawaban 
-- 						WHERE
-- 							id_indikator = a.id 
-- 							) IS NOT NULL 
-- 						) 
-- 					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
-- 					'1',
-- 					'0' 
-- 				) AS tombol 
				IF(
				(SELECT
					lke_aspek.batas_waktu
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_indikator.id = a.id) > NOW()
			,0,1) AS tombol
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
					a.id_sub_sub_aspek,
					a.indikator,
					a.create_at,
					a.update_at,
					( SELECT GROUP_CONCAT( nama_parameter SEPARATOR ',<br>' ) FROM lke_parameter WHERE id_indikator = a.id ) AS parameter,
					( SELECT GROUP_CONCAT( bukti_dukung SEPARATOR ',<br>' ) FROM lke_bukti_dukung WHERE id_indikator = a.id ) AS bukti_dukung,
					IF(uidx IS NULL, 0 ,
						IF((SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx) IS NULL,0,(SELECT Jawaban FROM lke_jawaban WHERE id_indikator = a.id AND userid = uidx))
					) AS jwbx,
					b.jenis_jawaban,
					a.jenis_jawaban AS jwbid,
					b.num,
-- 					IF
-- 				(((
-- 						SELECT
-- 							Jawaban 
-- 						FROM
-- 							lke_jawaban 
-- 						WHERE
-- 							id_indikator = a.id 
-- 							) IS NOT NULL 
-- 						) 
-- 					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
-- 					'1',
-- 					'0' 
-- 				) AS tombol
					IF(
				(SELECT
					lke_aspek.batas_waktu
				FROM
					lke_indikator
					INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
					INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
					INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id
					WHERE lke_indikator.id = a.id) > NOW()
			,0,1) AS tombol
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
			( SELECT
				nama_sub_sub_aspek 
				FROM
					lke_sub_sub_aspek 
				WHERE
					id = a.id_sub_sub_aspek 
					LIMIT 1 
				) AS sub_sub_aspek,
				a.indikator,
				a.create_at,
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
			IF
				(((
						SELECT
							Jawaban 
						FROM
							lke_jawaban 
						WHERE
							id_indikator = a.id 
							) IS NOT NULL 
						) 
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) <= ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id AND upl.userid = uidx LIMIT 1),
					'1',
					'0' 
				) AS tombol,
				CONCAT(
					( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id AND upl.userid = uidx LIMIT 1),
					' / ',
					( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = a.id ) 
				) AS kemajuan 
			FROM
				lke_indikator AS a
				INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
				INNER JOIN lke_sub_aspek AS c ON b.id_sub_aspek = c.id
				INNER JOIN lke_aspek AS d ON c.id_aspek = d.id
				WHERE a.id IN (SELECT id_indikator FROM lke_parameter)
				ORDER BY a.create_at DESC LIMIT lmtx OFFSET ofset;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			( SELECT
				nama_sub_sub_aspek 
				FROM
					lke_sub_sub_aspek 
				WHERE
					id = a.id_sub_sub_aspek 
					LIMIT 1 
				) AS sub_sub_aspek,
				a.indikator,
				a.create_at,
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
			IF
				(((
						SELECT
							Jawaban 
						FROM
							lke_jawaban 
						WHERE
							id_indikator = a.id 
							) IS NOT NULL 
						) 
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id) <= ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id AND upl.userid = uidx LIMIT 1) ,
					'1',
					'0' 
				) AS tombol,
				CONCAT(
					( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id AND upl.userid = uidx LIMIT 1),
					' / ',
					( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = a.id ) 
				) AS kemajuan 
			FROM
				lke_indikator AS a
				INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
				INNER JOIN lke_sub_aspek AS c ON b.id_sub_aspek = c.id
				INNER JOIN lke_aspek AS d ON c.id_aspek = d.id
				WHERE d.id = idx AND a.id IN (SELECT id_indikator FROM lke_parameter)
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
-- 	harus ada parameternya
-- baru tampil datanya


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
				WHERE lke_aspek.id = a.id AND lke_jawaban.userid = uidx
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
	
	WHERE a.id IN (
	SELECT
		lke_aspek.id 
	FROM
		lke_parameter
		INNER JOIN lke_indikator ON lke_parameter.id_indikator = lke_indikator.id
		INNER JOIN lke_sub_sub_aspek ON lke_indikator.id_sub_sub_aspek = lke_sub_sub_aspek.id
		INNER JOIN lke_sub_aspek ON lke_sub_sub_aspek.id_sub_aspek = lke_sub_aspek.id
		INNER JOIN lke_aspek ON lke_sub_aspek.id_aspek = lke_aspek.id 
	WHERE
		lke_aspek.id = a.id 
	) AND a.tahun = thn

ORDER BY
	a.nama_aspek ASC;
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
			a.id,
			a.nama,
			a.bobot,
			a.create_at 
		FROM
			lke_rb AS a
			ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
	ELSE
		SELECT
			res, 
			msg,
			a.id,
			a.nama,
			a.bobot,
			a.create_at 
		FROM
			lke_rb AS a
			WHERE id = idx
			ORDER BY a.nama ASC LIMIT lmtx OFFSET ofset;
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
