----------------------------------------------------------------------------------
-- Company: UAlbany
-- Engineer: Logan Mead
-- 
-- Create Date: 02/24/2022 01:34:05 PM
-- Design Name: 
-- Module Name: HW_1test - Behavioral
-- Project Name: Design Expirement 1 
-- Target Devices: 
-- Tool Versions: 
-- Description: tail light system
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
use ieee.std_logic_arith.all;
use IEEE.NUMERIC_STD.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HW1 is
  Port (L : in STD_LOGIC;                   --create variables
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
end HW1;
 
architecture Behavioral of HW1 is
Type state is (S0, S1, S2, S3);              -- declares name type state to identify state
SIGNAL pr_state : state;
SIGNAL nx_state : state;
SIGNAL scan_clk : STD_LOGIC;                --creates signal for a new slow clock

begin

    scan_clk_gen : process (clk) is                         --create clock with a slower speed for board
        variable count : integer range 0 to 15000000;
        begin
            if rising_edge(clk) then  
                if (count = 15000000) then               --sets the slow clock to 1 after so many clock cycles
                    count := 0;
                    scan_clk <= '1';
                else
                    count := count + 1;
                    scan_clk <= '0';
                end if;
             end if;           
     end process;                                   --code from proffesor moulic

    state_control: PROCESS (rst, scan_clk)         --sets previous state to next state on rising edge of slow clock
    begin
        if rising_edge(scan_clk) then
            pr_state <= nx_state;
        end if;
        
     end process state_control;
       
    state_diagram: PROCESS (L, R, pr_state, scan_clk)                            --state diagram 
        begin
        if(scan_clk'event and scan_clk = '1') then                          --runs only on slow clock being one and after being changed
            case pr_state is
                when S0 =>
                    if(L = '0' and R = '0') then nx_state <= S0;            --loop back into go state
                      L1 <= '0';                                            --set all lights off
                      L2 <= '0';
                      L3 <= '0';
                      R1 <= '0';
                      R2 <= '0';
                      R3 <= '0';
                   elsif(L = '0' and R = '1')then nx_state <= S1;           --go to first state
                      L1 <= '0';                                            --set all lights off
                      L2 <= '0';
                      L3 <= '0';
                      R1 <= '0';
                      R2 <= '0';
                      R3 <= '0';
                   elsif(L = '1' and R = '0')then nx_state <= S1;           -- go to first state
                      L1 <= '0';                                            --set all lights off
                      L2 <= '0';
                      L3 <= '0';
                      R1 <= '0';
                      R2 <= '0';
                      R3 <= '0';
                   elsif(L = '1' and R = '1')then nx_state <= S3;           --go to third state
                      L1 <= '1';                                            --set all lights on
                      L2 <= '1';
                      L3 <= '1';
                      R1 <= '1';
                      R2 <= '1';
                      R3 <= '1';
                   else nx_state <= S1;
                   end if;
                   
                when S1 =>
                    if(L = '0' and R = '0') then nx_state <= S0;                --go back to first state
                        L1 <= '0';                                              --set all lights off
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';
                    elsif(L = '0' and R = '1') then nx_state <= S2;            --go to second state
                        L1 <= '0';                                             --set R1 on
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '1';
                        R2 <= '0';
                        R3 <= '0';
                    elsif(L = '1' and R = '0') then nx_state <= S2;            --go to second state
                        L1 <= '1';                                             --set L1 on
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';
                    elsif(L = '1' and R = '1')then nx_state <= S3;             --go to third state
                        L1 <= '1';                                             --set all lights on
                        L2 <= '1';
                        L3 <= '1';
                        R1 <= '1';
                        R2 <= '1';
                        R3 <= '1';    
                    else nx_state <= S2;
                    end if;
                        
                when S2 =>
                    if(L = '0' and R = '0') then nx_state <= S0;               --go back to first state
                        L1 <= '0';                                             --set all lights off
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';               
                    elsif(L = '0' and R = '1') then nx_state <= S3;            --go to third state
                        L1 <= '0';                                             --set R1 and R2 on
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '1';
                        R2 <= '1';
                        R3 <= '0';
                    elsif(L = '1' and R = '0') then nx_state <= S3;             --go to third state
                        L1 <= '1';                                              --set L1 and L2 on
                        L2 <= '1';
                        L3 <= '0';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';
                    elsif(L = '1' and R = '1')then nx_state <= S3;              --go to third state
                        L1 <= '1';                                              --set all lights on
                        L2 <= '1';
                        L3 <= '1';
                        R1 <= '1';
                        R2 <= '1';
                        R3 <= '1';    
                    else nx_state <= S3;
                    end if;    
                
                when S3 =>
                    if(L = '0' and R = '0')then nx_state <= S0;                 --go to first state
                        L1 <= '0';                                              --set all lights off
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';    
                    elsif(L = '0' and R = '1') then nx_state <= S0;            --go to first state 
                        L1 <= '0';                                             --set R1, R2 and R3 on
                        L2 <= '0';
                        L3 <= '0';
                        R1 <= '1';
                        R2 <= '1';
                        R3 <= '1';
                    elsif(L = '1' and R = '0') then nx_state <= S0;             --go to first state
                        L1 <= '1';                                              --set L1, L2 and L3 on
                        L2 <= '1';
                        L3 <= '1';
                        R1 <= '0';
                        R2 <= '0';
                        R3 <= '0';
                    elsif(L = '1' and R = '1') then nx_state <= S3;             --go back to third state
                        L1 <= '1';                                              --set all lights on
                        L2 <= '1';
                        L3 <= '1';
                        R1 <= '1';
                        R2 <= '1';
                        R3 <= '1';   
                    else nx_state <= S0;
                    end if;    
             
        end case;
        end if;
        end process state_diagram;    
   
end Behavioral; 
