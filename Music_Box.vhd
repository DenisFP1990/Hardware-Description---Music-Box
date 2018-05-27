library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Music_Box is
  port( rst         : in std_logic;
        clk         : in std_logic;
        volume_up   : in std_logic;
        volume_down : in std_logic;
        switch_note : in std_logic_vector(11 downto 0);
        display     : out std_logic_vector(6 downto 0);
        disp_en     : out std_logic_vector(7 downto 0);
        dot         : out std_logic;
        pwm_signal  : out std_logic;
        audio_pwm   : out std_logic);
end Music_Box;

architecture Behavioral of Music_Box is
  -- COMPONENTS
  component Decoder_Data is
    port(switch_notes : in std_logic_vector(11 downto 0);
         address      : out std_logic_vector(3 downto 0);
         data_display : out std_logic_vector(3 downto 0);
         dots         : out std_logic_vector(7 downto 0));
  end component;
  component PWM_Counter is
    port( rst        : in std_logic;
          clk        : in std_logic;
          max_count  : in integer;
          duty_cycle : in integer;
          pwm        : out std_logic);
  end component;
  component ROM_Notes is
    port( rst     : in std_logic;
          clk     : in std_logic; 
          Address : in std_logic_vector(3 downto 0);
          Data    : out integer range 0 to 400000);
  end component;
  component Display_Shifter is
    port( rst     : in std_logic;
          clk     : in std_logic;
          Number0 : in std_logic_vector(3 downto 0);
          Number1 : in std_logic_vector(3 downto 0);
          Number2 : in std_logic_vector(3 downto 0);
          Number3 : in std_logic_vector(3 downto 0);
          Number4 : in std_logic_vector(3 downto 0);
          Number5 : in std_logic_vector(3 downto 0);
          Number6 : in std_logic_vector(3 downto 0);
          Number7 : in std_logic_vector(3 downto 0);
          dot_in  : in std_logic_vector(7 downto 0);
          Display : out std_logic_vector(6 downto 0);
          dot_out : out std_logic;
          Disp_En : out std_logic_vector(7 downto 0));
  end component;
  component Volume_Control is
    port( rst      : in std_logic;
          clk      : in std_logic;
          vol_up   : in std_logic;
          vol_down : in std_logic;
          volume   : out integer range 0 to 100);
  end component;
  -- SIGNALS
  signal aux_address : std_logic_vector(3 downto 0);
  signal aux_display : std_logic_vector(3 downto 0);
  signal aux_dots : std_logic_vector(7 downto 0);
  signal aux_data : integer range 0 to 400000;
  signal aux_volume : integer range 0 to 100;
  signal pwm_aux : std_logic;
  begin
    pwm_signal <= pwm_aux;
    audio_pwm <= pwm_aux;
    VOLUME : Volume_Control
      port map( rst => rst,
                clk => clk,
                vol_up => volume_up,
                vol_down => volume_down,
                volume => aux_volume);
    DECODER : Decoder_Data
      port map( switch_notes => switch_note,
                address => aux_address,
                data_display => aux_display,
                dots => aux_dots);
    MEMORY : ROM_Notes
      port map( rst => rst,
                clk => clk,
                Address => aux_address,
                Data => aux_data);
    PWM_GEN : PWM_Counter
      port map( rst => rst,
                clk => clk,
                max_count => aux_data,
                duty_cycle => aux_volume,
                pwm => pwm_aux);
    DISPLAYS : Display_Shifter
      port map( rst => rst,
                clk => clk,
                Number0 => aux_display,
                Number1 => "0000",
                Number2 => "0000",
                Number3 => "0000",
                Number4 => "0000",
                Number5 => "0000",
                Number6 => "0000",
                Number7 => "0000",
                dot_in => aux_dots,
                Display => display,
                dot_out => dot,
                Disp_En => disp_en);
end Behavioral;