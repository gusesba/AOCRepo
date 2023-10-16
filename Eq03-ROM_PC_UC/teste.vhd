LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY tb IS
END ENTITY;

ARCHITECTURE a_tb OF tb IS
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

  COMPONENT maq_estados IS
    PORT (
      clk, rst : IN STD_LOGIC;
      estado : OUT STD_LOGIC
    );
  END COMPONENT;

  SIGNAL CLK, RST, WR_EN, est_s : STD_LOGIC := '0';
  SIGNAL data_in_s, data_out_s, dado_s, dado_out : unsigned(7 DOWNTO 0) := x"00";

BEGIN
  pc_uut : pc PORT MAP(clk => CLK, wr_en => WR_EN, rst => RST, data_in => data_in_s, data_out => data_out_s);
  rom_uut : rom PORT MAP(clk => CLK, endereco => data_out_s, dado => dado_s);
  maq_estados_uut : maq_estados PORT MAP(clk => CLK, rst => RST, estado => est_s);

  data_in_s <= data_in_s + x"01" WHEN rising_edge(est_s) ELSE
    data_in_s;
  dado_out <= dado_s WHEN falling_edge(est_s) ELSE
    dado_out;
  PROCESS -- sinal de clock
  BEGIN
    clk <= '0';
    WAIT FOR 50 ns;
    clk <= '1';
    WAIT FOR 50 ns;
  END PROCESS;

  PROCESS -- sinal de reset
  BEGIN
    RST <= '1';
    WR_EN <= '1';
    WAIT FOR 10 ns;
    RST <= '0';
    WAIT;
  END PROCESS;
END ARCHITECTURE;