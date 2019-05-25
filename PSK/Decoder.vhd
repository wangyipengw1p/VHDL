----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/05/11 20:43:04
-- Design Name: 
-- Module Name: Decoder - Behavioral
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

entity decoder is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d_in : in STD_LOGIC_vector(13 downto 0);
           d_out : out STD_LOGIC;
           flag : out STD_LOGIC);
end decoder;

architecture Behavioral of Decoder is

constant threshold: integer := 15000;

signal count2k: unsigned(10 downto 0);
signal start_count,start_count_n:std_logic;
signal max, max_n:STD_LOGIC_vector(13 downto 0);
signal dout,dout_n: std_logic;
begin
count_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' or start_count = '0'then 
            count2k <= (others => '0');
        else 
            count2k <= count2k + 1;
            if count2k = 2000 then count2k <= to_unsigned(1,11); end if;
        end if;
    end if;
end process;

max_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            max <= (others => '0');
        else 
            max <= max_n;
        end if;
    end if;
end process;
max_comb:process(max, d_in)
begin
    max_n <= max;
    if d_in > max then max_n <= d_in;end if;
end process;

start_count_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            start_count <= '0';
        else 
            start_count <= start_count_n;
        end if;
    end if;
end process;
start_count_comb:process(start_count,max)
begin
    start_count_n <= start_count;
    if max > threshold and start_count = '0' then start_count_n <= '1';end if;
end process;
our_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            dout <= '1';
        else 
            dout <= dout_n;
        end if;
    end if;
end process;
out_comb:process(dout,d_in,count2k )
begin
    dout_n <= dout;
    if count2k = 1 then 
        if d_in > 8092 then dout_n <= '1'; else dout_n <= '0';end if;
    end if;
end process;
d_out <= dout;
flag_comb:process(count2k)
begin
if count2k = 2 then flag <= '1'; else flag <= '0';end if;
end process;


end Behavioral;