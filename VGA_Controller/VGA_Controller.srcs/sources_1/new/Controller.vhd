----------------------------------------------------------------------------------
-- Engineer: Thomas Nonis
-- Project Name: VGA Controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
    Generic(
        px_width : natural;         -- horizontal display size
        px_height : natural;        -- vertical display size
        h_sync_duration : natural;  -- duration of the horizontal sync pulse (in px)
        h_front_porch_size : natural;
        h_back_porch_size : natural;
        h_polarity : std_logic;     -- 1 active high, 0 active low
        v_sync_duration : natural;  -- duration of the horizontal sync pulse (in px)
        v_front_porch_size : natural;
        v_back_porch_size : natural;
        v_polarity : std_logic      -- 1 active high, 0 active low
    );
    Port(
        clk : in std_logic;
        reset : in std_logic;
        h_sync : out std_logic;
        v_sync : out std_logic;
        display_enable : out std_logic;
        col : out natural;
        row : out natural;
        blank : out std_logic;
        sync_on_screen : out std_logic
    );
end Controller;

architecture Behavioral of Controller is

    constant h_tot : natural := px_width + h_front_porch_size + h_sync_duration + h_back_porch_size;
    constant v_tot : natural := px_height + v_front_porch_size + v_sync_duration + v_back_porch_size;

    -- signal row_dbg, col_dbg : natural;

begin

    process (clk, reset) is
        variable h_counter : natural := 0;
        variable v_counter : natural := 0;
    begin
        if reset = '0' then
            h_counter := 0;
            v_counter := 0;
            h_sync <= not h_polarity;
            v_sync <= not v_polarity;
            display_enable <= '0';
            col <= 0;
            row <= 0;
        elsif rising_edge(clk) then

            -- Update current px counters
            if h_counter >= h_tot - 1 then
                h_counter := 0;
                if v_counter >= v_tot - 1 then
                    v_counter := 0;
                else
                    v_counter := v_counter + 1;
                end if;
            else
                h_counter := h_counter + 1;    
            end if;

            -- Generate horizontal sync pulse
            if h_counter >= px_width + h_front_porch_size and h_counter < px_width + h_front_porch_size + h_sync_duration then
                h_sync <= h_polarity;
            else
                h_sync <= not h_polarity;
            end if;

            -- Generate vertical sync pulse
            if v_counter >= px_height + v_front_porch_size and v_counter < px_height + v_front_porch_size + v_sync_duration then
                v_sync <= v_polarity;
            else
                v_sync <= not v_polarity;
            end if;

            -- Update output px x coordinates
            if h_counter < px_width then
                col <= h_counter;
            end if;

            -- Update output px y coordinates
            if v_counter < px_height then
                row <= v_counter;
            end if;

            -- Disable display when out of range
            if h_counter < px_width and v_counter < px_height then
                display_enable <= '1';
            else
                display_enable <= '0';
            end if;

        end if;

        -- row_dbg <= v_counter;
        -- col_dbg <= h_counter;

        -- hardwires
        blank <= '1';
        sync_on_screen <= '0';

    end process;

end Behavioral;
