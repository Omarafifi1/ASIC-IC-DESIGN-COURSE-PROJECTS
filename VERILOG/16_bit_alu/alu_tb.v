`timescale 1us/1ps
module bit16_alu_tb;
    reg[15:0]a_tb,b_tb;
    reg [3:0]alu_fun_tb;
    reg clk_tb;
    wire [15:0]alu_out_tb;
    wire c_out_tb;
    wire arith_flag_tb,logic_flag_tb,cmp_flag_tb,shift_flag_tb;


bit16_alu DUT(
.a(a_tb),
.b(b_tb),
.alu_fun(alu_fun_tb),
.clk(clk_tb),
.alu_out(alu_out_tb),
.c_out(c_out_tb),
.arith_flag(arith_flag_tb),
.logic_flag(logic_flag_tb),
.cmp_flag(cmp_flag_tb),
.shift_flag(shift_flag_tb)
);

localparam T = 10;
always
begin
clk_tb=0;
#(T/2);
clk_tb=1;
#(T/2);
end

initial
begin
a_tb=16'd20;
b_tb=16'd15;
alu_fun_tb=4'd0;
#10;
alu_fun_tb=4'd1;
#10;
alu_fun_tb=4'd2;
#10;
alu_fun_tb=4'd3;
#10;
alu_fun_tb=4'd4;
#10;
alu_fun_tb=4'd5;
#10;
alu_fun_tb=4'd6;
#10;
alu_fun_tb=4'd7;
#10;
alu_fun_tb=4'd8;
#10;
alu_fun_tb=4'd9;
#10;
alu_fun_tb=4'd10;
#10;
alu_fun_tb=4'd11;
#10;
alu_fun_tb=4'd12;
#10;
alu_fun_tb=4'd13;
#10;
alu_fun_tb=4'd14;
#10;
alu_fun_tb=4'd15;
#10;
a_tb=16'd5;
b_tb=16'd10;
alu_fun_tb=4'd10;
#10;
alu_fun_tb=4'd11;
#10;
alu_fun_tb=4'd12;
#10;
a_tb=16'd3;
b_tb=16'd3;
alu_fun_tb=4'd10;
#10;
alu_fun_tb=4'd11;
#10;
alu_fun_tb=4'd12;
#10;

$stop;
end


endmodule
