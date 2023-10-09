LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY tb IS
END ENTITY;

ARCHITECTURE a_tb OF tb IS
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
	
  SIGNAL CLK, RST, WR_EN : std_logic := '0';
  signal data_in_s, data_out_s : unsigned(7 downto 0) :=x"00";
  
BEGIN
  uut : pc PORT MAP(clk=>CLK, wr_en=>WR_EN, rst=>RST, data_in=>data_in_s, data_out=>data_out_s);
  uut2: rom port map(clk=>CLK, endereco=>data_out_s);
  
  
  PROCESS -- sinal de clock
  BEGIN
    clk <= '0';
    data_in_s<= data_in_s + x"01";
    WAIT FOR 50 ns;
    clk <= '1';
    WAIT FOR 50 ns;
  END PROCESS;

  PROCESS -- sinal de reset
  BEGIN
    RST <= '1';
    WR_EN <= '1';
    wait for 50 ns;
    RST <= '0';
    WAIT;
  END PROCESS;
END ARCHITECTURE;

