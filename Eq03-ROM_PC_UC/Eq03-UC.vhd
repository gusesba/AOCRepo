LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY uc IS
	PORT (
		jump_en,wr_en : out std_logic;
		clk,rst : in std_logic;
		opcode : IN unsigned(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_uc OF uc IS

component maq_estados is
	port(
		clk, rst : in std_logic;
		estado : out std_logic
	);
	end component;

SIGNAL est_s : std_logic := '0';

BEGIN
  maq_estados_uut : maq_estados port map(clk=>clk, rst =>rst, estado=>est_s);
  
  	wr_en<='0' when est_s='0' else
  		'1';

	jump_en <= '1' WHEN opcode = "11" ELSE
		'0';
		
end architecture;

