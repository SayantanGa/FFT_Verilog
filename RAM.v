module RAM (
    input clk,
    input data_a_wr, data_b_wr,
    input [15:0] data_a, data_b, 
    input [4:0] addr_a, addr_b,
    output reg [15:0] data_a_out, data_b_out
);

    reg [15:0] memory [31:0];

    always @(posedge clk) begin
        if (data_a_wr) begin
            memory[addr_a] <= data_a;
        end
        data_a_out <= memory[addr_a];
    end

    always @(posedge clk) begin
        if (data_b_wr) begin
            memory[addr_b] <= data_b;
        end
        data_b_out <= memory[addr_b];
    end

endmodule
