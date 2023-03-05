//done
module EX_Reg(
	CLK,
	RST,
	PC_In,
	PC_Out
/* 	WB_EN_In,
	MEM_R_EN_In,
	MEM_W_EN_In,
	ALU_Res_In,
	Val_Rm_In,
	Dest_In,

	Dest_Out,
	Val_Rm_Out,
	ALU_Rs_Out,
	WB_EN_Out,
	MEM_R_EN_Out,
	MEM_W_EN_Out, */
	);
	input CLK, RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;

	Register #(32) EX_PC_Reg (
        .clk(CLK),
        .rst(RST),
        .ld(1'b1),
        .regIn(PC_In),
        .regOut(PC_Out)
    );
	
/* 	input CLK,RST,WB_EN_In,MEM_R_EN_In,MEM_W_EN_In,ALU_Res_In,Val_Rm_In,Dest_In;
	output 	Dest_Out,Val_Rm_Out,ALU_Rs_Out,WB_EN_Out,MEM_R_EN_Out,MEM_W_EN_Out; */
endmodule
