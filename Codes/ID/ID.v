module ID(
	PC_In,
	PC_Out,
	Instruction_Memory,
	Signed_EX_imm_24
);

input[31:0] PC_In,Instruction_Memory;
output[23:0] Signed_EX_imm_24;
output [31:0] PC_Out;

endmodule 