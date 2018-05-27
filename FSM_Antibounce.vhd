library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_Antibounce is
  port ( rst        : in std_logic;
         clk        : in std_logic; 
         button_in  : in std_logic;
         c_end      : in std_logic;                  
         button_out : out std_logic;
         c_start    : out std_logic);
end FSM_Antibounce;

architecture Behavioral of FSM_Antibounce is
  -- Auxiliary Signal Definition
  type state is(detect,up,down);
  signal present_state,next_state : state;
  -- Begin Architecture
  begin
  -- Moore State Machine with 3 blocks
    -- Block F Programming
    blockF : process(present_state,button_in,c_end)
    begin
      case (present_state) is
        when detect => if(button_in = '1') then
                         next_state <= up;
                       elsif(button_in = '0') then
                         next_state <= down;
                       else
                         next_state <= detect;
                       end if;
        when up   =>   if(c_end = '1') then
                         next_state <= detect;
                       else
                         next_state <= up;
                       end if;
        when down  =>  if(c_end = '1') then
                         next_state <= detect;
                       else
                         next_state <= down;
                       end if;
        when others => next_state <= detect;
      end case;
    end process blockF;
    -- Block M Programmig
    blockM : process(clk,rst)
    begin
      if(rst = '1') then
        present_state <= detect;
      elsif(clk'event and clk='1') then
        present_state <= next_state;
      end if;
    end process blockM;
    -- Block G Programming
    blockG : process(present_state)
    begin
      case (present_state) is
        when detect => button_out <= '0';
                       c_start <= '0';
        when up     => button_out <= '1';
                       c_start <= '1';
        when down   => button_out <= '0';
                       c_start <= '1';
        when others => button_out <= '0';
                       c_start <= '0';
      end case;
    end process blockG;
end Behavioral;