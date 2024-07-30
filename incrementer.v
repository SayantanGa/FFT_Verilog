module incrementer (
    din, clk, clr, dout
);

    parameter WIDTH = 5;

    input [WIDTH-1:0] din;
    input clk, clr;
    output reg [WIDTH-1:0] dout;

    initial begin
        dout <= {{(WIDTH - 1){1'b0}}, 1'b1};
    end

    always @(posedge clk) begin
        if (clr) begin
            dout <= {{(WIDTH - 1){1'b0}}, 1'b1};
        end
        else begin
            dout <= din + {{(WIDTH - 1){1'b0}}, 1'b1};
        end
    end
endmodule