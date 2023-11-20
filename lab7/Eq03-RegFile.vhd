-- Equipe 03 -> RegFile                 12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY register_file IS
	PORT (
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		A1, A2, A3 : IN unsigned(2 DOWNTO 0);
		WD3 : IN unsigned(15 DOWNTO 0);
		WE3 : IN STD_LOGIC;
		RD1, RD2 : OUT unsigned(15 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_register_file OF register_file IS
	COMPONENT reg16bits IS
		PORT (
			clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			wr_en : IN STD_LOGIC;
			data_in : IN unsigned(15 DOWNTO 0);
			data_out : OUT unsigned(15 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : unsigned(15 DOWNTO 0) := x"0000";
	SIGNAL reg0o, reg1o, reg2o, reg3o, reg4o, reg5o, reg6o, reg7o : unsigned(15 DOWNTO 0) := x"0000";
	SIGNAL saidaA, saidaB, entrada : unsigned(2 DOWNTO 0) := "000";
BEGIN
	R0 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg0, data_out => reg0o);
	R1 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg1, data_out => reg1o);
	R2 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg2, data_out => reg2o);
	R3 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg3, data_out => reg3o);
	R4 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg4, data_out => reg4o);
	R5 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg5, data_out => reg5o);
	R6 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg6, data_out => reg6o);
	R7 : reg16bits PORT MAP(clk => CLK, rst => RST, wr_en => WE3, data_in => reg7, data_out => reg7o);

	saidaA <= A1;
	saidaB <= A2;
	entrada <= A3;

	RD1 <= reg0o WHEN saidaA = "000" ELSE
		reg1o WHEN saidaA = "001" ELSE
		reg2o WHEN saidaA = "010" ELSE
		reg3o WHEN saidaA = "011" ELSE
		reg4o WHEN saidaA = "100" ELSE
		reg5o WHEN saidaA = "101" ELSE
		reg6o WHEN saidaA = "110" ELSE
		reg7o WHEN saidaA = "111" ELSE
		"0000000000000000";

	RD2 <= reg0o WHEN saidaB = "000" ELSE
		reg1o WHEN saidaB = "001" ELSE
		reg2o WHEN saidaB = "010" ELSE
		reg3o WHEN saidaB = "011" ELSE
		reg4o WHEN saidaB = "100" ELSE
		reg5o WHEN saidaB = "101" ELSE
		reg6o WHEN saidaB = "110" ELSE
		reg7o WHEN saidaB = "111" ELSE
		"0000000000000000";

	reg0 <= "0000000000000000";
	reg1 <= WD3 WHEN entrada = "001" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg1;
	reg2 <= WD3 WHEN entrada = "010" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg2;
	reg3 <= WD3 WHEN entrada = "011" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg3;
	reg4 <= WD3 WHEN entrada = "100" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg4;
	reg5 <= WD3 WHEN entrada = "101" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg5;
	reg6 <= WD3 WHEN entrada = "110" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg6;
	reg7 <= WD3 WHEN entrada = "111" AND WE3 = '1'
		ELSE
		x"0000" WHEN RST = '1'
		ELSE
		reg7;

END ARCHITECTURE;