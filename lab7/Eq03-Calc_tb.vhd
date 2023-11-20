-- Equipe 03 -> TestBench Calc     12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ROM_PC_UC_tb IS
END ENTITY;

ARCHITECTURE a_ROM_PC_UC_tb OF ROM_PC_UC_tb IS
  COMPONENT ROM_PC_UC IS
    PORT (
      clk, rst : IN STD_LOGIC
    );
  END COMPONENT;

  SIGNAL CLK_s, RST_s : STD_LOGIC := '0';

BEGIN
  uut : ROM_PC_UC PORT MAP(clk => CLK_s, rst => RST_s);
  PROCESS -- sinal de clock
  BEGIN
    clk_s <= '0';
    WAIT FOR 50 ns;
    clk_s <= '1';
    WAIT FOR 50 ns;
  END PROCESS;

  PROCESS -- sinal de reset
  BEGIN
    RST_s <= '1';
    WAIT FOR 200 ns;
    RST_s <= '0';
    WAIT;
  END PROCESS;

END ARCHITECTURE;