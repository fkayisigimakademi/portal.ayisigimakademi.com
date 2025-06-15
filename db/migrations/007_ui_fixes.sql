-- Migration 007: UI Düzeltmeleri
-- - Sağdaki blok çekmecesini gizle
-- - "Kontrol paneli" → "Portalım" (dil dosyası üzerinden)
-- - "Kur oluştur" → "Kurs oluştur" typo düzelt (dil dosyası üzerinden)
-- - Site varsayılan dili Türkçe yap (tarayıcı dili yoksay)
-- - Profil: son IP ve ilk erişim alanını yönetici dışından gizle
-- - Profil: "Çeşitli" bölüm başlığını gizle

-- ========================================
-- 1. Site varsayılan dil ayarları
-- ========================================
INSERT INTO mdl_config (name, value)
VALUES
  ('lang',     'tr'),
  ('autolang', '0'),
  ('langmenu', '0')
ON DUPLICATE KEY UPDATE value = VALUES(value);

-- ========================================
-- 2. Profil gizlilik: son IP ve ilk erişim
-- ========================================
INSERT INTO mdl_config (name, value)
VALUES ('hiddenuserfields', 'lastip,firstaccess')
ON DUPLICATE KEY UPDATE value = VALUES(value);

-- ========================================
-- NOT: Aşağıdaki değişiklikler PHP script
-- ile uygulanır (dil dosyaları + SCSS):
--
-- a) /var/moodledata/lang/tr/moodle.php:
--    'myhome'         → 'Portalım'
--    'miscellaneous'  → '' (boş)
--
-- b) /var/moodledata/lang/tr/block_myoverview.php:
--    'createcourse'   → 'Kurs oluştur'
--
-- c) theme_boost_union SCSS:
--    .drawer.drawer-right gizleme
--    .drawer-toggler.drawer-right-toggle gizleme
--    profil lastip/firstaccess SCSS gizleme
-- ========================================
