module logic_unit#(parameter in_data_width=16,out_data_width=16)(
input signed[in_data_width-1:0]  A,B,
input clk,rst,logic_enable,
input [1:0]alu_fn,
output reg logic_flag,
output reg [out_data_width-1:0]logic_out
);

reg logic_flag_next;
reg [out_data_width-1:0]logic_out_next;

always @(posedge clk , negedge rst) begin
    if(!rst)begin
        logic_out<=0;
        logic_flag<=0;
    end
    else begin
        logic_out<=logic_out_next;
        logic_flag<=logic_flag_next;
    end    
end


always @(*) begin
    if(logic_enable) begin
        logic_flag_next=1;
    case (alu_fn)
        2'b00: logic_out_next= A & B;
        2'b01: logic_out_next= A | B;
        2'b10: logic_out_next=~(A & B);
        2'b11: logic_out_next=~(A | B);
    endcase
    end
    else begin
        logic_flag_next=0;
        logic_out_next=0;
    end
end
endmodule
