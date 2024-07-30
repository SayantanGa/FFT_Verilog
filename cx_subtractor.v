module cx_subtractor (
    input clk,
    input [31:0] in1_re, in1_im,
    input [31:0] in2_re, in2_im,
    output reg [31:0] diff_re, diff_im
);
    always @(posedge clk) begin
        sum_re <= in1_re - in2_re;
        sum_im <= in1_im - in2_im;
    end
endmodule