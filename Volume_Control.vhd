library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Volume_Control is
  port( rst      : in std_logic;
        clk      : in std_logic;
        vol_up   : in std_logic;
        vol_down : in std_logic;
        volume   : out integer range 0 to 100);
end Volume_Control;

architecture Behavioral of Volume_Control is
  -- COMPONENTS
  component Pulse_Volume is
    port( rst        : in std_logic;
          clk        : in std_logic;
          button_in  : in std_logic;
          pulse      : out std_logic);
  end component;
  component Volume_Counter is
    port(clk    : in std_logic;
         rst    : in std_logic;
         up     : in std_logic;
         down   : in std_logic;
         volume : out integer range 0 to 100);
  end component;
  -- SIGNALS
  signal pulse_up : std_logic;
  signal pulse_down : std_logic;
  begin
    UP_PULSE : Pulse_Volume
      port map( rst => rst,
                clk => clk,
                button_in => vol_up,
                pulse => pulse_up);
    DOWN_PULSE : Pulse_Volume
      port map( rst => rst,
                clk => clk, 
                button_in => vol_down,                
                pulse => pulse_down);
    VOL_CONTROL : Volume_Counter
      port map( clk => clk,
                rst => rst,
                up => pulse_up,
                down => pulse_down,
                volume => volume);
end Behavioral;