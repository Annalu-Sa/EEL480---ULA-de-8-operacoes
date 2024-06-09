LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- A configuracao do registrador de 4 bits e extremamente semelhante ao registradore de 3 bits 
-- A unica alteracao que foi feita foram os tamanhos dos vetores 

-- Este registrador foi feito especificamente para a entrada (op_in) que possui apenas 3 bits
-- Portanto seu registrador respectivo tambem precisa ter o mesmo tamanho, causando a necessidade
-- deste. 
ENTITY modulo_registrador3bits IS
    PORT (
        clock : IN STD_LOGIC;
        dado_de_entrada : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        enable          : IN STD_LOGIC;
        dado_de_saida   : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END ENTITY modulo_registrador3bits;

ARCHITECTURE behavioral OF modulo_registrador3bits IS
		SIGNAL registrador_interno : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
 PROCESS (clock,enable)
 BEGIN
    IF RISING_EDGE(clock) AND enable = '1' THEN
        registrador_interno <= dado_de_entrada;
    END IF;
 END PROCESS;

 dado_de_saida <= registrador_interno;
END ARCHITECTURE behavioral;