//done
module MEM_Reg(
	CLK,
	RST,
	PC_In,
	PC_Out
/* 	WB_EN_In,
	MEM_R_EN_In,
	ALU_Res_In,
	Data_In,
	Dest_In,

	WB_EN_Out,
	MEM_R_EN_Out,
	ALU_Res_Out,
	Data_Out,
	Dest_Out */
	);
	input CLK, RST;
	input [31:0] PC_In;
	output [31:0] PC_Out;

	Register #(32) MEM_PC_Reg (
        .clk(CLK),
        .rst(RST),
        .ld(1'b1),
        .regIn(PC_In),
        .regOut(PC_Out)
    );
/* 	input CLK,RST,WB_EN_In,MEM_R_EN_In,ALU_Res_In,Data_In,Dest_In;
	output WB_EN_Out,MEM_R_EN_Out,ALU_Res_Out,Data_Out,Dest_Out; */

endmodule	
