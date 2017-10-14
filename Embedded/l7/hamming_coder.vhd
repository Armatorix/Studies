library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_coder is
    Port (  data_in  : in   STD_LOGIC_VECTOR (3 downto 0);
						data_out : out  STD_LOGIC_VECTOR (6 downto 0);
				    clk      : in   STD_LOGIC);
end hamming_coder;

architecture Behavioral of hamming_coder is
begin
p1: process(clk)
begin
	data_out(0) <= data_in(0) XOR data_in(1) XOR data_in(3);
	data_out(1) <= data_in(0) XOR data_in(2) XOR data_in(3);
	data_out(2) <= data_in(1) XOR data_in(2) XOR data_in(3);
	data_out(3) <= data_in(0);																--change with 2 and in decoder
	data_out(4) <= data_in(1);
	data_out(5) <= data_in(2);
	data_out(6) <= data_in(3);
end process;

end Behavioral;
