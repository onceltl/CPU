library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MemToRegMux is
    port ( mem_to_reg : in std_logic;
	
           data : in std_logic_vector (15 downto 0);
           result : in std_logic_vector (15 downto 0);

           data_wr : out std_logic_vector (15 downto 0));

end MemToRegMux;

architecture Behavioral of MemToRegMux is
begin

	process(mem_to_reg, data, result)
	begin
		if(mem_to_reg = '1')then
			data_wr <= data;
		else
			data_wr <= result;
		end if;
	end process;

end Behavioral;

