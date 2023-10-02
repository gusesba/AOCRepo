-- UTFPR - DAELN
-- Professor Rafael E. de Góes
-- Disciplina de Arquitetura e Organização de Computadores - ELF61
-- Arquivo TopLevel do Microprocessador para substituir o test_bech
-- versão 1.0 - 2018-10-15
-- versão 2.0 - 2019-09-07: criação do sinal 'rst_proc' que correspode Ã  not(KEY0) e deve ser usado para o processador e RAMDisp
-- versão 3.0 - 2022-03-11: adaptação para a placa DE10-Lite

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;

ENTITY MikroP IS
PORT (   
		  -- sinais que sao usados no toplevel (substituem o que vinha do testbench)
		  CLK_H_HW : in std_logic;               -- PIN_N14 (50 MHz)
		  RST_HW   : in std_logic;               -- KEY0 PIN_B8
            
        -- sinais que sao a interface de teste no HW fisico
        
		  KEY1_HW:    in std_logic;				   -- KEY1 PIN_A7
        
		  SWITCH_HW : in unsigned (9 downto 0);   --SW9 a SW0  (PINS F15, B14, A14, A13, B12, A12, C12, D12, C11, C10) 
        LED_HW    : out unsigned (9 downto 0);  -- LED9..LED0 (PINS B11, A11, D14, E14, C13, D13, B10, A10, A9, A8)

        -- displays da placa conectados na FPGA
        HEX0_HW: out std_logic_vector(6 downto 0);   -- display 7 segmentos (LSd)
        HEX1_HW: out std_logic_vector(6 downto 0);   -- display 7 segmentos
        HEX2_HW: out std_logic_vector(6 downto 0);   -- display 7 segmentos
        HEX3_HW: out std_logic_vector(6 downto 0);   -- display 7 segmentos 
		  HEX4_HW: out std_logic_vector(6 downto 0);   -- display 7 segmentos 
		  HEX5_HW: out std_logic_vector(6 downto 0)    -- display 7 segmentos (MSd)	 
	 );
END MikroP;


ARCHITECTURE LogicFunction OF MikroP IS
	
	COMPONENT RAMDisp is
	PORT ( 	
				clk : in std_logic;
				endereco : in unsigned(15 downto 0);
				wr_en : in std_logic;
				dado_in : in unsigned(15 downto 0);
				dado_out : out unsigned(15 downto 0);
				
				--- sinais adicionais da RAMDisp
				-- decodificaÃ§Ã£o 7seg
				HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); --(max 99)
				HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				
				
				-- divisÃ£o de clock 
				rst    : in std_logic;
				clk_h  : in std_logic;
				turbo  : in std_logic;
				halt   : in std_logic;
				clk_div: out std_logic
			);
	END COMPONENT RAMDisp;
	
	COMPONENT ula
        PORT (
            in_A, in_B : IN UNSIGNED(15 DOWNTO 0);
            op : IN UNSIGNED(2 DOWNTO 0);
            out_ULA : OUT UNSIGNED(15 DOWNTO 0);
            zero, mq : OUT STD_LOGIC
        );
    END COMPONENT;
	
	-- Sinais do MikroP declarados apenas para nÃ£o deixar sinais de entrada da RAM flutuando
	SIGNAL enderecoRAMDisp: unsigned(15 downto 0);
	SIGNAL wr_enRAMDisp: std_logic;
	SIGNAL dado_inRAMDisp: unsigned(15 downto 0):="0000000000000000";
	SIGNAL ram_out:  unsigned(15 downto 0);
	
	
	Signal CONT: unsigned (7 downto 0);
	signal clk_div_s: std_logic;  -- esse é o clock divido de maneira variável pelas teclas TURBO e HALT
	signal rst_proc: std_logic; -- esse é o reset que deve ser ligado nos blocos do processador 
	signal saida_ula: unsigned(15 downto 0);

	
	
BEGIN

	RAMeDISP: RAMDisp
	PORT MAP (	
					clk=>clk_div_s,
					endereco => enderecoRAMDisp,
					dado_in=> dado_inRAMDisp,
					dado_out => ram_out, -- sinal a ser ligado ao processador
					wr_en=> wr_enRAMDisp,
					
					HEX0=>HEX0_HW, 
					HEX1=>HEX1_HW, 
					HEX2=>HEX2_HW, 
					HEX3=>HEX3_HW,
					HEX4=>HEX4_HW,
					HEX5=>HEX5_HW,
					
					halt => SWITCH_HW(9),
					turbo => SWITCH_HW(8),
					clk_h  => CLK_H_HW,  
					clk_div => clk_div_s,
					rst    => rst_proc
				);
			
	
	ulaula: ula port map (
		in_A => "00000000" & SWITCH_HW(7 downto 0),
		in_B => "00000000" & CONT,
		out_ULA => saida_ula,
		op => "001",
		zero => LED_HW(9),
		mq => LED_HW(8)
	 );
			
	-- Processo Exemplo que roda na cadência de clk_div
	process (clk_div_s, rst_proc)
   Begin
		If rst_proc = '1' then
			CONT <= b"0000_0000";
		elsif clk_div_s' event and clk_div_S = '1' then -- sintaxe equivalente a "rising_edge()"
				CONT <= CONT + 1 ; 
		end if;
	end process;

	-- Parte combincional assí­ncrona
	rst_proc  <= not RST_HW;

   -- Sinais ligados ao RAMDisp
	enderecoRAMDisp <= "0000000001111111"; -- endereço 127
	wr_enRAMDisp <= '1';
	dado_inRAMDisp (7 downto 0 ) <= saida_ula(7 downto 0);
	LED_HW(7 downto 0) <= saida_ula(7 downto 0);
	
	
	
END LogicFunction ;


