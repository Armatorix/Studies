
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	GENERIC(ControllLines : integer := 10;
					ModeLines 		:	integer := 9);
	port(
	data_bus  : inout 	std_logic_vector (8 downto 0);
	ctrl_bus	: out std_logic_vector (ControllLines-1 downto 0); -- +counter int,
	mode_bus  : out std_logic_vector (ModeLines-1 downto 0)
);
end controller;

architecture Flow of controller is
  type stan is (Fetch, Decode, Execute, Endless);
  signal stan_teraz : stan := Fetch;
	signal stan_potem : stan := Decode;
	signal op : std_logic_vector(3 downto 0);
	signal addr : std_logic_vector(4 downto 0);
	signal clk : STD_LOGIC := '1';

	constant clk_period : time := 10 ns;
	constant RAM_ID			: integer := 0;
	constant PC_ID  		: integer := 1;
	constant ACC_ID			: integer := 2;
	constant MAR_ID			: integer := 3;
	constant IN_ID 			: integer := 4;
	constant OUT_ID			: integer := 5;
	constant MBR_ID 		: integer := 6;
	constant ALU_ID			: integer := 7;
	constant PC_INC    : integer := 8;

begin

ctrl_process: process
begin
		case stan_teraz is
     	when Fetch =>
				stan_potem <= Decode;
				-- PC -> MAR
				mode_bus(PC_ID)  <= '1';
				ctrl_bus(PC_ID)  <= '1';
				mode_bus(MAR_ID) <= '0';
				ctrl_bus(MAR_ID) <= '1';
				wait for clk_period;
				ctrl_bus(MAR_ID) <= '0';
				ctrl_bus(PC_ID)  <= '0';
				wait for clk_period;

				-- PC ++
				ctrl_bus(PC_ID)  <= '1';
				ctrl_bus(PC_INC) <= '1';
				mode_bus(PC_ID)  <= '0';
				wait for clk_period;
				ctrl_bus(PC_ID)  <= '0';
				ctrl_bus(PC_INC) <= '0';

				-- RAM -> MBR
				ctrl_bus(RAM_ID) <= '1';
				ctrl_bus(MBR_ID) <= '1';
				mode_bus(RAM_ID) <= '1';
				mode_bus(MBR_ID) <= '0';
				wait for clk_period;

			when Decode =>
	 			stan_potem <= Execute;
				-- OP <- MBR(8 to 5)
				op 	 <= data_bus(8 downto 5);
				addr <= data_bus(4 downto 0);
				wait for clk_period;
				ctrl_bus(RAM_ID) <= '0';
				ctrl_bus(MBR_ID) <= '0';
				wait for clk_period;
	 	  when Execute =>
				stan_potem <= Fetch;
				if op = "0001" then --LOAD
						report "Load";
						-- MAR <- X
						mode_bus(MAR_ID) <= '0';
						ctrl_bus(MAR_ID) <= '1';
						data_bus(4 downto 0) <= addr;
						wait for clk_period;
						ctrl_bus(MAR_ID) <= '0';
						data_bus(4 downto 0) <= (others => 'Z');
						wait for clk_period;

						-- MBR <- M[MAR]
						mode_bus(RAM_ID) <= '1';
						mode_bus(MBR_ID) <= '0';
						ctrl_bus(RAM_ID) <= '1';
						ctrl_bus(MBR_ID) <= '1';
						wait for clk_period;

						-- AC <- MBR
						ctrl_bus(ACC_ID) <= '1';
						mode_bus(ACC_ID) <= '0';
						wait for clk_period;
						ctrl_bus(RAM_ID) <= '0';
						ctrl_bus(MBR_ID) <= '0';
						ctrl_bus(ACC_ID) <= '0';
						wait for clk_period;
					elsif op = "0010" then--Store
						report "Store";
						-- MAR <- X,
						mode_bus(MAR_ID) <= '0';
						ctrl_bus(MAR_ID) <= '1';
						data_bus(4 downto 0) <= addr;
						wait for clk_period;
						ctrl_bus(MAR_ID) <= '0';
						data_bus(4 downto 0) <= (others => 'Z');
						wait for clk_period;
						-- MBR <- AC
						mode_bus(ACC_ID) <= '1';
						mode_bus(MBR_ID) <= '0';
						ctrl_bus(ACC_ID) <= '1';
						ctrl_bus(MBR_ID) <= '1';
						wait for clk_period;
						ctrl_bus(ACC_ID) <= '0';
						ctrl_bus(MBR_ID) <= '0';
						-- M[MAR] <- MBR
						mode_bus(RAM_ID) <= '0';
						mode_bus(MBR_ID) <= '1';
						ctrl_bus(RAM_ID) <= '1';
						ctrl_bus(MBR_ID) <= '1';
						wait for clk_period;
						ctrl_bus(RAM_ID) <= '0';
						ctrl_bus(MBR_ID) <= '0';
					elsif op = "0011" then--Add
						report "add";
						-- MAR <- X,
						mode_bus(MAR_ID) <= '0';
						ctrl_bus(MAR_ID) <= '1';
						data_bus(4 downto 0) <= addr;
						wait for clk_period;
						ctrl_bus(MAR_ID) <= '0';
						data_bus(4 downto 0) <= (others => 'Z');
						wait for clk_period;
						-- MBR <- M[MAR]
						mode_bus(RAM_ID) <= '1';
						mode_bus(MBR_ID) <= '0';
						ctrl_bus(RAM_ID) <= '1';
						ctrl_bus(MBR_ID) <= '1';
						wait for clk_period;
						ctrl_bus(RAM_ID) <= '0';
						ctrl_bus(MBR_ID) <= '0';
						--
						--TODO: SUMA!!!!
						mode_bus(ALU_ID) <= '1';
						ctrl_bus(ALU_ID) <= '1';
						mode_bus(ACC_ID) <= '0';
						ctrl_bus(ACC_ID) <= '1';
						wait for clk_period;
						ctrl_bus(ALU_ID) <= '0';
						ctrl_bus(ACC_ID) <= '0';
					elsif op = "0100" then --Subt
						report "Sub";
						-- MAR <- X,
						mode_bus(MAR_ID) <= '0';
						ctrl_bus(MAR_ID) <= '1';
						data_bus(4 downto 0) <= addr;
						wait for clk_period;
						ctrl_bus(MAR_ID) <= '0';
						data_bus(4 downto 0) <= (others => 'Z');
						wait for clk_period;
						-- MBR <- M[MAR]
						mode_bus(RAM_ID) <= '1';
						mode_bus(MBR_ID) <= '0';
						ctrl_bus(RAM_ID) <= '1';
						ctrl_bus(MBR_ID) <= '1';
						wait for clk_period;
						ctrl_bus(RAM_ID) <= '0';
						ctrl_bus(MBR_ID) <= '0';
						--
						-- AC <- AC - MBR
						mode_bus(ALU_ID) <= '0';
						ctrl_bus(ALU_ID) <= '1';
						mode_bus(ACC_ID) <= '0';
						ctrl_bus(ACC_ID) <= '1';
						wait for clk_period;
						ctrl_bus(ALU_ID) <= '0';
						ctrl_bus(ACC_ID) <= '0';
					elsif op = "0101" then --Input
						-- AC -> InREG
						report "input";
						mode_bus(ACC_ID) <= '1';
						mode_bus(IN_ID)  <= '0';
						ctrl_bus(ACC_ID) <= '1';
						ctrl_bus(IN_ID)  <= '1';
						wait for clk_period;
						ctrl_bus(ACC_ID) <= '0';
						ctrl_bus(IN_ID)  <= '0';
					elsif op = "0110" then
						-- OutREG -> AC
						report "Output";
						mode_bus(ACC_ID) <= '1';
						mode_bus(OUT_ID) <= '0';
						ctrl_bus(ACC_ID) <= '1';
						ctrl_bus(OUT_ID) <= '1';
						wait for clk_period;
						ctrl_bus(ACC_ID) <= '0';
						ctrl_bus(OUT_ID) <= '0';
						--Halt
					elsif op = "0111" then
						report "Halt";
						stan_potem <= Endless;
						--Jump X
					elsif op = "1000" then
						report "Jump";
						ctrl_bus(PC_ID)  <= '1';
						ctrl_bus(PC_INC) <= '1';
						mode_bus(PC_ID)  <= '0';
						wait for clk_period;
						ctrl_bus(PC_ID)  <= '0';
						ctrl_bus(PC_INC) <= '0';
				end if;
			when Endless =>
				wait for clk_period;
				stan_potem <= Endless;

		end case;
		stan_teraz <= stan_potem;
end process;

end Flow;
