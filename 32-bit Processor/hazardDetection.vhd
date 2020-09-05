library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hazardDetection is
port(Rs_ID : in std_logic_vector(4 downto 0);
	Rt_ID : in std_logic_vector(4 downto 0);
	Rt_EX : in std_logic_vector(4 downto 0);
	writeReg_EX : in std_logic_vector(4 downto 0);
	regWrite_EX : in std_logic;
	memRead_EX : in std_logic;
	branch : in std_logic;
	jump : in std_logic;
	PCSrc : in std_logic;
	WE : out std_logic;
	flush : out std_logic);
end hazardDetection;

architecture rtl of hazardDetection is

signal tempWE : std_logic;

begin

tempWE <= '0' when ((branch = '1') and (regWrite_EX = '1') and (writeReg_EX /= "00000") and ((writeReg_EX = Rs_ID) or (writeReg_EX = Rt_ID))) or ((memRead_EX = '1') and ((Rt_EX = Rs_ID) or (Rt_EX = Rt_ID))) else '1';

WE <= tempWE;

flush <= '1' when (((tempWE = '1') and (PCSrc = '1')) or (jump = '1')) else '0';

end rtl;