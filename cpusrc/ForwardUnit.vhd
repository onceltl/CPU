library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ForwardUnit is
    port ( wr_reg : in std_logic;
           wr_ih : in std_logic;
           wr_sp : in std_logic;
           wr_t : in std_logic;
           mem_to_reg : in std_logic;

           rd : in std_logic_vector (2 downto 0);
           re_idx_a : in std_logic_vector (2 downto 0);
           re_idx_b : in std_logic_vector (2 downto 0);

           reg_a_src : out std_logic_vector(1 downto 0);
           reg_b_src : out std_logic_vector(1 downto 0);
           sp_src : out std_logic_vector(1 downto 0);
           t_src : out std_logic);

end ForwardUnit;

architecture Behavioral of ForwardUnit is

begin


end Behavioral;

