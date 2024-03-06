module counter #(parameter counter_width=$clog2(data_width*2),data_width=8)(
    input clk,rst_n,
    output reg valid,
    output active,done_tick,
    output data
);

reg [counter_width-1:0]counter;
reg [data_width-1:0]data_reg;


assign  data=data_reg[0];
assign  done_tick=&counter;
assign  active=!counter[counter_width-1]; //must be that because the last bit that goes out from data is xored and then the new value is shifted in crc at counter=8 so active must be equal 1 at counter = 7


always @(posedge clk,negedge rst_n ) begin
    if(!rst_n)
      counter<=0;
    else if(active)begin
      counter<=counter+1'b1;
      data_reg<={1'b0,data_reg[data_width-1:1]};   
    end     
    else if (!done_tick)
      counter<=counter+1'b1;
end


always @(posedge clk,negedge rst_n) begin  
  if(!rst_n)begin
  valid<=0;     
  end
  else begin
  valid<=(counter!=((2**counter_width)-1))?counter[counter_width-1]:0;  
  end
end


endmodule