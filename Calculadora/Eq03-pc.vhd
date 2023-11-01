library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc is
	port(
		clk, wr_en, rst : in std_logic;
		data_in : in unsigned(7 downto 0);
		data_out : out unsigned(7 downto 0)
	);
end entity;

architecture a_pc of pc is
	
begin
	
	process(clk,rst,wr_en) 
	begin
		if rst='1' then
			data_out <= x"00";
		elsif wr_en='1' then
			if rising_edge(clk) then
			data_out <= data_in;
			end if;
		end if;
	end process;
end architecture;
