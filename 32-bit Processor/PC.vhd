library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
port(CLK : in std_logic;
	WE : in std_logic;
	address_to_load : in std_logic_vector(31 downto 0);
	current_address : out std_logic_vector(31 downto 0));
end pc;

architecture beh of pc is

signal address: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

begin

process(CLK, WE)
begin
	current_address <= address;
	if CLK = '0' and CLK'event then
		if WE = '1' then
			address <= address_to_load;
		end if;
	end if;
end process;

end beh;