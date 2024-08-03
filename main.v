module main (
    
);
    reg clk, fft_start, load_data_write;
    wire fft_done;
    reg [4:0] load_data_addr;
    reg [15:0] data_real_in, data_imag_in;

    FFT FFT (
        .clk(clk),
        .fft_start(fft_start),
        .load_data_write(load_data_write),
        .load_data_addr(load_data_addr),
        .data_real_in(data_real_in),
        .data_imag_in(data_imag_in),
        .fft_done(fft_done)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 1'b0;
        fft_start = 1'b0;
        load_data_write = 1'b0;
        load_data_addr = 5'b0;
        data_real_in = 16'b0;
        data_imag_in = 16'b0;

        #10
        load_data_write = 1'b1;
        data_real_in = 16'h03ff;
        
        #2 load_data_addr = 5'h1;
        #2 load_data_addr = 5'h2;
        #2 load_data_addr = 5'h3;
        #2 load_data_addr = 5'h4;
        #2 load_data_addr = 5'h5;
        #2 load_data_addr = 5'h6;
        #2 load_data_addr = 5'h7;
        #2 load_data_addr = 5'h8;
        #2 load_data_addr = 5'h9;
        #2 load_data_addr = 5'ha;
        #2 load_data_addr = 5'hb;
        #2 load_data_addr = 5'hc;
        #2 load_data_addr = 5'hd;
        #2 load_data_addr = 5'he;
        #2 load_data_addr = 5'hf;
        data_real_in = 16'hfc01;
        #2 load_data_addr = 5'h11;
        #2 load_data_addr = 5'h12;
        #2 load_data_addr = 5'h13;
        #2 load_data_addr = 5'h14;
        #2 load_data_addr = 5'h15;
        #2 load_data_addr = 5'h16;
        #2 load_data_addr = 5'h17;
        #2 load_data_addr = 5'h18;
        #2 load_data_addr = 5'h19;
        #2 load_data_addr = 5'h1a;
        #2 load_data_addr = 5'h1b;
        #2 load_data_addr = 5'h1c;
        #2 load_data_addr = 5'h1d;
        #2 load_data_addr = 5'h1e;
        #2 load_data_addr = 5'h1f;
        #2 load_data_write = 1'b0;
        #2 load_data_addr = 5'h0;
        
        #10 fft_start = 1'b1;
        #4 fft_start = 1'b0;
               
        #500
        $finish;
    end

        

endmodule
