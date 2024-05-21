LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Modulo somador que recebe dois vetores de 4 bits e realiza a soma entre eles 
-- devolvendo um carry_out quando for necessario e alem do seu resultado de 4 bits 
-- tambem temos uma entrada de carry_in para o reutilizarmos como subtrator.

ENTITY Modulo_somador_4bits IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 downto 0);
        carry_in : IN STD_LOGIC;
        sum : OUT STD_LOGIC_VECTOR(3 downto 0);
        carry_out : OUT STD_LOGIC
    );
END Modulo_somador_4bits;

ARCHITECTURE behavior OF Modulo_somador_4bits IS
-- Utilizamos um sinal do tipo UNSIGNED para sermos capazes de realizar a soma destes sinais 
-- pois os fios deste tipo sao reconhecidos como numeros. 
    SIGNAL temp : UNSIGNED(4 downto 0);
BEGIN
-- O sinal nesta etapa recebe o valor de a e de b aumentando em 1 bit cada um deles 
-- de modo que nossa soma possa adequar um bit a mais diretamente no sinal temp 
-- facilitando nosso trabalho em identificar o carry_out e overflow 
    temp <= ('0' & UNSIGNED(a)) + ('0' & UNSIGNED(b)) + ('0' & carry_in);
-- Como nosso somador tem quatro bits, apenas atribuimos os valores dos bits anteriores ao bit mais signfiicativo
-- de temp.
    sum <= STD_LOGIC_VECTOR(temp(3 downto 0));
-- como nosso temp adequa 1 bit a mais podemos identificar overflow e carry out diretamente utilizando o quarto bit
-- de temp.
    carry_out <= STD_LOGIC(temp(4));
END behavior;
