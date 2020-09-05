library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regID is
port(CLK : in std_logic;
	i_Rs : in std_logic_vector(4 downto 0);
	i_Rt : in std_logic_vector(4 downto 0);
	i_Rd : in std_logic_vector(4 downto 0);
	i_shamt : in std_logic_vector(4 downto 0);
	i_regDst : in std_logic;
	i_memRead : in std_logic;
	i_memtoReg : in std_logic;
	i_memWrite : in std_logic;
	i_ALUSrc : in std_logic;
	i_regWrite : in std_logic;
	i_LUI : in std_logic;
	i_ALUControl : in std_logic_vector(3 downto 0);
	i_RsData : in std_logic_vector(31 downto 0);
	i_RtData : in std_logic_vector(31 downto 0);
	i_immExtended : in std_logic_vector(31 downto 0); 
	o_Rs : out std_logic_vector(4 downto 0);
	o_Rt : out std_logic_vector(4 downto 0);
	o_Rd : out std_logic_vector(4 downto 0);
	o_shamt : out std_logic_vector(4 downto 0);
	o_regDst : out std_logic;
	o_memRead : out std_logic;
	o_memtoReg : out std_logic;
	o_memWrite : out std_logic;
	o_ALUSrc : out std_logic;
	o_regWrite : out std_logic;
	o_LUI : out std_logic;
	o_ALUControl : out std_logic_vector(3 downto 0);
	o_RsData : out std_logic_vector(31 downto 0);
	o_RtData : out std_logic_vector(31 downto 0);
	o_immExtended : out std_logic_vector(31 downto 0));
end regID;

architecture structure of regID is

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

g_dff1 : nbit_dff
generic MAP(N => 5)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_Rs,
		Q => o_Rs);
		
g_dff2 : nbit_dff
generic MAP(N => 5)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_Rt,
		Q => o_Rt);
		
g_dff3 : nbit_dff
generic MAP(N => 5)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_Rd,
		Q => o_Rd);
		
g_dff4 : nbit_dff
generic MAP(N => 5)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_shamt,
		Q => o_shamt);
		
g_dff5 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_regDst,
		o_Q => o_regDst);
		
g_dff6 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memRead,
		o_Q => o_memRead);
		
g_dff7 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memtoReg,
		o_Q => o_memtoReg);
		
g_dff8 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_memWrite,
		o_Q => o_memWrite);
		
g_dff9 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_ALUSrc,
		o_Q => o_ALUSrc);
		
g_dff10 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_regWrite,
		o_Q => o_regWrite);
		
g_dff11 : d_flip_flop
port MAP(i_CLK => CLK,
		i_RST => '0',
		i_WE => '1',
		i_D => i_LUI,
		o_Q => o_LUI);
		
g_dff12 : nbit_dff
generic MAP(N => 4)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_ALUControl,
		Q => o_ALUControl);
		
g_dff13 : nbit_dff
generic MAP(N => 32)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_RsData,
		Q => o_RsData);
		
g_dff14 : nbit_dff
generic MAP(N => 32)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_RtData,
		Q => o_RtData);
		
g_dff15 : nbit_dff
generic MAP(N => 32)
port MAP(CLK => CLK,
		RST => '0',
		WE => '1',
		D => i_immExtended,
		Q => o_immExtended);

end structure;