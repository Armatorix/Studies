all:
	make analize
	make slave_tb
analize:
	ghdl -a pack.vhd
	ghdl -a crc8.vhd
	ghdl -a slave.vhd
slave_tb:
	ghdl -a slave_tb.vhd
	ghdl -e slave_tb
clean:
	ghdl --clean
	rm work*
	rm *.vcd
	rm slave_tb
	rm *.o
vcd:
	ghdl -r slave_tb --vcd=slave.vcd --stop-time=1us
gtk:
	gtkwave slave.vcd
remake:
	-make clean
	make
	make vcd
	make gtk
