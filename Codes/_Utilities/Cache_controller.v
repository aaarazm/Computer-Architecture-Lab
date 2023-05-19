module Cache_controller (
    clk, rst, address, wdata, MEM_R_EN, MEM_W_EN,
    rdata, ready, sram_address, sram_wdata, write,
    sram_rdata, sram_ready
);
    input clk, rst;

    // memory stage unit
    input [31:0] address, wdata;
    input MEM_R_EN, MEM_W_EN;
    output [31:0] rdata;
    output ready;

    //SRAM Ctrl
    input [31:0] sram_rdata;
    input sram_ready;
    output [31:0] sram_address, sram_wdata;
    output write;

endmodule