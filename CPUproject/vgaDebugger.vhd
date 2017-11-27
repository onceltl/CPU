library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity vgaDebugger is
    port (
			clk_cpu : in std_logic;
			clk_display : in std_logic;

			pc_now: in std_logic_vector(15 downto 0);
			inst: in std_logic_vector(15 downto 0);
			reg_a: in std_logic_vector(15 downto 0);
			reg_b: in std_logic_vector(15 downto 0);
			alu_result_ex: in std_logic_vector(15 downto 0);
			ex_mem_signal: in std_logic_vector(3 downto 0);
			mem_result: in std_logic_vector(15 downto 0);

			vga_rst:  out   STD_LOGIC;  --rst
			vga_clock: out std_logic;
			vga_wr_en :  out STD_LOGIC;
			vga_wr_char   :  out STD_LOGIC_VECTOR(7 downto 0)
		);
end vgaDebugger;

architecture Behavioral of vgaDebugger is
	signal cpuState: std_logic := '1';
	signal stageState, varState: std_logic_vector(7 downto 0) := ZERO8;
	
	signal var: std_logic_vector(15 downto 0):= ZERO16;
	signal data: std_logic_vector(7 downto 0):= ZERO8;
begin
	
	vga_wr_char <= data;
	vga_rst <= clk_cpu;
	
	process(clk_cpu, clk_display)
	variable state_num: std_logic_vector(7 downto 0) := ZERO8;
	begin
		state_num := stageState;
		if(clk_cpu = '0')then
			cpuState <= '1';
			stageState <= ZERO8;
			varState <= ZERO8;
		elsif(rising_edge(clk_display) and (state_num <= x"07"))then
			state_num := varState;
			varState <= varState + '1';
			if(state_num >= x"07")then
				varState <= ZERO8;
				stageState <= stageState + '1';
			end if;
		end if;
	end process;
	
	process(clk_cpu, clk_display, stageState)
	variable state_num: std_logic_vector(7 downto 0) := ZERO8;
	begin
		vga_wr_en <= '0';
		vga_clock <= '0';
		state_num := stageState;
		if (state_num <= x"07") and (state_num >= x"01") and (clk_cpu = '1') then
			vga_wr_en <= '1';
			vga_clock <= not clk_display;
		end if;
	end process;
	
	process(varState, var, stageState)
	variable state_num: std_logic_vector(7 downto 0) := ZERO8;
	variable temp_num: std_logic_vector(3 downto 0) := x"0";
	begin
		state_num := varState;
		case(state_num)is
			when x"01" =>
				data <= stageState + ASCII_A;
			when x"02" =>
				data <= ASCII_SPACE;
			when x"03" =>
				temp_num := var(15 downto 12);
				if(temp_num >= x"A")then
					data <= ASCII_A + ("0000"&temp_num) - "1010";
				else
					data <= ASCII_0 + ("0000"&temp_num);
				end if;
			when x"04" =>
				temp_num := var(11 downto 8);
				if(temp_num >= x"A")then
					data <= ASCII_A + ("0000"&temp_num) - "1010";
				else
					data <= ASCII_0 + ("0000"&temp_num);
				end if;
			when x"05" =>
				temp_num := var(7 downto 4);
				if(temp_num >= x"A")then
					data <= ASCII_A + ("0000"&temp_num) - "1010";
				else
					data <= ASCII_0 + ("0000"&temp_num);
				end if;
			when x"06" =>
				temp_num := var(3 downto 0);
				if(temp_num >= x"A")then
					data <= ASCII_A + ("0000"&temp_num) - "1010";
				else
					data <= ASCII_0 + ("0000"&temp_num);
				end if;
			when x"07" =>
				data <= ASCII_NEWLINE;
			when others => 
				data <= ASCII_SPACE;
		end case;
	end process;
	
	process(stageState, pc_now, inst, reg_a, reg_b, alu_result_ex, ex_mem_signal, mem_result)
	begin
		case(stageState)is
			when x"01" =>
				var <= pc_now;
			when x"02" =>
				var <= inst;
			when x"03" =>
				var <= reg_a;
			when x"04" =>
				var <= reg_b;
			when x"05" =>
				var <= alu_result_ex;
			when x"06" =>
				var(15 downto 4) <= (others => '0');
				var(3 downto 0) <= ex_mem_signal;
			when x"07" =>
				var <= mem_result;
			when others =>
				var <= (others => '1');
		end case;
	end process;

end Behavioral;

