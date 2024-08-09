`timescale 1ns/1ns
module fifo_top_tb;

parameter data_width=8;
localparam T_write=10  , T_read=25;

reg  w_clk_tb , w_rst_n_tb;
reg  rd_clk_tb , rd_rst_n_tb;
reg  w_inc_tb, rd_inc_tb;
reg  [data_width-1:0]w_data_tb;
wire [data_width-1:0]rd_data_tb;
wire full_flag_tb , empty_flag_tb;


fifo_top uut(
.w_clk(w_clk_tb) ,
.w_rst_n(w_rst_n_tb),
.rd_clk (rd_clk_tb),
.rd_rst_n(rd_rst_n_tb),
.w_inc(w_inc_tb), 
.rd_inc(rd_inc_tb),
.w_data(w_data_tb),
.rd_data(rd_data_tb),
.full_flag(full_flag_tb) ,
.empty_flag(empty_flag_tb)
);



initial
begin
initialize;
reset;
write(16); //to test full flag
@(posedge empty_flag_tb);
#(5*T_read);  // to make sure that the rd_ptr does not change  even if rd_inc is high
write(10);
stop_write;
end



initial
begin
@(posedge full_flag_tb);
#(5*T_write); // to make sure that the w_ptr doesnot change even if w_inc is high
stop_write;
read(16);//to test empty flag
@(posedge empty_flag_tb);
#(5*T_read);  // to make sure that the rd_ptr does not change  even if rd_inc is high
read(10);
stop_read;
$stop;
end


//////////////////////////////////////
//////   generate write_clock   /////
////////////////////////////////////
always
begin
w_clk_tb=0;
#(T_write/2);
w_clk_tb=1;
#(T_write/2);   
end



//////////////////////////////////////
//////   generate read_clock    /////
////////////////////////////////////
always
begin
rd_clk_tb=0;
#(T_read/2);
rd_clk_tb=1;
#(T_read/2);   
end

////////////////////////////////
////////  reset task   ////////
//////////////////////////////
task reset;
begin
w_rst_n_tb=0;
rd_rst_n_tb=0;
#(2);
w_rst_n_tb=1;
rd_rst_n_tb=1;
end
endtask


/////////////////////////////////////
////////     initialize     ////////
///////////////////////////////////
task initialize;
begin
w_inc_tb=0;
rd_inc_tb=0;
w_data_tb=0;
end
endtask

///////////////////////////////////////////////////////////////

task write;
integer i;
input [4:0]number_of_writes;
begin
w_data_tb=0;
w_inc_tb=1;
for ( i=0 ; i<number_of_writes ; i=i+1 ) begin
 w_data_tb=w_data_tb+1;  
 #(T_write); 
end
end
endtask
///////////////////////////////////////////////////////////////


task read;
integer i;
input [4:0]number_of_reads;
begin
for ( i=0 ; i<number_of_reads ; i=i+1 ) begin
 rd_inc_tb=1;
 #(T_read); 
end
end
endtask

///////////////////////////////////////////////////////////////


task stop_write;
begin
w_inc_tb=0;
end
endtask

///////////////////////////////////////////////


task stop_read;
begin
rd_inc_tb=0;
end
endtask


endmodule
