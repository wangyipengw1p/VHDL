-------------------------------------------------------------------------------
-- Title      : keyboard_ctrl.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        controller to handle the scan codes 
-- 		        
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity keyboard_ctrl is
    port (
	     clk : in std_logic; 
	     rst : in std_logic;
	     valid_code : in std_logic;
	     scan_code_in : in unsigned(7 downto 0);
	     code_to_display : out unsigned(7 downto 0);
	     seg_en : out unsigned(3 downto 0)
	 );
end keyboard_ctrl;
architecture keyboard_ctrl_arch of keyboard_ctrl is
--------------------------------------------------------------------------
type state is (st0, st1, st2);
signal present_state, next_state : state;
signal seg_en_reg    : std_logic_vector (3 downto 0) := "1110"; 
signal scan_code_reg : unsigned(7 downto 0); -- should be initialized in reset
signal code_to_display_reg : unsigned(7 downto 0) := X"00";
----signal counter_break_code: std_logic_vector(1 downto 0) := "00";
signal counterX: unsigned(11 downto 0) := X"000";
signal counter : unsigned(2 downto 0):= "000";
signal Four_digit   : unsigned(31 downto 0) := X"EEEEEEEE"; 
signal CF: std_logic ;
begin
----------------------------------------------------------------------------
syncronous_process : process (clk) begin 
    if rising_edge(clk) then
        if (rst = '1' ) then
            present_state <= st0;
            -- Four_digit <= X"EEEEEEEE";
            -- counter    <= '00';  
        else
            present_state <= next_state;
        end if;
    end if;
end process;
----------------------------------------------------------------------------
next_state_and_output_decoder : process(scan_code_in, valid_code)

begin
    case (present_state) is 
        when st0 =>
            if(valid_code = '0') then
                next_state <= st0;
            elsif(valid_code = '1') then
                scan_code_reg <= scan_code_in;
                next_state <= st1;
            end if;
        when st1 =>
            if(valid_code = '0') then
                next_state <= st1;
            elsif(valid_code = '1') then
                if (scan_code_in = X"F0") then
                    next_state <= st2;
                    --Four_digit (7 downto 0) <= X"EE";
                end if;
            end if;
          when st2 =>
               if(valid_code = '0') then
                   next_state <= st2;
               elsif(valid_code = '1') then
                   if (scan_code_in = unsigned(scan_code_reg)) then
                       next_state <= st0;
                       code_to_display <= scan_code_reg;
                       if (counter < "100") then
                         counter <= counter + 1; 
                       end if;
                    else
                        next_state    <= st0;
                        scan_code_reg <= X"EE";   
                   end if;
               end if;
           end case;
           
 end process;

digit_shifter: process (counter)  

begin    
       if (counter = 1) then 
           Four_digit (7 downto 0)   <= scan_code_reg;
       elsif (counter = 2) then 
           Four_digit (15 downto 8)  <= Four_digit (7 downto 0);
           Four_digit (7 downto 0)   <= scan_code_reg;
       elsif (counter = 3) then 
           Four_digit (23 downto 16) <= Four_digit (15 downto 8);
           Four_digit (15 downto 8)  <= Four_digit (7 downto 0);
           Four_digit (7 downto 0)   <= scan_code_reg;
       elsif (counter = 4) then 
           Four_digit (31 downto 24) <= Four_digit (23 downto 16);
           Four_digit (23 downto 16) <= Four_digit (15 downto 8);
           Four_digit (15 downto 8)  <= Four_digit (7 downto 0);
           Four_digit (7 downto 0)   <= scan_code_reg;
      end if;
         
end process;

seven_seg_en: process (counter)  

begin    
       if (counter = 1) then 
           seg_en <= "1110";
       elsif (counter = 2) then 
           if(counterX = 1) then 
              seg_en <= "1110";
           else 
              seg_en <= "1101";
           end if; 
       elsif (counter = 3) then 
           if(counterX = 1) then 
              seg_en <= "1110";
           elsif (counterX = 1) then 
              seg_en <= "1101";
           elsif (counterX = 1) then 
              seg_en <= "1011";
           end if; 
       elsif (counter = 4) then 
           if(counterX = 1) then 
              seg_en <= "1110";
           elsif (counterX = 2) then 
              seg_en <= "1101";
           elsif (counterX = 3) then 
              seg_en <= "1011";
           elsif (counterX = 4) then 
              seg_en <= "0111";
           end if;
      end if;
         
end process;

end keyboard_ctrl_arch;

      
     -- code_to_display <= unsigned(code_to_display_reg);
--else
--next_state <= st0;
--code_to_display <= X"EE";
-- end if; 
-- when st1 =>
--if (din = '1') then
--next_state <= st1;
--dout <= '0';
--else

--    counterX <= counterX + 1;
--    CF <= counterX (12);

--end process;
--process (CF) 
--begin
--seg_en_reg <= rol std_logic_vector(seg_en_reg) ;
--end process;
--process (CF)
--begin
--    if (counter_break_code = "00") then
--        seg_en_reg <= "1110"; 
--    elsif (counter_break_code = "01" ) then
--       case(seg_en_reg) is
--          when "1110" =>
--            seg_en_reg <= "1101";
--          when "1101" =>
--            seg_en_reg <= "1110";
--         end case;
--    elsif (counter_break_code="10") then
--         case(seg_en_reg) is
--            when "1110" =>
--               seg_en_reg <= "1101";
--            when "1101" =>
--               seg_en_reg <= "1011"; 
--            when "1011" =>
--               seg_en_reg <= "1110";
--         end case; 
--    elsif (counter_break_code="11") then
--          case(seg_en_reg) is
--             when "1110" =>
--                seg_en_reg <= "1101";
--             when "1101" =>
--                seg_en_reg <= "1011"; 
--             when "1011" =>
--                seg_en_reg <= "0111";
--             when "0111" =>
--                seg_en_reg <= "1110";    
--          end case; 
--    end if;  
