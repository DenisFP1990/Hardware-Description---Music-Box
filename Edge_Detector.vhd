library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Edge_Detector is
  port( rst    : in std_logic;
        clk    : in std_logic;
        button : in std_logic;
        pulse  : out std_logic);
end Edge_Detector;

architecture Behavioral of Edge_Detector is
  signal button_k1 : std_logic; 
  begin
    detect : process(rst,clk)
    begin
      if(rst = '1') then
        button_k1 <= '0';  
      elsif(clk'event and clk = '1') then
        button_k1 <= button;
      end if;
    end process detect;
    pulse <= button and (not(button_k1));
end Behavioral;