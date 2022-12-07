 //==============================================  
 //Writer:Shi-Yong Wu                              
 //                                                
 //Note:multiplier                                 
 //==============================================  
 `timescale 1ns/1ps                                
 module Mul(                                       
    A_in,                                          
    B_in,                                          
    clk,                                           
    rst_n,                                         
    S_out                                          
 );                                                
                                                   
   parameter DATA_WIDTH = 22;        
   parameter DOUBLE_DATA_WIDTH = 2*DATA_WIDTH ;    
   parameter PAD_ZERO = 44'b0;  
                                                   
   input [DATA_WIDTH-1:0] A_in;                    
   input [DATA_WIDTH-1:0] B_in;                    
   input clk;                                      
   input rst_n;                                    
                                                   
   output [DOUBLE_DATA_WIDTH-1:0] S_out;           
                                                   
   reg [DOUBLE_DATA_WIDTH-1:0] S_out;              
                                                   
   wire [DOUBLE_DATA_WIDTH-1:0]S_wire;             
                                                   
   assign  S_wire = A_in * B_in;                   
                                                   
   always@(posedge clk or negedge rst_n)begin      
     if(~rst_n)begin                               
 	  S_out <= PAD_ZERO ;                           
 	end                                             
 	else begin                                      
 	  S_out <= S_wire;                              
 	end                                             
   end                                             
                                                   
 endmodule                                         
