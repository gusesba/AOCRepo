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
		RST, O_CONS : in std_logic;
		A1,A2,A3,op : in unsigned(2 downto 0);
		WE3 : in std_logic;
		CONS: unsigned(15 DOWNTO 0)
		);

	END COMPONENT;
	
SIGNAL CLK, RST, WE3, O_CONS : std_logic := '0';
SIGNAL A1, A2, A3, op: unsigned(2 downto 0) :="000";
SIGNAL CONS: unsigned(15 DOWNTO 0) :=x"0000";
BEGIN
	uut : ULARegs PORT MAP(CLK=>CLK,RST=>RST,WE3=>WE3,A1=>A1,A2=>A2,A3=>A3,O_CONS=>O_CONS,op=>op,CONS=>CONS);
	
	 --1000100001101110 110011 RA:2235315
	 --1000110010001001 110010 RA:2302578
	 --1000010110111110 010101 RA:2191253
	 
	 
	 
	
	 PROCESS -- sinal de clock
	 BEGIN
	    CLK <= '0';
	    WAIT FOR 50 ns;
	    CLK <= '1';
	    WAIT FOR 50 ns;
	 END PROCESS;
	 
	 PROCESS -- sinal de reset
	 BEGIN
	    RST <= '1';
	    wait for 100 ns;
	    RST <= '0';
	    WAIT;
	 END PROCESS;
	 
	 PROCESS -- sinais dos casos de teste
	 BEGIN
	 
	 	WAIT FOR 100 ns;
	 
	 
		WE3 <= '0';
		A3 <= "110";
		CONS <= "1000100001101110";
		O_CONS	 <= '1';
		WAIT FOR 10 ns;
		WE3 <= '1';    
		WAIT FOR 90 ns;
		WE3 <= '0';
		A2 <= "110";
		
		A3 <= "111";
		CONS <= "1000110010001001";
		O_CONS	 <= '1';
		WAIT FOR 10 ns;
		WE3 <= '1';    
		WAIT FOR 90 ns;
		WE3 <= '0';
		A1 <= "111";
		
		A3 <= "110";
		O_CONS	 <= '0';
		op <= "001";
		WAIT FOR 10 ns;
		WE3 <= '1';    
		WAIT FOR 90 ns;
		WE3 <= '0';
		
		A3 <= "110";
		O_CONS	 <= '0';
		op <= "001";
		A1 <= "110";
		A2 <= "000";
		WAIT FOR 10 ns;
		WE3 <= '1';    
		WAIT FOR 90 ns;
		WE3 <= '0';
		A1 <= "110";
		
		
		
	 
	 
	 wait;
 	 END PROCESS;
	 

END ARCHITECTURE;
