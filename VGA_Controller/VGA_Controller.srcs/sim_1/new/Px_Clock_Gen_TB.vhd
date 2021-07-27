library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Px_Clock_Gen_TB is
--  Port ( );
end Px_Clock_Gen_TB;

architecture Behavioral of Px_Clock_Gen_TB is

    signal px_clk : std_logic;

begin

    DUT : entity work.Px_Clock_Gen
        Generic map (
            px_width => 800,
            px_height => 420,
            refresh_rate => 60.0
        )
        Port map (
            px_clk => px_clk
        );


end Behavioral;
