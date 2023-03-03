module ID(
	CLK,
	RST,
	PC_In,
	PC_Out
/* 	Instruction
	Result_WB,
	writeBackEn,
	Dest_wb,
	hazard,
	SR,
	to next stage
	WB_EN, MEM_R_EN, MEM_W_EN, B, S,
	EXE_CMD,
	Val_Rn, Val_Rm,
	imm,
	Shift_operand,
	Signed_imm_24,
	Dest,
	src1, src2,
	Two_src, */
);
	input CLK,RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;

	assign PC_Out = PC_In;
	
/* 	// from IF Reg
	input [31:0] Instruction;
	// from WB stage
	input [31:0] Result_WB;
	input writeBackEn;
	input [3:0] Dest_wb;
	// from hazard detect module
	input hazard;
	// from Status Register
	input [3:0] SR;
	// to next stage
	output WB_EN, MEM_R_EN, MEM_W_EN, B, S;
	output [3:0] EXE_CMD;
	output [31:0] Val_Rn, Val_Rm;
	output imm;
	output [11:0] Shift_operand;
	output [23:0] Signed_imm_24;
	output [3:0] Dest;
	// to hazard detect module
	output [3:0] src1, src2;
	output Two_src; */

endmodule 