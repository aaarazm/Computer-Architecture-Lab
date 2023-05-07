`timescale 1ns/1ns
module MemoryTB ();
    
    reg [31:0] Address = 0;
    reg [31:0] WriteData = 1;
    reg MemRead = 1, MemWrite = 0, clk = 0;
    wire [31:0] ReadData;
    Memory #(32, 32) UUT(
        .Address(Address),
        .WriteData(WriteData),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .clk(clk),
        .ReadData(ReadData)
    );

    always #11 clk <= ~clk;
    initial begin
        #53 MemRead = 1;
        #53 Address = 1024; WriteData = 2; MemWrite = 1;
        #53 Address = Address + 1; WriteData = 3;
        #53 Address = Address + 1; WriteData = 4;
        #53 Address = Address + 1; WriteData = 5;
        #53 Address = Address + 1; WriteData = 6;
        #53 Address = Address + 1; WriteData = 7;
        #53 Address = Address + 1; WriteData = 8;
        #53 Address = Address + 1; WriteData = 9;
        #53 Address = Address + 1; WriteData = 10;
        #53 Address = Address + 1; WriteData = 11;
        #53 Address = Address + 1; WriteData = 12;
        #53 Address = Address + 1; WriteData = 13;
        #53 Address = Address + 1; WriteData = 14;
        #53 Address = Address + 1; WriteData = 15;
        #53 Address = Address + 1; WriteData = 16;
        #53 Address = Address + 1; WriteData = 17;
        #53 Address = Address + 1; WriteData = 18;
        // #53 MemWrite = 0; MemRead = 1;
        #53 Address = 1024;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 MemWrite = 0; MemRead = 1;
        #53 Address = 1024;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 Address = Address + 4;
        #53 Address = 2024;
        #53 Address = Address + 1;
        #53 Address = Address + 1;
        #53 Address = Address + 1;
        #53 Address = Address + 1;
        #53 Address = Address + 1;
        #300 $stop;
    end

endmodule
