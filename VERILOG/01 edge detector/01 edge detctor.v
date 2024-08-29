module detect_01_edge(
input clk,
input rst_n,
input in,
output reg out

);
reg current_state,next_state;
localparam s0=0,s1=1;
always@(posedge clk,negedge rst_n)
begin
  if(!rst_n)
    current_state<=s0;
  else
    current_state<=next_state;
end


always@(*)
begin
  case(current_state)
    s0:
       if(in)
         next_state=s1;
       else
         next_state=s0;
    s1:
       if(in)
         next_state=s1;
       else
         next_state=s0;    
  endcase
  
  
end



always@(*)
begin
  case(current_state)   //or out=(current_state==s0)&(in==1)
    s0:
       if(in)
         out=1;
       else
         out=0;    
    s1:
       out=0;   
  endcase
end





endmodule