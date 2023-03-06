`timescale 1ns/1ns
module testbench1();

    reg clk = 0, rst;

    localparam clk_period = 20;
    always #(clk_period/2) clk = ~clk;

    ARM uut (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        rst = 1;
        #17 rst = 0;
        #300 $stop;
    end

endmodule