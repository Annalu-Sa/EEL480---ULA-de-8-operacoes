LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- .vhd DA BANCADA DE TESTES 
-- Aqui conta o codigo que representa toda a parte de fluxo de controle e de dados do circuito.

-- Teremos nossos modulos registradores, muxes e demuxes para realizacao do fluxo de dados.
-- E registradores, contadores, clock para controle de fluxo.

-- Criamos os arquivos .vhd de cada modulo separadamente e os adicionamos como componentes, 
-- assim realizando somente a conexao dos ''fios'' de cada um dos modulos assim montando o circuito final.



-- declarao de entidade da bancada de testes---------------------------------------------- 
ENTITY bancadatestes IS
  PORT (
    entrada : IN STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0') ; -------- entrada de 4 bits da Bancada de testes (switches FPGA)-------
    resultado : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0') ; -- sada de 8 bits da Bancada de testes (leds FPGA) ----------------------
    botao1,botao2,botao3,botao4,clock: IN STD_LOGIC := '0' ;  -- clocks (botoes e clock FPGA) --------------------------------
	 clock_de_subida_dividido : OUT STD_LOGIC_VECTOR(25 DOWNTO 0) := (others => '0') -- VISUALIZAR CLOCK DIVIDIDO ---
  );
END bancadatestes;
-- declarao de entidade da ula---------------------------------------------- 


ARCHITECTURE principal OF bancadatestes IS

-- declarao dos componentes utilizados ------------------------------------------------

  -- Modulo da ula e o componente combinacional que recebe as entradas da bancada de testes e realiza
  -- toda a aritimetica e operacoes logicas do circuito, ao receber as entradas e a operacao desejada 
  -- nos oferece um resultado e suas flags respectivas. 
  COMPONENT modulo_ula
     PORT (
	   a_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		b_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		op_in: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		result_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		flags_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	  );
  END COMPONENT modulo_ula;
  
  -- Modulo registrador de 4 bits com enable foi utilizado para realizar o fluxo das entradas a_in e 
  -- b_in ate a modulo_ula, este fluxo e controlado por um botao conectado a sua entrada Clock.
  COMPONENT modulo_registrador4bits
	  PORT (
	     clock : IN STD_LOGIC;
        dado_de_entrada : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        dado_de_saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		  enable         : IN STD_LOGIC
		 );
  END COMPONENT modulo_registrador4bits;
  
  -- Modulo registrador de 3 bits com enable foi utilizado para realizar o fluxo da entrada Op_in
  -- ate a modulo_ula, este fluxo tambem e controlado por um botao conectado a sua entrada clock.
  -- Enable foi utilizado pois temos apenas uma entrada para 3 registradores o que define um 
  -- barramento.
  COMPONENT modulo_registrador3bits
		  PORT (
	     clock : IN STD_LOGIC;
        dado_de_entrada : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        dado_de_saida : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		  enable         : IN STD_LOGIC
		 );
	  END COMPONENT modulo_registrador3bits;
	
  -- Modulo contador simples foi utilizado de maneira que sincronamente tanto em uma frequencia fixa
  -- de clock como tambem um botao tivessemos a possibilidade de alterar a visualizacao de cada uma das 
  -- saidas para os leds.  
  COMPONENT modulo_contador
	  PORT (
        clock : IN STD_LOGIC;
        contagem : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
    	      );
  END COMPONENT modulo_contador;
  
  -- Modulo necessario pois estaremos lidando com botoes fisico que tanto quando o aperta como quando o
  -- solta existe uma instabilidade de sinal, com este circuito criamos um sinal 'limpo' permitindo o 
  -- circuito funcionar de maneira correta sem variacoes inesperadas. 
	 COMPONENT modulo_debouncer
	   PORT (
		  input : IN STD_LOGIC;
		  clock : IN STD_LOGIC;
		  output : OUT STD_LOGIC
			);
	END COMPONENT modulo_debouncer;
	
	-- Modulo que divide o clock da placa FPGA que e de 50Mhz, o que facilita a visualizacao de cada etapa
	-- do circuito.
	COMPONENT modulo_divisor_de_clock
	   PORT (
        clock: IN std_logic;
        clock_dividido: OUT STD_LOGIC;
		  detector_de_subida: OUT STD_LOGIC_VECTOR(25 DOWNTO 0)
       );
	END COMPONENT modulo_divisor_de_clock;
	
	-- Decodificador feito a partir de uma demux para que cada registrador receba os dados um por vez no 
	-- barramento.
	COMPONENT modulo_decoder_com_demux1_4
	PORT(
    input_1bit : IN STD_LOGIC; 
    seletor : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
    out_01 : OUT STD_LOGIC; 
    out_10 : OUT STD_LOGIC; 
    out_11 : OUT STD_LOGIC 
    );
	 END COMPONENT modulo_decoder_com_demux1_4;
	 
	 -- Multiplexador foi fundamental para que possamos alternar cada informacao que aparece nos leds de 
	 -- saida da bancada de testes.
	 COMPONENT modulo_multiplexer4_4 
    PORT(
	 out_00 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
	 out_01 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
	 out_10 : IN STD_LOGIC_VECTOR( 2 DOWNTO 0);
	 out_11 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
    seletor : IN STD_LOGIC_VECTOR(1 DOWNTO 0);  
    output_4bits : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0)
    );
    END COMPONENT modulo_multiplexer4_4;
	 
	 -- Multiplexador de 2 entradas de 4 bits foi utilizado para que o circuito alterne entre as flags 
	 -- e Enable atual selecionado
	 COMPONENT modulo_multiplexer2_4 
	PORT(
		 out_00 : IN STD_LOGIC_VECTOR( 3 DOWNTO 0);
		 out_01 : IN STD_LOGIC_VECTOR( 1 DOWNTO 0);
		 seletor : IN STD_LOGIC;  --select input
		 output_4bits : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0)
		 );
	 END COMPONENT modulo_multiplexer2_4;

  
-- declarao dos sinais(fios)------------------------------------------------

  ------------------Fios que conectam os registradores ao modulo_ula---------------------------
  SIGNAL registra_a_in,registra_b_in,result_ula: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
  
  SIGNAL registra_op_in:                         STD_LOGIC_VECTOR(2 DOWNTO 0):= (others => '0');
  ------------------Fios que conectam os registradores ao modulo_ula---------------------------
  
  ------------------Fios que conectam os muxes aos LEDS do circuito ---------------------------
  SIGNAL alterna_leds_right,alterna_leds_left:   STD_LOGIC_VECTOR(1 DOWNTO 0):= (others => '0');
  SIGNAL leds_right,leds_left,flags:             STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
  ------------------Fios que conectam os muxes aos LEDS do circuito ---------------------------
  
  ------------------Fios que conectam os enables da Demux aos registradores -------------------
  SIGNAL enable00,enable01,enable10:             STD_LOGIC := '0';
  ------------------Fios que conectam os enables da Demux aos registradores -------------------
  
  ------------------Fios que conectam os botoes com o debounce aos registradores e contador ----
  SIGNAL botao1_debounced,botao2_debounced,botao3_debounced,botao4_debounced: STD_LOGIC:= '0';
  ------------------Fios que conectam os botoes com o debounce aos registradores e contador ----
  
  ------------------Fio que conecta o clock dividido aos muxes para permitir visualizacao ------ 
  SIGNAL clock_dividido:                         STD_LOGIC:= '0';
  ------------------Fio que conecta o clock dividido aos muxes para permitir visualizacao ------
  
  SIGNAL detector :                              STD_LOGIC_VECTOR(25 DOWNTO 0):= (others => '0');
-- declarao dos sinais(fios)------------------------------------------------


--- Nesta secao atribuimos cada uma das entradas aos seus respectivos fios e portas de cada modulo,
--- como um mapeamento do circuito.
BEGIN
  --atribuicao das entradas e saidas da ula
  ula        :  modulo_ula                       PORT MAP ( a_in => registra_a_in, b_in => registra_b_in, op_in => registra_op_in, result_out => result_ula , flags_out =>flags );
  --atribuicao das entradas e saidas dos registradores
  registrador_de_a_in:   modulo_registrador4bits PORT MAP ( clock => botao1_debounced, dado_de_entrada => entrada, dado_de_saida => registra_a_in, enable=>enable00);
  registrador_de_b_in:   modulo_registrador4bits PORT MAP ( clock => botao2_debounced, dado_de_entrada => entrada, dado_de_saida => registra_b_in, enable=>enable01 );
  registrador_de_op_in:  modulo_registrador3bits PORT MAP ( clock => botao3_debounced, dado_de_entrada => entrada(2 DOWNTO 0), dado_de_saida => registra_op_in, enable=>enable10);  
  --atribuicao das entradas e saidas do contador
  alternador_leds_right:     modulo_contador     PORT MAP ( clock => clock_dividido, contagem => alterna_leds_right);
  alternador_leds_left:      modulo_contador     PORT MAP ( clock => botao4_debounced, contagem => alterna_leds_left);
  --atribuicao das entradas e saidas do circuito de debounce para cada botao.
  debouncer_botao1:  modulo_debouncer            PORT MAP ( clock => clock, input => botao1, output=>botao1_debounced );
  debouncer_botao2:  modulo_debouncer            PORT MAP ( clock => clock, input => botao2, output=>botao2_debounced );
  debouncer_botao3:  modulo_debouncer            PORT MAP ( clock => clock, input => botao3, output=>botao3_debounced);
  debouncer_botao4:  modulo_debouncer            PORT MAP ( clock => clock, input => botao4, output=>botao4_debounced );
  --atribuicao de entradas e saidas do decodificador feito com a demux
  alternador_enables:modulo_decoder_com_demux1_4 PORT MAP ( input_1bit => '1', seletor =>alterna_leds_left, out_01 =>enable00, out_10 =>enable01, out_11 =>enable10);
  -- atribuicao de entradas e saidas dos multiplexadores 
  mux_leds_right:  modulo_multiplexer4_4         PORT MAP (output_4bits =>leds_right, seletor =>alterna_leds_right, out_00=> registra_a_in, out_01 => registra_b_in, out_10=> registra_op_in, out_11 =>result_ula );
  mux_leds_left:  modulo_multiplexer2_4          PORT MAP (output_4bits =>leds_left,  seletor =>clock_dividido, out_00=> flags,   out_01 =>alterna_leds_left );
  --atribuicao da entrada e saida do divisor de clock.
  divide_clock: modulo_divisor_de_clock          PORT MAP ( clock =>clock, clock_dividido => clock_dividido, detector_de_subida => detector );


-- Neste processo finalmente atribuimos cada uma de nossas saidas que passaram por todo o circuito, finalmente 
-- a nossa saida "resultado" da bancada de testes que na apresentacao final sera representada como os LEDS 
-- da FPGA

-- No processo, esta lista de sensibilidade identifica a mudanca de cada uma destas variaveis realizando 
-- a re-execucao do do processo a cada vez que uma delas e alterada, tornando assim possivel a visualizacao
-- do resultado final e de cada uma das flags respectivas, e tambem ao codigo de entrada atual que nos permite
-- visualizar qual dos enables esta habilitado, com essa informacao conseguimos identificar qual informacao devemos
-- submeter no circuito.
PROCESS(leds_right,leds_left,detector,clock_dividido)
BEGIN
clock_de_subida_dividido <= detector;
resultado(0) <= leds_right(0);
resultado(1) <= leds_right(1);
resultado(2) <= leds_right(2);
resultado(3) <= leds_right(3);

resultado(4) <= leds_left(0);
resultado(5) <= leds_left(1);
resultado(6) <= leds_left(2);
resultado(7) <= leds_left(3);
END PROCESS;

END principal;
