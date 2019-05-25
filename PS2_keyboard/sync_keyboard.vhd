-------------------------------------------------------------------------------
-- Title      : sync_keyboard.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity sync_keyboard is
    port (
         rst : in std_logic;
	     clk : in std_logic; 
	     kb_clk : in std_logic;
	     kb_data : in std_logic;
	     kb_clk_sync : out std_logic;
	     kb_data_sync : out std_logic
	 );
end sync_keyboard;


architecture sync_keyboard_arch of sync_keyboard is

signal kb_data_1 : std_logic ;
signal kb_clk_1  : std_logic ;

begin
    process(clk) 
    begin 
  
        if rising_edge(clk) then
            if ( rst = '1' ) then
                kb_clk_1     <= '0';
                kb_clk_sync  <= '0';
                kb_data_1    <= '0';
                kb_data_sync <= '0';
            else 
                kb_clk_1     <= kb_clk;
                kb_clk_sync  <= kb_clk_1;
                kb_data_1    <= kb_data;
                kb_data_sync <= kb_data_1;
            end if;
            
        end if;  
           
    end process;
        
end sync_keyboard_arch;
