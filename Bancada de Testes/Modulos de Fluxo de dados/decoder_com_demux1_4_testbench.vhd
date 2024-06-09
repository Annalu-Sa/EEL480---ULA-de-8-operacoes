--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:01:32 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/decoder_com_demux1_4_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_decoder_com_demux1_4
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
 
ENTITY decoder_com_demux1_4_testbench IS
END decoder_com_demux1_4_testbench;
 
ARCHITECTURE behavior OF decoder_com_demux1_4_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_decoder_com_demux1_4
    PORT(
         input_1bit : IN  std_logic;
         seletor : IN  std_logic_vector(1 downto 0);
         out_01 : OUT  std_logic;
         out_10 : OUT  std_logic;
         out_11 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input_1bit : std_logic := '0';
   signal seletor : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal out_01 : std_logic;
   signal out_10 : std_logic;
   signal out_11 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_decoder_com_demux1_4 PORT MAP (
          input_1bit => input_1bit,
          seletor => seletor,
          out_01 => out_01,
          out_10 => out_10,
          out_11 => out_11
        );
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	
		input_1bit <= '1';
		wait for 100 ns;
		seletor <= "00";
		wait for 100 ns;
		seletor <= "01";
		wait for 100 ns;
		seletor <= "10";
		wait for 100 ns;
		seletor <= "11";
      wait;
   end process;

END;
