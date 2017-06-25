all:
	make dzielnik
	make dzielnik_tb

dzielnik:
	ghdl -a dzielnik.vhd
dzielnik_tb:
	ghdl -a dzielnik_tb.vhd
	ghdl -e dzielnik_tb
clean:
	ghdl --clean
	rm work*
	rm *.vcd
	rm dzielnik_tb
	rm *.o
vcd:
	ghdl -r dzielnik_tb --vcd=dzielnik.vcd
gtk:
	gtkwave dzielnik.vcd
