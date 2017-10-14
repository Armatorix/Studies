library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity lfsr is
    Port ( clk : in  STD_LOGIC;
           q : inout  STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0')
			);
end lfsr;

ARCHITECTURE Behavioral OF lfsr IS
BEGIN
  PROCESS
  BEGIN
	q(15 downto 1) <= q(14 downto 0);
	q(0) <= not(q(12) XOR q(11) XOR q(10) XOR q(3));
	
	WAIT UNTIL clk'event AND clk='1';
  END PROCESS;
END Behavioral;

