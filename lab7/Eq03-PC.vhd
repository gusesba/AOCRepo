-- Equipe 03 -> PC		                12/11/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY pc IS
	PORT (
		clk, wr_en, rst : IN STD_LOGIC;
		data_in : IN unsigned(7 DOWNTO 0);
		data_out : OUT unsigned(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE a_pc OF pc IS

BEGIN

	PROCESS (clk, rst, wr_en)
	BEGIN
		IF rst = '1' THEN
			data_out <= x"00";
		ELSIF wr_en = '1' THEN
			IF rising_edge(clk) THEN
				data_out <= data_in;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;