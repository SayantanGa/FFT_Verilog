module srff (
    input clk, reset, preset, S, R,
    output reg Q
);
    initial begin
        Q = 0;
    end

    always @(posedge clk) begin
        if (~reset) begin
            Q <= 0;
        end else if (~preset) begin
            Q <= 1;
        end else if (S & R) begin
            Q <= Q;
        end else if (S) begin
            Q <= 1;
        end else if (R) begin
            Q <= 0;
        end
    end

endmodule