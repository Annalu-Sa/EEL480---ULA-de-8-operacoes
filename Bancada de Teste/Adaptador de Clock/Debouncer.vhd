LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Circuito de debounce feito pois precisamos de estabilidade em cada um 
-- dos botoes, especialmente no botao que seleciona cada um dos enables 
-- no barramento.
ENTITY modulo_debouncer IS
  PORT (
  
  input : IN STD_LOGIC;
  clock : IN STD_LOGIC;
  output : OUT STD_LOGIC
    );
END modulo_debouncer;

ARCHITECTURE typearchitecture OF modulo_debouncer IS
-- Para realizar o debounce utilizamos 3 sinais de 1 bit para receber o valor 
-- atual do nivel logico do clock.
SIGNAL delay1,delay2,delay3: STD_LOGIC;
BEGIN
-- e dentro do processo sensivel ao clock podemos realizar a premissa deste circuito.
PROCESS(clock)
BEGIN
-- a cada clock o botao entrega ao delay1 o seu nivel logico atual, e entao
-- o delay1 entrega ao delay2, e assim por diante, de modo que ao receber 3 sinais 
-- iguais tenhamos a certeza de que o sinal esta estavel.
IF clock'EVENT AND clock ='1' THEN
delay1 <= input;
delay2 <= delay1;
delay3 <= delay2;
END IF;

END PROCESS;
-- Deste modo, com o sinal ja estavel entregamos a saida somente este valor.
-- sera '1' quando os 3 delays receberem '1' sequencialmente, e sera '0' quando os 3 delays receberem '0' sequencialmente
output <= delay1 AND delay2 AND delay3;
END typearchitecture;