#!/usr/bin/env bash
# ============================================================
# apply_migrations.sh
# Uygulanmamış SQL migration'larını sırasıyla çalıştırır.
# Kullanım: ./db/apply_migrations.sh [--dry-run] [--env production]
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MIGRATIONS_DIR="${SCRIPT_DIR}/migrations"
ENV_FILE="${SCRIPT_DIR}/../.env"
DRY_RUN=false
ENV_MODE="local"

# --- Argüman Ayrıştırma ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)   DRY_RUN=true; shift ;;
        --env)       ENV_MODE="$2"; shift 2 ;;
        *)           echo "Bilinmeyen argüman: $1"; exit 1 ;;
    esac
done

# --- Ortam Değişkenlerini Yükle ---
if [[ -f "${ENV_FILE}" ]]; then
    # shellcheck disable=SC1090
    set -a; source "${ENV_FILE}"; set +a
else
    echo "HATA: .env dosyası bulunamadı: ${ENV_FILE}"
    exit 1
fi

# Üretim modunda farklı env dosyası kullan
if [[ "${ENV_MODE}" == "production" ]]; then
    PROD_ENV="${SCRIPT_DIR}/../.env.production"
    if [[ -f "${PROD_ENV}" ]]; then
        set -a; source "${PROD_ENV}"; set +a
    fi
fi

DB_HOST="${MOODLE_DB_HOST:-localhost}"
DB_PORT="${MOODLE_DB_PORT:-3306}"
DB_NAME="${MOODLE_DB_NAME:-moodle}"
DB_USER="${MOODLE_DB_USER:-moodleuser}"
DB_PASS="${MOODLE_DB_PASS:-}"

MYSQL_CMD="mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USER} -p${DB_PASS} ${DB_NAME}"

# --- Migration takip tablosunu oluştur (yoksa) ---
${MYSQL_CMD} <<'SQL'
CREATE TABLE IF NOT EXISTS `ayisigi_applied_migrations` (
    `id`           INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    `filename`     VARCHAR(255)     NOT NULL,
    `applied_at`   DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `description`  TEXT,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_filename` (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SQL

echo "============================================================"
echo " Ayisigimakademi - Migration Aracı"
echo " Mod: ${ENV_MODE} | Dry-run: ${DRY_RUN}"
echo "============================================================"

applied_count=0
skipped_count=0
error_count=0

# --- Migration dosyalarını sırasıyla işle ---
for migration_file in $(ls "${MIGRATIONS_DIR}"/*.sql 2>/dev/null | sort); do
    filename=$(basename "${migration_file}")

    # Daha önce uygulandı mı kontrol et
    already_applied=$(${MYSQL_CMD} -sN -e \
        "SELECT COUNT(*) FROM ayisigi_applied_migrations WHERE filename='${filename}';" 2>/dev/null || echo "0")

    if [[ "${already_applied}" == "1" ]]; then
        echo "  ATLA   ${filename} (zaten uygulanmış)"
        ((skipped_count++)) || true
        continue
    fi

    echo "  UYGULA ${filename}"

    if [[ "${DRY_RUN}" == "true" ]]; then
        echo "         [DRY-RUN] Gerçekte çalıştırılmadı"
        continue
    fi

    # Migration'ı uygula
    if ${MYSQL_CMD} < "${migration_file}"; then
        # Başarılı ise kayıt ekle (migration dosyasında INSERT yoksa)
        ${MYSQL_CMD} -e \
            "INSERT IGNORE INTO ayisigi_applied_migrations (filename, description) VALUES ('${filename}', 'Script tarafından uygulandı');" 2>/dev/null || true
        echo "         OK"
        ((applied_count++)) || true
    else
        echo "  HATA   ${filename} uygulanırken hata oluştu!"
        ((error_count++)) || true
        exit 1
    fi
done

echo "============================================================"
echo " Sonuç: ${applied_count} uygulandı, ${skipped_count} atlandı, ${error_count} hata"
echo "============================================================"
