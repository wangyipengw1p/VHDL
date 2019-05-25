library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
--USE std.standard.all;
use ieee.std_logic_signed.all;

entity mod3 is		--pure combnitional
   port ( A          : in  std_logic_vector (7 downto 0);   -- Input A range(
          result 	   : out std_logic_vector (7 downto 0);   -- output (unsigned binary)
        );
end ALU;

architecture behavioral of mod3 is

begin

    process ( A, B )
    variable modBuffer: signed(7 downto 0);
    begin

            modBuffer := signed(A);
            
			if modBuffer < 0 then
				modBuffer := not modBuffer + 1; --abs()
			end if;  

            if modBuffer >= 96 then modBuffer := modBuffer - 96; end if;
            if modBuffer >= 48 then modBuffer := modBuffer - 48; end if;
            if modBuffer >= 24 then modBuffer := modBuffer - 24; end if;
            if modBuffer >= 12 then modBuffer := modBuffer - 12; end if;
            if modBuffer >= 6 then modBuffer := modBuffer - 6; end if;
            if modBuffer >= 3 then modBuffer := modBuffer - 3; end if;

            --special for signed---------------------------------
            if  A(7) = '1' then
                if modBuffer = "00000010" then modBuffer := "00000001";
                elsif modBuffer = "00000001" then modBuffer := "00000010";
                end if;
            ------------------------------------------------------
            end if;
            result <= Std_logic_vector(modBuffer);
   end process;

    
end behavioral;
