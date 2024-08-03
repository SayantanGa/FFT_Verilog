module AGU (
    input clk, fft_start,
    output fft_done, mem_wr,
    output [4:0] address_a, address_b,
    output [3:0] twiddle_address
);
    wire AGU_clear_hold;
    wire [3:0] AGU_index_counter_count;
    wire AGU_index_counter_overflow;
    wire AGU_hold_write;

    counter_4b AGU_index_counter (
        .clk(clk),
        .reset(AGU_clear_hold | AGU_hold_write),
        .overflow(AGU_index_counter_overflow),
        .count(AGU_index_counter_count)
    );

    wire [4:0] AGU_wire_1;
    wire [4:0] AGU_wire_2;

    incrementer # (5) AGU_incrementer_1 (
        .din({AGU_index_counter_count, 1'b0}),
        .clk(clk),
        .clr(AGU_clear_hold),
        .dout(AGU_wire_2)
    );

    clk_delay # (1, 5) AGU_delay_1 (
        .clk(clk),
        .clear(AGU_clear_hold),
        .data_in({AGU_index_counter_count, 1'b0}),
        .data_out(AGU_wire_1)
    );

    wire AGU_wire_3;

    dff AGU_dff_1 (
        .clk(clk),
        .D(AGU_index_counter_overflow),
        .reset(1'b1),
        .preset(1'b1),
        .Q(AGU_wire_3)
    );
    
    wire [2:0] AGU_wire_4, AGU_wire_6;
    wire AGU_wire_5;

    counter_3bm5 AGU_counter_1 (
        .clk(AGU_wire_3),
        .reset(AGU_clear_hold),
        .count(AGU_wire_4),
        .overflow(AGU_wire_5)
    );

    clk_delay # (1, 3) AGU_delay_2 (
        .clk(clk),
        .clear(AGU_clear_hold),
        .data_in(AGU_wire_4),
        .data_out(AGU_wire_6)
    );

    rotate_left_5b AGU_rotator_1 (
        .clk(clk),
        .clr (AGU_clear_hold),
        .S(AGU_wire_6),
        .in(AGU_wire_1),
        .out(address_a)
    );
    
    rotate_left_5b AGU_rotator_2 (
        .clk(clk),
        .clr (AGU_clear_hold),
        .S(AGU_wire_6),
        .in(AGU_wire_2),
        .out(address_b)
    );

    wire [3:0] AGU_wire_7;
    right_shift AGU_shifter_1 (
        .clk(AGU_wire3),
        .clr(AGU_clear_hold),
        .s_in(1'b1),
        .p_out(AGU_wire_7)
    );

    assign twiddle_address = AGU_wire_7 & AGU_index_counter_count;

    wire AGU_wire_8;

    counter_4b AGU_counter_2 (
        .clk(clk),
        .reset(~AGU_hold_write),
        .overflow(AGU_wire_8),
        .count()
    );

    srff srff_1 (
        .clk(clk),
        .reset(1'b1),
        .preset(1'b1),
        .S(AGU_index_counter_overflow),
        .R(AGU_wire_8),
        .Q(AGU_hold_write)
    );

    wire AGU_wire_9, AGU_wire_10, AGU_wire_11, AGU_wire_12, AGU_wire_13, AGU_wire_14, AGU_wire_15;

    dff AGU_dff_2 (
        .clk(clk),
        .D(fft_start),
        .reset(1'b1),
        .preset(1'b1),
        .Q(AGU_wire_9)
    );

    dff AGU_dff_3 (
        .clk(clk),
        .D(AGU_wire_9),
        .reset(1'b1),
        .preset(1'b1),
        .Q(AGU_wire_10)
    );

    srff AGU_srff_2 (
        .clk(clk),
        .reset(1'b1),
        .preset(1'b1),
        .S(~AGU_wire_10 & AGU_wire_9),
        .R(AGU_wire_5 & AGU_index_counter_overflow),
        .Q(AGU_wire_11)
    );

    dff AGU_dff_4 (
        .clk(clk),
        .D(AGU_wire_11 & ~AGU_hold_write),
        .reset(~AGU_wire_14),
        .preset(1'b1),
        .Q(AGU_wire_12)
    );
    
    dff AGU_dff_5 (
        .clk(clk),
        .D(AGU_wire_12),
        .reset(~AGU_wire_14),
        .preset(1'b1),
        .Q(mem_wr)
    );

    dff AGU_dff_6 (
        .clk(clk),
        .D(~AGU_wire_11),
        .reset(1'b1),
        .preset(~AGU_wire_9 | AGU_wire_10),
        .Q(AGU_wire_13)
    );

    dff AGU_dff_7 (
        .clk(clk),
        .D(AGU_wire_13),
        .reset(1'b1),
        .preset(~AGU_wire_9 | AGU_wire_10),
        .Q(AGU_wire_14)
    );

    dff AGU_dff_8 (
        .clk(clk),
        .D(AGU_wire_14),
        .reset(1'b1),
        .preset(1'b1),
        .Q(AGU_wire_15)
    );

    dff AGU_dff_9 (
        .clk(clk),
        .D(AGU_wire_15),
        .reset(1'b1),
        .preset(1'b1),
        .Q(fft_done)
    );

    assign AGU_clear_hold = fft_done;

endmodule