LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Modulo da unidade logica aritimetica, ela e responsavel por realizar as operacoes tanto aritimeticas
-- quanto logicas do circuito. 

--A ula recebe duas entradas de 4 bits e uma entrada de 3 bits que seleciona 
-- a operacao. Como temos apenas funcoes logicas e operacao de soma e subtracao nossa saida tera 4 bits.
-- Alem destes tambem teremos a geracao de flags em um vetor de 4 bits, onde cada bit 
ENTITY modulo_ula IS
  PORT(
  --A ula recebe duas entradas de 4 bits e uma entrada de 3 bits que seleciona a operacao
	a_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	b_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	op_in: IN STD_LOGIC_VECTOR(2 DOWNTO 0):= (OTHERS => '0');
  -- Como temos apenas funcoes logicas e operacao de soma e subtracao nossa saida tera 4 bits.
	result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0) := (OTHERS => '0');
  -- Alem destes tambem teremos a geracao de flags em um vetor de 4 bits, onde cada bit representa um flag
  -- sendo estes bit 0 : Flag carry_out; bit 1 : Flag overflow; bit 2: Flag negativo; bit 3: Flag de zero
	flags_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0):= (OTHERS => '0')
	);
END modulo_ula;

ARCHITECTURE Behavioral OF Modulo_ULA IS
-- Para realizar a montagem da ula utilizamos modulos, dentre eles 
-- Modulo somador de 4 bits, recebe dois vetores de 4 bits e realiza a soma e tambem um carry_out
-- Com o mesmo modulo somador, utilizando o carry_in, contruimos a funcao aritimetica da subtracao
COMPONENT modulo_somador_4bits
    PORT (
       a,b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 carry_out : OUT STD_LOGIC;
		 carry_in : IN STD_LOGIC;
		 sum : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_somador_4bits;
  
  -- Os modulos a seguir sao os modulos das funcoes logicas onde cada um dos modulos recebem
  -- vetores de 4 bits e realizam as operacoes logicas.. and, nand, or, nor, xor, xnor.
  COMPONENT modulo_xor
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_xor;

  COMPONENT modulo_xnor
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_xnor;

  COMPONENT modulo_or
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_or;

  COMPONENT modulo_and
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_and;

 COMPONENT modulo_nand
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_nand;
  
  COMPONENT modulo_nor
     PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT modulo_nor;
  
  
  -- Fios que carregam os valores entre os modulos -----------
  
  -- Fios que carregam os resultados das somas e da subtracao, os fios possuem um bit a mais(5 bits) pois, 
  -- sendo assim podemos identificar de maneira mais simplificada a ocorrencia de carry_out e overflow.
  SIGNAL soma, subtrai: STD_LOGIC_VECTOR(4 DOWNTO 0):= (OTHERS => '0');
  
  -- Fios que carregam as saidas de cada um dos modulos das funcoes logicas.
  SIGNAL func_xor,func_xnor,func_and,func_nand,func_or,func_nor: STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
  
  -- Este sinal foi essencial para sermos capazes de fazer o subtrator, pois este sinal carrega o valor 
  -- de B invertido, entao, Ex : se o valor de B e "0000" este sinal carrega o valor "1111";
  SIGNAL bnegado: STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
  
  -- Fios que carregam os valores entre os modulos -----------
begin
  -- Comportamento da ULA, esta secao mostra o mapeamento do circuito, onde cada entrada se conecta --------------------------------------------
  bnegado(3 DOWNTO 0) <= NOT(b_in); -- Nega a entrada B de modo que nosso somador se torne um somador realizando o complemento de 2.  
  -- Modulo somador, aqui somos capazes de visualizar que o nosso carry_out entra como nosso quinto bit do vetor que carrega o resultado da soma.
  FuncSoma000     : modulo_somador_4bits PORT MAP (a => a_in, b => b_in,sum => soma(3 DOWNTO 0),carry_out => soma(4), carry_in => '0');
  -- Modulo subtrator, utilizando o somador de 4 bits, o valor de b negado e o carry_in recebendo nivel logico alto, conseguimos fazer um subtrator de 4 bits.
  FuncSubtrai001  : modulo_somador_4bits PORT MAP (a => a_in, b => bnegado(3 DOWNTO 0), sum => subtrai(3 DOWNTO 0),  carry_out => subtrai(4),  carry_in => '1');
  
  -- Aqui podemos ver os modulos das funcoes logicas com cada uma das suas entradas atribuidas no circuito.
  FuncLogNAND010  : modulo_nand    PORT MAP ( a => a_in, b =>b_in, saida =>func_nand );
  FuncLogOR011    : modulo_or    PORT MAP ( a => a_in, b =>b_in, saida =>func_or );
  FuncLogXOR100   : modulo_xor    PORT MAP ( a => a_in, b =>b_in, saida =>func_xor );
  FuncLogXNOR101  : modulo_xnor    PORT MAP ( a => a_in, b =>b_in, saida =>func_xnor );
  FuncLogAND110   : modulo_and    PORT MAP ( a => a_in, b =>b_in, saida =>func_and );
  FuncLogNOR111   : modulo_NOR    PORT MAP ( a => a_in, b =>b_in, saida =>func_nor );

  -- Este processo permite que cada uma das entradas e sinais listados sejam sensiveis a mudanca, re-executando o processo a cada mudanca
  PROCESS(op_in,soma,subtrai,a_in,b_in,func_and,func_nand,func_or,func_xor,func_xnor,func_nor)
  BEGIN
  -- Nesta etapa do processo definimos qual operacao logica e aritimetica sera realizada dependendo diretamente 
  -- do valor de op_in, que por termos 8 operacoes, e um vetor de 3 bits, sendo o seu primeiro valor 000 e ultimo 111.
  -- o que e exatamente o que queremos.
  
  --Portanto atribuimos o valor 000 a soma.
  IF op_in = "000" THEN
	result_out(0) <= soma(0);
	result_out(1) <= soma(1);
	result_out(2) <= soma(2);
	result_out(3) <= soma(3);
	flags_out(1) <= '0';
	
	-- Nesta etapa definimos as instrucoes para que o circuito identifique cada uma das flags. 
  
  -- Flag Zero ------------------------------------------
  -- Se nosso resultado for "0000" nosso flag zero sinaliza.
    IF soma = "00000" THEN
    flags_out(0) <= '1';
    ELSE 
    flags_out(0) <= '0';
    END IF;
-- Flag Zero ------------------------------------------

-- Flag Overflow --------------------------------------
-- Este flag acontece quando nossa entrada nao consegue ser representada corretamente no nosso vetor de saida. 
-- Para a soma de 4 bits a soma acontece na mesma frequencia em que se ocorre o carry_out, entao podemos 
-- utilizar nosso quinto bit para identificar igualmente os dois. 

    IF soma(4) = '1' THEN  -- Adição
            flags_out(3) <= '1';
    ELSE
            flags_out(3) <= '0';
    END IF;

-- Flag Overflow --------------------------------------

-- Flag Carry out --------------------------------------
-- Carry out acontece quando nosso valor excede o numero de bits de saida, portanto utilizaremos o quinto
-- bit do sinal que carrega o resultado para identifica-lo e entao sinaliza-lo.
  IF soma(4) ='1' THEN 
    flags_out(2) <= soma(4);
  ELSE 
    flags_out(2) <= '0';
  END IF;
-- Flag Carry out --------------------------------------  

  ELSIF op_in = "001" THEN
  --Portanto atribuimos o valor 001 a subtracao.
	result_out(0) <= subtrai(0);
	result_out(1) <= subtrai(1);
	result_out(2) <= subtrai(2);
	result_out(3) <= subtrai(3);
	
-- Flag Zero ------------------------------------------
  -- Se nosso resultado for "0000"nosso flag zero sinaliza.
    IF subtrai = "00000" THEN
    flags_out(0) <= '1';
    ELSE 
    flags_out(0) <= '0';
    END IF;
-- Flag Zero ------------------------------------------

-- Flag Negativo --------------------------------------
-- Se a nossa entrada a_in( que seria nosso minuendo) for maior que nosso b_in ( nosso subtraendo) entao temos 
-- um valor negativo na nossa saida, sendo assim nosso flag negativo sinaliza.
    IF (a_in < b_in) THEN
    flags_out(1) <= '1';
    ELSE
    flags_out(1) <= '0';
    END IF; 
-- Flag Negativo -------------------------------------- 
	 
-- Para a subtracao temos mais casos ja que nossos numeros estao em complemento de 2, entao para identificar 
-- overflow utilizamos a seguinte logica : Nosso a_in(minuendo) nunca pode ser maior que nosso resultado 
-- ja que ele esta sendo subtraido por b_in(subtraendo), nesse caso conseguimos cobrir todos os casos de overflow
-- satisfazendo os resultados esperados e sinalizando corretamente. 

 -- Flag Overflow --------------------------------------

	 IF subtrai(3 downto 0) > a_in THEN  -- Adição
            flags_out(3) <= '1';
    ELSE
            flags_out(3) <= '0';
    END IF;
-- Flag Overflow --------------------------------------
	 
-- Flag Carry out --------------------------------------  
	IF subtrai(4) = '1' THEN 
	 flags_out(2) <= soma(4);
	ELSE 
	 flags_out(2) <= '0';
	END IF;
-- Flag Carry out --------------------------------------  


--As fla

  ELSIF op_in = "010" THEN
  
   result_out(0) <= func_and(0);
	result_out(1) <= func_and(1);
	result_out(2) <= func_and(2);
	result_out(3) <= func_and(3);
	
	
	IF func_and = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_and = "0001" OR func_and ="0010" OR func_and ="0100"  OR func_and ="0111" OR func_and ="1000" OR func_and ="1011"  OR func_and ="1101" OR func_and ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_and = "0011" OR func_and ="0110" OR func_and ="1001" OR func_and ="0101" OR func_and ="1010" OR func_and ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_and = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
  
  
	--Portanto atribuimos o valor 011 a operacao logica nand.
  ELSIF op_in = "011" THEN
   result_out(0) <= func_nand(0);
	result_out(1) <= func_nand(1);
	result_out(2) <= func_nand(2);
	result_out(3) <= func_nand(3);
	
	
	IF func_nand = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nand = "0001" OR func_nand ="0010" OR func_nand ="0100"  OR func_nand ="0111" OR func_nand ="1000" OR func_nand ="1011"  OR func_nand ="1101" OR func_nand ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nand = "0011" OR func_nand ="0110" OR func_nand ="1001" OR func_nand ="0101" OR func_nand ="1010" OR func_nand ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nand = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
  
	--Portanto atribuimos o valor 100 a operacao logica or.
  ELSIF op_in = "100" THEN
   result_out(0) <= func_or(0);
	result_out(1) <= func_or(1);
	result_out(2) <= func_or(2);
	result_out(3) <= func_or(3);
	
	IF func_or = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_or = "0001" OR func_or ="0010" OR func_or ="0100"  OR func_or ="0111" OR func_or ="1000" OR func_or ="1011"  OR func_or ="1101" OR func_or ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_or = "0011" OR func_or ="0110" OR func_or ="1001" OR func_or ="0101" OR func_or ="1010" OR func_or ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_or = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
  
	--Portanto atribuimos o valor 101 a operacao logica nor.
  ELSIF op_in = "101" THEN
   result_out(0) <= func_nor(0);
	result_out(1) <= func_nor(1);
	result_out(2) <= func_nor(2);
	result_out(3) <= func_nor(3);
	
	IF func_nor = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nor = "0001" OR func_nor ="0010" OR func_nor ="0100"  OR func_nor ="0111" OR func_nor ="1000" OR func_nor ="1011"  OR func_nor ="1101" OR func_nor ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nor = "0011" OR func_nor ="0110" OR func_nor ="1001" OR func_nor ="0101" OR func_nor ="1010" OR func_nor ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_nor = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
	--Portanto atribuimos o valor 110 a operacao logica xor.
  ELSIF op_in = "110" THEN
  result_out(0) <= func_xor(0);
  result_out(1) <= func_xor(1);
  result_out(2) <= func_xor(2);
  result_out(3) <= func_xor(3);
  
	IF func_xor = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xor = "0001" OR func_xor ="0010" OR func_xor ="0100"  OR func_xor ="0111" OR func_xor ="1000" OR func_xor ="1011"  OR func_xor ="1101" OR func_xor ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xor = "0011" OR func_xor ="0110" OR func_xor ="1001" OR func_xor ="0101" OR func_xor ="1010" OR func_xor ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xor = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
  
  --Portanto atribuimos o valor 111 a operacao logica xnor.
  ELSE 
  result_out(0) <= func_xnor(0);
  result_out(1) <= func_xnor(1);
  result_out(2) <= func_xnor(2);
  result_out(3) <= func_xnor(3);
  
	IF func_xnor = "0000" THEN
	    flags_out(2) <= '0';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xnor = "0001" OR func_xnor ="0010" OR func_xnor ="0100"  OR func_xnor ="0111" OR func_xnor ="1000" OR func_xnor ="1011"  OR func_xnor ="1101" OR func_xnor ="1110" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xnor = "0011" OR func_xnor ="0110" OR func_xnor ="1001" OR func_xnor ="0101" OR func_xnor ="1010" OR func_xnor ="1100" THEN 
	    flags_out(2) <= '0';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSIF func_xnor = "1111" THEN
		 flags_out(2) <= '1';
		 flags_out(3) <= '1';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	ELSE
	    flags_out(3) <= '0';
		 flags_out(2) <= '0';
		 flags_out(1) <= '0';
		 flags_out(0) <= '0';
	END IF;
  END IF;
  
  

 END PROCESS;  
END Behavioral;