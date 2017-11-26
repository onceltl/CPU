library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MainController is
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
end entity;


architecture arch of MainController is
begin
	process(inst)
	variable inst_temp: std_logic_vector(4 downto 0);
	variable reg1_addr_v, reg2_addr_v, reg3_addr_v: std_logic_vector(2 downto 0);
	begin
		inst_temp := inst(15 downto 11);
		reg1_addr_v := inst(10 downto 8);
		reg2_addr_v := inst(7 downto 5);
		reg3_addr_v := inst(4 downto 2);
		
		--default value of output
		wr_ra <= '0';
		re_sp_ih <= '0';
		immd <= ZERO16;
		b_dest <= ZERO16; 
		jmp_dest <= "00"; 
		jmp <= '0'; 
		b_op <= "00"; 
		alu_op <= "000"; 
		alu_srca <= "00"; 
		alu_srcb <= "00"; 
		t_op <= '0'; 
		datasrc <= '0';
		rd <= "000"; 
		write_reg <= '0'; 
		write_mem <= '0'; 
		mem_to_reg <= '0'; 
		write_sp <= '0'; 
		write_ih <= '0'; 
		write_t <= '0';
		shift_imm <= ZERO16;
		
		case (inst_temp) is
			when OP_ADDIU =>
				wr_ra <= '0';
				immd(15 downto 8) <= (others => inst(7));
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_REGA;
				alu_srcb <= ALUSRCB_IMM;
				rd <= reg1_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';
 			when OP_ADDIU3 =>
 				wr_ra <= '0';
				immd(15 downto 4) <= (others => inst(3));
				immd(3 downto 0) <= inst(3 downto 0);
				jmp <= '0'; 
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_REGA;
				alu_srcb <= ALUSRCB_IMM;
				rd <= reg1_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';
 			when OP_B =>
  				wr_ra <= '0';
				b_dest(15 downto 11) <= (others => inst(10));
				b_dest(10 downto 0) <= inst(10 downto 0);
				jmp_dest <= JUMP_BDEST; 
				jmp <= '1'; 
				write_reg <= '0';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';			
 			when OP_BEQZ => 
   			wr_ra <= '0';
				b_dest(15 downto 8) <= (others => inst(7));
				b_dest(7 downto 0) <= inst(7 downto 0);
				jmp_dest <= JUMP_BDEST; 
				jmp <= '0'; 
				b_op <= BRANCH_RXEQZ;
				write_reg <= '0';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';			
 			when OP_BNEZ =>
 				wr_ra <= '0';
				b_dest(15 downto 8) <= (others => inst(7));
				b_dest(7 downto 0) <= inst(7 downto 0);
				jmp_dest <= JUMP_BDEST; 
				jmp <= '0'; 
				b_op <= BRANCH_RXNEZ;
				write_reg <= '0';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';			
 			when OP_LI =>
 				wr_ra <= '0';
				immd(15 downto 8) <= (others => '0');
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_ZERO;
				alu_srcb <= ALUSRCB_IMM;
				rd <= reg1_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';
 			when OP_LW =>
 				wr_ra <= '0';
				immd(15 downto 8) <= (others => inst(7));
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_REGA;
				alu_srcb <= ALUSRCB_IMM;
				rd <= reg2_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '1';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';	
 			when OP_LW_SP =>
 				wr_ra <= '0';
				re_sp_ih <= RE_SP;
				immd(15 downto 8) <= (others => inst(7));
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_SPREG;
				alu_srcb <= ALUSRCB_IMM;
				rd <= reg1_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '1';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';	
			when OP_MOVE =>
				wr_ra <= '0';
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_ZERO;
				alu_srcb <= ALUSRCB_REGB;
				rd <= reg1_addr_v;
				write_reg <= '1';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';	
 			when OP_IH =>
 				case( inst(7 downto 0) ) is				
 					when IH_MFIH =>
		 				wr_ra <= '0';
						re_sp_ih <= RE_IH;
						jmp <= '0';
						b_op <= BRANCH_NONE;   
						alu_op <= ALUOP_PLUS;
						alu_srca <= ALUSRCA_SPREG;
						alu_srcb <= ALUSRCB_ZERO;
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';		
 					when IH_MTIH =>
		 				wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;   
						alu_op <= ALUOP_PLUS;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_ZERO;
						write_reg <= '0';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '1';
						write_t <= '0';		
 					when others =>				
 				end case ;
 			when OP_NOP =>
 				wr_ra <= '0';
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				write_reg <= '0';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';		
 			when OP_SHIFT =>
 				case( inst(1 downto 0) ) is
 					when SHIFT_SLL =>
		 				wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;   
						alu_op <= ALUOP_SLL;
						alu_srca <= ALUSRCA_SHIFT;
						alu_srcb <= ALUSRCB_REGB;
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';
						if(inst(4 downto 2) = "000") then
							shift_imm <= "0000000000001000";
						else
							shift_imm(15 downto 3) <= "0000000000000";
							shift_imm(2 downto 0) <= inst(4 downto 2);
						end if;
 					when SHIFT_SRA =>
		 				wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;   
						alu_op <= ALUOP_SRA;
						alu_srca <= ALUSRCA_SHIFT;
						alu_srcb <= ALUSRCB_REGB;
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';	
						if(inst(4 downto 2) = "000") then
							shift_imm <= "0000000000001000";
						else
							shift_imm(15 downto 3) <= "0000000000000";
							shift_imm(2 downto 0) <= inst(4 downto 2);
						end if;
 					when others =>
 				
 				end case ; 	
 			when OP_SW =>
 				wr_ra <= '0';
				immd(15 downto 8) <= (others => inst(7));
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_REGA;
				alu_srcb <= ALUSRCB_IMM;
				datasrc <= DSRC_SRCB;
				write_reg <= '0';
				write_mem <= '1';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';			
 			when OP_SW_SP =>
 				wr_ra <= '0';
				re_sp_ih <= RE_SP;
				immd(15 downto 8) <= (others => inst(7));
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_PLUS;
				alu_srca <= ALUSRCA_SPREG;
				alu_srcb <= ALUSRCB_IMM;
				datasrc <= DSRC_SRCA;
				write_reg <= '0';
				write_mem <= '1';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '0';				
 			when OP_SLTUI =>
 				wr_ra <= '0';
				immd(15 downto 8) <= (others => '0');
				immd(7 downto 0) <= inst(7 downto 0);
				jmp <= '0';
				b_op <= BRANCH_NONE;   
				alu_op <= ALUOP_SUB;
				alu_srca <= ALUSRCA_REGA;
				alu_srcb <= ALUSRCB_IMM;
				t_op <= TOP_NEG; 
				write_reg <= '0';
				write_mem <= '0';
				mem_to_reg <= '0';
				write_sp <= '0';
				write_ih <= '0';
				write_t <= '1';				
 			when OP_SPECIAL =>
 				case (inst(10 downto 8)) is
 					when SPECIAL_ADDSP =>
 						wr_ra <= '0';
						re_sp_ih <= RE_SP;
						immd(15 downto 8) <= (others => inst(7));
						immd(7 downto 0) <= inst(7 downto 0);
						jmp <= '0';
						b_op <= BRANCH_NONE;   
						alu_op <= ALUOP_PLUS;
						alu_srca <= ALUSRCA_SPREG;
						alu_srcb <= ALUSRCB_IMM;
						write_reg <= '0';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '1';
						write_ih <= '0';
						write_t <= '0';		
 					when SPECIAL_BTEQZ =>
 						wr_ra <= '0';
						b_dest(15 downto 8) <= (others => inst(7));
						b_dest(7 downto 0) <= inst(7 downto 0);
						jmp_dest <= JUMP_BDEST;
						jmp <= '0';
						b_op <= BRANCH_TEQZ;   
						write_reg <= '0';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';			
 					when SPECIAL_MTSP =>
 						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_PLUS;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_ZERO;						
						write_reg <= '0';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '1';
						write_ih <= '0';
						write_t <= '0';	
 					when others =>
 				
 				end case ;
 			when OP_ADD_SUB_U =>
				case (inst(1 downto 0)) is
					when (ADD_SUB_U_ADDU) =>
						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_PLUS;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_REGB;	
						rd <= reg3_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';	
					when (ADD_SUB_U_SUBU) =>
						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_SUB;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_REGB;	
						rd <= reg3_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';	
					when others =>
				end case;
 			when OP_LOGIC =>
 				case( inst(4 downto 0) ) is				
 					when LOGIC_AND =>
 						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_AND;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_REGB;	
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';	
 					when LOGIC_CMP =>
 						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_SUB;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_REGB;	
						t_op <= TOP_NEG;
						write_reg <= '0';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '1';	
		 			when LOGIC_PC =>
		 				case( inst(7 downto 5) ) is		 				
		 					when PC_JR =>
		 						wr_ra <= '0';
								jmp_dest <= JUMP_REGX;
								jmp <= '1';
								write_reg <= '0';
								write_mem <= '0';
								mem_to_reg <= '0';
								write_sp <= '0';
								write_ih <= '0';
								write_t <= '0';	
		 					when PC_MFPC =>
		 						wr_ra <= '0';
								jmp <= '0';
								b_op <= BRANCH_NONE;  
								alu_op <= ALUOP_PLUS;
								alu_srca <= ALUSRCA_ZERO;
								alu_srcb <= ALUSRCB_PC;	
								rd <= reg1_addr_v;
								write_reg <= '1';
								write_mem <= '0';
								mem_to_reg <= '0';
								write_sp <= '0';
								write_ih <= '0';
								write_t <= '0';
							when PC_JRRA =>
		 						wr_ra <= '0';
								jmp_dest <= JUMP_RA;
								jmp <= '1';
								write_reg <= '0';
								write_mem <= '0';
								mem_to_reg <= '0';
								write_sp <= '0';
								write_ih <= '0';
								write_t <= '0';
							when PC_JALR =>
		 						wr_ra <= '1';
								jmp_dest <= JUMP_REGX;
								jmp <= '1';
								write_reg <= '0';
								write_mem <= '0';
								mem_to_reg <= '0';
								write_sp <= '0';
								write_ih <= '0';
								write_t <= '0';
		 					when others =>		 				
		 				end case ;
 							
		 			when LOGIC_OR =>
 						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_OR;
						alu_srca <= ALUSRCA_REGA;
						alu_srcb <= ALUSRCB_REGB;	
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';
					when LOGIC_NEG =>
 						wr_ra <= '0';
						jmp <= '0';
						b_op <= BRANCH_NONE;  
						alu_op <= ALUOP_SUB;
						alu_srca <= ALUSRCA_ZERO;
						alu_srcb <= ALUSRCB_REGB;	
						rd <= reg1_addr_v;
						write_reg <= '1';
						write_mem <= '0';
						mem_to_reg <= '0';
						write_sp <= '0';
						write_ih <= '0';
						write_t <= '0';
 					when others =>
 				end case ; 				
 			when others =>
			
		end case;
	end process;	
end architecture ; -- arch
