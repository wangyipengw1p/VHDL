library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.ALL;



entity Blink is 
port(
	clk		:	in	std_logic;
	rst		:	in	std_logic;
	LED		:	out	std_logic
	);
end Blink;

architecture Blink is 
signal count: unsigned(19 downto 0);
signal LED_r, LED_n: std_logic;
begin

LED <= LED_r;

universal_reg: process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            count <= (others => '0');
			LED_r <= '0';
        else 
			count <= count + 1;
			LED_r <= LED_n;
        end if;
    end if;
end process;

LED_R_comb: process(LED_r, count)
begin
LED_n <= LED_r;
if count = 0 then LED_n <= not LED_r; end if;
end process;
end architecture;
