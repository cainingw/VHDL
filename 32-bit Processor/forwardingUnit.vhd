library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity forwardingUnit is
port(Rs_ID : in std_logic_vector(4 downto 0);
	Rt_ID : in std_logic_vector(4 downto 0);
	Rs_EX : in std_logic_vector(4 downto 0);
	Rt_EX : in std_logic_vector(4 downto 0);
	writeReg_MEM : in std_logic_vector(4 downto 0);
	writeReg_WB : in std_logic_vector(4 downto 0);
	regWrite_MEM : in std_logic;
	regWrite_WB : in std_logic;
	forwardA : out std_logic_vector(1 downto 0);
	forwardB : out std_logic_vector(1 downto 0);
	forwardC : out std_logic_vector(1 downto 0);
	forwardD : out std_logic_vector(1 downto 0));
end forwardingUnit;

architecture rtl of forwardingUnit is

signal tempA : std_logic;
signal tempB : std_logic;
signal tempC : std_logic;
signal tempD : std_logic;

begin

tempA <= '1' when ((regWrite_MEM = '1') and (writeReg_MEM /= "00000") and (writeReg_MEM = Rs_EX)) else '0';

forwardA(1) <= tempA;

forwardA(0) <= '1' when ((tempA = '0') and (regWrite_WB = '1') and (writeReg_WB /= "00000") and (writeReg_WB = Rs_EX)) else '0';

tempB <= '1' when ((regWrite_MEM = '1') and (writeReg_MEM /= "00000") and (writeReg_MEM = Rt_EX)) else '0';

forwardB(1) <= tempB;

forwardB(0) <= '1' when ((tempB = '0') and (regWrite_WB = '1') and (writeReg_WB /= "00000") and (writeReg_WB = Rt_EX)) else '0';

tempC <= '1' when ((regWrite_MEM = '1') and (writeReg_MEM /= "00000") and (writeReg_MEM = Rs_ID)) else '0';

forwardC(1) <= tempC;

forwardC(0) <= '1' when ((tempC = '0') and (regWrite_WB = '1') and (writeReg_WB /= "00000") and (writeReg_WB = Rs_ID)) else '0';

tempD <= '1' when ((regWrite_MEM = '1') and (writeReg_MEM /= "00000") and (writeReg_MEM = Rt_ID)) else '0';

forwardD(1) <= tempD;

forwardD(0) <= '1' when ((tempD = '0') and (regWrite_WB = '1') and (writeReg_WB /= "00000") and (writeReg_WB = Rt_ID)) else '0';

end rtl;