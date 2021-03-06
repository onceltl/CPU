library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity DataToWrMux is
    port ( data_src : in std_logic;
	
           src_a : in std_logic_vector (15 downto 0);
           src_b : in std_logic_vector (15 downto 0);

           data_out : out std_logic_vector (15 downto 0));

end DataToWrMux;

architecture Behavioral of DataToWrMux is
begin

	process(data_src, src_a, src_b)
	begin
		if(data_src = DSRC_SRCA)then
			data_out <= src_a;
		else	-- DSRC_SRCB
			data_out <= src_b;
		end if;
	end process;

end Behavioral;

