library IEEE;
use IEEE.std_logic_1164.all;

entity d_flip_flop is
port(i_CLK: in std_logic;
    i_RST : in std_logic;
    i_WE: in std_logic;
    i_D : in std_logic;
    o_Q : out std_logic);
end d_flip_flop;

architecture mixed of d_flip_flop is

signal s_D : std_logic;
signal s_Q : std_logic;

begin

o_Q <= s_Q;
  
with i_WE select s_D <=
	i_D when '1',
    s_Q when others;
  
process (i_CLK, i_RST)
begin
    if (i_RST = '1') then
		s_Q <= '0';
    elsif (rising_edge(i_CLK)) then
		s_Q <= s_D;
    end if;
end process;
  
end mixed;