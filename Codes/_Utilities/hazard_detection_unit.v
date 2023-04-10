module hazard_detection_unit(
    src1, src2, EXE_Dest, MEM_Dest, EXE_WB_EN, MEM_WB_EN, Two_src, hazard_detected
);
    input EXE_WB_EN, MEM_WB_EN, Two_src;
    input [3:0] src1, src2, EXE_Dest, MEM_Dest;
    output reg hazard_detected;

    always @* begin // (src1, src2, EXE_Dest, MEM_Dest, EXE_WB_EN, MEM_WB_EN, Two_src)
        hazard_detected = 1'b0;
        if((src1 == EXE_Dest) & EXE_WB_EN)
            hazard_detected = 1'b1;
        if((src1 == MEM_Dest) & MEM_WB_EN)
            hazard_detected = 1'b1;
        if((src2 == EXE_Dest) & EXE_WB_EN & Two_src)
            hazard_detected = 1'b1;
        if((src2 == MEM_Dest) & MEM_WB_EN & Two_src)
            hazard_detected = 1'b1;
    end

endmodule