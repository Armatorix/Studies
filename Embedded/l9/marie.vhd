LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY marie IS
END marie;

ARCHITECTURE behavior OF marie IS

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

		COMPONENT alu
		GENERIC(NBit : Integer := 9);
		port (
		    		ctrl:	in  STD_LOGIC;
		        op:		in  STD_LOGIC;
		        a: 		in  STD_LOGIC_VECTOR(NBit-1 downto 0);
		        b:		in  STD_LOGIC_VECTOR(NBit-1 downto 0);
		        c: 		out STD_LOGIC_VECTOR(NBit-1 downto 0)
		    );
		END COMPONENT;

		COMPONENT controller
		GENERIC(ControllLines : integer := 10;
						ModeLines 		:	integer := 9);
		port(
						data_bus  : inout 	std_logic_vector (8 downto 0);
						ctrl_bus	: out std_logic_vector (ControllLines-1 downto 0);
						mode_bus  : out std_logic_vector (ModeLines-1 downto 0)
	);
		END COMPONENT;

   constant clk_hp 			: time    := 10 ns;
	 constant COMPONENTS  : integer := 9;

	 	constant RAM_ID			: integer := 0;
	 	constant PC_ID  		: integer := 1;
	 	constant ACC_ID			: integer := 2;
	 	constant MAR_ID			: integer := 3;
	 	constant IN_ID 			: integer := 4;
	 	constant OUT_ID			: integer := 5;
	 	constant MBR_ID 		: integer := 6;
	 	constant ALU_ID			: integer := 7;
	 	constant PC_INC    	: integer := 8;


	 signal counter_inc 	: STD_LOGIC;
	 signal ram_ptr 			: STD_LOGIC_VECTOR (4 downto 0);
	 signal data_bus 			: STD_LOGIC_VECTOR (8 downto 0);
	 signal mbr_to_alu    : STD_LOGIC_VECTOR (8 downto 0);
	 signal acc_to_alu 		: STD_LOGIC_VECTOR (8 downto 0);
	 signal ctrl_bus			: STD_LOGIC_VECTOR (COMPONENTS downto 0);
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
	 			ctrl				=> ctrl_bus(PC_ID),
				inc 				=> ctrl_bus(PC_INC),
				mode	 		  => mode_bus(PC_ID),
				data_bus  	=> data_bus(4 downto 0)
        );

	 alu1 :alu
	 PORT MAP (
						 ctrl =>	ctrl_bus(ALU_ID),
						 op		=>	mode_bus(ALU_ID),
						 a 		=>	acc_to_alu,
						 b		=>	mbr_to_alu,
						 c 		=>	data_bus
	 );

	 mar1 : mar
	 PORT MAP  (
	 				ctrl			=> ctrl_bus(MAR_ID),
					mode 			=> mode_bus(MAR_ID),
					data_in 	=> data_bus(4 downto 0),
					data_out	=> data_bus(4 downto 0),
					data_ram	=> ram_ptr
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

	 acc1 : mar
	 GENERIC MAP(NBit => 9)
	 PORT MAP  (
				ctrl		=> ctrl_bus(ACC_ID),
				mode 		=> mode_bus(ACC_ID),
				data_in => data_bus,
				data_out=> data_bus,
				data_ram=> acc_to_alu
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
	ctrler : controller
	PORT MAP (
					data_bus  => data_bus,
					mode_bus  => mode_bus,
					ctrl_bus	=> ctrl_bus
	);




   -- Test process
   test_proc: process
	 begin
		 wait for clk_hp;
		 wait;
   end process;

END;
