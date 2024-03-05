module Automatic_Garage_Door_Controller(
input up_max,down_max,
input activate,
input clk,rst_n,
output reg up_m,down_m

);

localparam IDLE = 3'b00,
           Mv_Up = 3'b01,
           Mv_Dn = 3'b10;


reg [1:0]current_state,next_state;

always @(posedge clk ,negedge rst_n ) begin
    if(!rst_n)
    current_state<=IDLE;
    else
    current_state<=next_state;
end



always @(*) begin
    case (current_state)
        IDLE:begin
            if(!activate)
            next_state=IDLE;
            else  begin
            if( !up_max && down_max)
            next_state=Mv_Up;
            else if(up_max && !down_max)
            next_state=Mv_Dn;
            else 
            next_state=IDLE;
            end
        end
        Mv_Up:begin
            if(up_max)
            next_state=IDLE;
            else 
            next_state=Mv_Up;             
        end
        Mv_Dn:begin
             if(down_max)
            next_state=IDLE;
            else 
            next_state=Mv_Dn;            
        end 
        default: next_state=IDLE;
    endcase
end


always @(*) begin
    up_m=0;
    down_m=0;
    case (current_state)
        IDLE:begin
          up_m=0;
          down_m=0;
        end
        Mv_Up:
          up_m=1;
        Mv_Dn:
          down_m=1;  
        default:begin
          up_m=0;
          down_m=0;  
        end
    endcase
end



endmodule