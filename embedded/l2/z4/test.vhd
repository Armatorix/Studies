LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

ENTITY test IS
END test;

ARCHITECTURE behavior OF test IS 
	component Xand is 
		generic (width : integer);
		port ( clk : in std_logic;
			   A,B : in std_logic_vector(width-1 downto 0);
				 C : out std_logic_vector(width-1 downto 0)
			);
	end component;

	signal A,B : std_logic_vector(3 downto 0) := (others => '0');
	signal C : std_logic_vector(3 downto 0);
	signal clk : std_logic;
	constant period : time := 10 ns;
	variable
BEGIN
	UUT : Xand generic map (width => 4)
				port map (
				clk => clk,
				A => A,
				B => B,
				C => C);

 stim_proc: process
	begin	
		for i in 0 to 15 loop
			for j in 0 to 15 loop
			wait for period;
			B <= std_logic_vector( unsigned(B) + 1);
			end loop;
			A <= std_logic_vector( unsigned(A) + 1);
		end loop;
		wait;
	end process;
END;
