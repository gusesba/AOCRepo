LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ROM_PC_UC_tb IS
END ENTITY;

ARCHITECTURE a_ROM_PC_UC_tb OF ROM_PC_UC_tb IS
	component ROM_PC_UC IS
	port (
		clk, rst : in std_logic
	);
	

	END component;
	
  SIGNAL CLK_s, RST_s: std_logic := '0';
  
BEGIN
 uut : ROM_PC_UC port map(clk=>CLK_s,rst=>RST_s);
 
   
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
    wait for 200 ns;
    RST_s <= '0';
    WAIT;
  END PROCESS;

END ARCHITECTURE;

