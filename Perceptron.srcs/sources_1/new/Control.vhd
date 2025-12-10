library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
Port ( 
    clk:in std_logic;
    input_val:in std_logic_vector(31 downto 0);
    sel_input:in std_logic;
    update_input:in std_logic;
    w:in std_logic_vector(31 downto 0);
    rst: in  std_logic;
    start_per: in  std_logic;
    update_w: in std_logic;
    done_per: out  std_logic;
    per_out: out  std_logic;
    sel_corrected_w: in std_logic_vector(1 downto 0);
    sel_w: in std_logic_vector(1 downto 0);
    
    start_delta: in  std_logic;
    desired_point_type: in  std_logic;
    corrected_w:out std_logic_vector(31 downto 0);
    delta_ok:out std_logic;
    delta_done:out std_logic
);
end Control;

architecture Behavioral of Control is
    signal perceived_point_type: std_logic;
    signal delta_ok1: std_logic;
    signal delta_done1: std_logic;
    signal delta_ok2: std_logic;
    signal delta_done2: std_logic;
    signal delta_ok3: std_logic;
    signal delta_done3: std_logic;
    signal corrected_w0: std_logic_vector(31 downto 0);
    signal corrected_w1: std_logic_vector(31 downto 0);
    signal corrected_w2: std_logic_vector(31 downto 0);    
    signal x_input: std_logic_vector(31 downto 0);    
    signal y_input: std_logic_vector(31 downto 0);    
    signal w0: std_logic_vector(31 downto 0);
    signal w1: std_logic_vector(31 downto 0);
    signal w2: std_logic_vector(31 downto 0);
begin

process(sel_corrected_w)
begin
    case sel_corrected_w is 
        when "00" => corrected_w <= corrected_w0; 
        when "01" => corrected_w <= corrected_w1; 
        when "10" => corrected_w <= corrected_w2; 
        when others => NULL; 
    end case;
end process;    

process(sel_w, update_w)
begin
    if rising_edge(update_w) then 
        case sel_w is 
            when "00" => w0 <= w; 
            when "01" => w1 <= w; 
            when "10" => w2 <= w; 
            when others => NULL; 
        end case;
     end if;   
end process;    

process(sel_input, update_input)
begin
    if rising_edge(update_input) then 
        if sel_input='0' then
            x_input<=input_val;
        else
            y_input<=input_val;
        end if;
     end if;   
end process; 

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
    initial_weight=>w0,
    input=>X"3f800000",-- 1f value
    desired_point_type=>desired_point_type,
    perceived_point_type=>perceived_point_type,
    corrected_weight=>corrected_w0,
    delta_ok=>delta_ok1,
    delta_done=>delta_done1
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
    delta_done=>delta_done2
    );  

delta_rule_unit3:entity WORK.delta_rule_unit port map(
    clk=>clk,
    start=>start_delta,
    rst=>rst,
    initial_weight=>w2,
    input=>y_input,-- 1f value
    desired_point_type=>desired_point_type,
    perceived_point_type=>perceived_point_type,
    corrected_weight=>corrected_w2,
    delta_ok=>delta_ok3,
    delta_done=>delta_done3
    );
    delta_ok<=delta_ok1 and delta_ok2 and delta_ok3;
    delta_done<=delta_done1 and delta_done2 and delta_done3;
end Behavioral;
