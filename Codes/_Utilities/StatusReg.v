module StatusReg (clk, rst, S, SR_In, SR_Out); // N, Z, C, V
    input clk, rst, S;
    input [3:0] SR_In;
    output reg [3:0] SR_Out;

    always@(negedge clk, posedge rst) begin
        if(rst)
            SR_Out <= 4'b0100;
        else if(S)
            SR_Out <= SR_In;
    end

endmodule