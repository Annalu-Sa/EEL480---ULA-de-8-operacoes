--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:42:54 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/bancadatestes_testbench.vhd
-- Project Name:  Projeto_ULA
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
 
ENTITY bancadatestes_testbench IS
END bancadatestes_testbench;
 
ARCHITECTURE behavior OF bancadatestes_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bancadatestes
    PORT(
         entrada : IN  std_logic_vector(3 downto 0);
         resultado : OUT  std_logic_vector(7 downto 0);
         botao1 : IN  std_logic;
         botao2 : IN  std_logic;
         botao3 : IN  std_logic;
         botao4 : IN  std_logic;
         clock : IN  std_logic;
         clock_de_subida_dividido : OUT  std_logic_vector(25 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal entrada : std_logic_vector(3 downto 0) := (others => '0');
   signal botao1 : std_logic := '0';
   signal botao2 : std_logic := '0';
   signal botao3 : std_logic := '0';
   signal botao4 : std_logic := '0';
   signal clock : std_logic := '0';

 	--Outputs
   signal resultado : std_logic_vector(7 downto 0);
   signal clock_de_subida_dividido : std_logic_vector(25 downto 0);

   -- Clock period definitions
   constant clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bancadatestes PORT MAP (
          entrada => entrada,
          resultado => resultado,
          botao1 => botao1,
          botao2 => botao2,
          botao3 => botao3,
          botao4 => botao4,
          clock => clock,
          clock_de_subida_dividido => clock_de_subida_dividido
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
      Entrada <= "0110";	
		botao4 <= '0';
		wait for 100 ms;
		botao4 <= '1';
		wait for 700 ms;
		botao4 <= '0';	
		wait for 100 ms;
		botao1 <= '1';
		wait for 700 ms;
		botao1 <= '0';	
		wait for 100 ms;

		Entrada <= "0100";	
		botao4 <= '0';
		wait for 100 ms;
		botao4 <= '1';
		wait for 700 ms;
		botao4 <= '0';	
		wait for 100 ms;
		botao2 <= '1';
		wait for 700 ms;
		botao2 <= '0';	
		wait for 100 ms;

		Entrada <= "0000";	
		botao4 <= '0';
		wait for 100 ms;
		botao4 <= '1';
		wait for 700 ms;
		botao4 <= '0';	
		wait for 100 ms;
		botao3 <= '1';
		wait for 700 ms;
		botao3 <= '0';	
		wait for 100 ms;

      -- insert stimulus here 

      wait;
   end process;

END;
