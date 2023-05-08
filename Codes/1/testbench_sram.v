`timescale 1ns/1ns
module testbench_sram();

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

    assign SRAM_DQ = (uut.MEM_inst.sram_ctrl_inst.ps == 5) ? 16'b0010000000000000:
                    (uut.MEM_inst.sram_ctrl_inst.ps == 7) ? 16'b0000000000000000: 16'bz;

    initial begin
        #1 rst = 1;
        #36 rst = 0;
        #6000 $stop;
    end

endmodule