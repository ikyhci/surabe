-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3309
-- Waktu pembuatan: 09 Jun 2025 pada 11.29
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
-- Indeks untuk tabel `lke_user`
--
ALTER TABLE `lke_user`
  ADD PRIMARY KEY (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
