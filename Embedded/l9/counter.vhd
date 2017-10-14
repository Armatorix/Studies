library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

--mode:
--1 - read
--0 - write
entity counter is
	 GENERIC ( NBit 		: 		integer := 9 );
   Port    ( ctrl 		: in  STD_LOGIC;
	 					 mode   	: in  STD_LOGIC;
						 inc 			: in  STD_LOGIC;
             data_bus	: inout  STD_LOGIC_VECTOR( NBit-1 downto 0)
				 	 );
end counter;

architecture counter_arch of counter is
  signal pc : unsigned(NBit-1 downto 0) := (others => '0');
BEGIN
  PROCESS(ctrl)
  BEGIN
		if ctrl = '1' and mode ='0' then
			if inc = '1' then
				pc <= pc + 1;
			else
				pc <= unsigned(data_bus);
			end if;
		end if;
  END PROCESS;
	data_bus <= STD_LOGIC_VECTOR(pc) when ctrl='1' and mode ='1'  else (others => 'Z');
END counter_arch;
