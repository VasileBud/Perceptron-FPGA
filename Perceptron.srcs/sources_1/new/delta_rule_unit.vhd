library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity delta_rule_unit is
Port ( 
    signal clk:in std_logic;
    signal start:in std_logic;
    signal rst:in std_logic;
    signal initial_weight:in std_logic_vector(31 downto 0);
    signal input:in std_logic_vector(31 downto 0);
    signal desired_point_type:in std_logic;
    signal perceived_point_type:in std_logic;
    signal corrected_weight:out std_logic_vector(31 downto 0);
    signal delta_ok:out std_logic;
    signal delta_done:out std_logic
--    signal leds:out std_logic_vector(6 downto 0)
);
end delta_rule_unit;

architecture Behavioral of delta_rule_unit is
    signal LEARNING_RATE: std_logic_vector(31 downto 0):=X"3a83126f"; --TODO x3dcccccd = 0.001
    signal rate: std_logic_vector(31 downto 0):=X"00000000";
    signal rst_mul_sync: std_logic:='0';
    signal rst_mul_async: std_logic:='0';
    signal rst_mul: std_logic:='0';
    signal rst_adder_sync: std_logic:='0';
    signal rst_adder_async: std_logic:='0';
    signal rst_adder: std_logic:='0';
    signal mul_done: std_logic:='0';
    signal adder_done: std_logic:='0';
    signal start_mul: std_logic:='0';
    signal start_adder: std_logic:='0';
    ------DEBUGGUNG--------
--    signal int1:std_logic:='0';
--    signal int2:std_logic:='0';
    
    signal weight_adjustment_value: std_logic_vector(31 downto 0):=X"00000000";
    type ST is (
        IDLE,RST_ST,STRT,COMPUTING,SIGNAL_STOP
    );

  signal cur_state : ST := IDLE;
  signal next_state : ST := IDLE;
    
begin
    rst_mul<=rst_mul_sync or rst_mul_async;
    rst_adder<=rst_adder_sync or rst_adder_async;
    delta_ok<= '1' when (perceived_point_type = desired_point_type) else '0';
    --this gives the "direction in which to correct the weight towards" by changing the sign of the learning rate according to 
    -- (d-y) where d is desired output and y is actual output. This is done to avoid using another multiplier just to change the sign of the result
    rate<= LEARNING_RATE when (desired_point_type='1') else ("1" & LEARNING_RATE(30 downto 0)) ;
    
    
    process(clk,rst)
    begin
        if rst='1' then
            cur_state<=IDLE;
            rst_mul_async<='1';
            rst_adder_async<='1';
        elsif rising_edge(clk) then
            rst_mul_async<='0';
            rst_adder_async<='0';
            cur_state<=next_state;
        end if;
    end process;
    
    process (cur_state,start,adder_done)
    begin
        case cur_state is
            when IDLE => 
                if start='1' then
                    next_state<=RST_ST;
                else
                    next_state<=IDLE;
                end if;
                
            when RST_ST =>
                next_state<=STRT;
                
            when STRT =>
                next_state<=COMPUTING;
                
            when COMPUTING =>
                if (adder_done='1') then 
                    next_state<=SIGNAL_STOP;
                else
                    next_state<=COMPUTING;                   
                end if;
                
           when SIGNAL_STOP=>
                next_state<=IDLE;
        end case;
    end process;
    
    process (cur_state,start)
    begin
        case cur_state is
            when IDLE => 
                rst_mul_sync<='1';
                rst_adder_sync<='1';
                start_mul<='1';
                delta_done<='1';
                if start='1' then
                    delta_done<='0';
                end if;
            when RST_ST =>
                rst_mul_sync<='1';
                rst_adder_sync<='1';
                start_mul<='0';
                delta_done<='0';
            when STRT =>
                rst_mul_sync<='1';
                rst_adder_sync<='0';
                start_mul<='1';
                delta_done<='0';
            when COMPUTING =>
                rst_mul_sync<='0';
                rst_adder_sync<='0';
                start_mul<='1';
                delta_done<='0';
            when SIGNAL_STOP=>
                rst_mul_sync<='0';
                rst_adder_sync<='0';
                start_mul<='0';
                delta_done<='1';
        end case;
    end process;
    ---------DEBUGGING
--    process (cur_state,start,adder_done,mul_done)
--    begin
--        if rising_edge(adder_done) then
--         leds<=(others=>'0');
--            leds(5)<='1';
--        end if;
        
--        if rising_edge(mul_done) then
--            leds(6)<='1';
--        end if;
--        case cur_state is
--            when IDLE =>leds(4)<='1';
--            when RST_ST =>leds(3)<='1';
--            when STRT =>leds(2)<='1';
--            when COMPUTING =>leds(1)<='1';
--            when SIGNAL_STOP=>leds(0)<='1';
--        end case;
--    end process;
    
    --CAREFUL multiplier cannot be started at will, but needs to be resetted
    fpu_mul: entity WORK.FPU_multiplier port map(
        clk => clk,
        reset => rst_mul,
        start=>start_mul,
        A=>rate,
        B=>input,
        done=>mul_done,
        product=>weight_adjustment_value
    );
    
    fpu_adder2: entity WORK.FPU_adder port map(
        clk => clk,
        reset => rst_adder,
        A=>initial_weight,
        B=>weight_adjustment_value,
        start=>mul_done,
        done=>adder_done,
        sum=>corrected_weight
    );

end Behavioral;
