library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Perceptron is
  Port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        start    : in  std_logic;
        x_coord  : in  std_logic_vector(31 downto 0);
        y_coord  : in  std_logic_vector(31 downto 0);
        w        : in  std_logic_vector(31 downto 0);
        wx       : in  std_logic_vector(31 downto 0);
        wy       : in  std_logic_vector(31 downto 0);
--        fsum     : out std_logic_vector(31 downto 0);
        output   : out std_logic;
        done     : out std_logic
        );
end Perceptron;

architecture Behavioral of Perceptron is

    signal weighted_sum : std_logic_vector(31 downto 0);
    signal productx     : std_logic_vector(31 downto 0);
    signal producty     : std_logic_vector(31 downto 0);
    signal sum          : std_logic_vector(31 downto 0);

    type ST is (IDLE, MUL, ADD1, ADD2, DONE_ST);
    signal cur_state, next_state : ST := IDLE;

    signal mul1_done    : std_logic := '0';
    signal mul2_done    : std_logic := '0';
    signal adder1_done  : std_logic := '0';
    signal adder2_done  : std_logic := '0';

    signal start_mul1   : std_logic := '0';
    signal start_mul2   : std_logic := '0';
    signal start_adder1 : std_logic := '0';
    signal start_adder2 : std_logic := '0';

begin
--    process(cur_state)
--    begin
--        leds <= (others => '0');
--        case cur_state is
--            when IDLE     => leds(4) <= '1';
--            when MUL      => leds(3) <= '1';
--            when ADD1     => leds(2) <= '1';
--            when ADD2     => leds(1) <= '1';
--            when DONE_ST  => leds(0) <= '1';
--        end case;
--    end process;

    process(clk, rst)
    begin
        if rst = '1' then
            cur_state <= IDLE;
        elsif rising_edge(clk) then
            cur_state <= next_state;
        end if;
    end process;

    process(cur_state, start, mul1_done, mul2_done, adder1_done, adder2_done)
    begin
        case cur_state is

            when IDLE =>
                if start = '1' then
                    next_state <= MUL;
                else
                    next_state <= IDLE;
                end if;

            when MUL =>
                if (mul1_done = '1' and mul2_done = '1') then
                    next_state <= ADD1;
                else
                    next_state <= MUL;
                end if;

            when ADD1 =>
                if adder1_done = '1' then
                    next_state <= ADD2;
                else
                    next_state <= ADD1;
                end if;

            when ADD2 =>
                if adder2_done = '1' then
                    next_state <= DONE_ST;
                else
                    next_state <= ADD2;
                end if;

            when DONE_ST =>
                if start = '0' then
                    next_state <= IDLE;
                else
                    next_state <= DONE_ST;
                end if;
        end case;
    end process;

    process(cur_state)
    begin
        start_mul1   <= '0';
        start_mul2   <= '0';
        start_adder1 <= '0';
        start_adder2 <= '0';
        done         <= '0';

        case cur_state is
            when IDLE =>
                done <= '0';

            when MUL =>
                start_mul1 <= '1';
                start_mul2 <= '1';

            when ADD1 =>
                start_adder1 <= '1';

            when ADD2 =>
                start_adder2 <= '1';

            when DONE_ST =>
                done <= '1';
                if start = '0' then
                    done <= '0';
                end if;
        end case;
    end process;

    output <= not weighted_sum(31);  

    fpu_mul1: entity WORK.FPU_multiplier
        port map(
            clk     => clk,
            reset   => rst,
            start   => start_mul1,
            A       => wx,
            B       => x_coord,
            done    => mul1_done,
            product => productx
        );

    fpu_mul2: entity WORK.FPU_multiplier
        port map(
            clk     => clk,
            reset   => rst,
            start   => start_mul2,
            A       => wy,
            B       => y_coord,
            done    => mul2_done,
            product => producty
        );

    fpu_adder1: entity WORK.FPU_adder
        port map(
            clk   => clk,
            reset => rst,
            A     => w,
            B     => productx,
            start => start_adder1,
            done  => adder1_done,
            sum   => sum
        );

    fpu_adder2: entity WORK.FPU_adder
        port map(
            clk   => clk,
            reset => rst,
            A     => sum,
            B     => producty,
            start => start_adder2,
            done  => adder2_done,
            sum   => weighted_sum
        );

end Behavioral;
