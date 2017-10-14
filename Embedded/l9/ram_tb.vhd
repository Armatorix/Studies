LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ram_tb IS
END ram_tb;

ARCHITECTURE behavior OF ram_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT ram
		GENERIC (NBit : integer := 9);

	 	 Port(
		 			ctrl 			: in STD_LOGIC ;
		 			mode	 		: in STD_LOGIC ;
 					mem_adr		: in STD_LOGIC_VECTOR (4 downto 0) ;
 					data_bus  	: inout  STD_LOGIC_VECTOR (NBit-1 downto 0)
 		 );
    END COMPONENT;

	 signal ctrl 			:  STD_LOGIC := '0';
	 signal mode	 		:  STD_LOGIC := '1';
	 signal mem_adr		:  STD_LOGIC_VECTOR (4 downto 0):= (others => 'Z');
	 signal data_bus 	:  STD_LOGIC_VECTOR (8 downto 0):= (others => 'Z');
BEGIN

	-- Instantiate the Unit Under Test (UUT)

   uut: ram
	 PORT MAP (
	 			ctrl 				=> ctrl,
				mode	 		  => mode,
				mem_adr			=> mem_adr,
				data_bus 		=> data_bus
        );


   -- Test process
   test_proc: process
	 variable i : natural :=0;
	 variable temp : natural;
   begin

		wait for 10 ns;
		mode <= '1';
		mem_adr <= (others => '0');
		ctrl <= '1';
		wait for 10 ns;
		for i in 0 to 9 loop
			ctrl <= '0';
			wait for 10 ns;
			ctrl <= '1';
			mem_adr <= std_logic_vector(to_unsigned(i, mem_adr'length));
			wait for 10 ns;
		end loop;

		mode <= '0';
		for i in 0 to 31 loop
			ctrl <= '0';
			wait for 10 ns;
			ctrl <= '1';
			mem_adr <= std_logic_vector(to_unsigned(i, mem_adr'length));
			data_bus <= std_logic_vector(to_unsigned(i, data_bus'length));
			wait for 10 ns;
		end loop;
		wait for 10 ns;

		data_bus <= (others => 'Z');
		mode <= '1';
		for i in 0 to 31 loop
			ctrl <= '0';
			wait for 10 ns;
			ctrl <= '1';
			mem_adr <= std_logic_vector(to_unsigned(i, mem_adr'length));
			wait for 10 ns;
		end loop;
		wait;
   end process;

END behavior;
