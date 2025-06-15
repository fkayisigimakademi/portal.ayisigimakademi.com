-- ============================================================
-- Migration: 005b - Boost Union Özel SCSS
-- Not: SCSS uzun olduğu için ayrı dosyaya alındı.
-- ============================================================

INSERT INTO mdl_config_plugins (plugin, name, value)
VALUES ('theme_boost_union', 'scss', '// ============================================================
// Ayışığı Akademi - Boost Union Özel SCSS
// Renk Paleti: Yeşil + Turkuaz
//   Primary:    #2ec4b6 (turkuaz)
//   Secondary:  #52b788 (yumuşak yeşil)
//   Accent:     #1a936f (koyu yeşil)
//   Background: #f0faf8 (açık mint)
//   Text:       #1b3a35 (koyu yeşil siyah)
//
// Bu dosyayı Boost Union → Appearance → Extra SCSS alanına yapıştırın.
// Kaynak: moodle-custom/scss/boost_union_custom.scss (git''te takip edilir)
// ============================================================

// -----------------------------------------------------------------------
// Google Font: Nunito
// Not: @import URL SCSS derleyicide çalışmaz.
// Nunito fontu Boost Union "Additional HTML in HEAD" ayarına şu link ile eklendi:
// <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
// -----------------------------------------------------------------------

body,
.navbar,
h1, h2, h3, h4, h5, h6,
.btn,
input, select, textarea {
    font-family: ''Nunito'', -apple-system, BlinkMacSystemFont, ''Segoe UI'', sans-serif !important;
}

// -----------------------------------------------------------------------
// Genel Arka Plan & Metin
// -----------------------------------------------------------------------
body {
    background-color: #f0faf8;
    color: #1b3a35;
}

// -----------------------------------------------------------------------
// Navigasyon Çubuğu
// -----------------------------------------------------------------------
.navbar {
    background: linear-gradient(90deg, #1a936f 0%, #2ec4b6 100%) !important;
    box-shadow: 0 2px 12px rgba(26, 147, 111, 0.25);
}

.navbar .nav-link,
.navbar .navbar-brand,
.navbar .usermenu .dropdown-toggle {
    color: rgba(255, 255, 255, 0.95) !important;
    font-weight: 600;
}

.navbar .nav-link:hover,
.navbar .navbar-brand:hover {
    color: #ffffff !important;
    opacity: 0.85;
}

// -----------------------------------------------------------------------
// Butonlar
// -----------------------------------------------------------------------
.btn-primary {
    background: #2ec4b6 !important;
    border-color: #2ec4b6 !important;
    border-radius: 10px;
    font-weight: 700;
    letter-spacing: 0.3px;
    transition: all 0.2s ease;
}

.btn-primary:hover,
.btn-primary:focus {
    background: #1a936f !important;
    border-color: #1a936f !important;
    box-shadow: 0 4px 16px rgba(46, 196, 182, 0.35) !important;
    transform: translateY(-1px);
}

.btn-secondary {
    border-radius: 10px;
    font-weight: 600;
}

// -----------------------------------------------------------------------
// Linkler
// -----------------------------------------------------------------------
a {
    color: #1a936f;
}
a:hover {
    color: #2ec4b6;
    text-decoration: none;
}

// -----------------------------------------------------------------------
// Hero Banner (Anasayfa)
// -----------------------------------------------------------------------
.ayk-hero {
    background: linear-gradient(135deg, #1a936f 0%, #2ec4b6 60%, #52b788 100%);
    padding: 72px 0 80px;
    text-align: center;
    color: white;
    border-radius: 0 0 48px 48px;
    margin-bottom: 48px;
    position: relative;
    overflow: hidden;
}

.ayk-hero::before {
    content: '''';
    position: absolute;
    top: -60px; right: -60px;
    width: 300px; height: 300px;
    background: rgba(255,255,255,0.07);
    border-radius: 50%;
}

.ayk-hero::after {
    content: '''';
    position: absolute;
    bottom: -80px; left: -40px;
    width: 250px; height: 250px;
    background: rgba(255,255,255,0.05);
    border-radius: 50%;
}

.ayk-hero h1 {
    font-size: 2.8rem;
    font-weight: 800;
    margin-bottom: 16px;
    text-shadow: 0 2px 8px rgba(0,0,0,0.1);
    position: relative;
    z-index: 1;
}

.ayk-hero p {
    font-size: 1.2rem;
    opacity: 0.92;
    margin-bottom: 32px;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    z-index: 1;
}

.ayk-hero-btn {
    display: inline-block;
    background: white;
    color: #1a936f !important;
    padding: 14px 40px;
    border-radius: 50px;
    font-weight: 800;
    font-size: 1.05rem;
    text-decoration: none !important;
    box-shadow: 0 6px 24px rgba(0,0,0,0.15);
    transition: all 0.25s ease;
    position: relative;
    z-index: 1;
}

.ayk-hero-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 32px rgba(0,0,0,0.2);
    color: #1a936f !important;
}

// -----------------------------------------------------------------------
// Kategori Kartları (Anasayfa Vitrin)
// -----------------------------------------------------------------------
.ayk-categories {
    padding: 0 0 48px;
}

.ayk-categories h2 {
    text-align: center;
    font-weight: 800;
    color: #1b3a35;
    margin-bottom: 32px;
    font-size: 1.8rem;
}

.ayk-category-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap: 20px;
    max-width: 900px;
    margin: 0 auto;
}

.ayk-category-card {
    background: white;
    border-radius: 18px;
    padding: 28px 16px 24px;
    text-align: center;
    box-shadow: 0 2px 16px rgba(46, 196, 182, 0.10);
    transition: transform 0.22s ease, box-shadow 0.22s ease;
    border-top: 4px solid #2ec4b6;
    text-decoration: none !important;
    display: block;
    color: #1b3a35 !important;
}

.ayk-category-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 30px rgba(46, 196, 182, 0.22);
    color: #1a936f !important;
}

.ayk-category-card .ayk-cat-icon {
    font-size: 2.4rem;
    margin-bottom: 10px;
    display: block;
}

.ayk-category-card .ayk-cat-name {
    font-weight: 700;
    font-size: 0.95rem;
}

// -----------------------------------------------------------------------
// İstatistik Sayacı (Anasayfa)
// -----------------------------------------------------------------------
.ayk-stats {
    background: white;
    border-radius: 20px;
    box-shadow: 0 2px 20px rgba(46, 196, 182, 0.10);
    padding: 36px 24px;
    margin-bottom: 48px;
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 24px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
}

.ayk-stat-item {
    text-align: center;
}

.ayk-stat-item .ayk-stat-number {
    display: block;
    font-size: 2.2rem;
    font-weight: 800;
    color: #2ec4b6;
    line-height: 1;
}

.ayk-stat-item .ayk-stat-label {
    font-size: 0.9rem;
    color: #5a7a74;
    font-weight: 600;
    margin-top: 4px;
}

// -----------------------------------------------------------------------
// Kurs Kartları (Moodle course listings)
// -----------------------------------------------------------------------
.coursebox,
.course-card,
[data-region="course-content"] {
    border-radius: 16px !important;
    border: none !important;
    box-shadow: 0 2px 14px rgba(0, 0, 0, 0.07) !important;
    transition: transform 0.22s ease, box-shadow 0.22s ease !important;
    overflow: hidden;
}

.coursebox:hover,
.course-card:hover {
    transform: translateY(-4px) !important;
    box-shadow: 0 8px 28px rgba(46, 196, 182, 0.18) !important;
}

.coursebox .coursename a,
.course-card .coursename a {
    font-weight: 700;
    color: #1b3a35;
}

.coursebox .coursename a:hover {
    color: #1a936f;
}

// -----------------------------------------------------------------------
// Giriş Sayfası
// -----------------------------------------------------------------------
#page-login-index #page-wrapper {
    background-size: cover;
    background-position: center;
}

#page-login-index #region-main-box,
#page-login-index .loginbox {
    background: rgba(255, 255, 255, 0.93);
    border-radius: 24px !important;
    box-shadow: 0 24px 64px rgba(0, 0, 0, 0.18) !important;
    border: none !important;
    padding: 20px !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    max-width: 420px;
    margin: 40px auto;
}

#page-login-index .card {
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
}

#page-login-index h2,
#page-login-index .login-heading {
    color: #1a936f;
    font-weight: 800;
    text-align: center;
    margin-bottom: 20px;
}

#page-login-index .btn-primary {
    background: linear-gradient(90deg, #1a936f, #2ec4b6) !important;
    border: none !important;
    border-radius: 50px !important;
    padding: 12px 24px !important;
    font-weight: 700 !important;
    font-size: 1rem;
    width: 100%;
    margin-top: 8px;
    letter-spacing: 0.3px;
}

#page-login-index .form-control {
    border-radius: 10px;
    border: 1.5px solid #c8e6e2;
    padding: 10px 14px;
    font-size: 0.95rem;
}

#page-login-index .form-control:focus {
    border-color: #2ec4b6;
    box-shadow: 0 0 0 3px rgba(46, 196, 182, 0.15);
}

// -----------------------------------------------------------------------
// Kurs İçi Sayfa
// -----------------------------------------------------------------------
#page-course-view-topics .section .sectionname {
    color: #1a936f;
    font-weight: 700;
    border-left: 4px solid #2ec4b6;
    padding-left: 12px;
}

.activity .activitytitle .instancename {
    font-weight: 600;
    color: #1b3a35;
}

.activity:hover .activitytitle .instancename {
    color: #1a936f;
}

// -----------------------------------------------------------------------
// Quiz & Sınav Sayfaları
// -----------------------------------------------------------------------
.que {
    background: white;
    border-radius: 14px;
    border: 1px solid #d4f0eb;
    padding: 24px;
    margin-bottom: 16px;
    box-shadow: 0 1px 8px rgba(46, 196, 182, 0.06);
}

.que .qno {
    background: #2ec4b6;
    color: white;
    border-radius: 8px;
    padding: 4px 10px;
    font-weight: 700;
    font-size: 0.85rem;
}

// -----------------------------------------------------------------------
// Bildirimler / Alert kutucukları
// -----------------------------------------------------------------------
.alert-info {
    background: #e8f7f5;
    border-color: #2ec4b6;
    color: #1b3a35;
    border-radius: 12px;
}

.alert-success {
    background: #edfaf3;
    border-color: #52b788;
    color: #1b3a35;
    border-radius: 12px;
}

// -----------------------------------------------------------------------
// Footer
// -----------------------------------------------------------------------
#page-footer {
    background: #1b3a35;
    color: rgba(255, 255, 255, 0.75);
    padding: 20px 0;
    font-size: 0.875rem;
    margin-top: 48px;
}

#page-footer a {
    color: rgba(255, 255, 255, 0.85);
}

#page-footer a:hover {
    color: #2ec4b6;
}

// -----------------------------------------------------------------------
// Mobil Uyumluluk
// -----------------------------------------------------------------------
@media (max-width: 768px) {
    .ayk-hero h1 { font-size: 1.9rem; }
    .ayk-hero p  { font-size: 1rem; }
    .ayk-category-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
    .ayk-stats { padding: 24px 16px; }
    .ayk-stat-item .ayk-stat-number { font-size: 1.7rem; }
}
')
ON DUPLICATE KEY UPDATE value = '// ============================================================
// Ayışığı Akademi - Boost Union Özel SCSS
// Renk Paleti: Yeşil + Turkuaz
//   Primary:    #2ec4b6 (turkuaz)
//   Secondary:  #52b788 (yumuşak yeşil)
//   Accent:     #1a936f (koyu yeşil)
//   Background: #f0faf8 (açık mint)
//   Text:       #1b3a35 (koyu yeşil siyah)
//
// Bu dosyayı Boost Union → Appearance → Extra SCSS alanına yapıştırın.
// Kaynak: moodle-custom/scss/boost_union_custom.scss (git''te takip edilir)
// ============================================================

// -----------------------------------------------------------------------
// Google Font: Nunito
// Not: @import URL SCSS derleyicide çalışmaz.
// Nunito fontu Boost Union "Additional HTML in HEAD" ayarına şu link ile eklendi:
// <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
// -----------------------------------------------------------------------

body,
.navbar,
h1, h2, h3, h4, h5, h6,
.btn,
input, select, textarea {
    font-family: ''Nunito'', -apple-system, BlinkMacSystemFont, ''Segoe UI'', sans-serif !important;
}

// -----------------------------------------------------------------------
// Genel Arka Plan & Metin
// -----------------------------------------------------------------------
body {
    background-color: #f0faf8;
    color: #1b3a35;
}

// -----------------------------------------------------------------------
// Navigasyon Çubuğu
// -----------------------------------------------------------------------
.navbar {
    background: linear-gradient(90deg, #1a936f 0%, #2ec4b6 100%) !important;
    box-shadow: 0 2px 12px rgba(26, 147, 111, 0.25);
}

.navbar .nav-link,
.navbar .navbar-brand,
.navbar .usermenu .dropdown-toggle {
    color: rgba(255, 255, 255, 0.95) !important;
    font-weight: 600;
}

.navbar .nav-link:hover,
.navbar .navbar-brand:hover {
    color: #ffffff !important;
    opacity: 0.85;
}

// -----------------------------------------------------------------------
// Butonlar
// -----------------------------------------------------------------------
.btn-primary {
    background: #2ec4b6 !important;
    border-color: #2ec4b6 !important;
    border-radius: 10px;
    font-weight: 700;
    letter-spacing: 0.3px;
    transition: all 0.2s ease;
}

.btn-primary:hover,
.btn-primary:focus {
    background: #1a936f !important;
    border-color: #1a936f !important;
    box-shadow: 0 4px 16px rgba(46, 196, 182, 0.35) !important;
    transform: translateY(-1px);
}

.btn-secondary {
    border-radius: 10px;
    font-weight: 600;
}

// -----------------------------------------------------------------------
// Linkler
// -----------------------------------------------------------------------
a {
    color: #1a936f;
}
a:hover {
    color: #2ec4b6;
    text-decoration: none;
}

// -----------------------------------------------------------------------
// Hero Banner (Anasayfa)
// -----------------------------------------------------------------------
.ayk-hero {
    background: linear-gradient(135deg, #1a936f 0%, #2ec4b6 60%, #52b788 100%);
    padding: 72px 0 80px;
    text-align: center;
    color: white;
    border-radius: 0 0 48px 48px;
    margin-bottom: 48px;
    position: relative;
    overflow: hidden;
}

.ayk-hero::before {
    content: '''';
    position: absolute;
    top: -60px; right: -60px;
    width: 300px; height: 300px;
    background: rgba(255,255,255,0.07);
    border-radius: 50%;
}

.ayk-hero::after {
    content: '''';
    position: absolute;
    bottom: -80px; left: -40px;
    width: 250px; height: 250px;
    background: rgba(255,255,255,0.05);
    border-radius: 50%;
}

.ayk-hero h1 {
    font-size: 2.8rem;
    font-weight: 800;
    margin-bottom: 16px;
    text-shadow: 0 2px 8px rgba(0,0,0,0.1);
    position: relative;
    z-index: 1;
}

.ayk-hero p {
    font-size: 1.2rem;
    opacity: 0.92;
    margin-bottom: 32px;
    max-width: 600px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
    z-index: 1;
}

.ayk-hero-btn {
    display: inline-block;
    background: white;
    color: #1a936f !important;
    padding: 14px 40px;
    border-radius: 50px;
    font-weight: 800;
    font-size: 1.05rem;
    text-decoration: none !important;
    box-shadow: 0 6px 24px rgba(0,0,0,0.15);
    transition: all 0.25s ease;
    position: relative;
    z-index: 1;
}

.ayk-hero-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 32px rgba(0,0,0,0.2);
    color: #1a936f !important;
}

// -----------------------------------------------------------------------
// Kategori Kartları (Anasayfa Vitrin)
// -----------------------------------------------------------------------
.ayk-categories {
    padding: 0 0 48px;
}

.ayk-categories h2 {
    text-align: center;
    font-weight: 800;
    color: #1b3a35;
    margin-bottom: 32px;
    font-size: 1.8rem;
}

.ayk-category-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap: 20px;
    max-width: 900px;
    margin: 0 auto;
}

.ayk-category-card {
    background: white;
    border-radius: 18px;
    padding: 28px 16px 24px;
    text-align: center;
    box-shadow: 0 2px 16px rgba(46, 196, 182, 0.10);
    transition: transform 0.22s ease, box-shadow 0.22s ease;
    border-top: 4px solid #2ec4b6;
    text-decoration: none !important;
    display: block;
    color: #1b3a35 !important;
}

.ayk-category-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 30px rgba(46, 196, 182, 0.22);
    color: #1a936f !important;
}

.ayk-category-card .ayk-cat-icon {
    font-size: 2.4rem;
    margin-bottom: 10px;
    display: block;
}

.ayk-category-card .ayk-cat-name {
    font-weight: 700;
    font-size: 0.95rem;
}

// -----------------------------------------------------------------------
// İstatistik Sayacı (Anasayfa)
// -----------------------------------------------------------------------
.ayk-stats {
    background: white;
    border-radius: 20px;
    box-shadow: 0 2px 20px rgba(46, 196, 182, 0.10);
    padding: 36px 24px;
    margin-bottom: 48px;
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 24px;
    max-width: 700px;
    margin-left: auto;
    margin-right: auto;
}

.ayk-stat-item {
    text-align: center;
}

.ayk-stat-item .ayk-stat-number {
    display: block;
    font-size: 2.2rem;
    font-weight: 800;
    color: #2ec4b6;
    line-height: 1;
}

.ayk-stat-item .ayk-stat-label {
    font-size: 0.9rem;
    color: #5a7a74;
    font-weight: 600;
    margin-top: 4px;
}

// -----------------------------------------------------------------------
// Kurs Kartları (Moodle course listings)
// -----------------------------------------------------------------------
.coursebox,
.course-card,
[data-region="course-content"] {
    border-radius: 16px !important;
    border: none !important;
    box-shadow: 0 2px 14px rgba(0, 0, 0, 0.07) !important;
    transition: transform 0.22s ease, box-shadow 0.22s ease !important;
    overflow: hidden;
}

.coursebox:hover,
.course-card:hover {
    transform: translateY(-4px) !important;
    box-shadow: 0 8px 28px rgba(46, 196, 182, 0.18) !important;
}

.coursebox .coursename a,
.course-card .coursename a {
    font-weight: 700;
    color: #1b3a35;
}

.coursebox .coursename a:hover {
    color: #1a936f;
}

// -----------------------------------------------------------------------
// Giriş Sayfası
// -----------------------------------------------------------------------
#page-login-index #page-wrapper {
    background-size: cover;
    background-position: center;
}

#page-login-index #region-main-box,
#page-login-index .loginbox {
    background: rgba(255, 255, 255, 0.93);
    border-radius: 24px !important;
    box-shadow: 0 24px 64px rgba(0, 0, 0, 0.18) !important;
    border: none !important;
    padding: 20px !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    max-width: 420px;
    margin: 40px auto;
}

#page-login-index .card {
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
}

#page-login-index h2,
#page-login-index .login-heading {
    color: #1a936f;
    font-weight: 800;
    text-align: center;
    margin-bottom: 20px;
}

#page-login-index .btn-primary {
    background: linear-gradient(90deg, #1a936f, #2ec4b6) !important;
    border: none !important;
    border-radius: 50px !important;
    padding: 12px 24px !important;
    font-weight: 700 !important;
    font-size: 1rem;
    width: 100%;
    margin-top: 8px;
    letter-spacing: 0.3px;
}

#page-login-index .form-control {
    border-radius: 10px;
    border: 1.5px solid #c8e6e2;
    padding: 10px 14px;
    font-size: 0.95rem;
}

#page-login-index .form-control:focus {
    border-color: #2ec4b6;
    box-shadow: 0 0 0 3px rgba(46, 196, 182, 0.15);
}

// -----------------------------------------------------------------------
// Kurs İçi Sayfa
// -----------------------------------------------------------------------
#page-course-view-topics .section .sectionname {
    color: #1a936f;
    font-weight: 700;
    border-left: 4px solid #2ec4b6;
    padding-left: 12px;
}

.activity .activitytitle .instancename {
    font-weight: 600;
    color: #1b3a35;
}

.activity:hover .activitytitle .instancename {
    color: #1a936f;
}

// -----------------------------------------------------------------------
// Quiz & Sınav Sayfaları
// -----------------------------------------------------------------------
.que {
    background: white;
    border-radius: 14px;
    border: 1px solid #d4f0eb;
    padding: 24px;
    margin-bottom: 16px;
    box-shadow: 0 1px 8px rgba(46, 196, 182, 0.06);
}

.que .qno {
    background: #2ec4b6;
    color: white;
    border-radius: 8px;
    padding: 4px 10px;
    font-weight: 700;
    font-size: 0.85rem;
}

// -----------------------------------------------------------------------
// Bildirimler / Alert kutucukları
// -----------------------------------------------------------------------
.alert-info {
    background: #e8f7f5;
    border-color: #2ec4b6;
    color: #1b3a35;
    border-radius: 12px;
}

.alert-success {
    background: #edfaf3;
    border-color: #52b788;
    color: #1b3a35;
    border-radius: 12px;
}

// -----------------------------------------------------------------------
// Footer
// -----------------------------------------------------------------------
#page-footer {
    background: #1b3a35;
    color: rgba(255, 255, 255, 0.75);
    padding: 20px 0;
    font-size: 0.875rem;
    margin-top: 48px;
}

#page-footer a {
    color: rgba(255, 255, 255, 0.85);
}

#page-footer a:hover {
    color: #2ec4b6;
}

// -----------------------------------------------------------------------
// Mobil Uyumluluk
// -----------------------------------------------------------------------
@media (max-width: 768px) {
    .ayk-hero h1 { font-size: 1.9rem; }
    .ayk-hero p  { font-size: 1rem; }
    .ayk-category-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
    .ayk-stats { padding: 24px 16px; }
    .ayk-stat-item .ayk-stat-number { font-size: 1.7rem; }
}
';
