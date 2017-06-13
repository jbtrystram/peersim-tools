#Le fichier GIFtest.dat doit être sous le format :
#numNode numPieces
#numNode numPieces
#numNode numPieces
#... suivi de deux espaces:


#numNode numPieces
#numNode numPieces
#numNode numPieces
#...

#Puis, modifier les fichiers 1 à 9 en 01 à 09 (pour éviter bug affichage gif)
#Puis, hors de gnuplot et dans le dossier contenant les .png faire :
#convert -delay 12 -loop 0 *.png animated.gif

reset

datafile = 'GIFtest.dat'
set title "Network instant t"
set xlabel "Node number"
set ylabel "Number of pieces"
set xrange [0:50]
set yrange [0:400]
set terminal png  

#stats datafile
NMAX=100

do for [n=0:NMAX] {
    ofname=sprintf("%d.png", n)
    set output ofname
    plot datafile index n using 1:2, datafile index n using 1:3 with lines
}


set terminal x11