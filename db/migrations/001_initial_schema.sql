-- ============================================================
-- Migration: 001 - İlk Kurulum Kaydı
-- Açıklama: Moodle ilk kurulumu tamamlandıktan sonra çalıştırılır.
--           Bu migration, migration takip tablosunu oluşturur.
-- Tarih: 2025-01-01
-- ============================================================

-- Migration takip tablosu (Moodle'ın kendi tablolarından ayrı)
CREATE TABLE IF NOT EXISTS `ayisigi_applied_migrations` (
    `id`           INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `filename`     VARCHAR(255)     NOT NULL,
    `applied_at`   DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `description`  TEXT,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_filename` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Özel SQL migration geçmişi';

-- Bu migration'ın kendisini kaydet
INSERT IGNORE INTO `ayisigi_applied_migrations` (`filename`, `description`)
VALUES ('001_initial_schema.sql', 'Migration takip tablosu oluşturuldu');
