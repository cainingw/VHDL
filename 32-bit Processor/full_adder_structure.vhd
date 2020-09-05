library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_structure is
port(
	i_X : in std_logic;
	i_Y : in std_logic;
	i_Cin : in std_logic;
	o_Cout : out std_logic;
	o_S : out std_logic);
end full_adder_structure;

architecture structure of full_adder_structure is

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

component mips_xor2
port(
	i_A : in std_logic;
    i_B : in std_logic;
    o_F : out std_logic);
end component;

signal xor_XY : std_logic;
signal and_1 : std_logic;
signal and_2 : std_logic;

begin

g_xor1 : mips_xor2
port MAP(
	i_A => i_X,
	i_B => i_Y,
	o_F => xor_XY);
	
g_xor2 : mips_xor2
port MAP(
	i_A => xor_XY,
	i_B => i_Cin,
	o_F => o_S);

g_and1 : mips_and2
port MAP(
	i_A => i_Cin,
	i_B => xor_XY,
	o_F => and_1);
	
g_and2 : mips_and2
port MAP(
	i_A => i_X,
	i_B => i_Y,
	o_F => and_2);

g_or : mips_or2
port MAP(
	i_A => and_1,
	i_B => and_2,
	o_F => o_Cout);
	
end structure;