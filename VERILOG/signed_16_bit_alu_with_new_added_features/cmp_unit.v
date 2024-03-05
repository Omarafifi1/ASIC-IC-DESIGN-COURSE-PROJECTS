module cmp_unit#(parameter in_data_width=16,out_data_width=16)(
input [in_data_width-1:0]A,B,
input clk,rst,cmp_enable,
input [1:0]alu_fn,
output reg cmp_flag,
output reg [out_data_width-1:0]cmp_out
);

always @(posedge clk , negedge rst) begin
    if(!rst)begin
        cmp_out<=0;
        cmp_flag<=0;
    end
    else if(cmp_enable) begin
        cmp_flag<=1;
    case (alu_fn)
        2'b00: cmp_out<=0;
        2'b01: cmp_out<=(A==B)?1:0;
        2'b10: cmp_out<=(A>B)?2:0;
        2'b11: cmp_out<=(A<B)?3:0;
    endcase
    end
    else begin
        cmp_out<=0;
        cmp_flag<=0;
    end
end

endmodule

