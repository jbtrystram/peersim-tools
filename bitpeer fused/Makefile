.PHONY: all clean doc compile

LIB_JARS=`find -L lib/ -name "*.jar" | tr [:space:] :`

compile:
	mkdir -p classes
	javac -sourcepath src -classpath $(LIB_JARS) -d classes `find -L -name "*.java"`

doc:
	mkdir -p doc
	javadoc -sourcepath src -classpath $(LIB_JARS) -d doc peersim.bittorrent

run:
	java -cp $(LIB_JARS):classes peersim.Simulator config-BitTorrent.cfg

all: compile doc run core

clean: 
	rm -fr classes doc
core:
	make -C peersim-1.0.5/ release
	cp peersim-1.0.5/peersim-1.0.5/peersim-1.0.5.jar lib/
