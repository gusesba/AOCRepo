library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
	port(   CLK : in std_logic;
		RST : in std_logic;
		A1,A2,A3 : in unsigned(2 downto 0);
		WD3 : in unsigned(15 downto 0);
		WE3 : in std_logic;
		RD1,RD2 : out unsigned(15 downto 0)
		);
end entity;

architecture a_register_file of register_file is
	component reg16bits is 
		port(   clk : in std_logic;
			rst : in std_logic;
			wr_en : in std_logic;
			data_in : in unsigned(15 downto 0);
			data_out : out unsigned(15 downto 0)
			);
	end component;
	signal reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7: unsigned(15 downto 0) :=x"0000";
	signal reg0o,reg1o,reg2o,reg3o,reg4o,reg5o,reg6o,reg7o: unsigned(15 downto 0) :=x"0000";
	signal saidaA,saidaB,entrada: unsigned(2 downto 0) :="000";
begin
	R0: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg0,data_out=>reg0o);
	R1: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg1,data_out=>reg1o);
	R2: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg2,data_out=>reg2o);
	R3: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg3,data_out=>reg3o);
	R4: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg4,data_out=>reg4o);
	R5: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg5,data_out=>reg5o);
	R6: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg6,data_out=>reg6o);
	R7: reg16bits port map(clk=>CLK,rst=>RST,wr_en=>WE3,data_in=>reg7,data_out=>reg7o);
	
	saidaA <= A1;
	saidaB <= A2;
	entrada <= A3;
	
	RD1 <=  reg0o when saidaA = "000" else
		reg1o when saidaA = "001" else
		reg2o when saidaA = "010" else
		reg3o when saidaA = "011" else
		reg4o when saidaA = "100" else
		reg5o when saidaA = "101" else
		reg6o when saidaA = "110" else
		reg7o when saidaA = "111" else
		"0000000000000000";
		
	RD2 <=  reg0o when saidaB = "000" else
		reg1o when saidaB = "001" else
		reg2o when saidaB = "010" else
		reg3o when saidaB = "011" else
		reg4o when saidaB = "100" else
		reg5o when saidaB = "101" else
		reg6o when saidaB = "110" else
		reg7o when saidaB = "111" else
		"0000000000000000";
	
	reg0 <= "0000000000000000";	
	reg1 <= WD3 when entrada = "001" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg1;
	reg2 <= WD3 when entrada = "010" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg2;
	reg3 <= WD3 when entrada = "011" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg3;
	reg4 <= WD3 when entrada = "100" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg4;
	reg5 <= WD3 when entrada = "101" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg5;
	reg6 <= WD3 when entrada = "110" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg6;
	reg7 <= WD3 when entrada = "111" and WE3 = '1'
		else x"0000" when RST = '1'
		else reg7;
	
	
		
end architecture;

