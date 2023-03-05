`timescale 1ns/1ns
module testbench1();

    reg clk = 0, rst;
    wire [31:0] PC_Out, Instruction_Out;

    localparam clk_period = 20;
    always #(clk_period/2) clk = ~clk;

    ARM uut (
        .clk(clk),
        .rst(rst),
        .PC_Out(PC_Out),
        .Instruction_Out(Instruction_Out)
    );

    initial begin
        rst = 1;
        #17 rst = 0;
        #300 $stop;
    end

endmodule