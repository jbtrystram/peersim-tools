#Format de donnée de mapTest2.dat.dat :
#Temps numNode numPieces
#Temps numNode numPieces
#Temps numNode numPieces
#Temps numNode numPieces
#... puis sauter deux lignes


#Temps numNode numPieces
#Temps numNode numPieces
#Temps numNode numPieces
#Temps numNode numPieces
#... puis sauter deux lignes


#etc...
reset
stats datafile

set title "Network instant t"
set xlabel "X"
set ylabel "Y"
set xrange [0:1000]
set yrange [0:1000]
set cbrange[0:400]
set terminal png  
set palette rgb -21,-22,-23;

NMAX=STATS_blocks
do for [n=0:NMAX] {
    ofname=sprintf("%d.png", n)
    set output ofname
    plot datafile index n using 1:2:3 with points pointtype 7 lt palette
}

set terminal x11
