-- Equipe 03 -> UC                      12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uc IS
	PORT (
		jump_en, wr_en, O_CONS, we_ularegs : OUT STD_LOGIC;
		ula_opcode : OUT unsigned(2 DOWNTO 0);
		clk, rst, zero, mq : IN STD_LOGIC;
		opcode : IN unsigned(6 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_uc OF uc IS

	COMPONENT maq_estados IS
		PORT (
			clk, rst : IN STD_LOGIC;
			estado : OUT unsigned(1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL est_s : unsigned(1 DOWNTO 0) := "00";
	SIGNAL ula_s, jump_en_s: STD_LOGIC := '0';

BEGIN
	maq_estados_uut : maq_estados PORT MAP(clk => clk, rst => rst, estado => est_s);

	ula_s <= opcode(6);
	wr_en <= '1' WHEN est_s = "10" ELSE
		'0';

	jump_en_s <= '1' WHEN (opcode = "0001000") or (opcode = "1010110"  and zero='1') or (opcode = "1011110"  and zero='0') or (opcode = "0000010"  and mq='1') or (opcode = "0000001"  and mq='0') ELSE '0';
		

	we_ularegs <= '1' WHEN est_s = "10" AND ula_s = '1' ELSE
		'0';

	ula_opcode <= opcode(2 DOWNTO 0) WHEN ula_s = '1' ELSE
		"000";
	O_CONS <= '1' WHEN opcode = "1000111" OR opcode = "1100001" ELSE
		'0';

	jump_en <= jump_en_s;
END ARCHITECTURE;
