module mux_4ch (
    clk, inA, inB, inC, inD, sel, out
);
    parameter WIDTH = 16;

    input [WIDTH - 1 : 0] inA, inB, inC, inD;
    input clk;
    input [1:0] sel;
    output reg [WIDTH - 1 : 0] out;

    initial
        out <= 0;

    always @(posedge clk) begin
        case (sel)
            2'b00: out <= inA;
            2'b01: out <= inB;
            2'b10: out <= inC;
            2'b11: out <= inD;
            endcase
    end
endmodule