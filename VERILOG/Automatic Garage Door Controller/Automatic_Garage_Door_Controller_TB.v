`timescale 1ns/1ps
module Automatic_Garage_Door_Controller_TB;
reg up_max_tb,down_max_tb;
reg activate_tb;
reg clk_tb,rst_n_tb;
wire up_m_tb,down_m_tb;

localparam T=20;

Automatic_Garage_Door_Controller dut(
 .up_max(up_max_tb),
 .down_max(down_max_tb),
 .activate(activate_tb),
 .clk(clk_tb),
 .rst_n(rst_n_tb),
 .up_m(up_m_tb),
 .down_m(down_m_tb)
);


initial 
begin
initialize;
reset;
move_up;
#(3*T);
U_IDLE;
#(T);
move_down;
#(3*T);
D_IDLE;
#(T);
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
/////  initialize task   //////
//////////////////////////////
task initialize;
begin
activate_tb=0;
up_max_tb=0;
down_max_tb=0; 
end
endtask
////////////////////////////////
/////  move_up_state   ////////
//////////////////////////////
task move_up;
begin
up_max_tb=0;
down_max_tb=1;
activate_tb=1;
#(T);
activate_tb=0;
down_max_tb=0;
end
endtask
////////////////////////////////
/////  move_down_state   //////
//////////////////////////////
task move_down;
begin
up_max_tb=1;
down_max_tb=0; 
activate_tb=1;
#(T);
activate_tb=0;
up_max_tb=0;
end
endtask
////////////////////////////////
///// move up to IDLE state  //
//////////////////////////////
task U_IDLE;
begin
up_max_tb=1;
end
endtask
////////////////////////////////
//// move down to IDLE state //
//////////////////////////////
task D_IDLE;
begin
down_max_tb=1;
end
endtask
endmodule
