library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10
	);

	port 
	(
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);

end imem;

architecture rtl of imem is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;

	-- Declare the RAM signal and specify a default value.	Quartus Prime
	-- will load the provided memory initialization file (.mif).
	signal ram : memory_t;
	attribute ram_init_file : string; -- newly added
	attribute ram_init_file of ram : signal is "imem.mif"; -- newly added

begin

	q <= ram(addr);

end rtl;