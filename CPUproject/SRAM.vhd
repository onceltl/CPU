library IEEE;
use IEEE.STD_LOGIC_signed.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.constantsIF.all;

entity SRAM is
  port (
	RAM_OE, RAM_WE, RAM_EN: in std_logic;
	RAM_Addr: in std_logic_vector(17 downto 0);
	RAM_Data: inout std_logic_vector(15 downto 0)
  ) ;
end entity ; -- SRAM

architecture arch of SRAM is
type MemArray is array(255 downto 0) of std_logic_vector(15 downto 0);
signal mem_array: MemArray := (others => NOP_INSTRUCT);
signal data_out: std_logic_vector(15 downto 0);
begin

	process(RAM_OE, RAM_WE, RAM_EN, RAM_Addr, RAM_Data)
	begin
		mem_array(0) <= "0100100110000001"; --ADDIU
		mem_array(1) <= "0100000101001001"; --ADDIU3
		mem_array(2) <= "0110001110000001"; --ADDSP
		mem_array(3) <= "1110000101001101"; --ADDU
		mem_array(4) <= "1110100101001100"; --AND
		mem_array(5) <= "1101000110000001"; --SW_SP
		mem_array(6) <= "0000100000000000"; --NOP
		mem_array(7) <= "1101100101010001"; --SW
		mem_array(8) <= "1110000101001111"; --SUBU
		mem_array(9) <= "0011000101010111"; --SRA
		mem_array(10) <= "1110100101001010"; --CMP
		mem_array(11) <= "1110100111000000"; --JALR
		mem_array(12) <= "1110100100000000"; --JR
		mem_array(13) <= "1110100000100000"; --JRRA
		mem_array(14) <= "0110100110000001"; --LI
		mem_array(15) <= "1001100101010001"; --LW
		mem_array(16) <= "1001000110000001"; --LW_SP
		mem_array(17) <= "1111000100000000"; --MFIH
		mem_array(18) <= "1110100101000000"; --MFPC
		mem_array(19) <= "0111100101000000"; --MOVE
		mem_array(20) <= "1111000100000001"; --MTIH
		mem_array(21) <= "0110010000100000"; --MTSP
		mem_array(22) <= "1110100101001011"; --NEG
		mem_array(23) <= "1110100101001101"; --OR
		mem_array(24) <= "0011000101010100"; --SLL
		mem_array(25) <= "0101100110000001"; --SLTUI
		mem_array(26) <= "0110000010000001"; --BTEQZ
		mem_array(27) <= "0010100110000001"; --BNEZ
		mem_array(28) <= "0010000110000001"; --BEQZ
		mem_array(29) <= "0001010000000001"; --B
		
		
		if RAM_WE = '1' and RAM_OE = '0' then -- read
			data_out <= mem_array(conv_integer(RAM_Addr(7 downto 0)));
		elsif RAM_WE = '0' then -- write
			mem_array(conv_integer(RAM_Addr(7 downto 0))) <= RAM_Data;
		else
			null;
		end if ;
	end process;
	
	RAM_data <= data_out when (RAM_WE = '1' and RAM_OE = '0' and RAM_EN = '0') else (others => 'Z');


end architecture ; -- arch