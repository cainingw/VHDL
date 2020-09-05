library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
port(opcode : in std_logic_vector(5 downto 0);
	funct : in std_logic_vector(5 downto 0);
	regDst : out std_logic;
	jump : out std_logic;
	branch : out std_logic;
	memRead : out std_logic;
	memtoReg : out std_logic;
	memWrite : out std_logic;
	ALUSrc : out std_logic;
	regWrite : out std_logic;
	lui : out std_logic;
	bne : out std_logic;
	jal : out std_logic;
	jr : out std_logic;
	zeroExt : out std_logic;
	ALUControl : out std_logic_vector(3 downto 0));
end control;

architecture rtl of control is

signal ALUSelector : std_logic_vector(3 downto 0);

begin

with opcode(5 downto 4) select regDst <=
	'1' when "00",
	'0' when others;
	
with opcode select jump <=
	'1' when "000001" | "000010" | "000011",
	'0' when others;
	
with opcode(5 downto 4) select branch <=
	'1' when "01",
	'0' when others;
	
with opcode(5 downto 4) select memRead <=
	'1' when "11",
	'0' when others;
	
with opcode(5 downto 4) select memtoReg <=
	'1' when "11",
	'0' when others;
	
with opcode select memWrite <=
	'1' when "110001",
	'0' when others;
	
with opcode(5 downto 4) select ALUSrc <=
	'1' when "10" | "11",
	'0' when others;
	
with opcode select regWrite <=
	'0' when "110001" | "010000" | "010001" | "000001" | "000011",
	'1' when others;
	
with opcode select lui <=
	'1' when "101010",
	'0' when others;
	
with opcode select bne <=
	'1' when "010001",
	'0' when others;
	
with opcode select jal <=
	'1' when "000010",
	'0' when others;
	
with opcode select jr <=
	'1' when "000011",
	'0' when others;
	
with opcode select zeroExt <=
	'1' when "100111" | "100110" | "101000",
	'0' when others;
	
with opcode(5 downto 4) select ALUSelector <=
	funct(3 downto 0) when "00",
	opcode(3 downto 0) when "10",
	"0010" when "01",
	"0000" when others;
	
ALUControl <= ALUSelector;
		
end rtl;