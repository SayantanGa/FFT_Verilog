module ROM (
    input [3:0] address,
    output [15:0] data_re, data_im
);
    reg [31:0] memory [0:15];

    initial begin
        memory[0] = 32'h7fff0000;
        memory[1] = 32'h7d891859;
        memory[2] = 32'h764130fb;
        memory[3] = 32'h6a6d471c;
        memory[4] = 32'h5a825a82;
        memory[5] = 32'h47136a6d;
        memory[6] = 32'h30fb7641;
        memory[7] = 32'h18f97d89;
        memory[8] = 32'h00007fff;
        memory[9] = 32'he7077d89;
        memory[10] = 32'hcf057641;
        memory[11] = 32'hb8e46a6d;
        memory[12] = 32'ha57e5a82;
        memory[13] = 32'h9593471c;
        memory[14] = 32'h89bf30fb;
        memory[15] = 32'h82771859;
    end

    assign data_re = memory[address][15:0];
    assign data_im = memory[address][31:16];

endmodule