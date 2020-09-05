library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regIF is
port(CLK : in std_logic;
	WE : in std_logic;
	flush : in std_logic;
	i_instruction : in std_logic_vector(31 downto 0);
	i_PCPlus4 : in std_logic_vector(31 downto 0);
	o_instruction : out std_logic_vector(31 downto 0);
	o_PCPlus4 : out std_logic_vector(31 downto 0));
end regIF;

architecture structure of regIF is

component nbit_dff
generic(N : integer := 32);
port(CLK : in std_logic;
    RST : in std_logic;
    WE : in std_logic;
    D : in std_logic_vector(N-1 downto 0);
    Q : out std_logic_vector(N-1 downto 0));
end component;

signal instruction : std_logic_vector(31 downto 0);
signal PCPlus4 : std_logic_vector(31 downto 0);

begin

instruction <= x"00000000" when flush = '1' else i_instruction;
PCPlus4 <= x"00000000" when flush = '1' else i_PCPlus4;

g_dff1 : nbit_dff
port MAP(CLK => CLK,
		RST => '0',
		WE => WE,
		D => instruction,
		Q => o_instruction);
		
g_dff2 : nbit_dff
port MAP(CLK => CLK,
		RST => '0',
		WE => WE,
		D => PCPlus4,
		Q => o_PCPlus4);

end structure;