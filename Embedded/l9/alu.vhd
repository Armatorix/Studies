LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
--op:
-- 1- add
-- 0- sub
entity alu is
		GENERIC(NBit : Integer := 9);
    port (
				ctrl:	in  STD_LOGIC;
        op:		in  STD_LOGIC;
        a: 		in  STD_LOGIC_VECTOR(NBit-1 downto 0);
        b:		in  STD_LOGIC_VECTOR(NBit-1 downto 0);
        c: 		out STD_LOGIC_VECTOR(NBit-1 downto 0)
    );
end alu;
architecture Behavioral of alu is
begin
	alu_proc: process(ctrl)
	begin
	if ctrl = '1' then
		if op ='1' then
  		c <= std_logic_vector(unsigned(a) + unsigned(b));
		else
			c <= std_logic_vector(unsigned(a) - unsigned(b));
		end if;
	end if;
	end process;
end Behavioral;
