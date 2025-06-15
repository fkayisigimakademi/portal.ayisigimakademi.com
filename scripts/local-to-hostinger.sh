#!/usr/bin/env bash
# ============================================================
# local-to-hostinger.sh
# Yerel Docker geliştirme ortamından Hostinger Shared Hosting'e deploy eder.
#
# Ön koşullar:
#   - rsync veya lftp yüklü olmalı
#   - Hostinger FTP bilgileri .env.production dosyasında tanımlı olmalı
#   - Moodle dosyaları yerelde hazır olmalı
#
# Kullanım:
#   ./scripts/local-to-hostinger.sh [--dry-run] [--skip-db] [--files-only]
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."

DRY_RUN=false
SKIP_DB=false
FILES_ONLY=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)    DRY_RUN=true; shift ;;
        --skip-db)    SKIP_DB=true; shift ;;
        --files-only) FILES_ONLY=true; SKIP_DB=true; shift ;;
        *)            echo "Bilinmeyen argüman: $1"; exit 1 ;;
    esac
done

# Üretim ortam değişkenlerini yükle
PROD_ENV="${ROOT_DIR}/.env.production"
if [[ ! -f "${PROD_ENV}" ]]; then
    echo "HATA: .env.production dosyası bulunamadı."
    echo "      .env.production.example dosyasını kopyalayın ve doldurun."
    exit 1
fi
set -a; source "${PROD_ENV}"; set +a

# Zorunlu değişkenleri kontrol et
: "${FTP_HOST:?FTP_HOST .env.production dosyasında tanımlı olmalı}"
: "${FTP_USER:?FTP_USER tanımlı olmalı}"
: "${FTP_PASS:?FTP_PASS tanımlı olmalı}"
: "${FTP_REMOTE_PATH:?FTP_REMOTE_PATH tanımlı olmalı}"

echo "============================================================"
echo " Ayisigimakademi - Hostinger Deploy"
echo " Hedef: ${FTP_HOST}:${FTP_REMOTE_PATH}"
echo " Dry-run: ${DRY_RUN} | DB Atla: ${SKIP_DB}"
echo "============================================================"

# --- Adım 1: DB Dışa Aktar ---
if [[ "${SKIP_DB}" == "false" ]]; then
    echo ""
    echo "[1/4] Veritabanı dışa aktarılıyor..."
    if [[ "${DRY_RUN}" == "false" ]]; then
        "${SCRIPT_DIR}/db-export.sh" --full
    else
        echo "  [DRY-RUN] Atlandı"
    fi
fi

# --- Adım 2: Özel temaları ve eklentileri kopyala ---
echo ""
echo "[2/4] Özel tema ve eklentiler Moodle dizinine kopyalanıyor..."
if [[ "${DRY_RUN}" == "false" ]]; then
    # Temalar (Moodle 5.x: public/theme/ altında)
    for theme_dir in "${ROOT_DIR}/moodle-custom/themes"/*/; do
        theme_name=$(basename "${theme_dir}")
        target="${ROOT_DIR}/moodle/public/theme/${theme_name}"
        echo "  Tema: ${theme_name} → ${target}"
        rsync -a --delete "${theme_dir}/" "${target}/"
    done

    # Eklentiler (Moodle 5.x: public/mod/ altında)
    for plugin_dir in "${ROOT_DIR}/moodle-custom/plugins"/*/; do
        plugin_name=$(basename "${plugin_dir}")
        target="${ROOT_DIR}/moodle/public/mod/${plugin_name#mod_}"
        echo "  Eklenti: ${plugin_name} → ${target}"
        mkdir -p "${target}"
        rsync -a --delete "${plugin_dir}/" "${target}/"
    done
else
    echo "  [DRY-RUN] Atlandı"
fi

# --- Adım 3: Dosyaları FTP ile yükle ---
echo ""
echo "[3/4] Dosyalar Hostinger'a yükleniyor..."

EXCLUDE_LIST=(
    "moodledata/"
    "config.php"
    ".git/"
    ".env"
    "*.log"
    "cache/"
    "localcache/"
    "temp/"
    "sessions/"
)

EXCLUDE_OPTS=""
for excl in "${EXCLUDE_LIST[@]}"; do
    EXCLUDE_OPTS="${EXCLUDE_OPTS} --exclude=${excl}"
done

if [[ "${DRY_RUN}" == "false" ]]; then
    # lftp ile FTP yükleme
    # Moodle 5.x: public/ web root olarak ayrı yüklenir
    # Hostinger: public_html/portal/ → moodle/public/ içeriğini alır
    lftp -u "${FTP_USER},${FTP_PASS}" "${FTP_HOST}" <<EOF
set ssl:verify-certificate no
mirror --reverse --delete --verbose \
    ${EXCLUDE_OPTS} \
    "${ROOT_DIR}/moodle/public/" \
    "${FTP_REMOTE_PATH}/"
bye
EOF
else
    echo "  [DRY-RUN] lftp mirror komutu atlandı"
fi

# --- Adım 4: config.php üretim için oluştur ve yükle ---
echo ""
echo "[4/4] Üretim config.php oluşturuluyor ve yükleniyor..."

PROD_CONFIG="${ROOT_DIR}/config/config.production.php"
if [[ ! -f "${PROD_CONFIG}" ]]; then
    echo "HATA: ${PROD_CONFIG} bulunamadı."
    echo "      config/config.php.example'dan kopyalayıp üretim değerlerini doldurun."
    exit 1
fi

if [[ "${DRY_RUN}" == "false" ]]; then
    # Moodle 5.x: config.php repo root'ta yüklenir (public/ bir üst dizin)
    # Hostinger'da bu genellikle public_html/portal/../config.php → public_html/config.php
    # veya hosting planına göre ayarlanır. Şimdilik FTP_REMOTE_PATH üstüne yükle:
    REMOTE_CONFIG_PATH="${FTP_REMOTE_PATH%/*}/config.php"
    lftp -u "${FTP_USER},${FTP_PASS}" "${FTP_HOST}" <<EOF
set ssl:verify-certificate no
put "${PROD_CONFIG}" -o "${REMOTE_CONFIG_PATH}"
bye
EOF
    echo "  config.php yüklendi: ${REMOTE_CONFIG_PATH}"
else
    echo "  [DRY-RUN] config.php yükleme atlandı"
fi

echo ""
echo "============================================================"
echo " Deploy tamamlandı!"
echo ""
echo " Sonraki adımlar:"
echo " 1. Hostinger hPanel > phpMyAdmin'den DB import edin:"
echo "    db/schema_dump.sql dosyasını içe aktarın"
echo " 2. Moodle upgrade kontrolü:"
echo "    https://portal.ayisigimakademi.com/admin/index.php"
echo " 3. Cron job aktif edin (hPanel > Cron Jobs):"
echo "    */5 * * * * php ${FTP_REMOTE_PATH}/admin/cli/cron.php"
echo "============================================================"
