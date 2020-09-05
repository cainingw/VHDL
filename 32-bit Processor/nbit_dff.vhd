library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_dff is
generic(N : integer);
port(CLK : in std_logic;
    RST : in std_logic;
    WE : in std_logic;
    D : in std_logic_vector(N-1 downto 0);
    Q : out std_logic_vector(N-1 downto 0));
end nbit_dff;

architecture structure of nbit_dff is

component d_flip_flop
port(i_CLK : in std_logic;
	i_RST : in std_logic;
    i_WE : in std_logic;
    i_D : in std_logic;
    o_Q : out std_logic);
end component;

begin

g_dff : for i in 0 to N-1 generate
	i_dff : d_flip_flop
	port MAP(i_CLK => CLK,
			i_RST => RST,
			i_WE => WE,
			i_D => D(i),
			o_Q => Q(i));
end generate;
  
end structure;
