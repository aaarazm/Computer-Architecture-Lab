module ARM(clk, rst);
    input clk, rst;
    wire [31:0] PC_Out, ID_Instruction; // outputting the Inst. for simulation.

    wire [31:0] IF_PC, ID_PC, EX_PC;
    wire [31:0] IF_Instruction, ID_Val_Rn, ID_Val_Rm,
				EX_Val_Rn, EX_Val_Rm, EX_ALU_Res, WB_Value;
	wire ID_WB_EN, ID_MEM_R_EN, ID_MEM_W_EN, ID_B, ID_S, ID_imm,
		EX_WB_EN, EX_MEM_R_EN, EX_MEM_W_EN, EX_S, EX_imm, WB_WB_EN, WB_Dest, Branch_taken;
	wire [23:0] ID_signed_immed_24, EX_signed_immed_24;
	wire [11:0] ID_Shift_operand, EX_Shift_operand;
	wire [3:0] SR_In, SR_Out, ID_EXE_CMD, EX_EXE_CMD, EX_SR, ID_Dest, EX_Dest;

	Register #(4) Status_Reg_inst (
        .clk(clk),
        .rst(rst),
        .ld(EX_S),
        .regIn(SR_In),
        .regOut(SR_Out)
    );

    IF IF_inst(
        .clk(clk),
        .rst(rst),
        .freeze(1'b0),
        .Branch_taken(Branch_taken),
        .BranchAddr(1'b0),
        .PC(IF_PC),
        .Instruction(IF_Instruction)
    );
    IF_Reg IF_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .freeze(1'b0),
	    .PC_In(IF_PC),
	    .flush(Branch_taken),
	    .InstructionMemory_In(IF_Instruction),
	    .PC_Out(ID_PC),
	    .InstructionMemory_Out(ID_Instruction)
	);
    ID ID_inst(
		.CLK(clk),
		.RST(rst),
		.PC_In(PC_Reg_to_ID),
		.PC_Out(PC_ID_to_Reg),
		.Instruction(ID_Instruction),
		.Result_WB(WB_Value),
		.writeBackEn(WB_WB_EN),
		.Dest_wb(WB_Dest),
		.hazard(1'b0),
		.SR(SR_Out),
		.WB_EN(ID_WB_EN), MEM_R_EN(ID_MEM_R_EN), MEM_W_EN(ID_MEM_W_EN), B(ID_B), S(ID_S),
		.EXE_CMD(ID_EXE_CMD),
		.Val_Rn(ID_Val_Rn), Val_Rm(ID_Val_Rm),
		.imm(ID_imm),
		.Shift_operand(ID_Shift_operand),
		.Signed_imm_24(ID_signed_immed_24),
		.Dest(ID_Dest),
		// to hazard unit
		// .src1(), src2()
		//.Two_src
    );
    ID_Reg ID_Reg_inst(
		.CLK(clk),
		.RST(rst),
		.flush(Branch_taken),
		.WB_EN_In(ID_WB_EN),
		.MEM_R_EN_In(ID_MEM_R_EN),
		.MEM_W_EN_In(ID_MEM_W_EN),
		.EXE_CMD_In(ID_EXE_CMD),
		.B_In(ID_B),
		.S_In(ID_S),
		.PC_In(ID_PC),
		.Val_Rn_In(ID_Val_Rn),
		.Val_Rm_In(ID_Val_Rm),
		.imm_In(ID_imm),
		.Shift_operand_In(ID_Shift_operand),
		.Signed_imm_24_In(ID_signed_immed_24),
		.Dest_In(ID_Dest),
		.SR_In(SR_Out),
		.WB_EN_Out(EX_WB_EN),
		.MEM_R_EN_Out(EX_MEM_R_EN),
		.MEM_W_EN_Out(EX_MEM_W_EN),
		.EXE_CMD_Out(EX_EXE_CMD),
		.B_Out(Branch_taken),
		.S_Out(EX_S),
		.PC_Out(EX_PC),
		.Val_Rn_Out(EX_Val_Rn),
		.Val_Rm_Out(EX_Val_Rm),
		.imm_Out(EX_imm),
		.Shift_operand_Out(EX_Shift_operand),
		.Signed_imm_24_Out(EX_signed_immed_24),
		.Dest_Out(EX_Dest),
		.SR_Out(EX_SR)
    );
    EX EX_inst(
		.EXE_CMD(EX_EXE_CMD),
		.SR_In(EX_SR),
		.MEM_R_EN(EX_MEM_R_EN),
		.MEM_W_EN(EX_MEM_W_EN),
		.PC(EX_PC),
		.Val_Rn(EX_Val_Rn),
		.Val_Rm(EX_Val_Rm),
		.Shift_operand(EX_Shift_operand),
		.imm(EX_imm),
		.Signed_EX_imm_24(EX_signed_immed_24),
		.ALU_Result(),
		.Branch_Address(),
		.SR_Out(SR_In)
    );
    EX_Reg EX_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_EX_to_Reg),
	    .PC_Out(PC_Reg_to_MEM)
    );
    MEM MEM_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_MEM),
	    .PC_Out(PC_MEM_to_Reg)
    );
    MEM_Reg MEM_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_MEM_to_Reg),
	    .PC_Out(PC_Reg_to_WB)
    );
    WB WB_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_WB),
	    .PC_Out(PC_Out)
    );

endmodule