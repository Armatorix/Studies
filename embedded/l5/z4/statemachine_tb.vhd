LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- include also the local library for 'str' call 
USE work.txt_util.ALL;

  
ENTITY statemachine_tb IS
END statemachine_tb;
 
ARCHITECTURE behavior OF statemachine_tb IS 
    COMPONENT statemachine
    PORT(
    	 reset : IN std_logic;
         clk : IN  std_logic;
         pusher : IN  std_logic;
         r : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal pusher : std_logic := '0';

 	--Outputs
   signal r : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: statemachine PORT MAP (
   		  reset => reset,
          clk => clk,
          pusher => pusher,
          r => r
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
      pusher <= '0';
      wait for 2*clk_period;
      pusher <= '1';
      wait for 5*clk_period;
      pusher <= '0';
      wait for 5*clk_period;
      pusher <= '1';
      wait for 2*clk_period;
      reset <= '1';
      wait for 2*clk_period;
      reset <= '0';
      wait for 5*clk_period;
      pusher <= '0';      

      wait;
   end process;

END;

		
