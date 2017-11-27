--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : xaw2vhdl
--  /   /         Filename : clkGenerator.vhd
-- /___/   /\     Timestamp : 11/27/2017 18:19:05
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: xaw2vhdl-intstyle D:/XilinxWorkspace/CPUThinPad/CPU/CPUproject/ipcore_dir/clkGenerator.xaw -st clkGenerator.vhd
--Design Name: clkGenerator
--Device: xc3s1200e-4fg320
--
-- Module clkGenerator
-- Generated by Xilinx Architecture Wizard
-- Written for synthesis tool: XST
-- Period Jitter (unit interval) for block DCM_SP_INST = 0.02 UI
-- Period Jitter (Peak-to-Peak) for block DCM_SP_INST = 1.80 ns

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity clkGenerator is
   port ( CE_IN           : in    std_logic; 
          CLKIN_IN        : in    std_logic; 
          CLR_IN          : in    std_logic; 
          PRE_IN          : in    std_logic; 
          RST_IN          : in    std_logic; 
          CLKDV_OUT       : out   std_logic; 
          CLKIN_IBUFG_OUT : out   std_logic; 
          CLK0_OUT        : out   std_logic; 
          DDR_CLK0_OUT    : out   std_logic; 
          LOCKED_OUT      : out   std_logic);
end clkGenerator;

architecture BEHAVIORAL of clkGenerator is
   signal CLKDV_BUF       : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal CLK0_INV_IN     : std_logic;
   signal C0_IN           : std_logic;
   signal GND_BIT         : std_logic;
   signal VCC_BIT         : std_logic;
begin
   GND_BIT <= '0';
   VCC_BIT <= '1';
   CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
   CLK0_OUT <= C0_IN;
   CLKDV_BUFG_INST : BUFG
      port map (I=>CLKDV_BUF,
                O=>CLKDV_OUT);
   
   CLKIN_IBUFG_INST : IBUFG
      port map (I=>CLKIN_IN,
                O=>CLKIN_IBUFG);
   
   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>C0_IN);
   
   DCM_SP_INST : DCM_SP
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => 2.0,
            CLKFX_DIVIDE => 8,
            CLKFX_MULTIPLY => 2,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 20.000,
            CLKOUT_PHASE_SHIFT => "NONE",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"C080",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE)
      port map (CLKFB=>C0_IN,
                CLKIN=>CLKIN_IBUFG,
                DSSEN=>GND_BIT,
                PSCLK=>GND_BIT,
                PSEN=>GND_BIT,
                PSINCDEC=>GND_BIT,
                RST=>RST_IN,
                CLKDV=>CLKDV_BUF,
                CLKFX=>open,
                CLKFX180=>open,
                CLK0=>CLK0_BUF,
                CLK2X=>open,
                CLK2X180=>open,
                CLK90=>open,
                CLK180=>open,
                CLK270=>open,
                LOCKED=>LOCKED_OUT,
                PSDONE=>open,
                STATUS=>open);
   
   INV_INST : INV
      port map (I=>C0_IN,
                O=>CLK0_INV_IN);
   
   OFDDRCPE_INST : OFDDRCPE
      port map (CE=>CE_IN,
                CLR=>CLR_IN,
                C0=>C0_IN,
                C1=>CLK0_INV_IN,
                D0=>VCC_BIT,
                D1=>GND_BIT,
                PRE=>PRE_IN,
                Q=>DDR_CLK0_OUT);
   
end BEHAVIORAL;


