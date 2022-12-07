 //=========================================                         
 //Date:2021/04/05                                                   
 //writer:shiyong                                                    
 //note: bn ank ma pipline                                           
 //      FFT type of m-th tiwiddle factor. m-th cyclotomic polynomial
 //========================================                          
 `timescale 1 ns/1 ps                                                
 module TWIpipe(                                                     
     BN_out,                                                         
     MA_out,                                                         
 	TWIradix0_o,                                                     
 	TWIradix1_o,                                                     
 	TWIradix2_o,                                                     
 	TWIradix3_o,                                                     
 	TWIradix4_o,                                                     
 	TWIradix5_o,                                                     
 	TWIradix6_o,                                                     
 	TWIradix7_o,                                                     
 	TWIradix8_o,                                                     
 	TWIradix9_o,                                                     
 	TWIradix10_o,                                                    
 	TWIradix11_o,                                                    
 	TWIradix12_o,                                                    
 	TWIradix13_o,                                                    
 	TWIradix14_o,                                                    
 	TWIradix15_o,                                                    
     BN_in,                                                          
     MA_in,                                                          
 	TWIradix0_i,                                                     
 	TWIradix1_i,                                                     
 	TWIradix2_i,                                                     
 	TWIradix3_i,                                                     
 	TWIradix4_i,                                                     
 	TWIradix5_i,                                                     
 	TWIradix6_i,                                                     
 	TWIradix7_i,                                                     
 	TWIradix8_i,                                                     
 	TWIradix9_i,                                                     
 	TWIradix10_i,                                                    
 	TWIradix11_i,                                                    
 	TWIradix12_i,                                                    
 	TWIradix13_i,                                                    
 	TWIradix14_i,                                                    
 	TWIradix15_i,                                                    
 	rst_n,                                                           
     clk                                                             
 );                                                                  
                                                                     
 parameter A_WIDTH = 9;                                         
 parameter A_ZERO  = 9'b0;                                      
 parameter P_WIDTH = 64;                                             
 parameter P_ZERO  = 64'd0;                                          
                                                                     
 output [A_WIDTH-1:0] MA_out;                                        
 output               BN_out;                                        
 output [P_WIDTH-1:0]TWIradix0_o;                                    
 output [P_WIDTH-1:0]TWIradix1_o;                                    
 output [P_WIDTH-1:0]TWIradix2_o;                                    
 output [P_WIDTH-1:0]TWIradix3_o;                                    
 output [P_WIDTH-1:0]TWIradix4_o;                                    
 output [P_WIDTH-1:0]TWIradix5_o;                                    
 output [P_WIDTH-1:0]TWIradix6_o;                                    
 output [P_WIDTH-1:0]TWIradix7_o;                                    
 output [P_WIDTH-1:0]TWIradix8_o;                                    
 output [P_WIDTH-1:0]TWIradix9_o;                                    
 output [P_WIDTH-1:0]TWIradix10_o;                                   
 output [P_WIDTH-1:0]TWIradix11_o;                                   
 output [P_WIDTH-1:0]TWIradix12_o;                                   
 output [P_WIDTH-1:0]TWIradix13_o;                                   
 output [P_WIDTH-1:0]TWIradix14_o;                                   
 output [P_WIDTH-1:0]TWIradix15_o;                                   
                                                                     
 input  [A_WIDTH-1:0] MA_in;                                         
 input                BN_in;                                         
 input  [P_WIDTH-1:0]TWIradix0_i;                                    
 input  [P_WIDTH-1:0]TWIradix1_i;                                    
 input  [P_WIDTH-1:0]TWIradix2_i;                                    
 input  [P_WIDTH-1:0]TWIradix3_i;                                    
 input  [P_WIDTH-1:0]TWIradix4_i;                                    
 input  [P_WIDTH-1:0]TWIradix5_i;                                    
 input  [P_WIDTH-1:0]TWIradix6_i;                                    
 input  [P_WIDTH-1:0]TWIradix7_i;                                    
 input  [P_WIDTH-1:0]TWIradix8_i;                                    
 input  [P_WIDTH-1:0]TWIradix9_i;                                    
 input  [P_WIDTH-1:0]TWIradix10_i;                                   
 input  [P_WIDTH-1:0]TWIradix11_i;                                   
 input  [P_WIDTH-1:0]TWIradix12_i;                                   
 input  [P_WIDTH-1:0]TWIradix13_i;                                   
 input  [P_WIDTH-1:0]TWIradix14_i;                                   
 input  [P_WIDTH-1:0]TWIradix15_i;                                   
 input                rst_n;                                         
 input                clk;                                           
                                                                     
 reg  [A_WIDTH-1:0] MA_out;                                          
 reg  [A_WIDTH-1:0] MA_reg0;                                         
 reg  [A_WIDTH-1:0] MA_reg1;                                         
 reg  [A_WIDTH-1:0] MA_reg2;                                         
 reg  [A_WIDTH-1:0] MA_reg3;                                         
                                                                     
 reg                BN_out;                                          
 reg                BN_reg0;                                         
 reg                BN_reg1;                                         
 //---------------------------------                                 
 reg                BN_reg2;                                         
 reg                BN_reg3;                                         
                                                                     
 reg [P_WIDTH-1:0]TWIradix0_o;                                       
 reg [P_WIDTH-1:0]TWIradix1_o;                                       
 reg [P_WIDTH-1:0]TWIradix2_o;                                       
 reg [P_WIDTH-1:0]TWIradix3_o;                                       
 reg [P_WIDTH-1:0]TWIradix4_o;                                       
 reg [P_WIDTH-1:0]TWIradix5_o;                                       
 reg [P_WIDTH-1:0]TWIradix6_o;                                       
 reg [P_WIDTH-1:0]TWIradix7_o;                                       
 reg [P_WIDTH-1:0]TWIradix8_o;                                       
 reg [P_WIDTH-1:0]TWIradix9_o;                                       
 reg [P_WIDTH-1:0]TWIradix10_o;                                      
 reg [P_WIDTH-1:0]TWIradix11_o;                                      
 reg [P_WIDTH-1:0]TWIradix12_o;                                      
 reg [P_WIDTH-1:0]TWIradix13_o;                                      
 reg [P_WIDTH-1:0]TWIradix14_o;                                      
 reg [P_WIDTH-1:0]TWIradix15_o;                                      
                                                                     
     always @(posedge clk,negedge rst_n)begin                        
         if(~rst_n)begin                                             
             MA_reg0       <=  A_ZERO;                               
             MA_reg1       <=  A_ZERO;                               
             MA_reg2       <=  A_ZERO;                               
             MA_reg3       <=  A_ZERO;                               
             MA_out        <=  A_ZERO;                               
             BN_reg0       <=  1'b0;                                 
             BN_reg1       <=  1'b0;                                 
             BN_reg2       <=  1'b0;                                 
             BN_reg3       <=  1'b0;                                 
 			BN_out        <=  1'b0;                                  
 			TWIradix0_o   <=  P_ZERO;                                
 			TWIradix1_o   <=  P_ZERO;                                
 			TWIradix2_o   <=  P_ZERO;                                
 			TWIradix3_o   <=  P_ZERO;                                
 			TWIradix4_o   <=  P_ZERO;                                
 			TWIradix5_o   <=  P_ZERO;                                
 			TWIradix6_o   <=  P_ZERO;                                
 			TWIradix7_o   <=  P_ZERO;                                
 			TWIradix8_o   <=  P_ZERO;                                
 			TWIradix9_o   <=  P_ZERO;                                
 			TWIradix10_o  <=  P_ZERO;                                
 			TWIradix11_o  <=  P_ZERO;                                
 			TWIradix12_o  <=  P_ZERO;                                
 			TWIradix13_o  <=  P_ZERO;                                
 			TWIradix14_o  <=  P_ZERO;                                
 			TWIradix15_o  <=  P_ZERO;                                
         end                                                         
         else begin                                                  
             MA_reg0  <= MA_in;                                      
             MA_reg1  <= MA_reg0;                                    
             MA_reg2  <= MA_reg1;                                    
             MA_reg3  <= MA_reg2;                                    
             MA_out   <= MA_reg3;                                    
 			//                                                       
             BN_reg0  <= BN_in;                                      
             BN_reg1  <= BN_reg0;                                    
             BN_reg2  <= BN_reg1;                                    
             BN_reg3  <= BN_reg2;                                    
             BN_out   <= BN_reg3;                                    
 			//                                                       
 		    TWIradix0_o   <=  TWIradix0_i;                           
 			TWIradix1_o   <=  TWIradix1_i;                           
 			TWIradix2_o   <=  TWIradix2_i;                           
 			TWIradix3_o   <=  TWIradix3_i;                           
 			TWIradix4_o   <=  TWIradix4_i;                           
 			TWIradix5_o   <=  TWIradix5_i;                           
 			TWIradix6_o   <=  TWIradix6_i;                           
 			TWIradix7_o   <=  TWIradix7_i;                           
 			TWIradix8_o   <=  TWIradix8_i;                           
 			TWIradix9_o   <=  TWIradix9_i;                           
 			TWIradix10_o  <=  TWIradix10_i;                          
 			TWIradix11_o  <=  TWIradix11_i;                          
 			TWIradix12_o  <=  TWIradix12_i;                          
 			TWIradix13_o  <=  TWIradix13_i;                          
 			TWIradix14_o  <=  TWIradix14_i;                          
 			TWIradix15_o  <=  TWIradix15_i;                          
         end                                                         
     end                                                             
                                                                     
 endmodule                                                           
