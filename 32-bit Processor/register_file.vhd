library IEEE;
use IEEE.std_logic_1164.all;

entity register_file is
port(i_Rs : in std_logic_vector(4 downto 0);
	i_Rt : in std_logic_vector(4 downto 0);
	i_Rd : in std_logic_vector(4 downto 0);
	i_RST : in std_logic;
	i_WE : in std_logic;
	i_CLK : in std_logic;
	w_Data : in std_logic_vector(31 downto 0);
	Rs_Data : out std_logic_vector(31 downto 0);
	Rt_Data : out std_logic_vector(31 downto 0));
end register_file;

architecture structure of register_file is

component nbit_dff
generic(N : integer := 32);
port(CLK : in std_logic;
	RST : in std_logic;
	WE : in std_logic;
	D : in std_logic_vector(N-1 downto 0);
	Q : out std_logic_vector(N-1 downto 0));
end component;

component decoder
port(Rd : in std_logic_vector(4 downto 0);
	o_F : out std_logic_vector(31 downto 0));
end component;

component mux32
port(i_0 : in std_logic_vector(31 downto 0);
	i_1 : in std_logic_vector(31 downto 0);
	i_2 : in std_logic_vector(31 downto 0);
	i_3 : in std_logic_vector(31 downto 0);
	i_4 : in std_logic_vector(31 downto 0);
	i_5 : in std_logic_vector(31 downto 0);
	i_6 : in std_logic_vector(31 downto 0);
	i_7 : in std_logic_vector(31 downto 0);
	i_8 : in std_logic_vector(31 downto 0);
	i_9 : in std_logic_vector(31 downto 0);
	i_10 : in std_logic_vector(31 downto 0);
	i_11 : in std_logic_vector(31 downto 0);
	i_12 : in std_logic_vector(31 downto 0);
	i_13 : in std_logic_vector(31 downto 0);
	i_14 : in std_logic_vector(31 downto 0);
	i_15 : in std_logic_vector(31 downto 0);
	i_16 : in std_logic_vector(31 downto 0);
	i_17 : in std_logic_vector(31 downto 0);
	i_18 : in std_logic_vector(31 downto 0);
	i_19 : in std_logic_vector(31 downto 0);
	i_20 : in std_logic_vector(31 downto 0);
	i_21 : in std_logic_vector(31 downto 0);
	i_22 : in std_logic_vector(31 downto 0);
	i_23 : in std_logic_vector(31 downto 0);
	i_24 : in std_logic_vector(31 downto 0);
	i_25 : in std_logic_vector(31 downto 0);
	i_26 : in std_logic_vector(31 downto 0);
	i_27 : in std_logic_vector(31 downto 0);
	i_28 : in std_logic_vector(31 downto 0);
	i_29 : in std_logic_vector(31 downto 0);
	i_30 : in std_logic_vector(31 downto 0);
	i_31 : in std_logic_vector(31 downto 0);
	r_reg : in std_logic_vector(4 downto 0);
	r_data : out std_logic_vector(31 downto 0));
end component;

signal selector1 : std_logic;
signal selector2 : std_logic;
signal selector3 : std_logic;
signal selector4 : std_logic;
signal selector5 : std_logic;
signal selector6 : std_logic;
signal selector7 : std_logic;
signal selector8 : std_logic;
signal selector9 : std_logic;
signal selector10 : std_logic;
signal selector11 : std_logic;
signal selector12 : std_logic;
signal selector13 : std_logic;
signal selector14 : std_logic;
signal selector15 : std_logic;
signal selector16 : std_logic;
signal selector17 : std_logic;
signal selector18 : std_logic;
signal selector19 : std_logic;
signal selector20 : std_logic;
signal selector21 : std_logic;
signal selector22 : std_logic;
signal selector23 : std_logic;
signal selector24 : std_logic;
signal selector25 : std_logic;
signal selector26 : std_logic;
signal selector27 : std_logic;
signal selector28 : std_logic;
signal selector29 : std_logic;
signal selector30 : std_logic;
signal selector31 : std_logic;

signal o_decoder : std_logic_vector(31 downto 0);
signal o_0 : std_logic_vector(31 downto 0);
signal o_1 : std_logic_vector(31 downto 0);
signal o_2 : std_logic_vector(31 downto 0);
signal o_3 : std_logic_vector(31 downto 0);
signal o_4 : std_logic_vector(31 downto 0);
signal o_5 : std_logic_vector(31 downto 0);
signal o_6 : std_logic_vector(31 downto 0);
signal o_7 : std_logic_vector(31 downto 0);
signal o_8 : std_logic_vector(31 downto 0);
signal o_9 : std_logic_vector(31 downto 0);
signal o_10 : std_logic_vector(31 downto 0);
signal o_11 : std_logic_vector(31 downto 0);
signal o_12 : std_logic_vector(31 downto 0);
signal o_13 : std_logic_vector(31 downto 0);
signal o_14 : std_logic_vector(31 downto 0);
signal o_15 : std_logic_vector(31 downto 0);
signal o_16 : std_logic_vector(31 downto 0);
signal o_17 : std_logic_vector(31 downto 0);
signal o_18 : std_logic_vector(31 downto 0);
signal o_19 : std_logic_vector(31 downto 0);
signal o_20 : std_logic_vector(31 downto 0);
signal o_21 : std_logic_vector(31 downto 0);
signal o_22 : std_logic_vector(31 downto 0);
signal o_23 : std_logic_vector(31 downto 0);
signal o_24 : std_logic_vector(31 downto 0);
signal o_25 : std_logic_vector(31 downto 0);
signal o_26 : std_logic_vector(31 downto 0);
signal o_27 : std_logic_vector(31 downto 0);
signal o_28 : std_logic_vector(31 downto 0);
signal o_29 : std_logic_vector(31 downto 0);
signal o_30 : std_logic_vector(31 downto 0);
signal o_31 : std_logic_vector(31 downto 0);

begin

g_decoder : decoder
port MAP(Rd => i_Rd,
		o_F => o_decoder);
		
o_0 <= (others => '0');

selector1 <= i_WE and o_decoder(1);
		
g_dff1 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector1,
		D => w_Data,
		Q => o_1);
	
selector2 <= i_WE and o_decoder(2);
		
g_dff2 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector2,
		D => w_Data,
		Q => o_2);

selector3 <= i_WE and o_decoder(3);
		
g_dff3 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector3,
		D => w_Data,
		Q => o_3);
		
selector4 <= i_WE and o_decoder(4);
		
g_dff4 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector4,
		D => w_Data,
		Q => o_4);

selector5 <= i_WE and o_decoder(5);
		
g_dff5 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector5,
		D => w_Data,
		Q => o_5);
		
selector6 <= i_WE and o_decoder(6);
		
g_dff6 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector6,
		D => w_Data,
		Q => o_6);
		
selector7 <= i_WE and o_decoder(7);
		
g_dff7 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector7,
		D => w_Data,
		Q => o_7);
		
selector8 <= i_WE and o_decoder(8);
		
g_dff8 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector8,
		D => w_Data,
		Q => o_8);
		
selector9 <= i_WE and o_decoder(9);
		
g_dff9 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector9,
		D => w_Data,
		Q => o_9);
		
selector10 <= i_WE and o_decoder(10);
		
g_dff10 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector10,
		D => w_Data,
		Q => o_10);
		
selector11 <= i_WE and o_decoder(11);
		
g_dff11 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector11,
		D => w_Data,
		Q => o_11);
		
selector12 <= i_WE and o_decoder(12);
		
g_dff12 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector12,
		D => w_Data,
		Q => o_12);
		
selector13 <= i_WE and o_decoder(13);
		
g_dff13 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector13,
		D => w_Data,
		Q => o_13);
		
selector14 <= i_WE and o_decoder(14);
		
g_dff14 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector14,
		D => w_Data,
		Q => o_14);
		
selector15 <= i_WE and o_decoder(15);
		
g_dff15 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector15,
		D => w_Data,
		Q => o_15);
		
selector16 <= i_WE and o_decoder(16);
		
g_dff16 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector16,
		D => w_Data,
		Q => o_16);
		
selector17 <= i_WE and o_decoder(17);
		
g_dff17 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector17,
		D => w_Data,
		Q => o_17);
		
selector18 <= i_WE and o_decoder(18);
		
g_dff18 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector18,
		D => w_Data,
		Q => o_18);
		
selector19 <= i_WE and o_decoder(19);
		
g_dff19 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector19,
		D => w_Data,
		Q => o_19);

selector20 <= i_WE and o_decoder(20);
		
g_dff20 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector20,
		D => w_Data,
		Q => o_20);

selector21 <= i_WE and o_decoder(21);
		
g_dff21 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector21,
		D => w_Data,
		Q => o_21);

selector22 <= i_WE and o_decoder(22);
		
g_dff22 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector22,
		D => w_Data,
		Q => o_22);

selector23 <= i_WE and o_decoder(23);
		
g_dff23 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector23,
		D => w_Data,
		Q => o_23);

selector24 <= i_WE and o_decoder(24);
		
g_dff24 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector24,
		D => w_Data,
		Q => o_24);

selector25 <= i_WE and o_decoder(25);
		
g_dff25 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector25,
		D => w_Data,
		Q => o_25);

selector26 <= i_WE and o_decoder(26);
		
g_dff26 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector26,
		D => w_Data,
		Q => o_26);

selector27 <= i_WE and o_decoder(27);
		
g_dff27 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector27,
		D => w_Data,
		Q => o_27);

selector28 <= i_WE and o_decoder(28);
		
g_dff28 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector28,
		D => w_Data,
		Q => o_28);

selector29 <= i_WE and o_decoder(29);
		
g_dff29 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector29,
		D => w_Data,
		Q => o_29);

selector30 <= i_WE and o_decoder(30);
		
g_dff30 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector30,
		D => w_Data,
		Q => o_30);

selector31 <= i_WE and o_decoder(31);
		
g_dff31 : nbit_dff
port MAP(CLK => i_CLK,
		RST => i_RST,
		WE => selector31,
		D => w_Data,
		Q => o_31);

g_mux1 : mux32
port MAP(i_0 => o_0,
		i_1 => o_1,
		i_2 => o_2,
		i_3 => o_3,
		i_4 => o_4,
		i_5 => o_5,
		i_6 => o_6,
		i_7 => o_7,
		i_8 => o_8,
		i_9 => o_9,
		i_10 => o_10,
		i_11 => o_11,
		i_12 => o_12,
		i_13 => o_13,
		i_14 => o_14,
		i_15 => o_15,
		i_16 => o_16,
		i_17 => o_17,
		i_18 => o_18,
		i_19 => o_19,
		i_20 => o_20,
		i_21 => o_21,
		i_22 => o_22,
		i_23 => o_23,
		i_24 => o_24,
		i_25 => o_25,
		i_26 => o_26,
		i_27 => o_27,
		i_28 => o_28,
		i_29 => o_29,
		i_30 => o_30,
		i_31 => o_31,
		r_reg => i_Rs,
		r_data => Rs_Data);
		
g_mux2 : mux32
port MAP(i_0 => o_0,
		i_1 => o_1,
		i_2 => o_2,
		i_3 => o_3,
		i_4 => o_4,
		i_5 => o_5,
		i_6 => o_6,
		i_7 => o_7,
		i_8 => o_8,
		i_9 => o_9,
		i_10 => o_10,
		i_11 => o_11,
		i_12 => o_12,
		i_13 => o_13,
		i_14 => o_14,
		i_15 => o_15,
		i_16 => o_16,
		i_17 => o_17,
		i_18 => o_18,
		i_19 => o_19,
		i_20 => o_20,
		i_21 => o_21,
		i_22 => o_22,
		i_23 => o_23,
		i_24 => o_24,
		i_25 => o_25,
		i_26 => o_26,
		i_27 => o_27,
		i_28 => o_28,
		i_29 => o_29,
		i_30 => o_30,
		i_31 => o_31,
		r_reg => i_Rt,
		r_data => Rt_Data);
		
end structure;