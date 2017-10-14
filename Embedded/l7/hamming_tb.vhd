LIBRARY ieee;
LIBRARY std;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY hamming_tb IS
END hamming_tb;

ARCHITECTURE behavior OF hamming_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT lossy_channel
      GENERIC (N : positive);
      PORT(
         data_in : IN  std_logic_vector(N-1 downto 0);
         clk : IN  std_logic;
         data_out : OUT  std_logic_vector(N-1 downto 0)
        );
    END COMPONENT;

		COMPONENT hamming_coder
		Port (  data_in  : in   STD_LOGIC_VECTOR (3 downto 0);
						data_out : out  STD_LOGIC_VECTOR (6 downto 0);
						clk      : in   STD_LOGIC);
		END COMPONENT;

		COMPONENT hamming_decoder
		Port (  data_in  : in   STD_LOGIC_VECTOR (6 downto 0);
						data_out : out  STD_LOGIC_VECTOR (3 downto 0);
						clk      : in   STD_LOGIC);
		END COMPONENT;

   -- channel bitwidth
   constant WIDTH : positive := 14;

   signal data_coded : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
	 signal data_transported : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
   signal clk : std_logic := '0';

   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
	 signal data_out : std_logic_vector(7 downto 0) := (others => '0');

   -- clock period definitions
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)

	 uut1 :hamming_coder
	 PORT MAP (
	 				 data_in  => data_in(7 downto 4),
					 data_out => data_coded(13 downto 7),
					 clk      => clk
	 );
	 uut2 :hamming_coder
	 PORT MAP (
	 				 data_in  => data_in(3 downto 0),
					 data_out => data_coded(6 downto 0),
					 clk      => clk
	 );

	 uut3 :hamming_decoder
	 PORT MAP (
	 				 data_in  => data_transported(13 downto 7),
					 data_out => data_out(7 downto 4),
					 clk      => clk
	 );
	 uut4 :hamming_decoder
	 PORT MAP (
	 				 data_in  => data_transported(6 downto 0),
					 data_out => data_out(3 downto 0),
					 clk      => clk
	 );

   los_proc: lossy_channel
   GENERIC MAP ( N => WIDTH )
   PORT MAP (
          data_in => data_coded,
          clk => clk,
          data_out =>data_transported
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
	 variable S : string(1 to 100);
	 variable L : line;

   begin
		readline(input,L);
		assert L'length < S'length;
		S := (others => ' ');
		if L'length > 0 then
			read(L, S(1 to L'length));
		end if;
    wait for clk_period ;

		for i in S'range
		loop
			data_in <= std_logic_vector(to_unsigned(Character'pos(S(i)), data_in'length));
			wait for clk_period/2;
			S(i) := Character'val(to_integer(unsigned(data_out)));
		end loop;

		write(L,S);
		writeline(output,L);
		assert false
				report "simulation ended"
				severity failure;
   end process;

END;
