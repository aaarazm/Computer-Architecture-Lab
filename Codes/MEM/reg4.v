//done
module reg1(
	CLK,
	RST,

	WB_EN_In,
	MEM_R_EN_In,
	ALU_Res_In,
	Data_In,
	Dest_In,

	WB_EN_Out,
	MEM_R_EN_Out,
	ALU_Res_Out,
	Data_Out,
	Dest_Out
	);

input CLK,RST,WB_EN_In,MEM_R_EN_In,ALU_Res_In,Data_In,Dest_In;
output WB_EN_Out,MEM_R_EN_Out,ALU_Res_Out,Data_Out,Dest_Out;

endmodule	
