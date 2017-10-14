LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dzielnik_tb IS
END dzielnik_tb;

ARCHITECTURE behavior OF dzielnik_tb IS

	COMPONENT dzielnik
		generic (
		upper  : integer ;
		lower : integer );
    port(
		clk_in : in std_logic;
		clk_out : inout std_logic
		);
	END COMPONENT;

	 signal clk_in : std_logic;
   signal clk_out50 : std_logic;
	 signal clk_out100 : std_logic;
	 signal clk_out11 : std_logic;
   constant clk_period : time := 8 ns;

	BEGIN
		-- instantiate UUT
	   clk_50: dzielnik
		 GENERIC MAP(
 		upper  => 3,
 		lower  => 2)
		 PORT MAP (
		 	clk_in => clk_in,
			clk_out => clk_out50
	   );

		 clk_100: dzielnik
		 GENERIC MAP(
			upper => 1250000,
			lower => 1250000)
		 PORT MAP (
			clk_in => clk_in,
			clk_out => clk_out100
		 );

		 clk_11: dzielnik
		 GENERIC MAP(
			upper => 113636,
			lower => 113636)
		 PORT MAP (
			clk_in => clk_in,
			clk_out => clk_out11
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
