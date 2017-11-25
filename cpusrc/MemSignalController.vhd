library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity MemSignalController is
    port ( mem_wr : in std_logic;
           mem_to_reg : in std_logic;

           alu_result : in std_logic_vector (15 downto 0);

           mem_signal : out std_logic_vector (3 downto 0));

end MemSignalController;

architecture Behavioral of MemSignalController is

begin


end Behavioral;

