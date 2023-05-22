module Cache_controller (
    clk, rst, address, writeData, MEM_R_EN,
    MEM_W_EN, ready, sram_readData,
    sram_ready, sram_address, sram_writeData,
    SRAM_readEn, SRAM_writeEn, isHit,
    cache_readData, cache_writeEn, cache_writeData,
    cache_address, LRU_update, invalidate
);
    input clk, rst;

    // memory stage unit
    input [31:0] address, writeData;
    input MEM_R_EN, MEM_W_EN;
    output ready;

    //SRAM Ctrl
    input [31:0] sram_readData;
    input sram_ready;
    output [31:0] sram_address, sram_writeData;
    output reg SRAM_readEn, SRAM_writeEn;

    //Cache
    input isHit; // ??
    input[31:0] cache_readData;

    output reg cache_writeEn;
    output[63:0] cache_writeData;
    output[17:0] cache_address;
    output LRU_update;
    output reg invalidate;


    reg [31:0] dataLSB, dataMSB;
    reg loadLSB, loadMSB, offset;

    assign sram_writeData = writeData;
    assign sram_address = {address[31:3], offset, 2'b0};
    assign cache_address = address[19:2];
    assign cache_writeData = {dataMSB, dataLSB};
    assign LRU_update = (MEM_R_EN & isHit) ? 1'b1:1'b0;
    assign ready = 


    reg [2:0] ps, ns;

    localparam [2:0] idle = 0, writeState = 1, readState1 = 2, readState2 = 3, cache_writeBack = 4;

    always @* begin
        case (ps)
            idle: begin
                ns = (MEM_W_EN) ? writeState:
                    (MEM_R_EN & ~isHit) ? readState1:idle;
            writeState: begin
                ns = (sram_ready) ? idle:writeState;
            end 
            readState1: begin
                ns = (sram_ready) ? readState2:readState1;
            end
            readState2: begin
                ns = (sram_ready) ? cache_writeBack:readState2;
            end
            cache_writeBack: begin
                ns = idle;
            end
            end
            default: ns = idle;
        endcase
    end

    always @(ps, ns) begin
        {invalidate, cache_writeEn, loadMSB, loadLSB, offset, SRAM_writeEn, SRAM_readEn} = 7'b0;
        case (ps)
            idle: begin
                invalidate = (ns == writeState) ? 1'b1:1'b0;
                SRAM_writeEn = (ns == writeState) ? 1'b1:1'b0;
                SRAM_readEn = (ns == readState1) ? 1'b1:1'b0;
            end
            readState1: begin
                loadLSB = (ns == readState2) ? 1'b1:1'b0;
            end
            readState2: begin
                loadMSB = (ns == cache_writeBack) ? 1'b1:1'b0;
                offset = 1'b1;
            end
            cache_writeBack: begin
                cache_writeEn = 1'b1;
            end
            default: {invalidate, cache_writeEn, loadMSB, loadLSB, offset, SRAM_writeEn, SRAM_readEn} = 7'b0;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            dataLSB <= 32'b0
            dataMSB <= 32'b0
        end
        else if (loadLSB) begin
            dataLSB <= sram_readData;
        end
        else if (loadMSB) begin
            dataMSB <= sram_readData;
        end
    end

    always @(posedge clk) begin
        if (rst)
            ps <= idle;
        else
            ps <= ns;
    end


endmodule