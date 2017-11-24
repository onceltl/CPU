library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ALUSrcAMux is
    port ( alu_src_b : in std_logic_vector(1 downto 0);
	
           reg_a : in std_logic_vector (15 downto 0);
           sp_reg : in std_logic_vector (15 downto 0);
           shift : in std_logic_vector (15 downto 0);

           src_a : out std_logic_vector (15 downto 0));

end ALUSrcAMux;

architecture Behavioral of ALUSrcAMux is

begin


end Behavioral;

