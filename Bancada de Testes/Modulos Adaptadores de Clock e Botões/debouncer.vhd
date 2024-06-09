library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity modulo_debouncer is
    Port (
        clk : in STD_LOGIC;
        button_in : in STD_LOGIC;
        button_out : out STD_LOGIC
    );
end modulo_debouncer;

architecture Behavioral of modulo_debouncer is
    signal count : integer range 0 to 1250000 := 1250000;
    signal temp : STD_LOGIC := '0';

begin
    process(clk)
    begin
        if rising_edge(clk) then
            if button_in /= temp then
                count <= 1250000;
                temp <= button_in;
            elsif count > 0 then
                count <= count - 1;
            end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            if count = 0 then
                button_out <= temp;
            end if;
        end if;
    end process;
end Behavioral;