`timescale 1us/1ps
module UART_TOP_MODULE_TB;
parameter data_width=8;
localparam T=8.68;
reg [data_width-1:0]p_data_tb;
reg clk_tb,rst_n_tb;
reg data_valid_tb;
reg parity_type_tb,parity_enable_tb;
wire tx_out_tb;
wire busy_tb;




UART_TOP_MODULE dut(
.p_data(p_data_tb),
.clk(clk_tb),
.rst_n(rst_n_tb), 
.data_valid(data_valid_tb),
.parity_type(parity_type_tb),
.parity_enable(parity_enable_tb),
.tx_out(tx_out_tb),
.busy(busy_tb)
);


initial 
begin
initialize;
reset;
repeat(2)@(negedge clk_tb);
test_no_parity_frame(8'hd8); // data valid is high for two cycles one to take the input_data and one to make sure that there is no data taken from the user once the frame is started
check_out(8'hd8);
@(negedge busy_tb)
repeat(5)@(negedge clk_tb);
test_odd_parity_frame(8'hdf);
check_out(8'hdf);
@(negedge busy_tb)
repeat(5)@(negedge clk_tb);
test_even_parity_frame(8'hac);   
check_out(8'hac);
@(negedge busy_tb)
repeat(5)@(negedge clk_tb);
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


task initialize;
begin
data_valid_tb=0; 
parity_type_tb=0;
parity_enable_tb=0;  
end
endtask



task test_no_parity_frame;
input [data_width-1:0]data_in;
begin
p_data_tb=data_in;
data_valid_tb=1;   
parity_type_tb=1;
parity_enable_tb=0; 
end
endtask


task test_odd_parity_frame;
input [data_width-1:0]data_in;
begin
p_data_tb=data_in;
data_valid_tb=1; 
parity_type_tb=1;
parity_enable_tb=1;  
end
endtask



task test_even_parity_frame;
input [data_width-1:0]data_in;
begin
p_data_tb=data_in;    
data_valid_tb=1; 
parity_type_tb=0;
parity_enable_tb=1;  
end
endtask


task check_out;
input [data_width-1:0]expec_out;
reg [data_width-1:0]gener_out;
integer i;
begin
    @(posedge busy_tb)
    #((3*T)/2) ; // to sample at the middle of the bit period 
    data_valid_tb=0;  
    for(i=0;i<data_width;i=i+1)begin
        gener_out[i]=tx_out_tb; 
        #(T); 
    end  
    if(gener_out==expec_out)
    $display("Test Case is succeeded");
    else
    $display("Test Case  is failed");
    gener_out=0;
end
endtask
endmodule
