-- Equipe 03 -> ROM_PC_UC                    12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ROM_PC_UC IS
	PORT (
		clk, rst : IN STD_LOGIC
	);
END ENTITY;

ARCHITECTURE a_ROM_PC_UC OF ROM_PC_UC IS
	COMPONENT pc IS
		PORT (
			clk, wr_en, rst : IN STD_LOGIC;
			data_in : IN unsigned(7 DOWNTO 0);
			data_out : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT rom IS
		PORT (
			clk : IN STD_LOGIC;
			endereco : IN unsigned(7 DOWNTO 0);
			dado : OUT unsigned(31 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT uc IS
		PORT (
			jump_en, wr_en, O_CONS, we_ularegs : OUT STD_LOGIC;
			ula_opcode : OUT unsigned(2 DOWNTO 0);
			clk, rst, zero, mq : IN STD_LOGIC;
			opcode : IN unsigned(6 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT ULARegs IS
		PORT (
			CLK : IN STD_LOGIC;
			zero, mq : OUT STD_LOGIC;
			RST, O_CONS : IN STD_LOGIC;
			A1, A2, A3, op : IN unsigned(2 DOWNTO 0);
			WE3 : IN STD_LOGIC;
			CONS : unsigned(15 DOWNTO 0)
		);

	END COMPONENT;

	SIGNAL WR_EN, jump_en_s, o_cons_s, we_ularegs_s, zero_s, mq_s  : STD_LOGIC := '0';
	SIGNAL data_in_s, data_out_s : unsigned(7 DOWNTO 0) := x"00";
	SIGNAL dado_s : unsigned(31 DOWNTO 0) := x"00000000";
	SIGNAL opcode_s : unsigned (6 DOWNTO 0) := "0000000";
	SIGNAL a1_s, a2_s, a3_s, op_s : unsigned(2 DOWNTO 0) := "000";
	SIGNAL cons_s : unsigned(15 DOWNTO 0) := x"0000";

BEGIN
	pc_uut : pc PORT MAP(clk => clk, wr_en => WR_EN, rst => RST, data_in => data_in_s, data_out => data_out_s);
	rom_uut : rom PORT MAP(clk => CLK, endereco => data_out_s, dado => dado_s);
	uc_uut : uc PORT MAP(clk => CLK, rst => RST, wr_en => WR_EN, jump_en => jump_en_s, opcode => opcode_s, we_ularegs => we_ularegs_s, ula_opcode => op_s, O_CONS => o_cons_s, zero=>zero_s, mq=>mq_s);
	ularegs_uut : ularegs PORT MAP(CLK => clk, rst => rst, O_CONS => o_cons_s, A1 => a1_s, A2 => a2_s, A3 => a3_s, op => op_s, CONS => cons_s, WE3 => we_ularegs_s, zero=>zero_s, mq=>mq_s);

	opcode_s <= dado_s(31 DOWNTO 25);
	a1_s <= dado_s(21 DOWNTO 19);
	a2_s <= dado_s(18 DOWNTO 16);
	a3_s <= dado_s(24 DOWNTO 22);
	cons_s <= dado_s(15 DOWNTO 0);

	data_in_s <= dado_s(7 DOWNTO 0) WHEN jump_en_s = '1' ELSE
		data_out_s + x"01";

END ARCHITECTURE;
