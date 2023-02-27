`timescale 1ns/1ns
module PC_Addr_tb();
    reg [31:0] PC;
    wire [31:0] PC_plus4;

    PC_Addr uut (
        .PC(PC),
        .PC_plus4(PC_plus4)
    );

    initial begin
        PC = 32'd1000;
        #5 PC = 32'd500;
        #100 $stop;
    end

endmodule