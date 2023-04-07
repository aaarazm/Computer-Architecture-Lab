module StatusReg (clk, rst, S, SR_In, SR_Out);
    input clk, rst, S;
    input [3:0] SR_In;
    output reg [3:0] SR_Out;

    always@(posedge clk, posedge rst) begin
        if(rst)
            SR_Out <= 4'b0100;
        else if(S)
            SR_Out <= SR_In;
    end

endmodule