library IEEE;
use IEEE.std_logic_1164.all;

entity mux_structure is
port(
	i_C : in std_logic;
	i_D : in std_logic;
	i_S : in std_logic;
	o_S : out std_logic);
end mux_structure;

architecture structure of mux_structure is

component mips_inv
port(
	i_A : in std_logic;
    o_F : out std_logic);
end component;

component mips_and2
port(
	i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;

component mips_or2
port(
	i_A : in std_logic;
    i_B : in std_logic;
	o_F : out std_logic);
end component;

signal not_S : std_logic;
signal and_C : std_logic;
signal and_D : std_logic;

begin

g_inv : mips_inv
port MAP(
	i_A => i_S,
	o_F => not_S);
	
g_and1 : mips_and2
port MAP(
	i_A => i_C,
	i_B => not_S,
	o_F => and_C);
	
g_and2 : mips_and2
port MAP(
	i_A => i_D,
	i_B => i_S,
	o_F => and_D);

g_or : mips_or2
port MAP(
	i_A => and_C,
	i_B => and_D,
	o_F => o_S);
	
end structure;