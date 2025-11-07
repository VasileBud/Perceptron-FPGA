library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FPU_adder is
Port (
    signal A:in std_logic_vector(31 downto 0);
    signal B:out std_logic_vector(31 downto 0)
);
end FPU_adder;

architecture Behavioral of FPU_adder is

begin
     B<= not A;
end Behavioral;
