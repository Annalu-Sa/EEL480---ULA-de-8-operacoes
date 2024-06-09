--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:41:56 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/registrador_4bits_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_registrador4bits
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
 
ENTITY registrador_4bits_testbench IS
END registrador_4bits_testbench;
 
ARCHITECTURE behavior OF registrador_4bits_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_registrador4bits
    PORT(
         clock : IN  std_logic;
         dado_de_entrada : IN  std_logic_vector(3 downto 0);
         enable : IN  std_logic;
         dado_de_saida : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal dado_de_entrada : std_logic_vector(3 downto 0) := (others => '0');
   signal enable : std_logic := '0';

 	--Outputs
   signal dado_de_saida : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_registrador4bits PORT MAP (
          clock => clock,
          dado_de_entrada => dado_de_entrada,
          enable => enable,
          dado_de_saida => dado_de_saida
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		enable <= '0';
		dado_de_entrada <= "0101";
		wait for 100 ns;	
		enable <= '1';
		dado_de_entrada <= "0101";
      

      -- insert stimulus here 

      wait;
   end process;

END;
