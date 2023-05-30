module Cache_controller (
    clk, rst, address, writeData, MEM_R_EN,
    MEM_W_EN, ready, sram_readData,
    sram_ready, sram_address, sram_writeData,
    sram_readEn, sram_writeEn, isHit,
    cache_writeEn, cache_writeData,
    cache_address, LRU_update, invalidate
);
    input clk, rst;

    // memory stage unit
    input [31:0] address, writeData;
    input MEM_R_EN, MEM_W_EN;
    output ready;

    //sram Ctrl
    input [31:0] sram_readData;
    input sram_ready;
    output [31:0] sram_address, sram_writeData;
    output sram_readEn, sram_writeEn;

    //Cache
    input isHit; // ??

    output reg cache_writeEn;
    output[63:0] cache_writeData;
    output[17:0] cache_address;
    output LRU_update;
    output reg invalidate;


    reg [2:0] ps, ns;
    reg [31:0] dataLSB, dataMSB;
    reg loadLSB, loadMSB, offset;

    localparam [2:0] idle = 0, writeState = 1, readState1 = 2, readPause = 3, readState2 = 4, cache_writeBack = 5, writeBackPause = 6;

    assign sram_writeData = writeData;
    assign sram_address = (MEM_W_EN) ? {address[31:2], 2'b0}:{address[31:3], offset, 2'b0};
    assign sram_writeEn = (ns == writeState) ? 1'b1:1'b0;
    assign sram_readEn = (ns == readState1) | (ps == readPause) ? 1'b1:1'b0;

    assign cache_address = address[19:2];
    assign cache_writeData = {dataMSB, dataLSB};
    assign LRU_update = ns == writeBackPause ? 1'b1:1'b0;
    assign ready = (isHit | sram_ready) & (ns == idle) ? 1'b1:1'b0;

    always @* begin
        case (ps)
            idle: begin
                ns = (MEM_W_EN) ? writeState:
                    (MEM_R_EN & ~isHit) ? readState1:idle;
            end
            writeState: begin
                ns = (sram_ready) ? idle:writeState;
            end 
            readState1: begin
                ns = (sram_ready) ? readPause:readState1;
            end
            readPause: begin
                ns = readState2;
            end
            readState2: begin
                ns = (sram_ready) ? cache_writeBack:readState2;
            end
            cache_writeBack: begin
                ns = writeBackPause;
            end
            writeBackPause: begin
                ns = idle;
            end
            default: ns = idle;
        endcase
    end

    always @(ps, ns) begin
        {invalidate, cache_writeEn, loadMSB, loadLSB, offset} = 5'b0;
        case (ps)
            idle: begin
                invalidate = (ns == writeState) ? 1'b1:1'b0;
            end
            readState1: begin
                loadLSB = (ns == readPause) ? 1'b1:1'b0;
            end
            readState2: begin
                loadMSB = (ns == cache_writeBack) ? 1'b1:1'b0;
                offset = 1'b1;
            end
            cache_writeBack: begin
                cache_writeEn = 1'b1;
            end
            default: {invalidate, cache_writeEn, loadMSB, loadLSB, offset} = 5'b0;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            dataLSB <= 32'b0;
            dataMSB <= 32'b0;
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