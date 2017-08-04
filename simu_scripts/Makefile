
FOLDER = "./simu_output"
TEMPFILE = $(FOLDER)/tmp.txt
#TEMPFILE := $(shell mktemp -p $(FOLDER) -u)


CONFIG = "./config-BitTorrent.cfg"
#TEMPDIR := $(shell mktemp -p ./ -d)


LIB_JARS=`find -L lib/ -name "*.jar" | tr "[:space:]" :`

try: 
	java -Xms512m -Xmx2048m -cp $(LIB_JARS) peersim.Simulator $(CONFIG)

run:
	mkdir $(FOLDER)
	 java -Xms512m -Xmx2048m -cp $(LIB_JARS) peersim.Simulator $(CONFIG) > $(TEMPFILE)

cleanfile:
	head -n -1 $(TEMPFILE) > $(TEMPFILE).tmp; mv $(TEMPFILE).tmp $(TEMPFILE)
	tail -n +2 $(TEMPFILE) > $(TEMPFILE).tmp; mv $(TEMPFILE).tmp $(TEMPFILE)

gnuplot: cleanfile
	cd $(FOLDER); gnuplot -e datafile="'tmp.txt'" ../../gnuplot_scripts/Map2Commandes.gnu
	
gif: gnuplot
	cd $(TEMPDIR); for a in *.png; do
		b=$(printf %04d.png ${a%.png})
		if [ $a != $b ]; then
			mv $a $b
		fi
	done 
	cd $(TEMPDIR); convert -delay 10 -loop 0 *.png ../$(TEMPFILE).gif

video: gif
	#todo

clean: 
	rm -rf $(FOLDER)


wrap: run cleanfile gnuplot gif
