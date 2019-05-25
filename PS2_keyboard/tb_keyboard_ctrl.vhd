library ieee; 
use ieee.numeric_std.all; 
use ieee.std_logic_1164.all; 
use std.textio.all;  
use ieee.std_logic_textio.all;
 
ENTITY tb_keyboard_ctrl IS
END tb_keyboard_ctrl;
 
ARCHITECTURE behavior OF tb_keyboard_ctrl IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyboard_ctrl
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         valid_code : IN  std_logic;
         scan_code_in : IN  unsigned(7 downto 0);
         code_to_display : OUT  unsigned(7 downto 0);
         seg_en : OUT  unsigned(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal valid_code : std_logic := '0';
   signal scan_code_in : unsigned(7 downto 0) := (others => '0');

 	--Outputs
   signal code_to_display : unsigned(7 downto 0);
   signal seg_en : unsigned(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard_ctrl PORT MAP (
          clk => clk,
          rst => rst,
          valid_code => valid_code,
          scan_code_in => scan_code_in,
          code_to_display => code_to_display,
          seg_en => seg_en
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst <= '1';
      wait for 100 ns;	
      rst <= '0';
       
      wait for clk_period*10;
      -- insert stimulus here 
      valid_code <= '1'; scan_code_in <= X"16"; wait for clk_period;
      scan_code_in <= X"16"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"16"; wait for clk_period;
      scan_code_in <= X"26"; wait for clk_period;
      scan_code_in <= X"26"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"26"; wait for clk_period;
      scan_code_in <= X"22"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"22"; wait for clk_period;
      scan_code_in <= X"22"; wait for clk_period;
      scan_code_in <= X"22"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"22"; wait for clk_period;
      scan_code_in <= X"44"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"30"; wait for clk_period;
      scan_code_in <= X"36"; wait for clk_period;
      scan_code_in <= X"36"; wait for clk_period;
      scan_code_in <= X"F0"; wait for clk_period;
      scan_code_in <= X"36"; wait for clk_period;
      --scan_code_in <= X"F0"; wait for clk_period;
      
   end process;

END;
