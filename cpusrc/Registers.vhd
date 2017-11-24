library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity Registers is
    port ( clk : in std_logic;
           wr_reg : in std_logic;
           wr_t : in std_logic;
           wr_sp : in std_logic;
           wr_ih : in std_logic;
           wr_ra : in std_logic;

           re_idx_a : in std_logic_vector(2 downto 0);
           re_idx_b : in std_logic_vector(2 downto 0);
           wr_idx : in std_logic_vector(2 downto 0);
		   
           t_result : in std_logic;
           wr_data : in std_logic_vector(15 downto 0);
           alu_result_ex : in std_logic_vector(15 downto 0);
           alu_result_mem : in std_logic_vector(15 downto 0);
           mem_result : in std_logic_vector(15 downto 0);
           wr_data : in std_logic_vector(15 downto 0);
		   
           reg_a_src : in std_logic_vector(1 downto 0);
           reg_b_src : in std_logic_vector(1 downto 0);
           t_src : in std_logic;
           sp_reg_src : in std_logic_vector(1 downto 0);

           reg_a_out : out std_logic_vector (15 downto 0);
           reg_b_out : out std_logic_vector (15 downto 0);
           t_out : out std_logic;
           sp_reg_out : out std_logic_vector (15 downto 0);
           ra_out : out std_logic_vector (15 downto 0));

end Registers;

architecture Behavioral of Registers is

begin


end Behavioral;

