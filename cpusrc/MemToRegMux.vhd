library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MemToRegMux is
    port ( mem_to_reg : in std_logic;
	
           data : in std_logic_vector (15 downto 0);
           alu_result : in std_logic_vector (15 downto 0);

           data_wr : out std_logic_vector (15 downto 0));

end MemToRegMux;

architecture Behavioral of MemToRegMux is

begin


end Behavioral;
