module tff (
    input clk, t,
    output reg q
);
    initial
        q <= 0;

    always @(posedge clk ) begin
        if (t) begin
            q <= ~q;
        end else begin
            q <= q;
        end
    end 
endmodule