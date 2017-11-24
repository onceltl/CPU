library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity IDEXRegister is
    port ( clk : in std_logic;
           rst : in std_logic;
           wr : in std_logic;
           flush : in std_logic;

           alu_op_in : in std_logic_vector (2 downto 0);
           alu_src_a_in : in std_logic_vector (1 downto 0);
           alu_src_b_in : in std_logic_vector (1 downto 0);
           t_op_in : in std_logic;
           data_src_in : in std_logic;
           wr_reg_in : in std_logic;
           wr_mem_in : in std_logic;
           mem_to_reg_in : in std_logic;
           wr_sp_in : in std_logic;
           wr_ih_in : in std_logic;
           wr_t_in : in std_logic;

           pc_in : in std_logic_vector (15 downto 0);
           reg_a_in : in std_logic_vector (15 downto 0);
           reg_b_in : in std_logic_vector (15 downto 0);
           sp_reg_in : in std_logic_vector (15 downto 0);
           imm_in : in std_logic_vector (15 downto 0);
           shift_in : in std_logic_vector (15 downto 0);
           rd_in : in std_logic_vector (2 downto 0);

           alu_op_out : out std_logic_vector (2 downto 0);
           alu_src_a_out : out std_logic_vector (1 downto 0);
           alu_src_b_out : out std_logic_vector (1 downto 0);
           t_op_out : out std_logic;
           data_src_out : out std_logic;
           wr_reg_out : out std_logic;
           wr_mem_out : out std_logic;
           mem_to_reg_out : out std_logic;
           wr_sp_out : out std_logic;
           wr_ih_out : out std_logic;
           wr_t_out : out std_logic;

           pc_out : out std_logic_vector (15 downto 0);
           reg_a_out : out std_logic_vector (15 downto 0);
           reg_b_out : out std_logic_vector (15 downto 0);
           sp_reg_out : out std_logic_vector (15 downto 0);
           imm_out : out std_logic_vector (15 downto 0);
           shift_out : out std_logic_vector (15 downto 0);
           rd_out : out std_logic_vector (2 downto 0);

end IDEXRegister;

architecture Behavioral of IDEXRegister is

begin


end Behavioral;

