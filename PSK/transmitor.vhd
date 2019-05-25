----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/05/11 20:46:19
-- Design Name: 
-- Module Name: transmitor - Behavioral
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

entity transmitor is
    Port ( clk : in STD_LOGIC;--100MHz
           rst : in STD_LOGIC;
           mode : in STD_LOGIC_vector(1 downto 0);
           d_in : in STD_LOGIC;
           d_out : out STD_LOGIC_vector(13 downto 0));
end transmitor;

architecture Behavioral of transmitor is
component blk_mem_gen_0 IS
  PORT (
    clka    : IN STD_LOGIC;
    addra   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    douta   : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    clkb    : IN STD_LOGIC;
    addrb   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    doutb   : OUT STD_LOGIC_VECTOR(13 DOWNTO 0)
  );
end component;
signal en: std_logic;
signal addr, addrn, addr2: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal count2k, count2k_n: unsigned(10 downto 0);
constant Barker: std_logic_vector(12 downto 0):="1111100110101"; -- Barker13 +++++--++-+-+
constant myid: std_logic_vector(31 downto 0) := "00010110011100010001000001100101"; --16711065
signal idmsg, idmsg_n:std_logic_vector(44 downto 0);
signal recevMsg,recevMsg_n:std_logic_vector(12 downto 0);
signal which2send, which2send_n: std_logic;
signal douta, doutb: STD_LOGIC_VECTOR(13 DOWNTO 0);
begin
en <= mode(1);
inst_rom:blk_mem_gen_0 port map(
    clka =>clk ,
    addra=>addr,
    douta=>douta,
    clkb =>clk ,
    addrb=>addr2,
    doutb=>doutb);
transmitor_uni_reg:process(clk,rst)
begin
    if rising_edge(clk) then
        if rst = '0' or en = '0' then 
            addr <= (others => '0');
            count2k <= (others => '0');
            idmsg <= Barker & myid;
            which2send <= '0';
            recevMsg <= Barker;
        else 
            addr <= addrn;
            count2k <= count2k_n;
            idmsg <= idmsg_n;
            which2send <= which2send_n;
            recevMsg <= recevMsg_n;
        end if;
    end if;
end process;
addr_comb:process(addr)
begin
    addrn <= addr;
    if addr = 9 then addrn <= "0000"; end if; 
    if addr > 4 then addr2 <= addr - 5; else addr2 <= addr + 5; end if;
end process;

count_comb: process(count2k)
begin
    count2k_n <= count2k + 1;
    if count2k = 2001 then count2k_n <= to_unsigned(2,11);end if; --wait for rom
end process;

idmsg_comb:process(idmsg,count2k)
begin
    idmsg_n <= idmsg;
    if count2k = 1000 then idmsg_n <= idmsg(43 downto 0) & idmsg(44);end if;
end process;

recevMsg_comb:process(recevMsg,d_in,count2k)
begin
    recevMsg_n <= recevMsg;
    if count2k = 500 then recevMsg_n <= recevMsg(11 downto 0) & d_in;end if;
end process;

select_send_MUXS:process(idmsg,which2send, count2k, mode, recevMsg)
begin
which2send_n <= which2send;
if count2k = 1 or count2k = 2001 then 
    if mode = "10" then which2send_n <= idmsg(44); else which2send_n <= recevMsg(12); end if;
end if;    
end process;

d_out <= douta when which2send = '1' else doutb;

end Behavioral;
