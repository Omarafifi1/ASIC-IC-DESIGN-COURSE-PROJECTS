module arith_unit#(parameter in_data_width=16,out_data_width=32)(
input signed [in_data_width-1:0]A,B,
input clk,rst,arith_enable,
input [1:0]alu_fn,
output  carry_out,
output reg arith_flag,
output reg signed[out_data_width-1:0]arith_out
);
assign carry_out=arith_out[in_data_width];

always @(posedge clk , negedge rst) begin
    if(!rst)begin
        arith_flag<=0;
        arith_out<=0;
    end
    else if(arith_enable) begin
        arith_flag<=1;
    case (alu_fn)
        2'b00: arith_out<=A + B;
        2'b01: arith_out<=A - B;
        2'b10: arith_out<=A * B;
        2'b11: arith_out<=A / B;
    endcase
    end
    else begin
        arith_flag<=0;
        arith_out<=0;
    end

end

endmodule