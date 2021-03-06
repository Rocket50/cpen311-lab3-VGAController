library ieee;
use ieee.std_logic_1164.all;

package lineGetterDecs is
  component lineGetter is 
    port(rst : in std_logic;
       slow_clock : in std_logic;
       colour : out std_logic_vector(2 downto 0);
       x0 : out std_logic_vector(7 downto 0); 
       x1 : out std_logic_vector(7 downto 0);
       y0 : out std_logic_vector(6 downto 0);
       y1 : out std_logic_vector(6 downto 0));
  end component; 
end package;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.NbitRegDecs.all;

entity lineGetter is
  port(rst : in std_logic;
       slow_clock : in std_logic;
       colour : out std_logic_vector(2 downto 0);
       x0 : out std_logic_vector(7 downto 0); 
       x1 : out std_logic_vector(7 downto 0);
       y0 : out std_logic_vector(6 downto 0);
       y1 : out std_logic_vector(6 downto 0));
end entity;

architecture impl of lineGetter is
    type GRAY is array (0 to 7) of std_logic_vector(2 downto 0);
  
    constant LUT : GRAY := ("000", "001", "011", "010", "110", "111", "101", "100");
  
  signal nextLine, currLine : std_logic_vector(3 downto 0);
  
  begin
    
    CURRLINER : NbitReg generic map(4, 1) port map(clk => slow_clock, rst => rst, D => nextLine, Q => currLine);
    
    process(all) begin
      if(currLine = 4d"14") then
        nextLine <= 4d"1";
      else
        nextLine <= std_logic_vector(unsigned(currLine) + 1); 
      end if;
    end process;
    
    --colour <= 
    
    x0 <= 8d"0";
    x1 <= 8d"159";
    
    y0 <= currLine & "000";
    y1 <= std_logic_vector(120 - (unsigned(currLine) & "000"));
    
    colour <= LUT(to_integer(unsigned(currLine(2 downto 0))));
    
end impl;

