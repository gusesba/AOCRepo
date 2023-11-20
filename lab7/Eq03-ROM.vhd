-- Equipe 03 -> ROM		                12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY rom IS
	PORT (
		clk : IN STD_LOGIC;
		endereco : IN unsigned(7 DOWNTO 0);
		dado : OUT unsigned(31 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_rom OF rom IS
	TYPE mem IS ARRAY (0 TO 127) OF unsigned(31 DOWNTO 0);
	CONSTANT conteudo_rom : mem := (
		-- caso endereco => conteudo (apenas exemplo. Altere para refletir o
		-- programa solicitado)
		0 => "00000000000000000000000000000000", 
		1 => b"1000111_100_000_000_0000000000000010", -- somar_cte r4 = 4 (a)
		2 => b"1000111_101_000_000_0000000000001010", -- somar_cte r5 = 10 (b)
		3 => b"1000111_110_110_000_0000000000000001", -- soma r6 = r6 + 1
		4 => b"1000000_010_010_100_0000000000000000", -- r2 = r2 + r4
		5 => b"1011110_000_110_101_0000000000000011", -- BNE r6, r5
		6 => b"0001000_000_000_000_0000000000000110",-- jump
		-- abaixo: casos omissos => (zero em todos os bits a decodificação do pc
		--é parcial dos 7 least significat bits)
		OTHERS => (OTHERS => '0')
	);
BEGIN
	PROCESS (clk)
	BEGIN
		--if(rising_edge(clk)) then
		dado <= conteudo_rom(to_integer(endereco));
		--end if;
	END PROCESS;
END ARCHITECTURE;
