#!/usr/bin/env bash
# ============================================================
# db-export.sh
# Moodle veritabanını dışa aktarır.
# Kullanım: ./scripts/db-export.sh [--full | --schema-only | --data-only]
#           ./scripts/db-export.sh --full --output /path/to/output.sql
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
ENV_FILE="${ROOT_DIR}/.env"

MODE="full"
OUTPUT_DIR="${ROOT_DIR}/db"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

while [[ $# -gt 0 ]]; do
    case "$1" in
        --full)        MODE="full"; shift ;;
        --schema-only) MODE="schema"; shift ;;
        --data-only)   MODE="data"; shift ;;
        --output)      OUTPUT_DIR="$2"; shift 2 ;;
        *)             echo "Bilinmeyen argüman: $1"; exit 1 ;;
    esac
done

# Ortam değişkenlerini yükle
if [[ -f "${ENV_FILE}" ]]; then
    set -a; source "${ENV_FILE}"; set +a
else
    echo "HATA: .env dosyası bulunamadı"
    exit 1
fi

DB_HOST="${MOODLE_DB_HOST:-localhost}"
DB_PORT="${MOODLE_DB_PORT:-3306}"
DB_NAME="${MOODLE_DB_NAME:-moodle}"
DB_USER="${MOODLE_DB_USER:-moodleuser}"
DB_PASS="${MOODLE_DB_PASS:-}"

DUMP_OPTS="--single-transaction --routines --triggers --add-drop-table"
OUTPUT_FILE=""

case "${MODE}" in
    full)
        OUTPUT_FILE="${OUTPUT_DIR}/schema_dump_${TIMESTAMP}.sql"
        DUMP_OPTS="${DUMP_OPTS}"
        ;;
    schema)
        OUTPUT_FILE="${OUTPUT_DIR}/schema_only_${TIMESTAMP}.sql"
        DUMP_OPTS="${DUMP_OPTS} --no-data"
        ;;
    data)
        OUTPUT_FILE="${OUTPUT_DIR}/data_only_${TIMESTAMP}.sql"
        DUMP_OPTS="${DUMP_OPTS} --no-create-info"
        ;;
esac

echo "Veritabanı dışa aktarılıyor..."
echo "  Host: ${DB_HOST}:${DB_PORT}"
echo "  DB:   ${DB_NAME}"
echo "  Mod:  ${MODE}"
echo "  Çıktı: ${OUTPUT_FILE}"

mysqldump -h"${DB_HOST}" -P"${DB_PORT}" -u"${DB_USER}" -p"${DB_PASS}" \
    ${DUMP_OPTS} "${DB_NAME}" > "${OUTPUT_FILE}"

# Boyutu göster
SIZE=$(du -sh "${OUTPUT_FILE}" | cut -f1)
echo "  Tamamlandı: ${SIZE}"

# schema_dump.sql symlink'ini güncelle (full dump için)
if [[ "${MODE}" == "full" ]]; then
    ln -sf "$(basename "${OUTPUT_FILE}")" "${OUTPUT_DIR}/schema_dump.sql"
    echo "  schema_dump.sql güncellendi"
fi

echo "Dışa aktarma başarılı: ${OUTPUT_FILE}"
