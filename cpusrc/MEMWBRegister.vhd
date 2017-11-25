library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MEMWBRegister is
    port ( clk : in std_logic;
           rst : in std_logic;
           wr : in std_logic;

           wr_reg_in : in std_logic;
           wr_sp_in : in std_logic;
           wr_ih_in : in std_logic;
           mem_to_reg_in : in std_logic;

           alu_result_in : in std_logic_vector (15 downto 0);
           data_in : in std_logic_vector (15 downto 0);
           rd_in : in std_logic_vector (2 downto 0);

           wr_reg_out : out std_logic;
           wr_sp_out : out std_logic;
           wr_ih_out : out std_logic;
           mem_to_reg_out : out std_logic;

           alu_result_out : out std_logic_vector (15 downto 0);
           data_out : out std_logic_vector (15 downto 0);
           rd_out : out std_logic_vector (2 downto 0));

end MEMWBRegister;

architecture Behavioral of MEMWBRegister is
begin

	process(rst, clk)
		if(rst = '0')then
			wr_reg_out <= '0';
			wr_sp_out <= '0';
			wr_ih_out <= '0';
			mem_to_reg_out <= '0';
			
			alu_result_out <= ZERO16;
			data_out <= ZERO16;
			rd_out <= ZERO3;
		elsif((wr = '1') and rising_edge(clk))then
			wr_reg_out <= wr_reg_in;
			wr_sp_out <= wr_sp_in;
			wr_ih_out <= wr_ih_in;
			mem_to_reg_out <= mem_to_reg_in;
			
			alu_result_out <= alu_result_in;
			data_out <= data_in;
			rd_out <= rd_in;
		end if;
	end process;

end Behavioral;

