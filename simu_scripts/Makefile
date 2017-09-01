
FOLDER = "./simu_output"
TEMPFILE = $(FOLDER)/tmp.txt
#TEMPFILE := $(shell mktemp -p $(FOLDER) -u)


CONFIG = "./config-BitTorrent.cfg"
#TEMPDIR := $(shell mktemp -p ./ -d)


LIB_JARS=`find -L lib/ -name "*.jar" | tr "[:space:]" :`

try: 
	java -Xms512m -Xmx2048m -cp $(LIB_JARS) peersim.Simulator $(CONFIG)

run: clean
	mkdir $(FOLDER)
	java -Xms512m -Xmx2048m -cp $(LIB_JARS) peersim.Simulator $(CONFIG) > $(TEMPFILE)

gnuplot:
	cd $(FOLDER); gnuplot -e datafile="'tmp.txt'" ../../gnuplot_scripts/mapping.gnu
	
gif: gnuplot
	cd $(FOLDER); convert -delay 10 -loop 0 *.png ../$(TEMPFILE).gif

histogram:
	cd $(FOLDER); python ../../gnuplot_scripts/hysto.py tmp.txt

clean: 
	rm -rf $(FOLDER)


wrap: run gif histogram

tar: 
	cp $(CONFIG) $(FOLDER)
	tar -czf `date "+%Y-%m-%d_%H-%M"`.tar.gz $(FOLDER)

archive: tar clean
