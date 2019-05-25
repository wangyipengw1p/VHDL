----------------------------------------------------------------------------------
-- Engineer: wyp
-- 
-- Create Date: 10/10/2018 09:53:57 PM
-- Design Name: rec2pol
-- Module Name: ALU - Behavioral

-- 
-- Dependencies: 
-- 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;   
use ieee.std_logic_unsigned.all;
                                                                       -- !!!Not a good design, just for practice!!!

entity rec2pol is
    Port ( A        : in  unsigned(7 downto 0);
           B        : in  unsigned(7 downto 0);
           result   : out unsigned(7 downto 0);
           result_d : out unsigned(7 downto 0);
           result1   : out  unsigned(7 downto 0);
           result_d1 : out  unsigned(7 downto 0)
           );
end rec2pol;

architecture Behavioral of rec2pol is
signal fdis:unsigned(35 downto 0);
signal fang:unsigned(15 downto 0);
signal fAA:signed(23 downto 0);
type table is array(0 to 9) of unsigned(31 downto 0);  

constant actan: table:= (X"02D00000",                  
                        "00000001101010010000101000111101",
                        "00000000111000001001001101110100",
                        X"00720000"                    ,
                        "00000000001110010011011101001011",
                        "00000000000111001010001111010111",
                        "00000000000011100101000111101011",
                        "00000000000001110010101100000010",
                        "00000000000000111001010110000001",
                        "00000000000000011100101011000000"); 
begin

process (A, B, op)
variable AA:signed(23 downto 0);
variable BB:signed(23 downto 0);
variable AAn:signed(23 downto 0);
variable BBn:signed(23 downto 0);

variable angle: unsigned(31 downto 0);


begin
    
    result    <= (others => '0');
    result_d  <= (others => '0');
    result1   <= (others => '0');
    result_d1 <= (others => '0');
    
            AA :=  signed("0000" & std_logic_vector(A) & "000000000000"); 
            BB :=  signed("0000" &std_logic_vector(B) & X"000");
            angle := (others => '0');
            for i in 0 to 7 loop
                if BB >= 0 then
                    AAn := AA + shift_right(BB,i);
                    BBn := BB - shift_right(AA, i);
                    angle:= angle + actan(i);
                else
                    AAn := AA - shift_right(BB, i);
                    BBn := BB + shift_right(AA, i);
                    angle:= angle - actan(i);
                end if;
                AA := AAn;
                BB := BBn;
            end loop;
            fAA <= AA;
            fdis <= unsigned(AA) * "100110110111";--------------------------fixed point num
            fang <= angle(19 downto 12) * "01100100";
            if fdis(23 downto 12) > 255 then overflow <= '1';
            else 
                overflow <= '0';
                
            end if;  
            result <= fdis(31 downto 24);
            result_d <= fdis(23 downto 16);
            result1 <= angle (27 downto 20);
            result_d1 <= fang (15 downto 8); 
        
end process;
end Behavioral;
