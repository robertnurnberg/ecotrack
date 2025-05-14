#!/bin/bash

# exit on errors
set -e

PREFIX="eco"
SOURCE="${PREFIX}.epd"
DEST="${PREFIX}_cdbpv.epd"
TEMP_FILE="_tmp_$DEST"
TRIMMED="${PREFIX}_trimmed.epd"
MATES="${PREFIX}_mates.epd"
ORACLE="../caissatrack/caissa_sorted_100000_cdbpv.epd $MATES"
FILTER="python ../cdblib/addons/fens_filter_overlap.py --saveMemory --noStats"
CDBBULK="python ../cdblib/cdbbulkpv.py -s -c 8 --stable --user rob"
SCORE="python ../cdblib/addons/score_fens_locally.py"

if [ -f "$TEMP_FILE" ]; then
    echo "$TEMP_FILE already exists. Exiting."
    exit 0
fi

if [ -f "$DEST" ]; then
    grep mated "$DEST" >"$MATES"
else
    rm -f "$MATES"
    touch "$MATES"
fi

$FILTER $SOURCE $ORACLE >"$TRIMMED"
$CDBBULK "$TRIMMED" >"$TEMP_FILE"
$SCORE $SOURCE $TEMP_FILE $ORACLE >"$DEST"
rm "$TEMP_FILE"

CSV="${PREFIX}track.csv"
SHORTEST="${PREFIX}_daily_shortest.epd"
EDGY="${PREFIX}_daily_edgy.epd"

python ../caissatrack/caissatrack.py "$DEST" >>"$CSV"
python ../caissatrack/extract_fens.py "$DEST" --shortest 100 --ignore2folds >"$SHORTEST"
python ../caissatrack/extract_fens.py "$DEST" --evalMin 90 --evalMax 105 >"$EDGY"

git add "$DEST" "$CSV" "$SHORTEST" "$EDGY"
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log
