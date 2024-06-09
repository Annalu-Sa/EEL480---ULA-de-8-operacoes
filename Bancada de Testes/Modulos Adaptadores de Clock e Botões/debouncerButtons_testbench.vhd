--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:39:23 06/03/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/debouncerButtons_testbench.vhd
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
 
ENTITY debouncerButtons_testbench IS
END debouncerButtons_testbench;
 
ARCHITECTURE behavior OF debouncerButtons_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_debouncer
    PORT(
         clk : IN  std_logic;
         button_in : IN  std_logic;
         button_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal button_in : std_logic := '0';

 	--Outputs
   signal button_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_debouncer PORT MAP (
          clk => clk,
          button_in => button_in,
          button_out => button_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period;
		clk <= '1';
		wait for clk_period;
   end process;
 

  -- Stimulus process
    stim_proc: process
    begin
        button_in <= '0';
		  wait for 50ms;
		  button_in <= '1';
		  wait for 20ms;
		  button_in <= '0';
		  wait for 10ms;
		  button_in <= '0';
		  wait for 10ms;
		  button_in <= '1';
		  wait for 160ms;
		  button_in <= '0';
		  wait for 10ms;
		  button_in <= '1';
		  wait for 10ms;
		  button_in <= '0';
		  wait for 160ms;
		  button_in <= '0';
    wait;
    end process;

END;
