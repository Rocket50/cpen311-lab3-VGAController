library ieee;
use ieee.std_logic_1164.all;
use work.line_drawerDecs.all;
use ieee.numeric_std.all;

entity line_drawerTB is
end line_drawerTB;

architecture impl of line_drawerTB is 
  
  signal CLOCK_50 : std_logic := '0';
  signal run : std_logic;
  signal rst : std_logic;
  signal x : std_logic_vector(7 downto 0);
  signal y : std_logic_vector(6 downto 0); 
       
  signal x0 : std_logic_vector(7 downto 0); 
  signal x1 : std_logic_vector(7 downto 0);
  signal y0 : std_logic_vector(6 downto 0);
  signal y1 : std_logic_vector(6 downto 0);
       
  signal plot : std_logic;
  signal done : std_logic;  
  
  begin
    
    DUT : line_drawer port map(CLOCK_50 => CLOCK_50, run => run, rst => rst, x=>x, y=>y, x0 => x0, x1 => x1,
                               y0 => y0, y1 => y1, plot => plot, done => done);
    process begin
      
      rst <= '1';
      
      wait for 5 ps; 
      
      rst <= '0'; 
      
      wait for 5 ps;
      
      run <= '0'; 
      x0 <= 8d"0";
      x1 <= 8d"159";
      
      y0 <= 7d"8";
      y1 <= 7d"112";
    
      
      wait for 5 ps;
      
      run <= '1'; 
      
      while(done = '0') loop
        
        CLOCK_50 <= not CLOCK_50;
        wait for 10 ps;
      end loop; 
      
      
      wait;
    end process;
end impl; 