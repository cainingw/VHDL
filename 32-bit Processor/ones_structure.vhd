library IEEE;
use IEEE.std_logic_1164.all;

entity ones_structure is
generic(N : integer);
port(i_S : in std_logic_vector(N-1 downto 0);
	o_S : out std_logic_vector(N-1 downto 0));
end ones_structure;

architecture structure of ones_structure is

component mips_inv
port(i_A : in std_logic;
     o_F : out std_logic);
end component;

begin

G1: for i in 0 to N-1 generate
	inv_i : mips_inv 
	port map(i_A  => i_S(i),
			o_F  => o_S(i));
end generate;

end structure;