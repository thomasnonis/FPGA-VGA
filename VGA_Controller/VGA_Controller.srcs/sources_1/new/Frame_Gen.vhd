----------------------------------------------------------------------------------
-- Engineer: Thomas Nonis
-- Project Name: VGA Controller
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Frame_Gen is
    Generic(
        px_width : natural;
        px_height : natural
    );
    Port (
        display_enable : in std_logic;
        col : in natural;
        row : in natural;
        r : out std_logic_vector(3 downto 0);
        g : out std_logic_vector(3 downto 0);
        b : out std_logic_vector(3 downto 0)
    );
end Frame_Gen;

architecture Line of Frame_Gen is
    
    constant thickness : natural := 20;
    constant every_n_frames : natural := 30;

    begin

        process (display_enable, col, row)
        
            variable current_frame : natural := 0;
            variable index : natural := 0;

        begin

            if display_enable = '1' then

                if col >= index and col < index + thickness then
                    r <= "1111";
                    g <= "0000";
                    b <= "0000";
                else
                    r <= "0000";
                    g <= "1111";
                    b <= "0000";
                end if;
                

                if col = px_width - 1 and row = px_height - 1 then
                    current_frame := current_frame + 1;
                end if;

                if current_frame mod every_n_frames = 0 then
                    index := index + 1;
                end if;

                if index = px_width - 1 then
                    index := 0;
                end if;

            else
                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');
            end if;
        end process;

end Line;

architecture Colors of Frame_Gen is
    
    constant every_n_frames : natural := 15;

    -- signal dbg_current_frame : integer;
    -- signal dbg_index : natural;

    signal current_frame : natural := 0;

    begin

        process (display_enable, col, row)
        
            -- variable current_frame : natural := 0;
            variable index : natural := 0;

        begin

            -- dbg_current_frame <= current_frame + 1;
            -- dbg_index <= index;

            if display_enable = '1' then

                if col = px_width - 1 and row = px_height - 1 then
                    -- update on next call
                    current_frame <= current_frame + 1;
                end if;

                if current_frame = every_n_frames - 1 then
                    current_frame <= 0;
                    index := index + 1;
                end if;

                if index = 8 then
                    index := 0;
                end if;

                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');

                case index is
                    when 0 =>
                        r <= (others => '1');

                    when 1 =>
                        g <= (others => '1');
                        
                    when 2 =>
                        b <= (others => '1');

                    when 3 =>
                        g <= (others => '1');
                        b <= (others => '1');
                        
                    when 4 =>
                        r <= (others => '1');
                        b <= (others => '1');

                    when 5 =>
                        r <= (others => '1');
                        g <= (others => '1');
 
                    when 6 =>
                        r <= (others => '1');
                        g <= (others => '1');
                        b <= (others => '1');

                    when others =>
                        r <= (others => '0');
                        g <= (others => '0');
                        b <= (others => '0');
                        
                    end case;                    
                
            else
                r <= (others => '0');
                g <= (others => '0');
                b <= (others => '0');
            end if;
        end process;

end Colors;
