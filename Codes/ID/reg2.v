//not complete
module reg2(
	CLK,
	RST,

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
	PC_Out,
	);

input CLK,RST;
 
input WB_EN_In,MEM_R_EN_In,MEM_W_EN_In,EXE_CMD_In,B_In,S_In;
input [31:0] PC_In;
output [31:0]PC_Out;
output WB_EN_Out,MEM_R_EN_Out,MEM_W_EN_Out,EXE_CMD_Out,B_Out,S_Out;
endmodule
