LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter_tb IS
END counter_tb;

ARCHITECTURE behavior OF counter_tb IS

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

		COMPONENT counter
		GENERIC ( NBit 		: 		integer := 5 );
    Port    ( ctrl 		: in  STD_LOGIC;
 	 					 mode   	: in  STD_LOGIC;
 						 inc 			: in  STD_LOGIC;
             data_bus	: inout  STD_LOGIC_VECTOR( NBit-1 downto 0) := (others => 'Z')
 				 	 );
		END COMPONENT;

   constant clk_hp 			:  time := 10 ns;
	 signal ram_mode	 		:  STD_LOGIC := '0';
	 signal ctr_inc 			:  STD_LOGIC;
	 signal ctr_mode	 		:  STD_LOGIC := '0';
	 signal ctrl_ram 			: STD_LOGIC := '0';
	 signal ctrl_ctr  		: STD_LOGIC := '0';
	 signal mem_adr				:  STD_LOGIC_VECTOR (4 downto 0);
	 signal data_bus 			: STD_LOGIC_VECTOR (8 downto 0);
BEGIN

	-- Instantiate the Unit Under Test (UUT)

   ram_unit: ram
	 PORT MAP (
	 			ctrl 				=> ctrl_ram,
				mode	 		  => ram_mode,
				mem_adr			=> mem_adr,
				data_bus  	=> data_bus
        );
	 uut : counter
	 PORT MAP (
	 			ctrl				=> ctrl_ctr,
				inc 				=> ctr_inc,
				mode	 		  => ctr_mode,
				data_bus  	=> data_bus(4 downto 0)
        );

   -- Test process
   test_proc: process
	 variable i : natural :=0;
	 variable temp : natural;
   begin
		 wait for clk_hp;
		 for i in 0 to 8 loop
			 ctr_mode <= '1';
			 ctrl_ctr <= '1';
			 wait for clk_hp;
			 mem_adr <= data_bus(4 downto 0);
			 ctrl_ctr <= '0';
			 ram_mode <= '1';
			 ctrl_ram <= '1';
			 wait for clk_hp;
			 ctrl_ram <= '0';
			 ctrl_ctr <= '1' ;
			 ctr_mode <= '0';
			 ctr_inc <= '1';
			 wait for clk_hp;
			 ctrl_ctr <= '0';
			 ctr_inc <= '0';
		 end loop;
		 wait;

   end process;

END;
