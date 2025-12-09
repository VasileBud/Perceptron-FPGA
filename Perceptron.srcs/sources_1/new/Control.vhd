library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
Port ( 
    clk:in std_logic;
    x_input:in std_logic_vector(31 downto 0);
    y_input:in std_logic_vector(31 downto 0);
    w:in std_logic_vector(31 downto 0);
    w1:in std_logic_vector(31 downto 0);
    w2:in std_logic_vector(31 downto 0);
    rst: in  std_logic;
    start_per: in  std_logic;
    done_per: out  std_logic;
    per_out: out  std_logic;
    
    start_delta: in  std_logic;
    desired_point_type: in  std_logic;
    corrected_w:out std_logic_vector(31 downto 0);
    corrected_w1:out std_logic_vector(31 downto 0);
    corrected_w2:out std_logic_vector(31 downto 0);
    delta_ok:out std_logic;
    delta_done:out std_logic
);
end Control;

architecture Behavioral of Control is
    signal perceived_point_type: std_logic;
    signal delta_ok1: std_logic;
    signal delta_ok2: std_logic;
    signal delta_ok3: std_logic;
begin
per_out <= perceived_point_type;
perceptron: entity WORK.Perceptron port map(
        clk=>clk,
        rst => rst,
        start => start_per,
        x_coord =>x_input,
        y_coord =>y_input,
        w=>w,
        wx=>w1,
        wy=>w2,
        output=>perceived_point_type,
        done =>done_per
    );
    
delta_rule_unit1:entity WORK.delta_rule_unit port map(
    clk=>clk,
    start=>start_delta,
    rst=>rst,
    initial_weight=>w,
    input=>X"3f800000",-- 1f value
    desired_point_type=>desired_point_type,
    perceived_point_type=>perceived_point_type,
    corrected_weight=>corrected_w,
    delta_ok=>delta_ok1,
    delta_done=>delta_done
    );
    
delta_rule_unit2:entity WORK.delta_rule_unit port map(
    clk=>clk,
    start=>start_delta,
    rst=>rst,
    initial_weight=>w1,
    input=>x_input,-- 1f value
    desired_point_type=>desired_point_type,
    perceived_point_type=>perceived_point_type,
    corrected_weight=>corrected_w1,
    delta_ok=>delta_ok2,
    delta_done=>delta_done
    );  

delta_rule_unit3:entity WORK.delta_rule_unit port map(
    clk=>clk,
    start=>start_delta,
    rst=>rst,
    initial_weight=>w2,
    input=>y_input,-- 1f value
    desired_point_type=>desired_point_type,
    perceived_point_type=>perceived_point_type,
    corrected_weight=>corrected_w1,
    delta_ok=>delta_ok3,
    delta_done=>delta_done
    );
    delta_ok<=delta_ok1 and delta_ok2 and delta_ok3;
end Behavioral;
