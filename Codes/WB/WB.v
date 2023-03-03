module WB(
	CLK,
	RST,
	PC_In,
	PC_Out
);

	input CLK,RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;

	assign PC_Out = PC_In;
    
endmodule