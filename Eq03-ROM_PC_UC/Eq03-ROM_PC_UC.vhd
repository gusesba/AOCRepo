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
			dado : OUT unsigned(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT uc IS
		PORT (
			jump_en, wr_en : OUT STD_LOGIC;
			clk, rst : IN STD_LOGIC;
			opcode : IN unsigned(1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL WR_EN, jump_en_s : STD_LOGIC := '0';
	SIGNAL data_in_s, data_out_s, dado_s : unsigned(7 DOWNTO 0) := x"00";
	SIGNAL opcode_s : unsigned (1 DOWNTO 0) := "00";

BEGIN
	pc_uut : pc PORT MAP(clk => clk, wr_en => WR_EN, rst => RST, data_in => data_in_s, data_out => data_out_s);
	rom_uut : rom PORT MAP(clk => CLK, endereco => data_out_s, dado => dado_s);
	uc_uuc : uc PORT MAP(clk => CLK, rst => RST, wr_en => WR_EN, jump_en => jump_en_s, opcode => opcode_s);

	opcode_s <= dado_s(7 DOWNTO 6);

	data_in_s <= "00" & dado_s(5 DOWNTO 0) WHEN jump_en_s = '1' ELSE
		data_out_s + x"01";

END ARCHITECTURE;