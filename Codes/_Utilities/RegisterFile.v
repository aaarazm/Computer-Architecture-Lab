module RegisterFile #(parameter WORD_SIZE = 32, ADDRESS_SIZE = 4) (
    input [(ADDRESS_SIZE-1):0] src1, src2, Dest_wb,
    input [(WORD_SIZE-1):0] Result_WB,
    input clk, rst, writeBackEn,
    output [(WORD_SIZE-1):0] reg1, reg2
);

    reg [(WORD_SIZE-1):0] memReg [0:((1<<ADDRESS_SIZE)-1)];
    assign reg1 = memReg[src1];    
    assign reg2 = memReg[src2];
    integer i;
    always @(posedge clk) begin
        memReg[0] <= 32'b0;
        if(rst) begin
            for (i=1; i<16; i = i + 1) begin
                memReg[i] <= 0;
            end
        end
        else if(writeBackEn & (Dest_wb != 4'b0)) begin
            memReg[Dest_wb] <= Result_WB;
        end
    end

endmodule