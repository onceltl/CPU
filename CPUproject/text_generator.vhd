----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:55:37 11/21/2017 
-- Design Name: 
-- Module Name:    text_generator - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_arith.all;  
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY text_generator IS
  PORT(
    clk_write        :  IN   STD_LOGIC;--write
	 rst              :  IN   STD_LOGIC;
    display_enable   :  IN   STD_LOGIC;  --display enable ('1' = display time, '0' = blanking time)
    row              :  IN   INTEGER;    --row pixel coordinate,0 to 480-1.
    column           :  IN   INTEGER;    --column pixel coordinate,0 to 640-1.
	 write_enable 	   :  IN   STD_LOGIC;
	 write_char       :  IN STD_LOGIC_VECTOR(7 downto 0);
    red              :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
    green            :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
    blue             :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END text_generator;

ARCHITECTURE behavior OF text_generator IS
  
  component font_rom 
   port(
      addr: in std_logic_vector(10 downto 0);
      data: out std_logic_vector(0 to 7)
   );
  end component;
  
  COMPONENT command_rom IS
   port(
      clk_write         : in std_logic;
      com_write_addr    : in std_logic_vector(11 downto 0);
      com_write_nable   : in std_logic;
      char_write_value  : in std_logic_vector(7 downto 0);
		
		com_read_addr     : in std_logic_vector(11 downto 0);
      char_read_value   : out std_logic_vector(7 downto 0)
	);
  END component;
	 SIGNAL offset,nxtoffset:STD_LOGIC_VECTOR(4 downto 0):="00000";
	 SIGNAL nowR,nxtR,readR: STD_LOGIC_VECTOR(4 downto 0);
    SIGNAL nowC,nxtC,readC: STD_LOGIC_VECTOR(6 downto 0);
	 SIGNAL com_write_nable:STD_LOGIC;
	 SIGNAL font_bit : STD_LOGIC;
	 SIGNAL font_word: std_logic_vector(0 to 7);
	 SIGNAL font_rom_addr:std_logic_vector(10 downto 0);
	 SIGNAL com_write_addr:std_logic_vector(11 downto 0);
	 SIGNAL com_read_addr:std_logic_vector(11 downto 0);
	 SIGNAL char_read_value:std_logic_vector(7 downto 0);
	 SIGNAL char_ascii:std_logic_vector(6 downto 0);
	 SIGNAL pixel_y:std_logic_vector(9 downto 0);
	 SIGNAL pixel_x:std_logic_vector(8 downto 0);
	 SIGNAL offset_enable,nxtoffset_enable:std_logic;
	 SIGNAL com_write_char:std_logic_vector(7 downto 0);
	 SIGNAL count_Cursor,nxtcount_Cursor:INTEGER range 0 to 25000000;--counter for display.
	 SIGNAL display_Cursor,nxtdisplay_Cursor:std_logic;--display or not
	 SIGNAL Cursor_write_enable:std_logic;
	 
   constant STOP_ADDR_WIDTH: integer := 5; --12=5+7; 2^5 rows ; 2^7 column
   constant STOP_WIDTH: integer := 7;  -- 8 bits per character; 2-bit-hex
   type stop_type is array (0 to 2**STOP_ADDR_WIDTH-1) of std_logic_vector(STOP_WIDTH-1 downto 0);
   
	-- memory signal 8*16
	
   signal stop : stop_type := (
		"1111111","1111111","1111111","1111111","1111111","1111111","1111111","1111111",
		
		"1111111","1111111","1111111","1111111","1111111","1111111","1111111","1111111",
		
		"1111111","1111111","1111111","1111111","1111111","1111111","1111111","1111111",
		
		"1111111","1111111","1111111","1111111","1111111","1111111","1111111","1111111"
	);
BEGIN

	 font_unit: font_rom
	 port map(
		 addr => font_rom_addr,
		 data => font_word
	 );
	 
	 com_ram : command_rom
	 port map(
		clk_write        => clk_write,
      com_write_addr   => com_write_addr,
      com_write_nable  => com_write_nable,
      char_write_value => com_write_char,
      com_read_addr    => com_read_addr,
      char_read_value  => char_read_value
	 );
	 
	  char_ascii <= char_read_value(6 downto 0);
	  font_rom_addr <= char_ascii & pixel_x(3 downto 0);--7+4
	  font_bit <= font_word(conv_integer(pixel_y(2 downto 0)));
	 
		
	  com_write_nable <= (write_enable or Cursor_write_enable);
	  com_write_addr <=nowR & nowC;
	  -- from rom and video_ram to get font bit for multiplexing 
	  
	  process(row,column,offset,pixel_x,pixel_y,readC,readR,stop)
	  begin
	    pixel_x(8 downto 0) <= conv_std_logic_vector(row, 9);
	    pixel_y(9 downto 0) <= conv_std_logic_vector(column, 10);
	    readR <= pixel_x(8 downto 4)+offset;--/16
	    readC <= pixel_y(9 downto 3);--/8
		 if (readC >=stop(conv_integer(readR))) then
		   com_read_addr <= "000001111111";
		 else
			com_read_addr <= readR & readC;
		 end if;
	  end process;
	 
    -- rgb multiplexing
	 process(display_enable, font_bit)
	 begin
	    if display_enable = '0' then 
			red <= (OTHERS => '0');
         green <= (OTHERS => '0');
         blue <= (OTHERS => '0');
		 elsif font_bit = '1' then
			red <= (OTHERS => '1');
         green <= (OTHERS => '1');
         blue <= (OTHERS => '1');
		 else
			red <= (OTHERS => '0');
         green <= (OTHERS => '0');
         blue <= (OTHERS => '0');
		 end if;
	 end process;
	 
	 
	 
	 --Cursor & Write
	 process (clk_write, rst) 
	 begin 
		if (rst = '0') then 
			nowR <= "01010";
			nowC <= "0000000";
			offset <= "00000";
			offset_enable <= '0';
			count_Cursor <= 0;
			display_Cursor <= '0';
		else
			if (rising_edge(clk_write)) then 
				nowR <= nxtR;
				nowC <= nxtC;
				offset <= nxtoffset;
				offset_enable <= nxtoffset_enable;
				count_Cursor <= nxtcount_Cursor;
				display_Cursor <= nxtdisplay_Cursor;
				if (write_enable = '1' and ((write_char = "00001101") or (write_char = "00001010"))) then
					stop(conv_integer(nxtR))<=nxtC;
				else 
					stop(conv_integer(nxtR))<=nxtC+"0000001";
				end if;
			end if;
		end if;
	 end process;
	  
	process(write_enable,count_Cursor,nowR,nowC,offset,offset_enable,display_Cursor,write_char) 
	begin 
		nxtR <= nowR ;
		nxtC <= nowC ;
		nxtoffset <= offset;
		nxtoffset_enable<=offset_enable;
		com_write_char<="00000000";
		
		nxtcount_Cursor <= count_Cursor + 1;
		nxtdisplay_Cursor <= display_Cursor;
		Cursor_write_enable <= '0';
			
		if (write_enable = '1') then 
			nxtcount_Cursor <= 0;
			nxtdisplay_Cursor <= '1';
			Cursor_write_enable<='0';
			if (write_char = "00001000") then  -- backspace
				com_write_char<="00000000";
				if (nowC = "0000000") then  -- start of line
					nxtC <= "0000000";
				else 
					nxtC <= nowC - "0000001";
				end if;
			elsif (write_char = "00001101") or (write_char = "00001010") then -- \r or \n
				nxtC <= "0000000";
				nxtR <= nowR+"00001";
				com_write_char<="00000000";
				if (offset_enable = '1') then
					nxtoffset <= offset+"00001";				
				end if;
				if (nowR = "11101") and (offset_enable = '0') then  -- at 31 queue tail.
					nxtoffset <= offset+"00001";
					nxtoffset_enable <= '1';
				end if;
				
			elsif (nowC = "1000000") then --at end of column  
				nxtC <= "1000000";
				com_write_char <= write_char;
			else 
				nxtC <= nowC + "0000001";
				com_write_char <= write_char;
			end if;
		elsif (count_Cursor= 2) then 
			nxtcount_Cursor <= 0;
			nxtdisplay_Cursor <= not display_Cursor;
			Cursor_write_enable <= '1';
         if (display_Cursor = '0') then 
			    com_write_char <= "00000000";
			else
				 com_write_char <= "00000001";
			end if;
		end if;
		
	end process;
	
END behavior;
