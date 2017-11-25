library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity DMController is
port (

	clk: in std_logic;
	-- data: input
	read_write_addr: in std_logic_vector(15 downto 0);
	write_data: in std_logic_vector(15 downto 0);
	-- signal: input
	mem_signal: in std_logic_vector(3 downto 0); 
	-- output
	read_result: out std_logic_vector(15 downto 0);
	
	-- ground portal
	-- serial status
	tbre, tsre, data_ready: in std_logic;
	-- serial signal
	rdn, wrn: out std_logic;

	-- ram1 enable
	ram1_oe, ram1_we, ram1_en: out std_logic;
	-- ram1 bus
	ram1_addr: out std_logic_vector(17 downto 0);
	ram1_data: inout std_logic_vector(15 downto 0);
	vga_write_enable: out std_logic;
	vga_write_data: out std_logic_vector(7 downto 0); --connect to vga's write_char signal
	--not ensured signals until ltl finish ps2 module
	ps2_read_enable: out std_logic;
	ps2_read_data: in std_logic_vector(7 downto 0);
	ps2_data_ready: in std_logic
	);
end entity ; -- DMController

architecture arch of DMController is
--signal read_data std_logic := '0';
begin
	
	process(read_write_addr, write_data, mem_signal, clk, ps2_read_data)
	begin
		-- default: all disabled
		ram1_oe <= '1';
		ram1_we <= '1';
		ram1_en <= '1';
		rdn <= '1';
		wrn <= '1';
		vga_write_enable <= WRITE_DISABLE;--0
		ps2_read_enable <= READ_DISABLE;--0
		case (mem_signal) is
			when DM_READ =>
				ram1_data <= "ZZZZZZZZZZZZZZZZ";
				ram1_en <= '0';
				ram1_oe <= '0';
				ram1_we <= '1';
				ram1_addr <= "00" & read_write_addr;
			when DM_WRITE =>
				ram1_data <= write_data;
				ram1_addr <= "00" & read_write_addr;
				ram1_en <= '0';
				ram1_oe <= '1';
				ram1_we <= '0';
			when SERIAL_DATA_READ =>
				-- need to be finished
			when SERIAL_DATA_WRITE =>
				-- need to be finished
			when VGA_WRITE =>
				--ram1_data <= write_data;
				--wrn <= clk; --?如何使用
				vga_write_data <= write_data(7 downto 0);
				vga_write_enable <= WRITE_ENABLE;
			when PS2_READ =>
			   -- need to be finished
			when others =>
				null;
		end case;
	end process;

	process(ram1_data, mem_signal, tbre, tsre, ps2_data_ready) --get result
	begin
		if mem_signal = DM_READ or mem_signal = SERIAL_DATA_READ then
			read_result <= ram1_data;
		elsif mem_signal = SERIAL_STATE_READ then
			read_result <= "00000000000000" & ps2_data_ready & (tbre AND tsre);
		else
			read_result <= NOP_INSTURCT;
		end if;
	end process; -- getResult

end architecture; -- arch