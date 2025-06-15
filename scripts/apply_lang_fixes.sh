#!/usr/bin/env bash
# apply_lang_fixes.sh — Dil string düzeltmeleri ve SCSS güncellemeleri
# Çalıştır: docker exec ayisigimakademi_moodle bash /path/apply_lang_fixes.sh

set -e

LANG_DIR="/var/moodledata/lang/tr"
MOODLE_PHP="$LANG_DIR/moodle.php"
OVERVIEW_PHP="$LANG_DIR/block_myoverview.php"

echo "=== Dil Düzeltmeleri ==="

# 1. "Kontrol paneli" → "Portalım"
sed -i "s/\$string\['myhome'\] = 'Kontrol paneli';/\$string['myhome'] = 'Portalım';/" "$MOODLE_PHP"
echo "myhome: $(grep "'myhome'" $MOODLE_PHP)"

# 2. "Çeşitli" → boş
sed -i "s/\$string\['miscellaneous'\] = 'Çeşitli';/\$string['miscellaneous'] = '';/" "$MOODLE_PHP"
echo "miscellaneous: $(grep "'miscellaneous'" $MOODLE_PHP)"

# 3. "Kur oluştur" → "Kurs oluştur"
if [ -f "$OVERVIEW_PHP" ]; then
  sed -i "s/\$string\['createcourse'\] = 'Kur oluştur';/\$string['createcourse'] = 'Kurs oluştur';/" "$OVERVIEW_PHP"
  echo "createcourse: $(grep 'createcourse' $OVERVIEW_PHP)"
fi

echo "=== Tamamlandı ==="
