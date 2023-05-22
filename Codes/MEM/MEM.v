module MEM(
	CLK,
	RST,
	MEM_R_EN,
	MEM_W_EN,
	Address,
	Data,
	SRAM_WE_N,
	SRAM_ready,
	cache_ready,
	SRAM_DQ,
	SRAM_ADDR,
	MEM_result
);

	input CLK, RST, MEM_R_EN, MEM_W_EN;
	input [31:0] Address, Data;

	inout [15:0] SRAM_DQ;
	output SRAM_WE_N, SRAM_ready, cache_ready;
	output [17:0] SRAM_ADDR;
	output [31:0] MEM_result;

	wire LRU_update, SRAM_readEn, SRAM_writeEn;
	wire [31:0] sram_readData, sram_address, cache_address, sram_writeData;

/* 	Memory #(32, 32) memory_inst(
        .Address(Address),
        .WriteData(Data),
        .MemRead(MEM_R_EN), .MemWrite(MEM_W_EN), .clk(CLK),
        .ReadData(MEM_result)
    ); */

	Cache_controller cache_ctrl_inst (
    	.clk(CLK),
		.rst(RST),
		.address(Address),
		.writeData(Data),
		.MEM_R_EN(MEM_R_EN),
    	.MEM_W_EN(MEM_W_EN),
		.ready(cache_ready),
		.sram_readData(sram_readData),
    	.SRAM_ready(SRAM_ready), // Not ready?
		.sram_address(sram_address),
		.sram_writeData(sram_writeData),
    	.SRAM_readEn(SRAM_readEn),
		.SRAM_writeEn(SRAM_writeEn),
		.isHit(isHit),
    	.cache_readData(cache_readData),
		.cache_writeEn(cache_writeEn),
		.cache_writeData(cache_writeData),
    	.cache_address(cache_address),
		.LRU_update(LRU_update),
		.invalidate(invalidate)
	);

	Cache cache_inst (
		.clk(clk),
		.rst(rst),
		.LRU_update(LRU_update),
		.invalidate(invalidate),
		.writeEn(writeEn),
		.address(cache_address),
		.ReadData(sram_readData),
		.WriteData(WriteData),
		.isHit(isHit)
	);

	SRAM_Controller sram_ctrl_inst(
		.clk(CLK),
		.rst(RST),
		.SRAM_WE_N(SRAM_WE_N),
		.writeEn(SRAM_writeEn),
		.readEn(SRAM_readEn),
		.address(sram_address),
		.WriteData(sram_writeData),
		.ReadData(sram_readData),
		.ready(SRAM_ready),
		.SRAM_DQ(SRAM_DQ),
		.SRAM_ADDR(SRAM_ADDR)
	);

endmodule 
