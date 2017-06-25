	all:
	make analize
	make testbench
analize:
	ghdl -a ram.vhd
	ghdl -a counter.vhd
	ghdl -a mar.vhd
	ghdl -a reg.vhd
	ghdl -a alu.vhd
	ghdl -a controller.vhd
	ghdl -a marie.vhd

testbench:
	ghdl -e marie
vcd:
	ghdl -r marie --vcd=marie.vcd --stop-time=100us
gtk:
	gtkwave marie.vcd
clean:
	ghdl --clean
	rm work*
	rm *.vcd
	rm *.o
	rm marie
remake:
	-make clean
	make
	make vcd
	make gtk
x:
	ghdl -a ram.vhd
	ghdl -a ram_tb.vhd
	ghdl -e ram_tb
	ghdl -r ram_tb --vcd=ram.vcd
	gtkwave ram.vcd
