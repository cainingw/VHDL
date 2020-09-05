library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_add_sub is
generic(N : integer);
port(arg1 : in std_logic_vector(N-1 downto 0);
	arg2 : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	carry_out : out std_logic;
	overflow : out std_logic;
	sol : out std_logic_vector(N-1 downto 0));
end nbit_add_sub;

architecture structure of nbit_add_sub is

component ones_structure
generic(N : integer := 32);
port(i_S : in std_logic_vector(N-1 downto 0);
	o_S : out std_logic_vector(N-1 downto 0));
end component;

component nbit_mux_structure
generic(N : integer := 32);
port(i_C : in std_logic_vector(N-1 downto 0);
	i_D : in std_logic_vector(N-1 downto 0);
	i_S : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end component;

component nbit_full_adder_structure
generic(N : integer := 32);
port(i_A : in std_logic_vector(N-1 downto 0);
	i_B : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
	Cout : out std_logic;
	CoutPrev : out std_logic;
	o_F : out std_logic_vector(N-1 downto 0));
end component;

signal inv_arg2 : std_logic_vector(N-1 downto 0);
signal temp : std_logic_vector(N-1 downto 0);
signal carry_out_in : std_logic;
signal carry_out_prev : std_logic;

begin

g_ones : ones_structure
port MAP(i_S => arg2,
		o_S => inv_arg2);

g_mux : nbit_mux_structure
port MAP(i_C => arg2,
		i_D => inv_arg2,
		i_S => nAdd_Sub,
		o_S => temp);

g_adder : nbit_full_adder_structure
port MAP(i_A => arg1,
		i_B => temp,
		Cin => nAdd_Sub,
		Cout => carry_out_in,
		CoutPrev => carry_out_prev,
		o_F => sol);

carry_out <= carry_out_in;	
overflow <= carry_out_in xor carry_out_prev;

end structure;
	