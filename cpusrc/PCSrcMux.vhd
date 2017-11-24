library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity PCSrcMux is
    port ( jump : in std_logic;
	
           pc_in : in std_logic_vector (15 downto 0);
           jump_dest : in std_logic_vector (15 downto 0);

           pc_out : out std_logic_vector (15 downto 0));

end PCSrcMux;

architecture Behavioral of PCSrcMux is

begin


end Behavioral;

