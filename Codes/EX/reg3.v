//done
module reg3(
	CLK,
	RST,

	WB_EN_In,
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
	MEM_W_EN_Out,
	);

input CLK,RST,WB_EN_In,MEM_R_EN_In,MEM_W_EN_In,ALU_Res_In,Val_Rm_In,Dest_In;
output 	Dest_Out,Val_Rm_Out,ALU_Rs_Out,WB_EN_Out,MEM_R_EN_Out,MEM_W_EN_Out;
endmodule
