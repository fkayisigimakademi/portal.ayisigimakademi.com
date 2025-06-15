-- ============================================================
-- Migration: 004 - Google Meet Eklentisi Kurulum Kaydı
-- Açıklama: mod_googlemeet eklentisinin veritabanı tablolarını
--           Moodle upgrade aracı yerine doğrudan oluşturur.
--           Moodle upgrade CLI'yi kullandıktan sonra bu migration'ı çalıştırın.
-- Tarih: 2025-01-01
-- ============================================================

-- Google Meet aktivite tablosu
CREATE TABLE IF NOT EXISTS `mdl_googlemeet` (
    `id`           BIGINT(10)   UNSIGNED NOT NULL AUTO_INCREMENT,
    `course`       BIGINT(10)   UNSIGNED NOT NULL DEFAULT 0,
    `name`         VARCHAR(255) NOT NULL DEFAULT '',
    `intro`        LONGTEXT,
    `introformat`  SMALLINT(4)  NOT NULL DEFAULT 0,
    `meeturl`      VARCHAR(1024) NOT NULL DEFAULT '',
    `starttime`    BIGINT(10)   DEFAULT NULL,
    `duration`     SMALLINT(5)  DEFAULT 60,
    `timecreated`  BIGINT(10)   NOT NULL DEFAULT 0,
    `timemodified` BIGINT(10)   NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    KEY `mdl_goog_cou_ix` (`course`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  COMMENT='Google Meet canlı ders aktiviteleri';

-- Bu migration'ı kaydet
INSERT IGNORE INTO `ayisigi_applied_migrations` (`filename`, `description`)
VALUES ('004_google_meet_plugin.sql', 'Google Meet eklenti tablosu oluşturuldu');
