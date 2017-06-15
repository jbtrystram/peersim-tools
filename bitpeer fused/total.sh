#!/bin/bash

make 

make run 1>$1

sh cleaner.sh $1

gnuplot -e "datafile='$1'"  Map2Commandes.gnu

sh mkwebm.sh $1


