#Format de donnée de 3DColorTest.dat :
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

splot "3DColorTest.dat" u 1:2:3 with points lt palette
set terminal png  
set output "3DColorCommande.png"
replot
set terminal x11
