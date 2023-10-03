LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY ULARegs_tb IS
END ENTITY;

ARCHITECTURE a_ULARegs_tb OF ULARegs_tb IS
	COMPONENT ULARegs IS
	port(   
		CLK: in std_logic;
		zero, mq: out std_logic;
		RST, O_COSN : in std_logic;
		A1,A2,A3,op : in unsigned(2 downto 0);
		WE3 : in std_logic;
		CONS: unsigned(15 DOWNTO 0)
		);

	END COMPONENT;
	
SIGNAL CLK, RST, WE3, O_COSN : std_logic := '0';
SIGNAL A1, A2, A3, op: unsigned(2 downto 0) :="000";
SIGNAL CONS: unsigned(15 DOWNTO 0) :=x"0000";
BEGIN
	uut : ULARegs PORT MAP(CLK=>CLK,RST=>RST,WE3=>WE3,A1=>A1,A2=>A2,A3=>A3,O_COSN=>O_COSN,op=>op,CONS=>CONS);

END ARCHITECTURE;
