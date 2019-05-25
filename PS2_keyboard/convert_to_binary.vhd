-------------------------------------------------------------------------------
-- Title      : convert_to_binary.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        Look-up-Table
-- 		
--
-------------------------------------------------------------------------------

library ieee; 
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all; 
use std.textio.all;  
use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;

entity convert_to_binary is
    port (
	     scan_code_in : in unsigned(7 downto 0);
	     binary_out   : out unsigned(3 downto 0)
	 );
end convert_to_binary;

architecture convert_to_binary_arch of convert_to_binary is

begin

process (scan_code_in) begin
-- simple combinational logic using case statements (LUT) 

        case (scan_code_in) is
            when X"16"  =>  
                binary_out <= X"1";
            when X"1E"  =>  
                binary_out <= X"2";
            when X"26"  =>  
                binary_out <= X"3";
            when X"25"  =>  
                binary_out <= X"4";  
            when X"2E"  =>  
                binary_out <= X"5";
            when X"36"  =>  
                binary_out <= X"6";
            when X"3D"  =>  
                binary_out <= X"7";
            when X"3E"  =>  
                binary_out <= X"8";
            when X"46"  =>  
                binary_out <= X"9";
            when X"45"  =>  
                binary_out <= X"0"; 
            when others =>  
                binary_out <= X"E";
        end case;
    
    --seg_en <= seg_en_reg
    end process;
end convert_to_binary_arch;
