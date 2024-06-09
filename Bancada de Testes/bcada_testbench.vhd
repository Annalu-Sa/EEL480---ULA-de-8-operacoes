--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:29:47 06/03/2024
-- Design Name:   
-- Module Name:   /home/ise/PROJETO/bcada_testbench.vhd
-- Project Name:  PROJETO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bancadatestes
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bcada_testbench IS
END bcada_testbench;
 
ARCHITECTURE behavior OF bcada_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bancadatestes
    PORT(
         entrada : IN  std_logic_vector(3 downto 0);
         resultado : OUT  std_logic_vector(7 downto 0);
         clckA : IN  std_logic;
         clckB : IN  std_logic;
         clckOP : IN  std_logic;
         clckEN : IN  std_logic;
         clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal entrada : std_logic_vector(3 downto 0) := (others => '0');
   signal clckA : std_logic := '0';
   signal clckB : std_logic := '0';
   signal clckOP : std_logic := '0';
   signal clckEN : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal resultado : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bancadatestes PORT MAP (
          entrada => entrada,
          resultado => resultado,
          clckA => clckA,
          clckB => clckB,
          clckOP => clckOP,
          clckEN => clckEN,
          clock => clock
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period;
		clock <= '1';
		wait for clock_period;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      Entrada <= "1010";	
		clckEN <= '0';
		wait for 100 ms;
		clckEN <= '1';
		wait for 700 ms;
		clckEN <= '0';	
		wait for 100 ms;
		clckA <= '1';
		wait for 700 ms;
		clckA <= '0';	

		Entrada <= "1100";	
		clckEN <= '0';
		wait for 100 ms;
		clckEN <= '1';
		wait for 700 ms;
		clckEN <= '0';	
		wait for 100 ms;
		clckB <= '1';
		wait for 700 ms;
		clckB <= '0';	
		
		Entrada <= "0000";	
		clckEN <= '0';
		wait for 100 ms;
		clckEN <= '1';
		wait for 700 ms;
		clckEN <= '0';	
		wait for 100 ms;
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0001";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0010";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0011";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0100";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0101";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0110";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		
		Entrada <= "0111";	
		clckOP <= '1';
		wait for 700 ms;
		clckOP <= '0';	
		wait for 100 ms;
		
		wait for 500 ms;
		

      -- insert stimulus here 

      wait;
   end process;

END;
