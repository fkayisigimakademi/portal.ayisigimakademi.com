#!/usr/bin/env bash
# ============================================================
# moodle-post-install.sh
# Moodle web kurulum sihirbazı tamamlandıktan sonra çalıştırılır.
# Türkçe dil paketi, tema aktivasyonu, temel yapılandırmayı otomatik yapar.
#
# Kullanım: ./scripts/moodle-post-install.sh
# Ön koşul: Docker servisleri çalışıyor ve Moodle kurulumu tamamlanmış olmalı
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
ENV_FILE="${ROOT_DIR}/.env"

if [[ -f "${ENV_FILE}" ]]; then
    set -a; source "${ENV_FILE}"; set +a
fi

DOCKER_CMD="docker compose -f ${ROOT_DIR}/docker/docker-compose.yml exec -T php"
PHP_BIN="php"
# Moodle 5.x: admin CLI repo root'ta
MOODLE_CLI="/var/www/moodle/admin/cli"
MOODLE_PUBLIC="/var/www/html"

echo "============================================================"
echo " Ayisigimakademi - Moodle Kurulum Sonrası Yapılandırma"
echo "============================================================"

# --- 1. Türkçe Dil Paketi ---
echo ""
echo "[1/6] Türkçe dil paketi yükleniyor..."
${DOCKER_CMD} ${PHP_BIN} "${MOODLE_CLI}/langimport.php" --lang=tr 2>/dev/null || \
    echo "  UYARI: langimport başarısız. Site Yönetimi > Dil > Dil Paketleri'nden manuel yükleyin."

# --- 2. Özel tema symlink'lerini oluştur ---
echo ""
echo "[2/6] Tema symlink'leri oluşturuluyor..."
${DOCKER_CMD} bash -c "
for d in /var/www/moodle-custom/themes/*/; do
    name=\$(basename \"\$d\")
    target=\"${MOODLE_PUBLIC}/theme/\$name\"
    if [ ! -e \"\$target\" ]; then
        ln -sf \"\$d\" \"\$target\"
        echo \"  Symlink: theme/\$name\"
    fi
done
" 2>/dev/null || echo "  Symlink oluşturma atlandı (manuel yapın)"

# --- 3. Eklenti symlink'lerini oluştur ---
echo ""
echo "[3/6] Eklenti symlink'leri oluşturuluyor..."
${DOCKER_CMD} bash -c "
for d in /var/www/moodle-custom/plugins/*/; do
    name=\$(basename \"\$d\")
    modname=\${name#mod_}
    target=\"${MOODLE_PUBLIC}/mod/\$modname\"
    if [ ! -e \"\$target\" ]; then
        ln -sf \"\$d\" \"\$target\"
        echo \"  Symlink: mod/\$modname\"
    fi
done
" 2>/dev/null || echo "  Symlink oluşturma atlandı (manuel yapın)"

# --- 4. DB Migration'larını uygula ---
echo ""
echo "[4/6] DB migration'ları uygulanıyor..."
"${ROOT_DIR}/db/apply_migrations.sh" || echo "  Migration'lar atlandı"

# --- 5. Moodle upgrade (yeni tema/eklenti DB kurulumu için) ---
echo ""
echo "[5/6] Moodle DB upgrade çalıştırılıyor (yeni eklentiler için)..."
${DOCKER_CMD} ${PHP_BIN} "${MOODLE_CLI}/upgrade.php" --non-interactive 2>/dev/null || \
    echo "  UYARI: upgrade başarısız. http://portal.localhost/admin/ adresini tarayıcıda açın."

# --- 6. Önbellekleri temizle ---
echo ""
echo "[6/6] Önbellekler temizleniyor..."
${DOCKER_CMD} ${PHP_BIN} "${MOODLE_CLI}/purge_caches.php" 2>/dev/null || \
    echo "  Önbellek temizleme atlandı"

echo ""
echo "============================================================"
echo " Kurulum sonrası yapılandırma tamamlandı!"
echo ""
echo " Kontrol listesi:"
echo " □ http://portal.localhost açın ve admin olarak giriş yapın"
echo " □ Site Yönetimi > Dil > Dil Ayarları > Varsayılan: Türkçe"
echo " □ Site Yönetimi > Görünüm > Temalar > Boost Magnific aktifleştir"
echo " □ Site Yönetimi > Eklentiler > Etkinlik Modülleri > Google Meet kurulumunu onaylayın"
echo " □ Site Yönetimi > Kurslar > Kategorileri Yönet > Kategorileri kontrol edin"
echo " □ Site Yönetimi > Güvenlik > Misafir girişi: Kapalı"
echo " □ Site Yönetimi > Sunucu > E-posta > SMTP ayarlayın"
echo "============================================================"
