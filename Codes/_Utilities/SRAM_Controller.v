module SRAM_Controller (clk, rst, SRAM_WE_N, writeEn, readEn, address, WriteData, ReadData, ready, SRAM_DQ, SRAM_ADDR);
    input clk, rst;
    input writeEn, readEn;
    input [31:0] address, WriteData;

    output reg [31:0] ReadData;
    output reg SRAM_WE_N;

    output ready;
    inout [15:0] SRAM_DQ;
    output reg [17:0] SRAM_ADDR;

    parameter [2:0] idle = 0, w1 = 1, w2 = 2, r1 = 3, r2 = 4, r3 = 5;

    reg [2:0] ns, ps;

    always @(writeEn, readEn) begin : next_state
        ns = idle;
        case (ps)
            idle: begin
                if (~writeEn & ~readEn)
                    ns = idle;
                else if (writeEn)
                    ns = w1;
                else
                    ns = r1;
            end
            w1: ns = w2;
            w2: ns = idle;
            r1: ns = r2;
            r2: ns = r3;
            r3: ns = idle;
        endcase
    end

    always @(ps) begin : signals
        SRAM_ADDR = 18'b0; ReadData = 32'b0; SRAM_WE_N = 1'b0;
        case (ps)
            w1: begin
                SRAM_ADDR = {address[16:0], 1'b0};
            end
            w2: begin
                SRAM_ADDR = {address[16:0], 1'b1};
            end
            r1: begin
                SRAM_ADDR = {address[16:0], 1'b0};
                SRAM_WE_N = 1'b1;
            end
            r2: begin
                SRAM_ADDR = {address[16:0], 1'b1};
                SRAM_WE_N = 1'b1;
                ReadData[15:0] = SRAM_DQ;
            end
            r3: begin
                SRAM_WE_N = 1'b1;
                ReadData[31:16] = SRAM_DQ;
            end
        endcase
    end

    always @(posedge clk, posedge rst) begin
        if (rst)
            ps <= idle;
        else
            ps <= ns;
    end

    assign SRAM_DQ = (ps == w1) ? WriteData[15:0]:
                (ps == w2) ? WriteData[31:16]:16'bz;
                
    assign ready = (ps == idle) ? 1'b1:1'b0;

endmodule
