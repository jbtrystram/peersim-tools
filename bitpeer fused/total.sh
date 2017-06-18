#!/bin/bash
#Argument 1 : nom du fichier final
#Argument 2 : temps d'execution en ms
sed -i '4s/.*/simulation.endtime '$2'/' config-BitTorrent.cfg

make

make run 1>$1

sh cleaner.sh $1

gnuplot -e "datafile='$1'"  Map2Commandes.gnu

sh mkwebm.sh $1 $2
