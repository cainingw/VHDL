onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mips_datapath_proj2a/s_RST
add wave -noupdate /tb_mips_datapath_proj2a/s_CLK
add wave -noupdate -divider pc
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_pc/WE
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_pc/address_to_load
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_pc/current_address
add wave -noupdate -divider PCPlus4
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_PCPlus4/o_F
add wave -noupdate -divider instruction
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_imem/addr
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_imem/q
add wave -noupdate -divider branch
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_PCSrc/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_PCSrc/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_PCSrc/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_PCSrc/o_S
add wave -noupdate -divider jump
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_jump/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_jump/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_jump/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_jump/o_S
add wave -noupdate -divider regIF
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/WE
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/flush
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/i_instruction
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/i_PCPlus4
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/o_instruction
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regIF/o_PCPlus4
add wave -noupdate -divider hazard
add wave -noupdate /tb_mips_datapath_proj2a/DUT/instruction_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/opcode
add wave -noupdate /tb_mips_datapath_proj2a/DUT/Rs_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/Rt_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/Rs_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/Rt_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/Rt_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/writeReg_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/regWrite_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/memRead_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/jump
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/PCSrc
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/WE
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_hazard/flush
add wave -noupdate -divider control
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_control/jump
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_control/branch
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_control/bne
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/flush
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_regDst
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_memRead
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_memWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_ALUSrc
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_lui
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_zeroExt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_controlMux/o_ALUControl
add wave -noupdate -divider regFile
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/i_Rs
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/i_Rt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/i_Rd
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/i_WE
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/w_Data
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/Rs_Data
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/Rt_Data
add wave -noupdate -divider reg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_1
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_2
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_3
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_4
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_5
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_6
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_7
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_8
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_9
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_10
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_11
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_12
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_reg/o_31
add wave -noupdate -divider regOutA
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutA/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutA/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutA/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutA/o_S
add wave -noupdate -divider regOutB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutB/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutB/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutB/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regOutB/o_S
add wave -noupdate -divider compareRegA
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegA/i_A
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegA/i_B
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegA/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegA/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegA/o_F
add wave -noupdate -divider compareRegB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegB/i_A
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegB/i_B
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegB/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegB/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_compareRegB/o_F
add wave -noupdate -divider zero
add wave -noupdate /tb_mips_datapath_proj2a/DUT/zero
add wave -noupdate -divider regID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_Rs
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_Rt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_Rd
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_shamt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_regDst
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_memRead
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_memWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_ALUSrc
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_LUI
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_ALUControl
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_RsData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_RtData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/i_immExtended
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_Rs
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_Rt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_Rd
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_shamt
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_regDst
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_memRead
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_memWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_ALUSrc
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_LUI
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_ALUControl
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_RsData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_RtData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regID/o_immExtended
add wave -noupdate -divider writeReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regDst/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regDst/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regDst/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regDst/o_S
add wave -noupdate -divider forward
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/Rs_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/Rt_ID
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/Rs_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/Rt_EX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/writeReg_MEM
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/writeReg_WB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/regWrite_MEM
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/regWrite_WB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/forwardA
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/forwardB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/forwardC
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_forward/forwardD
add wave -noupdate -divider ALUOperandA
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandA/i_A
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandA/i_B
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandA/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandA/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandA/o_F
add wave -noupdate -divider ALUOperandB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandB/i_A
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandB/i_B
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandB/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandB/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_ALUOperandB/o_F
add wave -noupdate -divider alu
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/operandA
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/operandB
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/aluOP
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/shift
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/lui
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/carryout
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/overflow
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_alu/resultF
add wave -noupdate -divider regEX
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_memRead
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_memWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_RtData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_ALUResult
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/i_writeReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_memRead
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_memWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_RtData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_ALUResult
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regEX/o_writeReg
add wave -noupdate -divider mem
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_dmem/addr
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_dmem/data
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_dmem/mr
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_dmem/we
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_dmem/q
add wave -noupdate -divider regMEM
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/i_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/i_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/i_ALUResult
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/i_writeReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/i_readData
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/o_memtoReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/o_regWrite
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/o_ALUResult
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/o_writeReg
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_regMEM/o_readData
add wave -noupdate -divider writeBack
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_memtoReg/i_C
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_memtoReg/i_D
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_memtoReg/i_S
add wave -noupdate /tb_mips_datapath_proj2a/DUT/g_memtoReg/o_S
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9534863 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 355
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {9388900 ps} {9926900 ps}
