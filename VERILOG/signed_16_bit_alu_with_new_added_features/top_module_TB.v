`timescale 1us/1ps
module parameterized_signed_alu_TB;
parameter in_data_width=16,out_data_width=16,arith_out_data_width=32;

reg signed [in_data_width-1:0]A_tb,B_tb;
reg clk_tb,rst_tb;
reg [3:0]alu_fn_tb;
wire shift_flag_tb,arith_flag_tb,logic_flag_tb,cmp_flag_tb,carry_out_tb;
wire [out_data_width-1:0]shift_out_tb,logic_out_tb,cmp_out_tb;
wire signed [arith_out_data_width-1:0]arith_out_tb;

parameterized_signed_alu uut(
.A(A_tb),
.B(B_tb),
.clk(clk_tb),
.rst(rst_tb),
.alu_fn(alu_fn_tb),
.shift_flag(shift_flag_tb),
.arith_flag(arith_flag_tb),
.logic_flag(logic_flag_tb),
.cmp_flag(cmp_flag_tb),
.carry_out(carry_out_tb),
.shift_out(shift_out_tb),
.logic_out(logic_out_tb),
.cmp_out(cmp_out_tb),
.arith_out(arith_out_tb) 
);

localparam T=10;
always 
begin
clk_tb=0;
#((2*T)/5);
clk_tb=1;
#((3*T)/5);    
end


initial 
begin
rst_tb=0;
#2;
rst_tb=1;
/////////////////////////
///////test_adding//////
///////////////////////
A_tb=-'d5;
B_tb=-'d55;
alu_fn_tb=0;
#10;

A_tb='d5;
B_tb=-'d55;
#10;

A_tb=-'d5;
B_tb='d55;
#10;

A_tb='d5;
B_tb='d55;
#10;

/////////////////////////
////test_subtracting////
///////////////////////

A_tb=-'d5;
B_tb=-'d55;
alu_fn_tb=1;
#10;

A_tb='d5;
B_tb=-'d55;
#10;

A_tb=-'d5;
B_tb='d55;
#10;

A_tb='d5;
B_tb='d55;
#10;


/////////////////////////
///////test_multiply////
///////////////////////
A_tb=-'d5;
B_tb=-'d55;
alu_fn_tb=2;
#10;

A_tb='d5;
B_tb=-'d55;
#10;

A_tb=-'d5;
B_tb='d55;
#10;

A_tb='d5;
B_tb='d55;
#10;

/////////////////////////
///////test_division////
///////////////////////
A_tb=-'d5;
B_tb=-'d55;
alu_fn_tb=3;
#10;

A_tb='d55;
B_tb=-'d5;
#10;

A_tb=-'d30;
B_tb='d10;
#10;

A_tb='d100;
B_tb='d5;
#10;

/////////////////////////
///////test_anding//////
///////////////////////
A_tb='d25;
B_tb='d94;
alu_fn_tb=4;
#10;
/////////////////////////
///////test_oring///////
///////////////////////
alu_fn_tb=5;
#10;
/////////////////////////
///////test_nanding/////
///////////////////////
alu_fn_tb=6;
#10;
/////////////////////////
///////test_noring//////
///////////////////////
alu_fn_tb=7;
#10;
/////////////////////////
///////test_nop/////////
///////////////////////
alu_fn_tb=8;
#10;
/////////////////////////
///////test_cmp/////////
///////////////////////
alu_fn_tb=9;
#10;
alu_fn_tb=10;
#10;
alu_fn_tb=11;
#10;


A_tb='d94;
B_tb='d30;
alu_fn_tb=9;
#10;
alu_fn_tb=10;
#10;
alu_fn_tb=11;
#10;

A_tb='d100;
B_tb='d100;
alu_fn_tb=9;
#10;
alu_fn_tb=10;
#10;
alu_fn_tb=11;
#10;
/////////////////////////
///////test_shifting////
///////////////////////
A_tb='d25;
B_tb='d94;
alu_fn_tb=12;
#10;
alu_fn_tb=13;
#10;
alu_fn_tb=14;
#10;
alu_fn_tb=15;
#30;
$stop;
end

endmodule