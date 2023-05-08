module freq_divider (sys_clk, clk_out);
    input sys_clk;
    output reg clk_out;

    reg nstate, pstate;

    always @(posedge sys_clk) begin
        nstate = 0;
        case (pstate)
            0:nstate=1;
            1:nstate=0;
        endcase
    end

    always @(pstate) begin
        clk_out = 0;
        case (pstate)
            0:clk_out=0;
            1:clk_out=1;
        endcase
    end

    always @(posedge sys_clk) begin
        pstate = nstate;
    end

endmodule