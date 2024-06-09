LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Neste modulo realizamos a divisao do clock, nossa placa possui um clock
-- de 50mhz, o que significa uma alternancia de valores a cada 20 nanosegundos
-- o que incapacita-nos de visualizar a alternancia dos valores que acontece
-- sequencialmente. 

-- Para realizar este circuito criamos uma entrada e uma saida de 1 bit.
ENTITY modulo_divisor_de_clock IS
    PORT (
        clock: IN STD_LOGIC;
        clock_dividido: OUT STD_LOGIC
    );
END modulo_divisor_de_clock;


ARCHITECTURE bhv OF modulo_divisor_de_clock IS
-- Estes sinais sao responsaveis por dividir o clock, e realizando a divisao percebemos que precisamos 
-- de um vetor de 2**26, portanto temos um vetor de 26 bits. 
	 SIGNAL divide: STD_LOGIC_VECTOR(25 DOWNTO 0) := (OTHERS => '0');
   
	 
BEGIN
-- Neste processo sensivel ao clock, a cada clock o sinal divide realiza a contagem preenchendo nosso 
-- vetor de 26 bits, de modo que quando nosso ultimo bit for preenchido, e esse o momento em que nosso
-- clock_dividido acontecera, portanto enquanto nosso clock acontece em 20 ns, nosso clock dividido acontece
-- a cada 2**26 * 20 ns.
    PROCESS(clock)
    BEGIN
        IF RISING_EDGE(clock) THEN
            divide <= divide + '1';
        END IF;
    END PROCESS;
	 
    clock_dividido <= divide(25);
	 
	
END bhv;