----------------------------------------------------------------------------------
-- Engineer: Thomas Nonis
-- Project Name: VGA Controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Img_Tester_TB is
--  Port ( );
end Img_Tester_TB;

architecture Behavioral of Img_Tester_TB is

    constant px_width : natural := 640;
    constant px_height : natural := 480;

    constant display_enable : std_logic := '1';

    signal col : natural := 0;
    signal row : natural := 0;

begin

    DUT : entity work.Img_Tester
        Generic map (
            px_width, px_height
        )
        Port map (
            display_enable, col, row
        );

    process begin
        for i in 0 to px_height - 1 loop
            row <= i;
            for j in 0 to px_width - 1 loop
                col <= j;
                wait for 10 ns;
            end loop;
        end loop;
    end process;
    
end Behavioral;
