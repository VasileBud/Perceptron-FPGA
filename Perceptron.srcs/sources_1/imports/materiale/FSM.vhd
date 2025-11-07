----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2024 02:34:37 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
Port
 (
 signal clk:in std_logic;
 signal rst:in std_logic;
 signal btn_power:in std_logic;
 signal btn_emisie:in std_logic;
 signal btn_safety:in std_logic;
 signal flag_emisie:out std_logic
  );
end FSM;

architecture Behavioral of FSM is
type stari is (power_off, idle, armat, emisie);
signal stare_cur:stari:=power_off;
signal stare_urm:stari:=power_off;
begin


process(clk,rst)
begin

if rst='1' then
    stare_cur<=idle;
elsif clk='1' and clk'event then
    stare_cur<=stare_urm;
end if;
end process;

process(stare_cur)
begin
    case stare_cur is
    when power_off=> if btn_power='1' then
                        stare_urm<=idle;
                     else 
                        stare_urm<=power_off;
                     end if;
    when idle=> if btn_power='0' then
                       stare_urm<=power_off;
                elsif btn_power='1' and btn_safety='0' then
                        stare_urm<=idle;
                elsif btn_power='1' and btn_safety='1' then
                        stare_urm<=armat;
                end if;
    when armat=> if btn_power='0' then
                       stare_urm<=power_off;
                elsif btn_power='1' and btn_safety='0' then
                        stare_urm<=idle;
                elsif btn_power='1' and btn_safety='1' and btn_emisie='0' then
                        stare_urm<=armat;
                elsif btn_power='1' and btn_safety='1' and btn_emisie='1' then
                        stare_urm<=emisie;
                end if;
    when others=> if btn_emisie='0' then
                    stare_urm<=armat;
                  else
                    stare_urm<=emisie;
                  end if;
    end case;
end process;

process(stare_cur)
begin
    case stare_cur is
    when power_off=>flag_emisie<='0';
    when idle=>flag_emisie<='0';
    when armat=>flag_emisie<='0';
    when others=>flag_emisie<='1';
    end case;
end process;
end Behavioral;
