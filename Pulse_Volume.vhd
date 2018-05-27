library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Pulse_Volume is
  port( rst        : in std_logic;
        clk        : in std_logic;
        button_in  : in std_logic;
        pulse      : out std_logic);
end Pulse_Volume;

architecture Behavioral of Pulse_Volume is
  -- COMPONENTS
  component Antibounce is
  port( button_in  : in std_logic;
        clk        : in std_logic;
        rst        : in std_logic;
        button_out : out std_logic);
  end component;
  component Edge_Detector is
    port( rst    : in std_logic;
          clk    : in std_logic;
          button : in std_logic;
          pulse  : out std_logic);
  end component;
  -- SIGNALS
  signal filtered_button : std_logic;
  begin
    ANTIBOUNCER : Antibounce
      port map( button_in => button_in,
                clk => clk,
                rst => rst,
                button_out => filtered_button);
    PULSE_GEN : Edge_Detector
      port map( rst => rst,
                clk => clk,
                button => filtered_button,
                pulse => pulse);
end Behavioral;