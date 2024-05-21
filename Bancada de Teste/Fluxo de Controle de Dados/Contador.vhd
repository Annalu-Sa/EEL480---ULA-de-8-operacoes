LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Utilizamos o modulo contador para realizar a mudanca da informacao recebida
-- no vetor de saida da bancada de testes, ele alterna sincronamente as saidas 
-- alternando para nivel alto os leds a cada N segundos.

-- O botao4 da bancada de testes atua como o clock de um dos contadores, pois como temos um barramento 
-- precisamos ter a informacao de que qual dos enables esta ativo no momento, e com os contadores 
-- junto de muxes e demux podemos tambem mostrar sincronamente estas informacoes.


ENTITY modulo_contador IS
    PORT (
        clock : IN STD_LOGIC;
        contagem : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    );
END modulo_contador;

ARCHITECTURE behavior OF modulo_contador IS
-- Sinal do tipo unsigned pois o utilizaremos para realizar soma, e desta 
-- forma ele e reconhecido como un numero.
    SIGNAL temp : UNSIGNED(1 DOWNTO 0) := (OTHERS => '0');
BEGIN
-- Processo sensivel ao clock, o fio temp soma 1 a cada clock, repare
-- que 1 se refere ao valor 1 e nao a 1 bit que seria representado desta forma 
-- '1'. 
    PROCESS(clock)
    BEGIN
        IF RISING_EDGE(clock) THEN
            temp <= temp + 1;
        END IF;
    END PROCESS;
-- Ao final a saida contagem recebe o valor do sinal temp.
    contagem <= STD_LOGIC_VECTOR(temp);
END behavior;
