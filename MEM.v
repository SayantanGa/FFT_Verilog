module MEM (
    input clk, load_data_write, bank0_write_en, bank1_write_en, rw_addr_en, bank_read_sel,
    input [15:0] data_real_in, data_imag_in,
    input [4:0] load_data_addr, read_G_addr, write_G_addr, read_H_addr, write_H_addr,
    input [15:0] Xr, Xi, Yr, Yi,
    output [15:0] G_real, G_imag, H_real, H_imag
);
    wire [15:0] dataA0_r, dataA0_i, dataB_r, dataB_i;
    wire [4:0] addr_a0, addr_b0, addr_a1, addr_b1;
    wire bank1_wr, bank0_a_wr, bank0_b_wr;

    clk_delay # (1, 1) MEM_bank0_wr_en_delay (
        .clk(clk),
        .clear(1'b1),
        .data_in(bank0_write_en),
        .data_out(bank0_b_wr)
    );
    
    mux_2ch # (1) MEM_mux_bank0_a_wr (
        .clk(clk),
        .inA(bank0_write_en),
        .inB(1'b1),
        .sel(load_data_write),
        .out(bank0_a_wr)
    )

    mux_2ch # (16) MEM_mux_dataA0_r (
        .clk(clk),
        .inA(Xr),
        .inB(data_real_in),
        .sel(load_data_write),
        .out(dataA0_r)
    );

    mux_2ch # (16) MEM_mux_dataA0_i (
        .clk(clk),
        .inA(Xi),
        .inB(data_imag_in),
        .sel(load_data_write),
        .out(dataA0_i)
    );

    mux_4ch # (5) MEM_mux_addr_A0 (
        .clk(clk),
        .inA(read_G_addr),
        .inB(write_G_addr),
        .inC(load_data_addr),
        .inD(load_data_addr),
        .sel({load_data_write, rw_addr_en}),
        .out(addr_a0)
    );

    mux_4ch # (5) MEM_mux_addr_A1 (
        .clk(clk),
        .inA(read_G_addr),
        .inB(write_G_addr),
        .inC(load_data_addr),
        .inD(load_data_addr),
        .sel({rw_addr_en, load_data_write}),
        .out(addr_a1)
    );

    mux_2ch # (16) MEM_mux_addr_B0 (
        .clk(clk),
        .inA(read_H_addr),
        .inB(write_H_addr),
        .sel(rw_addr_en),
        .out(addr_b0)
    );

    mux_2ch # (16) MEM_mux_addr_B1 (
        .clk(clk),
        .inA(read_H_addr),
        .inB(write_H_addr),
        .sel(rw_addr_en),
        .out(addr_b1)
    );

    clk_delay # (1, 16) MEM_delay_1 (
        .clk(clk),
        .clear(1'b1),
        .data_in(Yr),
        .data_out(dataB_r)
    );
    
    clk_delay # (1, 16) MEM_delay_2 (
        .clk(clk),
        .clear(1'b1),
        .data_in(Yi),
        .data_out(dataB_i)
    );

    clk_delay # (1, 16) MEM_delay_3 (
        .clk(clk),
        .clear(1'b1),
        .data_in(Xr),
        .data_out(dataB_r)
    );

    clk_delay # (1, 16) MEM_delay_4 (
        .clk(clk),
        .clear(1'b1),
        .data_in(Xi),
        .data_out(dataB_i)
    );

    clk_delay # (1, 16) MEM_delay_5 (
        .clk(clk),
        .clear(1'b1),
        .data_in(bank1_write_en),
        .data_out(bank1_wr)
    );

    wire [15:0] out_r11, out_r12, out_r21, out_r22, out_r31, out_r32, out_r41, out_r42;

    RAM MEM_RAM_1 (
        .clk(clk),
        .data_a_wr(bank0_a_wr),
        .data_b_wr(bank0_b_wr),
        .data_a(dataA0_r),
        .data_b(dataB_r),
        .addr_a(addr_a0),
        .addr_b(addr_b0),
        .data_a_out(out_r11),
        .data_b_out(out_r12)
    );

    RAM MEM_RAM_2 (
        .clk(clk),
        .data_a_wr(bank0_a_wr),
        .data_b_wr(bank0_b_wr),
        .data_a(dataA0_i),
        .data_b(dataB_i),
        .addr_a(addr_a0),
        .addr_b(addr_b0),
        .data_a_out(out_r21),
        .data_b_out(out_r22)
    );

    RAM MEM_RAM_3 (
        .clk(clk),
        .data_a_wr(bank1_wr),
        .data_b_wr(bank1_wr),
        .data_a(dataB_r),
        .data_b(dataB_r),
        .addr_a(addr_a1),
        .addr_b(addr_b1),
        .data_a_out(out_r31),
        .data_b_out(out_r32)
    );

    RAM MEM_RAM_4 (
        .clk(clk),
        .data_a_wr(bank1_wr),
        .data_b_wr(bank1_wr),
        .data_a(datab_i),
        .data_b(dataB_i),
        .addr_a(addr_a1),
        .addr_b(addr_b1),
        .data_a_out(out_r41),
        .data_b_out(out_r42)
    );

    mux_2ch # (16) MEM_mux_G_real (
        .clk(clk),
        .inA(out_r11),
        .inB(out_r31),
        .sel(bank_read_sel),
        .out(G_real)
    );

    mux_2ch # (16) MEM_mux_H_real (
        .clk(clk),
        .inA(out_r12),
        .inB(out_r32),
        .sel(bank_read_sel),
        .out(H_real)
    );

    mux_2ch # (16) MEM_mux_G_imag (
        .clk(clk),
        .inA(out_r21),
        .inB(out_r41),
        .sel(bank_read_sel),
        .out(G_imag)
    );

    mux_2ch # (16) MEM_mux_H_imag (
        .clk(clk),
        .inA(out_r22),
        .inB(out_r42),
        .sel(bank_read_sel),
        .out(H_imag)
    );
endmodule