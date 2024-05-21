LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY modulo_multiplexer4_4 IS
PORT(
	 out_00 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
	 out_01 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
	 out_10 : IN STD_LOGIC_VECTOR( 2 DOWNTO 0);
	 out_11 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
    seletor : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
    output_4bits : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0) 
    );
END modulo_multiplexer4_4;
ARCHITECTURE behavioral OF modulo_multiplexer4_4 IS
BEGIN


PROCESS(out_00,out_01,out_10,out_11,seletor) 
BEGIN
CASE seletor IS
    WHEN "00" => output_4bits <= out_00;
    WHEN "01" => output_4bits <= out_01;
    WHEN "10" => output_4bits(2 DOWNTO 0) <= out_10; output_4bits(3) <= '0';
    WHEN OTHERS => output_4bits <= out_11;
	 END CASE;
END PROCESS;

END behavioral;