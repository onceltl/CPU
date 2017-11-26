-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
  use ieee.std_logic_unsigned.all;
  use work.constantsIF.all;

  ENTITY test_pc IS
  END test_pc;

  ARCHITECTURE behavior OF test_pc IS 

  -- Component Declaration
          COMPONENT Test_PC_Jump
			Port (
			clk : in  STD_LOGIC;
			rst : in  STD_LOGIC;
			wr_pc : in  STD_LOGIC;
			if_id_pc : in  STD_LOGIC_VECTOR (15 downto 0);
			jmp : in  STD_LOGIC;
			b_op : in  STD_LOGIC_VECTOR (1 downto 0);
			j_dest : in  STD_LOGIC_VECTOR (1 downto 0);
			b_dest : in  STD_LOGIC_VECTOR (15 downto 0);
			reg_a : in  STD_LOGIC_VECTOR (15 downto 0);
			ra : in  STD_LOGIC_VECTOR (15 downto 0);
			t : in  STD_LOGIC;
	
			jump_dest_out : out  STD_LOGIC_VECTOR (15 downto 0);
			pc_out : out  STD_LOGIC_VECTOR (15 downto 0)
			);
          END COMPONENT;

			signal clk :  STD_LOGIC;
			signal rst :  STD_LOGIC := '1';
			signal wr_pc :  STD_LOGIC := '1';
			signal if_id_pc :  STD_LOGIC_VECTOR (15 downto 0) := ZERO16;
			signal jmp :  STD_LOGIC := '0';
			signal b_op :  STD_LOGIC_VECTOR (1 downto 0) := BRANCH_NONE;
			signal j_dest :  STD_LOGIC_VECTOR (1 downto 0);
			signal b_dest :  STD_LOGIC_VECTOR (15 downto 0) := "0000000000010000";
			signal reg_a :  STD_LOGIC_VECTOR (15 downto 0) := ZERO16 + '1';
			signal ra :  STD_LOGIC_VECTOR (15 downto 0) := ZERO16 - '1';
			signal t :  STD_LOGIC := '1';
	
			signal jump_dest_out :  STD_LOGIC_VECTOR (15 downto 0);
			signal pc_out :  STD_LOGIC_VECTOR (15 downto 0);
          

  BEGIN

  -- Component Instantiation
          uut: Test_PC_Jump PORT MAP(
                  clk => clk,
                  rst => rst,
                  wr_pc => wr_pc,
                  if_id_pc => if_id_pc,
                  jmp => jmp,
                  b_op => b_op,
                  j_dest => j_dest,
                  b_dest => b_dest,
                  reg_a => reg_a,
                  ra => ra,
                  t => t,
                  jump_dest_out => jump_dest_out,
                  pc_out => pc_out
          );


     clock_process : PROCESS
     BEGIN
		clk <= '0';
        wait for 10 ns; -- wait until global set/reset completes
		clk <= '1';
        wait for 10 ns; -- wait until global set/reset completes
     END PROCESS;
		  
  --  Test Bench Statements
     tb : PROCESS
     BEGIN
		rst <= '0';
        wait for 100 ns; -- wait until global set/reset completes
		rst <= '1';
		
		wait for 100 ns;
		jmp <= '1';
		j_dest <= JUMP_BDEST;
		wait for 20 ns;
		jmp <= '0';
		b_op <= BRANCH_RXEQZ;
		wait for 20 ns;
		b_op <= BRANCH_RXNEZ;
		wait for 20 ns;
		b_op <= BRANCH_TEQZ;
		wait for 20 ns;
		t <= '0';
		
		
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
