library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.scrn_clearerDecs.all;
use work.VGA_controllerFSMdecs.all;

entity lab3_top is
  port(KEY : in std_logic_vector(3 downto 0);
       CLOCK_50: in std_logic;
       SW : in std_logic_vector(17 downto 0);
       LEDG : out std_logic_vector(7 downto 0);
       LEDR : out std_logic_vector(17 downto 0);
       VGA_R, VGA_G, VGA_B : out std_logic_vector(9 downto 0);
       VGA_HS              : out std_logic;
       VGA_VS              : out std_logic;
       VGA_BLANK           : out std_logic;
       VGA_SYNC            : out std_logic;
       VGA_CLK             : out std_logic;
       HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out std_logic_vector(7 downto 0));
end entity; 

architecture impl of lab3_top is
  
  component vga_adapter  ---- Component from the Verilog file: vga_adapter.v
    generic(RESOLUTION : string);
    port (
      resetn                                       : in  std_logic;
      clock                                        : in  std_logic;
      colour                                       : in  std_logic_vector(2 downto 0);
      x                                            : in  std_logic_vector(7 downto 0);
      y                                            : in  std_logic_vector(6 downto 0);
      plot                                         : in  std_logic;
      VGA_R, VGA_G, VGA_B                          : out std_logic_vector(9 downto 0);
      VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK : out std_logic);
  end component;

  signal x      : std_logic_vector(7 downto 0);
  signal y      : std_logic_vector(6 downto 0);
  signal colour : std_logic_vector(2 downto 0);
  signal plot   : std_logic;
  signal slow_clockLED: std_logic;
  
  begin
    FSM : VGA_controllerFSM port map(CLOCK_50 => CLOCK_50, slow_clockLED => slow_clockLED, rst => not KEY(3), x => x, y => y, colour => colour, plot => plot, colourSel => SW(0));
    vga_u0 : vga_adapter
    generic map(
      RESOLUTION => "160x120"
      )  ---- Sets the resolution of display (as per vga_adapter.v description)
    port map(
      resetn    => KEY(0),
      clock     => CLOCK_50,
      colour    => colour,
      x         => x,
      y         => y,
      plot      => plot,
      VGA_R     => VGA_R,
      VGA_G     => VGA_G,
      VGA_B     => VGA_B,
      VGA_HS    => VGA_HS,
      VGA_VS    => VGA_VS,
      VGA_BLANK => VGA_BLANK,
      VGA_SYNC  => VGA_SYNC,
      VGA_CLK   => VGA_CLK
      );
    
    LEDG <= (0 => slow_clockLED, others => '0');
    LEDR <= (others => '0');
    
    HEX0 <= (others => '1'); 
    HEX1 <= (others => '1'); 
    HEX2 <= (others => '1'); 
    HEX3 <= (others => '1'); 
    HEX4 <= (others => '1');
    HEX5 <= (others => '1'); 
    HEX6 <= (others => '1');
    HEX7 <= (others => '1');

    
    
    
end impl; 