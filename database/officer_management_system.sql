-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2026 at 10:35 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `officer_management_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `DocID` bigint(20) UNSIGNED NOT NULL,
  `OfficerID` bigint(20) UNSIGNED NOT NULL,
  `FileName` varchar(255) NOT NULL,
  `FilePath` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`DocID`, `OfficerID`, `FileName`, `FilePath`, `created_at`, `updated_at`) VALUES
(1, 1, 'guests.pdf', 'documents/guests.pdf', '2026-04-01 01:19:16', '2026-04-01 01:19:16'),
(2, 2, 'Internship.pdf', 'documents/Internship.pdf', '2026-04-01 07:34:50', '2026-04-01 07:34:50'),
(4, 4, 'MyCV.pdf', 'documents/MyCV.pdf', '2026-04-02 18:29:49', '2026-04-02 18:29:49'),
(5, 18, 'guests (1).pdf', 'documents/guests (1).pdf', '2026-04-03 05:50:51', '2026-04-03 05:50:51'),
(6, 1, 'station.pdf', 'officer_documents/l1J2djSct5WlIKLeleDg1aso0oJn4PvXY8T0nfOZ.pdf', '2026-04-09 02:08:27', '2026-04-09 02:08:27'),
(7, 1, 'បណ្ដុះវិន័យ.pdf', 'officer_documents/3XvUBdAO01smFhAw3U4L51o5P6VBcLiSWgt29m6y.pdf', '2026-04-26 21:04:54', '2026-04-26 21:04:54'),
(8, 1, 'SengPricha.pdf', 'officer_documents/WwGrznV6pb2YaQB0fp9runFxK7QSeSke9nv8Rj0t.pdf', '2026-04-27 00:13:34', '2026-04-27 00:13:34'),
(9, 1, 'សួស្តីពិភពលោក.pdf', 'officer_documents/0FZ4XLt0cG29UfkkFANEtPBL5yrrsOQzf3vskggN.pdf', '2026-04-27 00:26:10', '2026-04-27 00:26:10'),
(10, 19, 'guests.pdf', 'officer_documents/VbqOrtC0MzWVf9EPPSeuOIfn1DSjEXBcocfChstY.pdf', '2026-04-27 01:22:18', '2026-04-27 01:22:18'),
(11, 4, 'VunVattanak.pdf', 'documents/VunVattanak.pdf', '2026-04-27 04:46:16', '2026-04-27 04:46:16');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(6, '0001_01_01_000000_create_users_table', 1),
(7, '0001_01_01_000001_create_cache_table', 1),
(8, '0001_01_01_000002_create_jobs_table', 1),
(9, '2026_03_31_032614_create_officer_system_tables', 1),
(10, '2026_03_31_043831_add_username_to_users_table', 1),
(11, '2026_04_01_025740_add_priority_to_roles_table', 2),
(12, '2026_04_01_071443_create_documents_table', 3),
(13, '2026_04_09_073309_add_status_note_to_officers_table', 4),
(14, '2026_04_27_045939_create_officer_biographies_table', 5),
(15, '2026_04_27_064128_change_effective_date_to_year_in_officer_biographies_table', 6),
(16, '2026_04_27_121911_add_parent_id_to_units_table', 7),
(17, '2026_04_28_020856_remove_parent_id_from_units_table', 8);

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `OfficerName` varchar(255) NOT NULL,
  `Gender` varchar(255) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `OfficerID_Code` varchar(255) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `ProfileImage` varchar(255) DEFAULT NULL,
  `RankID` bigint(20) UNSIGNED NOT NULL,
  `RoleID` bigint(20) UNSIGNED NOT NULL,
  `StatusID` bigint(20) UNSIGNED NOT NULL,
  `StatusNote` varchar(255) DEFAULT NULL,
  `UnitID` bigint(20) UNSIGNED NOT NULL,
  `PlanID` bigint(20) UNSIGNED DEFAULT NULL,
  `OfficeID` bigint(20) UNSIGNED DEFAULT NULL,
  `SectionID` bigint(20) UNSIGNED DEFAULT NULL,
  `PostID` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`ID`, `OfficerName`, `Gender`, `DOB`, `OfficerID_Code`, `StartDate`, `ProfileImage`, `RankID`, `RoleID`, `StatusID`, `StatusNote`, `UnitID`, `PlanID`, `OfficeID`, `SectionID`, `PostID`, `created_at`, `updated_at`) VALUES
(1, 'អ៊ូ ដេវីដ', 'ប្រុស', '2001-08-06', '205679', '2025-12-09', '7cVPLa9vRLW9QFR5qTY9LEn1Xzt1gfiUjWDg9ofA.jpg', 11, 13, 1, NULL, 1, 1, 1, NULL, NULL, '2026-04-01 01:19:16', '2026-04-28 18:39:54'),
(2, 'សេង សុគន្ធ', 'ប្រុស', '1967-03-09', '6095', '2006-10-02', '1777426759_IMG_5149.JPG', 3, 1, 1, NULL, 1, NULL, NULL, NULL, NULL, '2026-04-01 07:34:50', '2026-04-28 18:39:19'),
(4, 'វុន វឌ្ឍនៈ', 'ប្រុស', '1999-09-08', '109733', '2021-11-01', '7Fq0pRpo7B07QR7dfvhPKecGVHHCUbsY9qIPA34e.jpg', 10, 8, 1, NULL, 1, 1, 1, NULL, NULL, '2026-04-02 18:29:49', '2026-04-02 18:29:49'),
(5, 'ក', 'ប្រុស', '2000-02-10', '203838', '2024-04-03', NULL, 9, 13, 1, NULL, 2, NULL, NULL, NULL, 6, '2026-04-02 21:23:33', '2026-04-02 21:23:33'),
(6, 'ខ', 'ប្រុស', '2003-01-01', '208656', '2024-10-01', 'jncbpaO8kE3USgvYJoveJ4BEPg9B1nsrMPv8VaNu.png', 10, 13, 1, NULL, 1, 11, 27, 129, NULL, '2026-04-02 22:00:39', '2026-04-02 22:00:39'),
(7, 'គ', 'ប្រុស', '2002-12-07', '109822', '2023-01-04', 'b7lGeqELkN1ZeTwZpHgwVIi5jggQrsC3qoA3LtfA.jpg', 10, 13, 1, NULL, 3, NULL, NULL, NULL, 11, '2026-04-02 22:02:22', '2026-04-02 22:02:22'),
(8, 'ឃ', 'ប្រុស', '2002-11-04', '209433', '2020-12-01', NULL, 7, 12, 1, NULL, 3, NULL, NULL, 161, NULL, '2026-04-02 22:03:45', '2026-04-02 22:03:45'),
(9, 'ង', 'ប្រុស', '2001-04-01', '109282', '2022-04-01', 'FIQClht7emiVbYNvaatmj7E3lmK5MkEHmMPvXHMT.jpg', 11, 13, 1, NULL, 1, 2, 4, 14, NULL, '2026-04-02 22:05:28', '2026-04-02 22:05:28'),
(10, 'ច', 'ប្រុស', '2002-09-10', '209937', '2022-10-03', 'O8QiDcGTNFroviGVcn6CYfaMEDcqm69lGXQl3Epn.jpg', 10, 13, 1, NULL, 2, NULL, NULL, NULL, 8, '2026-04-02 22:06:40', '2026-04-02 22:06:40'),
(11, 'ឆ', 'ប្រុស', '2000-07-04', '209873', '2022-10-03', 'v3IPaC0xMRahonLKctS4jgJ17DdnuvhkJFjWUreg.jpg', 12, 12, 6, 'ទៅស្នងការខេត្តបាត់ដំបង', 4, NULL, NULL, NULL, 2, '2026-04-02 22:07:58', '2026-04-09 00:57:41'),
(12, 'ជ', 'ប្រុស', '2004-08-02', '102793', '2021-04-01', 'yGyMSLkTvlRUcA9mi20cz3lMio4dK0DeaiHhway7.jpg', 8, 13, 1, NULL, 4, NULL, NULL, NULL, 1, '2026-04-02 22:09:25', '2026-04-02 22:09:25'),
(13, 'ដ', 'ស្រី', '2005-02-01', '209387', '2020-04-06', '5na1FWo0WMS8KENJEA3Ng1rHa6ZScV7gCfH8g2N9.jpg', 10, 13, 1, NULL, 1, 8, 19, 90, NULL, '2026-04-02 22:16:14', '2026-04-02 22:16:14'),
(14, 'ត', 'ប្រុស', '2006-01-25', '209884', '2023-06-19', 'YA0odtikyZFtdp4cX0xkCjMKGqBhD0AqinkAS68u.jpg', 11, 13, 1, NULL, 4, NULL, NULL, NULL, 4, '2026-04-02 22:17:39', '2026-04-02 22:17:39'),
(15, 'ស', 'ប្រុស', '2000-07-14', '204522', '2024-04-02', 'QGOTCwjZTTqjpHVQSytjG0ra1CHqrfkcTiLabK0O.png', 11, 13, 1, NULL, 4, NULL, NULL, NULL, 3, '2026-04-02 22:37:45', '2026-04-02 22:37:45'),
(16, 'ប', 'ស្រី', '2000-01-24', '209736', '2020-12-01', 'IXHbwBDEJCP31rhkw10E3NjqpTDs2U5TuLLR0gV7.jpg', 8, 13, 9, NULL, 4, NULL, NULL, NULL, 2, '2026-04-03 00:09:49', '2026-04-03 00:09:49'),
(17, 'ល', 'ប្រុស', '2000-08-01', '209021', '2022-09-21', 'mZJXW1j04w00fSMmFBSLGSFZvNJ9TPeGCuK3PeWf.png', 10, 13, 4, NULL, 1, 12, 29, 138, NULL, '2026-04-03 02:21:22', '2026-04-03 02:21:22'),
(18, 'កុមារ', 'ប្រុស', '2000-02-15', '209735', '2022-04-06', 'DaoCXoeaLjuWOlMNmshxl9jz6ClTgLMmpOgh0GYN.png', 9, 13, 2, NULL, 3, NULL, NULL, NULL, 9, '2026-04-03 05:50:51', '2026-04-03 05:50:51'),
(19, 'ឡ', 'ប្រុស', '1989-02-01', '109762', '2009-11-10', '82YrcpGsRhN0cG0eC7hIWrSvRGQwzfJaDtxnS5kH.png', 7, 13, 7, NULL, 4, NULL, NULL, NULL, 1, '2026-04-03 06:07:41', '2026-04-03 06:07:41'),
(20, 'ល', 'ប្រុស', '1992-01-01', '100721', '2005-12-05', '93gEuIqlr7nZSi6C4PwREqUCh5Mmd5OckoWYJi9O.png', 10, 13, 8, NULL, 3, NULL, NULL, NULL, 9, '2026-04-03 06:25:42', '2026-04-03 06:25:42'),
(21, 'យ', 'ប្រុស', '1980-04-16', '70977', '1995-06-12', 'JBPr2woaHA8L3elAU5wCmzSGXPKjlr2IMdWefB1e.png', 9, 12, 10, NULL, 3, NULL, NULL, NULL, 10, '2026-04-03 06:39:27', '2026-04-03 06:39:27'),
(22, 'ឋ', 'ប្រុស', '1999-04-07', '150832', '2014-06-30', 'x1T5zRzGVzEOi4xhL5muQSLykPNTy1vFNQXZJA85.png', 11, 13, 11, NULL, 4, NULL, NULL, NULL, 2, '2026-04-03 06:51:45', '2026-04-03 06:51:45'),
(23, 'យ', 'ស្រី', '2003-11-19', '209830', '2018-08-06', 'OxGmLDvXnSZwVNZb4Av88pIfnZS96ZWRzxX0JliW.png', 8, 8, 5, 'មកពីស្នងការបាត់ដំបង', 1, 12, 29, NULL, NULL, '2026-04-03 07:34:40', '2026-04-26 19:20:31'),
(24, 'ក', 'ប្រុស', '2005-02-08', '209380', '2022-04-06', NULL, 10, 13, 6, NULL, 2, NULL, NULL, 155, NULL, '2026-04-09 00:43:38', '2026-04-09 00:43:38');

-- --------------------------------------------------------

--
-- Table structure for table `officer_biographies`
--

CREATE TABLE `officer_biographies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `officer_id` bigint(20) UNSIGNED NOT NULL,
  `rank_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `biography_name` varchar(255) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `effective_date` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `officer_biographies`
--

INSERT INTO `officer_biographies` (`id`, `officer_id`, `rank_id`, `role_id`, `biography_name`, `file_path`, `effective_date`, `created_at`, `updated_at`) VALUES
(1, 1, 12, 13, 'អនក្រ.០៩៣៤', NULL, '2024', '2026-04-27 00:13:33', '2026-04-27 00:13:33'),
(2, 1, 11, 10, 'អនក្រ.៨៩៣៦៣', NULL, '2025', '2026-04-27 00:26:10', '2026-04-28 21:41:33'),
(3, 19, 10, 13, 'សសរ.ដអក០១', NULL, '2020', '2026-04-27 01:22:18', '2026-04-27 01:22:18'),
(4, 4, 11, 13, 'ប្រក.នក៣២', NULL, '2022', '2026-04-27 04:46:16', '2026-04-27 04:46:16'),
(5, 1, 10, 9, 'ប្រក.កប៣១', NULL, '2026', '2026-04-28 21:50:27', '2026-04-28 21:50:27'),
(6, 12, 10, 13, 'ប្រក.កស', NULL, '2025', '2026-04-28 21:53:58', '2026-04-28 21:53:58');

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `OfficeID` bigint(20) UNSIGNED NOT NULL,
  `OfficeName` varchar(255) NOT NULL,
  `PlanID` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`OfficeID`, `OfficeName`, `PlanID`, `created_at`, `updated_at`) VALUES
(1, 'ការិយាល័យបុគ្គលិក', 1, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(2, 'ការិយាល័យបណ្ដុះបណ្ដាល', 1, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(3, 'ការិយាល័យផ្សព្វផ្សាយអប់រំ', 1, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(4, 'ការិយាល័យរដ្ឋបាល', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(5, 'ការិយាល័យសរុបផែនការ', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(6, 'ការិយាល័យវិទ្យុទាក់ទង', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(7, 'ការិយាល័យកិច្ចការប៉ុស្ដិ៍នគរបាលរដ្ឋបាល', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(8, 'ការិយាល័យអក្សរសម្ងាត់', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(9, 'ការិយាល័យអន្ដរាគមន៍ និងតម្រួតបទបញ្ជា', 2, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(10, 'ការិយាល័យនគរបាលព្រហ្មទណ្ឌកម្រិតធ្ងន់', 3, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(11, 'ការិយាល័យនគរបាលព្រហ្មទណ្ឌកម្រិតស្រាល', 3, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(12, 'ការិយាល័យនគរបាលបច្ចេកទេស និងវិទ្យាសាស្រ្ត', 3, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(13, 'ការិយាល័យនគរបាលប្រឆាំងបទល្មើសសេដ្ឋកិច្ច', 4, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(14, 'ការិយាល័យប្រឆាំងគ្រឿងញៀន', 5, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(15, 'ការិយាល័យប្រឆាំងការជួញដូរមនុស្ស និងការពារអនីតិជន', 6, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(16, 'ការិយាល័យសន្តិសុខផ្ទៃក្នុង', 7, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(17, 'ការិយាល័យប្រឆាំងភេរវកម្មនិងឧក្រិដ្ខកម្មឆ្លងដែន', 7, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(18, 'ការិយាល័យគ្រប់គ្រងសន្តិសុខឯកជន', 7, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(19, 'ការិយាល័យនគរបាលចរាចរណ៍ផ្លូវគោក', 8, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(20, 'ការិយាល័យនគរបាលសណ្តាប់ធ្នាប់', 8, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(21, 'ការិយាល័យនគរបាលទេសចរណ៍', 8, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(22, 'ការិយាល័យបង្ការ និងពន្លត់អគ្គិភ័យ', 9, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(23, 'ការិយាល័យគ្រប់គ្រងអាវុធជាតិផ្ទុះ-ជាតិពុល', 9, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(24, 'ការិយាល័យគ្រប់គ្រងជនបរទេស', 10, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(25, 'ការិយាល័យស៊ើបអង្កេត និងអនុវត្តនីតិវិធី', 10, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(26, 'ការិយាល័យគ្រប់គ្រងការស្នាក់នៅ', 11, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(27, 'ការិយាល័យអត្តសញ្ញាណបណ្ណសញ្ជាតិខ្មែរ', 11, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(28, 'ការិយាល័យភស្តុភារ', 12, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(29, 'ការិយាល័យសុខាភិបាល', 12, '2026-04-01 04:50:10', '2026-04-01 04:50:10'),
(30, 'ការិយាល័យគណនេយ្យ', 12, '2026-04-01 04:50:10', '2026-04-01 04:50:10');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `PlanID` bigint(20) UNSIGNED NOT NULL,
  `PlanName` varchar(255) NOT NULL,
  `UnitID` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`PlanID`, `PlanName`, `UnitID`, `created_at`, `updated_at`) VALUES
(1, 'ផែនការងារធនធានមនុស្ស', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(2, 'ផែនការងារសេនាធិការ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(3, 'ផែនការងារនគរបាលព្រហ្មទណ្ឌ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(4, 'ផែនការងារនគរបាលប្រឆាំងបទល្មើសសេដ្ឋកិច្ច', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(5, 'ផែនការងារប្រឆាំងគ្រឿងញៀន', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(6, 'ផែនការងារប្រឆាំងការជួញដូរមនុស្សនិងការពារអនីតិជន និងការពារយេនឌ័រ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(7, 'ផែនការងារសន្ដិសុខ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(8, 'ផែនការងារសណ្ដាប់ធ្នាប់', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(9, 'ផែនការងារគ្រប់គ្រងអាវុធជាតិផ្ទុះ និងអគ្គីភ័យ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(10, 'ផែនការងារអន្ដោប្រវេសន៍', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(11, 'ផែនការងារអត្តសញ្ញាណកម្ម', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(12, 'ផែនការងារភស្ដុភារ និងហិរញ្ញវត្ថុ', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38'),
(13, 'ផែននគរបាលការពារព្រំដែនគោកលេខ៨២១', 1, '2026-04-01 03:26:38', '2026-04-01 03:26:38');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `PostID` bigint(20) UNSIGNED NOT NULL,
  `PostName` varchar(255) NOT NULL,
  `UnitID` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`PostID`, `PostName`, `UnitID`, `created_at`, `updated_at`) VALUES
(1, 'ប៉ុស្តិ៍ឡាក់ ៦៨', 4, NULL, NULL),
(2, 'ប៉ុស្តិ៍ទួលរំដេង', 4, NULL, NULL),
(3, 'ប៉ុស្តិ៍សិល្បៈ', 4, NULL, NULL),
(4, 'ប៉ុស្តិ៍អូរឈើក្រំ', 4, NULL, NULL),
(5, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលអូរតាវ៉ៅ', 2, NULL, NULL),
(6, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលប៉ៃលិន', 2, NULL, NULL),
(7, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលទួលល្វា', 2, NULL, NULL),
(8, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលបរយ៉ាខា', 2, NULL, NULL),
(9, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលស្ទឹងកាច់', 3, NULL, NULL),
(10, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលអូរអណ្តូង', 3, NULL, NULL),
(11, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលសាលាក្រៅ', 3, NULL, NULL),
(12, 'ប៉ុស្តិ៍នគរបាលរដ្ឋបាលស្ទឹងត្រង់', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE `ranks` (
  `RankID` bigint(20) UNSIGNED NOT NULL,
  `RankName` varchar(255) NOT NULL,
  `Priority` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`RankID`, `RankName`, `Priority`, `created_at`, `updated_at`) VALUES
(1, 'នាយឧត្តមសេនីយ៍', 1, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(2, 'ឧត្តមសេនីយ៍ឯក', 2, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(3, 'ឧត្តមសេនីយ៍ទោ', 3, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(4, 'ឧត្តមសេនីយ៍ត្រី', 4, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(5, 'វរសេនីយ៍ឯក', 5, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(6, 'វរសេនីយ៍ទោ', 6, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(7, 'វរសេនីយ៍ត្រី', 7, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(8, 'អនុសេនីយ៍ឯក', 8, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(9, 'អនុសេនីយ៍ទោ', 9, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(10, 'អនុសេនីយ៍ត្រី', 10, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(11, 'ព្រិន្ទបាលឯក', 11, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(12, 'ព្រិន្ទបាលទោ', 12, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(13, 'ពលបាលឯក', 13, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(14, 'ពលបាលទោ', 14, '2026-04-01 01:42:46', '2026-04-01 01:42:46'),
(15, 'ពលបាលត្រី', 15, '2026-04-01 01:42:46', '2026-04-01 01:42:46');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `RoleID` bigint(20) UNSIGNED NOT NULL,
  `RoleName` varchar(255) NOT NULL,
  `Priority` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`RoleID`, `RoleName`, `Priority`, `created_at`, `updated_at`) VALUES
(1, 'ស្នងការ', 1, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(2, 'ស្នងការរង', 2, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(3, 'មេបញ្ជាការ', 5, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(4, 'អធិការ', 4, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(5, 'មេបញ្ជាការរង', 8, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(6, 'អធិការរង', 7, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(7, 'នាយការិយាល័យ', 3, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(8, 'នាយរងការិយាល័យ', 6, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(9, 'នាយផ្នែក', 9, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(10, 'នាយរងផ្នែក', 10, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(11, 'នាយប៉ុស្ដិ៍', 11, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(12, 'នាយរងប៉ុស្ដិ៍', 12, '2026-04-01 03:08:37', '2026-04-01 03:08:37'),
(13, 'មន្រ្តី', 13, '2026-04-01 03:08:37', '2026-04-01 03:08:37');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `SectionID` bigint(20) UNSIGNED NOT NULL,
  `SectionName` varchar(255) NOT NULL,
  `OfficeID` bigint(20) UNSIGNED DEFAULT NULL,
  `UnitID` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`SectionID`, `SectionName`, `OfficeID`, `UnitID`, `created_at`, `updated_at`) VALUES
(1, 'ផ្នែករដ្ឋបាលសរុប', 1, NULL, NULL, NULL),
(2, 'ផ្នែកអត្តសញ្ញាណប័ណ្ណ', 1, NULL, NULL, NULL),
(3, 'ផ្នែកក្របខណ្ឌ និងបៀវត្ស', 1, NULL, NULL, NULL),
(4, 'ផ្នែកបុគ្គលិក', 1, NULL, NULL, NULL),
(5, 'ផ្នែកគោលនយោបាយ', 1, NULL, NULL, NULL),
(6, 'ផ្នែកគ្រប់គ្រងសំណុំលិខិតបុគ្គលិក', 1, NULL, NULL, NULL),
(7, 'ផ្នែកអនុវត្តវិន័យ', 1, NULL, NULL, NULL),
(8, 'ផ្នែករដ្ឋបាលសរុប', 2, NULL, NULL, NULL),
(9, 'ផ្នែកបណ្ដុះបណ្ដាល និងវិក្រឹត្យការ', 2, NULL, NULL, NULL),
(10, 'ផ្នែកកម្មវិធីសិក្សា', 2, NULL, NULL, NULL),
(11, 'ផ្នែករដ្ឋបាលសរុប', 3, NULL, NULL, NULL),
(12, 'ផ្នែកផ្សព្វផ្សាយអប់រំ រូបភាព និងដំណឹង', 3, NULL, NULL, NULL),
(13, 'ផ្នែកអប់រំសិល្បៈ និងកីឡា', 3, NULL, NULL, NULL),
(14, 'ផ្នែករដ្ឋបាលសរុប', 4, NULL, NULL, NULL),
(15, 'ផ្នែកនាំសារ', 4, NULL, NULL, NULL),
(16, 'ផ្នែកទំនាក់ទំនងសាធារណៈការ និងពិធីការ', 4, NULL, NULL, NULL),
(17, 'ផ្នែករដ្ឋបាលសរុប', 5, NULL, NULL, NULL),
(18, 'ផ្នែកតាមដានបូកសរុបការងារអធិការដ្ឋាន', 5, NULL, NULL, NULL),
(19, 'ផ្នែកតាមដានបូកសរុបការងារការិយាល័យជំនាញ', 5, NULL, NULL, NULL),
(20, 'ផ្នែកព័ត៌មានវិទ្យា', 5, NULL, NULL, NULL),
(21, 'ផ្នែករដ្ឋបាលសរុប', 6, NULL, NULL, NULL),
(22, 'ផ្នែកបច្ចេកទេស', 6, NULL, NULL, NULL),
(23, 'ផ្នែកអនុវត្តនីតិវិធី', 6, NULL, NULL, NULL),
(24, 'ផ្នែកប្រចាំបញ្ជា', 6, NULL, NULL, NULL),
(25, 'ផ្នែករដ្ឋបាលសរុប', 7, NULL, NULL, NULL),
(26, 'ផ្នែកបណ្ដុះបណ្ដាល', 7, NULL, NULL, NULL),
(27, 'ផ្នែកនគរបាល និងសហគមន៍', 7, NULL, NULL, NULL),
(28, 'ផ្នែកផែនការ និងយុទ្ធសាស្រ្តប៉ុស្ដិ៍', 7, NULL, NULL, NULL),
(29, 'ផ្នែកអភិវឌ្ឃត្រួតពិនិត្យវាយតម្លៃប៉ុស្ដិ៍', 7, NULL, NULL, NULL),
(30, 'ផ្នែករដ្ឋបាល និងបញ្ជូនសារ', 8, NULL, NULL, NULL),
(31, 'ផ្នែកអក្សរសម្ងាត់រដ្ឋ', 8, NULL, NULL, NULL),
(32, 'ផ្នែកអក្សរសម្ងាត់នគរបាល', 8, NULL, NULL, NULL),
(33, 'ផ្នែករដ្ឋបាលសរុប', 9, NULL, NULL, NULL),
(34, 'ផ្នែកអន្តរាគមន៍', 9, NULL, NULL, NULL),
(35, 'ផ្នែកការពារគោលដៅ', 9, NULL, NULL, NULL),
(36, 'ផ្នែកចល័តការងារ', 9, NULL, NULL, NULL),
(37, 'ផ្នែកទប់ស្កាត់ កូដកម្ម បាតុកម្ម', 9, NULL, NULL, NULL),
(38, 'ផ្នែកតម្រួតបទបញ្ជា', 9, NULL, NULL, NULL),
(39, 'ផ្នែករដ្ឋបាលសរុប', 10, NULL, NULL, NULL),
(40, 'ផ្នែកស្រាវជ្រាវ និងស៊ើបអង្កេត', 10, NULL, NULL, NULL),
(41, 'ផ្នែកសួរចម្លើយ-សំណុំរឿង', 10, NULL, NULL, NULL),
(42, 'ផ្នែកបទឧក្រិដ្ឋ១', 10, NULL, NULL, NULL),
(43, 'ផ្នែកបទឧក្រិដ្ឋ២', 10, NULL, NULL, NULL),
(44, 'ផ្នែកអនុវត្តន៍ដីកា', 10, NULL, NULL, NULL),
(45, 'ផ្នែកអន្ដរាគមន៍', 10, NULL, NULL, NULL),
(46, 'ផ្នែករដ្ឋបាលសរុប', 11, NULL, NULL, NULL),
(47, 'ផ្នែកសួរចម្លើយ និងសំណុំរឿង', 11, NULL, NULL, NULL),
(48, 'ផ្នែកស្រាវជ្រាវ និងស៊ើបអង្កេត', 11, NULL, NULL, NULL),
(49, 'ផ្នែកបទមជ្ឈឹម១', 11, NULL, NULL, NULL),
(50, 'ផ្នែកបទមជ្ឈឹម២', 11, NULL, NULL, NULL),
(51, 'ផ្នែករដ្ឋបាលសរុប', 12, NULL, NULL, NULL),
(52, 'ផ្នែកពិនិត្យកន្លែងកើតហេតុ', 12, NULL, NULL, NULL),
(53, 'ផ្នែកគំនូសប្លង់កន្លែងកើតហេតុ និងថតរូប', 12, NULL, NULL, NULL),
(54, 'ផ្នែកកោសល្យវិច័យ', 12, NULL, NULL, NULL),
(55, 'ផ្នែកប័ណ្ណសារ', 12, NULL, NULL, NULL),
(56, 'ផ្នែករដ្ឋបាលសរុប', 13, NULL, NULL, NULL),
(57, 'ផ្នែកការពារតម្លៃបរិមាណ និងគុណភាព', 13, NULL, NULL, NULL),
(58, 'ផ្នែកប្រឆាំងបទល្មើសកម្មសិទ្ធបញ្ញា', 13, NULL, NULL, NULL),
(59, 'ផ្នែកប្រឆាំងបទល្មើសគេចពន្ធ និងសារពើពន្ធ', 13, NULL, NULL, NULL),
(60, 'ផ្នែកការពារធនធានធម្មជាតិ បរិស្ថាន និងសុខុមាលភាព', 13, NULL, NULL, NULL),
(61, 'ផ្នែកប្រឆាំងបទល្មើសអាជីវកម្ម សេវាកម្ម និងផលិតកម្ម', 13, NULL, NULL, NULL),
(62, 'ផ្នែកការពារសន្ដិសុខសេដ្ឋកិច្ចជាតិ', 13, NULL, NULL, NULL),
(63, 'ផ្នែកប្រឆាំងបទល្មើសវិស្វកម្ម ស្ថាបត្យកម្ម និងវិនិយោគ', 13, NULL, NULL, NULL),
(64, 'ផ្នែករដ្ឋបាលសរុប', 14, NULL, NULL, NULL),
(65, 'ផ្នែកស្រាវជ្រាវ និងស៊ើបអង្កេត', 14, NULL, NULL, NULL),
(66, 'ផ្នែកសួរចម្លើយ និងសំណុំរឿង', 14, NULL, NULL, NULL),
(67, 'ផ្នែកប្រឆាំងគ្រឿងញៀន', 14, NULL, NULL, NULL),
(68, 'ផ្នែករដ្ឋបាលសរុប', 15, NULL, NULL, NULL),
(69, 'ផ្នែកប្រឆាំងការជួញដូរមនុស្ស', 15, NULL, NULL, NULL),
(70, 'ផ្នែកប្រឆាំងអំពើហឹង្សា និងរំលោភផ្លូវភេទ', 15, NULL, NULL, NULL),
(71, 'ផ្នែកព័ត៌មាន និងបង្ការទប់ស្កាត់', 15, NULL, NULL, NULL),
(72, 'ផ្នែកការពារអនីតិជន', 15, NULL, NULL, NULL),
(73, 'ផ្នែករដ្ឋបាលសរុប', 16, NULL, NULL, NULL),
(74, 'ផ្នែកផែនការសរុបវិភាគ', 16, NULL, NULL, NULL),
(75, 'ផ្នែកព័ត៌មានលើវិស័យសេដ្ឋកិច្ច វប្បធ៌ម និងអប់រំសង្គម', 16, NULL, NULL, NULL),
(76, 'ផ្នែកការពារសម្ងាត់ជាតិ', 16, NULL, NULL, NULL),
(77, 'ផ្នែកស៊ើបការណ៍', 16, NULL, NULL, NULL),
(78, 'ផ្នែករដ្ឋបាលសរុប', 17, NULL, NULL, NULL),
(79, 'ផ្នែកប្រមូលព័ត៌មាន', 17, NULL, NULL, NULL),
(80, 'ផ្នែកស៊ើបអង្កេត', 17, NULL, NULL, NULL),
(81, 'ផ្នែកសន្តិសុខសហគមន៍ និងសាសនា', 17, NULL, NULL, NULL),
(82, 'ផ្នែកស៊ើបការណ៍ខាងក្រៅ', 17, NULL, NULL, NULL),
(83, 'ផ្នែកប្រតិបត្តិការបង្រ្កាប', 17, NULL, NULL, NULL),
(84, 'ផ្នែករដ្ឋបាលសរុប', 18, NULL, NULL, NULL),
(85, 'ផ្នែកគ្រប់គ្រងសហគ្រាស គ្រឹះស្ថាន និងកម្លាំងភ្នាក់ងារសន្តិសុខឯកជន', 18, NULL, NULL, NULL),
(86, 'ផ្នែកបណ្តុះបណ្តាល និងបច្ចេកទេស', 18, NULL, NULL, NULL),
(87, 'ផ្នែកផ្នែកអន្តរាគមន៍', 18, NULL, NULL, NULL),
(88, 'ផ្នែកស៊ើបអង្កេត និងនីតិវិធី', 18, NULL, NULL, NULL),
(89, 'ផ្នែករដ្ឋបាលសរុប', 19, NULL, NULL, NULL),
(90, 'ផ្នែកបញ្ជាចរាចរណ៍', 19, NULL, NULL, NULL),
(91, 'ផ្នែកដោះស្រាយគ្រោះថ្នាក់ចរាចរណ៍', 19, NULL, NULL, NULL),
(92, 'ផ្នែកឃោសនា និងល្បាតត្រួតពិនិត្យ', 19, NULL, NULL, NULL),
(93, 'ផ្នែកអន្តរាគមន៍', 19, NULL, NULL, NULL),
(94, 'ផ្នែករដ្ឋបាលសរុប', 20, NULL, NULL, NULL),
(95, 'ផ្នែកឃោសនាផ្សព្វផ្សាយការងារសណ្តាប់ធ្នាប់', 20, NULL, NULL, NULL),
(96, 'ផ្នែកសណ្តាប់ធ្នាប់គោលដៅ', 20, NULL, NULL, NULL),
(97, 'ផ្នែកបង្ការ និងបង្រ្កាបបទល្មើសសម្បត្តិវប្បធម៌', 20, NULL, NULL, NULL),
(98, 'ផ្នែកអន្តរាគមន៍', 20, NULL, NULL, NULL),
(99, 'ផ្នែករដ្ឋបាលសរុប', 21, NULL, NULL, NULL),
(100, 'ផ្នែកការពារ និងអន្តរាគមន៍', 21, NULL, NULL, NULL),
(101, 'ផ្នែកនីតិវិធី', 21, NULL, NULL, NULL),
(102, 'ផ្នែកព័ត៌មាន', 21, NULL, NULL, NULL),
(103, 'ផ្នែកទំនាក់ទំនងសាធារណៈ', 21, NULL, NULL, NULL),
(104, 'ផ្នែករដ្ឋបាលសរុប', 22, NULL, NULL, NULL),
(105, 'ផ្នែកបច្ចេកទេស និងបង្ការអគ្គិភ័យ', 22, NULL, NULL, NULL),
(106, 'ផ្នែកកោសល្យវិច័យអគ្គិភ័យ', 22, NULL, NULL, NULL),
(107, 'ផ្នែកសង្គ្រោះ', 22, NULL, NULL, NULL),
(108, 'ផ្នែកហ្វឹកហ្វឺន និងពន្លត់អគ្គិភ័យ', 22, NULL, NULL, NULL),
(109, 'ផ្នែករដ្ឋបាលសរុប', 23, NULL, NULL, NULL),
(110, 'ផ្នែកគ្រប់គ្រងអាវុធគ្រឿងផ្ទុះ', 23, NULL, NULL, NULL),
(111, 'ផ្នែកគ្រប់គ្រងមុខរបរងាយប៉ះពាល់ដល់សន្តិសុខសង្គម និងជាតិពុល', 23, NULL, NULL, NULL),
(112, 'ផ្នែករដ្ឋបាលសរុប', 24, NULL, NULL, NULL),
(113, 'ផ្នែកអធិការកិច្ចពលករបរទេស', 24, NULL, NULL, NULL),
(114, 'ផ្នែកអន្តោប្រវេសន៍', 24, NULL, NULL, NULL),
(115, 'ផ្នែកគ្រប់គ្រងជនបរទេសមិនមែនអន្តោប្រវេសន៍ ', 24, NULL, NULL, NULL),
(116, 'ផ្នែករដ្ឋបាលសរុប', 25, NULL, NULL, NULL),
(117, 'ផ្នែកស៊ើបការណ៍', 25, NULL, NULL, NULL),
(118, 'ផ្នែកប្រតិបត្តិការ និងនីតិវិធី', 25, NULL, NULL, NULL),
(119, 'ផ្នែកប្រមូលព័ត៌មាន', 25, NULL, NULL, NULL),
(120, 'ផ្នែករដ្ឋបាលសរុប', 26, NULL, NULL, NULL),
(121, 'ផ្នែកព័ត៌មានវិទ្យា', 26, NULL, NULL, NULL),
(122, 'ផ្នែកកិច្ចការស្ថិតិប្រជាពលរដ្ឋ', 26, NULL, NULL, NULL),
(123, 'ផ្នែកគ្រប់គ្រងការស្នាក់នៅ', 26, NULL, NULL, NULL),
(124, 'ផ្នែកប័ណ្ណសារ', 26, NULL, NULL, NULL),
(125, 'ផ្នែកតាមដានពិនិត្យនីតិវិធីស្ថិតិ', 26, NULL, NULL, NULL),
(126, 'ផ្នែករដ្ឋបាលសរុប', 27, NULL, NULL, NULL),
(127, 'ផ្នែកប័ណ្ណសារ', 27, NULL, NULL, NULL),
(128, 'ផ្នែកបេឡា', 27, NULL, NULL, NULL),
(129, 'ផ្នែកព័ត៌មានវិទ្យា', 27, NULL, NULL, NULL),
(130, 'ផ្នែកតាមដានត្រួតពិនិត្យ', 27, NULL, NULL, NULL),
(131, 'ផ្នែករដ្ឋបាលសរុប', 28, NULL, NULL, NULL),
(132, 'ផ្នែកដឹកជញ្ជូន និងយានដ្ឋាន', 28, NULL, NULL, NULL),
(133, 'ផ្នែកភស្តុភារ', 28, NULL, NULL, NULL),
(134, 'ផ្នែកផែនការ', 28, NULL, NULL, NULL),
(135, 'ផ្នែករដ្ឋបាលសរុប', 29, NULL, NULL, NULL),
(136, 'ផ្នែកគ្រប់គ្រងឱសថ', 29, NULL, NULL, NULL),
(137, 'ផ្នែកបច្ចេកទេស និងគិលានុដ្ឋាន', 29, NULL, NULL, NULL),
(138, 'ផ្នែកសង្រ្គោះបន្ទាន់', 29, NULL, NULL, NULL),
(139, 'ផ្នែករដ្ឋបាលសរុប', 30, NULL, NULL, NULL),
(140, 'ផ្នែកផែនការ', 30, NULL, NULL, NULL),
(141, 'ផ្នែកគណនេយ្យ', 30, NULL, NULL, NULL),
(142, 'ផ្នែកសេនាធិការ', NULL, 4, NULL, NULL),
(143, 'ផ្នែកបុគ្គលិក', NULL, 4, NULL, NULL),
(144, 'ផ្នែកវិទ្យុទាក់ទង', NULL, 4, NULL, NULL),
(145, 'ផ្នែកសុខាភិបាល', NULL, 4, NULL, NULL),
(146, 'ផ្នែកភស្ដុភារ', NULL, 4, NULL, NULL),
(147, 'ផ្នែកស៊ើបការណ៍', NULL, 4, NULL, NULL),
(148, 'ផ្នែកសេនាធិការ', NULL, 2, NULL, NULL),
(149, 'ផ្នែកសន្តិសុខ', NULL, 2, NULL, NULL),
(150, 'ផ្នែកនគរបាលយុត្តិធម៌', NULL, 2, NULL, NULL),
(151, 'ផ្នែកសណ្តាប់ធ្នាប់សាធារណៈ', NULL, 2, NULL, NULL),
(152, 'ផ្នែកពិនិត្យវិភាគកន្លែងកើតហេតុ', NULL, 2, NULL, NULL),
(153, 'ផ្នែកអក្សរសម្ងាត់', NULL, 2, NULL, NULL),
(154, 'ផ្នែកកិច្ចការប៉ុស្តិ៍នគរបាលរដ្ឋបាល', NULL, 2, NULL, NULL),
(155, 'ផ្នែកអត្តសញ្ញាណកម្ម', NULL, 2, NULL, NULL),
(156, 'ផ្នែកប្រឆាំងគ្រឿងញៀន', NULL, 2, NULL, NULL),
(157, 'ផ្នែកអន្តោប្រវេសន៍', NULL, 2, NULL, NULL),
(158, 'ផ្នែកសេនាធិការ', NULL, 3, NULL, NULL),
(159, 'ផ្នែកសន្តិសុខ', NULL, 3, NULL, NULL),
(160, 'ផ្នែកនគរបាលយុត្តិធម៌', NULL, 3, NULL, NULL),
(161, 'ផ្នែកសណ្តាប់ធ្នាប់សាធារណៈ', NULL, 3, NULL, NULL),
(162, 'ផ្នែកពិនិត្យវិភាគកន្លែងកើតហេតុ', NULL, 3, NULL, NULL),
(163, 'ផ្នែកអក្សរសម្ងាត់', NULL, 3, NULL, NULL),
(164, 'ផ្នែកកិច្ចការប៉ុស្តិ៍នគរបាលរដ្ឋបាល', NULL, 3, NULL, NULL),
(165, 'ផ្នែកអត្តសញ្ញាណកម្ម', NULL, 3, NULL, NULL),
(166, 'ផ្នែកប្រឆាំងគ្រឿងញៀន', NULL, 3, NULL, NULL),
(167, 'ផ្នែកអន្តោប្រវេសន៍', NULL, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('m7Xgu7VGL03VFLQx4iZwTLYVWWysNDLSaOynlbJ6', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI0SWNwTEdCY0ZoR0l4SE40UzI5eXlsVzZ2UUNiTzZLYmF2eGFuM0RaIiwidXJsIjpbXSwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9zdGFmZlwvY3JlYXRlIiwicm91dGUiOiJzdGFmZi5jcmVhdGUifSwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6MX0=', 1777441866);

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `StatusID` bigint(20) UNSIGNED NOT NULL,
  `StatusName` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`StatusID`, `StatusName`, `created_at`, `updated_at`) VALUES
(1, 'សកម្ម', NULL, NULL),
(2, 'ជាប់វិន័យ', NULL, NULL),
(3, 'បេសកកម្ម', NULL, NULL),
(4, 'ការងារសិក្សា', NULL, NULL),
(5, 'ផ្ទេរចូល', NULL, NULL),
(6, 'ផ្ទេរចេញ', NULL, NULL),
(7, 'មរណៈ', NULL, NULL),
(8, 'កាត់ ឬបណ្ដេញចេញពីក្របខណ្ឌ', NULL, NULL),
(9, 'សោធននិវត្តន៍', NULL, NULL),
(10, 'ពិការ ឬបាត់បង់សមត្ថភាព', NULL, NULL),
(11, 'ព្យួរក្របខណ្ឌ', NULL, NULL),
(12, 'ការសរសើរ', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `UnitID` bigint(20) UNSIGNED NOT NULL,
  `UnitName` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`UnitID`, `UnitName`, `created_at`, `updated_at`) VALUES
(1, 'ស្នងការដ្ឋាននគរបាលខេត្តប៉ៃលិន', '2026-04-01 02:35:59', '2026-04-01 02:35:59'),
(2, 'អធិការដ្ឋាននគរបាលក្រុងប៉ៃលិន', '2026-04-01 02:35:59', '2026-04-01 02:35:59'),
(3, 'អធិការដ្ឋាននគរបាលស្រុកសាលាក្រៅ', '2026-04-01 02:35:59', '2026-04-01 02:35:59'),
(4, 'វរសេនាតូចនគរបាលការពារព្រំដែនគោកលេខ ៨២១', '2026-04-01 02:35:59', '2026-04-01 02:35:59');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Vid911', 'vid911', 'vid911@gmail.com', NULL, '$2y$12$jOnjrWkfxNyT9efNYLXvZ.OjiHE/wagfH8q1nCq7/hBOO/mH4Doda', NULL, '2026-03-31 18:48:54', '2026-03-31 18:48:54');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`DocID`),
  ADD KEY `documents_officerid_foreign` (`OfficerID`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `officers_rankid_foreign` (`RankID`),
  ADD KEY `officers_roleid_foreign` (`RoleID`),
  ADD KEY `officers_statusid_foreign` (`StatusID`),
  ADD KEY `officers_unitid_foreign` (`UnitID`),
  ADD KEY `officers_planid_foreign` (`PlanID`),
  ADD KEY `officers_officeid_foreign` (`OfficeID`),
  ADD KEY `officers_sectionid_foreign` (`SectionID`),
  ADD KEY `officers_postid_foreign` (`PostID`);

--
-- Indexes for table `officer_biographies`
--
ALTER TABLE `officer_biographies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_biographies_officer_id_foreign` (`officer_id`),
  ADD KEY `officer_biographies_rank_id_foreign` (`rank_id`),
  ADD KEY `officer_biographies_role_id_foreign` (`role_id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`OfficeID`),
  ADD KEY `offices_planid_foreign` (`PlanID`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`PlanID`),
  ADD KEY `plans_unitid_foreign` (`UnitID`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`PostID`),
  ADD KEY `posts_unitid_foreign` (`UnitID`);

--
-- Indexes for table `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`RankID`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`RoleID`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`SectionID`),
  ADD KEY `sections_officeid_foreign` (`OfficeID`),
  ADD KEY `sections_unitid_foreign` (`UnitID`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`StatusID`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`UnitID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `DocID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `officers`
--
ALTER TABLE `officers`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `officer_biographies`
--
ALTER TABLE `officer_biographies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `OfficeID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `PlanID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `PostID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `RankID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `RoleID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `SectionID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `StatusID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `UnitID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_officerid_foreign` FOREIGN KEY (`OfficerID`) REFERENCES `officers` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `officers`
--
ALTER TABLE `officers`
  ADD CONSTRAINT `officers_officeid_foreign` FOREIGN KEY (`OfficeID`) REFERENCES `offices` (`OfficeID`),
  ADD CONSTRAINT `officers_planid_foreign` FOREIGN KEY (`PlanID`) REFERENCES `plans` (`PlanID`),
  ADD CONSTRAINT `officers_postid_foreign` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `officers_rankid_foreign` FOREIGN KEY (`RankID`) REFERENCES `ranks` (`RankID`),
  ADD CONSTRAINT `officers_roleid_foreign` FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`),
  ADD CONSTRAINT `officers_sectionid_foreign` FOREIGN KEY (`SectionID`) REFERENCES `sections` (`SectionID`),
  ADD CONSTRAINT `officers_statusid_foreign` FOREIGN KEY (`StatusID`) REFERENCES `status` (`StatusID`),
  ADD CONSTRAINT `officers_unitid_foreign` FOREIGN KEY (`UnitID`) REFERENCES `units` (`UnitID`);

--
-- Constraints for table `officer_biographies`
--
ALTER TABLE `officer_biographies`
  ADD CONSTRAINT `officer_biographies_officer_id_foreign` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `officer_biographies_rank_id_foreign` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`RankID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `officer_biographies_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`RoleID`) ON UPDATE CASCADE;

--
-- Constraints for table `offices`
--
ALTER TABLE `offices`
  ADD CONSTRAINT `offices_planid_foreign` FOREIGN KEY (`PlanID`) REFERENCES `plans` (`PlanID`) ON DELETE CASCADE;

--
-- Constraints for table `plans`
--
ALTER TABLE `plans`
  ADD CONSTRAINT `plans_unitid_foreign` FOREIGN KEY (`UnitID`) REFERENCES `units` (`UnitID`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_unitid_foreign` FOREIGN KEY (`UnitID`) REFERENCES `units` (`UnitID`);

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_officeid_foreign` FOREIGN KEY (`OfficeID`) REFERENCES `offices` (`OfficeID`),
  ADD CONSTRAINT `sections_unitid_foreign` FOREIGN KEY (`UnitID`) REFERENCES `units` (`UnitID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
