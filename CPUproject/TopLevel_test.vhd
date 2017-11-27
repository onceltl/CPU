--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:28:46 11/27/2017
-- Design Name:   
-- Module Name:   D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/TopLevel_test.vhd
-- Project Name:  CPUproject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopLevel
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
 
ENTITY TopLevel_test IS
END TopLevel_test;
 
ARCHITECTURE behavior OF TopLevel_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopLevel
    PORT(
         clk_origin : IN  std_logic;
         rst : IN  std_logic;
         en : IN  std_logic;
         pc_now_out : OUT  std_logic_vector(15 downto 0);
         inst_out : OUT  std_logic_vector(15 downto 0);
         reg_a_out : OUT  std_logic_vector(15 downto 0);
         reg_b_out : OUT  std_logic_vector(15 downto 0);
         alu_result_ex_out : OUT  std_logic_vector(15 downto 0);
         ex_mem_signal_out : OUT  std_logic_vector(3 downto 0);
         mem_result_out : OUT  std_logic_vector(15 downto 0);
         ram2_en_out : OUT  std_logic;
         ram2_oe_out : OUT  std_logic;
         ram2_we_out : OUT  std_logic;
         ram2_addr_out : OUT  std_logic_vector(17 downto 0);
         ram2_data_out : INOUT  std_logic_vector(15 downto 0);
         ram1_oe : OUT  std_logic;
         ram1_we : OUT  std_logic;
         ram1_en : OUT  std_logic;
         ram1_addr : OUT  std_logic_vector(17 downto 0);
         ram1_data : INOUT  std_logic_vector(15 downto 0);
         serial_tbre : IN  std_logic;
         serial_tsre : IN  std_logic;
         serial_data_ready : IN  std_logic;
         serial_rdn : OUT  std_logic;
         serial_wrn : OUT  std_logic;
         vga_tbre : IN  std_logic;
         vga_tsre : IN  std_logic;
         ps2_data_ready : IN  std_logic;
         ps2_read_data : IN  std_logic_vector(7 downto 0);
         vga_write_data : OUT  std_logic_vector(7 downto 0);
         vga_write_enable : OUT  std_logic;
         ps2_read_enable : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_origin : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';
   signal serial_tbre : std_logic := '0';
   signal serial_tsre : std_logic := '0';
   signal serial_data_ready : std_logic := '0';
   signal vga_tbre : std_logic := '0';
   signal vga_tsre : std_logic := '0';
   signal ps2_data_ready : std_logic := '0';
   signal ps2_read_data : std_logic_vector(7 downto 0) := (others => '0');

	--BiDirs
   signal ram2_data_out : std_logic_vector(15 downto 0);
   signal ram1_data : std_logic_vector(15 downto 0);

 	--Outputs
   signal pc_now_out : std_logic_vector(15 downto 0);
   signal inst_out : std_logic_vector(15 downto 0);
   signal reg_a_out : std_logic_vector(15 downto 0);
   signal reg_b_out : std_logic_vector(15 downto 0);
   signal alu_result_ex_out : std_logic_vector(15 downto 0);
   signal ex_mem_signal_out : std_logic_vector(3 downto 0);
   signal mem_result_out : std_logic_vector(15 downto 0);
   signal ram2_en_out : std_logic;
   signal ram2_oe_out : std_logic;
   signal ram2_we_out : std_logic;
   signal ram2_addr_out : std_logic_vector(17 downto 0);
   signal ram1_oe : std_logic;
   signal ram1_we : std_logic;
   signal ram1_en : std_logic;
   signal ram1_addr : std_logic_vector(17 downto 0);
   signal serial_rdn : std_logic;
   signal serial_wrn : std_logic;
   signal vga_write_data : std_logic_vector(7 downto 0);
   signal vga_write_enable : std_logic;
   signal ps2_read_enable : std_logic;

   -- Clock period definitions
   constant clk_origin_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopLevel PORT MAP (
          clk_origin => clk_origin,
          rst => rst,
          en => en,
          pc_now_out => pc_now_out,
          inst_out => inst_out,
          reg_a_out => reg_a_out,
          reg_b_out => reg_b_out,
          alu_result_ex_out => alu_result_ex_out,
          ex_mem_signal_out => ex_mem_signal_out,
          mem_result_out => mem_result_out,
          ram2_en_out => ram2_en_out,
          ram2_oe_out => ram2_oe_out,
          ram2_we_out => ram2_we_out,
          ram2_addr_out => ram2_addr_out,
          ram2_data_out => ram2_data_out,
          ram1_oe => ram1_oe,
          ram1_we => ram1_we,
          ram1_en => ram1_en,
          ram1_addr => ram1_addr,
          ram1_data => ram1_data,
          serial_tbre => serial_tbre,
          serial_tsre => serial_tsre,
          serial_data_ready => serial_data_ready,
          serial_rdn => serial_rdn,
          serial_wrn => serial_wrn,
          vga_tbre => vga_tbre,
          vga_tsre => vga_tsre,
          ps2_data_ready => ps2_data_ready,
          ps2_read_data => ps2_read_data,
          vga_write_data => vga_write_data,
          vga_write_enable => vga_write_enable,
          ps2_read_enable => ps2_read_enable
        );

   -- Clock process definitions
   clk_origin_process :process
   begin
		clk_origin <= '0';
		wait for clk_origin_period/2;
		clk_origin <= '1';
		wait for clk_origin_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '0';
      wait for 100 ns;	
		rst <= '1';
		en <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
