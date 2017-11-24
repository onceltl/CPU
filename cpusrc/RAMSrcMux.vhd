library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity RAMSrcMux is
    port ( mem_signal_in : in std_logic_vector (3 downto 0);

           dm_data_in : in std_logic_vector (15 downto 0));
           im_data_in : in std_logic_vector (15 downto 0));

           data_out : out std_logic_vector (15 downto 0));

end RAMSrcMux;

architecture Behavioral of RAMSrcMux is

begin


end Behavioral;

