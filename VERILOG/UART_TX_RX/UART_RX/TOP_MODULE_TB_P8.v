`timescale 1us/1ps
module RX_TOP_MODULE_TB_P8;

parameter data_width=8 ,prescale_width=6 ;
localparam T_tx=8.6;
localparam T_rx=T_tx/32;


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
initialize;
reset;
@(negedge rx_clk_tb)
start_glitch;    
#(3*T_tx);
@(negedge rx_clk_tb)

REG_FILE_WRITE_CMD(1'b0 , 1'b1 , 8'haa , 1'b0 , 8'd5 ,1'b0 , 8'd25 , 1'b1);
#(2*T_tx);
REG_FILE_READ_CMD(1'b0 , 1'b1 ,  8'hbb , 1'b0 , 8'd2 , 1'b1 );

ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd0 , 1'b0); //add
#(2*T_tx);



#(2*T_tx);
ALU_OPER_W_OP_CMD(1'b0 , 1'b1 , 8'hcc , 1'b0  , 8'd10  , 1'b0 , 8'd15 , 1'b0 , 8'd0 ,1'b0 );//add
#(2*T_tx);
ALU_OPER_W_OP_CMD(1'b0 , 1'b1 , 8'hcc , 1'b0  , 8'd10  , 1'b0 , 8'd15 , 1'b0 , 8'd1 ,1'b1 );//sub
#(2*T_tx);
ALU_OPER_W_OP_CMD(1'b0 , 1'b1 , 8'hcc , 1'b0  , 8'd150 , 1'b0 , 8'd89 , 1'b0 , 8'd2 ,1'b1 );//mul
#(2*T_tx);
ALU_OPER_W_OP_CMD(1'b0 , 1'b1 , 8'hcc , 1'b0  , 8'd200 , 1'b1 , 8'd4  , 1'b1 , 8'd3 ,1'b0 );//div
#(2*T_tx);
ALU_OPER_W_OP_CMD(1'b0 , 1'b1 , 8'hcc , 1'b0  , 8'd10  , 1'b0 , 8'd15 , 1'b0 , 8'd4 ,1'b1 );//and
#(2*T_tx);

ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd0 , 1'b0); //add
#(2*T_tx);
ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd1 , 1'b1);  //sub
#(2*T_tx);
ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd2 , 1'b1); //mul
#(2*T_tx);
ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd3 , 1'b0);//div
#(2*T_tx);
ALU_OPER_W_NOP_CMD(1'b0 , 1'b1 ,  8'hdd , 1'b0 , 8'd4 , 1'b1);//and
#(2*T_tx);
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
prescale_tb=32;
parity_enable_tb=1;
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



///////////////////////////////////////////////////
//           REG_FILE_WRITE_CMD task           ///
/////////////////////////////////////////////////
task REG_FILE_WRITE_CMD;
parameter frame0_width=8;
parameter frame1_width=8;
parameter frame2_width=8;
integer i;
input start_bit;
input stop_bit;
input [frame0_width-1:0]frame0_bits;
input frame0_parity_bit;
input [frame1_width-1:0]frame1_bits;
input frame1_parity_bit;
input [frame2_width-1:0]frame2_bits;
input frame2_parity_bit;
begin
    rx_in_tb=start_bit;
    #(T_tx);


 for(i=0 ;i<frame0_width;i=i+1)begin
    rx_in_tb= frame0_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame0_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx);  
    #(T_rx)   ;


     rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame1_width;i=i+1)begin
    rx_in_tb= frame1_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame1_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); 
#(T_rx)   ;

    rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame2_width;i=i+1)begin
    rx_in_tb= frame2_bits[i];
    #(T_tx);       
 end
 
    rx_in_tb=frame2_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); 
    #(T_rx)   ;
end
endtask


///////////////////////////////////////////////////
//           REG_FILE_READ_CMD task            ///
/////////////////////////////////////////////////
task REG_FILE_READ_CMD;
parameter frame0_width=8;
parameter frame1_width=8;
integer i;
input start_bit;
input stop_bit;
input [frame0_width-1:0]frame0_bits;
input frame0_parity_bit;
input [frame1_width-1:0]frame1_bits;
input frame1_parity_bit;
begin
    rx_in_tb=start_bit;
    #(T_tx);


 for(i=0 ;i<frame0_width;i=i+1)begin
    rx_in_tb= frame0_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame0_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx);     
#(T_rx)   ;

     rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame1_width;i=i+1)begin
    rx_in_tb= frame1_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame1_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); 
 #(T_rx)   ;
end
endtask


///////////////////////////////////////////////////
//           ALU_OPER_W_OP_CMD_ task           ///
/////////////////////////////////////////////////
task ALU_OPER_W_OP_CMD;
parameter frame0_width=8;
parameter frame1_width=8;
parameter frame2_width=8;
parameter frame3_width=8;
integer i;
input start_bit;
input stop_bit;
input [frame0_width-1:0]frame0_bits;
input frame0_parity_bit;
input [frame1_width-1:0]frame1_bits;
input frame1_parity_bit;
input [frame2_width-1:0]frame2_bits;
input frame2_parity_bit;
input [frame3_width-1:0]frame3_bits;
input frame3_parity_bit;
begin
    rx_in_tb=start_bit;
    #(T_tx);


 for(i=0 ;i<frame0_width;i=i+1)begin
    rx_in_tb= frame0_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame0_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx);     

#(T_rx)   ;
     rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame1_width;i=i+1)begin
    rx_in_tb= frame1_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame1_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); 

#(T_rx)   ;
    rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame2_width;i=i+1)begin
    rx_in_tb= frame2_bits[i];
    #(T_tx);       
 end
 
    rx_in_tb=frame2_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); 
#(T_rx)   ;

    rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame3_width;i=i+1)begin
    rx_in_tb= frame3_bits[i];
    #(T_tx);       
 end
 
    rx_in_tb=frame3_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx);  #(T_rx)   ;     
end
endtask



///////////////////////////////////////////////////
//           ALU_OPER_W_NOP_CMD_ task          ///
/////////////////////////////////////////////////
task ALU_OPER_W_NOP_CMD;
parameter frame0_width=8;
parameter frame1_width=8;
integer i;
input start_bit;
input stop_bit;
input [frame0_width-1:0]frame0_bits;
input frame0_parity_bit;
input [frame1_width-1:0]frame1_bits;
input frame1_parity_bit;
begin
    rx_in_tb=start_bit;
    #(T_tx);


 for(i=0 ;i<frame0_width;i=i+1)begin
    rx_in_tb= frame0_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame0_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx);     

#(T_rx)   ;
     rx_in_tb=start_bit;
    #(T_tx);
 for(i=0 ;i<frame1_width;i=i+1)begin
    rx_in_tb= frame1_bits[i];
    #(T_tx);       
 end

    rx_in_tb=frame1_parity_bit;
    #(T_tx);
    rx_in_tb=stop_bit;
    #(T_tx); #(T_rx)   ;
      
end
endtask





endmodule


