library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; -- needed?

package constantsIF is
	--memory signal
	constant ALU_RESULT: std_logic_vector(3 downto 0) := "0000";
	constant DM_READ: std_logic_vector(3 downto 0) := "0001";
	constant DM_WRITE: std_logic_vector(3 downto 0) := "0010";
	constant IM_READ: std_logic_vector(3 downto 0) := "0011";
	constant IM_WRITE: std_logic_vector(3 downto 0) := "0100";
	constant SERIAL_STATE_READ: std_logic_vector(3 downto 0) := "0101";
	constant SERIAL_DATA_READ: std_logic_vector(3 downto 0) := "0110";
	constant SERIAL_DATA_WRITE: std_logic_vector(3 downto 0) := "0111";
	constant VGA_WRITE: std_logic_vector(3 downto 0) := "1000";
	constant PS2_READ: std_logic_vector(3 downto 0) := "1001";
	--others
	constant NOPINSTURCT: std_logic_vector(15 downto 0) := "0000100000000000";
	
	
	-- zero bits
	constant ZERO16: std_logic_vector(15 downto 0) := "0000000000000000";

	--for branch
	constant BRANCH_NONE : std_logic_vector(1 downto 0) := "00"
	constant BRANCH_RXEQZ : std_logic_vector(1 downto 0) := "01"
	constant BRANCH_RXNEZ : std_logic_vector(1 downto 0) := "10"
	constant BRANCH_TEQZ : std_logic_vector(1 downto 0) := "11"
	
	-- for jump dest
	constant JUMP_BDEST : std_logic_vector(1 downto 0) := "01"
	constant JUMP_RA : std_logic_vector(1 downto 0) := "10"
	constant JUMP_REGX : std_logic_vector(1 downto 0) := "11"	

	-- for re_sp_or_ih
	constant RE_SP: std_logic := '1';
	constant RE_IH: std_logic := '0';
	
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
	
	--MainController Signal:
	--aluop
	constant ALUOP_PLUS: std_logic_vector(2 downto 0) := "000";
	constant ALUOP_AND: std_logic_vector(2 downto 0) := "001";
	constant ALUOP_SUB: std_logic_vector(2 downto 0) := "010";
	constant ALUOP_OR: std_logic_vector(2 downto 0) := "011";
	constant ALUOP_SLL: std_logic_vector(2 downto 0) := "100";
	constant ALUOP_SRA: std_logic_vector(2 downto 0) := "101";
	--alu src a & b
	constant ALUSRC_REGA: std_logic_vector(2 downto 0) := "000":
	constant ALUSRC_SPREG: std_logic_vector(2 downto 0) := "001";
	constant ALUSRC_ZERO: std_logic_vector(2 downto 0) := "010";
	constant ALUSRC_SHIFT: std_logic_vector(2 downto 0) := "011";
	constant ALUSRC_IMM: std_logic_vector(2 downto 0) := "100";
	constant ALUSRC_REGB: std_logic_vector(2 downto 0) := "101";
	constant ALUSRC_PC: std_logic_vector(2 downto 0) := "110";
	--t op
	constant TOP_NEQ: std_logic := '0';
	constant TOP_NEG: std_logic := '1';
	--data src
	constant DSRC_SRCA: std_logic := '0';
	constant DSRC_SRCB: std_logic := '1';
	
	

end package ; -- constantsIF 