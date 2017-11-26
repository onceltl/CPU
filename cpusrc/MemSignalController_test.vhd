--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:34:37 11/26/2017
-- Design Name:   
-- Module Name:   D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/MemSignalController_test.vhd
-- Project Name:  CPUproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemSignalController
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
 
ENTITY MemSignalController_test IS
END MemSignalController_test;
 
ARCHITECTURE behavior OF MemSignalController_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemSignalController
    PORT(
         mem_wr : IN  std_logic;
         mem_to_reg : IN  std_logic;
         alu_result : IN  std_logic_vector(15 downto 0);
         result_out : OUT  std_logic_vector(15 downto 0);
         mem_signal : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal mem_wr : std_logic := '0';
   signal mem_to_reg : std_logic := '0';
   signal alu_result : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal result_out : std_logic_vector(15 downto 0);
   signal mem_signal : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemSignalController PORT MAP (
          mem_wr => mem_wr,
          mem_to_reg => mem_to_reg,
          alu_result => alu_result,
          result_out => result_out,
          mem_signal => mem_signal
        );

   -- Clock process definition
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	



      -- insert stimulus here 

      wait;
   end process;

END;
