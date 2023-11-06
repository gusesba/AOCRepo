LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uc IS
	PORT (
		jump_en,wr_en,O_CONS, we_ularegs : out std_logic;
		ula_opcode : out unsigned(2 downto 0);
		clk,rst : in std_logic;
		opcode : IN unsigned(6 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_uc OF uc IS

component maq_estados is
	port(
		clk, rst : in std_logic;
		estado : out unsigned(1 downto 0)
	);
	end component;

SIGNAL est_s : unsigned(1 downto 0) := "00";
signal ula_s,jump_en_s : std_logic := '0';

BEGIN
  maq_estados_uut : maq_estados port map(clk=>clk, rst =>rst, estado=>est_s);
  
  	ula_s<=opcode(6);
  	wr_en<='1' when est_s="00" or jump_en_s = '1' else
  		'0';

	jump_en_s <= '1' WHEN opcode = "0001000" and est_s = "01" ELSE
		'0';
		
	we_ularegs <= '1' when est_s = "10" and ula_s = '1' else 
		'0';
		
	ula_opcode<=opcode(2 downto 0) when ula_s = '1' else 
		"000";
	O_CONS<='1' when opcode = "1000111" or opcode = "1100001" else
		'0';
		
	jump_en<=jump_en_s;
end architecture;

