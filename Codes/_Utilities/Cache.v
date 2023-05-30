module Cache (clk, rst, LRU_update, invalidate, MEM_R_EN, writeEn, address, ReadData, WriteData, isHit);
    input clk, rst, LRU_update, invalidate, writeEn, MEM_R_EN;
    input [17:0] address;
    input [63:0] WriteData;

    output [31:0] ReadData;
    output isHit; // ?

    reg [63:0] cache0_data [0:63];
    reg [10:0] cache0_tag [0:63];
    reg cache0_valid [0:63];
    reg [63:0] cache1_data [0:63];
    reg [10:0] cache1_tag [0:63];
    reg cache1_valid [0:63];
    reg [63:0] LRU;

    wire offset, valid0, valid1, hit0, hit1;
    wire [5:0] index;
    wire [10:0] tag; // 11 bit tag, 6 bit index, 1 bit offset
    wire [10:0] tag0, tag1;
    wire [63:0] data0, data1;


    assign {tag, index, offset} = address;

    
    assign data0 = cache0_data[index];
    assign tag0 = cache0_tag[index];
    assign valid0 = cache0_valid[index];

    assign data1 = cache1_data[index];
    assign tag1 = cache1_tag[index];
    assign valid1 = cache1_valid[index];

    assign hit0 = ((tag0 == tag) & valid0) ? 1'b1:1'b0;
    assign hit1 = ((tag1 == tag) & valid1) ? 1'b1:1'b0;

    assign isHit = hit0 | hit1;

    assign ReadData = (hit0 & ~offset) ? data0[31:0]:
                    (hit0 & offset) ? data0[63:32]:
                    (hit1 & ~offset) ? data1[31:0]:
                    (hit1 & offset) ? data1[63:32]: 'bz;

    always @(posedge clk) begin
        if (writeEn & LRU[index]) begin
            {cache0_data[index], cache0_tag[index], cache0_valid[index]} <= {WriteData, tag, 1'b1};
            LRU[index] <= 1'b0;
        end
        else if (writeEn & ~LRU[index]) begin
            {cache1_data[index], cache1_tag[index], cache1_valid[index]} <= {WriteData, tag, 1'b1};
            LRU[index] <= 1'b1;
        end
        else if (invalidate & hit0) begin
            cache0_valid[index] <= 1'b0;
            // LRU[index] <= 1'b1;
        end
        else if (invalidate & hit1) begin
            cache1_valid[index] <= 1'b0;
            // LRU[index] <= 1'b0;
        end
        else if (MEM_R_EN & isHit) begin
            LRU[index] <= (hit0) ? 1'b0:1'b1;
        end
        else if (LRU_update) begin
            LRU[index] <= (hit0) ? 1'b0:1'b1;
        end
    end

    integer i;
    initial begin
        for(i=0;i<64;i=i+1)begin
            {cache0_data[i], cache0_tag[i], cache0_valid[i]} = 76'b0;
            {cache1_data[i], cache1_tag[i], cache1_valid[i]} = 76'b0;
            LRU[i] = 1'b0;
        end
    end
    

endmodule