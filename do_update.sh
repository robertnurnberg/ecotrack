#!/bin/bash

python ../caissatrack/plotdata.py ecotrack.csv --cutOff 200 --negplot -ll --edgeMin 90 --edgeMax 105 --PvLengthPlot pvlength.png

git add ecotrack.png ecotrackpv.png ecotracktime.png ecotracktime-100.png
git diff --staged --quiet || git commit -m "update plots"
git push origin main >&push.log
