<?php
/**
 * Ayışığı Akademi - Anasayfa HTML Bloklarını Ekle
 *
 * Bu script Moodle ön sayfasına Hero Banner, Kategori Vitrin ve
 * İstatistik Sayacı HTML bloklarını ekler.
 *
 * Kullanım:
 *   docker exec ayisigimakademi_moodle php /var/www/moodle/scripts/add_frontpage_blocks.php
 *
 * Script idempotent'tir — tekrar çalıştırıldığında mevcut
 * site-index HTML bloklarını silip yeniden oluşturur.
 */

define('CLI_SCRIPT', true);
require('/var/www/moodle/config.php');

$syscontext = context_system::instance();

// Mevcut site-index HTML bloklarını temizle
$existing = $DB->get_records_select('block_instances',
    "blockname = 'html' AND pagetypepattern = 'site-index'");
foreach ($existing as $b) {
    $DB->delete_records('block_positions', ['blockinstanceid' => $b->id]);
    context_helper::delete_instance(CONTEXT_BLOCK, $b->id);
    $DB->delete_records('block_instances', ['id' => $b->id]);
    echo "Eski blok silindi: $b->id\n";
}

/**
 * HTML bloğu oluştur.
 */
function create_html_block(moodle_database $DB, context $ctx, string $title, string $html, int $weight): int {
    $config           = new stdClass();
    $config->title    = $title;
    $config->text     = $html;
    $config->format   = '1'; // FORMAT_HTML

    $bi                       = new stdClass();
    $bi->blockname            = 'html';
    $bi->parentcontextid      = $ctx->id;
    $bi->showinsubcontexts    = 0;
    $bi->requiredbytheme      = 0;
    $bi->pagetypepattern      = 'site-index';
    $bi->subpagepattern       = null;
    $bi->defaultregion        = 'content';
    $bi->defaultweight        = $weight;
    $bi->timecreated          = time();
    $bi->timemodified         = time();
    $bi->configdata           = base64_encode(serialize($config));

    $id = $DB->insert_record('block_instances', $bi);
    echo "Blok oluşturuldu: '$title' (id=$id, weight=$weight)\n";
    return $id;
}

// -----------------------------------------------------------------------
// Blok 1: Hero Banner
// -----------------------------------------------------------------------
$hero_html = <<<HTML
<section class="ayk-hero">
  <div class="container">
    <h1>Ayışığı Akademi'ye Hoş Geldiniz! 🌙✨</h1>
    <p>Ortaokul ve lise öğrencileri için interaktif dersler, sınavlar ve canlı eğitimler</p>
    <a href="/login" class="ayk-hero-btn">Hemen Başla →</a>
  </div>
</section>
HTML;

// -----------------------------------------------------------------------
// Blok 2: Kategori Vitrin
// -----------------------------------------------------------------------
$categories_html = <<<HTML
<section class="ayk-categories">
  <div class="container">
    <h2>Derslerimiz</h2>
    <div class="ayk-category-grid">
      <a href="/course/index.php?categoryid=2" class="ayk-category-card">
        <span class="ayk-cat-icon">📐</span>
        <span class="ayk-cat-name">Matematik</span>
      </a>
      <a href="/course/index.php?categoryid=3" class="ayk-category-card">
        <span class="ayk-cat-icon">🔬</span>
        <span class="ayk-cat-name">Fen Bilimleri</span>
      </a>
      <a href="/course/index.php?categoryid=4" class="ayk-category-card">
        <span class="ayk-cat-icon">📖</span>
        <span class="ayk-cat-name">Türkçe</span>
      </a>
      <a href="/course/index.php?categoryid=5" class="ayk-category-card">
        <span class="ayk-cat-icon">🌍</span>
        <span class="ayk-cat-name">Sosyal Bilgiler</span>
      </a>
      <a href="/course/index.php?categoryid=6" class="ayk-category-card">
        <span class="ayk-cat-icon">🔤</span>
        <span class="ayk-cat-name">İngilizce</span>
      </a>
      <a href="/course/index.php" class="ayk-category-card" style="border-top-color:#52b788;">
        <span class="ayk-cat-icon">📚</span>
        <span class="ayk-cat-name">Tüm Dersler</span>
      </a>
    </div>
  </div>
</section>
HTML;

// -----------------------------------------------------------------------
// Blok 3: İstatistik Sayacı
// -----------------------------------------------------------------------
$stats_html = <<<HTML
<div class="container">
  <div class="ayk-stats">
    <div class="ayk-stat-item">
      <span class="ayk-stat-number">500+</span>
      <span class="ayk-stat-label">Öğrenci</span>
    </div>
    <div class="ayk-stat-item">
      <span class="ayk-stat-number">50+</span>
      <span class="ayk-stat-label">Kurs</span>
    </div>
    <div class="ayk-stat-item">
      <span class="ayk-stat-number">20+</span>
      <span class="ayk-stat-label">Öğretmen</span>
    </div>
    <div class="ayk-stat-item">
      <span class="ayk-stat-number">5</span>
      <span class="ayk-stat-label">Ders Dalı</span>
    </div>
  </div>
</div>
HTML;

create_html_block($DB, $syscontext, '', $hero_html, 0);
create_html_block($DB, $syscontext, '', $categories_html, 1);
create_html_block($DB, $syscontext, '', $stats_html, 2);

// Ön sayfa ayarları
$DB->set_field_select('config', 'value', '', "name = 'frontpage'");
$DB->set_field_select('config', 'value', '', "name = 'frontpageloggedin'");

purge_all_caches();
echo "Tamamlandı! Tüm cache'ler temizlendi.\n";
