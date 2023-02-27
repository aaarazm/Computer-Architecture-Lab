//done
module reg1(
	CLK,
	RST,
	freeze,
	PC_In,
	flush,
	InstructionMemory_In,
	PC_Out,
	InstructionMemory_Out
	);
input CLK,RST,flush,freeze;
input [31:0] PC_In,InstructionMemory_In;
output [31:0]PC_Out,InstructionMemory_Out;
endmodule