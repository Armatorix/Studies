all:
	make lfsr
	make lossy_channel
	make hamming_coder
	make hamming_decoder
	make hamming_tb
lfsr:
	ghdl -a lfsr.vhd
lossy_channel:
	ghdl -a lossy_channel.vhd
hamming_coder:
	ghdl -a hamming_coder.vhd
hamming_decoder:
	ghdl -a hamming_decoder.vhd
hamming_tb:
	ghdl -a hamming_tb.vhd --ieee=synopsys 
	ghdl -e hamming_tb
clean:
	ghdl --clean
	rm work*
	rm *.vcd
	rm hamming_tb
	rm *.o
vcd:
	ghdl -r hamming_tb --vcd=hamming.vcd
gtk:
	gtkwave hamming.vcd
