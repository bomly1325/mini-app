-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.12-MariaDB-1:10.5.12+maria~focal - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table mini_app_db.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.admins: ~1 rows (approximately)
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Carlotta Kuhlman I', 'admin@example.com', '2021-10-28 15:24:00', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'n2ogIZpz3r', '2021-10-28 15:24:00', '2021-10-28 15:24:00');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.interests
CREATE TABLE IF NOT EXISTS `interests` (
  `id` bigint(20) unsigned NOT NULL,
  `frequency` char(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_interest_rate` decimal(2,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.interests: ~0 rows (approximately)
/*!40000 ALTER TABLE `interests` DISABLE KEYS */;
INSERT INTO `interests` (`id`, `frequency`, `default_interest_rate`) VALUES
	(1, 'Weekly', 0.01);
/*!40000 ALTER TABLE `interests` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.loans
CREATE TABLE IF NOT EXISTS `loans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `term_in_week` int(11) NOT NULL,
  `status` enum('new','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date DEFAULT NULL,
  `interest_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `admin_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `interest_rate` decimal(2,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `loans_interest_id_foreign` (`interest_id`),
  KEY `loans_user_id_foreign` (`user_id`),
  KEY `loans_admin_id_foreign` (`admin_id`),
  CONSTRAINT `loans_admin_id_foreign` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`),
  CONSTRAINT `loans_interest_id_foreign` FOREIGN KEY (`interest_id`) REFERENCES `interests` (`id`),
  CONSTRAINT `loans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.loans: ~1 rows (approximately)
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
INSERT INTO `loans` (`id`, `amount`, `term_in_week`, `status`, `start_date`, `interest_id`, `user_id`, `admin_id`, `created_at`, `updated_at`, `interest_rate`) VALUES
	(1, 5000.00, 52, 'approved', NULL, 1, 1, 1, '2021-10-30 04:07:27', '2021-10-30 06:37:36', 0.01);
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.migrations: ~8 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2021_10_28_152136_create_admin_table', 2),
	(7, '2021_10_30_023750_create_interest_table', 3),
	(10, '2021_10_30_023759_create_loans_table', 4),
	(12, '2021_10_30_023805_create_amortization_schedule_table', 5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) unsigned NOT NULL,
  `payment_date` date NOT NULL,
  `payment` decimal(10,2) NOT NULL,
  `interest` decimal(10,2) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `paid_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_loan_id_foreign` (`loan_id`),
  CONSTRAINT `payments_loan_id_foreign` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.payments: ~0 rows (approximately)
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` (`id`, `loan_id`, `payment_date`, `payment`, `interest`, `balance`, `paid`, `paid_date`) VALUES
	(1, 1, '2021-11-06', 96.15, 50.00, 4903.85, 1, '2021-10-30 07:10:45'),
	(2, 1, '2021-11-13', 96.15, 49.04, 4807.69, 0, NULL),
	(3, 1, '2021-11-20', 96.15, 48.08, 4711.54, 0, NULL),
	(4, 1, '2021-11-27', 96.15, 47.12, 4615.38, 0, NULL),
	(5, 1, '2021-12-04', 96.15, 46.15, 4519.23, 0, NULL),
	(6, 1, '2021-12-11', 96.15, 45.19, 4423.08, 0, NULL),
	(7, 1, '2021-12-18', 96.15, 44.23, 4326.92, 0, NULL),
	(8, 1, '2021-12-25', 96.15, 43.27, 4230.77, 0, NULL),
	(9, 1, '2022-01-01', 96.15, 42.31, 4134.62, 0, NULL),
	(10, 1, '2022-01-08', 96.15, 41.35, 4038.46, 0, NULL),
	(11, 1, '2022-01-15', 96.15, 40.38, 3942.31, 0, NULL),
	(12, 1, '2022-01-22', 96.15, 39.42, 3846.15, 0, NULL),
	(13, 1, '2022-01-29', 96.15, 38.46, 3750.00, 0, NULL),
	(14, 1, '2022-02-05', 96.15, 37.50, 3653.85, 0, NULL),
	(15, 1, '2022-02-12', 96.15, 36.54, 3557.69, 0, NULL),
	(16, 1, '2022-02-19', 96.15, 35.58, 3461.54, 0, NULL),
	(17, 1, '2022-02-26', 96.15, 34.62, 3365.38, 0, NULL),
	(18, 1, '2022-03-05', 96.15, 33.65, 3269.23, 0, NULL),
	(19, 1, '2022-03-12', 96.15, 32.69, 3173.08, 0, NULL),
	(20, 1, '2022-03-19', 96.15, 31.73, 3076.92, 0, NULL),
	(21, 1, '2022-03-26', 96.15, 30.77, 2980.77, 0, NULL),
	(22, 1, '2022-04-02', 96.15, 29.81, 2884.62, 0, NULL),
	(23, 1, '2022-04-09', 96.15, 28.85, 2788.46, 0, NULL),
	(24, 1, '2022-04-16', 96.15, 27.88, 2692.31, 0, NULL),
	(25, 1, '2022-04-23', 96.15, 26.92, 2596.15, 0, NULL),
	(26, 1, '2022-04-30', 96.15, 25.96, 2500.00, 0, NULL),
	(27, 1, '2022-05-07', 96.15, 25.00, 2403.85, 0, NULL),
	(28, 1, '2022-05-14', 96.15, 24.04, 2307.69, 0, NULL),
	(29, 1, '2022-05-21', 96.15, 23.08, 2211.54, 0, NULL),
	(30, 1, '2022-05-28', 96.15, 22.12, 2115.38, 0, NULL),
	(31, 1, '2022-06-04', 96.15, 21.15, 2019.23, 0, NULL),
	(32, 1, '2022-06-11', 96.15, 20.19, 1923.08, 0, NULL),
	(33, 1, '2022-06-18', 96.15, 19.23, 1826.92, 0, NULL),
	(34, 1, '2022-06-25', 96.15, 18.27, 1730.77, 0, NULL),
	(35, 1, '2022-07-02', 96.15, 17.31, 1634.62, 0, NULL),
	(36, 1, '2022-07-09', 96.15, 16.35, 1538.46, 0, NULL),
	(37, 1, '2022-07-16', 96.15, 15.38, 1442.31, 0, NULL),
	(38, 1, '2022-07-23', 96.15, 14.42, 1346.15, 0, NULL),
	(39, 1, '2022-07-30', 96.15, 13.46, 1250.00, 0, NULL),
	(40, 1, '2022-08-06', 96.15, 12.50, 1153.85, 0, NULL),
	(41, 1, '2022-08-13', 96.15, 11.54, 1057.69, 0, NULL),
	(42, 1, '2022-08-20', 96.15, 10.58, 961.54, 0, NULL),
	(43, 1, '2022-08-27', 96.15, 9.62, 865.38, 0, NULL),
	(44, 1, '2022-09-03', 96.15, 8.65, 769.23, 0, NULL),
	(45, 1, '2022-09-10', 96.15, 7.69, 673.08, 0, NULL),
	(46, 1, '2022-09-17', 96.15, 6.73, 576.92, 0, NULL),
	(47, 1, '2022-09-24', 96.15, 5.77, 480.77, 0, NULL),
	(48, 1, '2022-10-01', 96.15, 4.81, 384.62, 0, NULL),
	(49, 1, '2022-10-08', 96.15, 3.85, 288.46, 0, NULL),
	(50, 1, '2022-10-15', 96.15, 2.88, 192.31, 0, NULL),
	(51, 1, '2022-10-22', 96.15, 1.92, 96.15, 0, NULL),
	(52, 1, '2022-10-29', 96.15, 0.96, 0.00, 0, NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.personal_access_tokens: ~6 rows (approximately)
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

-- Dumping structure for table mini_app_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table mini_app_db.users: ~3 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Dr. Kaia Goodwin', 'user1@example.com', '2021-10-28 14:24:41', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'zRJRdbAmiI', '2021-10-28 14:24:41', '2021-10-28 14:24:41'),
	(2, 'Althea Rice', 'user2@example.com', '2021-10-28 14:24:41', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'pz1dfsZT32', '2021-10-28 14:24:41', '2021-10-28 14:24:41'),
	(3, 'Isom Schaden', 'user3@example.com', '2021-10-28 14:24:41', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'U2fIMDIBcW', '2021-10-28 14:24:41', '2021-10-28 14:24:41');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
