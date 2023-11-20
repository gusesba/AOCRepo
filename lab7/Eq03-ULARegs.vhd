-- Equipe 03 -> ULARegs                 12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ULARegs IS
	PORT (
		CLK : IN STD_LOGIC;
		zero, mq : OUT STD_LOGIC;
		RST, O_CONS : IN STD_LOGIC;
		A1, A2, A3, op : IN unsigned(2 DOWNTO 0);
		WE3 : IN STD_LOGIC;
		CONS : unsigned(15 DOWNTO 0)
	);

END ENTITY;

ARCHITECTURE a_ULARegs OF ULARegs IS
	COMPONENT register_file IS
		PORT (
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			A1, A2, A3 : IN unsigned(2 DOWNTO 0);
			WD3 : IN unsigned(15 DOWNTO 0);
			WE3 : IN STD_LOGIC;
			RD1, RD2 : OUT unsigned(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ula
		PORT (
			in_A, in_B : IN UNSIGNED(15 DOWNTO 0);
			op : IN UNSIGNED(2 DOWNTO 0);
			out_ULA : OUT UNSIGNED(15 DOWNTO 0);
			zero, mq : OUT STD_LOGIC
		);
	END COMPONENT;

	SIGNAL S_CONS : unsigned(15 DOWNTO 0) := x"0000";
	SIGNAL S_RD1, S_RD2, S_WD3 : unsigned(15 DOWNTO 0) := x"0000";
	SIGNAL S_A1, S_A2, S_A3 : unsigned(2 DOWNTO 0) := "000";

BEGIN
	aaa : register_file PORT MAP(CLK => CLK, RST => RST, WE3 => WE3, WD3 => S_WD3, RD1 => S_RD1, RD2 => S_RD2, A1 => A1, A2 => A2, A3 => A3);
	bbb : ula PORT MAP(in_A => S_RD1, in_B => S_CONS, out_ULA => S_WD3, op => op, zero => zero, mq => mq);

	S_CONS <= CONS WHEN O_CONS = '1' ELSE
		S_RD2;
END ARCHITECTURE;