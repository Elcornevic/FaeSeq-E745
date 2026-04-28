set terminal png tiny size 1400,1400
set output "e745_plot.png"
set xtics rotate ( \
 "NC_017960.1" 1.0, \
 "NC_017961.1" 2698137.0, \
 "NC_017962.1" 2734398.0, \
 "NC_017963.1" 2800644.0, \
 "" 3052572 \
)
set ytics ( \
 "tig00000001" 1.0, \
 "tig00000002" 2762475.0, \
 "tig00000003" 2961856.0, \
 "tig00000004" 2984627.0, \
 "tig00000005" 2999360.0, \
 "tig00000006" 3039372.0, \
 "tig00000007" 3054384.0, \
 "tig00000008" 3070427.0, \
 "tig00000009" 3085854.0, \
 "tig00000012" 3110801.0, \
 "" 3115034 \
)
set size 1,1
set grid
unset key
set border 0
set tics scale 0
set xlabel "REF"
set ylabel "QRY"
set format "%.0f"
set mouse format "%.0f"
set mouse mouseformat "[%.0f, %.0f]"
set xrange [1:3052572]
set yrange [1:3115034]
set style line 1  lt 1 lw 3 pt 6 ps 1
set style line 2  lt 3 lw 3 pt 6 ps 1
set style line 3  lt 2 lw 3 pt 6 ps 1
plot \
 "e745_plot.fplot" title "FWD" w lp ls 1, \
 "e745_plot.rplot" title "REV" w lp ls 2
