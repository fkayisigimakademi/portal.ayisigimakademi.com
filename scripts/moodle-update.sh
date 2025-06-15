#!/usr/bin/env bash
# ============================================================
# moodle-update.sh
# Moodle core'u git submodule üzerinden günceller.
# Tema ve eklenti uyumluluğunu kontrol eder.
#
# Kullanım: ./scripts/moodle-update.sh [--tag v5.1.4] [--dry-run]
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
# Moodle 5.x: repo root, web root public/ altında
MOODLE_DIR="${ROOT_DIR}/moodle"
MOODLE_PUBLIC="${ROOT_DIR}/moodle/public"

TARGET_TAG=""
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --tag)     TARGET_TAG="$2"; shift 2 ;;
        --dry-run) DRY_RUN=true; shift ;;
        *)         echo "Bilinmeyen argüman: $1"; exit 1 ;;
    esac
done

echo "============================================================"
echo " Moodle Güncelleme Aracı"
echo "============================================================"

# Mevcut sürümü göster
# Moodle 5.x: version.php public/ altında
CURRENT_VERSION=$(grep -r "release" "${MOODLE_PUBLIC}/version.php" 2>/dev/null | grep -oP "'\K[^']+" | head -1 || echo "Bilinmiyor")
echo "  Mevcut sürüm: ${CURRENT_VERSION}"

# Uzak değişiklikleri al
echo ""
echo "[1/4] Uzak Moodle güncellemeleri alınıyor..."
if [[ "${DRY_RUN}" == "false" ]]; then
    cd "${MOODLE_DIR}"
    git fetch --tags origin
else
    echo "  [DRY-RUN] Atlandı"
fi

# Mevcut tag'leri listele
echo ""
echo "  Mevcut stabil tag'ler:"
cd "${MOODLE_DIR}"
git tag --sort=-version:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -5 || true

# Belirli bir tag'e geç
if [[ -n "${TARGET_TAG}" ]]; then
    echo ""
    echo "[2/4] ${TARGET_TAG} sürümüne geçiliyor..."
    if [[ "${DRY_RUN}" == "false" ]]; then
        git checkout "${TARGET_TAG}"
        NEW_VERSION=$(grep "release" public/version.php | grep -oP "'\K[^']+" | head -1 || echo "Bilinmiyor")
        echo "  Yeni sürüm: ${NEW_VERSION}"
    else
        echo "  [DRY-RUN] git checkout ${TARGET_TAG} atlandı"
    fi
else
    echo ""
    echo "[2/4] MOODLE_501_STABLE branch en son commit'ine güncelleniyor..."
    if [[ "${DRY_RUN}" == "false" ]]; then
        git checkout MOODLE_501_STABLE
        git pull origin MOODLE_501_STABLE
    else
        echo "  [DRY-RUN] Atlandı"
    fi
fi

cd "${ROOT_DIR}"

# Özel tema/eklentilerin varlığını kontrol et
echo ""
echo "[3/4] Özel tema ve eklenti uyumluluğu kontrol ediliyor..."
for theme_dir in "${ROOT_DIR}/moodle-custom/themes"/*/; do
    theme_name=$(basename "${theme_dir}")
    echo "  Tema: ${theme_name} - public/theme/${theme_name} symlink kontrol edin"
done
for plugin_dir in "${ROOT_DIR}/moodle-custom/plugins"/*/; do
    plugin_name=$(basename "${plugin_dir}")
    echo "  Eklenti: ${plugin_name} - public/mod/${plugin_name#mod_} symlink kontrol edin"
done

# DB upgrade gerekebilir
echo ""
echo "[4/4] Güncelleme sonrası yapılacaklar:"
echo "  1. Docker'ı yeniden başlatın: docker compose restart"
echo "  2. Moodle upgrade'ini çalıştırın (Moodle 5.x: admin/cli/ repo root'ta):"
echo "     docker compose exec php php /var/www/moodle/admin/cli/upgrade.php"
echo "  3. Tarayıcıda http://portal.localhost/admin/ adresini kontrol edin"
echo "  4. Özel tema/eklentilerin çalıştığını doğrulayın"
echo ""
echo "Güncelleme işlemi tamamlandı."
