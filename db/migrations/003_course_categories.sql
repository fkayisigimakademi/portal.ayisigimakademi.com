-- ============================================================
-- Migration: 003 - Kurs Kategorileri
-- Açıklama: Ayisigimakademi için temel kurs kategori yapısı oluşturulur.
-- Tarih: 2025-01-01
-- ============================================================

-- Mevcut Miscellaneous kategorisini koru, yenilerini ekle
-- (Moodle kurulumunda id=1 olan kategori zaten var)

-- Ana kategoriler
INSERT IGNORE INTO `mdl_course_categories` (`name`, `idnumber`, `description`, `parent`, `sortorder`, `coursecount`, `visible`, `depth`, `path`, `theme`, `timemodified`)
VALUES
    ('Matematik',     'CAT_MATEMATIK',    'Matematik dersleri',             0, 10000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP()),
    ('Fen Bilimleri', 'CAT_FEN',          'Fen ve doğa bilimleri dersleri', 0, 20000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP()),
    ('Türkçe / Edebiyat', 'CAT_TURKCE',   'Türkçe ve edebiyat dersleri',    0, 30000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP()),
    ('Yabancı Dil',   'CAT_YD',           'İngilizce ve diğer dil dersleri',0, 40000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP()),
    ('Sosyal Bilimler','CAT_SOSYAL',       'Tarih, Coğrafya, Felsefe',       0, 50000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP()),
    ('Sınavlara Hazırlık', 'CAT_SINAV',   'YKS, LGS, KPSS hazırlık',       0, 60000, 0, 1, 1, '/0', '', UNIX_TIMESTAMP());

-- path alanını güncelle (kategori id'leri oluşturulduktan sonra)
UPDATE `mdl_course_categories` SET `path` = CONCAT('/', `id`) WHERE `parent` = 0 AND `id` > 1;

-- Bu migration'ı kaydet
INSERT IGNORE INTO `ayisigi_applied_migrations` (`filename`, `description`)
VALUES ('003_course_categories.sql', 'Temel kurs kategorileri oluşturuldu');
