
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity dzielnik is
	generic (
			N : integer
			);
	port(
			clk_in 	   : in  std_logic;
			clk_out    : inout std_logic_vector (N-1 downto 0) := (others => '0')
			);

end dzielnik;


architecture dzielnik_arch of dzielnik is
BEGIN
  PROCESS(clk_in)
  BEGIN
	if clk_in'event then
		clk_out <= std_logic_vector( unsigned(clk_out) + 1);
	end if;
  END PROCESS;
END dzielnik_arch;
