library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Antibounce is
  port( button_in  : in std_logic;
        clk        : in std_logic;
        rst        : in std_logic;
        button_out : out std_logic);
end Antibounce;

architecture Behavioral of Antibounce is
  -- Components Definition
  component Counter_Antibounce is
    port(rst    : in std_logic;
         clk    : in std_logic;
         start  : in std_logic;
         finish : out std_logic);
  end component;
  component FSM_Antibounce is
    port ( rst        : in std_logic;
           clk        : in std_logic; 
           button_in  : in std_logic;
           c_end      : in std_logic;                  
           button_out : out std_logic;
           c_start    : out std_logic);
  end component;
  -- Auxiliary Signals Definition
  signal c_start_aux : std_logic;
  signal c_end_aux : std_logic;
  -- Structural
  begin
    FSM : FSM_Antibounce
      port map( rst => rst,
                clk => clk,
                button_in => button_in,
                c_end => c_end_aux,
                button_out => button_out,
                c_start => c_start_aux);
    Counter : Counter_Antibounce
      port map( rst => rst,
                clk => clk,
                start => c_start_aux,
                finish => c_end_aux);
end Behavioral;