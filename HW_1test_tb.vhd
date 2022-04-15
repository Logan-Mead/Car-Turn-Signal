-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity HW1_tb is
end;

architecture bench of HW1_tb is

  component HW1
    Port (L : in STD_LOGIC;                         --create ports
          R : in STD_LOGIC;
          L1 : out STD_LOGIC;
          L2 : out STD_LOGIC;
          L3 : out STD_LOGIC;
          R1 : out STD_LOGIC;
          R2 : out STD_LOGIC;
          R3 : out STD_LOGIC;
          clk : in STD_LOGIC;
          rst : in STD_LOGIC := '0'
          );
  end component;

  signal L: STD_LOGIC;                              --set signals to inputs and outputs
  signal R: STD_LOGIC;
  signal L1: STD_LOGIC;
  signal L2: STD_LOGIC;
  signal L3: STD_LOGIC;
  signal R1: STD_LOGIC;
  signal R2: STD_LOGIC;
  signal R3: STD_LOGIC; 
  signal clk: STD_LOGIC;
  signal rst: STD_LOGIC := '0';

  constant clock_period: time := 20 ns;
  signal stop_the_clock: boolean;
begin
  uut: HW1 port map ( L     => L,                   --set port maping
                      R     => R,
                      L1    => L1,
                      L2    => L2,
                      L3    => L3,
                      R1    => R1,
                      R2    => R2,
                      R3    => R3,
                      clk   => clk,
                      rst   => rst);
  stimulus: process
  begin
    --set L and R and wait for 80 ns
        L <= '0';
        R <= '0';
        wait for 80ns;
        
        L <= '0';
        R <= '1';
        wait for 80ns;
        
        L <= '1';
        R <= '0';
        wait for 80ns;
        
        L <= '1';
        R <= '1';
        wait for 80ns;
    stop_the_clock <= true;
    wait;
  end process;
  clocking: process                                     --clock process that ticks every half period
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
end;
  