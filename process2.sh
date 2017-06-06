#!/bin/bash


TEMPFILE=./tmp$BASHPID
GNUPLOT=./plot$BASHPID

#echo "Time	Leechs	Seeds	Upload	Download	Active" > $TEMPFILE
echo "Time	Leechs	Seeds	Active" > $TEMPFILE

STEP_TIME=0
LINE_TIME=0

SEED=0
LEECH=0
ACTIVE=0

UP=0
DOWN=0
#remove junk from file 
TMPDATA=./tmpData$BASHPID
grep "OBS" $1 > $TMPDATA

#read file line by line 
while IFS='' read -r line || [[ -n "$line" ]]; do
	LINE_TIME=$( echo "$line" | cut -d ' ' -f13 )
	#agregate bandwith
	((UP+=$( echo "$line" | cut -d ' ' -f11 )))
	((DOWN+=$( echo "$line" | cut -d ' ' -f9 )))
	#Active peers
	if [[ $(echo "$line" | cut -d ' ' -f9) -ne 0 || $(echo "$line" | cut -d ' ' -f11) -ne 0 ]]; then 
		((++ACTIVE))
	fi
	#count leechers and seeders
	if [ "$LINE_TIME" -eq "$STEP_TIME" ]; then		
		if [[ $line == *"(L)"* ]]; then
  			((++LEECH))
		elif [[ $line == *"(S)"* ]]; then
			((++SEED))
		fi
	# total number of seeds & leech have been found, write them in file	
	else
		echo "$STEP_TIME	$LEECH	$SEED	$ACTIVE"	>> $TEMPFILE	
		STEP_TIME=$LINE_TIME
		SEED=0
		LEECH=0
		UP=0
		DOWN=0
		ACTIVE=0
	fi		
done < "$TMPDATA"

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
