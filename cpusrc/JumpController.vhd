library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

entity JumpController is
    port (	jmp : in std_logic;
			b_op : in std_logic_vector(1 downto 0);
			j_dest : in std_logic_vector(1 downto 0);

			t : std_logic;
			pc_in : in std_logic_vector (15 downto 0);
			b_dest : in std_logic_vector (15 downto 0);
			reg_a : in std_logic_vector (15 downto 0);
			ra : in std_logic_vector (15 downto 0);

			pc_out : out std_logic_vector (15 downto 0));
		   
end JumpController;

architecture Behavioral of JumpController is
	signal jump: std_logic := '0';
begin

	-- decide whether to jump
	process(jmp, b_op, reg_a, t)
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
	process(jump, j_dest, b_dest, pc_in, reg_a, ra)
	begin
		pc_out <= pc_in;
		
		if(jump = '1')then
			case(j_dest)is
				when JUMP_BDEST =>
					pc_out <= b_dest + pc_in;
				when JUMP_RA =>
					pc_out <= ra;
				when JUMP_REGX =>
					pc_out <= reg_a;
				when others =>
					pc_out <= pc_in;
			end case;
		else	-- jump = '0'
			pc_out <= pc_in;
		end if;
	end process;

end Behavioral;

