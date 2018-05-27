library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PWM_Counter is
  port( rst        : in std_logic;
        clk        : in std_logic;
        max_count  : in integer range 0 to 400000;
        duty_cycle : in integer range 0 to 100;
        pwm        : out std_logic);
end PWM_Counter;

architecture Behavioral of PWM_Counter is
  signal count      : integer range 0 to 400000;
  signal count_high : integer range 0 to 400000;
  signal out_aux : std_logic;
  begin
    pwm <= out_aux;
    pwm_generator : process(clk,rst,max_count,duty_cycle)
    begin
      count_high <= (max_count/100)*duty_cycle;
      if(rst = '1') then
        out_aux <= '0';
        count <= 0;
      elsif(clk'event and clk='1') then
        if(count <= max_count) then
          count <= count + 1;
          if(count <= count_high) then
            out_aux <= '1';
          else
            out_aux <= '0';
          end if;
        else
          count <= 0;
        end if;
      end if;
    end process pwm_generator;
end Behavioral;