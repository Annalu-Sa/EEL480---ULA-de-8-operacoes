
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY modulo_nor IS
    PORT ( a : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
           b : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
           saida : OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
			  );
END modulo_nor;
-- Modulo feito de maneira simplificada, apenas recebe as entradas de 4 bits 
-- e sua saida recebe a logica NOR realizada entre as mesmas.
ARCHITECTURE Behavioral of modulo_nor is
BEGIN

saida <= a NOR b; 

END Behavioral;

