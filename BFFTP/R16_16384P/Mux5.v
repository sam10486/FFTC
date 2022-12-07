 //=============================================                              
 //Data:2020/04/08                                                            
 //note:re-order factor Mux                                                   
 //writter:shi yong wu                                                        
 //=============================================                              
 `timescale 1ns/10ps                                                          
 module Mux5(                                                                 
         B0M0_ain_o,                                                          
         B0M1_ain_o,                                                          
         B0M2_ain_o,                                                          
         B0M3_ain_o,                                                          
         B0M4_ain_o,                                                          
         B0M5_ain_o,                                                          
         B0M6_ain_o,                                                          
         B0M7_ain_o,                                                          
         B0M8_ain_o,                                                          
         B0M9_ain_o,                                                          
         B0M10_ain_o,                                                         
         B0M11_ain_o,                                                         
         B0M12_ain_o,                                                         
         B0M13_ain_o,                                                         
         B0M14_ain_o,                                                         
         B0M15_ain_o,                                                         
 		  B1M0_ain_o,                                                          
 		  B1M1_ain_o,                                                          
 		  B1M2_ain_o,                                                          
 		  B1M3_ain_o,                                                          
 		  B1M4_ain_o,                                                          
 		  B1M5_ain_o,                                                          
 		  B1M6_ain_o,                                                          
 		  B1M7_ain_o,                                                          
 		  B1M8_ain_o,                                                          
 		  B1M9_ain_o,                                                          
 		  B1M10_ain_o,                                                         
 		  B1M11_ain_o,                                                         
 		  B1M12_ain_o,                                                         
 		  B1M13_ain_o,                                                         
 		  B1M14_ain_o,                                                         
 		  B1M15_ain_o,                                                         
         B0M0_bin_o,                                                           
         B0M1_bin_o,                                                           
         B0M2_bin_o,                                                           
         B0M3_bin_o,                                                           
         B0M4_bin_o,                                                           
         B0M5_bin_o,                                                           
         B0M6_bin_o,                                                           
         B0M7_bin_o,                                                           
         B0M8_bin_o,                                                           
         B0M9_bin_o,                                                           
         B0M10_bin_o,                                                           
         B0M11_bin_o,                                                           
         B0M12_bin_o,                                                           
         B0M13_bin_o,                                                           
         B0M14_bin_o,                                                           
         B0M15_bin_o,                                                           
 		  B1M0_bin_o,                                                           
 		  B1M1_bin_o,                                                           
 		  B1M2_bin_o,                                                           
 		  B1M3_bin_o,                                                           
 		  B1M4_bin_o,                                                           
 		  B1M5_bin_o,                                                           
 		  B1M6_bin_o,                                                           
 		  B1M7_bin_o,                                                           
 		  B1M8_bin_o,                                                           
 		  B1M9_bin_o,                                                           
 		  B1M10_bin_o,                                                          
 		  B1M11_bin_o,                                                          
 		  B1M12_bin_o,                                                          
 		  B1M13_bin_o,                                                          
 		  B1M14_bin_o,                                                          
 		  B1M15_bin_o,                                                          
         ExtB0_D0_pip,                                                             
         ExtB0_D1_pip,                                                             
         ExtB0_D2_pip,                                                             
         ExtB0_D3_pip,                                                             
         ExtB0_D4_pip,                                                             
         ExtB0_D5_pip,                                                             
         ExtB0_D6_pip,                                                             
         ExtB0_D7_pip,                                                             
         ExtB1_D0_pip,                                                             
         ExtB1_D1_pip,                                                             
         ExtB1_D2_pip,                                                             
         ExtB1_D3_pip,                                                             
         ExtB1_D4_pip,                                                             
         ExtB1_D5_pip,                                                             
         ExtB1_D6_pip,                                                             
         ExtB1_D7_pip,                                                             
         SP_r0,                                                                
         SP_r1,                                                                
         SP_r2,                                                                
         SP_r3,                                                                
         SP_r4,                                                                
         SP_r5,                                                                
         SP_r6,                                                                
         SP_r7,                                                                
         SP_r8,                                                                
         SP_r9,                                                                
         SP_r10,                                                               
         SP_r11,                                                               
         SP_r12,                                                               
         SP_r13,                                                               
         SP_r14,                                                               
         SP_r15,                                                               
         reorderb0r0,                                                          
         reorderb0r1,                                                          
         reorderb0r2,                                                          
         reorderb0r3,                                                          
         reorderb0r4,                                                          
         reorderb0r5,                                                          
         reorderb0r6,                                                          
         reorderb0r7,                                                          
         ireorderr0,                                                           
         ireorderr1,                                                           
         ireorderr2,                                                           
         ireorderr3,                                                           
         ireorderr4,                                                           
         ireorderr5,                                                           
         ireorderr6,                                                           
         ireorderr7,                                                           
         ireorderr8,                                                           
         ireorderr9,                                                           
         ireorderr10,                                                          
         ireorderr11,                                                          
         ireorderr12,                                                          
         ireorderr13,                                                          
         ireorderr14,                                                          
         ireorderr15,                                                          
 		  CRUD0,                                                                                
 		  CRUD1,                                                                                
 		  CRUD2,                                                                                
 		  CRUD3,                                                                                
 		  CRUD4,                                                                                
 		  CRUD5,                                                                                
 		  CRUD6,                                                                                
 		  CRUD7,                                                                                
 		  CRUD8,                                                                                
 		  CRUD9,                                                                                
 		  CRUD10,                                                                                
 		  CRUD11,                                                                                
 		  CRUD12,                                                                                
 		  CRUD13,                                                                                
 		  CRUD14,                                                                                
 		  CRUD15,                                                                                
 		  reorderb1r0,                                                                          
 		  reorderb1r1,                                                                          
 		  reorderb1r2,                                                                          
 		  reorderb1r3,                                                                          
 		  reorderb1r4,                                                                          
 		  reorderb1r5,                                                                          
 		  reorderb1r6,                                                                          
 		  reorderb1r7,                                                                          
         re_sel                                                                
 );                                                                            
                                                                               
 parameter CP_WIDTH  = 22;                                                      
 parameter CP_ZERO   = 22'd0;                                                      
 parameter DOP_WIDTH  = 44;  //Double data width                                           
                                                                               
 output [CP_WIDTH-1:0] B0M0_ain_o;                                             
 output [CP_WIDTH-1:0] B0M1_ain_o;                                             
 output [CP_WIDTH-1:0] B0M2_ain_o;                                             
 output [CP_WIDTH-1:0] B0M3_ain_o;                                             
 output [CP_WIDTH-1:0] B0M4_ain_o;                                             
 output [CP_WIDTH-1:0] B0M5_ain_o;                                             
 output [CP_WIDTH-1:0] B0M6_ain_o;                                             
 output [CP_WIDTH-1:0] B0M7_ain_o;                                             
 output [CP_WIDTH-1:0] B0M8_ain_o;                                             
 output [CP_WIDTH-1:0] B0M9_ain_o;                                             
 output [CP_WIDTH-1:0] B0M10_ain_o;                                            
 output [CP_WIDTH-1:0] B0M11_ain_o;                                            
 output [CP_WIDTH-1:0] B0M12_ain_o;                                            
 output [CP_WIDTH-1:0] B0M13_ain_o;                                            
 output [CP_WIDTH-1:0] B0M14_ain_o;                                            
 output [CP_WIDTH-1:0] B0M15_ain_o;                                            
                                                                               
 output [CP_WIDTH-1:0] B0M0_bin_o;                                              
 output [CP_WIDTH-1:0] B0M1_bin_o;                                              
 output [CP_WIDTH-1:0] B0M2_bin_o;                                              
 output [CP_WIDTH-1:0] B0M3_bin_o;                                              
 output [CP_WIDTH-1:0] B0M4_bin_o;                                              
 output [CP_WIDTH-1:0] B0M5_bin_o;                                              
 output [CP_WIDTH-1:0] B0M6_bin_o;                                              
 output [CP_WIDTH-1:0] B0M7_bin_o;                                              
 output [CP_WIDTH-1:0] B0M8_bin_o;                                              
 output [CP_WIDTH-1:0] B0M9_bin_o;                                              
 output [CP_WIDTH-1:0] B0M10_bin_o;                                             
 output [CP_WIDTH-1:0] B0M11_bin_o;                                             
 output [CP_WIDTH-1:0] B0M12_bin_o;                                             
 output [CP_WIDTH-1:0] B0M13_bin_o;                                             
 output [CP_WIDTH-1:0] B0M14_bin_o;                                             
 output [CP_WIDTH-1:0] B0M15_bin_o;                                             
                                                                                              
 output [CP_WIDTH-1:0] B1M0_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M1_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M2_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M3_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M4_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M5_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M6_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M7_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M8_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M9_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M10_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M11_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M12_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M13_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M14_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M15_ain_o;                                                        
 output [CP_WIDTH-1:0] B1M0_bin_o;                                                         
 output [CP_WIDTH-1:0] B1M1_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M2_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M3_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M4_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M5_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M6_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M7_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M8_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M9_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M10_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M11_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M12_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M13_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M14_bin_o;                                                        
 output [CP_WIDTH-1:0] B1M15_bin_o;                                                        
                                                                                              
 input [CP_WIDTH-1:0]  reorderb1r0;                                            
 input [CP_WIDTH-1:0]  reorderb1r1;                                            
 input [CP_WIDTH-1:0]  reorderb1r2;                                            
 input [CP_WIDTH-1:0]  reorderb1r3;                                            
 input [CP_WIDTH-1:0]  reorderb1r4;                                            
 input [CP_WIDTH-1:0]  reorderb1r5;                                            
 input [CP_WIDTH-1:0]  reorderb1r6;                                            
 input [CP_WIDTH-1:0]  reorderb1r7;                                            
 input [DOP_WIDTH-1:0] CRUD0;                                                  
 input [DOP_WIDTH-1:0] CRUD1;                                                  
 input [DOP_WIDTH-1:0] CRUD2;                                                  
 input [DOP_WIDTH-1:0] CRUD3;                                                  
 input [DOP_WIDTH-1:0] CRUD4;                                                  
 input [DOP_WIDTH-1:0] CRUD5;                                                  
 input [DOP_WIDTH-1:0] CRUD6;                                                  
 input [DOP_WIDTH-1:0] CRUD7;                                                  
 input [DOP_WIDTH-1:0] CRUD8;                                                  
 input [DOP_WIDTH-1:0] CRUD9;                                                  
 input [DOP_WIDTH-1:0] CRUD10;                                                 
 input [DOP_WIDTH-1:0] CRUD11;                                                 
 input [DOP_WIDTH-1:0] CRUD12;                                                 
 input [DOP_WIDTH-1:0] CRUD13;                                                 
 input [DOP_WIDTH-1:0] CRUD14;                                                 
 input [DOP_WIDTH-1:0] CRUD15;                                                 
 input                 re_sel ;                                                
 input  [CP_WIDTH-1:0] ExtB0_D0_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D1_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D2_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D3_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D4_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D5_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D6_pip;                                           
 input  [CP_WIDTH-1:0] ExtB0_D7_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D0_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D1_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D2_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D3_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D4_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D5_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D6_pip;                                           
 input [CP_WIDTH-1:0]  ExtB1_D7_pip;                                           
 input  [CP_WIDTH-1:0] SP_r0;                                                  
 input  [CP_WIDTH-1:0] SP_r1;                                                  
 input  [CP_WIDTH-1:0] SP_r2;                                                  
 input  [CP_WIDTH-1:0] SP_r3;                                                  
 input  [CP_WIDTH-1:0] SP_r4;                                                  
 input  [CP_WIDTH-1:0] SP_r5;                                                  
 input  [CP_WIDTH-1:0] SP_r6;                                                  
 input  [CP_WIDTH-1:0] SP_r7;                                                  
 input  [CP_WIDTH-1:0] SP_r8;                                                  
 input  [CP_WIDTH-1:0] SP_r9;                                                  
 input  [CP_WIDTH-1:0] SP_r10;                                                 
 input  [CP_WIDTH-1:0] SP_r11;                                                 
 input  [CP_WIDTH-1:0] SP_r12;                                                 
 input  [CP_WIDTH-1:0] SP_r13;                                                 
 input  [CP_WIDTH-1:0] SP_r14;                                                 
 input  [CP_WIDTH-1:0] SP_r15;                                                 
                                                                               
 input [CP_WIDTH-1:0]  reorderb0r0;                                             
 input [CP_WIDTH-1:0]  reorderb0r1;                                             
 input [CP_WIDTH-1:0]  reorderb0r2;                                             
 input [CP_WIDTH-1:0]  reorderb0r3;                                             
 input [CP_WIDTH-1:0]  reorderb0r4;                                             
 input [CP_WIDTH-1:0]  reorderb0r5;                                             
 input [CP_WIDTH-1:0]  reorderb0r6;                                             
 input [CP_WIDTH-1:0]  reorderb0r7;                                             
 input [CP_WIDTH-1:0]  ireorderr0;                                              
 input [CP_WIDTH-1:0]  ireorderr1;                                              
 input [CP_WIDTH-1:0]  ireorderr2;                                              
 input [CP_WIDTH-1:0]  ireorderr3;                                              
 input [CP_WIDTH-1:0]  ireorderr4;                                              
 input [CP_WIDTH-1:0]  ireorderr5;                                              
 input [CP_WIDTH-1:0]  ireorderr6;                                              
 input [CP_WIDTH-1:0]  ireorderr7;                                              
 input [CP_WIDTH-1:0]  ireorderr8;                                              
 input [CP_WIDTH-1:0]  ireorderr9;                                              
 input [CP_WIDTH-1:0]  ireorderr10;                                             
 input [CP_WIDTH-1:0]  ireorderr11;                                             
 input [CP_WIDTH-1:0]  ireorderr12;                                             
 input [CP_WIDTH-1:0]  ireorderr13;                                             
 input [CP_WIDTH-1:0]  ireorderr14;                                             
 input [CP_WIDTH-1:0]  ireorderr15;                                             
                                                                               
                                                                               
   assign B0M0_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D0_pip : SP_r0;                 
   assign B0M1_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D1_pip : SP_r1;                 
   assign B0M2_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D2_pip : SP_r2;                 
   assign B0M3_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D3_pip : SP_r3;                 
   assign B0M4_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D4_pip : SP_r4;                 
   assign B0M5_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D5_pip : SP_r5;                 
   assign B0M6_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D6_pip : SP_r6;                 
   assign B0M7_ain_o  = ( re_sel == 1'b1) ?  ExtB0_D7_pip : SP_r7;                 
   assign B0M8_ain_o  = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r8;                 
   assign B0M9_ain_o  = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r9;                 
   assign B0M10_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r10;                
   assign B0M11_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r11;                
   assign B0M12_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r12;                
   assign B0M13_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r13;                
   assign B0M14_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r14;                
   assign B0M15_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      : SP_r15;                
                                                        //test                 
   assign B0M0_bin_o  = ( re_sel == 1'b1) ?  reorderb0r0 : ireorderr0;//       
   assign B0M1_bin_o  = ( re_sel == 1'b1) ?  reorderb0r1 : ireorderr1;//       
   assign B0M2_bin_o  = ( re_sel == 1'b1) ?  reorderb0r2 : ireorderr2;//       
   assign B0M3_bin_o  = ( re_sel == 1'b1) ?  reorderb0r3 : ireorderr3;//       
   assign B0M4_bin_o  = ( re_sel == 1'b1) ?  reorderb0r4 : ireorderr4;//       
   assign B0M5_bin_o  = ( re_sel == 1'b1) ?  reorderb0r5 : ireorderr5;//       
   assign B0M6_bin_o  = ( re_sel == 1'b1) ?  reorderb0r6 : ireorderr6;//       
   assign B0M7_bin_o  = ( re_sel == 1'b1) ?  reorderb0r7 : ireorderr7;//       
   assign B0M8_bin_o  = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr8;//       
   assign B0M9_bin_o  = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr9;//       
   assign B0M10_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr10;//      
   assign B0M11_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr11;//      
   assign B0M12_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr12;//      
   assign B0M13_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr13;//      
   assign B0M14_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr14;//      
   assign B0M15_bin_o = ( re_sel == 1'b1) ?  CP_ZERO     : ireorderr15;//      
                                                                               
 	assign B1M0_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D0_pip :CRUD0[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M1_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D1_pip :CRUD1[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M2_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D2_pip :CRUD2[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M3_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D3_pip :CRUD3[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M4_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D4_pip :CRUD4[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M5_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D5_pip :CRUD5[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M6_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D6_pip :CRUD6[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M7_ain_o  = ( re_sel == 1'b1) ?  ExtB1_D7_pip :CRUD7[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M8_ain_o  = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD8[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M9_ain_o  = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD9[DOP_WIDTH-1:CP_WIDTH]  ;      
 	assign B1M10_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD10[DOP_WIDTH-1:CP_WIDTH] ;       
 	assign B1M11_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD11[DOP_WIDTH-1:CP_WIDTH] ;       
 	assign B1M12_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD12[DOP_WIDTH-1:CP_WIDTH] ;       
 	assign B1M13_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD13[DOP_WIDTH-1:CP_WIDTH] ;       
 	assign B1M14_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD14[DOP_WIDTH-1:CP_WIDTH] ;       
 	assign B1M15_ain_o = ( re_sel == 1'b1) ?  CP_ZERO      :CRUD15[DOP_WIDTH-1:CP_WIDTH] ;       
                                                                                              
 	assign B1M0_bin_o  = ( re_sel == 1'b1) ? reorderb1r0  :CRUD0[CP_WIDTH-1:0]  ;                
 	assign B1M1_bin_o  = ( re_sel == 1'b1) ? reorderb1r1  :CRUD1[CP_WIDTH-1:0]  ;                
 	assign B1M2_bin_o  = ( re_sel == 1'b1) ? reorderb1r2  :CRUD2[CP_WIDTH-1:0]  ;                
 	assign B1M3_bin_o  = ( re_sel == 1'b1) ? reorderb1r3  :CRUD3[CP_WIDTH-1:0]  ;                
 	assign B1M4_bin_o  = ( re_sel == 1'b1) ? reorderb1r4  :CRUD4[CP_WIDTH-1:0]  ;                
 	assign B1M5_bin_o  = ( re_sel == 1'b1) ? reorderb1r5  :CRUD5[CP_WIDTH-1:0]  ;                
 	assign B1M6_bin_o  = ( re_sel == 1'b1) ? reorderb1r6  :CRUD6[CP_WIDTH-1:0]  ;                
 	assign B1M7_bin_o  = ( re_sel == 1'b1) ? reorderb1r7  :CRUD7[CP_WIDTH-1:0]  ;                
 	assign B1M8_bin_o  = ( re_sel == 1'b1) ? CP_ZERO      :CRUD8[CP_WIDTH-1:0]  ;                
 	assign B1M9_bin_o  = ( re_sel == 1'b1) ? CP_ZERO      :CRUD9[CP_WIDTH-1:0]  ;                
 	assign B1M10_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD10[CP_WIDTH-1:0] ;                 
 	assign B1M11_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD11[CP_WIDTH-1:0] ;                 
 	assign B1M12_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD12[CP_WIDTH-1:0] ;                 
 	assign B1M13_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD13[CP_WIDTH-1:0] ;                 
 	assign B1M14_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD14[CP_WIDTH-1:0] ;                 
 	assign B1M15_bin_o = ( re_sel == 1'b1) ? CP_ZERO      :CRUD15[CP_WIDTH-1:0] ;                 
 endmodule                                                                     
