`timescale 1ns/1ns
module RegisterFileTB ();

    reg [3:0] src1 = 4'b0000, src2 = 4'b0001, Dest_wb = 4'b0000;
    reg [3:0] Result_WB = 4'b1011;
    reg clk = 0, writeBackEn = 0, rst = 0;
    wire [3:0] reg1, reg2;

    RegisterFile #( .WORD_SIZE(4), .ADDRESS_SIZE(4)) UUT (
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
        #54 Dest_wb = 4'b0000; writeBackEn = 1;
        #54 Dest_wb = 4'b0001; writeBackEn = 1;
        #40 Result_WB = 4'b0101; writeBackEn = 0;
        #54 src1 = 4'b0010; src2 = 4'b0011;
        #54 Dest_wb = 4'b0010; writeBackEn = 1;
        #54 Dest_wb = 4'b0011; writeBackEn = 1;
        #200 $stop;
    end

endmodule