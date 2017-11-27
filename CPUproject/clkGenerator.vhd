----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:38 11/27/2017 
-- Design Name: 
-- Module Name:    clkGenerator - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clkGenerator is
PORT(
	rst: in std_logic;
	clk: in std_logic; --¿ª¹ØÐÅºÅ
	clk1x: out std_logic;
	clk2x: out std_logic
);
end clkGenerator;

architecture Behavioral of clkGenerator is
signal myClk: std_logic;
signal clk50MMask: std_logic;
signal clk25MMask: std_logic;
signal clk11MMask: std_logic;
signal myClkMask: std_logic;
signal waitClock: integer;
signal clk25M: std_logic;
signal clk17M: std_logic;
signal clk6M: std_logic;
signal clk6Mcount: std_logic_vector(1 downto 0);
signal tmp: std_logic;
begin
with sel select
					
	process (rst, clk)
	begin
		if rst = '0' then
			clk25M <= '1';
			clk17M <= '1';
			clk6M <= '1';
			clk6Mcount <= "00";
		elsif clk50M'event and clk50M = '0' then
			clk25M <= not clk25M;
			tmp <= clk17M;
			if clk17M = '1' then
				clk17M <= '0';
			elsif tmp = '0' then
				clk17M <= '1';
			end if;
			clk6Mcount <= clk6Mcount + 1;
			if clk6Mcount = "11" then
				clk6M <= not clk6M;
			end if;
		end if;
	end process;
	
	process (rst, clk11M)
	begin
		if rst = '0' then
			waitClock <= 0;
			myClk <= '0';
		elsif clk11M'event and clk11M = '0' then
			if sel = "11" then
				clk11MMask <= '1';
				myClkMask <= '0';
				myClk <= '0';
				waitClock <= 0;
			else
				clk11MMask <= '0';
				myClkMask <= '1';
			end if;
			waitClock <= waitClock + 1;
			if waitClock = 199999 then
				myClk <= '1';
			elsif waitClock = 399999 then
				myClk <= '0';
				waitClock <= 0;
			end if;
		end if;
	end process;

end Behavioral;

