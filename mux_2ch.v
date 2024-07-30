module mux_2ch (
    clk, inA, inB, sel, out
);
    parameter WIDTH = 16;

    input [WIDTH - 1 : 0] inA, inB;
    input clk, sel;
    output [WIDTH - 1 : 0] out;

    always @(posedge clk) begin
        if (sel) begin
            out <= inB;
        end
        else begin
            out <= inA;
        end
    end

endmodule