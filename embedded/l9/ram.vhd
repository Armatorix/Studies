		library IEEE;
		use IEEE.STD_LOGIC_1164.ALL;
		use ieee.numeric_std.all;
		library std;
		use std.textio.all;  --include package textio.vhd
--	mode :
-- 	1- read
--  0- write
entity ram is
		GENERIC (NBit : integer := 9);
    Port ( ctrl			: in STD_LOGIC;
					 mode 		: in STD_LOGIC;
					 mem_adr	: in STD_LOGIC_VECTOR (4 downto 0);
					 data_bus : inout  STD_LOGIC_VECTOR (NBit-1 downto 0)
			);
end ram;

architecture Behavioral of ram is
	constant data_capacity : integer := 32;
	type data_type is array (data_capacity-1 downto 0) of STD_LOGIC_VECTOR (NBit-1 downto 0);
	shared variable stored_data : data_type;
begin
	ram_process: process (ctrl)
		begin
			if ctrl ='1' and mode = '0' then
				stored_data(to_integer(unsigned(mem_adr))) := data_bus;
			end if;
		end process;

data_bus <= stored_data(to_integer(unsigned(mem_adr))) when ctrl='1' and mode ='1'  else (others => 'Z');

	  reading: process
			file file_pointer : text;
			variable line_content : string(NBit-1 downto 0);
			variable line_num : line;
			variable i : integer := 0;
			variable j : integer;
			variable temp : std_logic_vector(NBit-1 downto 0);

		 	begin
	      file_open(file_pointer,"instructions",READ_MODE);
	      while not endfile(file_pointer) loop
		      readline (file_pointer,line_num);
		      read(line_num,line_content);
					--report "The value is " & line_content & " at " & integer'image(i);
					for j in line_content'range loop
			        if (character'pos(line_content(j)) = character'pos('1')) then
								temp(j) := '1';
							else
								temp(j) := '0';
							end if;
			    end loop;
					stored_data(i) := temp;
					--report "The value is " & line_content & " is " & integer'image(to_integer(unsigned(temp)));
					i := i+1;
	      end loop;
	      file_close(file_pointer);  --after reading all the lines close the file.
				while i< data_capacity loop
					stored_data(i) := (others => '0');
					i := i+1;
				end loop;
	      wait;
	    end process reading;
end Behavioral;
