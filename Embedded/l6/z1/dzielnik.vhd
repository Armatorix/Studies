
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
entity dzielnik is
	generic (
			upper  : integer ;
			lower : integer
			);
	port(
			clk_in 	   : in  std_logic;
			clk_out    : inout std_logic := '1'
			);

end dzielnik;


architecture dzielnik_arch of dzielnik is
BEGIN
  PROCESS(clk_in)
			variable clk_counter : natural range 0 to upper+1 := 0;
  BEGIN
	if clk_in'event then
		if clk_counter = upper+1 then
			clk_counter := 0;
		end if;
		if NOT ( clk_out = '1' or clk_out = '0' ) then
			clk_out <='1';
		end if;
		clk_counter := clk_counter + 1;
		if clk_out = '1' and clk_counter = upper then
			clk_out <= '0';
			clk_counter := 0;
		elsif clk_out = '0' and clk_counter = lower then
			clk_out <= '1';
			clk_counter := 0;
		end if;
	end if;
  END PROCESS;
END dzielnik_arch;
