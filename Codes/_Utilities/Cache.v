module Cache (clk, address, ReadData, WriteData, isHit);
    input clk;
    input [17:0] address;
    input [31:0] WriteData;

    output [31:0] ReadData;
    output isHit; // ?

    reg [152:0] cache [0:63];

    wire offset, LRU, valid0, valid1, hit0, hit1;
    wire [5:0] index;
    wire [10:0] tag;
    wire [10:0] tag0, tag1;
    wire [63:0] data0, data1;

    reg [152:0] readValue;

    assign {tag, index, offset} = address;

    assign readValue = cache[index]; 
    
    assign {data0, tag0, valid0, data1, tag1, valid1, LRU} = readValue;

    assign hit0 = ((tag0 == tag) & valid0) ? 1'b1:1'b0;
    assign hit1 = ((tag1 == tag) & valid1) ? 1'b1:1'b0;

    assign isHit = hit0 | hit1;

    assign ReadData = (hit0 & ~offset) ? data0[31:0]:
                    (hit0 & offset) ? data0[63:32]:
                    (hit1 & ~offset) ? data1[31:0]:
                    (hit1 & offset) ? data1[63:32]: 'bz;

    

endmodule