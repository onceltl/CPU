library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity PCIncreasor is
  port (
	pc_in: in std_logic_vector(15 downto 0);
	pc_out: out std_logic_vector(15 downto 0)
  ) ;
end entity ;

architecture arch of PCIncreasor is
begin

	process(pc_in)
	begin
		pc_out <= pc_in + '1';
	end process ;

end architecture ; -- arch