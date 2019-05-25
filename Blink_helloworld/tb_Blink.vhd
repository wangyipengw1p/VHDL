library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_signed.ALL;



entity tb_Blink is 
port(
	
	);
end Blink;

architecture Blink is 
signal clk, rst, LED: std_logic:='1';

component Blink is 
port(
	clk		:	in	std_logic;
	rst		:	in	std_logic;
	LED		:	out	std_logic
	);
end component;
begin

clk <= not clk after 5 ns;
rst <= '0', '1' after 10 ns;

inst_Blink: Blink port map(
	clk	 => clk	,
	rst	 => rst	,
	LED	 => LED	);


end architecture;
