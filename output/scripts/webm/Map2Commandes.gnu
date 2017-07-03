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
set terminal png size 1200,720 background rgb "#404040"
set palette rgb -21,-22,-23;

NMAX=STATS_blocks
do for [n=0:NMAX] {
    ofname=sprintf("%d.png", n)
    set output ofname
    #plot datafile index n using 1:2:3 with points pointtype 7 lt palette
    plot datafile index n using 1:2:($4==0?$3:1/0) with points pointtype 7 lt palette,\
	   "" index n using 1:2:($4==1?$3:1/0) with points pointtype 9 lt palette,\
	   #"" index n using 1:2:($4==2?$3:1/0) with points pointtype 5 lt palette
}

set terminal x11
