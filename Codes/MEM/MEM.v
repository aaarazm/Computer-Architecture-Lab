module MEM(
	CLK,
	RST,
	MEM_R_EN,
	MEM_W_EN,
	Address,
	Data,
	SRAM_WE_N,
	freeze_N,
	SRAM_DQ,
	SRAM_ADDR,
	MEM_result
);

	input CLK, RST, MEM_R_EN, MEM_W_EN;
	input [31:0] Address, Data;

	inout [15:0] SRAM_DQ;
	output SRAM_WE_N, freeze_N;
	output [17:0] SRAM_ADDR;
	output [31:0] MEM_result;

/* 	Memory #(32, 32) memory_inst(
        .Address(Address),
        .WriteData(Data),
        .MemRead(MEM_R_EN), .MemWrite(MEM_W_EN), .clk(CLK),
        .ReadData(MEM_result)
    ); */

	SRAM_Controller sram_ctrl_inst(
		.clk(CLK),
		.rst(RST),
		.SRAM_WE_N(SRAM_WE_N),
		.writeEn(MEM_W_EN),
		.readEn(MEM_R_EN),
		.address(Address),
		.WriteData(Data),
		.ReadData(MEM_result),
		.ready(freeze_N),
		.SRAM_DQ(SRAM_DQ),
		.SRAM_ADDR(SRAM_ADDR)
	);

endmodule 
