module InstructionMem (Address, Instruction);
    input [31:0] Address;
    output reg [31:0] Instruction;

    always @(Address) begin
        case (Address)
            32'h00000000: Instruction = 32'b000000_00001_00010_00000_00000000000;
            32'h00000004: Instruction = 32'b000000_00011_00100_00000_00000000000;
            32'h00000008: Instruction = 32'b000000_00101_00110_00000_00000000000;
            32'h0000000C: Instruction = 32'b000000_00111_01000_00010_00000000000;
            32'h00000010: Instruction = 32'b000000_01001_01010_00011_00000000000;
            32'h00000014: Instruction = 32'b000000_01011_01100_00000_00000000000;
            32'h00000018: Instruction = 32'b000000_01101_01110_00000_00000000000;
            default: Instruction = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
        endcase
    end

endmodule