library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regEX is
port(CLK : in std_logic;
	i_memRead : in std_logic;
	i_memtoReg : in std_logic;
	i_memWrite : in std_logic;
	i_regWrite : in std_logic;
	i_RtData : in std_logic_vector(31 downto 0);
	i_ALUResult : in std_logic_vector(31 downto 0);
	i_writeReg : in std_logic_vector(4 downto 0);
	o_memRead : out std_logic;
	o_memtoReg : out std_logic;
	o_memWrite : out std_logic;
	o_regWrite : out std_logic;
	o_RtData : out std_logic_vector(31 downto 0);
	o_ALUResult : out std_logic_vector(31 downto 0);
	o_writeReg : out std_logic_vector(4 downto 0));
end regEX;

architecture structure of regEX is

component nbit_dff
generic(N : integer);
port(CLK : in std_logic;
    RST : in std_logic;
    WE : in std_logic;
    D : in std_logic_vector(N-1 downto 0);
    Q : out std_logic_vector(N-1 downto 0));
end component;

component d_flip_flop
port(i_CLK: in std_logic;
    i_RST : in std_logic;
    i_WE: in std_logic;
    i_D : in std_logic;
    o_Q : out std_logic);
end component;

begin

g_dff1 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memRead,
		o_Q => o_memRead);
		
g_dff2 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memtoReg,
		o_Q => o_memtoReg);
		
g_dff3 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memWrite,
		o_Q => o_memWrite);
		
g_dff4 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_regWrite,
		o_Q => o_regWrite);

g_dff5 : nbit_dff
generic MAP(N => 32)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_RtData,
		Q => o_RtData);
		
g_dff6 : nbit_dff
generic MAP(N => 32)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_ALUResult,
		Q => o_ALUResult);
		
g_dff7 : nbit_dff
generic MAP(N => 5)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_writeReg,
		Q => o_writeReg);

end structure;