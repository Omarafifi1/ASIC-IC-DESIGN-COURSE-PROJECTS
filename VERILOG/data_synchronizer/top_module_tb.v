module data_sync_top_module_tb ;

parameter data_width =8  ;
localparam T=10;

reg dest_clk_tb , dest_rst_n_tb;
reg [data_width-1:0]unsync_bus_tb ; 
reg bus_enable_tb;
wire [data_width-1:0]sync_bus_tb ;
wire enable_pulse_tb;


data_sync_top_module  uut (
.dest_clk(dest_clk_tb) , 
.dest_rst_n(dest_rst_n_tb),
.unsync_bus (unsync_bus_tb), 
.bus_enable(bus_enable_tb),
.sync_bus (sync_bus_tb),
.enable_pulse(enable_pulse_tb)
);


initial begin
reset;
test(1'b1,8'd5);  //test sending 5 and see if it is recieved or not
#(6*T);

test(1'b0,8'd5); //test sending new data  and see if it is recieved or not so first we reset the enable signal for a cycle and then set it to high with the new unsync_data in the next test task
#(T);

test(1'b1,8'd15); //test sending 15 and see if it is recieved or not
#(6*T);

test(1'b1,8'd20); //test if a glitch happens on the unsync_bus ,will the sync_data be affected by this glitch or not?
#(3*T);
$stop;

end



//////////////////////////////////////
//////   generate  clock   //////////
////////////////////////////////////
always
begin
dest_clk_tb=0;
#(T/2);
dest_clk_tb=1;
#(T/2);   
end


////////////////////////////////
////////  reset task   ////////
//////////////////////////////
task reset;
begin
dest_rst_n_tb=0;
#2;
dest_rst_n_tb=1;
end
endtask

////////////////////////////////
////////  test task    ////////
//////////////////////////////
task test;
input bus_enable;
input [data_width-1:0]unsync_bus;
begin
bus_enable_tb=bus_enable;
unsync_bus_tb=unsync_bus;
end
endtask




endmodule


