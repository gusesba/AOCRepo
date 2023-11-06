library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
	port(
		clk: in std_logic;
		endereco : in unsigned(7 downto 0);
		dado : out unsigned(31 downto 0)
	);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 127) of unsigned(31 downto 0);
	constant conteudo_rom : mem := (
		-- caso endereco => conteudo (apenas exemplo. Altere para refletir o
		-- programa solicitado)
		0 => "00000000000000000000000000000000",
		1 => b"1000111_100_000_000_0000000000000100",
		2 => b"1000111_101_000_000_0000000000000110",
		3 => b"1000000_110_100_101_0000000000000000",
		4 => b"1000111_110_110_000_1111111111111110",
		5 => b"0001000_000_000_000_0000000000001111",
		15 => b"1000000_100_110_000_0000000000000000",
		16 => b"1100001_111_110_110_0000000000000011",
		17 => b"0001000_000_000_000_0000000000000011",
		-- abaixo: casos omissos => (zero em todos os bits a decodificação do pc
		--é parcial dos 7 least significat bits)
		others => (others=>'0')
	);
	begin
	process(clk)
	begin
		--if(rising_edge(clk)) then
			dado <= conteudo_rom(to_integer(endereco));
		--end if;
	end process;
end architecture;
