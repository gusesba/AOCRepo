LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ROM_PC_UC IS
	port (
		clk, rst : in std_logic
	);
	

END ENTITY;

ARCHITECTURE a_ROM_PC_UC OF ROM_PC_UC IS
	component pc is
		port(
			clk, wr_en, rst : in std_logic;
			data_in : in unsigned(7 downto 0);
			data_out : out unsigned(7 downto 0)
		);
	end component;
	
	component rom is
	port(
		clk : in std_logic;
		endereco : in unsigned(7 downto 0);
		dado : out unsigned(31 downto 0)
	);
	end component;
	
	component uc IS
	PORT (
		jump_en,wr_en,O_CONS, we_ularegs : out std_logic;
		ula_opcode : out unsigned(2 downto 0);
		clk, rst : in std_logic;
		opcode : IN unsigned(6 DOWNTO 0)
	);
	END component;
	
	component ULARegs IS
	port(   
		CLK: in std_logic;
		zero, mq: out std_logic;
		RST, O_CONS : in std_logic;
		A1,A2,A3,op : in unsigned(2 downto 0);
		WE3 : in std_logic;
		CONS: unsigned(15 DOWNTO 0)
		);

	END component;
	
  SIGNAL WR_EN, jump_en_s,o_cons_s, we_ularegs_s : std_logic := '0';
  signal data_in_s, data_out_s : unsigned(7 downto 0) :=x"00";
  signal dado_s : unsigned(31 downto 0):=x"00000000";
  signal opcode_s : unsigned (6 downto 0) :="0000000";
  signal a1_s,a2_s,a3_s,op_s : unsigned(2 downto 0) :="000";
  signal cons_s : unsigned(15 downto 0) :=x"0000";
  
BEGIN
  pc_uut : pc PORT MAP(clk=>clk, wr_en=>WR_EN, rst=>RST, data_in=>data_in_s, data_out=>data_out_s);
  rom_uut : rom port map(clk=>CLK, endereco=>data_out_s, dado=>dado_s);
  uc_uut : uc port map(clk=>CLK, rst=>RST, wr_en=>WR_EN, jump_en=>jump_en_s,opcode=>opcode_s,we_ularegs=>we_ularegs_s,ula_opcode=>op_s,O_CONS=>o_cons_s);
  ularegs_uut : ularegs port map(CLK=>clk, rst=>rst,O_CONS=>o_cons_s,A1=>a1_s,A2=>a2_s,A3=>a3_s,op=>op_s,CONS=>cons_s,WE3=>we_ularegs_s);
  
opcode_s<=dado_s(31 downto 25);
a1_s<=dado_s(21 downto 19);
a2_s<=dado_s(18 downto 16);
a3_s<=dado_s(24 downto 22);
cons_s<=dado_s(15 downto 0);

data_in_s<= dado_s(7 downto 0) when jump_en_s='1' else
	data_out_s + x"01";
	


END ARCHITECTURE;

