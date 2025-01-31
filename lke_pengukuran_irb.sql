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

 Date: 30/01/2025 18:58:02
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
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('01a75049450717a248822411267e350e1556869b', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Keamanan Informasi (optional/wajib bagi yang telah menerapkan Sistem Manajemen Keamanan Informasi/ISO 27001)', '2025-01-26 09:19:57', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('036014ab1a3061359e34ecf3596e7d34ddcb83a5', '374367084e673af84bcbf2f998198f6e2e02770d', 'Dokumen Manajemen Risiko SPBE PD', '2025-01-26 09:21:59', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('07c52bc24fd731b35d4b0a06e24aebd4af75c2b7', '8de2575da7ddfcb955d14e62558d057fd37f3cea', 'Nota Dinas', '2025-01-26 09:16:04', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('1ba86412761491a8ba9816dcef83087b0c772356', '7da5fbc0249bd6ea50b43fac211ae09911eba00e', 'Roadmap TIK yang dimiliki PD (Dokumen peta jalan TIK/Rencana Induk TIK/Masterplan Pengembangan TIK) dan Renstra PD', '2025-01-26 09:20:58', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('250fd68d20187f3f6fec8214a693f1ac5e4b9b0e', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Surat Permohonan', '2025-01-26 09:27:36', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('2ac7a07aa5bd59892125f98d23fec8cce41b9742', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', 'Nota Dinas', '2025-01-26 09:24:25', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('36c27dbf736d1e4def8879f7e4fa242a18155b2a', '37707fc0417b80bb7dfa064f979a2c5ab7073eb3', 'Surat Edaran', '2025-01-26 09:27:20', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('37bb12e2bf176d0a9901a514f11677398bf3a93e', '96b4ad37bdeb28ba9ddabde33068ae38c29d3f46', 'Alokasi anggaran TIK diselaraskan antara roadmap dengan renstra', '2025-01-26 09:23:49', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('446b1f1826c499438e5997be8c45a327e84054a9', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Infrastruktur (optional/wajib bagi yang memiliki infrastruktur sendiri dan memanfaatkan Pusat Data Nasional)', '2025-01-26 09:19:42', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('44d91bfe6df3bddc9ea50b56113bc0ee6a8b6246', '4abb0d7caa97e312fd7bc64f9c546c8aac281776', 'Dokumen Manajemen Data PD (List user, log aktivitas, dataset PD)', '2025-01-26 09:14:33', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('4c1eb8e041367470eaded5434cff0d8a359520b0', '2297bc7097bd46bc7c4ede020b5ae086066a1db1', 'Domain Aplikasi (selaras dengan Layanan dan data/informasi-nya)', '2025-01-26 09:19:10', NULL);
INSERT INTO `lke_bukti_dukung` (`id`, `id_indikator`, `bukti_dukung`, `create_at`, `update_at`) VALUES ('5017aab44f2e1a342e1ffb695c221963cf774398', '123338438afd46814a983f6dd03618590f3c651a', 'apalah', '2025-01-22 15:42:16', NULL);
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
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`) VALUES ('8d417d314fb55d22059b4fa1729a0021033542d6', 'YA', 'd39a3d69e310f99b1f244bc750956ee64c8a7bc0', '2025-01-27 13:42:06', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL);
INSERT INTO `lke_jawaban` (`id`, `Jawaban`, `id_indikator`, `create_at`, `update_at`, `userid`, `nilai`) VALUES ('dab21673045d094c124e830afc928e45756b906f', 'YA', 'cbb3fb1ca87f3f9131e7465c95a0bd4745759125', '2025-01-27 14:20:15', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', NULL);
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
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1219b19995ae5a993e7a535d87186d15015807c5', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 10:38:07', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('16a65c40b50af8085e71bec5646b6fc3019e6218', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:39:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('1fce37d33284e935fbcf9f7c69d2cd2019362302', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:45:19', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('37370561649955e31efc975fe12d9f8e9990623f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:25:02', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('38f8a336d864627e473608e15782eb644df7317a', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:34:59', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('3bf97aa06fd8e31fca274dc8766e3d652066a3ae', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:12:34', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('55a52b342310fc1d9855eb216fa6d97b2ab73067', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 11:27:52', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5b56261f266f0a93a3b5eacb32dafa51cf89233b', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:43:22', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('5e6218f561856dbec3eec97229a575936c407813', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:10:23', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('651425d805ae3d8de3e89a549486e8521898c579', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:21:38', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('679258574282bcb2061ccc619b6d978c14601cd6', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:10:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('6bab7835cdadec9581c0b64f8fc3cd79cfb2b1dc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:32:21', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('73edc6b2ccacdd8ae680ec71a6414dc5bc3c394f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:38:48', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7cd95939bc4e38a47b5ecfc1e824a1b101c1a82f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:01:21', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('7d50d350aac733ec5b4c94e0d306806868908d1b', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 14:56:57', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('86fbf2adae48025d7e203cc2c8690199ed9a7340', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 18:11:08', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('87ad1fa3ec3d6b1ccd03f45fb1a8b834988485f3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:11:17', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8be37c97ca0ed046233e61a8e00ea133ed20b7c6', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:53:17', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('8c83b7c3a923f8b2bfa6c3b3d08843b8ab42ab59', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 14:57:10', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a1aba678f81c8fd8b9b634afa39f9a2ebb11a593', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:08:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a48d01ca030ba240f241082d0956b15ec38f9acc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 09:32:46', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('a910d294390b7bf8f4635ea791ac0aaad9ffd270', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 14:15:43', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('aa2cd6731047488e5cabceadf96fd036ec4bbf6d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 17:33:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b0ba296eec072a1c7bf7f20fc860d183ad6ce97d', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:45:06', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b17495b3f1017f51d029c6711a6122a317fe5497', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 14:55:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('b705235beea9cec8b3a1cd26a18a23f74efbc7aa', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:03:24', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c070ec60722bf06c74d9952f6b85e7bb7a4400ad', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:32:11', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c19a19eeb5782fcb29134c3bda068b05608ca55f', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:23:36', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c1ef09f5fc12be7a3c58ad946e2b8edf403b23bd', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 16:13:36', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c2f7097cb56216a5458e5346a521d5f3f15e94b3', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-29 14:23:05', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c46a7b55b4056ce0efbff21f86e81c415f33d9ea', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 13:45:01', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c5b9e8859926d041c0edd58e1818e785a1d44f59', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 15:29:39', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('c70c5db9a3e521bfa1b74206e8de78e1d99f6586', '85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', '2025-01-30 17:53:40', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('ce127aafe16c74adbe98b46d55e4a99c892d34dc', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:29:28', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dc4a72f365dc60ea8d0ea0d31da514521eb4d667', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 18:21:02', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('dd7cac1d12cfe50f75f946dd224cc4ae01d086b7', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:13:05', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e287e1daecfdea59c5fcce3bc62f045ad084bf84', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 11:27:19', '::1', 'LOGOUT');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e3171902fc74bc07d8247c3911817697f6b39fc2', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:47:03', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('e6bde6283b049cb4bf2f4da7e1c0c14dde14ba40', 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', '2025-01-30 15:40:00', '::1', 'LOGIN');
INSERT INTO `lke_log_user` (`id`, `userid`, `fullname`, `loged_at`, `ip`, `status`) VALUES ('eaee3a15831495ee314497f1d0d2b6e40ed5485e', 'c01e70c5551bf859d6de5dd332deaf41c6895742', 'Super Admin', '2025-01-29 13:49:41', '::1', 'LOGIN');
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
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('00034df0b4462ad22a9130ccb112561ae5a0ec21', '2025-01-30 14:57:10', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 14:57:10');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('00fc783eb5a4e47db2a26da88c8da68cac0d2749', '2025-01-30 18:21:02', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:21:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0eb2ad98120a0f94d53aef7a4af05392b48f8486', '2025-01-30 15:40:00', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:40:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('0f7e7028169911ed995e77daac2382e4c9274c6b', '2025-01-30 15:10:36', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:10:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('11a09aeb705d4a8a06c298d3e0ea245866a28af9', '2025-01-30 13:52:49', 'ERROR', 'System', 'del Parameter :Unknown column \'id_parameter\' in \'field list\'', '2025-01-30 13:52:49');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('13e16b9ed7b2fd06c48c29c872918bc5a2824e1b', '2025-01-27 14:20:15', 'INSERT', 'user', 'Tambah Data Jawaban : YAParameter : Telah menggunakan Layanan Jaringan Intra Pemerintah Daerah', '2025-01-27 14:20:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('20b1de531f98743ae2e0a7933f6aebacf9aa3fff', '2025-01-30 17:34:59', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:34:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2610f57e2ec08a1c2ded78db7f8d29b5f5a242f0', '2025-01-30 11:27:19', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 11:27:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2cb2d17a39f7abed4669cc490663e8d5e0f867f9', '2025-01-30 14:08:34', 'ERROR', 'System', 'del Parameter :Unknown column \'odk\' in \'where clause\'', '2025-01-30 14:08:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2d21166edcd39d89719df0ecb0d25820d3a51716', '2025-01-30 15:38:48', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:38:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2e9375d5f30fccc59e4416b122dafee3fe048eb7', '2025-01-30 11:27:52', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 11:27:52');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2efd66ac5b3f902377dd318602e2e508ead522d7', '2025-01-30 17:53:40', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 17:53:40');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('2f4c7ee2ac619d95f3726bfc4d763da75f4c3fda', '2025-01-30 15:39:48', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:39:48');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('324efc0dceb32550b7edf4092f6ee03dd43ee938', '2025-01-29 13:45:19', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:45:19');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('37408f5a1bcb9da617498fe8ab93119847913644', '2025-01-30 13:45:01', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 13:45:01');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('3c806fa5c23a9fa9b8477ff10d70d2f7d6abbab8', '2025-01-30 15:32:11', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:32:11');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('4044fa87ea91a9de351dda612f8a8736ca2e2e4a', '2025-01-30 14:10:32', 'INSERT', 'soal', 'Tambah Data Parameter : nama parameternya', '2025-01-30 14:10:32');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('52f471237c6a0334e1453312b4122b1e1678a4fc', '2025-01-30 18:11:17', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:11:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('5eb8d0e25238c7541d62609982b196e019e04919', '2025-01-30 14:56:57', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 14:56:57');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('637fd165c3345618c4432cb9bb5706e4cd004caf', '2025-01-30 16:08:03', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:08:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('6e3a98e58fdba5d440e880eaf4354585b0b99c6f', '2025-01-30 16:13:36', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:13:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('716e8482fc1656bf2bc1d9839bdeff533883a699', '2025-01-29 13:47:03', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:47:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('7416de49565495aa7d74cd8413bac3b76ac9f77b', '2025-01-30 14:09:00', 'DELETE', 'soal', 'Hapus Parameter  : nama parametrnya', '2025-01-30 14:09:00');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('76024e5e09a55b7828a895da19d66cffb2e2839a', '2025-01-30 15:10:23', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:10:23');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('80b59b0dfda2f2c49036af3535fc8b7b035124cc', '2025-01-30 18:21:38', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:21:38');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('84d7cdd09074e5b0d339124eec8ca4f47bbed607', '2025-01-30 09:32:47', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 09:32:47');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('859c7e5d4732b72e9fa3e7c01e1940549f58b573', '2025-01-29 14:15:43', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 14:15:43');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8604f30b87ad0fcdddb6f3cc73c09f8138cb187a', '2025-01-30 14:09:56', 'DELETE', 'soal', 'Hapus Parameter  : nama parameternya', '2025-01-30 14:09:56');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('889354e7bc9e96c58e6f63f4c9699de77102e5a5', '2025-01-30 16:01:21', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:01:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8a166909b67ac7bbd93e42a2bf66e8da741253dd', '2025-01-30 18:23:36', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 18:23:36');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('8b3d5f66c7c59694c5f83c1a644425cf205bdccc', '2025-01-30 15:13:05', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:13:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9332a7ccc3e5fd759c777b7640ade3857dc8ccce', '2025-01-29 13:49:41', 'LOGIN', 'USER', 'User Login :Super Admin', '2025-01-29 13:49:41');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('947316f4be1b67ba3a76972b6357d9fb1e50b3ee', '2025-01-30 17:33:03', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:33:03');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('956a91fb1e1d440f22360c85477f7ad23c498d6c', '2025-01-30 10:38:07', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 10:38:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('9622450e8be20acac386f104815c56f8303be39a', '2025-01-30 11:02:07', 'INSERT', 'administrator', 'Tambah Data Berhasil : soal Full Name : soal', '2025-01-30 11:02:07');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('97b3482e260ae55db13565c87af35e2b263a97e7', '2025-01-27 14:20:15', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737958815_73d000c2efbc76785db7.jpeg ,bukti Dukung  : 89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-01-27 14:20:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('a8c8763647028207975f2f90ca87f4bbaeb68cfc', '2025-01-29 14:23:05', 'LOGIN', 'USER', 'User Login :user', '2025-01-29 14:23:05');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('b7f78e3e5b239e5e23fcc589240991104921719a', '2025-01-30 16:03:24', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 16:03:24');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('bad8a896cefd2916738a749f9cdb9f40f2ce5662', '2025-01-30 17:53:17', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:53:17');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c3cf4ac2e5bef4a372a23ddb7a73b1c13fde4b04', '2025-01-30 14:10:37', 'DELETE', 'soal', 'Hapus Parameter  : nama parameternya', '2025-01-30 14:10:37');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c88189f03614a06c3641c90b56e15bd53fcf170f', '2025-01-30 14:09:50', 'INSERT', 'soal', 'Tambah Data Parameter : nama parameternya', '2025-01-30 14:09:50');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('c97cedab5fe7d39fb19cc563e20ebaa6e6cbae2b', '2025-01-27 14:25:15', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737959115_a2aa9578e9a43de60a27.xlsx ,bukti Dukung  : 2ac7a07aa5bd59892125f98d23fec8cce41b9742', '2025-01-27 14:25:15');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d17e9e5ccbd7e25d1b244c706e928f3f35db9046', '2025-01-30 18:11:08', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 18:11:08');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d28956086b50fd4c7b11dba0c1229b96654b50f3', '2025-01-30 15:29:39', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:29:39');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('d44264c64e1f5e013fb8d01bd2c703393253f11a', '2025-01-27 13:42:06', 'INSERT', 'user', 'Tambah Data File Bukti Dukung : 1737956526_5572248522f278d4fe7f.jpeg ,bukti Dukung  : 7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-01-27 13:42:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('da7433a16f01b5586fc877e4538c245d48e36093', '2025-01-30 17:25:02', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 17:25:02');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e3606e69e35629f1f911164ba321c459b7d42160', '2025-01-29 14:22:59', 'UPDATE', 'user', 'UPDATE Password User  : user Full Name : user', '2025-01-29 14:22:59');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('e7faffaf37e9302013a0c6866e8c14866d8501cd', '2025-01-27 13:42:06', 'INSERT', 'user', 'Tambah Data Jawaban : YAParameter : Telah Menggunakan Layanan Perencanan Berbasis Elektronik', '2025-01-27 13:42:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('ef2e06c724a5c3ca6392abec380b666af8484901', '2025-01-30 15:32:21', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:32:21');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f2e980e104c002d1943eb97e55d886f3e846e1db', '2025-01-30 15:45:06', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:45:06');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f53e3999169842e9aa6570513def7999271beaac', '2025-01-30 15:29:28', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:29:28');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('f944a6fd23d1510c410c61810f585eb8c61e522e', '2025-01-30 15:12:34', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 15:12:34');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fbcf1d623d8673311e176d27de3ee474aabc5aff', '2025-01-30 15:43:22', 'LOGIN', 'USER', 'User Login :user', '2025-01-30 15:43:22');
INSERT INTO `lke_logs` (`id`, `log`, `info`, `user`, `content`, `create_at`) VALUES ('fbcf845295120f6415c9878a07b1f6f7f3c265f1', '2025-01-30 14:55:24', 'LOGIN', 'USER', 'User Login :soal', '2025-01-30 14:55:24');
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
INSERT INTO `lke_opd` (`id`, `nama_opd`, `create_at`, `update_at`) VALUES ('17fd850a367a6c2d45f29ff28054e76be1b11468', '-', '2025-01-08 20:55:35', NULL);
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
INSERT INTO `lke_role` (`Uid`, `RoleId`, `Create_at`, `Update_at`) VALUES ('85adeb743adbcd35b7cf642df747d5f128e6125a', '8fdad4894c55a3dbfb4fe280c02bd55512df3803', '2025-01-30 11:02:07', NULL);
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
  `userid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of lke_upload_bukti
-- ----------------------------
BEGIN;
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('28553b83e28cf7067b326b9a9b6ad72f0ef6ea2f', '1737958815_73d000c2efbc76785db7.jpeg', '89dffecba42d250ecebf3069a7ccda4ae0b8f913', '2025-01-27 14:20:15', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
INSERT INTO `lke_upload_bukti` (`id`, `files`, `id_bukti`, `create_at`, `update_at`, `userid`) VALUES ('2b4e8ff757a111d437786848e5490ad4c21de238', '1737956526_5572248522f278d4fe7f.jpeg', '7b3f2f3c3be15de407ff4d02881c424482970ad9', '2025-01-27 13:42:06', NULL, 'a3fff5eb4d729348ff7aaf71a69bd3e78b072da5');
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
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('85adeb743adbcd35b7cf642df747d5f128e6125a', 'soal', 'soal', 0xD69AEAED31B2EF9D2D4338276965F075, '0', 'soal@mail.com', '2025-01-30 11:02:07', NULL, 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('a3fff5eb4d729348ff7aaf71a69bd3e78b072da5', 'user', 'user', 0xD69AEAED31B2EF9D2D4338276965F075, '-', '-', '2025-01-07 19:10:31', '2025-01-29 14:22:59', 'TRUE');
INSERT INTO `lke_user` (`uid`, `UserName`, `FullName`, `PassEnc`, `Phone`, `EmailAdds`, `Create_at`, `Update_at`, `actv`) VALUES ('c01e70c5551bf859d6de5dd332deaf41c6895742', 'administrator', 'Super Admin', 0xD69AEAED31B2EF9D2D4338276965F075, '-', '-', '2025-01-07 13:47:03', NULL, 'TRUE');
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
			IF(uidx IS NULL,0,
				IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
			) 
			 AS filesx,
			 IF(uidx IS NULL,0,
				IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
			) 
			 AS fl_id,
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
				IF(uidx IS NULL,0,
					IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
				) 
				 AS filesx,
				 IF(uidx IS NULL,0,
				IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
			) 
			 AS fl_id,
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
					IF(uidx IS NULL,0,
						IF((SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT files FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
					) 
					 AS filesx,
					 IF(uidx IS NULL,0,
						IF((SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) IS NULL,'0',(SELECT id FROM lke_upload_bukti WHERE id_bukti = a.id AND userid = uidx) )
					) 
					 AS fl_id,
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
			b.num,
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
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					'1',
					'0' 
				) AS tombol 
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
				b.num,
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
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					'1',
					'0' 
				) AS tombol 
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
					b.num,
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
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					'1',
					'0' 
				) AS tombol
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
CREATE PROCEDURE `View_Jawaban_By_OPD`(idx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
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
			a.Jawaban,
			d.nama_opd,
			b.UserName,
			e.indikator 
		FROM
			lke_jawaban AS a
			INNER JOIN lke_user AS b ON a.userid = b.uid
			INNER JOIN lke_detail_opd AS c ON b.uid = c.userid
			INNER JOIN lke_opd AS d ON c.opdid = d.id
			INNER JOIN lke_indikator AS e ON a.id_indikator = e.id;
	ELSE
		SET res = 1;
		SET msg = 'success';
		SELECT
			res, msg,
			a.Jawaban,
			d.nama_opd,
			b.UserName,
			e.indikator 
		FROM
			lke_jawaban AS a
			INNER JOIN lke_user AS b ON a.userid = b.uid
			INNER JOIN lke_detail_opd AS c ON b.uid = c.userid
			INNER JOIN lke_opd AS d ON c.opdid = d.id
			INNER JOIN lke_indikator AS e ON a.id_indikator = e.id
			WHERE a.id = idx;
	
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
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					'1',
					'0' 
				) AS tombol,
				CONCAT(
					( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					' / ',
					( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = a.id ) 
				) AS kemajuan 
			FROM
				lke_indikator AS a
				INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
				INNER JOIN lke_sub_aspek AS c ON b.id_sub_aspek = c.id
				INNER JOIN lke_aspek AS d ON c.id_aspek = d.id
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
					AND ( SELECT COUNT(*) FROM lke_bukti_dukung WHERE id_indikator = a.id ) = ( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					'1',
					'0' 
				) AS tombol,
				CONCAT(
					( SELECT COUNT(*) FROM lke_upload_bukti AS upl INNER JOIN lke_bukti_dukung AS bktx ON upl.id_bukti = bktx.id WHERE bktx.id_indikator = a.id ),
					' / ',
					( SELECT COUNT(*) FROM lke_bukti_dukung WHERE lke_bukti_dukung.id_indikator = a.id ) 
				) AS kemajuan 
			FROM
				lke_indikator AS a
				INNER JOIN lke_sub_sub_aspek AS b ON a.id_sub_sub_aspek = b.id
				INNER JOIN lke_sub_aspek AS c ON b.id_sub_aspek = c.id
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
-- Procedure structure for View_UploadFile
-- ----------------------------
DROP PROCEDURE IF EXISTS `View_UploadFile`;
delimiter ;;
CREATE PROCEDURE `View_UploadFile`(idx VARCHAR(255),uidx VARCHAR(255),lmt VARCHAR(255), ofst VARCHAR(255))
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
			ORDER BY a.Create_at ASC LIMIT lmtx OFFSET ofset;
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
