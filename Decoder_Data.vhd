library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_Data is
  port(switch_notes : in std_logic_vector(11 downto 0);
       address      : out std_logic_vector(3 downto 0);
       data_display : out std_logic_vector(3 downto 0);
       dots         : out std_logic_vector(7 downto 0));
end Decoder_Data;

architecture Behavioral of Decoder_Data is
  begin
    address <= "0001" when switch_notes = "000000000001" else    -- C Note
               "0010" when switch_notes = "000000000010" else    -- C# Note
               "0011" when switch_notes = "000000000100" else    -- D Note
               "0100" when switch_notes = "000000001000" else    -- D# Note
               "0101" when switch_notes = "000000010000" else    -- E Note
               "0110" when switch_notes = "000000100000" else    -- F Note
               "0111" when switch_notes = "000001000000" else    -- F# Note
               "1000" when switch_notes = "000010000000" else    -- G Note
               "1001" when switch_notes = "000100000000" else    -- G# Note
               "1010" when switch_notes = "001000000000" else    -- A Note
               "1011" when switch_notes = "010000000000" else    -- A# Note
               "1100" when switch_notes = "100000000000" else    -- B Note
               "0000";
    data_display <= "1100" when switch_notes = "000000000001" else    -- C Note
                    "1100" when switch_notes = "000000000010" else    -- C# Note
                    "1101" when switch_notes = "000000000100" else    -- D Note
                    "1101" when switch_notes = "000000001000" else    -- D# Note
                    "1110" when switch_notes = "000000010000" else    -- E Note
                    "1111" when switch_notes = "000000100000" else    -- F Note
                    "1111" when switch_notes = "000001000000" else    -- F# Note
                    "0110" when switch_notes = "000010000000" else    -- G Note
                    "0110" when switch_notes = "000100000000" else    -- G# Note
                    "1010" when switch_notes = "001000000000" else    -- A Note
                    "1010" when switch_notes = "010000000000" else    -- A# Note
                    "1011" when switch_notes = "100000000000" else    -- B Note
                    "0000";
    dots <= "00000000" when switch_notes = "000000000001" else    -- C Note
            "00000001" when switch_notes = "000000000010" else    -- C# Note
            "00000000" when switch_notes = "000000000100" else    -- D Note
            "00000001" when switch_notes = "000000001000" else    -- D# Note
            "00000000" when switch_notes = "000000010000" else    -- E Note
            "00000000" when switch_notes = "000000100000" else    -- F Note
            "00000001" when switch_notes = "000001000000" else    -- F# Note
            "00000000" when switch_notes = "000010000000" else    -- G Note
            "00000001" when switch_notes = "000100000000" else    -- G# Note
            "00000000" when switch_notes = "001000000000" else    -- A Note
            "00000001" when switch_notes = "010000000000" else    -- A# Note
            "00000000" when switch_notes = "100000000000" else    -- B Note
            "00000000";
end Behavioral;