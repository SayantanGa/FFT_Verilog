module right_shift (
    clk, clr, s_in, p_out
);
    parameter WIDTH = 4;

    input clk, clr, s_in;
    output reg [WIDTH - 1  : 0] p_out;

    initial begin
        p_out = 0;
    end

    genvar i;

    generate
        for (i = 0; i < WIDTH - 1; i = i + 1) begin
            always @(posedge clk) begin
                p_out[i] <= p_out[i + 1];
                if (clr) begin
                    p_out[i] <= 0;
        end
            end
        end
    endgenerate

    always @(posedge clk) begin
        p_out[WIDTH - 1] <= s_in;
        if (clr) begin
            p_out[WIDTH - 1] <= 0;
        end
    end
endmodule