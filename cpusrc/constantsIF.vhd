library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; -- needed?

package constantsIF is
	--IMController's signal
	constant IMRead: std_logic := '0';
	constant IMWrite: std_logic := '1';
	
	constant NOPInstruct: std_logic_vector(15 downto 0) := "0000100000000000";

end package ; -- constantsIF 
