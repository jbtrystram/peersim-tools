#!/bin/bash


TEMPFILE=./tmp$BASHPID
GNUPLOT=./plot$BASHPID

echo "Time	Leechs	Seeds	Active" > $TEMPFILE

#remove junk from file 
mapfile <$1 TMPDATA
TMPDATA=`grep "OBS" $mapfile`


MAX_VALUE=`echo $TMPDATA | sort -nrk12,12 | cut -d ' ' -f13 | uniq | head -1`
STEP_VALUE=`echo $TMPDATA | sort -nrk12,12 | cut -d ' ' -f13 | uniq | head -2 | tail -1`
echo $MAX_VALUE
echo $STEP_VALUE
STEP_VALUE=$((MAX_VALUE-STEP_VALUE))

for ((i=0;i<=MAX_VALUE;i+=STEP_VALUE)); do
	#get leechers and seeders count
	LEECH=`echo $TMPDATA | awk "/time: $i/ && /(L)/ {count++} END {print count}" ` 
	SEED=`echo $TMPDATA | awk "/time: $i/ && /(S)/ {count++} END {print count}" ` 
	#active peers
	ACTIVE=`echo $TMPDATA | awk "/time: $i/ && \\$8 == 0 && \\$10 == 0 {count++} END {print count}" `
	#write to file
	echo "$i	$LEECH	$SEED	$ACTIVE"	>> $TEMPFILE
done

#write gnuplot script

echo > $GNUPLOT
echo "set terminal jpeg" >> $GNUPLOT 
echo "set output 'gnuplot2.jpg'" >> $GNUPLOT 
echo "set title ' Seeders / Leechers '" >> $GNUPLOT 
echo "set key invert reverse Left outside" >> $GNUPLOT 
echo "set key autotitle columnheader" >> $GNUPLOT 
echo "set xlabel ' Temps '" >> $GNUPLOT 
echo "set ylabel ' Total Peers '" >> $GNUPLOT
echo "set boxwidth 1.25" >> $GNUPLOT
echo "set style fill solid border -1 " >> $GNUPLOT
echo "set style histogram rowstacked" >> $GNUPLOT
echo "set xtics autofreq 0, 10" >> $GNUPLOT

echo "plot 'tmp$BASHPID' using 2 with histogram, '' using 3 with histogram, 'tmp$BASHPID' using 4 with lines lw 2 title 'Active Peers'" >> $GNUPLOT

gnuplot $GNUPLOT


#cleanup
rm $TEMPFILE
rm $GNUPLOT
