-- Equipe 03 -> ULA                     24/08/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT (
        in_A, in_B : IN UNSIGNED(15 DOWNTO 0);
        op : IN UNSIGNED(2 DOWNTO 0);
        out_ULA : OUT UNSIGNED(15 DOWNTO 0);
        zero, mq : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_ula OF ula IS
    SIGNAL s_in_A, s_in_B, s_out_ULA : UNSIGNED(15 DOWNTO 0) := "0000000000000000";
    SIGNAL s_op : UNSIGNED(2 DOWNTO 0) := "000";
    SIGNAL s_mul : UNSIGNED(31 DOWNTO 0);
BEGIN
    s_in_A <= in_A;
    s_in_B <= in_B;
    s_op <= op;
    s_mul <= s_in_A * s_in_B WHEN s_op = "011" ELSE
        "00000000000000000000000000000000";
    s_out_ULA <= s_in_A + s_in_B WHEN s_op = "000" ELSE
        s_in_A / s_in_B WHEN s_op = "001" ELSE
        s_in_A MOD s_in_B WHEN s_op = "010" ELSE
        s_mul(15 DOWNTO 0) WHEN s_op = "011" ELSE
        s_in_A XOR s_in_B WHEN s_op = "100" ELSE
        NOT s_in_A WHEN s_op = "101" ELSE
        "0000000000000000";
    zero <= '1' WHEN s_out_ULA = "0000000000000000" ELSE
        '0';
    mq <= '1' WHEN s_in_A > s_in_B ELSE
        '0';
    out_ULA <= s_out_ULA;
END ARCHITECTURE;