LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ULARegs IS
	port(   
		CLK: in std_logic;
		zero, mq: out std_logic;
		RST, O_COSN : in std_logic;
		A1,A2,A3,op : in unsigned(2 downto 0);
		WE3 : in std_logic;
		CONS: unsigned(15 DOWNTO 0)
		);

END ENTITY;

ARCHITECTURE a_ULARegs OF ULARegs IS
	COMPONENT register_file IS
		PORT (   	
		CLK : in std_logic;
		RST : in std_logic;
		A1,A2,A3 : in unsigned(2 downto 0);
		WD3 : in unsigned(15 downto 0);
		WE3 : in std_logic;
		RD1,RD2 : out unsigned(15 downto 0)
		);
	END COMPONENT;

	COMPONENT ula
		PORT (
		in_A, in_B : IN UNSIGNED(15 DOWNTO 0);
		op : IN UNSIGNED(2 DOWNTO 0);
		out_ULA : OUT UNSIGNED(15 DOWNTO 0);
		zero, mq : OUT STD_LOGIC
		);
	END COMPONENT;
	
	SIGNAL S_CONS: unsigned(15 DOWNTO 0) :=x"0000";
	SIGNAL S_RD1, S_RD2, S_WD3: unsigned(15 DOWNTO 0) :=x"0000";
	SIGNAL S_A1, S_A2, S_A3: unsigned(2 downto 0) :="000";
	
BEGIN
	aaa : register_file PORT MAP(CLK=>CLK,RST=>RST,WE3=>WE3,WD3=>S_WD3,RD1=>S_RD1,RD2=>S_RD2,A1=>A1,A2=>A2,A3=>A3);
	bbb : ula PORT MAP(in_A=>S_RD1,in_B=>S_RD2,out_ULA=>S_WD3,op=>op,zero=>zero,mq=>mq);
END ARCHITECTURE;

