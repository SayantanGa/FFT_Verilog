module cx_multiplier (
    input clk,
    input [31:0] in1_re, in1_im,
    input [31:0] in2_re, in2_im,
    output reg [31:0] product_re, product_im
);
    // Intermediate registers for signed 32-bit parts and 64-bit results
    reg signed [31:0] in1_re_signed, in1_im_signed, in2_re_signed, in2_im_signed;
    reg signed [63:0] product_re_64, product_im_64;
    reg signed [63:0] re_part1, re_part2, im_part1, im_part2;

    always @* begin
        in1_re_signed = in1_re;
        in1_im_signed = in1_im;
        in2_re_signed = in2_re;
        in2_im_signed = in2_im;

        re_part1 = in1_re_signed * in2_re_signed;
        re_part2 = in1_im_signed * in2_im_signed;
        im_part1 = in1_re_signed * in2_im_signed;
        im_part2 = in1_im_signed * in2_re_signed;

        product_re_64 = re_part1 - re_part2;
        product_im_64 = im_part1 + im_part2;
    end

    always @(posedge clk) begin
        product_re <= product_re_64[31:0];
        product_im <= product_im_64[31:0];
    end

endmodule
