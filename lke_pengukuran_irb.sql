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

 Date: 06/01/2025 16:01:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for lke_aspek
-- ----------------------------
DROP TABLE IF EXISTS `lke_aspek`;
CREATE TABLE `lke_aspek` (
  `id` int NOT NULL,
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
COMMIT;

-- ----------------------------
-- Table structure for lke_user
-- ----------------------------
DROP TABLE IF EXISTS `lke_user`;
CREATE TABLE `lke_user` (
  `uid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `UserName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FullName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PassEnc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
