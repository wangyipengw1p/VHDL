library IEEE, STD;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity clk_div_odd is
generic(div:integer:=25);
port(
	clk:in std_logic;
	rst:in std_logic;
	clko:out std_logic
);
end clk_div_odd;
architecture behaviral of clk_div_odd is 
signal counter:unsigned(7 downto 0);
signal clkp, clkn, clkp_n, clkn_n: std_logic;
begin
p_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' then 
            counter <= (others => '0');
			clkp <= '0';
        else 
			clkp <= clkp_n;
			counter <= counter + 1;
			if counter = div then counter <= to_unsigned(1,8); end if;
        end if;
    end if;
end process;
n_reg:process(clk,rst)
begin
    if falling_edge(clk) then
        if rst = '0' then 
            clkn <= '0';
        else 
			clkn <= clkn_n;
        end if;
    end if;
end process;

comb:process(clkn, clkp, counter)
begin
	clkn_n <= clkn;
	clkp_n <= clkp;
	if counter = div then clkp_n <= not clkp; end if;
	if counter = (div - 1 )/ 2 then clkn_n <= not clkn; end if;
end process;

clk_o <= clkp xor clkn;
end behaviral
