library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_coder is
    Port (  data_in  : in   STD_LOGIC_VECTOR (3 downto 0);
						data_out : out  STD_LOGIC_VECTOR (6 downto 0));
				    clk      : in   STD_LOGIC;
end hamming_coder;

architecture Behavioral of hamming_coder is
begin
p1: process(clk)
begin

  -- if decision = "110"			-- decision to flip one bit
  -- then
  --   for I in data_in'range loop
	-- 	if I = to_integer(unsigned(place1))
	-- 	then
	-- 		data_out(I) <= not data_in(I);
	-- 	else
	-- 		data_out(I) <= data_in(I);
	-- 	end if;
	--  end loop;
  -- elsif decision = "010"  -- decision to flip two bits
  -- then
  --   for I in data_in'range loop
	-- 	if I = to_integer(unsigned(place1))
	-- 	   or
  --      I = to_integer(unsigned(place2))
	-- 	then
	-- 		data_out(I) <= not data_in(I);
	-- 	else
	-- 		data_out(I) <= data_in(I);
	-- 	end if;
	--  end loop;
  -- else
	--   data_out <= data_in;
  -- end if;
end process;

end Behavioral;
