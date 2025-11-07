library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD is
Port 
(
signal clk:in std_logic;
signal data:in std_logic_vector(15 downto 0);
signal cat:out std_logic_vector(6 downto 0);
signal an:out std_logic_vector(3 downto 0)
 );
end SSD;

architecture Behavioral of SSD is

signal counter: std_logic_vector(16 downto 0);
signal selection:std_logic_vector(1 downto 0);
signal decoder:std_logic_vector(3 downto 0);

begin

process(clk)
begin
    if clk='1' and clk'event then
        counter <= counter+1;
    end if;
end process;

selection<=counter(16 downto 15);

process(selection,data)
begin

    case selection is
    when "00" => an<="0111";decoder<=data(15 downto 12);
    when "01" => an<="1011";decoder<=data(11 downto 8);
    when "10" => an<="1101";decoder<=data(7 downto 4);
    when others => an<="1110";decoder<=data(3 downto 0);
    end case;
    end process;

process(decoder)
begin

    case decoder is
    when "0000" =>cat<="1000000"; -- 0
    when "0001" =>cat<="1111001"; -- 1
    when "0010" =>cat<="0100100"; -- 2
    when "0011" =>cat<="0110000"; -- 3
    when "0100" =>cat<="0011001"; -- 4
    when "0101" =>cat<="0010010"; -- 5
    when "0110" =>cat<="0000010"; -- 6
    when "0111" =>cat<="1111000"; -- 7
    when "1000" =>cat<="0000000"; -- 8
    when "1001" =>cat<="0010000"; -- 9
    when "1010" =>cat<="0001000"; -- A
    when "1011" =>cat<="0000011"; -- B
    when "1100" =>cat<="1000110"; -- C
    when "1101" =>cat<="0100001"; -- D
    when "1110" =>cat<="0000110"; -- E
    when others =>cat<="0001110"; -- F
    end case;
end process;
end Behavioral;