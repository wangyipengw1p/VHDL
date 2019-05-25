
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_keyboard_top IS
END tb_keyboard_top;
 
ARCHITECTURE behavior OF tb_keyboard_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyboard_top
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         kb_data : IN  std_logic;
         kb_clk : IN  std_logic;
         sc : OUT  std_logic_vector(7 downto 0);
         num : OUT  std_logic_vector(7 downto 0);
         seg_en : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal kb_data : std_logic := '0';
   signal kb_clk : std_logic := '0';

 	--Outputs
   signal sc : std_logic_vector(7 downto 0);
   signal num : std_logic_vector(7 downto 0);
   signal seg_en : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant kb_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard_top PORT MAP (
          clk => clk,
          rst => rst,
          kb_data => kb_data,
          kb_clk => kb_clk,
          sc => sc,
          num => num,
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
 
   kb_clk_process :process
   begin
		kb_clk <= '0';
		wait for kb_clk_period/2;
		kb_clk <= '1';
		wait for kb_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
