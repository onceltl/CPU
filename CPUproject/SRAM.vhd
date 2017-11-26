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
		mem_array(0) <= "0110010011000000";
		mem_array(1) <= "0001001000001101";
		mem_array(2) <= "0110010000100000";
		mem_array(3) <= "0100011010001010";
		mem_array(4) <= "0100011101000111";
		mem_array(5) <= "1101001001010010";
		mem_array(6) <= "1110110000000000";
		mem_array(7) <= "1110100100000000";
		mem_array(8) <= "1110000111101101";
		mem_array(9) <= "0001010110100010";
		mem_array(10) <= "0100000111001000";
		mem_array(11) <= "1101111011110000";
		mem_array(12) <= "1110110001101101";
		mem_array(13) <= "1110011000100111";
		mem_array(14) <= "1001101110101010";
		mem_array(15) <= "0110000101110101";
		mem_array(16) <= "0100001111000001";
		mem_array(17) <= "1110000001001011";
		mem_array(18) <= "1110111101100110";
		mem_array(19) <= "0000100000000000";
		mem_array(20) <= "1110111101101010";
		mem_array(21) <= "0011000110010111";
		mem_array(22) <= "0100010011000000";
		mem_array(23) <= "0000100000000000";
		mem_array(24) <= "1001011010101001";
		mem_array(25) <= "1110110101000000";
		mem_array(26) <= "1110001011111111";
		mem_array(27) <= "0000100000000000";
		mem_array(28) <= "0110000011110111";
		mem_array(29) <= "1110010001110011";
		mem_array(30) <= "0001011001001000";
		mem_array(31) <= "1110010100010111";
		mem_array(32) <= "0001010001111011";
		mem_array(33) <= "0000100000000000";
		mem_array(34) <= "0110001010101011";
		mem_array(35) <= "0000100000000000";
		mem_array(36) <= "1110010110111011";
		mem_array(37) <= "0000100000000000";
		mem_array(38) <= "0110001011011111";
		mem_array(39) <= "0010000110001100";
		mem_array(40) <= "0100000000100001";
		mem_array(41) <= "1110110001001100";
		mem_array(42) <= "0001010100111110";
		mem_array(43) <= "0110001001110111";
		mem_array(44) <= "0110000010110001";
		mem_array(45) <= "0000100000000000";
		mem_array(46) <= "0110001011001100";
		mem_array(47) <= "0110000011001100";
		mem_array(48) <= "1110110011101100";
		mem_array(49) <= "0001001110000010";
		
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