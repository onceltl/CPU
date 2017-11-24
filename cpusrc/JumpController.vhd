library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity JumpController is
    port ( jmp : in std_logic;
           b_op : in std_logic_vector(1 downto 0);
           j_dest : in std_logic_vector(1 downto 0);

           b_dest : in std_logic_vector (15 downto 0);
           reg_a : in std_logic_vector (15 downto 0);
           ra : in std_logic_vector (15 downto 0);

           jump : out std_logic;
           pc_out : out std_logic_vector (15 downto 0));
		   
end JumpController;

architecture Behavioral of JumpController is

begin


end Behavioral;

