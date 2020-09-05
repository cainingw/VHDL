library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mips_datapath_proj2a is
generic(gCLK_HPER : time := 50 ns);
end tb_mips_datapath_proj2a;

architecture behavior of tb_mips_datapath_proj2a is
  
component mips_datapath
port(RST : in std_logic;
	CLK : in std_logic;
	output : out std_logic_vector(31 downto 0));
end component;
  
-- Calculate the clock period as twice the half-period
constant cCLK_PER  : time := gCLK_HPER * 2;
  
-- signals we need
signal s_RST, s_CLK : std_logic;
signal s_output : std_logic_vector(31 downto 0);
 
begin

-- create an instance of your final design
DUT : mips_datapath
port map(s_RST, s_CLK);

  -- generating clocks
P_CLK: process
  begin
    s_CLK <= '1';
    wait for gCLK_HPER;
    s_CLK <= '0';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
  
	-- INIT
	s_RST <= '1';
	wait for cCLK_PER;
	
	s_RST <= '0';
	wait for cCLK_PER;
	
    wait; -- wait for forever
  end process;
  
end behavior;