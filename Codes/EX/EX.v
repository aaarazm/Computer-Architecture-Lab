module EX(
	CLK,
	RST,
	PC_In,
	PC_Out
/* 	Signed_EX_imm_24,
	Branch_Address */
);

	input CLK,RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;

	assign PC_Out = PC_In;
	
/* 	input[23:0] Signed_EX_imm_24;
	output [31:0]Branch_Address; */

endmodule 
