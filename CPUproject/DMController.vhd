library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity DMController is
port (

	clk: in std_logic;
	cpu_clk: in std_logic;
	serial_clk: in std_logic;
	-- data: input
	read_write_addr: in std_logic_vector(15 downto 0);
	write_data: in std_logic_vector(15 downto 0);
	-- signal: input
	mem_signal: in std_logic_vector(3 downto 0); 
	-- output
	read_result: out std_logic_vector(15 downto 0);
	
	-- ground portal
	-- serial status
	serial_tbre, serial_tsre, serial_data_ready: in std_logic;
	-- serial signal
	serial_rdn, serial_wrn: out std_logic;

	-- ram1 enable
	ram1_oe, ram1_we, ram1_en: out std_logic;
	-- ram1 bus
	ram1_addr: out std_logic_vector(17 downto 0);
	ram1_data: inout std_logic_vector(15 downto 0);
	
	vga_write_enable: out std_logic;
	vga_write_data: out std_logic_vector(7 downto 0); --connect to vga's write_char signal
	vga_clk: out std_logic; --vga write clk
	--not ensured signals until ltl finish ps2 module
	ps2_read_enable: out std_logic;
	ps2_read_data: in std_logic_vector(7 downto 0);
	ps2_data_ready: in std_logic
	);
end entity ; -- DMController

architecture arch of DMController is
--signal local_we : std_logic := '1';
begin
	--ram1_we <= local_we or clk;
	vga_clk <= not cpu_clk;
	process(read_write_addr, write_data, mem_signal, clk, ps2_read_data, cpu_clk, serial_clk)
	begin
		-- default: all disabled
		ram1_oe <= '1';
		ram1_we <= '1';
		--local_we <= '1';
		ram1_en <= '1';
		serial_rdn <= '1';
		serial_wrn <= '1';
		--vga_rdn <= '1';
		--vga_wrn <= '1';
		vga_write_enable <= WRITE_DISABLE;--0
		ps2_read_enable <= READ_DISABLE;--0
		
		ram1_data <= HIGHZ16;
		ram1_addr <= "00" & read_write_addr;
		vga_write_data <= HIGHZ8;
		
		case (mem_signal) is
			when DM_READ =>
				ram1_data <= HIGHZ16;
				ram1_en <= '0';
				ram1_oe <= '0';
				ram1_we <= '1';
				--local_we <= '1';
			when DM_WRITE =>
				ram1_data <= write_data;
				ram1_en <= '0';
				ram1_oe <= '1';
				ram1_we <= clk;
				--local_we <= '0';
			when SERIAL_DATA_READ =>
				ram1_en <= '1';
				ram1_oe <= '1';
				ram1_we <= '1';
				--local_we <= '1';
				--ram1_data(15 downto 8) <= ZERO8;
				--serial_rdn <= not clk;
				--serial_rdn <= clk;
				serial_rdn <= '0';
			when SERIAL_DATA_WRITE =>
				ram1_en <= '1';
				ram1_oe <= '1';
				ram1_we <= '0';
				--local_we <= '0';
				ram1_data(7 downto 0) <= write_data(7 downto 0);
				serial_wrn <= serial_clk;--'1'保持时间较长
				--serial_wrn <= not clk;
				
			when VGA_WRITE =>
				vga_write_data <= write_data(7 downto 0);
				vga_write_enable <= WRITE_ENABLE;
			when PS2_READ =>
			   ps2_read_enable <= READ_ENABLE;
				ram1_data <= "00000000" & ps2_read_data;
			when others =>
				null;
		end case;
	end process;

	process(clk, ram1_data, mem_signal, serial_tbre, serial_tsre, serial_data_ready, read_write_addr, ps2_data_ready) --get result
	begin
		if mem_signal = DM_READ or mem_signal = SERIAL_DATA_READ or mem_signal = PS2_READ then
			read_result <= ram1_data;
		--elsif mem_signal = PS2_READ then
		--	read_result <= "00000000" & ps2_read_data;
		elsif mem_signal = SERIAL_STATE_READ then
			read_result <= ZERO14 & serial_data_ready & (serial_tbre AND serial_tsre);
		elsif mem_signal = VGA_PS2_STATE_READ then
			read_result <= ZERO14 & ps2_data_ready & "1"; --"VGA默认写成功“
		else
			read_result <= NOP_INSTRUCT;
		end if;
		
		-- a fake ram
		--read_result <= read_write_addr;
	end process; -- getResult

end architecture; -- arch