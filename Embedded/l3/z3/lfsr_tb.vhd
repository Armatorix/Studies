LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_textio.all;
use std.textio.all; 
 
ENTITY lfsr_tb IS
END lfsr_tb;
 
ARCHITECTURE behavior OF lfsr_tb IS 
 
    COMPONENT lfsr
    PORT(
         clk : IN  std_logic;
         q : INOUT  STD_LOGIC_VECTOR (15 downto 0)
        );
    END COMPONENT;	
    
   signal clk : std_logic := '0';

   signal qq : STD_LOGIC_VECTOR (15 downto 0) := ( others => '0');

   constant clk_period : time := 20 ns;
 
BEGIN

   uut: lfsr PORT MAP (
          clk => clk,
          q   => qq
        );
   
   clk_process :PROCESS
   BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
   END PROCESS;
   
    -- stimulating process
   stim_proc: PROCESS
   variable l : line;
   BEGIN
   	for i in 0 to 10 loop
      wait for 20*15 ns;
      write(l,to_integer(signed(qq)));
      writeline(OUTPUT, l);
      wait for 20 ns;
    end loop;
      wait;
   END PROCESS;	
END;
