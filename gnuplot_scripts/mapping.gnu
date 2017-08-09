#Format de donnée de mapTest2.dat.dat :
#Temps numNode coordX coordY numPieces status Energy-state
#Temps numNode coordX coordY numPieces status Energy-state
#Temps numNode coordX coordY numPieces status Energy-state
#Temps numNode coordX coordY numPieces status Energy-state
#... puis sauter deux lignes

reset
stats datafile

set title "Network instant t"
set xlabel "X"
set ylabel "Y"
set xrange [0:1000]
set yrange [0:1000]
set cbrange[0:400]
set terminal png background rgb '#FFFFFF'

# palette from 'parula.pal'
set palette defined (0 '#352a87', 1 '#0363e1', 2 '#1485d4', 3 '#06a7c6',\
 4 '#38b99e', 5 '#92bf73', 6 '#d9ba56', 7 '#fcce2e', 8 '#f9fb0e')


NMAX=STATS_blocks
do for [n=0:NMAX] {
    ofname=sprintf("%04d.png", n)
    set output ofname
	# set variable point labels
    plot datafile index n using 3:4:5 with points pointtype 5 lt palette

}
