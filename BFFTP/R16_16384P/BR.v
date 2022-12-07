 //==============================================                                                
 //Writer:Shi-Yong Wu                                                                            
 //                                                                                              
 //Note:Modular multiplier                                                                       
 //using barrett reduction                                                                       
 //==============================================                                                
 `timescale 1ns/1ps                                                                              
                                                                                                 
 module BR(                                                                                  
   S_in,                                                                                         
   result,                                                                                        
   rst_n,                                                                                        
   clk                                                                                          
 );                                                                                              
   parameter CP_ZERO             = 22'd0;                                                           
   parameter DATA_WIDTH          = 22;
   parameter DOUBLE_DATA_WIDTH   = 44;
   parameter DATA_FRI_RS_WIDTH   = 24;  // DOUBLE_DATA_WIDTH - rf_FRI                            
   parameter DATA_MULT_PRE_WIDTH = 48;                                                           
   parameter PAD_ZERO            = 44'b0;
   parameter Prime               = 22'd2146043;
   parameter rf_FRI              = 20;                                                           
   parameter rf_SEC              = 25;                                                           
   parameter pre_computing       = 24'd16394998;                                                 
                                                                                                 
   input [DOUBLE_DATA_WIDTH-1:0] S_in;                                                                  
   input clk;                                                                                    
   input rst_n;                                                                                  
                                                                                                 
   output [DATA_WIDTH-1:0] result;                                                                  
                                                                                                 
   reg  [DATA_WIDTH-1:0] result;                                                                    
                                                                                                 
   reg  [DATA_FRI_RS_WIDTH-1:0]S_out_RS; //32-14 = 18                                            
   reg  [DATA_MULT_PRE_WIDTH-1:0]af_pre; //18+16 = 34    mult by pre_computing                   
   reg  [DATA_WIDTH:0]Q;               //quotient                                              
   reg  [DOUBLE_DATA_WIDTH-1:0]QM;       //32 bits                                               
   reg  [DATA_WIDTH:0]C_Minus_QM;                                                                
   reg  [DATA_WIDTH:0]C_Minus_QM_1;                                                              
   reg  [DATA_WIDTH-1:0]C_Minus_QM_MUX;                                                          
                                                                                                 
      always@(*) begin    
         S_out_RS = S_in >> rf_FRI;                                                             
         af_pre   = S_out_RS * pre_computing;                                                    
         Q        = af_pre >> rf_SEC;                                                            
         QM       = Q * Prime;                                                                   
 	    //adder part                                                                             
         C_Minus_QM   = S_in - QM;                                                      
         C_Minus_QM_1 = C_Minus_QM -Prime;                                                       
                                                                                                 
         C_Minus_QM_MUX   = ((C_Minus_QM_1[DATA_WIDTH] == 1'b1))? C_Minus_QM:C_Minus_QM_1;       
      end                                                                                        
                                                                                                 
   always@(posedge clk,negedge rst_n)begin                                                       
     if(~rst_n)begin                                                                             
       result    <= CP_ZERO;                                                                      
 	end                                                                                          
 	else begin                                                                                   
       result    <= C_Minus_QM_MUX;
 	end                                                                                          
   end                                                                                           
                                                                                                 
                                                                                                 
 endmodule                                                                                       
