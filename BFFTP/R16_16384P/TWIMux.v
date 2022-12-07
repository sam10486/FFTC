//=============================================                 
//Data:2020/04/08                                               
//note:twiddle factor mux                                       
//writter:shi yong wu                                           
//=============================================                 
`timescale 1ns/10ps                                             
module TWIMux(                                                  
    TWIradix0,                                                  
    TWIradix1,                                                  
    TWIradix2,                                                  
    TWIradix3,                                                  
    TWIradix4,                                                  
    TWIradix5,                                                  
    TWIradix6,                                                  
    TWIradix7,                                                  
    TWIradix8,                                                  
    TWIradix9,                                                  
    TWIradix10,                                                  
    TWIradix11,                                                  
    TWIradix12,                                                  
    TWIradix13,                                                  
    TWIradix14,                                                  
    TWIradix15,                                                  
    b0radix0,                                                   
    b0radix1,                                                   
    b0radix2,                                                   
    b0radix3,                                                   
    b0radix4,                                                   
    b0radix5,                                                   
    b0radix6,                                                   
    b0radix7,                                                   
    b0radix8,                                                   
    b0radix9,                                                   
    b0radix10,                                                   
    b0radix11,                                                   
    b0radix12,                                                   
    b0radix13,                                                   
    b0radix14,                                                   
    b0radix15,                                                   
    b1radix0,                                                   
    b1radix1,                                                   
    b1radix2,                                                   
    b1radix3,                                                   
    b1radix4,                                                   
    b1radix5,                                                   
    b1radix6,                                                   
    b1radix7,                                                   
    b1radix8,                                                   
    b1radix9,                                                   
    b1radix10,                                                   
    b1radix11,                                                   
    b1radix12,                                                   
    b1radix13,                                                   
    b1radix14,                                                   
    b1radix15,                                                   
    BN_wire                                                     
);                                                              
                                                                
                                                                
parameter P_WIDTH = 64;                                         
                                                                
output [P_WIDTH-1:0] TWIradix0;                                 
output [P_WIDTH-1:0] TWIradix1;                                 
output [P_WIDTH-1:0] TWIradix2;                                 
output [P_WIDTH-1:0] TWIradix3;                                 
output [P_WIDTH-1:0] TWIradix4;                                 
output [P_WIDTH-1:0] TWIradix5;                                 
output [P_WIDTH-1:0] TWIradix6;                                 
output [P_WIDTH-1:0] TWIradix7;                                 
output [P_WIDTH-1:0] TWIradix8;                                 
output [P_WIDTH-1:0] TWIradix9;                                 
output [P_WIDTH-1:0] TWIradix10;                                 
output [P_WIDTH-1:0] TWIradix11;                                 
output [P_WIDTH-1:0] TWIradix12;                                 
output [P_WIDTH-1:0] TWIradix13;                                 
output [P_WIDTH-1:0] TWIradix14;                                 
output [P_WIDTH-1:0] TWIradix15;                                 
                                                                
input               BN_wire;                                    
input [P_WIDTH-1:0] b0radix0;                                   
input [P_WIDTH-1:0] b0radix1;                                   
input [P_WIDTH-1:0] b0radix2;                                   
input [P_WIDTH-1:0] b0radix3;                                   
input [P_WIDTH-1:0] b0radix4;                                   
input [P_WIDTH-1:0] b0radix5;                                   
input [P_WIDTH-1:0] b0radix6;                                   
input [P_WIDTH-1:0] b0radix7;                                   
input [P_WIDTH-1:0] b0radix8;                                   
input [P_WIDTH-1:0] b0radix9;                                   
input [P_WIDTH-1:0] b0radix10;                                   
input [P_WIDTH-1:0] b0radix11;                                   
input [P_WIDTH-1:0] b0radix12;                                   
input [P_WIDTH-1:0] b0radix13;                                   
input [P_WIDTH-1:0] b0radix14;                                   
input [P_WIDTH-1:0] b0radix15;                                   
input [P_WIDTH-1:0] b1radix0;                                   
input [P_WIDTH-1:0] b1radix1;                                   
input [P_WIDTH-1:0] b1radix2;                                   
input [P_WIDTH-1:0] b1radix3;                                   
input [P_WIDTH-1:0] b1radix4;                                   
input [P_WIDTH-1:0] b1radix5;                                   
input [P_WIDTH-1:0] b1radix6;                                   
input [P_WIDTH-1:0] b1radix7;                                   
input [P_WIDTH-1:0] b1radix8;                                   
input [P_WIDTH-1:0] b1radix9;                                   
input [P_WIDTH-1:0] b1radix10;                                   
input [P_WIDTH-1:0] b1radix11;                                   
input [P_WIDTH-1:0] b1radix12;                                   
input [P_WIDTH-1:0] b1radix13;                                   
input [P_WIDTH-1:0] b1radix14;                                   
input [P_WIDTH-1:0] b1radix15;                                   
                                                                
                                                                
  assign TWIradix0  = (BN_wire == 1'b1) ? b1radix0  : b0radix0;    
  assign TWIradix1  = (BN_wire == 1'b1) ? b1radix1  : b0radix1;    
  assign TWIradix2  = (BN_wire == 1'b1) ? b1radix2  : b0radix2;    
  assign TWIradix3  = (BN_wire == 1'b1) ? b1radix3  : b0radix3;    
  assign TWIradix4  = (BN_wire == 1'b1) ? b1radix4  : b0radix4;    
  assign TWIradix5  = (BN_wire == 1'b1) ? b1radix5  : b0radix5;    
  assign TWIradix6  = (BN_wire == 1'b1) ? b1radix6  : b0radix6;    
  assign TWIradix7  = (BN_wire == 1'b1) ? b1radix7  : b0radix7;    
  assign TWIradix8  = (BN_wire == 1'b1) ? b1radix8  : b0radix8;    
  assign TWIradix9  = (BN_wire == 1'b1) ? b1radix9  : b0radix9;    
  assign TWIradix10 = (BN_wire == 1'b1) ? b1radix10 : b0radix10;   
  assign TWIradix11 = (BN_wire == 1'b1) ? b1radix11 : b0radix11;   
  assign TWIradix12 = (BN_wire == 1'b1) ? b1radix12 : b0radix12;   
  assign TWIradix13 = (BN_wire == 1'b1) ? b1radix13 : b0radix13;   
  assign TWIradix14 = (BN_wire == 1'b1) ? b1radix14 : b0radix14;   
  assign TWIradix15 = (BN_wire == 1'b1) ? b1radix15 : b0radix15;   
                                                                
endmodule 	                                                   
