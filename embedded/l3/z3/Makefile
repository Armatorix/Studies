all:
	make lfsr
	make lfsr_tb
lfsr:
	ghdl -a lfsr.vhd
	ghdl -e lfsr
lfsr_tb:
	ghdl -a --ieee=synopsys lfsr_tb.vhd
	ghdl -e --ieee=synopsys lfsr_tb
vcd:
	timeout 1s ghdl -r lfsr_tb --vcd=lfsr.vcd
gtk:
	gtkwave lfsr.vcd
clean:
	rm *.o *cf
	rm lfsr lfsr_tb
remake:
	make clean
	make lfsr
	make lfsr_tb
	timeout 1s ghdl -r lfsr_tb
