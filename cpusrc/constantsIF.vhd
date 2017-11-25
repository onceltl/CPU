library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; -- needed?

package constantsIF is
	--IMController's signal
	constant IMRead: std_logic := '0';
	constant IMWrite: std_logic := '1';
	
	constant NOPInstruct: std_logic_vector(15 downto 0) := "0000100000000000";
	
	
	-- zero bits
	constant ZERO16: std_logic_vector(15 downto 0) := "0000000000000000";

	-- for re_sp_or_ih
	constant SP: std_logic := '1';
	constant IH: std_logic := '0';
	
	-- for side road
	constant FORWARD_OLD: std_logic_vector(1 downto 0) := "00";
	constant FORWARD_ALU_EX: std_logic_vector(1 downto 0) := "01";
	constant FORWARD_ALU_MEM: std_logic_vector(1 downto 0) := "10";
	constant FORWARD_MEM: std_logic_vector(1 downto 0) := "11";

end package ; -- constantsIF 
