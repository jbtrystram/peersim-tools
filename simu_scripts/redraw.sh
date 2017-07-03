#!/bin/bash
#Argument 1 : nom du fichier final
#Argument 2 : temps d'execution en ms
sed -i '4s/.*/simulation.endtime '$2'/' config-BitTorrent.cfg

# make

# make run 1>./output/scripts/webm/$1

sh ./output/scripts/webm/cleaner.sh ./output/scripts/webm/$1

gnuplot -e "datafile='./output/scripts/webm/$1'"  ./output/scripts/webm/Map2Commandes.gnu

sh mkwebm.sh $1 $2
rm *.png

