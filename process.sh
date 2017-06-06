#!/bin/bash


TEMPFILE=./tmp$BASHPID
GNUPLOT=./plot$BASHPID
MAX_VALUE=`awk '/(L)/ {print $0}' $1 | awk 'sub(/\(L\)/, "", $3)' | sort -nrk3,3 | head -1 | cut -d ' ' -f3 `

#edit file 
awk '/(L)/ {print $0}' $1 | awk 'sub(/\(L\)/, "", $3) {print $0}' > $TEMPFILE

#prep gnuplot script

echo > $GNUPLOT
echo "set terminal jpeg" >> $GNUPLOT 
echo "set output 'gnuplot.jpg'" >> $GNUPLOT 
echo "set title ' blocs complétés '" >> $GNUPLOT 
echo "set xlabel ' Temps '" >> $GNUPLOT 
echo "set ylabel ' Blocs '" >> $GNUPLOT 

#iterate through the file to isolate data
echo "plot \\" >> $GNUPLOT
for ((i=1;i<=MAX_VALUE;i++)); do
    awk "/node $i / {print \$0}" $TEMPFILE > data_$i
    echo "   'data_$BASHPID_$i' using 12:6 notitle with lines, \\" >> $GNUPLOT
done
echo "    0 notitle" >> $GNUPLOT
gnuplot $GNUPLOT

#cleanup
rm data_*
rm $GNUPLOT
rm $TEMPFILE
