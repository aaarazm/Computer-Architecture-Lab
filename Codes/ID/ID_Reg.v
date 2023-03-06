//not complete
module ID_Reg(
	CLK,
	RST,
	PC_In,
	PC_Out
/* 	flush,
	WB_EN_In,
	MEM_R_EN_In,
	MEM_W_EN_In,
	EXE_CMD_In,
	B_In,
	S_In,
	PC_In,

	WB_EN_Out,
	MEM_R_EN_Out,
	MEM_W_EN_Out,
	EXE_CMD_Out,
	B_Out,
	S_Out,
	PC_Out */
	);
	input CLK, RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;
/* 	input CLK, RST, flush;
	input WB_EN_In, MEM_R_EN_In, MEM_W_EN_In;
	input B_In, S_In;
	input [3:0] EXE_CMD_In;
	input [31:0] PC_In;
	input [31:0] Val_Rn_In, Val_Rm_In;
	input imm_In;
	input [11:0] Shift_operand_In;
	input [23:0] Signed_imm_24_In;
	input [3:0] Dest_In;

	output reg WB_EN, MEM_R_EN_Out, MEM_W_EN_Out, B_Out, S_Out;
	output reg [3:0] EXE_CMD_Out;
	output reg [31:0] PC_Out;
	output reg [31:0] Val_Rn_Out, Val_Rm_Out;
	output reg imm_Out;
	output reg [11:0] Shift_operand_Out;
	output reg [23:0] Signed_imm_24_Out;
	output reg [3:0] Dest_Out; */

	Register #(32) ID_PC_Reg (
        .clk(CLK),
        .rst(RST),
        .ld(1'b1),
        .regIn(PC_In),
        .regOut(PC_Out)
    );

endmodule
