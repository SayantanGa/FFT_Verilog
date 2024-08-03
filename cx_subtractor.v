module cx_subtractor (
    input clk,
    input [15:0] in1_re, in1_im,
    input [15:0] in2_re, in2_im,
    output reg [15:0] diff_re, diff_im
);

    initial
        {diff_re, diff_im} = 32'd0;
    always @(posedge clk) begin
        diff_re <= in1_re - in2_re;
        diff_im <= in1_im - in2_im;
    end
endmodule