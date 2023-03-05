module RegisterFile #(parameter WORD_SIZE = 32, ADDRESS_SIZE = 4) (
    input [(ADDRESS_SIZE-1):0] src1, src2, Dest_wb,
    input [(WORD_SIZE-1):0] Result_WB,
    input clk, rst, writeBackEn,
    output [(WORD_SIZE-1):0] reg1, reg2
);

    //reg [(WORD_SIZE-1):0] memReg [0:((1<<ADDRESS_SIZE)-1)];
    reg [(WORD_SIZE-1):0] memReg [0:14];

    assign reg1 = memReg[src1];    
    assign reg2 = memReg[src2];

    integer i;

    always @(negedge clk, posedge rst) begin
        memReg[0] <= 0;
        if(rst) begin
            for (i=0; i<15; i = i + 1) begin
                memReg[i] <= i;
            end
        end
        if(writeBackEn && (Dest_wb != 0)) begin
            memReg[Dest_wb] <= Result_WB;
        end
    end

endmodule