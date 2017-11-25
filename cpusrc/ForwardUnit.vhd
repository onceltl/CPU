library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ForwardUnit is
    port ( wr_reg_ex : in std_logic;
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
           sp_reg_src : out std_logic_vector(1 downto 0));
end ForwardUnit;

architecture Behavioral of ForwardUnit is
begin
	
	process(wr_reg_ex, wr_reg_mem, mem_to_reg,
			rd_ex, rd_mem, re_idx_a)
		if((wr_reg_ex = '1') and (rd_ex = re_idx_a))then		-- alu result to be used by next
			reg_a_src <= FORWARD_ALU_EX;
		elsif((wr_reg_mem = '1') and (mem_to_reg = '1') and (rd_mem = re_idx_a))then	-- memdata to be used by next next
			reg_a_src <= FORWARD_MEM;
		elsif((wr_reg_mem = '1') and (rd_mem = re_idx_a))then	-- alu result to be used by next next
			reg_a_src <= FORWARD_ALU_MEM;
		else
			reg_a_src <= FORWARD_OLD;
		end if;
	end process;
	process(wr_reg_ex, wr_reg_mem, mem_to_reg,
			rd_ex, rd_mem, re_idx_b)
		if((wr_reg_ex = '1') and (rd_ex = re_idx_b))then
			reg_b_src <= FORWARD_ALU_EX;
		elsif((wr_reg_mem = '1') and (mem_to_reg = '1') and (rd_mem = re_idx_b))then
			reg_b_src <= FORWARD_MEM;
		elsif((wr_reg_mem = '1') and (rd_mem = re_idx_b))then
			reg_b_src <= FORWARD_ALU_MEM;
		else
			reg_b_src <= FORWARD_OLD;
		end if;
	end process;
	
	process(wr_ih_ex, wr_ih_mem, wr_sp_ex, wr_sp_mem, re_sp_or_ih)
		if( ((wr_ih_ex = '1') and (re_sp_or_ih = RE_IH)) or ((wr_sp_ex = '1') and (re_sp_or_ih = RE_SP)) )then
			sp_reg_src <= FORWARD_ALU_EX;
		elsif( ((wr_ih_mem = '1') and (re_sp_or_ih = RE_IH)) or ((wr_sp_mem = '1') and (re_sp_or_ih = RE_SP)) )then
			sp_reg_src <= FORWARD_ALU_MEM;
		else
			sp_reg_src <= FORWARD_OLD;
		end if;
	end process;

end Behavioral;

