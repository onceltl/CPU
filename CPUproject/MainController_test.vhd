--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:23:12 11/26/2017
-- Design Name:   
-- Module Name:   D:/XilinxWorkspace/CPUTest/MainController_test.vhd
-- Project Name:  CPUTest
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MainController
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
 
ENTITY MainController_test IS
END MainController_test;
 
ARCHITECTURE behavior OF MainController_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MainController
    PORT(
         inst : IN  std_logic_vector(15 downto 0);
         wr_ra : OUT  std_logic;
         re_sp_ih : OUT  std_logic;
         immd : OUT  std_logic_vector(15 downto 0);
         b_dest : OUT  std_logic_vector(15 downto 0);
         jmp_dest : OUT  std_logic_vector(1 downto 0);
         jmp : OUT  std_logic;
         b_op : OUT  std_logic_vector(1 downto 0);
         alu_op : OUT  std_logic_vector(2 downto 0);
         alu_srca : OUT  std_logic_vector(1 downto 0);
         alu_srcb : OUT  std_logic_vector(1 downto 0);
         t_op : OUT  std_logic;
         datasrc : OUT  std_logic;
         rd : OUT  std_logic_vector(2 downto 0);
         write_reg : OUT  std_logic;
         write_mem : OUT  std_logic;
         mem_to_reg : OUT  std_logic;
         write_sp : OUT  std_logic;
         write_ih : OUT  std_logic;
         write_t : OUT  std_logic;
         shift_imm : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inst : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal wr_ra : std_logic;
   signal re_sp_ih : std_logic;
   signal immd : std_logic_vector(15 downto 0);
   signal b_dest : std_logic_vector(15 downto 0);
   signal jmp_dest : std_logic_vector(1 downto 0);
   signal jmp : std_logic;
   signal b_op : std_logic_vector(1 downto 0);
   signal alu_op : std_logic_vector(2 downto 0);
   signal alu_srca : std_logic_vector(1 downto 0);
   signal alu_srcb : std_logic_vector(1 downto 0);
   signal t_op : std_logic;
   signal datasrc : std_logic;
   signal rd : std_logic_vector(2 downto 0);
   signal write_reg : std_logic;
   signal write_mem : std_logic;
   signal mem_to_reg : std_logic;
   signal write_sp : std_logic;
   signal write_ih : std_logic;
   signal write_t : std_logic;
   signal shift_imm : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MainController PORT MAP (
          inst => inst,
          wr_ra => wr_ra,
          re_sp_ih => re_sp_ih,
          immd => immd,
          b_dest => b_dest,
          jmp_dest => jmp_dest,
          jmp => jmp,
          b_op => b_op,
          alu_op => alu_op,
          alu_srca => alu_srca,
          alu_srcb => alu_srcb,
          t_op => t_op,
          datasrc => datasrc,
          rd => rd,
          write_reg => write_reg,
          write_mem => write_mem,
          mem_to_reg => mem_to_reg,
          write_sp => write_sp,
          write_ih => write_ih,
          write_t => write_t,
          shift_imm => shift_imm
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		inst <= "0000100000000000"; --NOP
		wait for 10 ns;
		inst <= "0100100110000001"; --ADDIU 
		wait for 10 ns;
		inst <= "0100000101001001"; --ADDIU3
		wait for 10 ns;
		inst <= "0110001110000001"; --ADDSP
		wait for 10 ns;
		inst <= "1110000101001101"; --ADDU
		wait for 10 ns;
		inst <= "1110100101001100"; --AND
		wait for 10 ns;
		inst <= "0001010000000001"; --B
		wait for 10 ns;
		inst <= "0010000110000001"; --BEQZ
		wait for 10 ns;
		inst <= "0010100110000001"; --BNEZ
		wait for 10 ns;
		inst <= "0110000010000001"; --BTEQZ
		wait for 10 ns;
		inst <= "1110100101001010"; --CMP
		wait for 10 ns;
		inst <= "1110100111000000"; --JALR
		wait for 10 ns;
		inst <= "1110100100000000"; --JR
		wait for 10 ns;
		inst <= "1110100000100000"; --JRRA
		wait for 10 ns;
		inst <= "0110100110000001"; --LI
		wait for 10 ns;
		inst <= "1001100101010001"; --LW
		wait for 10 ns;
		inst <= "1001000110000001"; --LW_SP
		wait for 10 ns;
		inst <= "1111000100000000"; --MFIH
		wait for 10 ns;
		inst <= "1110100101000000"; --MFPC
		wait for 10 ns;
		inst <= "0111100101000000"; --MOVE
		wait for 10 ns;
		inst <= "1111000100000001"; --MTIH
		wait for 10 ns;
		inst <= "0110010000100000"; --MTSP
		wait for 10 ns;
		inst <= "1110100101001011"; --NEG
		wait for 10 ns;
		inst <= "1110100101001101"; --OR
		wait for 10 ns;
		inst <= "0011000101010100"; --SLL
		wait for 10 ns;
		inst <= "0101100110000001"; --SLTUI
		wait for 10 ns;
		inst <= "0011000101010111"; --SRA
		wait for 10 ns;
		inst <= "1110000101001111"; --SUBU
		wait for 10 ns;
		inst <= "1101100101010001"; --SW
		wait for 10 ns;
		inst <= "1101000110000001"; --SW_SP
 

      -- insert stimulus here 

      wait;
   end process;

END;
