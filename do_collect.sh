#!/bin/bash

# exit on errors
set -e

temp_file="_tmp_eco_cdbpv.epd"

if [ -f "$temp_file" ]; then
    echo "$temp_file already exists. Exiting."
    exit 0
fi

python ../cdblib/cdbbulkpv.py -s -c 8 --stable --user rob eco.epd >"$temp_file"

mv "$temp_file" eco_cdbpv.epd

python ../caissatrack/caissatrack.py eco_cdbpv.epd >>ecotrack.csv
python ../caissatrack/extract_fens.py eco_cdbpv.epd --shortest 100 --ignore2folds >eco_daily_shortest.epd
python ../caissatrack/extract_fens.py eco_cdbpv.epd --evalMin 90 --evalMax 105 >eco_daily_edgy.epd

git add eco_cdbpv.epd ecotrack.csv eco_daily_shortest.epd eco_daily_edgy.epd
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log
