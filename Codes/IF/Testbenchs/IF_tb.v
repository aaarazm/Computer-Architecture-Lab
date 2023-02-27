`timescale 1ns/1ns
module IF_tb();
    reg clk = 0, rst, freeze, Branch_taken;
    reg [31:0] BranchAddr;
    wire [31:0] PC, Instruction;

    localparam clk_period = 20;
    always #(clk_period/2) clk = ~clk;

    IF uut (
        .clk(clk),
        .rst(rst),
        .freeze(freeze),
        .Branch_taken(Branch_taken),
        .BranchAddr(BranchAddr),
        .PC(PC),
        .Instruction(Instruction)
    );

    initial begin
        rst = 1;
        {freeze, Branch_taken} = 0;
        BranchAddr = 0;
        #17 rst = 0;
        #100 $stop;
    end

endmodule