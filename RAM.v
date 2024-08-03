module RAM (
    input clk,
    input data_a_wr, data_b_wr,
    input [15:0] data_a, data_b, 
    input [4:0] addr_a, addr_b,
    output reg [15:0] data_a_out, data_b_out
);

    reg [15:0] memory [31:0];

    initial begin
        memory[0] <= 16'd0;
        memory[1] <= 16'd0;
        memory[2] <= 16'd0;
        memory[3] <= 16'd0;
        memory[4] <= 16'd0;
        memory[5] <= 16'd0;
        memory[6] <= 16'd0;
        memory[7] <= 16'd0;
        memory[8] <= 16'd0;
        memory[9] <= 16'd0;
        memory[10] <= 16'd0;
        memory[11] <= 16'd0;
        memory[12] <= 16'd0;
        memory[13] <= 16'd0;
        memory[14] <= 16'd0;
        memory[15] <= 16'd0;
        memory[16] <= 16'd0;
        memory[17] <= 16'd0;
        memory[18] <= 16'd0;
        memory[19] <= 16'd0;
        memory[20] <= 16'd0;
        memory[21] <= 16'd0;
        memory[22] <= 16'd0;
        memory[23] <= 16'd0;
        memory[24] <= 16'd0;
        memory[25] <= 16'd0;
        memory[26] <= 16'd0;
        memory[27] <= 16'd0;
        memory[28] <= 16'd0;
        memory[29] <= 16'd0;
        memory[30] <= 16'd0;
        memory[31] <= 16'd0;
    end

    always @(posedge clk) begin
        if (data_a_wr) begin
            memory[addr_a] = data_a;
        end
        data_a_out = memory[addr_a];
    end

    always @(posedge clk) begin
        if (data_b_wr) begin
            memory[addr_b] = data_b;
        end
        data_b_out = memory[addr_b];
    end

endmodule
