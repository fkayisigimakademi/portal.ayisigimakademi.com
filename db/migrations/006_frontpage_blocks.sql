-- ============================================================
-- Migration: 006 - Anasayfa HTML Blokları
-- Açıklama: Ayışığı Akademi anasayfası için Hero, Kategori Vitrin ve
--           İstatistik Sayacı HTML bloklarını ekler.
-- Not: Bu script idempotent'tir (site-index HTML blokları önce silinir).
-- Tarih: 2025-01-01
-- ============================================================

-- Mevcut site-index HTML bloklarını temizle (idempotent)
DELETE FROM mdl_block_positions
WHERE blockinstanceid IN (
    SELECT id FROM mdl_block_instances
    WHERE blockname = 'html' AND pagetypepattern = 'site-index'
);

DELETE FROM mdl_block_instances
WHERE blockname = 'html' AND pagetypepattern = 'site-index';

-- defaulthomepage: 0 = Site ön sayfası (misafirler için hero gösterilir)
INSERT INTO mdl_config (name, value)
VALUES ('defaulthomepage', '0')
ON DUPLICATE KEY UPDATE value = '0';

-- -----------------------------------------------------------------------
-- Blok 1: Hero Banner (weight=0)
-- configdata: base64(serialize({title:'',text:'<html>',format:'1'}))
-- -----------------------------------------------------------------------
-- NOT: configdata PHP serialize + base64 formatındadır.
-- Aşağıdaki değerler PHP ile üretilmiş olup doğrudan insert edilebilir.
-- Güncel değerleri üretmek için: scripts/generate_block_configdata.php
-- -----------------------------------------------------------------------

-- Blok kayıtları PHP CLI ile eklenir (aşağıdaki adım):
-- docker exec ayisigimakademi_moodle php /tmp/add_frontpage_blocks.php
-- Bu dosya scripts/add_frontpage_blocks.php konumundadır.

-- -----------------------------------------------------------------------
-- Ön Sayfa Ayarları
-- -----------------------------------------------------------------------
UPDATE mdl_config SET value = '' WHERE name = 'frontpage';
UPDATE mdl_config SET value = '' WHERE name = 'frontpageloggedin';

-- Migration kaydı
INSERT IGNORE INTO ayisigi_applied_migrations (filename, description)
VALUES ('006_frontpage_blocks.sql', 'Anasayfa Hero, Kategori ve İstatistik blokları eklendi');
