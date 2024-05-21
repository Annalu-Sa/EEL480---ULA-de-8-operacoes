--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:48:34 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/debouncer_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_debouncer
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
 
ENTITY debouncer_testbench IS
END debouncer_testbench;
 
ARCHITECTURE behavior OF debouncer_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_debouncer
    PORT(
         input : IN  std_logic;
         clock : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_debouncer PORT MAP (
          input => input,
          clock => clock,
          output => output
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
		input <= '1';
		wait for 10 ns;	
		input <= '0';
		wait for 10 ns;	
		input <= '1';
		wait for 10 ns;	
		input <= '1';
		wait for 10 ns;	
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;	
		input <= '0';
		wait for 10 ns;	
		input <= '1';
		wait for 10 ns;	
		input <= '0';
		wait for 10 ns;	
		input <= '0';
		wait for 10 ns;	
		input <= '0';
		wait for 10 ns;	
		input <= '0';
      

      -- insert stimulus here 

      wait;
   end process;

END;
