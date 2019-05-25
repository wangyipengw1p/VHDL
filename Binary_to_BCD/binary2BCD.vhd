library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.ALU_components_pack.all;

entity binary2BCD is
   
   port ( 
          binary_in : in  std_logic_vector(7 downto 0);  -- binary input width
          BCD_out   : out std_logic_vector(9 downto 0)        -- BCD output, 10 bits [2|4|4] to display a 3 digit BCD value when input has length 8
        );
end binary2BCD;

architecture structural of binary2BCD is 



  
begin  

process(binary_in)
variable stack :std_logic_vector(17 downto 0);
begin

stack := (others => '0');
stack(10 downto 3) := binary_in;

for i in 0 to 4 loop
    if stack(11 downto 8) > 4 then
        stack(11 downto 8) := stack(11 downto 8) + 3;
    end if;
    if stack(15 downto 12) > 4 then
        stack(15 downto 12) := stack(15 downto 12) + 3;
    end if;
    stack(17 downto 1) := stack(16 downto 0);
end loop;
 BCD_out <= stack(17 downto 8);
end process;
--variable high4 : std_logic_vector(9 downto 0):="0000000000";
--variable low4 :  std_logic_vector(9 downto 0):="0000000000";
--begin
--    case binary_in(7 downto 4) is
--        when "0000" =>high4(8 downto 4):= "00000";      
--        when "0001" =>high4(8 downto 4):= "00001";      
--        when "0010" =>high4(8 downto 4):= "00010";      
--        when "0011" =>high4(8 downto 4):= "00011";      
--        when "0100" =>high4(8 downto 4):= "00100";      
--        when "0101" =>high4(8 downto 4):= "00101";      
--        when "0110" =>high4(8 downto 4):= "00110";      
--        when "0111" =>high4(8 downto 4):= "00111";      
--        when "1000" =>high4(8 downto 4):= "01000";      
--        when "1001" =>high4(8 downto 4):= "01001";      
--        when "1010" =>high4(8 downto 4):= "10000";      
--        when "1011" =>high4(8 downto 4):= "10001";      
--        when "1100" =>high4(8 downto 4):= "10010";      
--        when "1101" =>high4(8 downto 4):= "10011";      
--        when "1110" =>high4(8 downto 4):= "10100";      
--        when others =>high4(8 downto 4):= "10101";
--    end case;
    
--    case binary_in(3 downto 0) is
--        when "0000" =>low4(4 downto 0):= "00000";      
--        when "0001" =>low4(4 downto 0):= "00001";      
--        when "0010" =>low4(4 downto 0):= "00010";      
--        when "0011" =>low4(4 downto 0):= "00011";      
--        when "0100" =>low4(4 downto 0):= "00100";      
--        when "0101" =>low4(4 downto 0):= "00101";      
--        when "0110" =>low4(4 downto 0):= "00110";      
--        when "0111" =>low4(4 downto 0):= "00111";      
--        when "1000" =>low4(4 downto 0):= "01000";      
--        when "1001" =>low4(4 downto 0):= "01001";      
--        when "1010" =>low4(4 downto 0):= "10000";      
--        when "1011" =>low4(4 downto 0):= "10001";      
--        when "1100" =>low4(4 downto 0):= "10010";      
--        when "1101" =>low4(4 downto 0):= "10011";      
--        when "1110" =>low4(4 downto 0):= "10100";      
--        when others =>low4(4 downto 0):= "10101";
--    end case;
    
--    BCD_out <= high4 + low4;


end structural;
