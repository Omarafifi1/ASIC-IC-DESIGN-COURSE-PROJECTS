module parameterized_signed_alu #(parameter in_data_width=16,out_data_width=16,arith_out_data_width=32)(
input signed [in_data_width-1:0]A,B,
input clk,rst,
input [3:0]alu_fn,
output shift_flag,arith_flag,logic_flag,cmp_flag,carry_out,
output [out_data_width-1:0]shift_out,logic_out,cmp_out,
output signed[arith_out_data_width-1:0] arith_out

);

wire arith_enable,shift_enable,logic_enable,cmp_enable;


arith_unit dut0(
.A(A),
.B(B),
.clk(clk),
.rst(rst),
.arith_enable(arith_enable),
.alu_fn(alu_fn[1:0]),
.carry_out(carry_out),
.arith_flag(arith_flag),
.arith_out(arith_out)
);

logic_unit dut1(
.A(A),
.B(B),
.clk(clk),
.rst(rst),
.logic_enable(logic_enable),
.alu_fn(alu_fn[1:0]),
.logic_flag(logic_flag),
.logic_out(logic_out)
);

cmp_unit   dut2(
.A(A),
.B(B),
.clk(clk),
.rst(rst),
.cmp_enable(cmp_enable),
.alu_fn(alu_fn[1:0]),
.cmp_flag(cmp_flag),
.cmp_out(cmp_out)
);

shift_unit dut3(
.A(A),
.B(B),
.clk(clk),
.rst(rst),
.shift_enable(shift_enable),
.alu_fn(alu_fn[1:0]),
.shift_flag(shift_flag),
.shift_out(shift_out)
);

decoder dut4(
.alu_fn(alu_fn[3:2]),
.arith_enable(arith_enable),
.cmp_enable(cmp_enable),
.logic_enable(logic_enable),
.shift_enable(shift_enable)
);

endmodule
