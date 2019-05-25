----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/12/2018 03:26:24 PM
-- Design Name: 
-- Module Name: mealy - Behavioral
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

entity mealy is
    Port ( d_in : in STD_LOGIC;
           clk : in STD_LOGIC;
           res : in STD_LOGIC;
           d_out1 : out STD_LOGIC);
end mealy;

architecture Behavioral of mealy is
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
    signal current_state, next_state: state_type;
    
begin
    reg: process(clk, res)
    begin
        if clk'event and clk = '0' then --Falling trigger
            if res = '1' then current_state <= next_state;
            else current_state <= s0;
            end if;
        end if;
    end process reg;
    
    combine: process(d_in, current_state)
    begin
    
        d_out1 <= '0';
        next_state <= current_state;
        
        case current_state is
            when s0 =>
                if d_in = '0' then 
                    next_state <= s0; 
                    d_out1 <= '0';
                else
                    next_state <= s1; 
                    d_out1 <= '0';
                end if;
            when s1 =>
                    if d_in = '0' then 
                        next_state <= s2; 
                        d_out1 <= '0';
                   else 
                        next_state <= s1; 
                        d_out1 <= '0';
                    end if;
            when s2 =>
                    if d_in = '0' then 
                        next_state <= s0; 
                        d_out1 <= '0';
                    else 
                        next_state <= s3; 
                        d_out1 <= '0';
                    end if;
            when s3 =>
                    if d_in = '0' then 
                        next_state <= s4; 
                        d_out1 <= '0';
                    else 
                        next_state <= s1; 
                        d_out1 <= '0';
                    end if;
             when s4 =>
                    if d_in = '0' then 
                        next_state <= s5; 
                        d_out1 <= '0';
                    else 
                        next_state <= s3; 
                        d_out1 <= '0';
                    end if;                           
            when s5 =>
                    if d_in = '0' then 
                        next_state <= s0; 
                        d_out1 <= '0';
                    else 
                        next_state <= s6; 
                        d_out1 <= '0';
                    end if;                     
            when s6 =>
                    if d_in = '0' then 
                        next_state <= s2; 
                        d_out1 <= '0';
                    else 
                        next_state <= s7; 
                        d_out1 <= '0';
                    end if;                     
            when s7 =>
                    if d_in = '0' then 
                        next_state <= s2; 
                        d_out1 <= '0';
                    else 
                        next_state <= s8; 
                        d_out1 <= '0';
                    end if;
            when s8 =>
                    if d_in = '0' then 
                        next_state <= s2; 
                        d_out1 <= '0';
                    else 
                        next_state <= s9; 
                        d_out1 <= '0';
                    end if;
            when s9 =>
                    if d_in = '0' then 
                        next_state <= s10; 
                        d_out1 <= '0';
                    else 
                        next_state <= s1; 
                        d_out1 <= '0';
                    end if;
            when s10 =>
                    if d_in = '0' then 
                        next_state <= s0; 
                        d_out1 <= '0';
                    else 
                        next_state <= s11; 
                        d_out1 <= '0';
                    end if;                                                  
            when s11 =>
                    if d_in = '0' then 
                        next_state <= s4; 
                        d_out1 <= '1';
                    else 
                        next_state <= s1; 
                        d_out1 <= '0';
                    end if;                                               
            when others => null;
        end case;
                                                   
                                                                                                                                                            
    end process combine;

end Behavioral;
