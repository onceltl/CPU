library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity IDEXRegister is
    port ( clk : in std_logic;
           rst : in std_logic;
           wr : in std_logic;
           flush : in std_logic;

           alu_op_in : in std_logic_vector (2 downto 0);
           alu_src_a_in : in std_logic_vector (1 downto 0);
           alu_src_b_in : in std_logic_vector (1 downto 0);
           t_op_in : in std_logic;
           data_src_in : in std_logic;
           wr_reg_in : in std_logic;
           wr_mem_in : in std_logic;
           mem_to_reg_in : in std_logic;
           wr_sp_in : in std_logic;
           wr_ih_in : in std_logic;
           wr_t_in : in std_logic;

           pc_in : in std_logic_vector (15 downto 0);
           reg_a_in : in std_logic_vector (15 downto 0);
           reg_b_in : in std_logic_vector (15 downto 0);
           sp_reg_in : in std_logic_vector (15 downto 0);
           imm_in : in std_logic_vector (15 downto 0);
           shift_in : in std_logic_vector (15 downto 0);
           rd_in : in std_logic_vector (2 downto 0);

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
           rd_out : out std_logic_vector (2 downto 0));

end IDEXRegister;

architecture Behavioral of IDEXRegister is
begin

	process(rst, clk)
	begin
		if(rst = '0')then
			alu_op_out <= ALUOP_PLUS;
			alu_src_a_out <= ALUSRCA_ZERO;
			alu_src_b_out <= ALUSRCB_ZERO;
			t_op_out <= TOP_NEQ;
			data_src_out <= DSRC_SRCA;
			wr_reg_out <= '0';
			wr_mem_out <= '0';
			mem_to_reg_out <= '0';
			wr_sp_out <= '0';
			wr_ih_out <= '0';
			wr_t_out <= '0';
			
			pc_out <= ZERO16;
			reg_a_out <= ZERO16;
			reg_b_out <= ZERO16;
			sp_reg_out <= ZERO16;
			shift_out <= ZERO16;
			imm_out <= ZERO16;
			rd_out <= ZERO3;
		elsif(rising_edge(clk))then
			if(wr = '1')then
				alu_op_out <= alu_op_in;
				alu_src_a_out <= alu_src_a_in;
				alu_src_b_out <= alu_src_b_in;
				t_op_out <= t_op_in;
				data_src_out <= data_src_in;
				wr_reg_out <= wr_reg_in;
				wr_mem_out <= wr_mem_in;
				mem_to_reg_out <= mem_to_reg_in;
				wr_sp_out <= wr_sp_in;
				wr_ih_out <= wr_ih_in;
				wr_t_out <= wr_t_in;
				
				pc_out <= pc_in;
				reg_a_out <= reg_a_in;
				reg_b_out <= reg_b_in;
				sp_reg_out <= sp_reg_in;
				shift_out <= shift_in;
				imm_out <= imm_in;
				rd_out <= rd_in;
			end if;
			if(flush = '1')then
				alu_op_out <= ALUOP_PLUS;
				alu_src_a_out <= ALUSRCA_ZERO;
				alu_src_b_out <= ALUSRCB_ZERO;
				t_op_out <= TOP_NEQ;
				data_src_out <= DSRC_SRCA;
				wr_reg_out <= '0';
				wr_mem_out <= '0';
				mem_to_reg_out <= '0';
				wr_sp_out <= '0';
				wr_ih_out <= '0';
				wr_t_out <= '0';
				
				pc_out <= ZERO16;
				reg_a_out <= ZERO16;
				reg_b_out <= ZERO16;
				sp_reg_out <= ZERO16;
				shift_out <= ZERO16;
				imm_out <= ZERO16;
				rd_out <= ZERO3;
			end if;
		end if;
	end process;

end Behavioral;

