all:
	make vhdl_txt
	make statemachine
	make statemachine_tb
	
statemachine:
	ghdl -a statemachine.vhd
	ghdl -e statemachine
statemachine_tb:
	ghdl -a statemachine_tb.vhd
	ghdl -e statemachine_tb
vhdl_txt:
	ghdl -a vhdl_txt.vhd
clean:
	rm *.o
	rm work-obj93.cf statemachine statemachine_tb
vcd:
	timeout 0.1s ghdl -r statemachine_tb --vcd=statemachine.vcd
gtk:
	gtkwave statemachine.vcd
