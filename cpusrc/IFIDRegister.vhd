library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity IFIDRegister is
    port ( clk : in std_logic;
           rst : in std_logic;
           wr : in std_logic;

           pc_in : in std_logic_vector (15 downto 0);
           inst_in : in std_logic_vector (15 downto 0);

           pc_out : out std_logic_vector (15 downto 0));
           inst_out : out std_logic_vector (15 downto 0));
		   
end IFIDRegister;

architecture Behavioral of IFIDRegister is

begin


end Behavioral;

