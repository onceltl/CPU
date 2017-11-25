library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MemSignalController is
    port ( mem_wr : in std_logic;
           mem_to_reg : in std_logic;

           alu_result : in std_logic_vector (15 downto 0);

           alu_result_out : out std_logic_vector (15 downto 0);
           mem_signal : out std_logic_vector (3 downto 0));

end MemSignalController;

architecture Behavioral of MemSignalController is
begin

	process(mem_wr, mem_to_reg, alu_result)
	variable res : STD_LOGIC_VECTOR(15 downto 0) := ZERO16;
	begin
		res := alu_result;
		mem_signal <= NONE;
		
		if(mem_wr = '1')then
			if( (res >= x"0000") and (res <= x"7FFF") )then
				mem_signal <= IM_WRITE;
			elsif( (res >= x"8000") and ((res <= x"BEFF") or (res >= x"BF10")) )then
				mem_signal <= DM_WRITE;
			elsif(res = x"BF00")then
				mem_signal <= SERIAL_DATA_WRITE;
			end if;
		end if;
		
		if(mem_to_reg = '1')then
			if( (res >= x"0000") and (res <= x"7FFF") )then
				mem_signal <= IM_READ;
			elsif( (res >= x"8000") and ((res <= x"BEFF") or (res >= x"BF10")) )then
				mem_signal <= DM_READ;
			elsif(res = x"BF00")then
				mem_signal <= SERIAL_DATA_READ;
			elsif(res = x"BF01")then
				mem_signal <= SERIAL_STATE_READ;
			end if;
		end if;
		
		if res >= x"8000" then
			res := res - x"8000";
		end if;
		alu_result_out <= res;
		
	end process;

end Behavioral;

