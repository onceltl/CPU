library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity TopLevel is
    port (
		clk_origin : in std_logic;
		rst : in std_logic;
		
		ram2_en: out std_logic;
		ram2_oe: out std_logic;
		ram2_we: out std_logic;
		ram2_addr: out std_logic_vector(17 downto 0);
		ram2_data: inout std_logic_vector(15 downto 0)
	);
end TopLevel;

architecture Behavioral of TopLevel is

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
	signal clk: std_logic;
	signal wr_pc: std_logic;
	
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
	signal jmp: std_logic;
	signal b_op : std_logic_vector(1 downto 0);
	signal j_dest : std_logic_vector(1 downto 0);
	signal t : std_logic;
	signal id_pc: std_logic_vector(15 downto 0);
	signal b_dest : std_logic_vector (15 downto 0);
	signal reg_a : std_logic_vector (15 downto 0);
	signal ra : std_logic_vector (15 downto 0);
	
	component PCIncreasor
		port (
			pc_in: in std_logic_vector(15 downto 0);
			pc_out: out std_logic_vector(15 downto 0)
		);
	end component;
	signal pc_plus: std_logic_vector(15 downto 0);
	
	component PCSrcMux
		port(
			jump : in std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			jump_dest : in std_logic_vector (15 downto 0);
			pc_out : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component IMController
		port(
			input_pc, input_alu: in std_logic_vector(15 downto 0);	
			write_data: in std_logic_vector(15 downto 0);
			mem_signal: in std_logic_vector(3 downto 0);
			read_result: out std_logic_vector(15 downto 0);
			ram2_oe, ram2_we, ram2_en: out std_logic;
			ram2_addr: out std_logic_vector(17 downto 0);
			ram2_data: inout std_logic_vector(15 downto 0)
		);
	end component;
	signal ex_mem_result: std_logic_vector(15 downto 0);
	signal mem_signal: std_logic_vector(3 downto 0);
	signal ex_mem_data: std_logic_vector(15 downto 0);
	signal im_data: std_logic_vector(15 downto 0);
	
	component IFIDRegister
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr : in std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			inst_in : in std_logic_vector (15 downto 0);
			pc_out : out std_logic_vector (15 downto 0);
			inst_out : out std_logic_vector (15 downto 0)
		);
	end component;
	signal wr_ifid: std_logic;
	signal inst: std_logic_vector(15 downto 0);
	
	component MainController
		port (
			inst: in std_logic_vector(15 downto 0);
	 		wr_ra: out std_logic; --是否写ra
			re_sp_ih: out std_logic; --选sp还是ih
			immd: out std_logic_vector(15 downto 0); --扩展后的立即数立即数
			b_dest: out std_logic_vector(15 downto 0); --符号扩展后的分支地址
			jmp_dest: out std_logic_vector(1 downto 0); --跳转地址的控制信号
			jmp: out std_logic; --跳转控制信号
			b_op: out std_logic_vector(1 downto 0);   --branch控制指令
			alu_op: out std_logic_vector(2 downto 0); --alu operator
			alu_srca: out std_logic_vector(1 downto 0); --alu sourceA
			alu_srcb: out std_logic_vector(1 downto 0); --alu sourceB
			t_op: out std_logic; --t register operator (not equal or < 0)
			datasrc: out std_logic; -- 写进内存的地址是从srca来还是b来
			rd: out std_logic_vector(2 downto 0); --目的寄存器地址
			write_reg: out std_logic; --是否写寄存器
			write_mem: out std_logic; --是否写内存
			mem_to_reg: out std_logic; --写回寄存器的是访存结果还是前一步结果
			write_sp: out std_logic; --是否写sp
			write_ih: out std_logic; --是否写ih
			write_t: out std_logic; --是否写t寄存器
			shift_imm: out std_logic_vector(15 downto 0) --移位立即数
		);
	end component;
	signal wr_ra: std_logic;
	signal id_re_sp_ih: std_logic;
	signal id_imm: std_logic_vector(15 downto 0);
	signal id_alu_op: std_logic_vector(2 downto 0);
	signal id_alu_srca: std_logic_vector(1 downto 0);
	signal id_alu_srcb: std_logic_vector(1 downto 0);
	signal id_t_op: std_logic;	
	signal id_data_src: std_logic;
	signal id_rd: std_logic_vector(2 downto 0);
	signal id_wr_reg: std_logic;
	signal id_wr_mem: std_logic;
	signal id_mem_to_reg: std_logic;
	signal id_wr_sp: std_logic;
	signal id_wr_ih: std_logic;
	signal id_wr_t: std_logic;
	signal re_idx_a: std_logic_vector(2 downto 0);
	signal re_idx_b: std_logic_vector(2 downto 0);
	signal id_shift: std_logic_vector(15 downto 0);

begin
	u7: MainController port map(
		inst => inst,	wr_ra => wr_ra,		
	);
	u1: PC port map(
		clk => clk,		rst => rst,		wr => wr_pc,
		pc_in => next_pc,	pc_out => now_pc
	);
	u2: JumpController port map(
		jmp => jmp,		b_op => b_op,	j_dest => j_dest,
		t => t,			pc_in => id_pc,
		b_dest => b_dest,	reg_a => reg_a,
		ra => ra,		jump => jump,	j_dest_out => jump_dest
	);
	u3: PCIncreasor port map(
		pc_in => now_pc,	pc_out => pc_plus
	);
	u4: PCSrcMux port map(
		jump => jump,		pc_in => pc_plus,
		jump_dest => jump_dest,	pc_out => next_pc
	);
	u5: IMController port map(
		input_pc => now_pc,	input_alu => ex_mem_result,	write_data => ex_mem_data,
		mem_signal => mem_signal,	read_result => im_data,
		ram2_oe => ram2_oe,	ram2_we => ram2_we,	ram2_en => ram2_en,
		ram2_addr => ram2_addr,	ram2_data => ram2_data
	);
	u6: IFIDRegister port map(
		clk => clk,	rst => rst,	wr => wr_ifid,
		pc_in => pc_plus,	inst_in => im_data,
		pc_out => id_pc,	inst_out => inst
	);

end Behavioral;

