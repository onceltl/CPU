library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity GetT is
    port ( op : in std_logic;
	
           alu_signed : in std_logic;
           alu_zero : in std_logic;

           t : out std_logic);

end GetT;

architecture Behavioral of GetT is
begin
	
	process(op, alu_result, alu_zero)
		if(op = TOP_NEQ)then
			t <= not alu_zero;
		else	-- TOP_NEG
			t <= alu_signed;
		end if;
	end process;

end Behavioral;

