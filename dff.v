module dff (
    input clk, D, reset, preset,
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
        end else begin
            Q <= D;
        end
    end
endmodule