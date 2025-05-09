
module BFU (
    input clk,
    input [31:0] in_a, in_b,
    input [31:0] twiddle_factor,
    output [31:0] out_a, out_b
);

// Twiddle Factor 1 approximation
// wire [31:0] twiddle_factor_real = (twiddle_factor[31:16] == 16'h7fff) ? 32'h0001_0000 : {{16{twiddle_factor[31]}}, twiddle_factor[30:16], 1'b0};
// wire [31:0] twiddle_factor_imaginary = (twiddle_factor[15:0] == 16'h7fff) ? 32'h0001_0000 : {{16{twiddle_factor[15]}}, twiddle_factor[14:0], 1'b0};

wire [31:0] b_w_product;
wire [31:0] delayed_in_a;


cx_multiplier b_w_multiplier (
    .clk(clk),
    .in1_re(twiddle_factor[15:0]),
    .in1_im(twiddle_factor[31:16]),
    .in2_re(in_b[15:0]),
    .in2_im(in_b[31:16]),
    .product_re(b_w_product[15:0]),
    .product_im(b_w_product[31:16])
);

clk_delay #(
    .DELAY(4),
    .WIDTH(32)
) in_a_delay (
    .clk(clk),
    .clear(1'b0),
    .data_in(in_a),
    .data_out(delayed_in_a)
);

cx_adder in_a_adder (
    .clk(clk),
    .in1_re(delayed_in_a[15:0]),
    .in1_im(delayed_in_a[31:16]),
    .in2_re(b_w_product[15:0]),
    .in2_im(b_w_product[31:16]),
    .sum_re(out_a[15:0]),
    .sum_im(out_a[31:16])
);

cx_subtractor in_b_subtractor (
    .clk(clk),
    .in1_re(delayed_in_a[15:0]),
    .in1_im(delayed_in_a[31:16]),
    .in2_re(b_w_product[15:0]),
    .in2_im(b_w_product[31:16]),
    .diff_re(out_b[15:0]),
    .diff_im(out_b[31:16])
);


endmodule
