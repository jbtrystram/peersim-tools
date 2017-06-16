all:
	make -C peersim-1.0.5 release
	cp peersim-1.0.5/peersim-1.0.5/peersim-1.0.5.jar bitpeer\ fused/lib
