javac -d classes src/ParserHistogram.java

cd classes

java ParserHistogram ../output/scripts/webm/$1 | tee ../output/scripts/histogram/data

cd ../output/scripts/histogram/

gnuplot -p -e 'gnuplot'
