----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/05/11 20:46:19
-- Design Name: 
-- Module Name: detector - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detector is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d_in : in STD_LOGIC;
           flag_d : in STD_LOGIC;
           mode : out STD_LOGIC_vector(1 downto 0);
           d_out : out std_logic);
end detector;

architecture Behavioral of detector is
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12);
signal state, state_n: state_type;
signal start, start_n: std_logic;
signal message, message_n: std_logic_vector(31 downto 0);
signal check,check_n:std_logic;
signal mode_o, mode_n: std_logic_vector(1 downto 0);
signal msgcount, msgcount_n: unsigned(8 downto 0);
begin
FSM_start_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            state <= s0;
            start <= '0';
        else 
            state <= state_n;
            start <= start_n;
        end if;
    end if;
end process;

FSM_comb:process(state, d_in, flag_d, start)
begin
state_n <= state;
start_n <= start;
if flag_d = '1' then 
    case state is
        when s0 => if d_in = '1' then state_n <= s1; else state_n <= s0;end if;
        when s1 => if d_in = '1' then state_n <= s2; else state_n <= s0;end if;
        when s2 => if d_in = '1' then state_n <= s3; else state_n <= s0;end if;
        when s3 => if d_in = '1' then state_n <= s4; else state_n <= s0;end if;
        when s4 => if d_in = '1' then state_n <= s5; else state_n <= s0;end if;
        when s5 => if d_in = '0' then state_n <= s6; else state_n <= s0;end if;
        when s6 => if d_in = '0' then state_n <= s7; else state_n <= s0;end if;
        when s7 => if d_in = '1' then state_n <= s8; else state_n <= s0;end if;
        when s8 => if d_in = '1' then state_n <= s9; else state_n <= s0;end if;
        when s9 => if d_in = '0' then state_n <= s10; else state_n <= s0;end if;
        when s10=> if d_in = '1' then state_n <= s11; else state_n <= s0;end if;
        when s11=> if d_in = '0' then state_n <= s12; else state_n <= s0;end if;
        when s12=> state_n <= s0; if d_in = '1' then start_n <= '1'; end if;
    end case;
end if;
end process;

message_shift_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            message <= (others => '0');
        else 
            message <= message_n;
        end if;
    end if;
end process;
message_comb:process(message,check,start,flag_d, d_in)
begin
    message_n <= message;
    check_n <= check;
    if start = '1' and flag_d = '1' then 
        message_n <= message(30 downto 0) & d_in;
        check_n <= check xor d_in;
    end if; 
end process;
check_mode_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            check <= '0';
            mode_o <= "00";
        else 
            check <= check_n;
            mode_o <= mode_n;
        end if;
    end if;
end process;
mode <= mode_o;
msgcount_reg:process(clk,rst)
 begin
     if rising_edge(clk) then
         if rst = '0' then 
            msgcount <= (others => '0');
         else 
            msgcount <= msgcount_n;
         end if;
     end if;
 end process;
 msgcount_comb:process(msgcount, start, flag_d, check,mode_o,check_n)
 begin
    msgcount_n <= msgcount;
    mode_n <= mode_o;
    if start = '1' and flag_d = '1' then 
        msgcount_n <= msgcount + 1; 
        if msgcount = 32 then 
            msgcount_n <= to_unsigned(1,9); 
            if check_n = '1' then mode_n <= "10"; --correct
            else mode_n <= "11"; --wrong
            end if;
        end if;
    end if;
 end process;
 d_out <= message(31);
end Behavioral;
