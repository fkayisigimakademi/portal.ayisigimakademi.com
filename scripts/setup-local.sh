#!/usr/bin/env bash
# ============================================================
# setup-local.sh
# Yerel Docker ortamını ilk kez veya sıfırdan kurar.
# Kullanım: ./scripts/setup-local.sh [--reset]
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
DOCKER_DIR="${ROOT_DIR}/docker"

RESET=false
while [[ $# -gt 0 ]]; do
    case "$1" in
        --reset) RESET=true; shift ;;
        *)       echo "Bilinmeyen argüman: $1"; exit 1 ;;
    esac
done

echo "============================================================"
echo " Ayisigimakademi - Yerel Geliştirme Ortamı Kurulumu"
echo "============================================================"

# --- .env dosyasını kontrol et ---
if [[ ! -f "${ROOT_DIR}/.env" ]]; then
    echo ""
    echo "[!] .env dosyası bulunamadı."
    echo "    .env.example'dan kopyalanıyor..."
    cp "${ROOT_DIR}/.env.example" "${ROOT_DIR}/.env"
    echo ""
    echo "UYARI: ${ROOT_DIR}/.env dosyasını açıp şifreleri değiştirin!"
    echo "       Sonra bu scripti tekrar çalıştırın."
    exit 0
fi

# --- Moodle submodule'ünü başlat ---
echo ""
echo "[1/5] Moodle submodule kontrol ediliyor..."
if [[ ! -f "${ROOT_DIR}/moodle/version.php" ]]; then
    echo "  Moodle dosyaları eksik. Submodule başlatılıyor (internet gerekli)..."
    cd "${ROOT_DIR}"
    git submodule update --init --depth 1
    echo "  Moodle indirildi."
else
    MOODLE_VERSION=$(grep "release" "${ROOT_DIR}/moodle/version.php" | grep -oP "'\K[^']+" | head -1 2>/dev/null || echo "bilinmiyor")
    echo "  Moodle zaten mevcut: ${MOODLE_VERSION}"
fi

# --- Özel temaları Moodle 5.x dizinine bağla ---
# Moodle 5.x: web root public/ altında, temalar public/theme/ içinde
echo ""
echo "[2/5] Özel temalar ve eklentiler bağlanıyor (Moodle 5.x public/ yapısı)..."
for theme_dir in "${ROOT_DIR}/moodle-custom/themes"/*/; do
    [[ -d "${theme_dir}" ]] || continue
    theme_name=$(basename "${theme_dir}")
    target="${ROOT_DIR}/moodle/public/theme/${theme_name}"
    if [[ ! -e "${target}" ]]; then
        ln -sf "${theme_dir}" "${target}"
        echo "  Symlink: public/theme/${theme_name}"
    else
        echo "  Zaten var: public/theme/${theme_name}"
    fi
done

for plugin_dir in "${ROOT_DIR}/moodle-custom/plugins"/*/; do
    [[ -d "${plugin_dir}" ]] || continue
    plugin_name=$(basename "${plugin_dir}")
    target="${ROOT_DIR}/moodle/public/mod/${plugin_name#mod_}"
    if [[ ! -e "${target}" ]]; then
        mkdir -p "$(dirname "${target}")"
        ln -sf "${plugin_dir}" "${target}"
        echo "  Symlink: public/mod/${plugin_name#mod_}"
    else
        echo "  Zaten var: public/mod/${plugin_name#mod_}"
    fi
done

# --- Sıfırlama opsiyonu ---
if [[ "${RESET}" == "true" ]]; then
    echo ""
    echo "[3/5] Docker ortamı sıfırlanıyor (volumes dahil)..."
    cd "${DOCKER_DIR}"
    docker compose down -v 2>/dev/null || true
fi

# --- Docker servislerini başlat ---
echo ""
echo "[3/5] Docker servisleri başlatılıyor..."
cd "${DOCKER_DIR}"
docker compose up -d --build

# --- DB hazır olana kadar bekle ---
echo ""
echo "[4/5] Veritabanının hazır olması bekleniyor..."
ATTEMPTS=0
until docker compose exec -T db mysqladmin ping -h localhost -u root \
    -p"$(grep MYSQL_ROOT_PASSWORD "${ROOT_DIR}/.env" | cut -d= -f2)" --silent 2>/dev/null; do
    ATTEMPTS=$((ATTEMPTS + 1))
    if [[ $ATTEMPTS -gt 30 ]]; then
        echo "HATA: Veritabanı 30 denemede başlamadı."
        exit 1
    fi
    echo "  Bekleniyor... (${ATTEMPTS}/30)"
    sleep 2
done
echo "  Veritabanı hazır."

# --- Migration'ları uygula ---
echo ""
echo "[5/5] Migration'lar uygulanıyor..."
"${ROOT_DIR}/db/apply_migrations.sh" 2>/dev/null || echo "  (Migration tablosu henüz yok - Moodle kurulumundan sonra tekrar çalıştırın)"

echo ""
echo "============================================================"
echo " Kurulum tamamlandı!"
echo ""
echo " Moodle: http://portal.localhost"
echo " phpMyAdmin: http://localhost:8080"
echo ""
echo " Sonraki adım: http://portal.localhost adresini açın ve"
echo " Moodle kurulum sihirbazını tamamlayın."
echo "============================================================"
