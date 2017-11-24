library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ALU is
    port ( op : in std_logic_vector(2 downto 0);
	
           src_a : in std_logic_vector (15 downto 0);
           src_b : in std_logic_vector (15 downto 0);

           result : out std_logic_vector (15 downto 0));
           zero : out std_logic);

end ALU;

architecture Behavioral of ALU is

begin


end Behavioral;

