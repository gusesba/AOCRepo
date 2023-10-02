-- Equipe 03 -> ULA                     24/08/2023
-- Polianna Beatriz Basso               RA: 2302578
-- José Mário Nishihara de Albuquerque  RA: 2191253
-- Gustavo Esmanhotto Bareta            RA: 2235315

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula_tb IS
END;

ARCHITECTURE a_ula_tb OF ula_tb IS
    COMPONENT ula
        PORT (
            in_A, in_B : IN UNSIGNED(15 DOWNTO 0);
            op : IN UNSIGNED(2 DOWNTO 0);
            out_ULA : OUT UNSIGNED(15 DOWNTO 0);
            zero, mq : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL s_in_A, s_in_B, s_out_ULA : UNSIGNED(15 DOWNTO 0);
    SIGNAL s_op : UNSIGNED(2 DOWNTO 0);
    SIGNAL s_zero, s_mq : STD_LOGIC;
BEGIN
    uut : ula PORT MAP(
        in_A => s_in_A,
        in_B => s_in_B,
        op => s_op,
        out_ULA => s_out_ULA,
        zero => s_zero,
        mq => s_mq
    );

    PROCESS
    BEGIN
        --soma 
        s_in_A <= "0000000001111101"; --125
        s_in_B <= "0000000011111111"; --255
        s_op <= "000";
        WAIT FOR 50 ns;
        --divisao dos RAs e flag maior que
        s_in_A <= "0000101000010010"; --2578
        s_in_B <= "0000010011100101"; --1253
        s_op <= "001";
        WAIT FOR 50 ns;
        --divisao dos RAs e flag maior que
        s_in_A <= "0001010011000011"; --5315
        s_in_B <= "0000010011100101"; --1253
        s_op <= "001";
        WAIT FOR 50 ns;
        --resto da divisão e flag zero
        s_in_A <= "0000000001100100"; --100
        s_in_B <= "0000000000001010"; --10
        s_op <= "010";
        WAIT FOR 50 ns;
        --multiplicacao (estourando os 16 bits)
        s_in_A <= "1111111111111111";
        s_in_B <= "1111111111111111";
        s_op <= "011";
        WAIT FOR 50 ns;
        --xor 
        s_in_A <= "1010101010101010";
        s_in_B <= "0101010101010101";
        s_op <= "100";
        WAIT FOR 50 ns;
        --not A
        s_in_A <= "1111111111111111";
        s_op <= "101";
        WAIT FOR 50 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE;