library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller_TB is
--  Port ( );
end Controller_TB;

architecture Behavioral of Controller_TB is

    constant px_width : natural := 10;
    constant px_height : natural := 20;
    constant h_sync_duration : natural := 2;
    constant h_front_porch_size : natural := 1;
    constant h_back_porch_size : natural := 1;
    constant h_polarity : std_logic := '0';
    constant v_sync_duration : natural := 2;
    constant v_front_porch_size : natural := 1;
    constant v_back_porch_size : natural := 1;
    constant v_polarity : std_logic := '0';

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';

begin

    DUT : entity work.Controller
        Generic map (
            px_width,
            px_height,
            h_sync_duration,
            h_front_porch_size,
            h_back_porch_size,
            h_polarity,
            v_sync_duration,
            v_front_porch_size,
            v_back_porch_size,
            v_polarity
        )
        Port map (
            clk, reset
        );

    clk_gen : process begin
        clk <= not clk;
        wait for 10 ns;
    end process;

end Behavioral;
