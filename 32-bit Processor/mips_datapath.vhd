library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_datapath is
port(RST : in std_logic;
	CLK : in std_logic;
	output : out std_logic_vector(31 downto 0));
end mips_datapath;

architecture structure of mips_datapath is

component pc
port(CLK : in std_logic;
	WE : in std_logic;
	address_to_load : in std_logic_vector(31 downto 0);
	current_address : out std_logic_vector(31 downto 0));
end component;

component nbit_full_adder_structure
generic(N : integer := 32);
port(i_A : in std_logic_vector(N-1 downto 0);
	i_B : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
	Cout : out std_logic;
	CoutPrev : out std_logic;
	o_F : out std_logic_vector(N-1 downto 0));
end component;

component imem
generic(DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10);
port(addr : in natural range 0 to 2**ADDR_WIDTH - 1;
	q : out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component barrel_shifter
port(shift_amount : in std_logic_vector(4 downto 0);
	dir : in std_logic;
	ari : in std_logic;
	input : in std_logic_vector(31 downto 0);
	output : out std_logic_vector(31 downto 0));
end component;

component nbit_mux_structure
generic(N : integer);
port(i_C : in std_logic_vector(N-1 downto 0);
	i_D : in std_logic_vector(N-1 downto 0);
	i_S : in std_logic;
	o_S : out std_logic_vector(N-1 downto 0));
end component;

component register_file
port(i_Rs : in std_logic_vector(4 downto 0);
	i_Rt : in std_logic_vector(4 downto 0);
	i_Rd : in std_logic_vector(4 downto 0);
	i_RST : in std_logic;
	i_WE : in std_logic;
	i_CLK : in std_logic;
	w_Data : in std_logic_vector(31 downto 0);
	Rs_Data : out std_logic_vector(31 downto 0);
	Rt_Data : out std_logic_vector(31 downto 0));
end component;

component hazardDetection
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
end component;

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
	jal : out std_logic;
	jr : out std_logic;
	zeroExt : out std_logic;
	ALUControl : out std_logic_vector(3 downto 0));
end component;

component controlMux
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
end component;

component extender
port(zeroExt : in std_logic;
	to_extend : in std_logic_vector(15 downto 0);
	extended : out std_logic_vector(31 downto 0));
end component;

component forwardingUnit
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
	forwardd : out std_logic_vector(1 downto 0));
end component;

component mux3
port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	i_C : in std_logic_vector(31 downto 0);
	i_S : in std_logic_vector(1 downto 0);
	o_F : out std_logic_vector(31 downto 0));
end component;

component alu
port(operandA : in std_logic_vector(31 downto 0);
	operandB : in std_logic_vector(31 downto 0);
	aluOP : in std_logic_vector(3 downto 0);
	shift : in std_logic_vector(4 downto 0);
	lui : in std_logic;
	carryout : out std_logic;
	overflow : out std_logic;
	resultF : out std_logic_vector(31 downto 0));
end component;

component mem
generic(DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10);
port(clk : in std_logic;
	addr : in natural range 0 to 2**ADDR_WIDTH - 1;
	data : in std_logic_vector((DATA_WIDTH-1) downto 0);
	mr : in std_logic := '1';
	we : in std_logic := '1';
	q : out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component regIF
port(CLK : in std_logic;
	WE : in std_logic;
	flush : in std_logic;
	i_instruction : in std_logic_vector(31 downto 0);
	i_PCPlus4 : in std_logic_vector(31 downto 0);
	o_instruction : out std_logic_vector(31 downto 0);
	o_PCPlus4 : out std_logic_vector(31 downto 0));
end component;

component regID
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
end component;

component regEX
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
end component;

component regMEM
port(CLK : in std_logic;
	i_memtoReg : in std_logic;
	i_regWrite : in std_logic;
	i_ALUResult : in std_logic_vector(31 downto 0);
	i_writeReg : in std_logic_vector(4 downto 0);
	i_readData : in std_logic_vector(31 downto 0);
	o_memtoReg : out std_logic;
	o_regWrite : out std_logic;
	o_ALUResult : out std_logic_vector(31 downto 0);
	o_writeReg : out std_logic_vector(4 downto 0);
	o_readData : out std_logic_vector(31 downto 0));
end component;

signal nextAddress : std_logic_vector(31 downto 0);
signal PCAddress : std_logic_vector(31 downto 0);
signal PCPlus4_IF, PCPlus4_ID : std_logic_vector(31 downto 0);
signal instruction_IF, instruction_ID : std_logic_vector(31 downto 0);
signal opcode : std_logic_vector(5 downto 0);
signal Rs_ID, Rs_EX : std_logic_vector(4 downto 0);
signal Rt_ID, Rt_EX : std_logic_vector(4 downto 0);
signal Rd_ID, Rd_EX : std_logic_vector(4 downto 0);
signal shamt_ID, shamt_EX : std_logic_vector(4 downto 0);
signal funct : std_logic_vector(5 downto 0);
signal imm : std_logic_vector(15 downto 0);

signal WE : std_logic;
signal flush : std_logic;
signal jump : std_logic;
signal branch : std_logic;
signal regDst_ID, regDst_EX : std_logic;
signal memRead_ID, memRead_EX, memRead_MEM : std_logic;
signal memtoReg_ID, memtoReg_EX, memtoReg_MEM, memtoReg_WB : std_logic;
signal memWrite_ID, memWrite_EX, memWrite_MEM : std_logic;
signal ALUSrc_ID, ALUSrc_EX : std_logic;
signal regWrite_ID, regWrite_EX, regWrite_MEM, regWrite_WB : std_logic;
signal LUI_ID, LUI_EX : std_logic;
signal BNE : std_logic;
signal jal : std_logic;
signal jr : std_logic;
signal zeroExtend : std_logic;
signal ALUControl_ID, ALUControl_EX : std_logic_vector(3 downto 0);

signal PCPlus8 : std_logic_vector(31 downto 0);
signal RsData_ID, RsData_EX : std_logic_vector(31 downto 0);
signal RtData_ID, RtData_EX, RtData_MEM : std_logic_vector(31 downto 0);
signal immExtended_ID, immExtended_EX : std_logic_vector(31 downto 0);
signal tempExtended : std_logic_vector(31 downto 0);
signal branchAddress : std_logic_vector(31 downto 0);
signal regOutA : std_logic;
signal regOutB : std_logic;
signal compareRegA : std_logic_vector(31 downto 0);
signal compareRegB : std_logic_vector(31 downto 0);
signal zero : std_logic;
signal PCSrc : std_logic;
signal jumpAddress : std_logic_vector(31 downto 0);
signal writeReg_EX, writeReg_MEM, writeReg_WB : std_logic_vector(4 downto 0);
signal forwardA : std_logic_vector(1 downto 0);
signal forwardB : std_logic_vector(1 downto 0);
signal forwardC : std_logic_vector(1 downto 0);
signal forwardD : std_logic_vector(1 downto 0);
signal ALUOperandA : std_logic_vector(31 downto 0);
signal ALUOperandB : std_logic_vector(31 downto 0);
signal ALUResult_EX, ALUResult_MEM, ALUResult_WB : std_logic_vector(31 downto 0);
signal readData_MEM, readData_WB : std_logic_vector(31 downto 0);
signal writeData : std_logic_vector(31 downto 0);

signal tempPC : natural range 0 to 2**10-1;
signal tempAddress : std_logic_vector(31 downto 0);
signal tempRd : std_logic_vector(4 downto 0);
signal tempRegDst : std_logic;
signal tempMemRead : std_logic;
signal tempMemtoReg : std_logic;
signal tempMemWrite : std_logic;
signal tempALUSrc : std_logic;
signal tempRegWrite : std_logic;
signal tempLUI : std_logic;
signal tempZeroExtend : std_logic;
signal tempALUControl : std_logic_vector(3 downto 0);
signal tempRsData1 : std_logic_vector(31 downto 0);
signal tempRtData1 : std_logic_vector(31 downto 0);
signal tempRsData2 : std_logic_vector(31 downto 0);
signal tempRtData2 : std_logic_vector(31 downto 0);
signal tempJump : std_logic_vector(31 downto 0);
signal tempOperandB : std_logic_vector(31 downto 0);
signal tempALU : natural range 0 to 2**10-1;

begin

------------------------------------
-- IF stage
------------------------------------

g_pc : pc
port MAP(CLK => CLK,
		WE => WE,
		address_to_load => nextAddress,
		current_address => PCAddress);
		
g_PCPlus4 : nbit_full_adder_structure
port MAP(i_A => PCAddress,
		i_B  => x"00000004",
		Cin  => '0',
		Cout => open,
		CoutPrev => open,
		o_F	=> PCPlus4_IF);
		
tempPC <= to_integer(unsigned(PCAddress(11 downto 2)));
		
g_imem : imem
port MAP(addr => tempPC,
		q => instruction_IF);
		
g_PCSrc : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => PCPlus4_IF,
		i_D => branchAddress,
		i_S => PCSrc,
		o_S => tempAddress);
		
g_jump : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => tempAddress,
		i_D => jumpAddress,
		i_S => jump,
		o_S => nextAddress);
		
g_regIF : regIF
port MAP(CLK => CLK,
		WE => WE,
		flush => flush,
		i_instruction => instruction_IF,
		i_PCPlus4 => PCPlus4_IF,
		o_instruction => instruction_ID,
		o_PCPlus4 => PCPlus4_ID);
		
------------------------------------
-- ID stage
------------------------------------

opcode <= instruction_ID(31 downto 26);
Rs_ID <= instruction_ID(25 downto 21);
Rt_ID <= instruction_ID(20 downto 16);
tempRd <= instruction_ID(15 downto 11);
shamt_ID <= instruction_ID(10 downto 6);
funct <= instruction_ID(5 downto 0);
imm <= instruction_ID(15 downto 0);

g_hazard : hazardDetection
port MAP(Rs_ID => Rs_ID,
		Rt_ID => Rt_ID,
		Rt_EX => Rt_EX,
		writeReg_EX => writeReg_EX,
		regWrite_EX => regWrite_EX,
		memRead_EX => memRead_EX,
		branch => branch,
		jump => jump,
		PCSrc => PCSrc,
		WE => WE,
		flush => flush);

g_control : control
port MAP(opcode => opcode,
		funct => funct,
		regDst => tempRegDst,
		jump => jump,
		branch => branch,
		memRead => tempMemRead,
		memtoReg => tempMemtoReg,
		memWrite => tempMemWrite,
		ALUSrc => tempALUSrc,
		regWrite => tempRegWrite,
		lui => tempLUI,
		bne => BNE,
		jal => jal,
		jr => jr,
		zeroExt => tempZeroExtend,
		ALUControl => tempALUControl);
		
g_controlMux : controlMux
port MAP(flush => '0',
		i_regDst => tempRegDst,
		i_memRead => tempMemRead,
		i_memtoReg => tempMemtoReg,
		i_memWrite => tempMemWrite,
		i_ALUSrc => tempALUSrc,
		i_regWrite => tempRegWrite,
		i_lui => tempLUI,
		i_zeroExt => tempZeroExtend,
		i_ALUControl => tempALUControl,
		o_regDst => regDst_ID,
		o_memRead => memRead_ID,
		o_memtoReg => memtoReg_ID,
		o_memWrite => memWrite_ID,
		o_ALUSrc => ALUSrc_ID,
		o_regWrite => regWrite_ID,
		o_lui => LUI_ID,
		o_zeroExt => zeroExtend,
		o_ALUControl => ALUControl_ID);

g_extend : extender
port MAP(zeroExt => zeroExtend,
		to_extend => imm,
		extended => immExtended_ID);
		
g_shiftLeft2Branch : barrel_shifter
port MAP(shift_amount => "00010",
		dir => '1',
		ari => '0',
		input => immExtended_ID,
		output => tempExtended);
		
g_adderBranch : nbit_full_adder_structure
port MAP(i_A => PCPlus4_ID,
		i_B  => tempExtended,
		Cin  => '0',
		Cout => open,
		CoutPrev => open,
		o_F	=> branchAddress);		
		
g_reg : register_file -- belongs to WB as well
port MAP(i_Rs => Rs_ID,
		i_Rt => Rt_ID,
		i_Rd => writeReg_WB,
		i_RST => RST,
		i_WE => regWrite_WB,
		i_CLK => CLK,
		w_Data => writeData,
		Rs_Data => tempRsData1,
		Rt_Data => tempRtData1);
		
regOutA <= '1' when ((writeReg_WB = Rs_ID) and (regWrite_WB = '1')) else '0';

regOutB <= '1' when ((writeReg_WB = Rt_ID) and (regWrite_WB = '1')) else '0';
		
g_regOutA : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => tempRsData1,
		i_D => writeData,
		i_S => regOutA,
		o_S => tempRsData2);
		
g_regOutB : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => tempRtData1,
		i_D => writeData,
		i_S => regOutB,
		o_S => tempRtData2);
		
g_compareRegA : mux3
port MAP(i_A => tempRsData2,
		i_B => writeData,
		i_C => ALUResult_MEM,
		i_S => forwardC,
		o_F => compareRegA);
		
g_compareRegB : mux3
port MAP(i_A => tempRtData2,
		i_B => writeData,
		i_C => ALUResult_MEM,
		i_S => forwardD,
		o_F => compareRegB);
		
zero <= '1' when compareRegA = compareRegB else '0';

PCSrc <= branch and (zero XOR BNE);

tempJump <= PCPlus4_ID(31 downto 28) & instruction_ID(25 downto 0) & "00";

g_jr : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => tempJump,
		i_D => compareRegA,
		i_S => jr,
		o_S => jumpAddress);
		
g_jalAdder : nbit_full_adder_structure
port MAP(i_A => PCPlus4_ID,
		i_B  => x"00000004",
		Cin  => '0',
		Cout => open,
		CoutPrev => open,
		o_F	=> PCPlus8);
		
g_jalRs : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => compareRegA,
		i_D => PCPlus8,
		i_S => jal,
		o_S => RsData_ID);
		
g_jalRt : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => compareRegB,
		i_D => x"00000000",
		i_S => jal,
		o_S => RtData_ID);

g_jalRd : nbit_mux_structure
generic MAP(N => 5)
port MAP(i_C => tempRd,
		i_D => "11111",
		i_S => jal,
		o_S => Rd_ID);		
		
g_regID : regID
port MAP(CLK => CLK,
		i_Rs => Rs_ID,
		i_Rt => Rt_ID,
		i_Rd => Rd_ID,
		i_shamt => shamt_ID,
		i_regDst => regDst_ID,
		i_memRead => memRead_ID,
		i_memtoReg => memtoReg_ID,
		i_memWrite => memWrite_ID,
		i_ALUSrc => ALUSrc_ID,
		i_regWrite => regWrite_ID,
		i_LUI => LUI_ID,
		i_ALUControl => ALUControl_ID,
		i_RsData => RsData_ID,
		i_RtData => RtData_ID,
		i_immExtended => immExtended_ID, 
		o_Rs => Rs_EX,
		o_Rt => Rt_EX,
		o_Rd => Rd_EX,
		o_shamt => shamt_EX,
		o_regDst => regDst_EX,
		o_memRead => memRead_EX,
		o_memtoReg => memtoReg_EX,
		o_memWrite => memWrite_EX,
		o_ALUSrc => ALUSrc_EX,
		o_regWrite => regWrite_EX,
		o_LUI => LUI_EX,
		o_ALUControl => ALUControl_EX,
		o_RsData => RsData_EX,
		o_RtData => RtData_EX,
		o_immExtended => immExtended_EX);

------------------------------------
-- EX stage
------------------------------------

g_regDst : nbit_mux_structure
generic MAP(N => 5)
port MAP(i_C => Rt_EX,
		i_D => Rd_EX,
		i_S => regDst_EX,
		o_S => writeReg_EX);
		
g_forward : forwardingUnit
port MAP(Rs_ID => Rs_ID,
	Rt_ID => Rt_ID,
	Rs_EX => Rs_EX,
	Rt_EX => Rt_EX,
	writeReg_MEM => writeReg_MEM,
	writeReg_WB => writeReg_WB,
	regWrite_MEM => regWrite_MEM,
	regWrite_WB => regWrite_WB,
	forwardA => forwardA,
	forwardB => forwardB,
	forwardC => forwardC,
	forwardD => forwardD);
		
g_ALUOperandA : mux3
port MAP(i_A => RsData_EX,
		i_B => writeData,
		i_C => ALUResult_MEM,
		i_S => forwardA,
		o_F => ALUOperandA);
		
g_ALUOperandB : mux3
port MAP(i_A => RtData_EX,
		i_B => writeData,
		i_C => ALUResult_MEM,
		i_S => forwardB,
		o_F => tempOperandB);

g_ALUSrc : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => tempOperandB,
		i_D => immExtended_EX,
		i_S => ALUSrc_EX,
		o_S => ALUOperandB);	
			
g_alu : alu
port MAP(operandA => ALUOperandA,
		operandB => ALUOperandB,
		aluOP => ALUControl_EX,
		shift => shamt_EX,
		lui => LUI_EX,
		carryout => open,
		overflow => open,
		resultF => ALUResult_EX);

g_regEX : regEX		
port MAP(CLK => CLK,
		i_memRead => memRead_EX,
		i_memtoReg => memtoReg_EX,
		i_memWrite => memWrite_EX,
		i_regWrite => regWrite_EX,
		i_RtData => RtData_EX,
		i_ALUResult => ALUResult_EX,
		i_writeReg => writeReg_EX,
		o_memRead => memRead_MEM,
		o_memtoReg => memtoReg_MEM,
		o_memWrite => memWrite_MEM,
		o_regWrite => regWrite_MEM,
		o_RtData => RtData_MEM,
		o_ALUResult => ALUResult_MEM,
		o_writeReg => writeReg_MEM);

------------------------------------
-- MEM stage
------------------------------------

tempALU <= to_integer(unsigned(ALUResult_MEM(11 downto 2)));
		
g_dmem : mem
port MAP(clk => CLK,
		addr => tempALU,
		data => RtData_MEM,
		mr => memRead_MEM,
		we => memWrite_MEM,
		q => readData_MEM);
		
g_regMEM : regMEM
port MAP(CLK => CLK,
		i_memtoReg => memtoReg_MEM,
		i_regWrite => regWrite_MEM,
		i_ALUResult => ALUResult_MEM,
		i_writeReg => writeReg_MEM,
		i_readData => readData_MEM,
		o_memtoReg => memtoReg_WB,
		o_regWrite => regWrite_WB,
		o_ALUResult => ALUResult_WB,
		o_writeReg => writeReg_WB,
		o_readData => readData_WB);
		
------------------------------------
-- WB stage
------------------------------------
		
g_memtoReg : nbit_mux_structure
generic MAP(N => 32)
port MAP(i_C => ALUResult_WB,
		i_D => readData_WB,
		i_S => memtoReg_WB,
		o_S => writeData);
		
output <= writeData;

end structure;