LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- O modulo decodificador feito com demux tem a intencao de alternar entre
-- os enables de cada um dos registradores que atuam como um buffer, sendo assim
-- somos capazes de entregar informacao para os registradores alternadamente. 
ENTITY modulo_decoder_com_demux1_4 IS
-- Temos portanto um input de 1 bit que inicialmente recebe '1' configurando assim
-- nossa demux como um decodificador.
PORT(
    input_1bit : IN STD_LOGIC; 
    seletor : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  
    out_01 : OUT STD_LOGIC; 
    out_10 : OUT STD_LOGIC; 
	 out_11 : OUT STD_LOGIC
    );
END modulo_decoder_com_demux1_4;

ARCHITECTURE behavioral OF modulo_decoder_com_demux1_4 IS
BEGIN
-- Temos um processo sensivel a entrada de 1 bit e ao seletor.
PROCESS(input_1bit,seletor)
BEGIN
-- Nesta etapa omitimos o valor 00 pois precisamos apenas alternar entre 3 enables 
-- E seria mais adequado omitir o valor inicial 00 do que o valor final 11. 
CASE seletor IS
   -- Temos as condicoes que constituem um decodificador/demux onde para cada valor 
	-- selecionado, habilitamos cada uma das saidas
	 WHEN "00" => out_11 <= '0'; out_10 <= '0'; out_11 <= '0'; out_01 <= '0';
    WHEN "01" => out_01 <= input_1bit; out_10 <= '0'; out_11 <= '0';
	 WHEN "10" => out_10 <= input_1bit; out_01 <= '0'; out_11 <= '0';
	 WHEN OTHERS => out_11 <= input_1bit; out_01 <= '0'; out_10 <= '0';
END CASE;
END PROCESS;
END behavioral;