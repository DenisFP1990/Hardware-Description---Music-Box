library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Counter_Antibounce is
  port(rst    : in std_logic;
       clk    : in std_logic;
       start  : in std_logic;
       finish : out std_logic);
end Counter_Antibounce;

architecture Behavioral of Counter_Antibounce is
  signal count : integer range 0 to 5000000;
  signal fin_aux : std_logic;
  begin
    finish <= fin_aux;
    counting : process(clk,rst)
    begin
      if(rst = '1') then
        fin_aux <= '0';
        count <= 0;
      elsif(rising_edge(clk)) then
        if(start = '1') then
          if(count < 5000000) then
            fin_aux <= '0';
            count <= count + 1;
          else
            fin_aux <= '1';
            count <= 0;
          end if;
        else
          count <= count;
        end if;
      end if;
    end process counting;
end Behavioral;