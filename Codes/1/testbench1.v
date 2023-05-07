`timescale 1ns/1ns
module testbench1();

    reg clk = 0, rst = 0;

    localparam clk_period = 20;
    always #(clk_period/2) clk = ~clk;

    ARM uut (
        .clk(clk),
        .rst(rst),
        .forward_EN(1'b1)
    );

    initial begin
        #1 rst = 1;
        #36 rst = 0;
        #6000 $stop;
    end

endmodule