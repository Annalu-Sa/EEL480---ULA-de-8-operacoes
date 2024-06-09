LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Modulo registrador que recebe informacao do barramento e no lugar de sua entrada
-- clock sao atribuidos botoes, que quando o circuito esta com Enable em nivel alto
-- recebe o dado e o carrega. 

-- Temos um registrador para o seletor de operacao (op_in) e nossas duas entradas (a_in) e (b_in)
-- Como temos apenas um vetor conectado em todas elas, utilizamos os registradores com botoes como clock
-- Para sermos capazes de representar corretamente o barramento.

ENTITY modulo_registrador4bits IS
-- O registrador de 4 bits foram construidos com uma entrada clock e enable de 1 bit
-- e a entrada e saida com 4 bits.
    PORT (
        clock : IN STD_LOGIC;
        dado_de_entrada : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        enable          : IN STD_LOGIC;
        dado_de_saida   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY modulo_registrador4bits;

ARCHITECTURE behavioral OF modulo_registrador4bits IS
-- Este sinal e responsavel por guardar a informacao da entrada e carregar este valor 
-- ate a saida do registrador.
		SIGNAL registrador_interno : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
-- Este processo avalia o valor de clock e enable constantemente.
 PROCESS (clock,enable)
 BEGIN
 -- Ao pressionar o botao, com a condicao de que o enable esta em nivel alto, o sinal recebe o valor da entrada 
 -- respectiva. 
    IF RISING_EDGE(clock) AND enable = '1' THEN
        registrador_interno <= dado_de_entrada;
    END IF;
 END PROCESS;

 dado_de_saida <= registrador_interno;
END ARCHITECTURE behavioral;