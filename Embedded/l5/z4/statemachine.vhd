
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity statemachine is
  port(
  	reset:   in std_logic;
	clk:     in std_logic;
	pusher:  in std_logic;
	r : out std_logic := '0'
  );
  
end statemachine;

architecture Flow of statemachine is
  type stan is (A, B, C, D);
  signal stan_teraz : stan := A;
  signal stan_potem : stan := A;
begin

state_advance: process(clk, reset)
begin
	if reset = '1' then
		stan_teraz <= A;	
	elsif rising_edge(clk) then
		stan_teraz <= stan_potem;
	end if;
end process;

next_state: process(stan_teraz)
begin
   stan_potem <= stan_teraz;
   case stan_teraz is
     when A => 
				if pusher='1' then stan_potem <= B; end if;
	  when B => 
				if pusher='1' then stan_potem <= C; end if;
	  when C => 
				if pusher='1' then stan_potem <= D; end if;			
	  when D => 
				if pusher='1' then stan_potem <= B; else 
				 				   stan_potem <= A; end if;			
   end case;
end process;

r <= '1' when stan_teraz=D else '0';

end Flow;

