--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:15:47 11/26/2017
-- Design Name:   
-- Module Name:   D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/Registers_test.vhd
-- Project Name:  CPUproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Registers
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
 
ENTITY Registers_test IS
END Registers_test;
 
ARCHITECTURE behavior OF Registers_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Registers
    PORT(
         clk : IN  std_logic;
         wr_reg : IN  std_logic;
         wr_t : IN  std_logic;
         wr_sp : IN  std_logic;
         wr_ih : IN  std_logic;
         wr_ra : IN  std_logic;
         re_idx_a : IN  std_logic_vector(2 downto 0);
         re_idx_b : IN  std_logic_vector(2 downto 0);
         re_sp_or_ih : IN  std_logic;
         wr_idx : IN  std_logic_vector(2 downto 0);
         t_result : IN  std_logic;
         wr_data : IN  std_logic_vector(15 downto 0);
         pc : IN  std_logic_vector(15 downto 0);
         alu_result_ex : IN  std_logic_vector(15 downto 0);
         alu_result_mem : IN  std_logic_vector(15 downto 0);
         mem_result : IN  std_logic_vector(15 downto 0);
         reg_a_src : IN  std_logic_vector(1 downto 0);
         reg_b_src : IN  std_logic_vector(1 downto 0);
         sp_reg_src : IN  std_logic_vector(1 downto 0);
         reg_a_out : OUT  std_logic_vector(15 downto 0);
         reg_b_out : OUT  std_logic_vector(15 downto 0);
         t_out : OUT  std_logic;
         sp_reg_out : OUT  std_logic_vector(15 downto 0);
         ra_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wr_reg : std_logic := '0';
   signal wr_t : std_logic := '0';
   signal wr_sp : std_logic := '0';
   signal wr_ih : std_logic := '0';
   signal wr_ra : std_logic := '0';
   signal re_idx_a : std_logic_vector(2 downto 0) := (others => '0');
   signal re_idx_b : std_logic_vector(2 downto 0) := (others => '0');
   signal re_sp_or_ih : std_logic := '0';
   signal wr_idx : std_logic_vector(2 downto 0) := (others => '0');
   signal t_result : std_logic := '0';
   signal wr_data : std_logic_vector(15 downto 0) := (others => '0');
   signal pc : std_logic_vector(15 downto 0) := (others => '0');
   signal alu_result_ex : std_logic_vector(15 downto 0) := (others => '0');
   signal alu_result_mem : std_logic_vector(15 downto 0) := (others => '0');
   signal mem_result : std_logic_vector(15 downto 0) := (others => '0');
   signal reg_a_src : std_logic_vector(1 downto 0) := (others => '0');
   signal reg_b_src : std_logic_vector(1 downto 0) := (others => '0');
   signal sp_reg_src : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal reg_a_out : std_logic_vector(15 downto 0);
   signal reg_b_out : std_logic_vector(15 downto 0);
   signal t_out : std_logic;
   signal sp_reg_out : std_logic_vector(15 downto 0);
   signal ra_out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Registers PORT MAP (
          clk => clk,
          wr_reg => wr_reg,
          wr_t => wr_t,
          wr_sp => wr_sp,
          wr_ih => wr_ih,
          wr_ra => wr_ra,
          re_idx_a => re_idx_a,
          re_idx_b => re_idx_b,
          re_sp_or_ih => re_sp_or_ih,
          wr_idx => wr_idx,
          t_result => t_result,
          wr_data => wr_data,
          pc => pc,
          alu_result_ex => alu_result_ex,
          alu_result_mem => alu_result_mem,
          mem_result => mem_result,
          reg_a_src => reg_a_src,
          reg_b_src => reg_b_src,
          sp_reg_src => sp_reg_src,
          reg_a_out => reg_a_out,
          reg_b_out => reg_b_out,
          t_out => t_out,
          sp_reg_out => sp_reg_out,
          ra_out => ra_out
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
      wait for 100 ns;	
		wr_ra <= '1';
		
		wait for 10 ns;
		wr_ra <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
