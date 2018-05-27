library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_Notes is
  port( rst     : in std_logic;
        clk     : in std_logic; 
        Address : in std_logic_vector(3 downto 0);
        Data    : out integer range 0 to 400000);
end ROM_Notes;

architecture Behavioral of ROM_Notes is
  signal ROM_address : integer range 0 to 12;
  type memory_ROM is array (12 downto 0) of integer range 0 to 400000;
  signal value : integer range 0 to 400000;
  constant notes_rom : memory_ROM := ( 0      => 0,
                                       1      => 382220,
                                       2      => 360776,
                                       3      => 340530,
                                       4      => 321410,
                                       5      => 303370,
                                       6      => 286344,
                                       7      => 270278,
                                       8      => 255102,
                                       9      => 240790,
                                       10     => 227272,
                                       11     => 214518,
                                       12     => 202478,
                                       others => 0);
  begin
    Data <= value;
    reading : process(rst,clk)
    begin
      if( rst = '1') then
        value <= 0;
      elsif(clk'event and clk='1') then
        ROM_address <= to_integer(unsigned(Address));
        value <= notes_rom(ROM_address);
      end if;
    end process reading;
end Behavioral;