-- Equipe 03 -> Maquina de estados      12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY maq_estados IS
	PORT (
		clk, rst : IN STD_LOGIC;
		estado : OUT unsigned(1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_maq_estados OF maq_estados IS
	SIGNAL estado_s : unsigned(1 DOWNTO 0) := "00";
BEGIN
	PROCESS (clk, rst)
	BEGIN
		IF rst = '1' THEN
			estado_s <= "00";
		ELSIF rising_edge(clk) THEN
			IF estado_s = "10" THEN
				estado_s <= "00";
			ELSE
				estado_s <= estado_s + 1;
			END IF;
		END IF;
	END PROCESS;
	estado <= estado_s;
END ARCHITECTURE;