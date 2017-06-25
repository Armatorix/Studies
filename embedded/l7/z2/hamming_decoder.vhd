library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hamming_decoder is
    Port (  data_in  : in   STD_LOGIC_VECTOR (7 downto 0);
						data_out : out  STD_LOGIC_VECTOR (3 downto 0);
				    clk      : in   STD_LOGIC);
end hamming_decoder;

architecture Behavioral of hamming_decoder is
begin
p: process(data_in)
	variable c0,c1,c2,c3 : std_logic;
begin
	c0 := data_in(4) XOR data_in(5) XOR data_in(7);
	c1 := data_in(4) XOR data_in(6) XOR data_in(7);
	c2 := data_in(5) XOR data_in(6) XOR data_in(7);
	c3 := data_in(4) XOR data_in(5) XOR data_in(6) XOR data_in(7);

	data_out(0) <= data_in(4);
	data_out(1) <= data_in(5);
	data_out(2) <= data_in(6);
	data_out(3) <= data_in(7);
-- TODO !!!
	--3
	if NOT(c3 = data_in(3)) then
		if NOT( c0 = data_in(0) OR c1 = data_in(1) ) then
			data_out(3) <= NOT(data_in(7));

			--2
		elsif NOT( c1 = data_in(1) OR c2 = data_in(2) ) then
			data_out(2) <= NOT(data_in(6));

			--1
		elsif NOT( c0 = data_in(0) OR c2 = data_in(2) ) then
			data_out(1) <= NOT(data_in(5));

		--0
		elsif NOT( c0 = data_in(0) OR c1 = data_in(1) ) then
			data_out(0) <= NOT(data_in(4));
		end if;
	else
		if NOT( c1 = data_in(1) OR c2=data_in(2)) then
			data_out(1) <= NOT(data_in(5));
			data_out(0) <= NOT(data_in(4));

			--2
		elsif NOT(c0 = data_in(0) OR c1=data_in(1)) then
			data_out(1) <= NOT(data_in(5));
			data_out(2) <= NOT(data_in(6));
			--1
		elsif NOT( c0 = data_in(0) OR c2=data_in(2)) then
			data_out(0) <= NOT(data_in(4));
			data_out(2) <= NOT(data_in(6));
		end if;
	end if;

end process;

end Behavioral;
