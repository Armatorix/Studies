LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dzielnik_tb IS
END dzielnik_tb;

ARCHITECTURE behavior OF dzielnik_tb IS

	COMPONENT dzielnik
		generic (N  : integer);
    port(
		clk_in : in std_logic;
		clk_out : inout std_logic_vector(9 downto 0)
		);
	END COMPONENT;

	 signal clk_in : std_logic;
   signal clk_out : std_logic_vector(9 downto 0) := (others => '0');
   constant clk_period : time := 8 ns;

	BEGIN
		-- instantiate UUT
	   uut: dzielnik
		 GENERIC MAP(
 		N  => 10)
		 PORT MAP (
		 	clk_in => clk_in,
			clk_out => clk_out
	   );

	   -- clock management process
	   -- no sensitivity list, but uses 'wait'
	   clk_process :PROCESS
	   BEGIN
			clk_in <= '0';
			WAIT FOR clk_period/2;
			clk_in <= '1';
			WAIT FOR clk_period/2;
	   END PROCESS;


	   stim_proc: PROCESS
	   BEGIN
	   wait for 1000 ns;
	   wait;
	   END PROCESS;
	END;
