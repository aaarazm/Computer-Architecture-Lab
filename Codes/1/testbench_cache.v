`timescale 1ns/1ns
module testbench_cache();

    reg clk = 0, rst = 0;

    wire SRAM_WE_N;
    wire [17:0] SRAM_ADDR;
    wire [15:0] SRAM_DQ;

    localparam clk_period = 20;
    always #(clk_period/2) clk = ~clk;


    ARM uut (
        .clk(clk),
        .rst(rst),
        .forward_EN(1'b1),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_ADDR(SRAM_ADDR)
    );

    SRAM sram_mimick (
        .clk(clk),
        .rst(rst),
        .SRAM_DQ(SRAM_DQ),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_UB_N(1'b0),
        .SRAM_LB_N(1'b0),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(1'b0),
        .SRAM_OE_N(1'b0)
    );

    initial begin
        #1 rst = 1;
        #36 rst = 0;
        #7500 $stop;
    end

endmodule