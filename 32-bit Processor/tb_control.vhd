library IEEE;
use IEEE.std_logic_1164.all;

entity tb_control is
generic(gCLK_HPER : time := 50 ns);
end tb_control;

architecture behavior of tb_control is
  
component control
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
	zeroExt : out std_logic;
	ALUControl : out std_logic_vector(3 downto 0));
end component;
  
-- Calculate the clock period as twice the half-period
constant cCLK_PER  : time := gCLK_HPER * 2;
  
-- signals we need
signal s_regDst, s_jump, s_branch, s_memRead, s_memtoReg, s_memWrite, s_ALUSrc, s_lui, s_bne, s_zeroExt : std_logic;
signal s_RST, s_CLK : std_logic;
signal s_ALUControl : std_logic_vector(3 downto 0);
signal s_opcode, s_funct : std_logic_vector(5 downto 0);

 
begin

-- create an instance of your final design
DUT : control
port map(s_opcode, s_funct);

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
	
	-- addi
	s_opcode <= "100000";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- ori
	s_opcode <= "100111";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- add
	s_opcode <= "000000";
	s_funct <= "100000";
	wait for cCLK_PER;
	
	-- sub
	s_opcode <= "000000";
	s_funct <= "100010";
	wait for cCLK_PER;
	
	-- and
	s_opcode <= "000000";
	s_funct <= "100110";
	wait for cCLK_PER;
	
	-- andi
	s_opcode <= "100110";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- lui
	s_opcode <= "101010";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- lw
	s_opcode <= "110000";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- nor
	s_opcode <= "000000";
	s_funct <= "101001";
	wait for cCLK_PER;
	
	-- xor
	s_opcode <= "000000";
	s_funct <= "101000";
	wait for cCLK_PER;
	
	-- xori
	s_opcode <= "101000";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- or
	s_opcode <= "000000";
	s_funct <= "100111";
	wait for cCLK_PER;
	
	-- slt
	s_opcode <= "000000";
	s_funct <= "100100";
	wait for cCLK_PER;
	
	-- slti
	s_opcode <= "100100";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- sll
	s_opcode <= "000000";
	s_funct <= "101010";
	wait for cCLK_PER;
	
	-- srl
	s_opcode <= "000000";
	s_funct <= "101011";
	wait for cCLK_PER;
	
	-- sra
	s_opcode <= "000000";
	s_funct <= "101100";
	wait for cCLK_PER;
	
	-- sllv
	s_opcode <= "000000";
	s_funct <= "101101";
	wait for cCLK_PER;
	
	-- srlv
	s_opcode <= "000000";
	s_funct <= "101110";
	wait for cCLK_PER;
	
	-- srav
	s_opcode <= "000000";
	s_funct <= "101111";
	wait for cCLK_PER;
	
	-- sw
	s_opcode <= "110001";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- beq
	s_opcode <= "010000";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- bne
	s_opcode <= "010001";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- j
	s_opcode <= "000001";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- jal
	s_opcode <= "000010";
	s_funct <= "000000";
	wait for cCLK_PER;
	
	-- jr
	s_opcode <= "000011";
	s_funct <= "000000";
	wait for cCLK_PER;
	
    wait; -- wait for forever
  end process;
  
end behavior;