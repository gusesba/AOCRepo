LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
	PORT (
		clk : IN STD_LOGIC;
		endereco : IN unsigned(7 DOWNTO 0);
		dado : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_rom OF rom IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned(7 DOWNTO 0);
	CONSTANT conteudo_rom : mem := (
		-- caso endereco => conteudo (apenas exemplo. Altere para refletir o
		-- programa solicitado)
		0 => "11000001",
		1 => "11000101",
		2 => "00011110",
		3 => "00000001",
		4 => "10000101",
		5 => "11000111",
		6 => "10100011",
		7 => "00000010",
		8 => "00000010",
		9 => "11000011",
		10 => "00000000",
		15 => "11000001",
		-- abaixo: casos omissos => (zero em todos os bits a decodificação do pc
		--é parcial dos 7 least significat bits)
		OTHERS => (OTHERS => '0')
	);
BEGIN
	PROCESS (clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			dado <= conteudo_rom(to_integer(endereco));
		END IF;
	END PROCESS;
END ARCHITECTURE;