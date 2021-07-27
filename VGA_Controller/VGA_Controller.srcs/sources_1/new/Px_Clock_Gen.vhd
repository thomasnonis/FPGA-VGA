----------------------------------------------------------------------------------
-- Engineer: Thomas Nonis
-- Project Name: VGA Controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Px_Clock_Gen is
    Generic (
        px_width : natural;
        px_height : natural;
        refresh_rate : real;
        h_sync_duration : natural;  -- duration of the horizontal sync pulse (in px)
        h_front_porch_size : natural;
        h_back_porch_size : natural;
        v_sync_duration : natural;  -- duration of the horizontal sync pulse (in px)
        v_front_porch_size : natural;
        v_back_porch_size : natural
    );
    Port (
        -- board_clk : in std_logic;
        px_clk : buffer std_logic := '0'
    );
end Px_Clock_Gen;

architecture Behavioral of Px_Clock_Gen is

    -- constant h_tot : natural := px_width + h_front_porch_size + h_sync_duration + h_back_porch_size;
    -- constant v_tot : natural := px_height + v_front_porch_size + v_sync_duration + v_back_porch_size;
    
    -- constant clk_period : time := 1 sec / (h_tot * v_tot * refresh_rate);

    constant frequency : real := 25175000;
    constant clk_period : time := 1 sec / frequency;

    begin
        
        px_clk <= not px_clk after clk_period;



end Behavioral;
