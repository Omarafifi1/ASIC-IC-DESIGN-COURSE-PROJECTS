module shift_unit#(parameter in_data_width=16,out_data_width=16)(
input [in_data_width-1:0]A,B,
input clk,rst,shift_enable,
input [1:0]alu_fn,
output reg shift_flag,
output reg [out_data_width-1:0]shift_out
);

always @(posedge clk , negedge rst) begin
    if(!rst)begin
        shift_flag<=0;
        shift_out<=0;
    end
    else if(shift_enable) begin
        shift_flag<=1;
    case (alu_fn)
        2'b00: shift_out<=A>>1;
        2'b01: shift_out<=A<<1;
        2'b10: shift_out<=B>>1;
        2'b11: shift_out<=B<<1;
    endcase
    end
    else begin
        shift_flag<=0;
        shift_out<=0;
    end
end

endmodule

