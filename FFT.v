module FFT (
    input clk, fft_start, load_data_write,
    input [4:0] load_data_addr,
    input [15:0] data_real_in, data_imag_in,
    output fft_done
);
    wire [15:0] tw_real, tw_imag;
    wire [3:0] tw_address;

    ROM FFT_ROM_twiddle (
        .address(tw_address),
        .data_re(tw_real),
        .data_im(tw_imag)
    );

    wire FFT_mem_write;
    wire [4:0] FFT_mem_a_address, FFT_mem_b_address;

    AGU FFT_AGU (
        .clk(clk),
        .fft_start(fft_start),
        .fft_done(fft_done),
        .mem_wr(FFT_mem_write),
        .address_a(FFT_mem_a_address),
        .address_b(FFT_mem_b_address),
        .twiddle_address(tw_address)
    );

    wire [15:0] FFT_G_real, FFT_G_imag, FFT_H_real, FFT_H_imag, FFT_Xr, FFT_Xi, FFT_Yr, FFT_Yi;

    BFU FFT_BFU (
        .clk(clk),
        .in_a({FFT_G_imag, FFT_G_real}),
        .in_b({FFT_H_imag, FFT_H_real}),
        .twiddle_factor({tw_real, tw_imag}),
        .out_a({FFT_Xi, FFT_Xr}),
        .out_b({FFT_Yi, FFT_Yr})
    );
    
    wire FFT_bank_wr_en;

    clk_delay # (8, 1) FFT_delay_1(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_mem_write),
        .data_out(FFT_bank_wr_en)
    );

    wire FFT_wire_1, FFT_wire_2;

    clk_delay # (7, 1) FFT_delay_2(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_mem_write),
        .data_out(FFT_wire_1)
    );
    
    wire [4:0] FFT_write_G_address, FFT_write_H_address;

    clk_delay # (9, 5) FFT_delay_3(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_mem_a_address),
        .data_out(FFT_write_G_address)
    );

    clk_delay # (9, 5) FFT_delay_4(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_mem_b_address),
        .data_out(FFT_write_H_address)
    );

    wire [15:0] FFT_Xr_del, FFT_Xi_del, FFT_Yr_del, FFT_Yi_del;

    clk_delay # (1, 16) FFT_delay_51(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_Xr),
        .data_out(FFT_Xr_del)
    );

    clk_delay # (1, 16) FFT_delay_52(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_Xi),
        .data_out(FFT_Xi_del)
    );

    clk_delay # (1, 16) FFT_delay_53(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_Yr),
        .data_out(FFT_Yr_del)
    );

    clk_delay # (1, 16) FFT_delay_54(
        .clk(clk),
        .clear(1'b0),
        .data_in(FFT_Yi),
        .data_out(FFT_Yi_del)
    );

    dff FFT_dff (
        .clk(clk),
        .D(FFT_wire_1),
        .Q(FFT_wire_2)
    );

    wire FFT_mem_bank_read_sel;

    tff FFT_tff (
        .clk(clk),
        .t(~FFT_wire_1 & FFT_wire_2),
        .q(FFT_mem_bank_read_sel)
    );

    MEM FFT_MEM(
        .clk(clk),
        .load_data_write(load_data_write),
        .bank0_write_en(FFT_bank_wr_en & FFT_mem_bank_read_sel),
        .bank1_write_en(FFT_bank_wr_en & ~FFT_mem_bank_read_sel),
        .rw_addr_en(FFT_mem_bank_read_sel),
        .bank_read_sel(FFT_mem_bank_read_sel),
        .data_real_in(data_real_in),
        .data_imag_in(data_imag_in),
        .load_data_addr(load_data_addr),
        .read_G_addr(FFT_mem_a_address),
        .write_G_addr(FFT_write_G_address),
        .read_H_addr(FFT_mem_b_address),
        .write_H_addr(FFT_write_H_address),
        .Xr(FFT_Xr_del),
        .Xi(FFT_Xi_del),
        .Yr(FFT_Yr_del),
        .Yi(FFT_Yi_del),
        .G_real(FFT_G_real),
        .G_imag(FFT_G_imag),
        .H_real(FFT_H_real),
        .H_imag(FFT_H_imag)
    );

endmodule