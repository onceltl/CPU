library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity TopLevel is
    port (
		clk_origin : in std_logic;
		rst : in std_logic;
		en : in std_logic;
		
		ram2_en, ram2_oe, ram2_we: out std_logic;
		ram2_addr: out std_logic_vector(17 downto 0);
		ram2_data: inout std_logic_vector(15 downto 0);
		
		ram1_oe, ram1_we, ram1_en: out std_logic;
		ram1_addr: out std_logic_vector(17 downto 0);
		ram1_data: inout std_logic_vector(15 downto 0);

		serial_tbre,	serial_tsre, 	serial_data_ready: 	in std_logic;
		serial_rdn, 	serial_wrn: 						out std_logic;
		vga_tbre, 		vga_tsre, 		ps2_data_ready: 	in std_logic;
		ps2_read_data: 										in std_logic_vector(7 downto 0);
		vga_write_data:										out std_logic_vector(7 downto 0);
		vga_write_enable, 				ps2_read_enable: 	out std_logic
		
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
			jmp_dest: out std_logic_vector(1 downto 0); --跳转地址的控制信�
			jmp: out std_logic; --跳转控制信号
			b_op: out std_logic_vector(1 downto 0);   --branch控制指令
			alu_op: out std_logic_vector(2 downto 0); --alu operator
			alu_srca: out std_logic_vector(1 downto 0); --alu sourceA
			alu_srcb: out std_logic_vector(1 downto 0); --alu sourceB
			t_op: out std_logic; --t register operator (not equal or < 0)
			datasrc: out std_logic; -- 写进内存的地址是从srca来还是b�
			rd: out std_logic_vector(2 downto 0); --目的寄存器地址
			write_reg: out std_logic; --是否写寄存器
			write_mem: out std_logic; --是否写内�
			mem_to_reg: out std_logic; --写回寄存器的是访存结果还是前一步结�
			write_sp: out std_logic; --是否写sp
			write_ih: out std_logic; --是否写ih
			write_t: out std_logic; --是否写t寄存�
			shift_imm: out std_logic_vector(15 downto 0); --移位立即�
			reidx_a: out std_logic_vector(2 downto 0); --rx地址
			reidx_b: out std_logic_vector(2 downto 0)  --ry地址
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
	
	component Registers
		port(
			clk : in std_logic;
			wr_reg : in std_logic;
			wr_t : in std_logic;	-- from ID/EX Register
			wr_sp : in std_logic;
			wr_ih : in std_logic;
			wr_ra : in std_logic;
			re_idx_a : in std_logic_vector(2 downto 0);
			re_idx_b : in std_logic_vector(2 downto 0);
			re_sp_or_ih : in std_logic;
			wr_idx : in std_logic_vector(2 downto 0);
		    t_result : in std_logic;
			wr_data : in std_logic_vector(15 downto 0);
			pc : in std_logic_vector(15 downto 0);
			alu_result_ex : in std_logic_vector(15 downto 0);
			alu_result_mem : in std_logic_vector(15 downto 0);
			mem_result : in std_logic_vector(15 downto 0);
			reg_a_src : in std_logic_vector(1 downto 0);
			reg_b_src : in std_logic_vector(1 downto 0);
			sp_reg_src : in std_logic_vector(1 downto 0);
			reg_a_out : out std_logic_vector (15 downto 0);
			reg_b_out : out std_logic_vector (15 downto 0);
			t_out : out std_logic;
			sp_reg_out : out std_logic_vector (15 downto 0);
			ra_out : out std_logic_vector (15 downto 0)
		);
	end component;
	signal wb_wr_reg: std_logic;
	signal wb_wr_sp: std_logic;
	signal wb_wr_ih: std_logic;
	signal wb_wr_idx: std_logic_vector(2 downto 0);
	signal wb_wr_data: std_logic_vector(15 downto 0);
	signal t_result: std_logic;
	signal alu_result_ex: std_logic_vector(15 downto 0);
	signal alu_result_mem: std_logic_vector(15 downto 0);
	signal mem_result: std_logic_vector(15 downto 0);
	signal ex_wr_t: std_logic;
	signal reg_a_src: std_logic_vector(1 downto 0);
	signal reg_b_src: std_logic_vector(1 downto 0);
	signal sp_reg_src: std_logic_vector(1 downto 0);
	signal id_sp_reg: std_logic_vector(15 downto 0);
	signal id_reg_a: std_logic_vector(15 downto 0);
	signal id_reg_b: std_logic_vector(15 downto 0);
	
	component IDEXRegister
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr : in std_logic;
			flush : in std_logic;
			alu_op_in : in std_logic_vector (2 downto 0);		-- 26
			alu_src_a_in : in std_logic_vector (1 downto 0);	-- 27
			alu_src_b_in : in std_logic_vector (1 downto 0);	-- 28
			t_op_in : in std_logic;								-- 29
			data_src_in : in std_logic;							-- 30
			wr_reg_in : in std_logic;							-- 32
			wr_mem_in : in std_logic;							-- 33
			mem_to_reg_in : in std_logic;						-- 34
			wr_sp_in : in std_logic;							-- 35
			wr_ih_in : in std_logic;							-- 36
			wr_t_in : in std_logic;								-- 37
			pc_in : in std_logic_vector (15 downto 0);			-- 16
			reg_a_in : in std_logic_vector (15 downto 0);		-- 55
			reg_b_in : in std_logic_vector (15 downto 0);		-- 56
			sp_reg_in : in std_logic_vector (15 downto 0);		-- 54
			imm_in : in std_logic_vector (15 downto 0);			-- 25
			shift_in : in std_logic_vector (15 downto 0);		-- 40
			rd_in : in std_logic_vector (2 downto 0);			-- 31
			alu_op_out : out std_logic_vector (2 downto 0);
			alu_src_a_out : out std_logic_vector (1 downto 0);
			alu_src_b_out : out std_logic_vector (1 downto 0);
			t_op_out : out std_logic;
			data_src_out : out std_logic;
			wr_reg_out : out std_logic;
			wr_mem_out : out std_logic;
			mem_to_reg_out : out std_logic;
			wr_sp_out : out std_logic;
			wr_ih_out : out std_logic;
			wr_t_out : out std_logic;
			pc_out : out std_logic_vector (15 downto 0);
			reg_a_out : out std_logic_vector (15 downto 0);
			reg_b_out : out std_logic_vector (15 downto 0);
			sp_reg_out : out std_logic_vector (15 downto 0);
			imm_out : out std_logic_vector (15 downto 0);
			shift_out : out std_logic_vector (15 downto 0);
			rd_out : out std_logic_vector (2 downto 0)
		);
	end component;
	signal wr_idex: std_logic;		-- 60
	signal flush_idex: std_logic;	-- 61
	signal ex_alu_op : std_logic_vector (2 downto 0);		--62
	signal ex_alu_src_a : std_logic_vector (1 downto 0);	--63
	signal ex_alu_src_b : std_logic_vector (1 downto 0);	--64
	signal ex_t_op : std_logic;			--65
	signal ex_data_src : std_logic;		--66
	signal ex_wr_reg : std_logic;		--67
	signal ex_wr_mem : std_logic;		--68
	signal ex_mem_to_reg : std_logic;	--69
	signal ex_wr_sp : std_logic;		--70
	signal ex_wr_ih : std_logic;		--71
	signal ex_pc : std_logic_vector (15 downto 0);		--72
	signal ex_reg_a : std_logic_vector (15 downto 0);	--73
	signal ex_reg_b : std_logic_vector (15 downto 0);	--74
	signal ex_sp_reg : std_logic_vector (15 downto 0);	--75
	signal ex_imm : std_logic_vector (15 downto 0);		--76
	signal ex_shift : std_logic_vector (15 downto 0);	--77
	signal ex_rd : std_logic_vector (2 downto 0);		--78
	
	component ALUSrcAMux
		port(
			alu_src_a : in std_logic_vector(1 downto 0);
			reg_a : in std_logic_vector (15 downto 0);
			sp_reg : in std_logic_vector (15 downto 0);
			shift : in std_logic_vector (15 downto 0);
			src_a : out std_logic_vector (15 downto 0)
		);
	end component;
	signal src_a: std_logic_vector(15 downto 0);

	component ALUSrcBMux
		port(
			alu_src_b : in std_logic_vector(1 downto 0);
			reg_b : in std_logic_vector (15 downto 0);
			imm : in std_logic_vector (15 downto 0);
			pc : in std_logic_vector (15 downto 0);
			src_b : out std_logic_vector (15 downto 0)
		);
	end component;
	signal src_b: std_logic_vector(15 downto 0);
	
	component ALU
		port(
			op : in std_logic_vector(2 downto 0);
			src_a : in std_logic_vector (15 downto 0);
			src_b : in std_logic_vector (15 downto 0);
			result : out std_logic_vector (15 downto 0);
			zero : out std_logic
		);
	end component;
	signal alu_zero: std_logic;
	
	component GetT
		port(
			op : in std_logic;
			alu_signed : in std_logic;
			alu_zero : in std_logic;
			t : out std_logic
		);
	end component;
	
	component MemSignalController
		port(
			mem_wr : in std_logic;
			mem_to_reg : in std_logic;
			alu_result : in std_logic_vector (15 downto 0);
			result_out : out std_logic_vector (15 downto 0);
			mem_signal : out std_logic_vector (3 downto 0)
		);
	end component;
	signal ex_mem_signal: std_logic_vector(3 downto 0);
	signal ex_result: std_logic_vector(15 downto 0);
	
	component DataToWrMux
		port(
			data_src : in std_logic;
			src_a : in std_logic_vector (15 downto 0);
			src_b : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0)
		);
	end component;
	signal ex_wr_data: std_logic_vector(15 downto 0);
	
	component EXMEMRegister
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr : in std_logic;
			wr_reg_in : in std_logic;
			wr_sp_in : in std_logic;
			wr_ih_in : in std_logic;
			mem_to_reg_in : in std_logic;
			mem_signal_in : in std_logic_vector (3 downto 0);	--83
			result_in : in std_logic_vector (15 downto 0);		--84
			data_in : in std_logic_vector (15 downto 0);		--85
			rd_in : in std_logic_vector (2 downto 0);
			wr_reg_out : out std_logic;		--86
			wr_sp_out : out std_logic;		--87
			wr_ih_out : out std_logic;		--88
			mem_to_reg_out : out std_logic;	--89
			mem_signal_out : out std_logic_vector (3 downto 0);	--90
			result_out : out std_logic_vector (15 downto 0);	--48
			data_out : out std_logic_vector (15 downto 0);		--91
			rd_out : out std_logic_vector (2 downto 0)			--92
		);
	end component;
	signal wr_exmem: std_logic;
	signal mem_wr_reg: std_logic;
	signal mem_wr_sp: std_logic;
	signal mem_wr_ih: std_logic;
	signal mem_mem_to_reg: std_logic;
	signal mem_mem_signal: std_logic_vector(3 downto 0);
	signal mem_wr_data: std_logic_vector(15 downto 0);
	signal mem_rd: std_logic_vector(2 downto 0);
	
	component DMController
		port(
			clk: in std_logic;
			read_write_addr: in std_logic_vector(15 downto 0);
			write_data: in std_logic_vector(15 downto 0);
			mem_signal: in std_logic_vector(3 downto 0); 
			read_result: out std_logic_vector(15 downto 0);
			serial_tbre, serial_tsre, serial_data_ready: in std_logic;
			serial_rdn, serial_wrn: out std_logic;
			ram1_oe, ram1_we, ram1_en: out std_logic;
			ram1_addr: out std_logic_vector(17 downto 0);
			ram1_data: inout std_logic_vector(15 downto 0);
			vga_write_enable: out std_logic;
			vga_write_data: out std_logic_vector(7 downto 0); --connect to vga's write_char signal
			vga_tbre, vga_tsre: in std_logic;
			--vga_rdn, vga_wrn: out std_logic;
			ps2_read_enable: out std_logic;
			ps2_read_data: in std_logic_vector(7 downto 0);
			ps2_data_ready: in std_logic
		);
	end component;
	signal dm_data: std_logic_vector(15 downto 0);
	
	component RAMSrcMux
		port(
			mem_signal_in : in std_logic_vector (3 downto 0);
			dm_data_in : in std_logic_vector (15 downto 0);
			im_data_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component MEMWBRegister
		port(
			clk : in std_logic;
			rst : in std_logic;
			wr : in std_logic;
			wr_reg_in : in std_logic;
			wr_sp_in : in std_logic;
			wr_ih_in : in std_logic;
			mem_to_reg_in : in std_logic;
			result_in : in std_logic_vector (15 downto 0);
			data_in : in std_logic_vector (15 downto 0);
			rd_in : in std_logic_vector (2 downto 0);
			wr_reg_out : out std_logic;
			wr_sp_out : out std_logic;
			wr_ih_out : out std_logic;
			mem_to_reg_out : out std_logic;
			result_out : out std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0);
			rd_out : out std_logic_vector (2 downto 0)
		);
	end component;
	signal wr_memwb: std_logic;
	signal wb_mem_to_reg: std_logic;
	signal wb_result: std_logic_vector(15 downto 0);
	signal wb_data: std_logic_vector(15 downto 0);
	
	component MemToRegMux
		port(
			mem_to_reg : in std_logic;
			data : in std_logic_vector (15 downto 0);
			result : in std_logic_vector (15 downto 0);
			data_wr : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component ForwardUnit
		port(
			wr_reg_ex : in std_logic;
			wr_reg_mem : in std_logic;
			wr_ih_ex : in std_logic;
			wr_sp_ex : in std_logic;
			wr_ih_mem : in std_logic;
			wr_sp_mem : in std_logic;
			re_sp_or_ih : in std_logic;
			mem_to_reg : in std_logic;
			rd_ex : in std_logic_vector (2 downto 0);
			rd_mem : in std_logic_vector (2 downto 0);
			re_idx_a : in std_logic_vector (2 downto 0);
			re_idx_b : in std_logic_vector (2 downto 0);
			reg_a_src : out std_logic_vector(1 downto 0);
			reg_b_src : out std_logic_vector(1 downto 0);
			sp_reg_src : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component HazardDetectiveUnit
		port(
			en : in std_logic;
			wr_reg : in std_logic;
			mem_to_reg_ex : in std_logic;
			mem_signal_mem : in std_logic_vector(3 downto 0);
			rd : in std_logic_vector (2 downto 0);
			re_idx_a : in std_logic_vector (2 downto 0);
			re_idx_b : in std_logic_vector (2 downto 0);
			wr_pc : out std_logic;
			wr_ifid : out std_logic;
			wr_idex : out std_logic;
			wr_exmem : out std_logic;
			wr_memwb : out std_logic;
			flush_idex : out std_logic
		);
	end component;
	
-- begin here
	
begin
	clk <= clk_origin;
	
	u1: PC port map(
		clk => clk,		rst => rst,		wr => wr_pc,
		pc_in => next_pc,	pc_out => now_pc
	);
	u2: JumpController port map(
		jmp => jmp,		b_op => b_op,	j_dest => j_dest,
		t => t,			pc_in => id_pc,
		b_dest => b_dest,	reg_a => id_reg_a,
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
		input_pc => now_pc,	input_alu => alu_result_mem,	write_data => mem_wr_data,
		mem_signal => mem_mem_signal,	read_result => im_data,
		ram2_oe => ram2_oe,	ram2_we => ram2_we,	ram2_en => ram2_en,
		ram2_addr => ram2_addr,	ram2_data => ram2_data
	);
	u6: IFIDRegister port map(
		clk => clk,	rst => rst,	wr => wr_ifid,
		pc_in => pc_plus,	inst_in => im_data,
		pc_out => id_pc,	inst_out => inst
	);
	u7: MainController port map(
		inst => inst,	wr_ra => wr_ra,		re_sp_ih => id_re_sp_ih,
		immd => id_imm,	b_dest => b_dest,	jmp_dest => j_dest,
		jmp => jmp,		b_op => b_op,		alu_op => id_alu_op,
		alu_srca => id_alu_srca,			alu_srcb => id_alu_srcb,
		t_op => id_t_op,		datasrc => id_data_src,	rd => id_rd,
		write_reg => id_wr_reg,	write_mem => id_wr_mem, mem_to_reg => id_mem_to_reg,
		write_sp => id_wr_sp,	write_ih => id_wr_ih,	write_t => id_wr_t,
		shift_imm => id_shift,	reidx_a => re_idx_a,	reidx_b => re_idx_b
	);
	u8: Registers port map(
		clk => clk,		wr_reg => wb_wr_reg,	wr_t => ex_wr_t,
		wr_sp => wb_wr_sp,	wr_ih => wb_wr_ih,	wr_ra => wr_ra,
		re_idx_a => re_idx_a,	re_idx_b => re_idx_b,	re_sp_or_ih => id_re_sp_ih,
		wr_idx => wb_wr_idx,	wr_data => wb_wr_data,	t_result => t_result,
		pc => id_pc,	alu_result_ex => alu_result_ex,	alu_result_mem => alu_result_mem,
		mem_result => mem_result,	reg_a_src => reg_a_src,	reg_b_src => reg_b_src,
		sp_reg_src => sp_reg_src,	reg_a_out => id_reg_a,	reg_b_out => id_reg_b,
		t_out => t,		sp_reg_out => id_sp_reg,	ra_out => ra
	);
	u9: IDEXRegister port map(
		clk => clk,		rst => rst,		wr => wr_idex,
		flush => flush_idex,	alu_op_in => id_alu_op,
		alu_src_a_in => id_alu_srca,	alu_src_b_in => id_alu_srcb,
		t_op_in => id_t_op,		data_src_in => id_data_src,
		wr_reg_in => id_wr_reg,	wr_mem_in => id_wr_mem,	mem_to_reg_in => id_mem_to_reg,
		wr_sp_in => id_wr_sp,	wr_ih_in => id_wr_ih,	wr_t_in => id_wr_t,
		pc_in => id_pc,		reg_a_in => id_reg_a,	reg_b_in => id_reg_b,
		sp_reg_in => id_sp_reg,	imm_in => id_imm,	shift_in => id_shift,
		rd_in => id_rd,
		alu_op_out =>ex_alu_op,	alu_src_a_out => ex_alu_src_a,	alu_src_b_out => ex_alu_src_b,
		t_op_out => ex_t_op,	data_src_out => ex_data_src,	wr_reg_out => ex_wr_reg,
		wr_mem_out => ex_wr_mem,	mem_to_reg_out => ex_mem_to_reg,
		wr_sp_out => ex_wr_sp,	wr_ih_out => ex_wr_ih,	wr_t_out => ex_wr_t,
		pc_out => ex_pc,	reg_a_out => ex_reg_a,	reg_b_out => ex_reg_b,
		sp_reg_out => ex_sp_reg,	imm_out => ex_imm,	shift_out => ex_shift,	rd_out => ex_rd
	);
	u10: ALUSrcAMux port map(
		alu_src_a => ex_alu_src_a,	reg_a => ex_reg_a,
		sp_reg => ex_sp_reg,	shift => ex_shift,	src_a => src_a
	);
	u11: ALUSrcBMux port map(
		alu_src_b => ex_alu_src_b,	reg_b => ex_reg_b,
		imm => ex_imm,	pc => ex_pc,	src_b => src_b
	);
	u12: ALU port map(
		op => ex_alu_op,	src_a => src_a,	src_b => src_b,
		result => alu_result_ex,	zero => alu_zero
	);
	u13: GetT port map(
		op => ex_t_op,	alu_signed => alu_result_ex(15),
		alu_zero => alu_zero,	t => t_result
	);
	u14: MemSignalController port map(
		mem_wr => ex_wr_mem,	mem_to_reg => ex_mem_to_reg,	alu_result => alu_result_ex,
		result_out => ex_result,	mem_signal => ex_mem_signal
	);
	u15: DataToWrMux port map(
		data_src => ex_data_src,	src_a => ex_reg_a,	src_b => ex_reg_b,
		data_out => ex_wr_data
	);
	u16: EXMEMRegister port map(
		clk => clk,		rst => rst,		wr => wr_exmem,
		wr_reg_in => ex_wr_reg,	wr_sp_in => ex_wr_sp,	wr_ih_in => ex_wr_ih,
		mem_to_reg_in => ex_mem_to_reg,		mem_signal_in => ex_mem_signal,
		result_in => ex_result,		data_in => ex_wr_data,	rd_in => ex_rd,
		wr_reg_out => mem_wr_reg,	wr_sp_out => mem_wr_sp,	wr_ih_out => mem_wr_ih,
		mem_to_reg_out => mem_mem_to_reg,	mem_signal_out => mem_mem_signal,
		result_out => alu_result_mem,	data_out => mem_wr_data,	rd_out => mem_rd
	);
	u17: DMController port map(
		clk => clk,		read_write_addr => alu_result_mem,	write_data => mem_wr_data,
		mem_signal => mem_mem_signal,	read_result => dm_data,	serial_tbre => serial_tbre,
		serial_tsre => serial_tsre,	serial_data_ready => serial_data_ready,
		serial_rdn => serial_rdn,	serial_wrn => serial_wrn,
		ram1_oe => ram1_oe,		ram1_we => ram1_we,		ram1_en => ram1_en,
		ram1_addr => ram1_addr,		ram1_data => ram1_data,
		vga_write_enable => vga_write_enable,	vga_write_data => vga_write_data,
		vga_tbre => vga_tbre,	vga_tsre => vga_tsre,
		ps2_read_enable => ps2_read_enable,	ps2_read_data => ps2_read_data,	ps2_data_ready => ps2_data_ready
	);
	u18: RAMSrcMux port map(
		mem_signal_in => mem_mem_signal,	dm_data_in => dm_data,
		im_data_in => im_data,				data_out => mem_result
	);
	u19: MEMWBRegister port map(
		clk => clk,		rst => rst,		wr => wr_memwb,
		wr_reg_in => mem_wr_reg,	wr_sp_in => mem_wr_sp,	wr_ih_in => mem_wr_ih,
		mem_to_reg_in => mem_mem_to_reg,	result_in => alu_result_mem,
		data_in => mem_result,	rd_in => mem_rd,
		wr_reg_out => wb_wr_reg,	wr_sp_out => wb_wr_sp,	wr_ih_out => wb_wr_ih,
		mem_to_reg_out => wb_mem_to_reg,	result_out => wb_result,
		data_out => wb_data,	rd_out => wb_wr_idx
	);
	u20: MemToRegMux port map(
		mem_to_reg => wb_mem_to_reg,	data => wb_data,
		result => wb_result,			data_wr => wb_wr_data
	);
	u21: ForwardUnit port map(
		wr_reg_ex => ex_wr_reg,	wr_reg_mem => mem_wr_reg,	wr_ih_ex => ex_wr_ih,
		wr_sp_ex => ex_wr_sp,	wr_ih_mem => mem_wr_ih,		wr_sp_mem => mem_wr_sp,
		re_sp_or_ih => id_re_sp_ih,	mem_to_reg => mem_mem_to_reg,	rd_ex => ex_rd,
		rd_mem => mem_rd,	re_idx_a => re_idx_a,	re_idx_b => re_idx_b,
		reg_a_src => reg_a_src,	reg_b_src => reg_b_src,	sp_reg_src => sp_reg_src
	);
	u22: HazardDetectiveUnit port map(
		en => en,	wr_reg => ex_wr_reg,
		mem_to_reg_ex => ex_mem_to_reg,		mem_signal_mem => mem_mem_signal,
		rd => ex_rd,	re_idx_a => re_idx_a,	re_idx_b => re_idx_b,
		wr_pc => wr_pc,	wr_ifid => wr_ifid,	wr_idex => wr_idex,
		wr_exmem => wr_exmem,	wr_memwb => wr_memwb,	flush_idex => flush_idex
	);

end Behavioral;

