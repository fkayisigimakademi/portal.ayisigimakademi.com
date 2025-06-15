-- ============================================================
-- Docker MySQL İlk Başlangıç Scripti
-- Bu dosya MySQL container ilk kez başladığında otomatik çalışır.
-- (/docker-entrypoint-initdb.d/ mekanizması)
-- ============================================================

-- Charset ve collation güvencesi
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- Moodle için önerilen ayarlar
SET GLOBAL innodb_file_per_table = ON;
SET GLOBAL max_allowed_packet = 67108864;  -- 64MB
