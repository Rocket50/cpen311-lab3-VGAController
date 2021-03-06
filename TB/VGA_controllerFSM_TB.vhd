library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_controllerFSMdecs.all;

entity VGA_controllerFSM_TB is
end entity;

architecture impl of VGA_controllerFSM_TB is
  
  signal CLOCK_50 : std_logic := '0';
  signal rst : std_logic := '0';
  signal x : std_logic_vector(7 downto 0);
  signal y : std_logic_vector(6 downto 0);
  signal colour: std_logic_vector(2 downto 0);
  signal plot : std_logic;
  
  
  begin
    
    DUT : VGA_controllerFSM port map(CLOCK_50 => CLOCK_50, rst => rst, x => x, y => y, colour => colour, plot => plot);
      
    
    process begin
      wait for 5 ps;
      rst <= '1'; 
  
      for I in 0 to 100000 loop
        wait for 10 ps;
        
        rst <= '0';
        
        CLOCK_50 <= not CLOCK_50;
        
        
      end loop;
      
      wait; 
    end process; 
end impl; 