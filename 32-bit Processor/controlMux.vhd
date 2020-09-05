library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlMux is
port(flush : in std_logic;
	i_regDst : in std_logic;
	i_memRead : in std_logic;
	i_memtoReg : in std_logic;
	i_memWrite : in std_logic;
	i_ALUSrc : in std_logic;
	i_regWrite : in std_logic;
	i_lui : in std_logic;
	i_zeroExt : in std_logic;
	i_ALUControl : in std_logic_vector(3 downto 0);
	o_regDst : out std_logic;
	o_memRead : out std_logic;
	o_memtoReg : out std_logic;
	o_memWrite : out std_logic;
	o_ALUSrc : out std_logic;
	o_regWrite : out std_logic;
	o_lui : out std_logic;
	o_zeroExt : out std_logic;
	o_ALUControl : out std_logic_vector(3 downto 0));
end controlMux;

architecture rtl of controlMux is

signal tempIn : std_logic_vector(11 downto 0);
signal tempOut : std_logic_vector(11 downto 0);

begin

tempIn <= i_regDst & i_memRead & i_memtoReg & i_memWrite & i_ALUSrc & i_regWrite & i_lui & i_zeroExt & i_ALUControl;

tempOut <= tempIn when flush = '0' else x"000";

o_regDst <= tempOut(11);
o_memRead <= tempOut(10);
o_memtoReg <= tempOut(9);
o_memWrite <= tempOut(8);
o_ALUSrc <= tempOut(7);
o_regWrite <= tempOut(6);
o_lui <= tempOut(5);
o_zeroExt <= tempOut(4);
o_ALUControl <= tempOut(3 downto 0);
		
end rtl;