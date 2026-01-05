bash -lc set -euo pipefail
INPUT=/mnt/data/network_backup_01.04.2026_12-00-AM_v10.0.162.unf
TMP=$(mktemp)
OUT=/mnt/data/network_backup_decrypted_fixed.zip
openssl enc -d -in "$INPUT" -out "$TMP" -aes-128-cbc -K 626379616e676b6d6c756f686d617273 -iv 75626e74656e74657270726973656170 -nopad
# feed 'y' then many 'e'
(printf 'y\n'; yes e | head -n 50) | zip -FF "$TMP" --out "$OUT" > /mnt/data/zip_fix.log 2>&1 || true
ls -l "$OUT" || true
head -n 40 /mnt/data/zip_fix.log
# test zip with unzip -l
unzip -l "$OUT" | head -n 30 || true
rm -f "$TMP"
