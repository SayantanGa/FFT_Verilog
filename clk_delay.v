module clk_delay (
    clk, clear,
    data_in,
    data_out
);
    parameter DELAY = 1;
    parameter WIDTH = 32;

    input clk, clear;
    input [WIDTH-1:0] data_in;
    output reg [WIDTH-1:0] data_out;

    reg [WIDTH-1:0] DFF[DELAY-1:0];

    integer i;

    always @(posedge clk) begin
        if (clear) begin
            for (i = 0; i < DELAY; i = i + 1) begin
                DFF[i] <= 0;
            end
            data_out <= 0;
        end else begin
            DFF[0] <= data_in;
            for (i = 1; i < DELAY; i = i + 1) begin
                DFF[i] <= DFF[i-1];
            end
            data_out <= DFF[DELAY-1];
        end
    end

endmodule
