# ecotrack

Track the evaluations of the most common openings in the
[ECO](https://en.wikipedia.org/wiki/Encyclopaedia_of_Chess_Openings)
on [chessdb.cn](https://chessdb.cn/queryc_en/) (cdb). 
The file [`all.tsv`](all.tsv) was downloaded from 
[lichess-org/chess-openings](https://github.com/lichess-org/chess-openings)
in May 2025, and the `epd` fields were stored (in the original order)
in [`eco.epd`](eco.epd).

The file [`eco_cdbpv.epd`](eco_cdbpv.epd) 
contains the current cdb evaluations and PVs for each opening. It is created 
daily with the help of the script `cdbbulkpv.py` from 
[cdblib](https://github.com/robertnurnberg/cdblib), and the obtained statistics
are written to [`ecotrack.csv`](ecotrack.csv).
Moreover, each day the hundred positions with the currently shortest PVs on cdb
(ignoring PVs ending in a two-fold repetition)
are written to [`eco_daily_shortest.epd`](eco_daily_shortest.epd), and
the positions with absolute evaluations in the interval [90, 105]
are written to [`eco_daily_edgy.epd`](eco_daily_edgy.epd).

---

<p align="center"> <img src="ecotrack.png?raw=true"> </p>

---

<p align="center"> <img src="ecotrackpv.png?raw=true"> </p>

---

## Progress

The following graphs attempt to measure the progress cdb makes in exploring
and evaluating the positions in `eco.epd`. See
[caissatrack](https://github.com/robertnurnberg/caissatrack)
for a precise description of the plotted indicators.

<p align="center"> <img src="ecotracktime.png?raw=true"> </p>

<p align="center"> <img src="ecotracktime-100.png?raw=true"> </p>

---

## Get in touch

To discuss anything cdb related, and to help cdb grow at a healthy pace, join
other (computer) chess enthusiasts at the [chessdbcn channel](
https://discord.com/channels/435943710472011776/1101022188313772083) on the
[Stockfish discord server](https://discord.gg/ZzJwPv3).
