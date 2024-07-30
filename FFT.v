module FFT (
    input clk, fft_start,
    input [4:0] load_data_addr,
    input [15:0] data_real_in, data_imag_in,
    output fft_done,
);
    wire [15:0] tw_real, tw_imag;
    wire [3:0] tw_address;

    ROM FFT_ROM_twiddle (
        .address(tw_address),
        .data_re(tw_real),
        .data_im(tw_imag)
    );

    wire FFT_mem_write;

    // AGU FFT_AGU (
    //     .clk(clk),
    //     .fft_start(fft_start),
    //     .fft_done(fft_done),
    //     .mem_wr(FFT_mem_write),
    //     .address_a(load_data_addr),
    //     .address_b(load_data_addr),
    //     .twiddle_address(tw_address),
    //     .twiddle_real(tw_real),
    //     .twiddle_imag(tw_imag)
    // )
endmodule