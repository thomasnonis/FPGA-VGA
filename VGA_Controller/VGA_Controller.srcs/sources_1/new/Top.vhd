----------------------------------------------------------------------------------
-- Engineer: Thomas Nonis
-- Project Name: VGA Controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    Port (
        sys_clk : in std_logic;
        r : out std_logic_vector(3 downto 0);
        g : out std_logic_vector(3 downto 0);
        b : out std_logic_vector(3 downto 0);
        -- n_sync : out std_logic;
        -- n_blank : out std_logic;
        h_sync : out std_logic;
        v_sync : out std_logic
        -- px_clk : buffer std_logic
    );
end Top;

architecture Behavioral of Top is

    constant px_width : natural := 640;
    constant px_height : natural := 480;
    constant refresh_rate : real := 60.0;

    constant h_sync_duration : natural := 96;
    constant h_front_porch_size : natural := 16;
    constant h_back_porch_size : natural := 48;
    constant h_polarity : std_logic := '0';

    constant v_sync_duration : natural := 2;
    constant v_front_porch_size : natural := 10;
    constant v_back_porch_size : natural := 33;
    constant v_polarity : std_logic := '0';

    signal reset : std_logic := '1';

    signal display_enable : std_logic;

    signal col : natural;
    signal row : natural;

    signal n_sync : std_logic;
    signal n_blank : std_logic;

    signal px_clk : std_logic;

begin

    -- clk_gen : entity work.Px_Clock_Gen
    --     Generic map (
    --         px_width => px_width,
    --         px_height => px_height,
    --         refresh_rate => refresh_rate,
    --         h_sync_duration => h_sync_duration,
    --         h_front_porch_size => h_front_porch_size,
    --         h_back_porch_size => h_back_porch_size,
    --         v_sync_duration => v_sync_duration,
    --         v_front_porch_size => v_front_porch_size,
    --         v_back_porch_size => v_back_porch_size
    --     )
    --     Port map (
    --         px_clk => px_clk
    --     );

    clk_gen : entity work.clk_wiz Port map (sys_clk => sys_clk, px_clk => px_clk);

    VGA_Controller : entity work.Controller
        Generic map (
            px_width => px_width,
            px_height => px_height,
            h_sync_duration => h_sync_duration,
            h_front_porch_size => h_front_porch_size,
            h_back_porch_size => h_back_porch_size,
            h_polarity => h_polarity,
            v_sync_duration => v_sync_duration,
            v_front_porch_size => v_front_porch_size,
            v_back_porch_size => v_back_porch_size,
            v_polarity => v_polarity
        )
        Port map (
            clk => px_clk,
            reset => reset,
            h_sync => h_sync,
            v_sync => v_sync,
            display_enable => display_enable,
            col => col,
            row => row,
            blank => n_blank,
            sync_on_screen => n_sync
        );

    -- Image_Buffer : entity work.Img_Tester (Bands)
    Frame_generator : entity work.Frame_Gen(Colors)
        Generic map (
            px_width => px_width,
            px_height => px_height
        )
        Port map (
            display_enable => display_enable,
            col => col,
            row => row,
            r => r,
            g => g,
            b => b
        );

end Behavioral;
