`timescale 1ns/1ps
module CRC_TOP_MODULE_TB;

parameter data_width=8 , depth=10 , cases_number=10;
localparam T = 100;

reg clk_tb,rst_n_tb;
wire valid_tb;
wire CRC_tb;
wire done_tick_tb;

CRC_TOP_MODULE dut (
.clk(clk_tb),
.rst_n(rst_n_tb),
.valid(valid_tb),
.CRC(CRC_tb),
.done_tick(done_tick_tb)
);

reg [data_width-1:0]test_cases_reg[0:depth-1];
reg [data_width-1:0]expec_out_reg[0:depth-1];

integer i;

initial
begin
$readmemh("DATA_h.txt",test_cases_reg);
$readmemh("Expec_Out_h.txt",expec_out_reg);

for(i=0;i<cases_number;i=i+1)begin
   data_read(i);
   reset; 
   check_out(i);
   wait(CRC_TOP_MODULE_TB.dut.uut0.counter==15);
   #(3*T);
end

$stop;
end



////////////////////////////////
//////   generate clock   /////
//////////////////////////////
always
begin
clk_tb=0;
#(T/2);
clk_tb=1;
#(T/2);
end 
////////////////////////////////
////////  reset task   ////////
//////////////////////////////
task reset;
begin
rst_n_tb=0;
#2;
rst_n_tb=1;
end
endtask
////////////////////////////////
//////// read data task ///////
//////////////////////////////
task data_read;
input [3:0]test_number;
    begin
       CRC_TOP_MODULE_TB.dut.uut0.data_reg=test_cases_reg[test_number];
    end    
endtask
////////////////////////////////
////  check out task   ////////
//////////////////////////////
task check_out; 
input [3:0]test_number;
begin
    wait(CRC_TOP_MODULE_TB.dut.uut0.counter==8)begin
    if(CRC_TOP_MODULE_TB.dut.uut1.CRC_reg==expec_out_reg[test_number])
        $display("Test Case %d is succeeded",test_number);
    else
        $display("Test Case %d is failed",test_number);
    end
end
endtask

endmodule





