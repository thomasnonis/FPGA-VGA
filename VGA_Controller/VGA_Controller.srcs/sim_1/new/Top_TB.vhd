library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_TB is
--  Port ( );
end Top_TB;

architecture Behavioral of Top_TB is

    signal clk : std_logic := '0';
    signal r,g,b : std_logic_vector(3 downto 0);

begin

    DUT : entity work.Top Port map (sys_clk => clk, r => r, g => g, b => b);

    clk_gen : process begin
        clk <= not clk;
        wait for 10 ns;
    end process;

end Behavioral;
