library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity PC is
    port ( clk : in std_logic;
           rst : in std_logic;
           wr : in std_logic;

           pc_in : in std_logic_vector (15 downto 0);

           pc_out : out std_logic_vector (15 downto 0));

end PC;

architecture Behavioral of PC is
begin
	
	process(rst, clk)
		if(rst = '0')then
			pc_out <= ZERO16;
		elsif((wr = '1') and rising_edge(clk))then
			pc_out <= pc_in;
		end if;
	end process;

end Behavioral;

