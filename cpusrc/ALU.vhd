library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity ALU is
    port ( op : in std_logic_vector(2 downto 0);
	
           src_a : in std_logic_vector (15 downto 0);
           src_b : in std_logic_vector (15 downto 0);

           result : out std_logic_vector (15 downto 0);
           zero : out std_logic);

end ALU;

architecture Behavioral of ALU is

begin
	process(op, src_a, src_b)
	variable temp : std_logic_vector(15 downto 0);
	begin
		case op is
			when ALUOP_PLUS =>
				temp := src_a + src_b;
			when ALUOP_AND =>
				temp := src_a and src_b;
			when ALUOP_SUB =>
				temp := src_a - src_b;
			when ALUOP_OR =>
				temp := src_a or src_b;
			when ALUOP_SLL =>
				temp := TO_STDLOGICVECTOR(TO_BITVECTOR(src_b) SLL CONV_INTEGER(src_a)); 
			when ALUOP_SRA =>
				temp := TO_STDLOGICVECTOR(TO_BITVECTOR(src_b) SRA CONV_INTEGER(src_a)); 
			when others =>
				temp := ZERO16;
		end case;
		result <= temp;
		if(temp = ZERO16) then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end process;

end Behavioral;

