module counter_4b (
    input clk,
    input reset,
    output [3:0] count,
    output overflow
);
    reg [4:0] counter;

    initial
        counter <= 0;

    assign count = counter[3:0];
    assign overflow = counter[4];

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule