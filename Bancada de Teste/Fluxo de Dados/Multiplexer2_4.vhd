--LIBRARY declarations.
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Multiplexador utilizado para alternar os valores junto ao contador 
-- Com este modulo somos capazes de levar os sinais de cada um dos modulos
-- para a saida resultante da bancada de testes.

-- Neste multiplexador de 2 entradas de 4 bits, temos um seletor responsavel 
-- por mostrar o enable ativo no momento e tambem as flags, alternadamente.

ENTITY modulo_multiplexer2_4 IS
PORT(
	 out_00 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
	 out_01 : IN STD_LOGIC_VECTOR( 1 DOWNTO 0);
    seletor : IN STD_LOGIC;  
    output_4bits : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0)  
    );
END modulo_multiplexer2_4;

ARCHITECTURE behavioral OF modulo_multiplexer2_4 IS
BEGIN
-- Em um processo sensivel ao seletor e as saidas realizamos a seguinte logica. 
PROCESS(out_00,out_01,seletor) 
BEGIN
CASE seletor IS
-- Quando o seletor for '0', teremos como saida out_00, entretanto 
-- quando o seletor recebe '1', teremos como saida out_01, como esta possui apenas 
-- 2 bits, colocamos zero nos bits remanescentes para evitar erros. 
    WHEN '0' => output_4bits <= out_00;
    WHEN OTHERS => output_4bits(1 DOWNTO 0) <= out_01; output_4bits(2) <= '0'; output_4bits(3) <= '0';
END CASE;
END PROCESS;

END behavioral;