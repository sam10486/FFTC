//=============================================                                         
//Data:2020/04/08                                                                       
//note:output data and ExtB0_Dx Mux                                                     
//writter:shi yong wu                                                                   
//=============================================                                         
`timescale 1ns/10ps                                                                     
module Mux6(                                                                            
        ExtB0_D0,                                                                       
        ExtB0_D1,                                                                       
        ExtB0_D2,                                                                       
        ExtB0_D3,                                                                       
        ExtB0_D4,                                                                       
        ExtB0_D5,                                                                       
        ExtB0_D6,                                                                       
        ExtB0_D7,                                                                       
        ExtB0_D8,                                                                       
        ExtB0_D9,                                                                       
        ExtB0_D10,                                                                      
        ExtB0_D11,                                                                      
        ExtB0_D12,                                                                      
        ExtB0_D13,                                                                      
        ExtB0_D14,                                                                      
        ExtB0_D15,                                                                      
        MulD0_out,                                                                      
        MulD1_out,                                                                      
        MulD2_out,                                                                      
        MulD3_out,                                                                      
        MulD4_out,                                                                      
        MulD5_out,                                                                      
        MulD6_out,                                                                      
        MulD7_out,                                                                      
        MulD8_out,                                                                      
        MulD9_out,                                                                      
        MulD10_out,                                                                     
        MulD11_out,                                                                     
        MulD12_out,                                                                     
        MulD13_out,                                                                     
        MulD14_out,                                                                     
        MulD15_out,                                                                     
        B0M0_result,                                                                    
        B0M1_result,                                                                    
        B0M2_result,                                                                    
        B0M3_result,                                                                    
        B0M4_result,                                                                    
        B0M5_result,                                                                    
        B0M6_result,                                                                    
        B0M7_result,                                                                    
        B0M8_result,                                                                    
        B0M9_result,                                                                    
        B0M10_result,                                                                   
        B0M11_result,                                                                   
        B0M12_result,                                                                   
        B0M13_result,                                                                   
        B0M14_result,                                                                   
        B0M15_result,                                                                   
         ExtB1_D0,                                                             
         ExtB1_D1,                                                             
         ExtB1_D2,                                                             
         ExtB1_D3,                                                             
         ExtB1_D4,                                                             
         ExtB1_D5,                                                             
         ExtB1_D6,                                                             
         ExtB1_D7,                                                             
         ExtB1_D8,                                                             
         ExtB1_D9,                                                             
         ExtB1_D10,                                                             
         ExtB1_D11,                                                             
         ExtB1_D12,                                                             
         ExtB1_D13,                                                             
         ExtB1_D14,                                                             
         ExtB1_D15,                                                             
         BR_S0,                                                                
         BR_S1,                                                                
         BR_S2,                                                                
         BR_S3,                                                                
         BR_S4,                                                                
         BR_S5,                                                                
         BR_S6,                                                                
         BR_S7,                                                                
         BR_S8,                                                                
         BR_S9,                                                                
         BR_S10,                                                                
         BR_S11,                                                                
         BR_S12,                                                                
         BR_S13,                                                                
         BR_S14,                                                                
         BR_S15,                                                                
         B1M0_result,                                                          
         B1M1_result,                                                          
         B1M2_result,                                                          
         B1M3_result,                                                          
         B1M4_result,                                                          
         B1M5_result,                                                          
         B1M6_result,                                                          
         B1M7_result,                                                          
         B1M8_result,                                                          
         B1M9_result,                                                          
         B1M10_result,                                                          
         B1M11_result,                                                          
         B1M12_result,                                                          
         B1M13_result,                                                          
         B1M14_result,                                                          
         B1M15_result,                                                          
         m2_sel                                                                
);                                                                                      
                                                                                        
parameter CP_WIDTH = 22;                                                                
parameter CP_ZERO  = 22'd0;                                                             
                                                                                        
output [CP_WIDTH-1:0] ExtB0_D0;                                                         
output [CP_WIDTH-1:0] ExtB0_D1;                                                         
output [CP_WIDTH-1:0] ExtB0_D2;                                                         
output [CP_WIDTH-1:0] ExtB0_D3;                                                         
output [CP_WIDTH-1:0] ExtB0_D4;                                                         
output [CP_WIDTH-1:0] ExtB0_D5;                                                         
output [CP_WIDTH-1:0] ExtB0_D6;                                                         
output [CP_WIDTH-1:0] ExtB0_D7;                                                         
output [CP_WIDTH-1:0] ExtB0_D8;                                                         
output [CP_WIDTH-1:0] ExtB0_D9;                                                         
output [CP_WIDTH-1:0] ExtB0_D10;                                                        
output [CP_WIDTH-1:0] ExtB0_D11;                                                        
output [CP_WIDTH-1:0] ExtB0_D12;                                                        
output [CP_WIDTH-1:0] ExtB0_D13;                                                        
output [CP_WIDTH-1:0] ExtB0_D14;                                                        
output [CP_WIDTH-1:0] ExtB0_D15;                                                        
output [CP_WIDTH-1:0] MulD0_out;                                                        
output [CP_WIDTH-1:0] MulD1_out;                                                        
output [CP_WIDTH-1:0] MulD2_out;                                                        
output [CP_WIDTH-1:0] MulD3_out;                                                        
output [CP_WIDTH-1:0] MulD4_out;                                                        
output [CP_WIDTH-1:0] MulD5_out;                                                        
output [CP_WIDTH-1:0] MulD6_out;                                                        
output [CP_WIDTH-1:0] MulD7_out;                                                        
output [CP_WIDTH-1:0] MulD8_out;                                                        
output [CP_WIDTH-1:0] MulD9_out;                                                        
output [CP_WIDTH-1:0] MulD10_out;                                                       
output [CP_WIDTH-1:0] MulD11_out;                                                       
output [CP_WIDTH-1:0] MulD12_out;                                                       
output [CP_WIDTH-1:0] MulD13_out;                                                       
output [CP_WIDTH-1:0] MulD14_out;                                                       
output [CP_WIDTH-1:0] MulD15_out;                                                       
                                                                                        
 output [CP_WIDTH-1:0] ExtB1_D0;                                               
 output [CP_WIDTH-1:0] ExtB1_D1;                                               
 output [CP_WIDTH-1:0] ExtB1_D2;                                               
 output [CP_WIDTH-1:0] ExtB1_D3;                                               
 output [CP_WIDTH-1:0] ExtB1_D4;                                               
 output [CP_WIDTH-1:0] ExtB1_D5;                                               
 output [CP_WIDTH-1:0] ExtB1_D6;                                               
 output [CP_WIDTH-1:0] ExtB1_D7;                                               
 output [CP_WIDTH-1:0] ExtB1_D8;                                               
 output [CP_WIDTH-1:0] ExtB1_D9;                                               
 output [CP_WIDTH-1:0] ExtB1_D10;                                               
 output [CP_WIDTH-1:0] ExtB1_D11;                                               
 output [CP_WIDTH-1:0] ExtB1_D12;                                               
 output [CP_WIDTH-1:0] ExtB1_D13;                                               
 output [CP_WIDTH-1:0] ExtB1_D14;                                               
 output [CP_WIDTH-1:0] ExtB1_D15;                                               
 output [CP_WIDTH-1:0] BR_S0;                                                  
 output [CP_WIDTH-1:0] BR_S1;                                                  
 output [CP_WIDTH-1:0] BR_S2;                                                  
 output [CP_WIDTH-1:0] BR_S3;                                                  
 output [CP_WIDTH-1:0] BR_S4;                                                  
 output [CP_WIDTH-1:0] BR_S5;                                                  
 output [CP_WIDTH-1:0] BR_S6;                                                  
 output [CP_WIDTH-1:0] BR_S7;                                                  
 output [CP_WIDTH-1:0] BR_S8;                                                  
 output [CP_WIDTH-1:0] BR_S9;                                                  
 output [CP_WIDTH-1:0] BR_S10;                                                  
 output [CP_WIDTH-1:0] BR_S11;                                                  
 output [CP_WIDTH-1:0] BR_S12;                                                  
 output [CP_WIDTH-1:0] BR_S13;                                                  
 output [CP_WIDTH-1:0] BR_S14;                                                  
 output [CP_WIDTH-1:0] BR_S15;                                                  
                                                                               
 input                 m2_sel;                                                  
 input  [CP_WIDTH-1:0] B1M0_result;                                             
 input  [CP_WIDTH-1:0] B1M1_result;                                             
 input  [CP_WIDTH-1:0] B1M2_result;                                             
 input  [CP_WIDTH-1:0] B1M3_result;                                             
 input  [CP_WIDTH-1:0] B1M4_result;                                             
 input  [CP_WIDTH-1:0] B1M5_result;                                             
 input  [CP_WIDTH-1:0] B1M6_result;                                             
 input  [CP_WIDTH-1:0] B1M7_result;                                             
 input  [CP_WIDTH-1:0] B1M8_result;                                             
 input  [CP_WIDTH-1:0] B1M9_result;                                             
 input  [CP_WIDTH-1:0] B1M10_result;                                             
 input  [CP_WIDTH-1:0] B1M11_result;                                             
 input  [CP_WIDTH-1:0] B1M12_result;                                             
 input  [CP_WIDTH-1:0] B1M13_result;                                             
 input  [CP_WIDTH-1:0] B1M14_result;                                             
 input  [CP_WIDTH-1:0] B1M15_result;                                             
 input  [CP_WIDTH-1:0] B0M0_result;                                                       
 input  [CP_WIDTH-1:0] B0M1_result;                                                       
 input  [CP_WIDTH-1:0] B0M2_result;                                                       
 input  [CP_WIDTH-1:0] B0M3_result;                                                       
 input  [CP_WIDTH-1:0] B0M4_result;                                                       
 input  [CP_WIDTH-1:0] B0M5_result;                                                       
 input  [CP_WIDTH-1:0] B0M6_result;                                                       
 input  [CP_WIDTH-1:0] B0M7_result;                                                       
 input  [CP_WIDTH-1:0] B0M8_result;                                                       
 input  [CP_WIDTH-1:0] B0M9_result;                                                       
 input  [CP_WIDTH-1:0] B0M10_result;                                                      
 input  [CP_WIDTH-1:0] B0M11_result;                                                      
 input  [CP_WIDTH-1:0] B0M12_result;                                                      
 input  [CP_WIDTH-1:0] B0M13_result;                                                      
 input  [CP_WIDTH-1:0] B0M14_result;                                                      
 input  [CP_WIDTH-1:0] B0M15_result;                                                      
                                                                                        
  assign ExtB0_D0  =  B0M0_result; 
  assign ExtB0_D1  =  B0M1_result; 
  assign ExtB0_D2  =  B0M2_result; 
  assign ExtB0_D3  =  B0M3_result; 
  assign ExtB0_D4  =  B0M4_result; 
  assign ExtB0_D5  =  B0M5_result; 
  assign ExtB0_D6  =  B0M6_result; 
  assign ExtB0_D7  =  B0M7_result; 
  assign ExtB0_D8  =  B0M8_result; 
  assign ExtB0_D9  =  B0M9_result; 
  assign ExtB0_D10 =  B0M10_result;
  assign ExtB0_D11 =  B0M11_result;
  assign ExtB0_D12 =  B0M12_result;
  assign ExtB0_D13 =  B0M13_result;
  assign ExtB0_D14 =  B0M14_result;
  assign ExtB0_D15 =  B0M15_result;
  assign ExtB1_D0  =  B1M0_result; 
  assign ExtB1_D1  =  B1M1_result; 
  assign ExtB1_D2  =  B1M2_result; 
  assign ExtB1_D3  =  B1M3_result; 
  assign ExtB1_D4  =  B1M4_result; 
  assign ExtB1_D5  =  B1M5_result; 
  assign ExtB1_D6  =  B1M6_result; 
  assign ExtB1_D7  =  B1M7_result; 
  assign ExtB1_D8  =  B1M8_result; 
  assign ExtB1_D9  =  B1M9_result; 
  assign ExtB1_D10 =  B1M10_result; 
  assign ExtB1_D11 =  B1M11_result; 
  assign ExtB1_D12 =  B1M12_result; 
  assign ExtB1_D13 =  B1M13_result; 
  assign ExtB1_D14 =  B1M14_result; 
  assign ExtB1_D15 =  B1M15_result; 
                                                                                        
  assign MulD0_out  = ( m2_sel == 1'b1) ?  B0M0_result  : CP_ZERO;  
  assign MulD1_out  = ( m2_sel == 1'b1) ?  B0M1_result  : CP_ZERO;  
  assign MulD2_out  = ( m2_sel == 1'b1) ?  B0M2_result  : CP_ZERO;  
  assign MulD3_out  = ( m2_sel == 1'b1) ?  B0M3_result  : CP_ZERO;  
  assign MulD4_out  = ( m2_sel == 1'b1) ?  B0M4_result  : CP_ZERO;  
  assign MulD5_out  = ( m2_sel == 1'b1) ?  B0M5_result  : CP_ZERO;  
  assign MulD6_out  = ( m2_sel == 1'b1) ?  B0M6_result  : CP_ZERO;  
  assign MulD7_out  = ( m2_sel == 1'b1) ?  B0M7_result  : CP_ZERO;  
  assign MulD8_out  = ( m2_sel == 1'b1) ?  B0M8_result  : CP_ZERO;  
  assign MulD9_out  = ( m2_sel == 1'b1) ?  B0M9_result  : CP_ZERO;  
  assign MulD10_out = ( m2_sel == 1'b1) ?  B0M10_result : CP_ZERO;  
  assign MulD11_out = ( m2_sel == 1'b1) ?  B0M11_result : CP_ZERO;  
  assign MulD12_out = ( m2_sel == 1'b1) ?  B0M12_result : CP_ZERO;  
  assign MulD13_out = ( m2_sel == 1'b1) ?  B0M13_result : CP_ZERO;  
  assign MulD14_out = ( m2_sel == 1'b1) ?  B0M14_result : CP_ZERO;  
  assign MulD15_out = ( m2_sel == 1'b1) ?  B0M15_result : CP_ZERO;  
                                                                                        
   assign BR_S0  = ( m2_sel == 1'b1) ?  B1M0_result : CP_ZERO;    
   assign BR_S1  = ( m2_sel == 1'b1) ?  B1M1_result : CP_ZERO;    
   assign BR_S2  = ( m2_sel == 1'b1) ?  B1M2_result : CP_ZERO;    
   assign BR_S3  = ( m2_sel == 1'b1) ?  B1M3_result : CP_ZERO;    
   assign BR_S4  = ( m2_sel == 1'b1) ?  B1M4_result : CP_ZERO;    
   assign BR_S5  = ( m2_sel == 1'b1) ?  B1M5_result : CP_ZERO;    
   assign BR_S6  = ( m2_sel == 1'b1) ?  B1M6_result : CP_ZERO;    
   assign BR_S7  = ( m2_sel == 1'b1) ?  B1M7_result : CP_ZERO;    
   assign BR_S8  = ( m2_sel == 1'b1) ?  B1M8_result : CP_ZERO;    
   assign BR_S9  = ( m2_sel == 1'b1) ?  B1M9_result : CP_ZERO;    
   assign BR_S10 = ( m2_sel == 1'b1) ?  B1M10_result : CP_ZERO;    
   assign BR_S11 = ( m2_sel == 1'b1) ?  B1M11_result : CP_ZERO;    
   assign BR_S12 = ( m2_sel == 1'b1) ?  B1M12_result : CP_ZERO;    
   assign BR_S13 = ( m2_sel == 1'b1) ?  B1M13_result : CP_ZERO;    
   assign BR_S14 = ( m2_sel == 1'b1) ?  B1M14_result : CP_ZERO;    
   assign BR_S15 = ( m2_sel == 1'b1) ?  B1M15_result : CP_ZERO;    
                                                                                        
endmodule                                                                               
