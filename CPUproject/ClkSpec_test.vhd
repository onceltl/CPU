--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:04:41 11/28/2017
-- Design Name:   
-- Module Name:   D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/ClkSpec_test.vhd
-- Project Name:  CPUproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ClkSpec
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
 
ENTITY ClkSpec_test IS
END ClkSpec_test;
 
ARCHITECTURE behavior OF ClkSpec_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ClkSpec
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         clk_spec : OUT  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal clk_spec : std_logic;
   signal clk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant clk_spec_period : time := 10 ns;
   constant clk_out_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ClkSpec PORT MAP (
          rst => rst,
          clk => clk,
          clk_spec => clk_spec,
          clk_out => clk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   clk_spec_process :process
   begin
		clk_spec <= '0';
		wait for clk_spec_period/2;
		clk_spec <= '1';
		wait for clk_spec_period/2;
   end process;
 
   clk_out_process :process
   begin
		clk_out <= '0';
		wait for clk_out_period/2;
		clk_out <= '1';
		wait for clk_out_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '0';
      wait for 100 ns;	
		rst <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
