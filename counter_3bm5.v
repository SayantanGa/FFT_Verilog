module counter_3bm5 (
    input clk, reset,
    output reg [2:0] count,
    output reg overflow
);
    reg [3:0] counter;

    initial begin
        counter = 0;
        overflow = 0;
    end

    assign count = counter[2:0];
    assign overflow = counter[3];

    always @(posedge clk) begin
        if (~reset) begin
            counter <= 0;
        end else if (counter == 4'b0100) begin
            counter <= 4'b1000;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule