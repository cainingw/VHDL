library ieee;
use ieee.std_logic_1164.all;

entity barrel_shifter is
port(shift_amount : in std_logic_vector(4 downto 0);
	dir : in std_logic;
	ari : in std_logic;
	input : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0));
end barrel_shifter;

architecture structure of barrel_shifter is

component mux_structure
port(i_C : in std_logic;
	i_D : in std_logic;
	i_S : in std_logic;
	o_S : out std_logic);
end component;

signal mux_in : std_logic_vector(31 downto 0);
signal mux1_out : std_logic_vector(31 downto 0);
signal mux2_out : std_logic_vector(31 downto 0);
signal mux3_out : std_logic_vector(31 downto 0);
signal mux4_out : std_logic_vector(31 downto 0);
signal mux5_out : std_logic_vector(31 downto 0);
signal mux_out : std_logic_vector(31 downto 0);

begin

g_reverse : for i in 0 to 31 generate
	reverse_i : mux_structure
	port MAP(i_C => input(i), 
			i_D => input(31-i),
			i_S => dir,
			o_S => mux_in(i));
end generate;

g_mux1 : for i in 0 to 30 generate
	mux1_i : mux_structure
	port MAP(i_C => mux_in(i), 
			i_D => mux_in(i+1),
			i_S => shift_amount(0),
			o_S => mux1_out(i));
end generate;

mux1_out(31) <= (not(shift_amount(0)) and mux_in(31)) or (ari and mux_in(31));

g_mux2 : for i in 0 to 29 generate	
	mux2_i : mux_structure
	port MAP(i_C => mux1_out(i), 
			i_D => mux1_out(i+2),
			i_S => shift_amount(1),
			o_S => mux2_out(i));
end generate;

g_loop1 : for i in 30 to 31 generate
	mux2_out(i) <= (not(shift_amount(1)) and mux1_out(i)) or (ari and mux_in(31));
end generate;

g_mux3 : for i in 0 to 27 generate	
	mux3_i : mux_structure
	port MAP(i_C => mux2_out(i), 
			i_D => mux2_out(i+4),
			i_S => shift_amount(2),
			o_S => mux3_out(i));
end generate;

g_loop2 : for i in 28 to 31 generate
	mux3_out(i) <= (not(shift_amount(2)) and mux2_out(i)) or (ari and mux_in(31));
end generate;

g_mux4 : for i in 0 to 23 generate	
	mux4_i : mux_structure
	port MAP(i_C => mux3_out(i), 
			i_D => mux3_out(i+8),
			i_S => shift_amount(3),
			o_S => mux4_out(i));
end generate;

g_loop3 : for i in 24 to 31 generate
	mux4_out(i) <= (not(shift_amount(3)) and mux3_out(i)) or (ari and mux_in(31));
end generate;

g_mux5 : for i in 0 to 15 generate	
	mux5_i : mux_structure
	port MAP(i_C => mux4_out(i), 
			i_D => mux4_out(i+16),
			i_S => shift_amount(4),
			o_S => mux5_out(i));
end generate;

g_loop4 : for i in 16 to 31 generate
	mux5_out(i) <= (not(shift_amount(4)) and mux4_out(i)) or (ari and mux_in(31));
end generate;

g_unreverse : for i in 0 to 31 generate
	unreverse_i : mux_structure
	port MAP(i_C => mux5_out(i), 
			i_D => mux5_out(31-i),
			i_S => dir,
			o_S => mux_out(i));
end generate;

output <= mux_out;

end structure;