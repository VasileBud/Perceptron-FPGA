----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2023 06:36:01 PM
-- Design Name: 
-- Module Name: Div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Div is
Port
(
signal clk:in std_logic;
signal rst:in std_logic;
signal new_clk:out std_logic
);
end Div;

architecture Behavioral of Div is
signal counter:integer:=0;
signal clk_div:std_logic;
begin

process(clk)
begin
if rst='1' then
    counter<=0;
    clk_div<='0';
elsif clk='1' and clk'event then
    if counter<49999999 then
        counter<=counter+1;
    else
        counter<=0;
        clk_div<=not(clk_div);
    end if;
end if;

end process;
end Behavioral;
