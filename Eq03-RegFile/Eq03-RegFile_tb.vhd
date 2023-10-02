LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY register_file_tb IS
END ENTITY;

ARCHITECTURE a_register_file_tb OF register_file_tb IS
  COMPONENT register_file IS
    PORT (   	CLK : in std_logic;
		RST : in std_logic;
		A1,A2,A3 : in unsigned(2 downto 0);
		WD3 : in unsigned(15 downto 0);
		WE3 : in std_logic;
		RD1,RD2 : out unsigned(15 downto 0)
		);
  END COMPONENT;

  SIGNAL CLK, RST, WE3 : std_logic;
  SIGNAL WD3, RD1, RD2: unsigned(15 DOWNTO 0);
  SIGNAL A1, A2, A3: unsigned(2 downto 0);

BEGIN
  uut : register_file PORT MAP(CLK=>CLK,RST=>RST,WE3=>WE3,WD3=>WD3,RD1=>RD1,RD2=>RD2,A1=>A1,A2=>A2,A3=>A3);

  PROCESS -- sinal de clock
  BEGIN
    clk <= '0';
    WAIT FOR 50 ns;
    clk <= '1';
    WAIT FOR 50 ns;
  END PROCESS;

  PROCESS -- sinal de reset
  BEGIN
    RST <= '0';
    WAIT FOR 650 ns;
    RST <= '1';
    WAIT FOR 100 ns;
    RST <= '0';
    WAIT;
  END PROCESS;
  PROCESS -- sinais dos casos de teste
  BEGIN
    
    --1000100001101110 110011 RA:2235315
    --1000110010001001 110010 RA:2302578
    --1000010110111110 010101 RA:2191253
    
    
    WE3 <= '0';
    A3 <= "001";
    WD3 <= "1000100001101110";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A2 <= "001";
    
    A3 <= "010";
    WD3 <= "1000110010001001";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A2 <= "010";
    
    A3 <= "011";
    WD3 <= "1000010110111110";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A2 <= "011";
    
    wait for 200 ns;
    
    A2 <= "000";
    A3 <= "001";
    WD3 <= "1000100001101110";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A1 <= "001";
    
    A3 <= "010";
    WD3 <= "1000110010001001";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A1 <= "010";
    
    A3 <= "011";
    WD3 <= "1000010110111110";
    WAIT FOR 100 ns;
    WE3 <= '1';    
    WAIT FOR 100 ns;
    WE3 <= '0';
    A1 <= "011";
    
    
    wait;
  END PROCESS;
END ARCHITECTURE;
