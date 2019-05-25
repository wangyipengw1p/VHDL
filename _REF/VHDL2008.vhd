-- VHDL2008 Supports Block comments similar to Verilog using /* */
-- 
/*
Block Comment section
*/
		
-- VHDL2008 supports new Condition operator ?? This converts std_logic expression to a boolean value

-- Example below can be coded as
-- if A = '1' and B = '1' then 

if ?? A and B then

-- VHDL2008 enhances bit string literals to include:
-- explicit width
-- Signed/unsigned
-- Meta values ('U','X', etc)

-- Example
variable T : std_logic_vector(7 downto 0);
  begin
    T := 8x"0f";  -- width 8
    T := 8x"XA";  -- "XXXX1010" 
    T := 8SX"F";  -- "11111111" (sign extension)
    T := 8Ux"f";  -- "00001111" (zero extension)
    T := 8sb"11"; -- "11111111" (binary format)
    T := 8uO"7";  -- "00000111" (octal format)

-- VHDL2008 enhanced generate statement and supports if-elsif and  case

-- Using if-elsif
g1 : if G = 1 generate
  a1 : entity work.sub(arch1) port map (din => din,dout=> dout);    
elsif G2 = 2 generate
  a2 : entity work.sub(arch2) port map (din => din,dout=> dout);    
end generate;

-- Using case generate
G1 : 
case G generate
  when 1 => a1 : entity work.sub(arch1) port map (din => din,dout=> dout);    
  when 2 => a2 : entity work.sub(arch2) port map (din => din,dout=> dout);    
  when others  => a3 : entity work.sub(arch2) port map (din => din,dout=> dout);    
end generate;


-- VHDL2008 introduced Matching case statement to handle dont_care values
-- Example
case? sel is
    when "1---" => out <= "01";
    when "01--" => out <= "10";
    when "001-" => out <= "11";
    when "0001" => out <= "00";
    when others => null;
end case;


-- VHDL2008 supports Matching Relational operators ?=  ?/=  ?< ?<= ?>  ?>=  which return bit/std_ulogic
-- These relational operators also understand dont_care "-" 
-- Example
dout1 <= sig1 and sig2 and sig3 ?= "1100--";
dout2 <= sig1 and sig2 and sig3 ?/= "1100--";
dout3 <= sig1 and sig2 and sig3 ?<= "1100--";
dout4 <= sig1 and sig2 and sig3 ?>= "1100--";


-- VHDL2008 introduced simplified sensitivity lists
-- Example (all) can be specfied to implicitly indicate that all the signals read in the process are included  
process(all) 
begin
-- Other assignments
end process;


-- VHDL2008 allows us to have unconstrained elements with Composite types (Arrays/records)
-- These need to be constrained appropriately during the usage 
-- Array Example
type array_T is array (natural range<>) of std_logic_vector;

-- Record Example
type Record_T is
record
  a : std_logic_vector;
  b : std_logic_vector;
end record;
			