  //==================================================     
  //Writer     : shi yong                                  
  //Date       : 2020/4/20                                 
  //Note       : MA of inverse re-order pipeline           
  //==================================================     
                                                           
  module IReorderMA_pip(                                   
                         IREMA_o,                          
                         MA_i,                             
                         rst_n,                            
                         clk                               
  );                                                       
                                                           
  parameter IREMA_WIDTH = 9;
  parameter IREMA_ZERO  = 9'd0;
                                                           
  output [IREMA_WIDTH-1:0] IREMA_o;                        
                                                           
  input  [IREMA_WIDTH-1:0] MA_i;                           
  input                    rst_n;                          
  input                    clk;                            
                                                           
  reg    [IREMA_WIDTH-1:0] IREMA_o;                        
  reg    [IREMA_WIDTH-1:0] IREMA_d0;                        
                                                           
  always @(posedge clk,negedge rst_n)begin                 
     if(~rst_n)begin                                       
         IREMA_o  <= IREMA_ZERO;                           
         IREMA_d0 <= IREMA_ZERO;                           
     end                                                   
     else begin                                            
         IREMA_d0 <= MA_i;                                 
         IREMA_o  <= IREMA_d0;                             
     end                                                   
  end                                                      
                                                           
                                                           
  endmodule                                                
