`timescale 1us/1ps
module RX_TOP_MODULE_TB_P16;

parameter data_width=8 ,prescale_width=6 ;
localparam T_tx=8.6;
localparam T_rx=T_tx/16;


reg rx_in_tb;
reg [prescale_width-1:0]prescale_tb;
reg parity_enable_tb;
reg parity_type_tb;
reg rx_clk_tb,rst_n_tb;
wire [data_width-1:0] p_data_tb;
wire data_valid_tb;
wire stop_error_tb, parity_error_tb;

RX_TOP_MODULE uut(
.rx_in(rx_in_tb),
.prescale(prescale_tb),
.parity_enable(parity_enable_tb),
.parity_type(parity_type_tb),
.rx_clk(rx_clk_tb),
.rst_n(rst_n_tb),
.p_data(p_data_tb),
.data_valid(data_valid_tb),
.stop_error(stop_error_tb) , 
.parity_error(parity_error_tb)
);





initial 
begin
reset;
initialize;
#(2*T_tx);
@(negedge rx_clk_tb)
start_glitch;

////////////////////////////////////////
//       test_correct_frames        ///
//////////////////////////////////////
 @(negedge rx_clk_tb)
no_parity_frame(10'b0110101001);
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b00101011);



 @(negedge rx_clk_tb)
odd_parity_frame(11'b01001010111);
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b10101001);

 @(negedge rx_clk_tb)
even_parity_frame(11'b00101010011);
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b00101010);

 @(negedge rx_clk_tb)
no_parity_frame(10'b0110101111);
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b11101011);


 @(negedge rx_clk_tb)
even_parity_frame(11'b00101011001);
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b01101010);

////////////////////////////////////////
//         test_wrong_frames        ///
//////////////////////////////////////
 @(negedge rx_clk_tb)

no_parity_frame(10'b0110101000);  //reset stop bit and check stop error 
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b00101011);

 @(negedge rx_clk_tb)
even_parity_frame(11'b00101010000); //reset stop and parity bits and check stop and parity errors 
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b00101010);

 @(negedge rx_clk_tb)  
odd_parity_frame(11'b01001010100); //reset stop and parity bits and check stop and parity errors 
#(T_rx);//for check error state
check_frame_and_recieved_8_data_bits(8'b10101001);

#(T_rx);
$stop;
end
////////////////////////////////
//////   generate clock   /////
//////////////////////////////
always
begin
rx_clk_tb=0;
#(T_rx/2);
rx_clk_tb=1;
#(T_rx/2);   
end


////////////////////////////////
////////  reset task   ////////
//////////////////////////////
task reset;
begin
rst_n_tb=0;
#(T_rx);
rst_n_tb=1;
end
endtask

////////////////////////////////
//      initialize task     ///
//////////////////////////////
task initialize;
begin
rx_in_tb=1;
prescale_tb=16;
parity_enable_tb=0;
parity_type_tb=0;    
end
endtask


////////////////////////////////
//       glitch task        ///
//////////////////////////////
task start_glitch;
begin
rx_in_tb=0;
#T_rx;
rx_in_tb=1;
#(3*T_tx);
end
endtask

/////////////////////////////////////
//      no_parity_frame task     ///
///////////////////////////////////
task no_parity_frame;
parameter frame_width=10;
 integer i;
input [frame_width-1:0]frame_bits; //include correct data (start[MSB] , 8bits_data , stop[LSB]) >>10 bits
begin
 parity_enable_tb=0;  


 for(i=(frame_width-1);i>=0;i=i-1)
 begin
    rx_in_tb= frame_bits[i];
    #(T_tx);
 end
end
endtask


///////////////////////////////////////////
//       even_parity_frame task        ///
/////////////////////////////////////////

task even_parity_frame;
parameter frame_width=11;
 integer i;
input [frame_width-1:0]frame_bits; //include correct data (start[MSB] , 8bits_data ,parity, stop[LSB]) >>11 bits
begin
 parity_enable_tb=1;  
 parity_type_tb=0;

 for(i=(frame_width-1);i>=0;i=i-1)
 begin
    rx_in_tb= frame_bits[i];
    #(T_tx);
 end
end
endtask


///////////////////////////////////////////
//        odd_parity_frame task        ///
/////////////////////////////////////////
task odd_parity_frame;
parameter frame_width=11;
 integer i;
input [frame_width-1:0]frame_bits; //include correct data (start[MSB] , 8bits_data ,parity, stop[LSB]) >>11 bits
begin
 parity_enable_tb=1;  
 parity_type_tb=1;
 for(i=(frame_width-1);i>=0;i=i-1)
 begin
    rx_in_tb= frame_bits[i];
    #(T_tx);
 end
end
endtask

///////////////////////////////////////////
//           check_frame_task          ///
/////////////////////////////////////////
task check_frame_and_recieved_8_data_bits;
parameter width=8;
input [width-1:0]frame_data_bits;
begin
if(data_valid_tb && (frame_data_bits==RX_TOP_MODULE_TB_P16.uut.dut3.p_data))
$display("frame is recieved successfully");   
else
$display("frame is not recieved successfully");   
end
endtask




endmodule

