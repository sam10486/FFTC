 //==============================================                                                
 //Writer:Shi-Yong Wu                                                                            
 //                                                                                              
 //Note:Modular multiplier                                                                       
 //using barrett reduction                                                                       
 //==============================================                                                
 `timescale 1ns/1ps                                                                              
                                                                                                 
 module MulMod(                                                                                  
   A_in,                                                                                         
   B_in,                                                                                         
   bypass,                                                                                          
   clk,                                                                                          
   rst_n,                                                                                        
   result                                                                                        
 );                                                                                              
   parameter DATA_WIDTH          = 22;
   parameter DOUBLE_DATA_WIDTH   = 44;
                                                                                                 
   input [DATA_WIDTH-1:0] A_in;                                                                  
   input [DATA_WIDTH-1:0] B_in;                                                                  
   input bypass;                                                                                    
   input clk;                                                                                    
   input rst_n;                                                                                  
                                                                                                 
   output [DATA_WIDTH-1:0] result;                                                                  
                                                                                                 
                                                                                                 
   wire [DOUBLE_DATA_WIDTH-1:0]S_wire;                                                           
   wire [DOUBLE_DATA_WIDTH-1:0]BR_in_wire;                                                        
                                                                                                 
                                                                                                 
   Mul M1(                                                                                       
     .A_in(A_in),                                                                                
     .B_in(B_in),                                                                                
 	.clk(clk),                                                                                   
 	.rst_n(rst_n),                                                                               
 	.S_out(S_wire)                                                                                
   );                                                                                            
                                                                                                 
   assign BR_in_wire = (bypass == 1'b1 ) ? {A_in,B_in} : S_wire;  
                                                                  
   BR BR1(                                                        
          .S_in(BR_in_wire),                                      
          .result(result),                                        
          .rst_n(rst_n),                                          
          .clk(clk)                                               
   );                                                             
                                                                  
 endmodule                                                                                       
