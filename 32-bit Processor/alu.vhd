library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
port(operandA : in std_logic_vector(31 downto 0);
	operandB : in std_logic_vector(31 downto 0);
	aluOP : in std_logic_vector(3 downto 0);
	shift : in std_logic_vector(4 downto 0);
	lui : in std_logic;
	carryout : out std_logic;
	overflow : out std_logic;
	resultF : out std_logic_vector(31 downto 0));
end alu;

architecture rtl of alu is

component nbit_add_sub
generic(N : integer := 32);
port(arg1 : in std_logic_vector(N-1 downto 0);
	arg2 : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	carry_out : out std_logic;
	overflow : out std_logic;
	sol : out std_logic_vector(N-1 downto 0));
end component;

component nbit_mux_structure
generic(N : integer := 5);
port(i_C : in std_logic_vector(N-1 downto 0);
	i_D : in std_logic_vector(N-1 downto 0);
	i_S : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end component;

component barrel_shifter
port(shift_amount : in std_logic_vector(4 downto 0);
	dir : in std_logic;
	ari : in std_logic;
	input : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0));
end component;

signal resultAdd : std_logic_vector(31 downto 0);
signal resultSub : std_logic_vector(31 downto 0);
signal resultSlt : std_logic_vector(31 downto 0);
signal resultAnd : std_logic_vector(31 downto 0);
signal resultOr : std_logic_vector(31 downto 0);
signal resultXor : std_logic_vector(31 downto 0);
signal resultNor : std_logic_vector(31 downto 0);
signal resultShift : std_logic_vector(31 downto 0);
signal result : std_logic_vector(31 downto 0);

signal dir : std_logic;
signal ari : std_logic;
signal var : std_logic;
signal shamt : std_logic_vector(4 downto 0);
signal fshamt : std_logic_vector(4 downto 0);

signal carryout_add : std_logic;
signal overflow_add : std_logic;
signal carryout_sub : std_logic;
signal overflow_sub : std_logic;

begin

--add/addu
g_add : nbit_add_sub
port MAP(arg1 => operandA,
		arg2 => operandB,
		nAdd_Sub => '0',
		carry_out => carryout_add,
		overflow => overflow_add,
		sol => resultAdd);

--sub/subu		
g_sub : nbit_add_sub
port MAP(arg1 => operandA,
		arg2 => operandB,
		nAdd_Sub => '1',
		carry_out => carryout_sub,
		overflow => overflow_sub,
		sol => resultSub);

--slt/sltu
resultSlt(31 downto 1) <= (others => '0');

resultSlt(0) <= resultSub(31);

--and
resultAnd <= operandA and operandB;

--or
resultOr <= operandA or operandB;

--xor
resultXor <= operandA xor operandB;

--Nor
resultNor <= operandA nor operandB;

--sll/srl/sra
with aluOP select dir <=
	'1' when "1010" | "1101",--sll
	'0' when others;

with aluOP select ari <=
	'1' when "1100" | "1111",--sra
	'0' when others;
	
with aluOP select var <=
	'1' when "1101" | "1110" | "1111",
	'0' when others;
		
g_mux1 : nbit_mux_structure
port MAP(i_C => shift,
		i_D => operandB(4 downto 0),
		i_S => var,
		o_S => shamt);
	
g_mux2 : nbit_mux_structure
port MAP(i_C => shamt,
		i_D => "10000",
		i_S => lui,
		o_S => fshamt);

g_shift : barrel_shifter
port MAP(shift_amount => fshamt,
		dir => dir,
		ari => ari,
		input => operandB,
		output => resultShift);

with aluOP select result <=
	resultAdd when "0000",--add
	resultAdd when "0001",--addu
	resultSub when "0010",--sub
	resultSub when "0011",--subu
	resultSlt when "0100",--slt
	resultSlt when "0101",--sltu
	resultAnd when "0110",--and
	resultOr when "0111",--or
	resultXor when "1000",--xor
	resultNor when "1001",--nor
	resultShift when "1010",--sll
	resultShift when "1011",--srl
	resultShift when "1100",--sra
	resultShift when "1101",--sllv
	resultShift when "1110",--srlv
	resultShift when "1111",--srav
	x"00000000" when others;
		
with aluOP select carryout <=
	carryout_add when "0000",
	carryout_add when "0001",
	carryout_sub when "0010",
	carryout_sub when "0011",
	'0' when others;
		
with aluOP select overflow <=
	overflow_add when "0000",
	overflow_add when "0001",
	overflow_sub when "0010",
	overflow_sub when "0011",
	'0' when others;

resultF <= result;

end rtl;