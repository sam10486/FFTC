 //============================================                                             
 //Note: Re-order controller                                                                
 //data:2020/4/17                                                                           
 //writter:shi yong                                                                         
 //============================================                                             
 `timescale 1ns/10ps                                                                        
 module Rectrl(                                                                             
          REMA,                                                                             
          ExtValid_in,                                                                      
          rst_n,                                                                            
          clk                                                                               
 );                                                                                         
                                                                                            
 parameter REMA_WIDTH = 9;
 parameter REMA_deadline = 9'd511;
 parameter REMA_ZERO = 9'd0;
                                                                                            
 parameter IDLE   = 2'd0;                                                                   
 parameter WORK   = 2'd1;                                                                   
 parameter WORK_F = 2'd2;                                                                   
 parameter OVER   = 2'd3;                                                                   
                                                                                            
 output [REMA_WIDTH-1:0] REMA;                                                              
                                                                                            
 input ExtValid_in;                                                                         
 input clk;                                                                                 
 input rst_n;                                                                               
                                                                                            
 reg   [REMA_WIDTH-1:0] REMA;                                                               
 reg   [1:0] state;                                                                         
 reg   [1:0] next_state;                                                                    
                                                                                            
 wire  [REMA_WIDTH-1:0]REMA_wire;                                                           
                                                                                            
                                                                                            
     assign REMA_wire = ((state == WORK)|| (state == WORK_F)) ? (REMA + 9'b1):REMA;
                                                                                            
     always@(*)begin                                                                        
         case(state)                                                                        
             IDLE:begin                                                                     
                     if(ExtValid_in)next_state = WORK;                                      
                     else next_state = IDLE;                                                
             end                                                                            
             WORK:begin                                                                     
                     if(REMA < REMA_deadline) next_state = WORK;                            
                     else next_state = WORK_F;                                              
             end                                                                            
             WORK_F:begin                                                                   
                     next_state = OVER;                                                     
             end                                                                            
             OVER:begin                                                                     
                     next_state = OVER;                                                     
             end                                                                            
             default: next_state = IDLE;                                                    
         endcase                                                                            
     end                                                                                    
                                                                                            
     always@(posedge clk,negedge rst_n)begin                                                
         if(~rst_n)begin                                                                    
             REMA  <=  REMA_ZERO;                                                           
             state <=  2'b0;                                                                
         end                                                                                
         else begin                                                                         
             REMA  <= REMA_wire;                                                            
             state <= next_state;                                                           
         end                                                                                
     end                                                                                    
                                                                                            
 endmodule                                                                                  
