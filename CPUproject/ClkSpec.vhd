----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:50:28 11/28/2017 
-- Design Name: 
-- Module Name:    ClkSpec - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constantsIF.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ClkSpec is
	Port ( 
			rst : in std_logic;
			clk : in  std_logic;
		   
			clk_spec : out std_logic;
			clk_spec2 : out std_logic;
			clk_out : out std_logic
			 );
end ClkSpec;

architecture Behavioral of ClkSpec is
signal count : std_logic_vector(2 downto 0) := "000";
begin
	process (clk, rst, count)
	begin
		if (rst = '0') then
			clk_spec <= '0';
			clk_out <= '0';
			count <= "000";
		elsif (clk'event and clk='1') then			
			case count is
				when "000" =>
					clk_spec <= '1';
					clk_out <= '1';
					count <= "001";
				when "001" =>
					clk_spec <= '0';
					clk_out <= '1';
					count <= "010";
				when "010" =>
					clk_spec <= '0';
					clk_out <= '1';
					count <= "011";
				when "011" =>
					clk_spec <= '0';
					clk_out <= '0';
					count <= "100";
				when "100" =>
					clk_spec <= '0';
					clk_out <= '0';
					count <= "101";
				when "101" =>
					clk_spec <= '1';
					clk_out <= '0';
					count <= "000";
				when others =>
					clk_spec <= '0';
					clk_out <= '0';
					count <= "000";
			end case;
		end if;

	end process;

end Behavioral;

