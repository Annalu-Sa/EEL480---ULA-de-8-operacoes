--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:18:18 05/21/2024
-- Design Name:   
-- Module Name:   /home/ise/Projeto_ULA/ula_testbench.vhd
-- Project Name:  Projeto_ULA
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: modulo_ula
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
 
ENTITY ula_testbench IS
END ula_testbench;
 
ARCHITECTURE behavior OF ula_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT modulo_ula
    PORT(
         a_in : IN  std_logic_vector(3 downto 0);
         b_in : IN  std_logic_vector(3 downto 0);
         op_in : IN  std_logic_vector(2 downto 0);
         result_out : OUT  std_logic_vector(3 downto 0);
         flags_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a_in : std_logic_vector(3 downto 0) := (others => '0');
   signal b_in : std_logic_vector(3 downto 0) := (others => '0');
   signal op_in : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result_out : std_logic_vector(3 downto 0);
   signal flags_out : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: modulo_ula PORT MAP (
          a_in => a_in,
          b_in => b_in,
          op_in => op_in,
          result_out => result_out,
          flags_out => flags_out
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		-- teste da operacao soma
		a_in <= "0110";
		b_in <= "0010";
		op_in <= "000";
		wait for 100 ns;
		-- teste da operacao subtracao
		wait for 100 ns;	
		a_in <= "0011";
		b_in <= "0010";
		op_in <= "001";
		wait for 100 ns;
		-- teste da operacao and
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "010";
		wait for 100 ns;
		-- teste da operacao nand
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "011";
		wait for 100 ns;
		-- teste da operacao or
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "100";
		wait for 100 ns;
		-- teste da operacao nor
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "101";
		wait for 100 ns;
		-- teste da operacao xor
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "110";
		wait for 100 ns;
		-- teste da operacao xnor
		wait for 100 ns;	
		a_in <= "1010";
		b_in <= "1100";
		op_in <= "111";
		wait for 100 ns;
		-- teste da flag zero
		wait for 100 ns;	
		a_in <= "0000";
		b_in <= "0000";
		op_in <= "000";
		wait for 100 ns;
		-- teste da flag negativo
		wait for 100 ns;	
		a_in <= "1000";
		b_in <= "1001";
		op_in <= "001";
		wait for 100 ns;
		-- teste da flag overflow
		wait for 100 ns;	
		a_in <= "1111";
		b_in <= "1111";
		op_in <= "000";
		wait for 100 ns;
		-- teste da flag overflow negativo
		wait for 100 ns;	
		a_in <= "0000";
		b_in <= "0001";
		op_in <= "001";
		wait for 100 ns;
		-- teste da flag carry out
      wait for 100 ns;	
		a_in <= "1000";
		b_in <= "1000";
		op_in <= "000";
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
