library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is
port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	i_C : in std_logic_vector(31 downto 0);
	i_S : in std_logic_vector(1 downto 0);
	o_F : out std_logic_vector(31 downto 0));
end mux3;

architecture rtl of mux3 is

begin
	
with i_S select o_F <=
	i_A when "00",
	i_B when "01",
	i_C when "10",
	x"00000000" when others;

end rtl;
	