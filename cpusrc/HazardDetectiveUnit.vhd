library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity HazardDetectiveUnit is
    port ( en : in std_logic;
           wr_reg : in std_logic;
           mem_signal : in std_logic_vector(3 downto 0);

           rd : in std_logic_vector (2 downto 0);
           re_idx_a : in std_logic_vector (2 downto 0);
           re_idx_b : in std_logic_vector (2 downto 0);

           wr_pc : out std_logic;
           wr_ifid : out std_logic;
           wr_idex : out std_logic;
           wr_exmem : out std_logic;
           wr_memwb : out std_logic;
           flush_idex : out std_logic);

end HazardDetectiveUnit;

architecture Behavioral of HazardDetectiveUnit is

begin


end Behavioral;

