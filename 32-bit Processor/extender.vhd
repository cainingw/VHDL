library ieee;
use ieee.std_logic_1164.all;

entity extender is
port(zeroExt : in std_logic;
	to_extend : in std_logic_vector(15 downto 0);
	extended : out std_logic_vector(31 downto 0));
end extender;

architecture dataflow of extender is

signal sign : std_logic_vector(31 downto 0);

begin

g_loop1 : for i in 16 to 31 generate
	with zeroExt select sign(i) <=
		to_extend(15) when '1',
		'0' when others;
end generate;

sign(15 downto 0) <= to_extend;

extended <= sign;

end dataflow;