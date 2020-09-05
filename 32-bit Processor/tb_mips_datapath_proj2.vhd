library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mips_datapath_proj2 is
generic(gCLK_HPER : time := 50 ns);
end tb_mips_datapath_proj2;

architecture behavior of tb_mips_datapath_proj2 is
  
component mips_datapath
port(opcode : in std_logic_vector(5 downto 0);
	Rs : in std_logic_vector(4 downto 0);
	Rt : in std_logic_vector(4 downto 0);
	Rd : in std_logic_vector(4 downto 0);
	shamt : in std_logic_vector(4 downto 0);
	funct : in std_logic_vector(5 downto 0);
	imm : in std_logic_vector(15 downto 0);
	RST : in std_logic;
	CLK : in std_logic;
	output : out std_logic_vector(31 downto 0));
end component;
  
-- Calculate the clock period as twice the half-period
constant cCLK_PER  : time := gCLK_HPER * 2;
  
-- signals we need
signal s_RST, s_CLK : std_logic;
signal s_Rs, s_Rt, s_Rd, s_shamt : std_logic_vector(4 downto 0);
signal s_opcode, s_funct : std_logic_vector(5 downto 0);
signal s_imm : std_logic_vector(15 downto 0);
signal s_output : std_logic_vector(31 downto 0);
 
begin

-- create an instance of your final design
DUT : mips_datapath
port map(s_opcode, s_Rs, s_Rt, s_Rd, s_shamt, s_funct, s_imm, s_RST, s_CLK);

  -- generating clocks
P_CLK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;
  
  -- Testbench process  
  P_TB: process
  begin
  
	-- INIT
	s_RST <= '1';
	wait for cCLK_PER;
	
	s_RST <= '0';
	wait for cCLK_PER;
	
	-- addi $1, $0, 5
	--"10000000000000010000000000000101"
	--x"80010005"
	s_opcode <= "100000";
	s_Rs <= "00000";
	s_Rt <= "00001";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"0005";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- ori $2, $0, -5
	--"10011100000000101111111111111011"
	--x"9C02FFFB"
	s_opcode <= "100111";
	s_Rs <= "00000";
	s_Rt <= "00010";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"fffb";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- add $3, $1, $2
	--"00000000001000100001100000100000"
	--x"00221820"
	s_opcode <= "000000";
	s_Rs <= "00001";
	s_Rt <= "00010";
	s_Rd <= "00011";
	s_shamt <= "00000";
	s_funct <= "100000";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- sub $3, $1, $2
	--"00000000001000100001100000100010"
	--x"00221822"
	s_opcode <= "000000";
	s_Rs <= "00001";
	s_Rt <= "00010";
	s_Rd <= "00011";
	s_shamt <= "00000";
	s_funct <= "100010";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- and $4, $2, $3
	--"00000000010000110010000000100110"
	--x"00432026"
	s_opcode <= "000000";
	s_Rs <= "00010";
	s_Rt <= "00011";
	s_Rd <= "00100";
	s_shamt <= "00000";
	s_funct <= "100110";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- andi $5, $2, 0xf
	--"10011000010001010000000000001111"
	--x"9845000F"
	s_opcode <= "100110";
	s_Rs <= "00010";
	s_Rt <= "00101";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"000f";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- lui $6, 0xaaaa
	--"10101000000001101010101010101010"
	--x"A806AAAA"
	s_opcode <= "101010";
	s_Rs <= "00000";
	s_Rt <= "00110";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"aaaa";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- lw $7, 0($1)
	--"11000000001001110000000000000000"
	--x"C0270000"
	s_opcode <= "110000";
	s_Rs <= "00001";
	s_Rt <= "00111";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- nor $8, $6, $7
	--"00000000110001110100000000101001"
	--x"00C74029"
	s_opcode <= "000000";
	s_Rs <= "00110";
	s_Rt <= "00111";
	s_Rd <= "01000";
	s_shamt <= "00000";
	s_funct <= "101001";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- xor $9, $7, $8
	--"00000000111010000100100000101000"
	--x"00E84828"
	s_opcode <= "000000";
	s_Rs <= "00111";
	s_Rt <= "01000";
	s_Rd <= "01001";
	s_shamt <= "00000";
	s_funct <= "101000";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- xori $10, $9, 0xffff
	--"10100001001010101111111111111111"
	--x"A12AFFFF"
	s_opcode <= "101000";
	s_Rs <= "01001";
	s_Rt <= "01010";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"ffff";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- or $1, $1, $2
	--"00000000001000100000100000100111"
	--x"00220827"
	s_opcode <= "000000";
	s_Rs <= "00001";
	s_Rt <= "00010";
	s_Rd <= "00001";
	s_shamt <= "00000";
	s_funct <= "100111";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- slt $3, $1, $2
	--"00000000001000100001100000100100"
	--x"00221824"
	s_opcode <= "000000";
	s_Rs <= "00001";
	s_Rt <= "00010";
	s_Rd <= "00011";
	s_shamt <= "00000";
	s_funct <= "100100";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- slti $3, $2, 1
	--"10010000010000110000000000000001"
	--x"90430001"
	s_opcode <= "100100";
	s_Rs <= "00010";
	s_Rt <= "00011";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"0001";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- sll $4, $1, 0x10
	--"00000000000000010010010000101010"
	--x"0001242A"
	s_opcode <= "000000";
	s_Rs <= "00000";
	s_Rt <= "00001";
	s_Rd <= "00100";
	s_shamt <= "10000";
	s_funct <= "101010";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- srl $5, $4, 0x10
	--"00000000000001000010110000101011"
	--"00042C2B"
	s_opcode <= "000000";
	s_Rs <= "00000";
	s_Rt <= "00100";
	s_Rd <= "00101";
	s_shamt <= "10000";
	s_funct <= "101011";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- sra $6, $4, 0x10
	--"00000000000001000011010000101100"
	--x"0004342C"
	s_opcode <= "000000";
	s_Rs <= "00000";
	s_Rt <= "00100";
	s_Rd <= "00110";
	s_shamt <= "10000";
	s_funct <= "101100";
	s_imm <= x"0005";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- sllv $7, $5, $6
	--"00000000101001100011100000101101"
	--x"00A6382D"
	s_opcode <= "000000";
	s_Rs <= "00101";
	s_Rt <= "00110";
	s_Rd <= "00111";
	s_shamt <= "00000";
	s_funct <= "101101";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- srlv $8, $2, $6
	--"00000000010001100100000000101110"
	--x"0046402E"
	s_opcode <= "000000";
	s_Rs <= "00010";
	s_Rt <= "00110";
	s_Rd <= "01000";
	s_shamt <= "00000";
	s_funct <= "101110";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- srav $9, $2, $6
	--"00000000010001100100100000101111"
	--x"0046482F"
	s_opcode <= "000000";
	s_Rs <= "00010";
	s_Rt <= "00110";
	s_Rd <= "01001";
	s_shamt <= "00000";
	s_funct <= "101111";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
	-- sw $9, 0($1)
	--"11000100001010010000000000000000"
	--x"C4290000"
	s_opcode <= "110001";
	s_Rs <= "00001";
	s_Rt <= "01001";
	s_Rd <= "00000";
	s_shamt <= "00000";
	s_funct <= "000000";
	s_imm <= x"0000";
	--s_RST
	--s_CLK
	--s_output
	wait for cCLK_PER;
	
    wait; -- wait for forever
  end process;
  
end behavior;