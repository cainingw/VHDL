library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_mux_structure is
generic(N : integer);
port(i_C : in std_logic_vector(N-1 downto 0);
	i_D : in std_logic_vector(N-1 downto 0);
	i_S : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end nbit_mux_structure;

architecture structure of nbit_mux_structure is

component mips_inv
port(i_A : in std_logic;
    o_F : out std_logic);
end component;

component mips_and2
port(i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;

component mips_or2
port(i_A : in std_logic;
    i_B : in std_logic;
	o_F : out std_logic);
end component;

signal not_S : std_logic;
signal and_C : std_logic_vector(N-1 downto 0);
signal and_D : std_logic_vector(N-1 downto 0);

begin

g_inv : mips_inv
port MAP(i_A => i_S,
		o_F => not_S);

g_and1 : for i in 0 to N-1 generate	
	and1_i : mips_and2
	port MAP(i_A => i_C(i),
			i_B => not_S,
			o_F => and_C(i));
end generate;

g_and2 : for i in 0 to N-1 generate	
	and2_i : mips_and2
	port MAP(i_A => i_D(i),
			i_B => i_S,
			o_F => and_D(i));
end generate;

g_or : for i in 0 to N-1 generate	
	or_i : mips_or2
	port MAP(i_A => and_C(i),
			i_B => and_D(i),
			o_F => o_S(i));
end generate;
	
end structure;