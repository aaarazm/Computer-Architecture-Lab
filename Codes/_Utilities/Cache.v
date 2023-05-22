module Cache (clk, rst, LRU_update, invalidate, writeEn, address, ReadData, WriteData, isHit);
    input clk, rst, LRU_update, invalidate, writeEn;
    input [17:0] address;
    input [63:0] WriteData;

    output [31:0] ReadData;
    output isHit; // ?

    reg [75:0] cache0 [0:63];
    reg [75:0] cache1 [0:63];
    reg [63:0] LRU;

    wire offset, valid0, valid1, hit0, hit1;
    wire [5:0] index;
    wire [10:0] tag; // 11 bit tag, 6 bit index, 1 bit offset
    wire [10:0] tag0, tag1;
    wire [63:0] data0, data1;


    assign {tag, index, offset} = address;

    
    assign {data0, tag0, valid0} = cache0[index];
    assign {data1, tag1, valid1} = cache1[index];

    assign hit0 = ((tag0 == tag) & valid0) ? 1'b1:1'b0;
    assign hit1 = ((tag1 == tag) & valid1) ? 1'b1:1'b0;

    assign isHit = hit0 | hit1;

    assign ReadData = (hit0 & ~offset) ? data0[31:0]:
                    (hit0 & offset) ? data0[63:32]:
                    (hit1 & ~offset) ? data1[31:0]:
                    (hit1 & offset) ? data1[63:32]: 'bz;

    always @(posedge clk) begin
        if (writeEn & LRU[index]) begin
            cache0[index] <= {WriteData, tag, 1'b1};
        end
        else if (writeEn & ~LRU[index]) begin
            cache1[index] <= {WriteData, tag, 1'b1};
        end
        if (invalidate & hit0) begin
            valid0 <= 1'b0;
        end
        if (invalidate & hit1) begin
            valid1 <= 1'b0;
        end
        if (LRU_update) begin
            LRU[index] <= (hit0) ? 1'b0:1'b1;
        end
    end

    integer i;
    initial begin
        for(i=0;i<64;i=i+1)begin
            cache0[i] = 76'b0;
            cache1[i] = 76'b0;
            LRU[i] = 1'b0;
        end
    end
    

endmodule