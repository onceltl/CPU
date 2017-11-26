library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity Test_PC_Jump is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           wr_pc : in  STD_LOGIC;
           if_id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
           jmp : in  STD_LOGIC;
           b_op : in  STD_LOGIC_VECTOR (1 downto 0);
           j_dest : in  STD_LOGIC_VECTOR (1 downto 0);
           b_dest : in  STD_LOGIC_VECTOR (15 downto 0);
           reg_a : in  STD_LOGIC_VECTOR (15 downto 0);
           ra : in  STD_LOGIC_VECTOR (15 downto 0);
           t : in  STD_LOGIC;

           j_dest : out  STD_LOGIC_VECTOR (15 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (15 downto 0));
end Test_PC_Jump;

architecture Behavioral of Test_PC_Jump is
	component PC
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr : in std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			pc_out : out std_logic_vector (15 downto 0)
		);
	end component;
	signal next_pc: std_logic_vector(15 downto 0);
	signal now_pc: std_logic_vector(15 downto 0);
	component JumpController
		port(
			jmp : in std_logic;
			b_op : in std_logic_vector(1 downto 0);
			j_dest : in std_logic_vector(1 downto 0);
			t : std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			b_dest : in std_logic_vector (15 downto 0);
			reg_a : in std_logic_vector (15 downto 0);
			ra : in std_logic_vector (15 downto 0);
			jump: out std_logic;
			j_dest_out : out std_logic_vector (15 downto 0)
		);
	end component;
	signal jump: std_logic;
	signal jump_dest: std_logic_vector(15 downto 0);
	component PCIncreasor
		port (
			pc_in: in std_logic_vector(15 downto 0);
			pc_out: out std_logic_vector(15 downto 0)
		);
	end component;
	signal pc_plusplus: std_logic_vector(15 downto 0);
	component PCSrcMux
		port(
			jump : in std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			jump_dest : in std_logic_vector (15 downto 0);
			pc_out : out std_logic_vector (15 downto 0)
		);
	end component;
begin
	u1: PC port map(
		clk => clk,		rst => rst,		wr => wr_pc,
		pc_in => next_pc,	pc_out => now_pc
	);
	u2: JumpController port map(
		jmp => jmp,		b_op => b_op,	j_dest => j_dest,
		t => t,			pc_in => if_id_pc,
		b_dest => b_dest,	reg_a => reg_a,
		ra => ra,		jump => jump,	j_dest_out => jump_dest
	);
	u3: PCIncreasor port map(
		pc_in => now_pc,	pc_out => pc_plusplus;
	);
	u4: PCSrcMux port map(
		jump => jump,		pc_in => pc_plusplus,
		jump_dest => jump_dest,	pc_out => next_pc
	);
	
	j_dest <= jump_dest;
	pc_out <= now_pc;

end Behavioral;

