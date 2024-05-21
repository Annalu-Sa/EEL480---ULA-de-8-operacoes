--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:58:19 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/multiplexer2_4_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_multiplexer2_4
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
 
ENTITY multiplexer2_4_testbench IS
END multiplexer2_4_testbench;
 
ARCHITECTURE behavior OF multiplexer2_4_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_multiplexer2_4
    PORT(
         out_00 : IN  std_logic_vector(3 downto 0);
         out_01 : IN  std_logic_vector(1 downto 0);
         seletor : IN  std_logic;
         output_4bits : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal out_00 : std_logic_vector(3 downto 0) := (others => '0');
   signal out_01 : std_logic_vector(1 downto 0) := (others => '0');
   signal seletor : std_logic := '0';

 	--Outputs
   signal output_4bits : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_multiplexer2_4 PORT MAP (
          out_00 => out_00,
          out_01 => out_01,
          seletor => seletor,
          output_4bits => output_4bits
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		out_00 <= "0001";
		out_01 <= "10";
		wait for 100 ns;	
		seletor <= '0';
		wait for 100 ns;	
		seletor <= '1';
		wait for 100 ns;	
      
      -- insert stimulus here 

      wait;
   end process;

END;
