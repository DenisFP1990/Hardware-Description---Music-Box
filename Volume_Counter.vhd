library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Volume_Counter is
  port(clk    : in std_logic;
       rst    : in std_logic;
       up     : in std_logic;
       down   : in std_logic;
       volume : out integer range 0 to 100);
end Volume_Counter;

architecture Behavioral of Volume_Counter is
  signal aux_count : integer range 0 to 100;
  begin
    volume <= aux_count;
    vol_control : process(rst,clk)
    begin
      if(rst = '1') then
        aux_count <= 1;
      elsif(clk'event and clk='1') then
        if(up='1' and aux_count<99) then
          aux_count <= aux_count + 1;
        elsif(down='1' and aux_count>1) then
          aux_count <= aux_count - 1;
        else
          aux_count <= aux_count;
        end if;
      end if;
    end process vol_control;
end Behavioral;