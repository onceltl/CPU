library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity HazardDetectiveUnit is
    port ( en : in std_logic;
           wr_reg : in std_logic;
           mem_signal_ex : in std_logic_vector(3 downto 0);
           mem_signal_mem : in std_logic_vector(3 downto 0);

           rd : in std_logic_vector (2 downto 0);
           re_idx_a : in std_logic_vector (2 downto 0);
           re_idx_b : in std_logic_vector (2 downto 0);

           wr_pc : out std_logic;
           wr_ifid : out std_logic;
           wr_idex : out std_logic;
           wr_exmem : out std_logic;
           wr_memwb : out std_logic;
           flush_idex : out std_logic);

end HazardDetectiveUnit;

architecture Behavioral of HazardDetectiveUnit is
begin
	
	process(en, wr_reg, mem_signal_ex, mem_signal_mem,
			rd, re_idx_a, re_idx_b)
		wr_pc <= '1';
		wr_ifid <= '1';
		wr_idex <= '1';
		wr_exmem <= '1';
		wr_memwb <= '1';
		flush_idex <= '0';
		
		if(en = '0')then
			wr_pc <= '0';
			wr_ifid <= '0';
			wr_idex <= '0';
			wr_exmem <= '0';
			wr_memwb <= '0';
		elsif((mem_signal_mem = RE_IM) or (mem_signal_mem = WR_IM))then	-- struct conflict
			wr_pc <= '0';
			wr_ifid <= '0';
			flush_idex <= '1';
		elsif((mem_signal_ex = RE_DM) and (wr_reg = '1'))then			-- memdata conflict
			if((rd = re_idx_a) or (rd = re_idx_b))then
				wr_pc <= '0';
				wr_ifid <= '0';
				flush_idex <= '1';
			end if;
		end if;
	
	end process;

end Behavioral;

