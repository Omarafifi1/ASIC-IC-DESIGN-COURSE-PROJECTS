module decoder(
input [1:0]alu_fn,
output reg arith_enable,cmp_enable,logic_enable,shift_enable
);
always @(*) begin
        arith_enable=0;
        logic_enable=0;
        cmp_enable=0;
        shift_enable=0;
    case (alu_fn)
       2'b00: arith_enable=1;
       2'b01: logic_enable=1;
       2'b10: cmp_enable=1;
       2'b11: shift_enable=1;
    endcase
end
endmodule
