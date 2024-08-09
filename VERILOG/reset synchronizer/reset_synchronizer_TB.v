module rst_synch_tb;
reg clk_tb ;
reg rst_n_tb;
wire sync_rst_tb;


rst_synchronizer dut(
.clk(clk_tb) ,
.rst_n(rst_n_tb),
.sync_rst(sync_rst_tb)
);


initial
begin
 reset;   
end

localparam T=10;
//////////////////////////////////////
//////   generate  clock   //////////
////////////////////////////////////
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
#(10*T);
#3;
rst_n_tb=1;
#(10*T);
$stop;
end
endtask

endmodule
