----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2018 08:50:20 PM
-- Design Name: 
-- Module Name: moore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity moore is
    Port ( d_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           res : in STD_LOGIC;
           d_out2 : out STD_LOGIC);
end moore;

architecture Behavioral of moore is
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
    signal current_state, next_state: state_type;
    
begin
    reg: process(clk, res)
    begin
        if clk'event and clk = '0' then 
            if res = '1' then current_state <= next_state;
            else current_state <= s0;
            end if;
        end if;
    end process reg;
    
    combine: process(d_in, current_state)
    begin
    
        d_out2 <= '0';
        next_state <= current_state;
        
        case current_state is
            when s0 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s0;
                else
                    next_state <= s1; 
                end if;
            when s1 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s2; 
               else 
                    next_state <= s1; 
                end if;
            when s2 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s0;
                else 
                    next_state <= s3; 
                end if;
            when s3 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s4;
                else 
                    next_state <= s1; 
                end if;
             when s4 =>
                 d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s5; 
                else 
                    next_state <= s3; 
                end if;                           
            when s5 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s0;
                else 
                    next_state <= s6; 
                end if;                     
            when s6 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s2; 
                else 
                    next_state <= s7; 
                end if;                     
            when s7 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s2;
                else 
                    next_state <= s8; 
                end if;
            when s8 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s2; 
                else 
                    next_state <= s9; 
                end if;
            when s9 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s10; 
                else 
                    next_state <= s1; 
                end if;
            when s10 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s0; 
                else 
                    next_state <= s11; 
                end if;                                                  
            when s11 =>
                d_out2 <= '0';
                if d_in = '0' then 
                    next_state <= s12; 
                else 
                    next_state <= s1; 
                end if;   
            when s12 =>
                d_out2 <= '1';
                if d_in = '0' then 
                    next_state <= s5; 
                else 
                    next_state <= s3; 
                end if;                                            
            when others => null;
        end case;
                                                   
                                                                                                                                                            
    end process combine;

end Behavioral;