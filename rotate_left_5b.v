module rotate_left_5b (
    input clk, clr,
    input [2:0] S,
    input [4:0] in,
    output [4:0] out
);
    initial begin
        out = in;
    end

    always @(posedge clk) begin
        if(clr) begin
            out <= in;
        end else if(S == 2'b00) begin
            out <= {in[3:0], in[4]};
        end else if(S == 2'b01) begin
            out <= {in[2:0], in[4:3]};
        end else if(S == 2'b10) begin
            out <= {in[1:0], in[4:2]};
        end else begin
            out <= {in[0], in[4:1]};
        end
    end
endmodule