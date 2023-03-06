module ARM(clk, rst);
    input clk, rst;
    wire [31:0] PC_Out, Instruction_Out; // outputting the Inst. for simulation.

    wire [31:0] PC_IF_to_Reg, PC_Reg_to_ID, PC_ID_to_Reg, PC_Reg_to_EX, PC_EX_to_Reg, PC_Reg_to_MEM, PC_MEM_to_Reg, PC_Reg_to_WB;
    wire [31:0] Inst_IF_to_Reg;
    IF IF_inst(
        .clk(clk),
        .rst(rst),
        .freeze(1'b0),
        .Branch_taken(1'b0),
        .BranchAddr(1'b0),
        .PC(PC_IF_to_Reg),
        .Instruction(Inst_IF_to_Reg)
    );
    IF_Reg IF_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .freeze(1'b0),
	    .PC_In(PC_IF_to_Reg),
	    .flush(1'b0),
	    .InstructionMemory_In(Inst_IF_to_Reg),
	    .PC_Out(PC_Reg_to_ID),
	    .InstructionMemory_Out(Instruction_Out)
	);
    ID ID_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_ID),
	    .PC_Out(PC_ID_to_Reg)
    );
    ID_Reg ID_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_ID_to_Reg),
	    .PC_Out(PC_Reg_to_EX)
    );
    EX EX_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_EX),
	    .PC_Out(PC_EX_to_Reg)
    );
    EX_Reg EX_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_EX_to_Reg),
	    .PC_Out(PC_Reg_to_MEM)
    );
    MEM MEM_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_MEM),
	    .PC_Out(PC_MEM_to_Reg)
    );
    MEM_Reg MEM_Reg_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_MEM_to_Reg),
	    .PC_Out(PC_Reg_to_WB)
    );
    WB WB_inst(
	    .CLK(clk),
	    .RST(rst),
	    .PC_In(PC_Reg_to_WB),
	    .PC_Out(PC_Out)
    );

endmodule