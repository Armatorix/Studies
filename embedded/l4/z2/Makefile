all:
	make rom
	make pack
	make crc8
	make crc8_tb
	
crc8:
	ghdl -a crc8.vhd
	ghdl -e crc8
crc8_tb:
	ghdl -a crc8_tb.vhd
	ghdl -e crc8_tb
rom:
	ghdl -a rom.vhd
	ghdl -e rom_for_crc8	
pack:
	ghdl -a pack.vhd
clean:
	rm *.o
	rm work-obj93.cf crc8 crc8_tb

