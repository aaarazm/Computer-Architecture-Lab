`timescale 1ns/1ns
module PC_Branch_Addr_tb();
    reg [31:0] pc, signed_immed_24;
    wire [31:0] Branch_Address;

    PC_Branch_Addr uut (
        .PC(pc),
        .signed_immed_24(signed_immed_24),
        .Branch_Address(Branch_Address)
    );

    initial begin
        pc = 32'd1000; signed_immed_24 = 0;
        #5 signed_immed_24 = 32'd500;
        #100 $stop;
    end

endmodule