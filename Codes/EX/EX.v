module EX(
/* 	CLK,
	RST, */
	EXE_CMD,
	SR_In,
	MEM_R_EN,
	MEM_W_EN,
	PC,
	Val_Rn,
	Val_Rm,
	forward1,
	forward2,
	Shift_operand,
	imm,
	Signed_EX_imm_24,
	ALU_Result,
	Branch_Address,
	WB_Value,
	MEM_ALU_Res,
	EX_Val_Rm_Out,
	SR_Out
);

	// input CLK,RST;
	input [3:0] EXE_CMD;
	input [3:0] SR_In;
	input [1:0] forward1, forward2;
	input MEM_R_EN, MEM_W_EN;
	input [31:0] PC;
	input [31:0] Val_Rn, Val_Rm;
    input [11:0] Shift_operand;
    input imm;
	input [23:0] Signed_EX_imm_24;

	output [31:0] ALU_Result, Branch_Address, WB_Value, MEM_ALU_Res, EX_Val_Rm_Out;
	output [3:0] SR_Out;

	wire [31:0] Val2, forwarded1, forwarded2;

	assign EX_Val_Rm_Out = forwarded2;

	assign forwarded1 = (forward1 == 2'b00) ? Val_Rn:
					(forward1 == 2'b01) ? MEM_ALU_Res:
					(forward1 == 2'b10) ? WB_Value: 'bz;

	assign forwarded2 = (forward2 == 2'b00) ? Val_Rm:
					(forward2 == 2'b01) ? MEM_ALU_Res:
					(forward2 == 2'b10) ? WB_Value: 'bz;

	ALU alu_inst (
		.in1(forwarded1),
		.in2(Val2),
		.Cin(SR_In[1]),
		.Vin(SR_In[0]),
		.SR(SR_Out),
		.EXE_CMD(EXE_CMD),
		.result(ALU_Result)
	);

	Val2_Generator v2gen_inst (
		.Val_Rm(forwarded2),
		.imm(imm),
		.memRW(MEM_R_EN | MEM_W_EN),
		.Shift_operand(Shift_operand),
		.Val2(Val2)
	);

	PC_Branch_Addr branchAdder_inst (
		.PC(PC),
		.signed_immed_24({{8{Signed_EX_imm_24[23]}}, Signed_EX_imm_24}),
		.Branch_Address(Branch_Address)
	);

endmodule 
