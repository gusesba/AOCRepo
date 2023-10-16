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
		jump_en,wr_en : out unsigned;
		opcode : IN unsigned(1 DOWNTO 0)
	);
	END component;
	
  SIGNAL CLK_s, RST_s, WR_EN : std_logic := '0';
  signal data_in_s, data_out_s, dado_s, dado_out : unsigned(7 downto 0) :=x"00";
  
BEGIN
  pc_uut : pc PORT MAP(clk=>CLK_s, wr_en=>WR_EN, rst=>RST_s, data_in=>data_in_s, data_out=>data_out_s);
  rom_uut : rom port map(clk=>CLK_s, endereco=>data_out_s, dado=>dado_s);
  uc_uuc : uc port map();
  
  data_in_s<= data_in_s + x"01" when rising_edge(est_s) else
	data_in_s; 
  dado_out<=dado_s when rising_edge(est_s) else
	dado_out; 
 WR_EN <= '1' when rising_edge(est_s) else 
 	'0';
	

END ARCHITECTURE;

