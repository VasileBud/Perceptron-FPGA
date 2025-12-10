library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity FPU_multiplier is
  port(
    A       : in  std_logic_vector(31 downto 0);
    B       : in  std_logic_vector(31 downto 0);
    clk     : in  std_logic;
    reset   : in  std_logic;
    start   : in  std_logic;
    done    : out std_logic;
    product : out std_logic_vector(31 downto 0)
  );
end FPU_multiplier;

architecture Behavioral of FPU_multiplier is

  type ST is (
    WAIT_STATE, CHECK_X, CHECK_Y, PRODUCT_ZERO,
    ADD_EXP, SUB_BIAS, CHK_OVF, CHK_UNF,
    MUL_MANT_STATE, NORM_MANT_STATE, CHK_UNF2_STATE, COMPUTE_ROUND_CONS,
    ROUND_STATE, SET_SIGN_STATE,COMPUTE_PRODUCT, STOP_STATE
  );

  signal state : ST := WAIT_STATE;
  signal M_full_reg : std_logic_vector(47 downto 0);

  signal A_sgn, B_sgn, Product_sgn : std_logic;
  signal A_man, B_man : std_logic_vector(23 downto 0);
  signal A_exp, B_exp : std_logic_vector(8 downto 0);

  signal E_temp : std_logic_vector(8 downto 0);
  signal eZ     : std_logic_vector(8 downto 0);

  signal M_full, M_norm : std_logic_vector(47 downto 0);
  signal mant : std_logic_vector(22 downto 0);

  signal g, r, s : std_logic;

begin

process(clk, reset)
begin
  if reset='1' then
    state <= WAIT_STATE;
    done  <= '0';
    product <= (others => '0');

  elsif rising_edge(clk) then
    case state is

      when WAIT_STATE =>
      if start='1' then
      --add start condition if remote start is needed
        done <= '0';
        A_sgn <= A(31);
        B_sgn <= B(31);

        A_exp <= '0' & A(30 downto 23);
        B_exp <= '0' & B(30 downto 23);

        A_man <= '1' & A(22 downto 0);
        B_man <= '1' & B(22 downto 0);

        state <= CHECK_X;
      else 
        state <= WAIT_STATE;
      end if;

      when CHECK_X =>
        if A = X"00000000" then
          state <= PRODUCT_ZERO;
        else
          state <= CHECK_Y;
        end if;

      when CHECK_Y =>
        if B = X"00000000" then
          state <= PRODUCT_ZERO;
        else
          state <= ADD_EXP;
        end if;

      when PRODUCT_ZERO =>
        product <= (others => '0');
        state <= STOP_STATE;

      when ADD_EXP =>
        E_temp <= A_exp + B_exp;
        state <= SUB_BIAS;

      when SUB_BIAS =>
        eZ <= E_temp - 127;
        state <= CHK_OVF;

      when CHK_OVF =>
        if unsigned(eZ) > 254 then
          state <= PRODUCT_ZERO;
        else
          state <= CHK_UNF;
        end if;

      when CHK_UNF =>
        if unsigned(eZ) < 1 then
          state <= PRODUCT_ZERO;
        else
          state <= MUL_MANT_STATE;
        end if;

      when MUL_MANT_STATE =>
        M_full_reg <= A_man*B_man;
        state <= NORM_MANT_STATE;

    when NORM_MANT_STATE =>
        M_full<=M_full_reg;
      if M_full(47) = '0' then
          M_norm(47 downto 24) <= M_full(46 downto 23);
          M_norm(23 downto 0)  <= M_full(22 downto 0) & '0'; 
      else
          M_norm <= M_full;
          eZ <= eZ + '1';
      end if;
      state <= CHK_UNF2_STATE;
      
    when CHK_UNF2_STATE =>
        if unsigned(eZ) < 1 then
          state <= PRODUCT_ZERO;
        end if;
        state <= COMPUTE_ROUND_CONS;  
        
     when COMPUTE_ROUND_CONS =>
          mant <= M_norm(46 downto 24);
          g <= M_norm(23);
          r <= M_norm(22);
          
          if M_norm(21 downto 0) = X"000000" then
            s <= '0';
          else
            s <= '1';
          end if;
          state <= ROUND_STATE;

     when ROUND_STATE =>
        if (r='1' and (g='1' or s='1')) then
          mant <= mant + '1';
        end if;
        state <= SET_SIGN_STATE;

      when SET_SIGN_STATE =>
        Product_sgn <= A_sgn xor B_sgn;
        state <= COMPUTE_PRODUCT;

      when COMPUTE_PRODUCT =>   
        product(31) <= Product_sgn;
        product(30 downto 23) <= eZ(7 downto 0);
        product(22 downto 0) <= mant;
        state <= STOP_STATE;
        
      when STOP_STATE =>
        done <= '1';
        if (start = '0') then         -- stay in the state till request ends i.e start is low
            done    <= '0';
            state <= WAIT_STATE;
        end if;

    end case;
  end if;
end process;

end Behavioral;
