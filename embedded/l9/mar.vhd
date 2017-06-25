library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--	mode :
-- 	1- read
--  0- write
entity mar is
		GENERIC (NBit : integer := 5);
    Port ( ctrl			: in STD_LOGIC;
					 mode 		: in STD_LOGIC;
					 data_in  : in STD_LOGIC_VECTOR (NBit-1 downto 0);
					 data_out :out STD_LOGIC_VECTOR (NBit-1 downto 0);
					 data_ram :out STD_LOGIC_VECTOR (NBit-1 downto 0)
			);
end mar;

architecture Behavioral of mar is
	signal stored_data : STD_LOGIC_VECTOR(NBit-1 downto 0);
begin
	reg_process: process (ctrl)
		begin
			if ctrl = '1' and mode = '0' then
				stored_data <= data_in;
			end if;
		end process;
		data_out <= stored_data when ctrl='1' and mode ='1' else (others => 'Z');

	ram_out_proc: process (stored_data)
	begin
		data_ram <= stored_data;
	end process;
end Behavioral;
