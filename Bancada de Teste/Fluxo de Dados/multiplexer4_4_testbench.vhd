--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:54:44 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/multiplexer4_4_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_multiplexer4_4
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
 
ENTITY multiplexer4_4_testbench IS
END multiplexer4_4_testbench;
 
ARCHITECTURE behavior OF multiplexer4_4_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_multiplexer4_4
    PORT(
         out_00 : IN  std_logic_vector(3 downto 0);
         out_01 : IN  std_logic_vector(3 downto 0);
         out_10 : IN  std_logic_vector(2 downto 0);
         out_11 : IN  std_logic_vector(3 downto 0);
         seletor : IN  std_logic_vector(1 downto 0);
         output_4bits : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal out_00 : std_logic_vector(3 downto 0) := (others => '0');
   signal out_01 : std_logic_vector(3 downto 0) := (others => '0');
   signal out_10 : std_logic_vector(2 downto 0) := (others => '0');
   signal out_11 : std_logic_vector(3 downto 0) := (others => '0');
   signal seletor : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal output_4bits : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_multiplexer4_4 PORT MAP (
          out_00 => out_00,
          out_01 => out_01,
          out_10 => out_10,
          out_11 => out_11,
          seletor => seletor,
          output_4bits => output_4bits
        );

 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      out_00 <= "0001";
		out_01 <= "0010";
		out_10 <= "011"; 
		out_11 <= "0100";
		wait for 100 ns;	
		seletor <= "00";
		wait for 100 ns;	
		seletor <= "01";
		wait for 100 ns;	
		seletor <= "10";
		wait for 100 ns;	
		seletor <= "11";
		wait for 100 ns;	
		
      wait;
   end process;

END;
