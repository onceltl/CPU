
-- VHDL Instantiation Created from source file clkGenerator.vhd -- 18:19:07 11/27/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT clkGenerator
	PORT(
		CE_IN : IN std_logic;
		CLKIN_IN : IN std_logic;
		CLR_IN : IN std_logic;
		PRE_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKDV_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		DDR_CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;

	Inst_clkGenerator: clkGenerator PORT MAP(
		CE_IN => ,
		CLKIN_IN => ,
		CLR_IN => ,
		PRE_IN => ,
		RST_IN => ,
		CLKDV_OUT => ,
		CLKIN_IBUFG_OUT => ,
		CLK0_OUT => ,
		DDR_CLK0_OUT => ,
		LOCKED_OUT => 
	);


