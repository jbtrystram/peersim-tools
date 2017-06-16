#Format de donnée de 2DColorTest.dat :
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

plot "2DColorTest.dat" u 1:3:2 with points lt palette
set terminal png  
set output "2DColorTest.png"
replot
set terminal x11
