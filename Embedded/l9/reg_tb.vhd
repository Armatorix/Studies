LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY reg_tb IS
END reg_tb;

ARCHITECTURE behavior OF reg_tb IS

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

		COMPONENT mar
				GENERIC (NBit : integer := 5);
		    Port ( ctrl			: in STD_LOGIC;
							 mode 		: in STD_LOGIC;
							 data_in  : in STD_LOGIC_VECTOR (NBit-1 downto 0);
							 data_out :out STD_LOGIC_VECTOR (NBit-1 downto 0);
							 data_ram :out STD_LOGIC_VECTOR (NBit-1 downto 0)
					);
		end COMPONENT;

		COMPONENT counter
		GENERIC ( NBit 		: 		integer := 5 );
    Port    ( ctrl 		: in  STD_LOGIC;
 	 					 mode   	: in  STD_LOGIC;
 						 inc 			: in  STD_LOGIC;
             data_bus	: inout  STD_LOGIC_VECTOR( NBit-1 downto 0) := (others => 'Z')
 				 	 );
		END COMPONENT;
		COMPONENT reg
		GENERIC (NBit : integer := 9);
		Port ( ctrl			: in STD_LOGIC;
					 mode 		: in STD_LOGIC;
					 data_in  : in STD_LOGIC_VECTOR (NBit-1 downto 0);
					 data_out :out STD_LOGIC_VECTOR (NBit-1 downto 0)
		);
		END COMPONENT;


   constant clk_hp 			: time    := 10 ns;
	 constant COMPONENTS  : integer := 7;

	 constant RAM_ID			: integer := 0;
	 constant CTR_ID  		: integer := 1;
	 constant ACC_ID			: integer := 2;
	 constant MAR_ID			: integer := 3;
	 constant IN_ID 			: integer := 4;
	 constant OUT_ID			: integer := 5;
	 constant MBR_ID 			: integer := 6;
	 --constant ALU_ID					: integer := 7;


	 signal counter_inc 	: STD_LOGIC;
	 signal ram_ptr 			: STD_LOGIC_VECTOR (4 downto 0);
	 signal data_bus 			: STD_LOGIC_VECTOR (8 downto 0);
	 signal mbr_to_alu    : STD_LOGIC_VECTOR (8 downto 0);
	 signal ctrl_bus			: STD_LOGIC_VECTOR (COMPONENTS-1 downto 0);
	 signal mode_bus 			: STD_LOGIC_VECTOR (COMPONENTS-1 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)

   ram_u1: ram
	 PORT MAP (
	 			ctrl 				=> ctrl_bus(RAM_ID),
				mode	 		  => mode_bus(RAM_ID),
				mem_adr			=> ram_ptr,
				data_bus  	=> data_bus
        );

	 pc : counter
	 PORT MAP (
	 			ctrl				=> ctrl_bus(CTR_ID),
				inc 				=> counter_inc,
				mode	 		  => mode_bus(CTR_ID),
				data_bus  	=> data_bus(4 downto 0)
        );

	 mar1 : mar
	 PORT MAP  (
	 				ctrl		=> ctrl_bus(MAR_ID),
					mode 		=> mode_bus(MAR_ID),
					data_in => data_bus(4 downto 0),
					data_out=> data_bus(4 downto 0),
					data_ram=> ram_ptr
	 				);

	 mbr1 : mar
	 GENERIC MAP(NBit => 9)
	 PORT MAP  (
				ctrl		=> ctrl_bus(MBR_ID),
				mode 		=> mode_bus(MBR_ID),
				data_in => data_bus,
				data_out=> data_bus,
				data_ram=> mbr_to_alu
				);

	 acc1 : reg
	 GENERIC MAP(NBit => 9)
	 PORT MAP  (
	 				ctrl		=> ctrl_bus(ACC_ID),
					mode 		=> mode_bus(ACC_ID),
					data_in => data_bus,
					data_out=> data_bus
	 				);
	 in1 : reg
	 GENERIC MAP(NBit => 9)
	 PORT MAP  (
	 				ctrl		=> ctrl_bus(IN_ID),
					mode 		=> mode_bus(IN_ID),
					data_in => data_bus,
					data_out=> data_bus
					);
	out1 : reg
	GENERIC MAP(NBit => 9)
	PORT MAP  (
					ctrl		=> ctrl_bus(OUT_ID),
					mode 		=> mode_bus(OUT_ID),
					data_in => data_bus,
					data_out=> data_bus
					);




   -- Test process
   test_proc: process
	 variable i : natural :=0;
	 variable temp : natural;
   begin
		 wait for clk_hp;

		 --save to MAR 0
		 data_bus <= (others => '0');
		 mode_bus(MAR_ID) <= '0';
		 ctrl_bus(MAR_ID) <= '1';
		 wait for clk_hp;
		 data_bus <= (others => 'Z');
		 ctrl_bus(MAR_ID) <= '0';

		 --read value from RAM(MAR)
		 mode_bus(RAM_ID) <= '1';
		 ctrl_bus(RAM_ID) <= '1';
		 wait for clk_hp;

		 --save data from bus to ACC
		 mode_bus(ACC_ID) <= '0';
		 ctrl_bus(ACC_ID) <= '1';
		 wait for clk_hp;
		 mode_bus(RAM_ID) <= '0';
		 ctrl_bus(RAM_ID) <= '0';
		 ctrl_bus(ACC_ID) <= '0';
		 wait for clk_hp;

		 for i in 0 to 1 loop
			 --increment PC
			 mode_bus(CTR_ID) <= '0';
			 counter_inc 			<= '1';
			 ctrl_bus(CTR_ID) <= '1';
			 wait for clk_hp;
			 counter_inc		  <= '0';
			 ctrl_bus(CTR_ID) <= '0';
			 wait for clk_hp;
			 -- PC to MAR
			 mode_bus(CTR_ID) <= '1';
			 ctrl_bus(CTR_ID) <= '1';
			 ctrl_bus(MAR_ID) <= '1';
			 wait for clk_hp;
			 ctrl_bus(CTR_ID) <= '0';
			 ctrl_bus(MAR_ID) <= '0';

			 --read value from RAM(MAR)
			 mode_bus(RAM_ID) <= '1';
			 ctrl_bus(RAM_ID) <= '1';
			 wait for clk_hp;
			 ctrl_bus(RAM_ID) <= '0';
		 end loop ;
		 -- put value from ACC on bus
		 mode_bus(ACC_ID) <= '1';
		 ctrl_bus(ACC_ID) <= '1';
		 wait for clk_hp;
		 wait;
   end process;

END;
