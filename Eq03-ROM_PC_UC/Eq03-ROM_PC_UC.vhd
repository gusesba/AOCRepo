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
		dado : out unsigned(7 downto 0)
	);
	end component;
	
	component uc IS
	PORT (
		jump_en,wr_en : out std_logic;
		clk, rst : in std_logic;
		opcode : IN unsigned(1 DOWNTO 0)
	);
	END component;
	
  SIGNAL WR_EN, jump_en_s : std_logic := '0';
  signal data_in_s, data_out_s, dado_s : unsigned(7 downto 0) :=x"00";
  signal opcode_s : unsigned (1 downto 0) :="00";
  
BEGIN
  pc_uut : pc PORT MAP(clk=>clk, wr_en=>WR_EN, rst=>RST, data_in=>data_in_s, data_out=>data_out_s);
  rom_uut : rom port map(clk=>CLK, endereco=>data_out_s, dado=>dado_s);
  uc_uuc : uc port map(clk=>CLK, rst=>RST, wr_en=>WR_EN, jump_en=>jump_en_s,opcode=>opcode_s);
  
opcode_s<=dado_s(7 downto 6);

data_in_s<= "00"&dado_s(5 downto 0) when jump_en_s='1' else
	data_out_s + x"01";
	


END ARCHITECTURE;

