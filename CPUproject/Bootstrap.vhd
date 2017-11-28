----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:50:29 11/26/2017 
-- Design Name: 
-- Module Name:    Bootstrap - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bootstrap is
port(
		--ʱ��
		clk : in std_logic;
		rst : in std_logic;
		
		
		ram2_addr : out std_logic_vector(17 downto 0); 	--RAM2��ַ����
		ram2_data : inout std_logic_vector(15 downto 0);--RAM2��������
		
		--ram2AddrOutput : out std_logic_vector(17 downto 0);
		
		ram2_en : out std_logic;		--RAM2ʹ�ܣ�='1'��ֹ����Զ����'0'
		ram2_oe : out std_logic;		--RAM2��ʹ�ܣ�='1'��ֹ
		ram2_we : out std_logic;		--RAM2дʹ�ܣ�='1'��ֹ
		
		--FlashStateOut : out std_logic_vector(2 downto 0); --������Ϣ
		
		flash_finished : out std_logic := '0';
		
		--Flash
		flash_addr : out std_logic_vector(22 downto 0);		--flash��ַ��
		flash_data : inout std_logic_vector(15 downto 0);	--flash������
		
		flash_byte : out std_logic := '1';	--flash����ģʽ������'1'
		flash_vpen : out std_logic := '1';	--flashд����������'1'
		flash_rp : out std_logic := '1';		--'1'��ʾflash����������'1'
		flash_ce : out std_logic := '0';		--flashʹ��
		flash_oe : out std_logic := '1';		--flash��ʹ�ܣ�'0'��Ч��ÿ�ζ���������'1'
		flash_we : out std_logic := '1'		--flashдʹ��
		
	);
end Bootstrap;

architecture Behavioral of Bootstrap is

signal local_flash_finished : std_logic := '0';
--type FLASH_STATE is (STATE1, STATE2, STATE3, STATE4, STATE5, STATE6);
--signal flashstate : FLASH_STATE := STATE1;	--��flash����ָ�ram2��״̬
signal flashstate : std_logic_vector(2 downto 0) := "001";
signal current_addr : std_logic_vector(15 downto 0) := (others => '0');	--flash��ǰҪ���ĵ�ַ
shared variable cnt : integer := 0;	--��������50Mʱ��Ƶ����1M
	
begin
	
	process(clk, rst)
	begin
	
		if (rst = '0') then
			ram2_en <= '0';
			ram2_oe <= '1';
			ram2_we <= '1';
			ram2_addr <= (others => '0'); --�ɲ�Ҫ����
			flashstate <= "001";
			local_flash_finished <= '0';
			--flash_finished <= '0';
			current_addr <= (others => '0');
			
		elsif (clk'event and clk = '1') then 
			if (local_flash_finished = '1') then			--��flash����kernelָ�ram2�����
				flash_byte <= '1';
				flash_vpen <= '1';
				flash_rp <= '1';
				flash_ce <= '1';	--��ֹflash
				
			else				--��flash����kernelָ�ram2��δ��ɣ����������
				if (cnt = 1000) then --��������ʱ��Ƶ������Ӧflash��д
					cnt := 0;
					
					case flashstate is
						
						when "001" =>		--WE��0
							ram2_en <= '0';
							ram2_we <= '1';--??????ԭ����0��Ϊʲô��
							ram2_oe <= '1';
							flash_we <= '0';
							flash_oe <= '1';
							
							flash_byte <= '1';
							flash_vpen <= '1';
							flash_rp <= '1';
							flash_ce <= '0';
							
							flashstate <= "010";
							
						when "010" =>
							flash_data <= x"00FF";
							flashstate <= "011";
							
						when "011" =>
							flash_we <= '1';
							flashstate <= "100";
							
						when "100" =>
							flash_addr <= "000000" & current_addr & '0';
							flash_data <= (others => 'Z');
							flash_oe <= '0';
							flashstate <= "101";
							
						when "101" =>
							flash_oe <= '1';
							ram2_we <= '0';
							ram2_addr <= "00" & current_addr;
							--ram2AddrOutput <= "00" & current_addr;	--����
							ram2_data <= flash_data;
							flashstate <= "110";
						
						when "110" =>
							ram2_we <= '1';
							current_addr <= current_addr + "1";
							flashstate <= "001";
						
							
						when others =>
							flashstate <= "001";
						
					end case;
					
					if (current_addr > x"0249") then --Ӧ��Ϊʵ��ָ������
						local_flash_finished <= '1';
					end if;
				else 
					if (cnt < 1000) then
						cnt := cnt + 1;
					end if;
				end if;	--cnt 
				
			end if;	--flash finished or not
			
		end if;	--rst/clk_raise
		
	end process;
	
	flash_finished <= local_flash_finished;
	--FlashStateOut <= flashstate;

end Behavioral;

