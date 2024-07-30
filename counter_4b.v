module counter_4b (
    input clk,
    input reset,
    output reg [3:0] count,
    output reg overflow
);
    reg [4:0] counter;

    initial begin
        counter = 0;
        overflow = 0;
    end

    assign count = counter[3:0];
    assign overflow = counter[4];

    always @(posedge clk) begin
        if (~reset) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule