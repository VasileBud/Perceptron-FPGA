library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Main is
  Port ( 
    signal clk:in std_logic;
    signal btnd:in std_logic;
    signal btnu:in std_logic;
    signal btnc:in std_logic;
    signal btnl:in std_logic;
    signal btnr:in std_logic;
    signal cat: out std_logic_vector(6 downto 0); 
    signal sw: in std_logic_vector(15 downto 0); 
    signal an: out std_logic_vector(3 downto 0); 
    signal led:out std_logic_vector(15 downto 0)
    );
end Main;

architecture Behavioral of Main is
    signal btnc_d:std_logic;
    signal data:std_logic_vector(15 downto 0):=X"0000";
    signal cnt:std_logic_vector(3 downto 0):=X"0";
    signal a: std_logic_vector(31 downto 0):= x"3FC00000"; -- 1.5 
    signal b: std_logic_vector(31 downto 0):= x"C0000000"; -- -2.0

begin

    process(clk,btnc_d)
    begin
        if rising_edge(clk) then
            cnt<= cnt+1;
        end if;
    end process;
    
    mpg_center: entity WORK.MPG port map(
        btn=>btnc,
        clk=>clk,
        en=>btnc_d
    );
    
   fpu_mul: entity WORK.FPU_multiplier port map(
        a=>a,
        b=>b,
        y=>data
   );
   
    display:entity WORK.SSD port map(
        clk=>clk,
        cat=>cat,
        an=>an,
        data=>data
    );

end Behavioral;
