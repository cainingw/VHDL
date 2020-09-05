library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_full_adder_structure is
generic(N : integer);
port(i_A : in std_logic_vector(N-1 downto 0);
	i_B : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
	Cout : out std_logic;
	CoutPrev : out std_logic;
	o_F : out std_logic_vector(N-1 downto 0));
end nbit_full_adder_structure;

architecture structure of nbit_full_adder_structure is

component full_adder_structure
port(
	i_X : in std_logic;
	i_Y : in std_logic;
	i_Cin : in std_logic;
	o_Cout : out std_logic;
	o_S : out std_logic);
end component;

signal carry : std_logic_vector(N downto 0);

begin

carry(0) <= Cin;

g_full_adder : for i in 0 to N-1 generate
	full_adder_i : full_adder_structure
		port MAP(i_X => i_A(i),
				i_Y => i_B(i),
				i_Cin => carry(i),
				o_Cout => carry(i+1),
				o_S => o_F(i));
end generate;

Cout <= carry(N);
CoutPrev <= carry(N-1);
	
end structure;