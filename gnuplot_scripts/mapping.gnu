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
load 'parula.pal'


NMAX=STATS_blocks
do for [n=0:NMAX] {
    ofname=sprintf("%d.png", n)
    set output ofname
	# set variable point labels
    plot datafile index n using 3:4:5 with points pointtype 5 lt palette

}

set terminal x11
