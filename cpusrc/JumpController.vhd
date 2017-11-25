library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity JumpController is
    port ( jmp : in std_logic;
           b_op : in std_logic_vector(1 downto 0);
           j_dest : in std_logic_vector(1 downto 0);

		   t : std_logic;
           b_dest : in std_logic_vector (15 downto 0);
           reg_a : in std_logic_vector (15 downto 0);
           ra : in std_logic_vector (15 downto 0);

           jump : out std_logic;
           j_dest_out : out std_logic_vector (15 downto 0));
		   
end JumpController;

architecture Behavioral of JumpController is
begin

	-- decide whether to jump
	process(jmp, b_op)
	begin
		jump <= '0';
		if(jmp = '1')then
			jump <= '1'
		else
			case(b_op)is
				when BRANCH_RXEQZ =>
					if(reg_a = ZERO16)then
						jump <= '1';
					end if;
				when BRANCH_RXNEZ =>
					if(reg_a /= ZERO16)then
						jump <= '1';
					end if;
				when BRANCH_TEQZ =>
					if(t = '0')then
						jump <= '1';
					end if;
				when others =>	-- BRANCH_NONE
					jump <= '0';
			end case;
		end if;
	end process;

	-- choose jump dest
	process(j_dest, b_dest, reg_a, ra)
	begin
		case(j_dest)is
			when JUMP_BDEST =>
				j_dest_out <= b_dest;
			when JUMP_RA =>
				j_dest_out <= ra;
			when JUMP_REGX =>
				j_dest_out <= reg_a;
			when others =>
				j_dest_out <= ZERO16;
		end case;
	end process;

end Behavioral;

