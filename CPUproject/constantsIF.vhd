library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; -- needed?

package constantsIF is

	--MainController Signal:
	
	--branch op
	constant BRANCH_NONE : std_logic_vector(1 downto 0) := "00";
	constant BRANCH_RXEQZ : std_logic_vector(1 downto 0) := "01";
	constant BRANCH_RXNEZ : std_logic_vector(1 downto 0) := "10";
	constant BRANCH_TEQZ : std_logic_vector(1 downto 0) := "11";
	-- jump dest
	constant JUMP_BDEST : std_logic_vector(1 downto 0) := "01";
	constant JUMP_RA : std_logic_vector(1 downto 0) := "10";
	constant JUMP_REGX : std_logic_vector(1 downto 0) := "11";
	-- re sp or ih
	constant RE_SP: std_logic := '1';
	constant RE_IH: std_logic := '0';
	--alu op
	constant ALUOP_PLUS: std_logic_vector(2 downto 0) := "000";
	constant ALUOP_AND: std_logic_vector(2 downto 0) := "001";
	constant ALUOP_SUB: std_logic_vector(2 downto 0) := "010";
	constant ALUOP_OR: std_logic_vector(2 downto 0) := "011";
	constant ALUOP_SLL: std_logic_vector(2 downto 0) := "100";
	constant ALUOP_SRA: std_logic_vector(2 downto 0) := "101";
	--alu src a
	constant ALUSRCA_ZERO: std_logic_vector(1 downto 0) := "00";
	constant ALUSRCA_REGA: std_logic_vector(1 downto 0) := "01";
	constant ALUSRCA_SPREG: std_logic_vector(1 downto 0) := "10";
	constant ALUSRCA_SHIFT: std_logic_vector(1 downto 0) := "11";
	--alu src b
	constant ALUSRCB_ZERO: std_logic_vector(1 downto 0) := "00";
	constant ALUSRCB_REGB: std_logic_vector(1 downto 0) := "01";
	constant ALUSRCB_IMM: std_logic_vector(1 downto 0) := "10";
	constant ALUSRCB_PC: std_logic_vector(1 downto 0) := "11";
	--t op
	constant TOP_NEQ: std_logic := '0';
	constant TOP_NEG: std_logic := '1';
	--data src
	constant DSRC_SRCA: std_logic := '0';
	constant DSRC_SRCB: std_logic := '1';
	
	--memory signal
	constant NONE: std_logic_vector(3 downto 0) := "0000";
	constant DM_READ: std_logic_vector(3 downto 0) := "0001";
	constant DM_WRITE: std_logic_vector(3 downto 0) := "0010";
	constant IM_READ: std_logic_vector(3 downto 0) := "0011";
	constant IM_WRITE: std_logic_vector(3 downto 0) := "0100";
	constant SERIAL_STATE_READ: std_logic_vector(3 downto 0) := "0101";
	constant SERIAL_DATA_READ: std_logic_vector(3 downto 0) := "0110";
	constant SERIAL_DATA_WRITE: std_logic_vector(3 downto 0) := "0111";
	constant VGA_WRITE: std_logic_vector(3 downto 0) := "1000";
	constant PS2_READ: std_logic_vector(3 downto 0) := "1001";
	constant VGA_PS2_STATE_READ: std_logic_vector(3 downto 0) := "1010";
	
	--read write enable signal
	constant READ_ENABLE: std_logic := '1';
	constant WRITE_ENABLE: std_logic := '1';
	constant READ_DISABLE: std_logic := '0';
	constant WRITE_DISABLE: std_logic := '0';

	--others
	constant NOP_INSTRUCT: std_logic_vector(15 downto 0) := "0000100000000000";
	constant ZERO16: std_logic_vector(15 downto 0) := 		"0000000000000000";
	constant ZERO14: std_logic_vector(13 downto 0) := 		"00000000000000";
	constant ZERO8: std_logic_vector(7 downto 0) := 		"00000000";
	constant ZERO3: std_logic_vector(2 downto 0) := 		"000";
	constant HIGHZ16: std_logic_vector(15 downto 0) := 		"ZZZZZZZZZZZZZZZZ";
	
	-- for side road
	constant FORWARD_OLD: std_logic_vector(1 downto 0) := "00";
	constant FORWARD_ALU_EX: std_logic_vector(1 downto 0) := "01";
	constant FORWARD_ALU_MEM: std_logic_vector(1 downto 0) := "10";
	constant FORWARD_MEM: std_logic_vector(1 downto 0) := "11";
	
	-- operator
	constant OP_ADDIU: std_logic_vector(4 downto 0) := "01001";
	constant OP_ADDIU3: std_logic_vector(4 downto 0) := "01000";
	constant OP_SPECIAL: std_logic_vector(4 downto 0) := "01100";
	constant OP_ADD_SUB_U: std_logic_vector(4 downto 0) := "11100";
	constant OP_LOGIC: std_logic_vector(4 downto 0) := "11101"; --OP_PC
	constant OP_B: std_logic_vector(4 downto 0) := "00010";
	constant OP_BEQZ: std_logic_vector(4 downto 0) := "00100";
	constant OP_BNEZ: std_logic_vector(4 downto 0) := "00101";
	constant OP_LI: std_logic_vector(4 downto 0) := "01101";
	constant OP_LW: std_logic_vector(4 downto 0) := "10011";
	constant OP_LW_SP: std_logic_vector(4 downto 0) := "10010";
	constant OP_IH: std_logic_vector(4 downto 0) := "11110";
	constant OP_NOP: std_logic_vector(4 downto 0) := "00001";
	constant OP_SHIFT: std_logic_vector(4 downto 0) := "00110";
	constant OP_SW: std_logic_vector(4 downto 0) := "11011";
	constant OP_SW_SP: std_logic_vector(4 downto 0) := "11010";
	constant OP_SLTUI: std_logic_vector(4 downto 0) := "01011";
	constant OP_MOVE: std_logic_vector(4 downto 0) := "01111";
	
	-- 11110 OP_IH inst(7 downto 0)
	constant IH_MFIH: std_logic_vector(7 downto 0) := "00000000";
	constant IH_MTIH: std_logic_vector(7 downto 0) := "00000001";
	
	-- 00110 OP_SHIFT inst(1 downto 0)
	constant SHIFT_SLL: std_logic_vector(1 downto 0) := "00";
	constant SHIFT_SRA: std_logic_vector(1 downto 0) := "11";
	
	-- 01100 OP_SPECIAL inst(10 downto 8)
	constant SPECIAL_ADDSP: std_logic_vector(2 downto 0) := "011";
	constant SPECIAL_BTEQZ: std_logic_vector(2 downto 0) := "000";
	constant SPECIAL_MTSP: std_logic_vector(2 downto 0) := "100";
	
	-- 11100 OP_ADD_SUB_U inst(1 downto 0)
	constant ADD_SUB_U_ADDU: std_logic_vector(1 downto 0) := "01";
	constant ADD_SUB_U_SUBU: std_logic_vector(1 downto 0) := "11";

	-- 11101 OP_LOGIC inst(4 downto 0) 
	constant LOGIC_AND: std_logic_vector(4 downto 0) := "01100";
	constant LOGIC_CMP: std_logic_vector(4 downto 0) := "01010";
	constant LOGIC_PC: std_logic_vector(4 downto 0) := "00000";
		--sub function code for pc inst(7 downto 5)
		constant PC_JR: std_logic_vector(2 downto 0) := "000"; 
		constant PC_MFPC: std_logic_vector(2 downto 0) := "010"; 
		constant PC_JRRA: std_logic_vector(2 downto 0) := "001";
		constant PC_JALR: std_logic_vector(2 downto 0) := "110";
		-- end sub --
	constant LOGIC_OR: std_logic_vector(4 downto 0) := "01101";
	constant LOGIC_NEG: std_logic_vector(4 downto 0) := "01011";


	

end package ; -- constantsIF 
