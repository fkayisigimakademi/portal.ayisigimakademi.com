-- ============================================================
-- Migration: 002 - Temel Site Yapılandırması
-- Açıklama: Moodle site ayarlarını Türkçe ve platform gereksinimlerine göre düzenler.
-- Tarih: 2025-01-01
-- ============================================================

-- Varsayılan dil: Türkçe
UPDATE `mdl_config` SET `value` = 'tr' WHERE `name` = 'lang';

-- Site tam adı
UPDATE `mdl_config` SET `value` = 'Ayisigimakademi Portal' WHERE `name` = 'fullname';

-- Site kısa adı
UPDATE `mdl_config` SET `value` = 'AYK-Portal' WHERE `name` = 'shortname';

-- Zaman dilimi: İstanbul
UPDATE `mdl_config` SET `value` = 'Asia/Istanbul' WHERE `name` = 'timezone';

-- Self-registration kapalı (admin hesap açar)
UPDATE `mdl_config` SET `value` = '0' WHERE `name` = 'registerauth';

-- Misafir girişi kapalı
UPDATE `mdl_config` SET `value` = '0' WHERE `name` = 'guestloginbutton';

-- E-posta bildirimleri açık
UPDATE `mdl_config` SET `value` = '1' WHERE `name` = 'emailonlyfromnoreplyaddress';

-- Bu migration'ı kaydet
INSERT IGNORE INTO `ayisigi_applied_migrations` (`filename`, `description`)
VALUES ('002_site_configuration.sql', 'Temel site yapılandırması uygulandı');
