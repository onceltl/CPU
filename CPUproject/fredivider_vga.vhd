----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:11 11/21/2017 
-- Design Name: 
-- Module Name:    fredivider_vga - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freDivider_vga is
  port(
    clkin:in STD_LOGIC;
    clkout:out STD_LOGIC
  );
end freDivider_vga;

architecture behavioral of freDivider_vga is
  signal q:STD_LOGIC:='0';
begin 
  process(clkin)
  begin
    if rising_edge(clkin) then
        q<=not q;
    end if;
    clkout<=q;
  end process;  
end behavioral;

