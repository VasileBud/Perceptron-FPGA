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
    signal product:std_logic_vector(31 downto 0):=X"00000000";
    signal sum:std_logic_vector(31 downto 0):=X"00000000";
    signal res:std_logic_vector(31 downto 0):=X"00000000";
    signal x:std_logic_vector(31 downto 0):=x"c0200000"; -- -2.5
    signal y:std_logic_vector(31 downto 0):=x"3fa00000"; -- 1.25
    signal data_16:std_logic_vector(15 downto 0);
    signal btns:std_logic_vector(4 downto 0);--concatenated btns
    signal btnu_d: std_logic;
    signal btnc_d: std_logic;
    
    
    signal x1,y1: std_logic_vector(31 downto 0);
    
begin

    mpg1: entity WORK.MPG port map(
        clk=>clk,
        btn=>btnc,
        en=>btnc_d
    );
    
     mpg2: entity WORK.MPG port map(
        clk=>clk,
        btn=>btnu,
        en=>btnu_d
    );
    
    
    x1 <= x"41b80000" when sw(0) = '1' else x"41600000";
    y1 <= x"40a00000" when sw(0) = '1' else x"41a80000";
    
--    perceptron: entity WORK.Perceptron port map(
--        clk=>clk,
--        rst => btnc_d,
--        start => btnu,
--        x_coord =>x1,
--        y_coord =>y1,
--        w=>x"3f800000",
--        wx=>x"3f800000",
--        wy=>x"bf800000",
--        fsum=>res,
--        output=>led(13),
--        done =>led(15),
--        leds=>led(6 downto 0)
--    );
    
    data_16 <= res(31 downto 16) when sw(15)='0' else res(15 downto 0);
    --res <= product when sw(15)='0' else sum;
    
    delta_rule_unit:entity WORK.delta_rule_unit port map(
    clk=>clk,
    start=>btnu,
    rst=>btnd,
    initial_weight=>x1,--1.0
    input=>y1,--27.0
    desired_point_type=>'0',--
    perceived_point_type=>'1',--    perceived_point_type=>'1'
    corrected_weight=>res,--
    delta_ok=>led(14),
    delta_done=>led(15),
    leds=>led(6 downto 0)
    );
    
    display:entity WORK.SSD port map(
        clk=>clk,
        cat=>cat,
        an=>an,
        data=>data_16
    );

end Behavioral;