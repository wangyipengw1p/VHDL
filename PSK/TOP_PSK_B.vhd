----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/05/11 20:43:04
-- Design Name: 
-- Module Name: TOP_PSK_B - Behavioral
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

entity TOP_PSK_B is
    Port ( d_in     : in STD_LOGIC_vector(13 downto 0);
           clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           d_out    : out STD_LOGIC_vector(13 downto 0));
end TOP_PSK_B;

architecture Behavioral of TOP_PSK_B is
component Decoder is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           d_in     : in STD_LOGIC_vector(13 downto 0);
           d_out    : out STD_LOGIC;
           flag     : out STD_LOGIC);
end component;
component detector is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           d_in     : in STD_LOGIC;
           flag_d     : in STD_LOGIC;
           mode     : out STD_LOGIC_vector(1 downto 0);
           d_out    : out std_logic);
end component;
component transmitor is
    Port ( clk      : in STD_LOGIC;
           rst      : in STD_LOGIC;
           mode     : in STD_LOGIC_vector(1 downto 0);
           d_in     : in STD_LOGIC;
           d_out    : out STD_LOGIC_vector(13 downto 0));
end component;

signal deco_detec   : std_logic;
signal flag         : std_logic;
signal mode         : std_logic_vector(1 downto 0);
signal detec_tran   : std_logic;
begin
inst_decoder:decoder port map(
    clk   => clk  ,
    rst   => rst  ,
    d_in  => d_in ,
    d_out => deco_detec,
    flag  => flag );
inst_detector:detector port map(
    clk    => clk  ,
    rst    => rst  ,
    d_in   => deco_detec ,
    flag_d => flag ,
    mode   => mode ,
    d_out  => detec_tran);
inst_transmitor:transmitor port map(
    clk   => clk   ,
    rst   => rst   ,
    mode  => mode  ,
    d_in  => detec_tran  ,
    d_out => d_out );
end Behavioral;
