library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.constantsIF.all;

entity Registers is
    port ( clk : in std_logic;
           wr_reg : in std_logic;
           wr_t : in std_logic;
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
           --t_src : in std_logic;

           reg_a_out : out std_logic_vector (15 downto 0);
           reg_b_out : out std_logic_vector (15 downto 0);
           t_out : out std_logic;
           sp_reg_out : out std_logic_vector (15 downto 0);
           ra_out : out std_logic_vector (15 downto 0));

end Registers;

architecture Behavioral of Registers is
type RegisterArray is array(7 downto 0) of std_logic_vector(7 downto 0);

signal reg_norm : RegisterArray := (others => ZERO16);
signal sp_reg : std_logic_vector(15 downto 0) := ZERO16;
signal ih_reg : std_logic_vector(15 downto 0) := ZERO16;
signal ra_reg : std_logic_vector(15 downto 0) := ZERO16;
signal t_reg : std_logic;

signal reg_a_data : std_logic_vector(15 downto 0);
signal reg_b_data : std_logic_vector(15 downto 0);
signal sp_reg_data : std_logic_vector(15 downto 0);
begin
	-- choose register
	--process(re_idx_a, reg_norm)
		reg_a_data <= reg_norm(conv_integer(re_idx_a));
	--end process;
	--process(re_idx_b, reg_norm)
		reg_b_data <= reg_norm(conv_integer(re_idx_b));
	--end process;
	process(re_sp_or_ih, sp_reg, ih_reg)
		if(re_sp_or_ih = RE_SP)then
			sp_reg_data <= sp_reg;
		else	-- RE_IH
			sp_reg_data <= ih_reg;
		end if;
	end process;
	
	-- write register
	process(clk)
		if(falling_edge(clk))then
			if(wr_reg)then
				reg_norm(conv_integer(wr_idx)) <= wr_data;
			end if;
			if(wr_ra)then
				ra_reg <= pc + '1';
			end if;
			if(wr_sp)then
				sp_reg <= wr_data;
			end if;
			if(wr_ih)then
				ih_reg <= wr_data;
			end if;
		end if;
	end process;	
	process(clk)
		if(rising_edge(clk))then
			t_reg <= t_result;
		end if;
	end process;
	
	--choose register out src
	process(reg_a_src, reg_a_data, alu_result_ex, alu_result_mem, mem_result)
		case(reg_a_src)is
			when FORWARD_ALU_EX =>
				reg_a_out <= alu_result_ex;
			when FORWARD_ALU_MEM =>
				reg_a_out <= alu_result_mem;
			when FORWARD_MEM =>
				reg_a_out <= mem_result;
			when others =>	-- FORWARD_OLD
				reg_a_out <= reg_a_data;
		end case;
	end process;
	process(reg_b_src, reg_b_data, alu_result_ex, alu_result_mem, mem_result)
		case(reg_b_src)is
			when FORWARD_ALU_EX =>
				reg_b_out <= alu_result_ex;
			when FORWARD_ALU_MEM =>
				reg_b_out <= alu_result_mem;
			when FORWARD_MEM =>
				reg_b_out <= mem_result;
			when others =>	-- FORWARD_OLD
				reg_b_out <= reg_b_data;
		end case;
	end process;
	process(sp_reg_src, sp_reg_data, alu_result_ex, alu_result_mem)
		case(sp_reg_src)is
			when FORWARD_ALU_EX =>
				sp_reg_out <= alu_result_ex;
			when FORWARD_ALU_MEM =>
				sp_reg_out <= alu_result_mem;
			when others =>	-- FORWARD_OLD
				sp_reg_out <= sp_reg_data;
		end case;
	end process;
	process(wr_t, t_reg, t_result)
		if(wr_t)then
			t_out <= t_result;
		else
			t_out <= t_reg;
		end if;
	end process;

end Behavioral;
