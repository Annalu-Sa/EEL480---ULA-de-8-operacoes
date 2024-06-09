--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:08:38 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/divide_clock_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_divisor_de_clock
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
 
ENTITY divide_clock_testbench IS
END divide_clock_testbench;
 
ARCHITECTURE behavior OF divide_clock_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_divisor_de_clock
    PORT(
         clock : IN  std_logic;
         clock_dividido : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';

 	--Outputs
   signal clock_dividido : std_logic;

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_divisor_de_clock PORT MAP (
          clock => clock,
          clock_dividido => clock_dividido
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
	wait for 100 ns;
 	 wait for clock_period*20;
	
      -- insert stimulus here 

      wait;
   end process;

END;
