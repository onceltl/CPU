--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:08:08 11/24/2017
-- Design Name:   
-- Module Name:   G:/cd/vga_test/text_test.vhd
-- Project Name:  vga_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: text_generator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY text_test IS
END text_test;
 
ARCHITECTURE behavior OF text_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT text_generator
    PORT(
         clk_write : IN  std_logic;
         rst : IN  std_logic;
         display_enable : IN  std_logic;
         row : IN  INTEGER;
         column : IN  INTEGER;
         write_enable : IN  std_logic;
         write_char : IN  std_logic_vector(7 downto 0);
         red : OUT  std_logic_vector(2 downto 0);
         green : OUT  std_logic_vector(2 downto 0);
         blue : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_write : std_logic := '0';
   signal rst : std_logic := '0';
   signal display_enable : std_logic := '0';
   signal row : INTEGER;
   signal column : INTEGER;
   signal write_enable : std_logic := '0';
   signal write_char : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal red : std_logic_vector(2 downto 0);
   signal green : std_logic_vector(2 downto 0);
   signal blue : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_write_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: text_generator PORT MAP (
          clk_write => clk_write,
          rst => rst,
          display_enable => display_enable,
          row => row,
          column => column,
          write_enable => write_enable,
          write_char => write_char,
          red => red,
          green => green,
          blue => blue
        );

   -- Clock process definitions
   clk_write_process :process
   begin
		clk_write <= '0';
		wait for clk_write_period/2;
		clk_write <= '1';
		wait for clk_write_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '0';
      write_enable <= '0';
		row <= 0;
		column <= 0;
		display_enable <= '1';
		wait for 100 ns;	
		rst <= '1';
		row <= 174;
		column <= 0;
      wait for clk_write_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
