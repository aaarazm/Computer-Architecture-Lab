`timescale 1ns/1ns
module RegisterFileTB ();

    reg [1:0] src1 = 2'b00, src2 = 2'b01, Dest_wb = 2'b00;
    reg [3:0] Result_WB = 4'b1011;
    reg clk = 0, writeBackEn = 0, rst = 0;
    wire [3:0] reg1, reg2;

    RegisterFile #(4, 2) UUT (
        .src1(src1), .src2(src2), .Dest_wb(Dest_wb),
        .Result_WB(Result_WB),
        .clk(clk), .rst(rst), .writeBackEn(writeBackEn),
        .reg1(reg1), .reg2(reg2)
    );

    localparam clk_period = 20;
    always #(clk_period/2) clk <= ~clk;
    initial begin
        #10 rst = 1;
        #103 rst = 0;
        #54 Dest_wb = 2'b00; writeBackEn = 1;
        #54 Dest_wb = 2'b01; writeBackEn = 1;
        #40 Result_WB = 4'b0101; writeBackEn = 0;
        #54 src1 = 2'b10; src2 = 2'b11;
        #54 Dest_wb = 2'b10; writeBackEn = 1;
        #54 Dest_wb = 2'b11; writeBackEn = 1;
        #200 $stop;
    end

endmodule
