module forwarding_unit(src1, src2, forward_EN, MEM_WB_EN, MEM_Dest, WB_WB_EN, WB_Dest, forward1, forward2);
    input WB_WB_EN, MEM_WB_EN, forward_EN;
    input [3:0] src1, src2, WB_Dest, MEM_Dest;

    output reg [1:0] forward1, forward2;

    always @* begin
        forward1 = 2'b00; forward2 = 2'b00;
        if ((src1 == MEM_Dest) & MEM_WB_EN & forward_EN)
            forward1 <= 2'b01;
        else if ((src1 == WB_Dest) & WB_WB_EN & forward_EN)
            forward1 <= 2'b10;
        if ((src2 == MEM_Dest) & MEM_WB_EN & forward_EN)
            forward2 <= 2'b01;
        else if ((src2 == WB_Dest) & WB_WB_EN & forward_EN)
            forward2 <= 2'b10;
    end

endmodule