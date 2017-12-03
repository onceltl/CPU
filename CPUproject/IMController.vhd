library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity IMController is
  port (
	clk: in std_logic;
	input_pc, input_alu: in std_logic_vector(15 downto 0);	
	write_data: in std_logic_vector(15 downto 0);
	mem_signal: in std_logic_vector(3 downto 0);

	read_result: out std_logic_vector(15 downto 0);
	--ground signals
	ram2_oe, ram2_we, ram2_en: out std_logic;
	ram2_addr: out std_logic_vector(17 downto 0);
	ram2_data: inout std_logic_vector(15 downto 0)
  );
end entity ; -- IMController

architecture arch of IMController is
--signal local_we : std_logic := '1';
begin
	
	ram2_en <= '0';
	--ram2_we <= local_we or clk;
	process(input_pc, input_alu, write_data, mem_signal)
	begin
		case (mem_signal) is
			when IM_WRITE =>
				ram2_data <= write_data;
				ram2_addr <= "00" & input_alu;
				ram2_oe <= '1';
				ram2_we <= clk;
				--local_we <= '0';
			when IM_READ =>
				ram2_data <= "ZZZZZZZZZZZZZZZZ";
				ram2_oe <= '0';
				ram2_we <= '1';
				--local_we <= '1';
				ram2_addr <= "00" & input_alu;
			when others =>
				--包括NONE在内的所有其他状态都视为从ram2读指令
				ram2_data <= "ZZZZZZZZZZZZZZZZ";
				ram2_oe <= '0';
				ram2_we <= '1';
				--local_we <= '1';
				ram2_addr <= "00" & input_pc;
		end case;
	end process ;

	getResult : process(ram2_data, mem_signal)
	begin
		if mem_signal /= IM_WRITE then
			read_result <= ram2_data;
		else
			read_result <= NOP_INSTRUCT;
		end if;
	end process ; 
end architecture ; 