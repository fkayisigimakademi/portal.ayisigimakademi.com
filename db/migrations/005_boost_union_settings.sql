-- ============================================================
-- Migration: 005 - Boost Union Tema Ayarları (güncellenmiş)
-- Açıklama: Ayışığı Akademi için Boost Union renk, SCSS, slider,
--           kategori tile'ları ve info banner ayarları
-- Tarih: 2025-01-01
-- ============================================================

INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'brandcolor', '#2ec4b6') ON DUPLICATE KEY UPDATE value = '#2ec4b6';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'navbarcolor', 'dark') ON DUPLICATE KEY UPDATE value = 'dark';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'footercustomcontent', '© 2025 Ayışığı Akademi — Tüm hakları saklıdır.') ON DUPLICATE KEY UPDATE value = '© 2025 Ayışığı Akademi — Tüm hakları saklıdır.';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'additionalhtml', '<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">') ON DUPLICATE KEY UPDATE value = '<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1order', '1') ON DUPLICATE KEY UPDATE value = '1';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1content', '<h1>Ayışığı Akademi''ye Hoş Geldiniz! 🌙✨</h1><p>Ortaokul ve lise öğrencileri için interaktif dersler, sınavlar ve canlı eğitimler</p><a href="/login" class="btn btn-light btn-lg px-4 py-2 fw-bold">Hemen Başla →</a>') ON DUPLICATE KEY UPDATE value = '<h1>Ayışığı Akademi''ye Hoş Geldiniz! 🌙✨</h1><p>Ortaokul ve lise öğrencileri için interaktif dersler, sınavlar ve canlı eğitimler</p><a href="/login" class="btn btn-light btn-lg px-4 py-2 fw-bold">Hemen Başla →</a>';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1link', '/login') ON DUPLICATE KEY UPDATE value = '/login';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1linktitle', 'Hemen Başla') ON DUPLICATE KEY UPDATE value = 'Hemen Başla';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1linksource', 'disabled') ON DUPLICATE KEY UPDATE value = 'disabled';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1interval', '5000') ON DUPLICATE KEY UPDATE value = '5000';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1backgroundimage', 'hero_background.jpg') ON DUPLICATE KEY UPDATE value = 'hero_background.jpg';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'slide1backgroundimagealt', 'Ayışığı Akademi Hero Görseli') ON DUPLICATE KEY UPDATE value = 'Ayışığı Akademi Hero Görseli';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tilecolumns', '3') ON DUPLICATE KEY UPDATE value = '3';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1order', '1') ON DUPLICATE KEY UPDATE value = '1';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1title', '📐 Matematik') ON DUPLICATE KEY UPDATE value = '📐 Matematik';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1link', '/course/index.php?categoryid=2') ON DUPLICATE KEY UPDATE value = '/course/index.php?categoryid=2';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile1linktitle', '📐 Matematik') ON DUPLICATE KEY UPDATE value = '📐 Matematik';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2order', '2') ON DUPLICATE KEY UPDATE value = '2';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2title', '🔬 Fen Bilimleri') ON DUPLICATE KEY UPDATE value = '🔬 Fen Bilimleri';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2link', '/course/index.php?categoryid=3') ON DUPLICATE KEY UPDATE value = '/course/index.php?categoryid=3';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile2linktitle', '🔬 Fen Bilimleri') ON DUPLICATE KEY UPDATE value = '🔬 Fen Bilimleri';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3order', '3') ON DUPLICATE KEY UPDATE value = '3';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3title', '📖 Türkçe') ON DUPLICATE KEY UPDATE value = '📖 Türkçe';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3link', '/course/index.php?categoryid=4') ON DUPLICATE KEY UPDATE value = '/course/index.php?categoryid=4';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile3linktitle', '📖 Türkçe') ON DUPLICATE KEY UPDATE value = '📖 Türkçe';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4order', '4') ON DUPLICATE KEY UPDATE value = '4';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4title', '🌍 Sosyal Bilgiler') ON DUPLICATE KEY UPDATE value = '🌍 Sosyal Bilgiler';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4link', '/course/index.php?categoryid=5') ON DUPLICATE KEY UPDATE value = '/course/index.php?categoryid=5';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile4linktitle', '🌍 Sosyal Bilgiler') ON DUPLICATE KEY UPDATE value = '🌍 Sosyal Bilgiler';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5order', '5') ON DUPLICATE KEY UPDATE value = '5';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5title', '🔤 İngilizce') ON DUPLICATE KEY UPDATE value = '🔤 İngilizce';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5link', '/course/index.php?categoryid=6') ON DUPLICATE KEY UPDATE value = '/course/index.php?categoryid=6';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile5linktitle', '🔤 İngilizce') ON DUPLICATE KEY UPDATE value = '🔤 İngilizce';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6order', '6') ON DUPLICATE KEY UPDATE value = '6';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6title', '📚 Tüm Dersler') ON DUPLICATE KEY UPDATE value = '📚 Tüm Dersler';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6content', '') ON DUPLICATE KEY UPDATE value = '';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6contentstyle', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6link', '/course/index.php') ON DUPLICATE KEY UPDATE value = '/course/index.php';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6linktarget', '_self') ON DUPLICATE KEY UPDATE value = '_self';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'tile6linktitle', '📚 Tüm Dersler') ON DUPLICATE KEY UPDATE value = '📚 Tüm Dersler';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1enabled', 'yes') ON DUPLICATE KEY UPDATE value = 'yes';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1order', '1') ON DUPLICATE KEY UPDATE value = '1';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1content', '<div style="display:flex;justify-content:center;gap:48px;flex-wrap:wrap;padding:8px 0;">
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">500+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Öğrenci</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">50+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Kurs</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">20+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Öğretmen</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">5</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Ders Dalı</span></div>
</div>') ON DUPLICATE KEY UPDATE value = '<div style="display:flex;justify-content:center;gap:48px;flex-wrap:wrap;padding:8px 0;">
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">500+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Öğrenci</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">50+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Kurs</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">20+</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Öğretmen</span></div>
  <div style="text-align:center;"><span style="display:block;font-size:2rem;font-weight:800;color:#2ec4b6;">5</span><span style="font-size:0.9rem;color:#1b3a35;font-weight:600;">Ders Dalı</span></div>
</div>';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1bsclass', 'light') ON DUPLICATE KEY UPDATE value = 'light';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1mode', 'perpetual') ON DUPLICATE KEY UPDATE value = 'perpetual';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1dismissible', 'no') ON DUPLICATE KEY UPDATE value = 'no';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1pages', 'frontpage') ON DUPLICATE KEY UPDATE value = 'frontpage';
INSERT INTO mdl_config_plugins (plugin, name, value) VALUES ('theme_boost_union', 'infobanner1position', 'belownavbar') ON DUPLICATE KEY UPDATE value = 'belownavbar';
INSERT INTO mdl_config (name, value) VALUES ('defaulthomepage', '0') ON DUPLICATE KEY UPDATE value = '0';

-- Migration kaydı
INSERT IGNORE INTO ayisigi_applied_migrations (filename, description)
VALUES ('005_boost_union_settings.sql', 'Boost Union renk/SCSS/slider/tile ayarları uygulandı');
