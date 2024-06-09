LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY modulo_or IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 downto 0);
        saida : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
END modulo_or;
-- Modulo feito de maneira simplificada, apenas recebe as entradas de 4 bits 
-- e sua saida recebe a logica OR realizada entre as mesmas.
ARCHITECTURE behavior OF modulo_or IS
BEGIN
   saida <= a OR b;
END behavior;
