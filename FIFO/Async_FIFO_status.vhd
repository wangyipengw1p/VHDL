
library IEEE, STD; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity FIFO_status is
port (	reset : in std_logic;
		clk : in std_logic;
		fifo_wr : in std_logic;
		fifo_rd : in std_logic;
		valid_rd : out std_logic;
		valid_wr : out std_logic;
		rd_ptr : out std_logic_vector(4 downto 0);
		wr_ptr : out std_logic_vector(4 downto 0);
		empty : out std_logic;
		full : out std_logic
);
end FIFO_status;
architecture behaviral of status is
signal rd_ptr_s : std_logic_vector(4 downto 0);
signal wr_ptr_s : std_logic_vector(4 downto 0);
signal valid_rd_s : std_logic;
signal valid_wr_s : std_logic;
begin
empty_P : process(clk, reset)
begin
	if (reset = '1') then
		empty <= '1';
	elsif rising_edge(clk) then
		if (fifo_wr = '1' and fifo_rd = '1') then
			-- do nothing
			null;
		elsif (fifo_wr = '1') then
			-- write unconditionally clears empty
			empty <= '0';
		elsif (fifo_rd = '1' and (wr_ptr_s = rd_ptr_s + '1')) then
			-- set empty
			empty <= '1';
		end if;
	end if;
end process;

full_P : process(clk, reset)
begin
	if (reset = '1') then
		full <= '0';
	elsif rising_edge(clk) then
		if (fifo_rd = '1' and fifo_wr = '1') then
			-- do nothing
			null;
		elsif (fifo_rd = '1') then
			-- read unconditionally clears full
			full <= '0';
		elsif (fifo_wr = '1' and (rd_ptr_s = wr_ptr_s + '1')) then
			-- set full
			full <= '1';
		end if;
	end if;
end process;

valid_rd_s <= '1' when (empty = '0' and fifo_rd = '1');
valid_wr_s <= '1' when (full = '0' and fifo_wr = '1');

wr_ptr_s_P : process(clk, reset)
begin
	if (reset = '1') then
		wr_ptr_s_P <= (others => '0');
	elsif rising_edge(clk) then
		if (valid_wr_s = '1') then
			wr_ptr_s <= wr_ptr_s + '1';
		end if;
	end if;
end process;

rd_ptr_s_P : process(clk, reset)
begin
	if (reset = '1') then
		rd_ptr_s_P <= (others => '0');
	elsif rising_edge(clk) then
		if (valid_rd_s = '1') then
			rd_ptr_s <= rd_ptr_s + '1';
		end if;
	end if;
end process;

rd_ptr <= rd_ptr_s;
wr_ptr <= wr_ptr_s;

end behaviral;
