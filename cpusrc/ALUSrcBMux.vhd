library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ALUSrcBMux is
    port ( alu_src_a : in std_logic_vector(1 downto 0);
	
           reg_b : in std_logic_vector (15 downto 0);
           imm : in std_logic_vector (15 downto 0);
           pc : in std_logic_vector (15 downto 0);

           src_b : out std_logic_vector (15 downto 0));

end ALUSrcBMux;

architecture Behavioral of ALUSrcBMux is

begin


end Behavioral;

