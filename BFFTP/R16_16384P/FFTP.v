 `timescale 1 ns/1 ps                                                       
 module FFTP(  MulValid_out,                                                  
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

 			   ExtB0_D0_in,                                                   
 			   ExtB0_D1_in,                                                   
 			   ExtB0_D2_in,                                                   
 			   ExtB0_D3_in,                                                   
 			   ExtB0_D4_in,                                                   
 			   ExtB0_D5_in,                                                   
 			   ExtB0_D6_in,                                                   
 			   ExtB0_D7_in,  
               ExtB0_D8_in,
               ExtB0_D9_in, 
               ExtB0_D10_in,
               ExtB0_D11_in,
               ExtB0_D12_in,
               ExtB0_D13_in,
               ExtB0_D14_in,
               ExtB0_D15_in,

 			   ExtB1_D0_in,                                                   
 			   ExtB1_D1_in,                                                   
 			   ExtB1_D2_in,                                                   
 			   ExtB1_D3_in,                                                   
 			   ExtB1_D4_in,                                                   
 			   ExtB1_D5_in,                                                   
 			   ExtB1_D6_in,                                                   
 			   ExtB1_D7_in,  
               ExtB1_D8_in,
               ExtB1_D9_in,
               ExtB1_D10_in,
               ExtB1_D11_in,
               ExtB1_D12_in,
               ExtB1_D13_in,
               ExtB1_D14_in,
               ExtB1_D15_in,

 			   N_in,                                                          
 			   ExtValid_in,                                                   
               rst_n,                                                         
               clk                                                            
             ) ;                                                            
 			                                                                  
 parameter CP_WIDTH    = 22;
 parameter DOP_WIDTH   = 44;
 parameter HP_WIDTH    = 32 ; 			                                  
 parameter P_WIDTH     = 64 ; 			                                  
 parameter A_WIDTH     = 9;
 parameter SD_WIDTH    = 128 ;                                              
 parameter ROMA_WIDTH  = 10;
 parameter IREMA_WIDTH = 9;
 parameter DC_WIDTH    = 13;
 parameter OUT_PIPE_WIDTH   = 20;
 //----------siang record--------
 parameter DCNT_BP4 = 10 ;
 parameter S_WIDTH   = 4 ;
 parameter SC_WIDTH    = 3; 

 wire [S_WIDTH-1:0] state;
 //-------------------------------
                                                                            
                                                                            
 output                MulValid_out ;                                       
                                                                            
 output[P_WIDTH-1:0]   MulD0_out ;                                          
 output[P_WIDTH-1:0]   MulD1_out ;                                          
 output[P_WIDTH-1:0]   MulD2_out ;                                          
 output[P_WIDTH-1:0]   MulD3_out ;                                          
 output[P_WIDTH-1:0]   MulD4_out ;                                          
 output[P_WIDTH-1:0]   MulD5_out ;                                          
 output[P_WIDTH-1:0]   MulD6_out ;                                          
 output[P_WIDTH-1:0]   MulD7_out ;                                          
 output[P_WIDTH-1:0]   MulD8_out ;                                          
 output[P_WIDTH-1:0]   MulD9_out ;                                          
 output[P_WIDTH-1:0]   MulD10_out ;                                         
 output[P_WIDTH-1:0]   MulD11_out ;                                         
 output[P_WIDTH-1:0]   MulD12_out ;                                         
 output[P_WIDTH-1:0]   MulD13_out ;                                         
 output[P_WIDTH-1:0]   MulD14_out ;                                         
 output[P_WIDTH-1:0]   MulD15_out ;                                         
                                                                            
                                                                            
 input  [P_WIDTH-1:0] ExtB0_D0_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D1_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D2_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D3_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D4_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D5_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D6_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D7_in ;  
 input  [P_WIDTH-1:0] ExtB0_D8_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D9_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D10_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D11_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D12_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D13_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D14_in ;                                         
 input  [P_WIDTH-1:0] ExtB0_D15_in ;  

 input  [P_WIDTH-1:0] ExtB1_D0_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D1_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D2_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D3_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D4_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D5_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D6_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D7_in ;      
 input  [P_WIDTH-1:0] ExtB1_D8_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D9_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D10_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D11_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D12_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D13_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D14_in ;                                         
 input  [P_WIDTH-1:0] ExtB1_D15_in ;

 input  [P_WIDTH-1:0] N_in ;                                                
 input                ExtValid_in ;                                         
 input                rst_n ;                                               
 input                clk ;                                                 
 //=============================================                                      
                                                                                                                                                     
 wire [SD_WIDTH-1:0]  Data_out0 ;                                           
 wire [SD_WIDTH-1:0]  Data_out1 ;                                           
 wire [SD_WIDTH-1:0]  Data_out2 ;                                           
 wire [SD_WIDTH-1:0]  Data_out3 ;                                           
 wire [SD_WIDTH-1:0]  Data_out4 ;                                           
 wire [SD_WIDTH-1:0]  Data_out5 ;                                           
 wire [SD_WIDTH-1:0]  Data_out6 ;                                           
 wire [SD_WIDTH-1:0]  Data_out7 ;                                           
 wire [SD_WIDTH-1:0]  Data_out8 ;                                           
 wire [SD_WIDTH-1:0]  Data_out9 ;                                           
 wire [SD_WIDTH-1:0]  Data_out10 ;                                          
 wire [SD_WIDTH-1:0]  Data_out11 ;                                          
 wire [SD_WIDTH-1:0]  Data_out12 ;                                          
 wire [SD_WIDTH-1:0]  Data_out13 ;                                          
 wire [SD_WIDTH-1:0]  Data_out14 ;                                          
 wire [SD_WIDTH-1:0]  Data_out15 ;                                          
 wire                 cen_wire ;                                            
 wire                 wen0_wire ;                                           
 wire                 wen1_wire ;                                           
 wire                 SD_sel_wire ;                                         
 wire [A_WIDTH-1:0]   ExtMA_wire ;                                          
 wire [A_WIDTH-1:0]   AGUMA_wire ;                                          
 wire [A_WIDTH-1:0]   MA0_wire ;                                            
 wire [A_WIDTH-1:0]   MA1_wire ;                                            
 wire                 AGU_en_wire ;                                         
 wire [SD_WIDTH-1:0]  BN0_MEM0_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM1_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM2_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM3_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM4_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM5_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM6_wire ;                                       
 wire [SD_WIDTH-1:0]  BN0_MEM7_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM0_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM1_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM2_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM3_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM4_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM5_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM6_wire ;                                       
 wire [SD_WIDTH-1:0]  BN1_MEM7_wire ;                                       
 wire                 BN_wire ;                                             
 wire [P_WIDTH-1:0]   RA0D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA1D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA2D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA3D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA4D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA5D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA6D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA7D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA8D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA9D_in_wire ;                                        
 wire [P_WIDTH-1:0]   RA10D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA11D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA12D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA13D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA14D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA15D_in_wire ;                                       
 wire [P_WIDTH-1:0]   RA0D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA1D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA2D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA3D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA4D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA5D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA6D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA7D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA8D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA9D_out_wire ;                                       
 wire [P_WIDTH-1:0]   RA10D_out_wire ;                                      
 wire [P_WIDTH-1:0]   RA11D_out_wire ;                                      
 wire [P_WIDTH-1:0]   RA12D_out_wire ;                                      
 wire [P_WIDTH-1:0]   RA13D_out_wire ;                                      
 wire [P_WIDTH-1:0]   RA14D_out_wire ;                                      
 wire [P_WIDTH-1:0]   RA15D_out_wire ;                                      
                                                                            
 wire                 RomCen_wire ;                                         
 wire [ROMA_WIDTH-1:0] ROMA_wire ;                                          
 wire [P_WIDTH-1:0]   ROMD0_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD1_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD2_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD3_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD4_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD5_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD6_out_wire ;                                      
 wire [SD_WIDTH-1:0]  ROMD7_out_wire ;     
 wire                 DC_mode_sel_wire;
 wire                 BU_mode_sel_wire;                                  
 wire                 Mul_sel_wire ;                                        
 wire [P_WIDTH-1:0]   MulB0_wire ;                                          
 wire [P_WIDTH-1:0]   MulB1_wire ;                                          
 wire [P_WIDTH-1:0]   MulB2_wire ;                                          
 wire [P_WIDTH-1:0]   MulB3_wire ;                                          
 wire [P_WIDTH-1:0]   MulB4_wire ;                                          
 wire [P_WIDTH-1:0]   MulB5_wire ;                                          
 wire [P_WIDTH-1:0]   MulB6_wire ;                                          
 wire [P_WIDTH-1:0]   MulB7_wire ;                                          
 wire [P_WIDTH-1:0]   MulB8_wire ;                                          
 wire [P_WIDTH-1:0]   MulB9_wire ;                                          
 wire [P_WIDTH-1:0]   MulB10_wire ;                                         
 wire [P_WIDTH-1:0]   MulB11_wire ;                                         
 wire [P_WIDTH-1:0]   MulB12_wire ;                                         
 wire [P_WIDTH-1:0]   MulB13_wire ;                                         
 wire [P_WIDTH-1:0]   MulB14_wire ;                                         
 wire [P_WIDTH-1:0]   MulB15_wire ;                                         
 wire [P_WIDTH-1:0]   MulMod0_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod1_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod2_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod3_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod4_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod5_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod6_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod7_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod8_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod9_out_wire ;                                    
 wire [P_WIDTH-1:0]   MulMod10_out_wire ;                                   
 wire [P_WIDTH-1:0]   MulMod11_out_wire ;                                   
 wire [P_WIDTH-1:0]   MulMod12_out_wire ;                                   
 wire [P_WIDTH-1:0]   MulMod13_out_wire ;                                   
 wire [P_WIDTH-1:0]   MulMod14_out_wire ;                                   
 wire [P_WIDTH-1:0]   MulMod15_out_wire ;                                   
 wire [P_WIDTH-1:0]   RDC_out0_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out1_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out2_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out3_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out4_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out5_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out6_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out7_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out8_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out9_wire ;                                       
 wire [P_WIDTH-1:0]   RDC_out10_wire ;                                      
 wire [P_WIDTH-1:0]   RDC_out11_wire ;                                      
 wire [P_WIDTH-1:0]   RDC_out12_wire ;                                      
 wire [P_WIDTH-1:0]   RDC_out13_wire ;                                      
 wire [P_WIDTH-1:0]   RDC_out14_wire ;                                      
 wire [P_WIDTH-1:0]   RDC_out15_wire ;                                      
 wire [3:0]           RDC_sel_wire ;                                        
 wire                 BND_wire ;                                            
 wire [A_WIDTH-1:0]   WMA_wire ;                                            
                                                                            
 wire [DC_WIDTH-1:0]  data_cnt_wire ;                                                                                                              
                                                                                                              
 wire [P_WIDTH-1:0]   MulA1_wire ;                                          
 wire [P_WIDTH-1:0]   MulA2_wire ;                                          
 wire [P_WIDTH-1:0]   MulA3_wire ;                                          
 wire [P_WIDTH-1:0]   MulA4_wire ;                                          
 wire [P_WIDTH-1:0]   MulA5_wire ;                                          
 wire [P_WIDTH-1:0]   MulA6_wire ;                                          
 wire [P_WIDTH-1:0]   MulA7_wire ;                                          
 wire [P_WIDTH-1:0]   MulA9_wire ;                                          
 wire [P_WIDTH-1:0]   MulA10_wire ;                                         
 wire [P_WIDTH-1:0]   MulA11_wire ;                                         
 wire [P_WIDTH-1:0]   MulA12_wire ;                                         
 wire [P_WIDTH-1:0]   MulA13_wire ;                                         
 wire [P_WIDTH-1:0]   MulA14_wire ;                                         
 wire [P_WIDTH-1:0]   MulA15_wire ;                                   
                                                                                                                                                  
 wire                 rc_sel_wire ; //modify 2020/02/24                     
 wire                 m2_sel_wire ;     
                                                                                                                                               
 wire                  Mul_sel_D_wire ;                                     
 wire [3:0]            RDC_sel_D_wire ;                                     
 wire                  DC_mode_sel_D_wire ;                                 
 wire                  BU_mode_sel_D_wire ;                                                                    
 wire                  wrfd_en_wire ;                                       
                                                                            
 wire [P_WIDTH-1:0]    RDC_out0_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out1_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out2_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out3_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out4_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out5_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out6_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out7_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out8_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out9_D_wire ;                                    
 wire [P_WIDTH-1:0]    RDC_out10_D_wire ;                                   
 wire [P_WIDTH-1:0]    RDC_out11_D_wire ;                                   
 wire [P_WIDTH-1:0]    RDC_out12_D_wire ;                                   
 wire [P_WIDTH-1:0]    RDC_out13_D_wire ;                                   
 wire [P_WIDTH-1:0]    RDC_out14_D_wire ;                                   
 wire [P_WIDTH-1:0]    RDC_out15_D_wire ;                                   
                                                                                                                                        
 wire [P_WIDTH-1:0]    N_D4_wire ;                                          
 wire [P_WIDTH-1:0]    ROMD0_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD1_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD2_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD3_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD4_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD5_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD6_D_wire ;                                       
 wire [SD_WIDTH-1:0]   ROMD7_D_wire ;                                       

 	CenCtrl u_CenCtrl(
                      .state(state),
                      .MulValid_out(MulValid_out),                            
 			          .cen_out(cen_wire),                                     
 			          .wen0_out(wen0_wire),                                   
 			          .wen1_out(wen1_wire),                                   
 			          .SD_sel_out(SD_sel_wire),                               
 			          .ExtMA_out(ExtMA_wire),                                 
 					  .AGU_en_out(AGU_en_wire),                               
 					  .RomCen_out(RomCen_wire),                               
 					  .rc_sel_out(rc_sel_wire),                               
 					  .m2_sel_out(m2_sel_wire),  //modify 2020/02/24          
 					  .wrfd_en_out(wrfd_en_wire),                             
 					  .data_cnt_in(data_cnt_wire),                            
 					  .BND_in(BND_wire),                                      
 			          .ExtValid_in(ExtValid_in),                              
                      .rst_n(rst_n),                                          
                      .clk(clk)                   
                    ) ;                                                     
 	                                                                          
 	//                                                                        
 	R16_AGU u_R16_AGU(.BN_out(BN_wire),                                       
 			          .MA(AGUMA_wire),                                        
 					  .ROMA(ROMA_wire),
					  .DC_mode_sel_out(DC_mode_sel_wire),
                      .BU_mode_sel_out(BU_mode_sel_wire),					  
 					  .Mul_sel_out(Mul_sel_wire),                             
 					  .RDC_sel_out(RDC_sel_wire),                             
 					  .data_cnt_reg(data_cnt_wire),                                                                        
 					  .rc_sel_in(rc_sel_wire),                                
 			          .AGU_en(AGU_en_wire),                                   
 					  .wrfd_en_in(wrfd_en_wire),                              
                      .rst_n(rst_n),                                          
                      .clk(clk)                                      
                    ) ;                                                     
 	                                                                          
 	//Control Signal Pipeline Register                                        
 	Ctrl_PipeReg1 u_Ctrl_PipeReg1(.DC_mode_sel_Dout(DC_mode_sel_D_wire),
	                              .BU_mode_sel_Dout(BU_mode_sel_D_wire),            
 				                  .Mul_sel_Dout(Mul_sel_D_wire),              
 				                  .RDC_sel_Dout(RDC_sel_D_wire),
								  .DC_mode_sel_in(DC_mode_sel_wire),
								  .BU_mode_sel_in(BU_mode_sel_wire),
 			                      .Mul_sel_in(Mul_sel_wire),                  
 			                      .RDC_sel_in(RDC_sel_wire),                  
                                  .rst_n(rst_n),                              
                                  .clk(clk)                     
                                ) ;                                         
 	R16_WAddr u_R16_WAddr(.BND_out(BND_wire),                                 
 			              .WMA_out(WMA_wire),                                 
                          .BN_in(BN_wire),                                 
 		                  .MA_in(AGUMA_wire),                                 
                          .rst_n(rst_n),                                   
                          .clk(clk)                                           
                        ) ;                                                 
 	                                                                                                                                                                       
 	//for SRAM                                                                
 	Mux1 u_Mux1(.BN0_MEM0_Dout(BN0_MEM0_wire),                                
 			    .BN0_MEM1_Dout(BN0_MEM1_wire),                                
 				.BN0_MEM2_Dout(BN0_MEM2_wire),                                
 				.BN0_MEM3_Dout(BN0_MEM3_wire),                                
 			    .BN0_MEM4_Dout(BN0_MEM4_wire),                                
 			    .BN0_MEM5_Dout(BN0_MEM5_wire),                                
 			    .BN0_MEM6_Dout(BN0_MEM6_wire),                                
 			    .BN0_MEM7_Dout(BN0_MEM7_wire),                                
 			    .BN1_MEM0_Dout(BN1_MEM0_wire),                                
 			    .BN1_MEM1_Dout(BN1_MEM1_wire),                                
 				.BN1_MEM2_Dout(BN1_MEM2_wire),                                
 			    .BN1_MEM3_Dout(BN1_MEM3_wire),                                
 			    .BN1_MEM4_Dout(BN1_MEM4_wire),                                
 			    .BN1_MEM5_Dout(BN1_MEM5_wire),                                
 			    .BN1_MEM6_Dout(BN1_MEM6_wire),                                
 			    .BN1_MEM7_Dout(BN1_MEM7_wire),                                
 				.MA0_out(MA0_wire),                                           
 				.MA1_out(MA1_wire),                                           
 		        .ExtB0_D0_in(ExtB0_D0_in),                                    
 			    .ExtB0_D1_in(ExtB0_D1_in),                                    
 			    .ExtB0_D2_in(ExtB0_D2_in),                                    
 			    .ExtB0_D3_in(ExtB0_D3_in),                                    
 				.ExtB0_D4_in(ExtB0_D4_in),                                    
 				.ExtB0_D5_in(ExtB0_D5_in),                                    
 			    .ExtB0_D6_in(ExtB0_D6_in),                                    
 			    .ExtB0_D7_in(ExtB0_D7_in),                                    
 			    .ExtB0_D8_in(ExtB0_D8_in),                                    
 			    .ExtB0_D9_in(ExtB0_D9_in),                                    
 			    .ExtB0_D10_in(ExtB0_D10_in),                                  
 			    .ExtB0_D11_in(ExtB0_D11_in),                                  
 			    .ExtB0_D12_in(ExtB0_D12_in),                                  
 			    .ExtB0_D13_in(ExtB0_D13_in),                                  
 			    .ExtB0_D14_in(ExtB0_D14_in),                                  
 			    .ExtB0_D15_in(ExtB0_D15_in),                                  
 			    .ExtB1_D0_in(ExtB1_D0_in),                                    
 			    .ExtB1_D1_in(ExtB1_D1_in),                                    
                .ExtB1_D2_in(ExtB1_D2_in),                                    
 			    .ExtB1_D3_in(ExtB1_D3_in),                                    
 				.ExtB1_D4_in(ExtB1_D4_in),                                    
 			    .ExtB1_D5_in(ExtB1_D5_in),                                    
 			    .ExtB1_D6_in(ExtB1_D6_in),                                    
 			    .ExtB1_D7_in(ExtB1_D7_in),                                    
 			    .ExtB1_D8_in(ExtB1_D8_in),                                    
 			    .ExtB1_D9_in(ExtB1_D9_in),                                    
 			    .ExtB1_D10_in(ExtB1_D10_in),                                  
 			    .ExtB1_D11_in(ExtB1_D11_in),                                  
 			    .ExtB1_D12_in(ExtB1_D12_in),                                  
 			    .ExtB1_D13_in(ExtB1_D13_in),                                  
 			    .ExtB1_D14_in(ExtB1_D14_in),                                  
 			    .ExtB1_D15_in(ExtB1_D15_in),                                  
 				.RDC_in0(RDC_out0_D_wire),                                    
 				.RDC_in1(RDC_out1_D_wire),                                    
 				.RDC_in2(RDC_out2_D_wire),                                    
 				.RDC_in3(RDC_out3_D_wire),                                    
 				.RDC_in4(RDC_out4_D_wire),                                    
 			    .RDC_in5(RDC_out5_D_wire),                                    
 			    .RDC_in6(RDC_out6_D_wire),                                    
 			    .RDC_in7(RDC_out7_D_wire),                                    
 			    .RDC_in8(RDC_out8_D_wire),                                    
 			    .RDC_in9(RDC_out9_D_wire),                                    
 			    .RDC_in10(RDC_out10_D_wire),                                  
 			    .RDC_in11(RDC_out11_D_wire),                                  
 			    .RDC_in12(RDC_out12_D_wire),                                  
 			    .RDC_in13(RDC_out13_D_wire),                                  
 			    .RDC_in14(RDC_out14_D_wire),                                  
 			    .RDC_in15(RDC_out15_D_wire),                                  
 				.ExtMA_in(ExtMA_wire),                                        
 				.AGUMA_in(AGUMA_wire),                                        
 				.WMA_in(WMA_wire),                                            
 				.wen0_in(wen0_wire),                                          
 				.wen1_in(wen1_wire),                                          
 			    .SD_sel(SD_sel_wire)                                      
 			    ) ;                                                           
 	                                                                          
 	//for Radix-16                                                            
 	Mux2 u_Mux2(.RA0_out(RA0D_in_wire),                                       
 			    .RA1_out(RA1D_in_wire),                                       
 			    .RA2_out(RA2D_in_wire),                                       
 			    .RA3_out(RA3D_in_wire),                                       
 				.RA4_out(RA4D_in_wire),                                       
 			    .RA5_out(RA5D_in_wire),                                       
 			    .RA6_out(RA6D_in_wire),                                       
 			    .RA7_out(RA7D_in_wire),                                       
 			    .RA8_out(RA8D_in_wire),                                       
 			    .RA9_out(RA9D_in_wire),                                       
 			    .RA10_out(RA10D_in_wire),                                     
 			    .RA11_out(RA11D_in_wire),                                     
 			    .RA12_out(RA12D_in_wire),                                     
 			    .RA13_out(RA13D_in_wire),                                     
 			    .RA14_out(RA14D_in_wire),                                     
 			    .RA15_out(RA15D_in_wire),                                     
 		        .BN0_MEM0_in(Data_out0),                                      
 			    .BN0_MEM1_in(Data_out1),                                      
 				.BN0_MEM2_in(Data_out2),                                      
 				.BN0_MEM3_in(Data_out3),                                      
 			    .BN0_MEM4_in(Data_out4),                                      
 			    .BN0_MEM5_in(Data_out5),                                      
 			    .BN0_MEM6_in(Data_out6),                                      
 			    .BN0_MEM7_in(Data_out7),                                      
 			    .BN1_MEM0_in(Data_out8),                                      
 			    .BN1_MEM1_in(Data_out9),                                      
 				.BN1_MEM2_in(Data_out10),                                     
 			    .BN1_MEM3_in(Data_out11),                                     
 			    .BN1_MEM4_in(Data_out12),                                     
 			    .BN1_MEM5_in(Data_out13),                                     
 			    .BN1_MEM6_in(Data_out14),                                     
 			    .BN1_MEM7_in(Data_out15),                                     
 			    .BN_sel(BN_wire)                                                          
 			    ) ;                                                           
 	                                                                          
 	//                                                                        
 	Radix16_Pipe u_Radix16_Pipe(.RA0_out(RA0D_out_wire),                      
 			                    .RA1_out(RA1D_out_wire),                      
 			                    .RA2_out(RA2D_out_wire),                      
 			                    .RA3_out(RA3D_out_wire),                      
 					            .RA4_out(RA4D_out_wire),                      
 			                    .RA5_out(RA5D_out_wire),                      
 			                    .RA6_out(RA6D_out_wire),                      
 			                    .RA7_out(RA7D_out_wire),                      
 			                    .RA8_out(RA8D_out_wire),                      
 			                    .RA9_out(RA9D_out_wire),                      
 			                    .RA10_out(RA10D_out_wire),                    
 			                    .RA11_out(RA11D_out_wire),                    
 			                    .RA12_out(RA12D_out_wire),                    
 			                    .RA13_out(RA13D_out_wire),                    
 			                    .RA14_out(RA14D_out_wire),                    
 			                    .RA15_out(RA15D_out_wire),                    
                                .RA0_in(RA0D_in_wire),                        
 			                    .RA1_in(RA1D_in_wire),                        
 			                    .RA2_in(RA2D_in_wire),                        
 			                    .RA3_in(RA3D_in_wire),                        
 					            .RA4_in(RA4D_in_wire),                        
 			                    .RA5_in(RA5D_in_wire),                        
 			                    .RA6_in(RA6D_in_wire),                        
 			                    .RA7_in(RA7D_in_wire),                        
 			                    .RA8_in(RA8D_in_wire),                        
 			                    .RA9_in(RA9D_in_wire),                        
 			                    .RA10_in(RA10D_in_wire),                      
 			                    .RA11_in(RA11D_in_wire),                      
 			                    .RA12_in(RA12D_in_wire),                      
 			                    .RA13_in(RA13D_in_wire),                      
 			                    .RA14_in(RA14D_in_wire),                      
 			                    .RA15_in(RA15D_in_wire),
                                .BU_mode_sel(BU_mode_sel_D_wire),								
 		                        .N_in(N_in),                                  
                                .rst_n(rst_n),                                
                                .clk(clk)                                                           
                              ) ;                                           
 	                                                     
 	//Pipeline Register                                                       
 	R16_NPipeReg3 u_R16_NPipeReg3(.N_D4_out(N_D4_wire),                       
                                   .N_in(N_in),                             
                                   .rst_n(rst_n),                           
                                   .clk(clk)                                    
                                   ) ;                                      
                                                                       
 	                                                                    	                                                                          
 	//                                                                        
 	R16_DC u_R16_DC(.RDC_out0(RDC_out0_wire),                                 
 			        .RDC_out1(RDC_out1_wire),                                 
 			        .RDC_out2(RDC_out2_wire),                                 
 			        .RDC_out3(RDC_out3_wire),                                 
 					.RDC_out4(RDC_out4_wire),                                 
 			        .RDC_out5(RDC_out5_wire),                                 
 			        .RDC_out6(RDC_out6_wire),                                 
 			        .RDC_out7(RDC_out7_wire),                                 
 			        .RDC_out8(RDC_out8_wire),                                 
 			        .RDC_out9(RDC_out9_wire),                                 
 			        .RDC_out10(RDC_out10_wire),                               
 			        .RDC_out11(RDC_out11_wire),                               
 			        .RDC_out12(RDC_out12_wire),                               
 			        .RDC_out13(RDC_out13_wire),                               
 			        .RDC_out14(RDC_out14_wire),                               
 			        .RDC_out15(RDC_out15_wire),                               
                    .RDC_in0(MulMod0_out_wire),                               
 		            .RDC_in1(MulMod1_out_wire),                               
 			        .RDC_in2(MulMod2_out_wire),                               
 			        .RDC_in3(MulMod3_out_wire),                               
 					.RDC_in4(MulMod4_out_wire),                               
 			        .RDC_in5(MulMod5_out_wire),                               
 			        .RDC_in6(MulMod6_out_wire),                               
 			        .RDC_in7(MulMod7_out_wire),                               
 			        .RDC_in8(MulMod8_out_wire),                               
 			        .RDC_in9(MulMod9_out_wire),                               
 			        .RDC_in10(MulMod10_out_wire),                             
 			        .RDC_in11(MulMod11_out_wire),                             
 			        .RDC_in12(MulMod12_out_wire),                             
 			        .RDC_in13(MulMod13_out_wire),                             
 			        .RDC_in14(MulMod14_out_wire),                             
 			        .RDC_in15(MulMod15_out_wire),                             
 			        .RDC_sel(RDC_sel_D_wire),
                    .DC_mode_sel_in(DC_mode_sel_D_wire),					
                    .rst_n(rst_n),                                         
                    .clk(clk)                                                                         
                     ) ;                                                    
 	                                                                          
 	//                                                                        
 	R16_WD_buf u_R16_WD_buf(.RDC0_D_out(RDC_out0_D_wire),                     
 			                .RDC1_D_out(RDC_out1_D_wire),                     
 				            .RDC2_D_out(RDC_out2_D_wire),                     
 				            .RDC3_D_out(RDC_out3_D_wire),                     
 				            .RDC4_D_out(RDC_out4_D_wire),                     
 				            .RDC5_D_out(RDC_out5_D_wire),                     
 				            .RDC6_D_out(RDC_out6_D_wire),                     
 				            .RDC7_D_out(RDC_out7_D_wire),                     
 				            .RDC8_D_out(RDC_out8_D_wire),                     
 				            .RDC9_D_out(RDC_out9_D_wire),                     
 				            .RDC10_D_out(RDC_out10_D_wire),                   
 				            .RDC11_D_out(RDC_out11_D_wire),                   
 				            .RDC12_D_out(RDC_out12_D_wire),                   
 				            .RDC13_D_out(RDC_out13_D_wire),                   
 				            .RDC14_D_out(RDC_out14_D_wire),                   
 				            .RDC15_D_out(RDC_out15_D_wire),                   
 		                    .RDC0_in(RDC_out0_wire),                          
 				            .RDC1_in(RDC_out1_wire),                          
 				            .RDC2_in(RDC_out2_wire),                          
 				            .RDC3_in(RDC_out3_wire),                          
 				            .RDC4_in(RDC_out4_wire),                          
 				            .RDC5_in(RDC_out5_wire),                          
 				            .RDC6_in(RDC_out6_wire),                          
 				            .RDC7_in(RDC_out7_wire),                          
 				            .RDC8_in(RDC_out8_wire),                          
 				            .RDC9_in(RDC_out9_wire),                          
 				            .RDC10_in(RDC_out10_wire),                        
 				            .RDC11_in(RDC_out11_wire),                        
 				            .RDC12_in(RDC_out12_wire),                        
 				            .RDC13_in(RDC_out13_wire),                        
 				            .RDC14_in(RDC_out14_wire),                        
 				            .RDC15_in(RDC_out15_wire),                        
                            .rst_n(rst_n),                                    
                            .clk(clk)                                           
                          ) ;                                               
 	                                                                          
 	//-----------------------------------------------------                   
 	// for CRUR16                                                             
 	Mux4 u_Mux4(.Result0_out(MulD0_out),                                       
 			    .Result1_out(MulD1_out),                                       
 			    .Result2_out(MulD2_out),                                       
 			    .Result3_out(MulD3_out),                                       
 				.Result4_out(MulD4_out),                                       
 			    .Result5_out(MulD5_out),                                       
 			    .Result6_out(MulD6_out),                                       
 			    .Result7_out(MulD7_out),                                       
 			    .Result8_out(MulD8_out),                                       
 			    .Result9_out(MulD9_out),                                       
 			    .Result10_out(MulD10_out),                                     
 			    .Result11_out(MulD11_out),                                     
 			    .Result12_out(MulD12_out),                                     
 			    .Result13_out(MulD13_out),                                     
 			    .Result14_out(MulD14_out),                                     
 			    .Result15_out(MulD15_out),                                     
 			    .NTTD0_in(RA0D_in_wire),                                     
                .NTTD1_in(RA1D_in_wire),                                     
                .NTTD2_in(RA2D_in_wire),                                     
                .NTTD3_in(RA3D_in_wire),                                     
 				.NTTD4_in(RA4D_in_wire),                                     
 			    .NTTD5_in(RA5D_in_wire),                                     
 			    .NTTD6_in(RA6D_in_wire),                                     
 			    .NTTD7_in(RA7D_in_wire),                                     
 			    .NTTD8_in(RA8D_in_wire),                                     
 			    .NTTD9_in(RA9D_in_wire),                                     
 			    .NTTD10_in(RA10D_in_wire),                                   
 			    .NTTD11_in(RA11D_in_wire),                                   
 			    .NTTD12_in(RA12D_in_wire),                                   
 			    .NTTD13_in(RA13D_in_wire),                                   
 			    .NTTD14_in(RA14D_in_wire),                                   
 			    .NTTD15_in(RA15D_in_wire)                                        
 			    ) ;                                                           
                                                                                       
 	//---FFT1----------------------------------------------                   
 	//Bank0 Mem0                                                              
  SRAM_SP_512_128 u0_SRAM_SP_512_128 (.Q(Data_out0),
                                        .CLK(clk),                       
                                        .CEN(cen_wire),                  
                                        .WEN(wen0_wire),                 
                                        .A(MA0_wire),                    
                                        .D(BN0_MEM0_wire),               
                                        .EMA(3'd0)                   
                                        );                               
 	//Bank0 Mem1                                                              
  SRAM_SP_512_128 u1_SRAM_SP_512_128 (.Q(Data_out1),
                                        .CLK(clk),                       
                                        .CEN(cen_wire),                  
                                        .WEN(wen0_wire),                 
                                        .A(MA0_wire),                    
                                        .D(BN0_MEM1_wire),               
                                        .EMA(3'd0)                   
                                        );							      
 	//Bank0 Mem2                                                              
  SRAM_SP_512_128 u2_SRAM_SP_512_128 (.Q(Data_out2),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM2_wire),               
                                           .EMA(3'd0)                   
                                           );                               
 	//Bank0 Mem3                                                              
  SRAM_SP_512_128 u3_SRAM_SP_512_128 (.Q(Data_out3),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM3_wire),               
                                           .EMA(3'd0)                   
                                           );                               
 	//Bank0 Mem4                                                              
  SRAM_SP_512_128 u4_SRAM_SP_512_128 (.Q(Data_out4),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM4_wire),               
                                           .EMA(3'd0)                   
                                           );							      
 	//Bank0 Mem5                                                              
  SRAM_SP_512_128 u5_SRAM_SP_512_128 (.Q(Data_out5),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM5_wire),               
                                           .EMA(3'd0)                   
                                           );                               
 	//Bank0 Mem6                                                              
  SRAM_SP_512_128 u6_SRAM_SP_512_128 (.Q(Data_out6),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM6_wire),               
                                           .EMA(3'd0)                   
                                           );                               
 	//Bank0 Mem7                                                              
  SRAM_SP_512_128 u7_SRAM_SP_512_128 (.Q(Data_out7),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen0_wire),                 
                                           .A(MA0_wire),                    
                                           .D(BN0_MEM7_wire),               
                                           .EMA(3'd0)                   
                                           );                               
 			                                                                  
 			                                                                  
 	//Bank1 Mem0                                                              
  SRAM_SP_512_128 u8_SRAM_SP_512_128 (.Q(Data_out8),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen1_wire),                 
                                           .A(MA1_wire),                    
                                           .D(BN1_MEM0_wire),               
                                           .EMA(3'd0)                   
                                           );							      
 	//Bank0 Mem1                                                              
  SRAM_SP_512_128 u9_SRAM_SP_512_128 (.Q(Data_out9),
                                           .CLK(clk),                       
                                           .CEN(cen_wire),                  
                                           .WEN(wen1_wire),                 
                                           .A(MA1_wire),                    
                                           .D(BN1_MEM1_wire),               
                                           .EMA(3'd0)                   
                                           );	                              
 	//Bank1 Mem2                                                              
  SRAM_SP_512_128 u10_SRAM_SP_512_128 (.Q(Data_out10),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM2_wire),              
                                            .EMA(3'd0)                  
                                            );		                      
 	//Bank1 Mem3                                                              
  SRAM_SP_512_128 u11_SRAM_SP_512_128 (.Q(Data_out11),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM3_wire),              
                                            .EMA(3'd0)                  
                                            );		                      
 	//Bank1 Mem4                                                              
  SRAM_SP_512_128 u12_SRAM_SP_512_128 (.Q(Data_out12),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM4_wire),              
                                            .EMA(3'd0)                  
                                            );	                          
 	//Bank1 Mem5                                                              
  SRAM_SP_512_128 u13_SRAM_SP_512_128 (.Q(Data_out13),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM5_wire),              
                                            .EMA(3'd0)                  
                                            );	                          
 	//Bank1 Mem6                                                              
  SRAM_SP_512_128 u14_SRAM_SP_512_128 (.Q(Data_out14),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM6_wire),              
                                            .EMA(3'd0)                  
                                            );		                      
 	//Bank1 Mem7                                                              
  SRAM_SP_512_128 u15_SRAM_SP_512_128 (.Q(Data_out15),
                                            .CLK(clk),                      
                                            .CEN(cen_wire),                 
                                            .WEN(wen1_wire),                
                                            .A(MA1_wire),                   
                                            .D(BN1_MEM7_wire),              
                                            .EMA(3'd0)                  
                                            );						      
                                                         												
    //----------------siang record---------------------------
    //  Pipelien Register output for const
    wire [P_WIDTH-1:0]  siang_ROMD0_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD1_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD2_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD3_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD4_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD5_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD6_const_out_D_wire    ;
    wire [SD_WIDTH-1:0] siang_ROMD7_const_out_D_wire    ;
    // for Pipeline Register output
    wire [P_WIDTH-1:0]    siang_ROMD0_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD1_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD2_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD3_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD4_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD5_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD6_D_wire ;                                       
    wire [SD_WIDTH-1:0]   siang_ROMD7_D_wire ; 
    //  Pipelien Register output
    wire [P_WIDTH-1:0]   siang_ROMD0_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD1_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD2_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD3_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD4_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD5_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD6_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD7_out_wire ;
    // ROM const output
    wire [P_WIDTH-1:0]   siang_ROMD0_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD1_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD2_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD3_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD4_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD5_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD6_const_out_wire ;                                      
    wire [SD_WIDTH-1:0]  siang_ROMD7_const_out_wire ;
    // ROM Q_group_tf_fly
    wire [P_WIDTH-1:0]  horizontal_tf0_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf1_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf2_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf3_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf4_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf5_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf6_wire    ;
    wire [SD_WIDTH-1:0] horizontal_tf7_wire    ;


    //  Mux3 output
    wire [P_WIDTH-1:0]   siang_MulB0_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB1_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB2_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB3_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB4_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB5_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB6_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB7_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB8_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB9_wire ;                                          
    wire [P_WIDTH-1:0]   siang_MulB10_wire ;                                         
    wire [P_WIDTH-1:0]   siang_MulB11_wire ;                                         
    wire [P_WIDTH-1:0]   siang_MulB12_wire ;                                         
    wire [P_WIDTH-1:0]   siang_MulB13_wire ;                                         
    wire [P_WIDTH-1:0]   siang_MulB14_wire ;                                         
    wire [P_WIDTH-1:0]   siang_MulB15_wire ; 

    // Mux3 const output
    wire [P_WIDTH-1:0]  siang_MulB0_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB1_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB2_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB3_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB4_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB5_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB6_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB7_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB8_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB9_const_wire  ;
    wire [P_WIDTH-1:0]  siang_MulB10_const_wire ;
    wire [P_WIDTH-1:0]  siang_MulB11_const_wire ;
    wire [P_WIDTH-1:0]  siang_MulB12_const_wire ;
    wire [P_WIDTH-1:0]  siang_MulB13_const_wire ;
    wire [P_WIDTH-1:0]  siang_MulB14_const_wire ;
    wire [P_WIDTH-1:0]  siang_MulB15_const_wire ;

    // MulMod output
    wire [P_WIDTH-1:0]   siang_MulB0_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB1_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB2_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB3_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB4_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB5_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB6_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB7_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB8_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB9_wire_fly;                                    
    wire [P_WIDTH-1:0]   siang_MulB10_wire_fly ;                                   
    wire [P_WIDTH-1:0]   siang_MulB11_wire_fly ;                                   
    wire [P_WIDTH-1:0]   siang_MulB12_wire_fly ;                                   
    wire [P_WIDTH-1:0]   siang_MulB13_wire_fly ;                                   
    wire [P_WIDTH-1:0]   siang_MulB14_wire_fly ;                                   
    wire [P_WIDTH-1:0]   siang_MulB15_wire_fly ; 
    


    wire [SC_WIDTH-1:0] stage_delay_out;

    TW_ROM0_1024_64 u_TW_ROM0_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD0_out_wire),
        .Q_const(siang_ROMD0_const_out_wire),
        .Q_group_tf_fly(horizontal_tf0_wire)
    );

    TW_ROM1_1024_64 u_TW_ROM1_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD1_out_wire),
        .Q_const(siang_ROMD1_const_out_wire),
        .Q_group_tf_fly(horizontal_tf1_wire)
    );

    TW_ROM2_1024_64 u_TW_ROM2_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD2_out_wire),
        .Q_const(siang_ROMD2_const_out_wire),
        .Q_group_tf_fly(horizontal_tf2_wire)
    );

    TW_ROM3_1024_64 u_TW_ROM3_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD3_out_wire),
        .Q_const(siang_ROMD3_const_out_wire),
        .Q_group_tf_fly(horizontal_tf3_wire)
    );

    TW_ROM4_1024_64 u_TW_ROM4_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD4_out_wire),
        .Q_const(siang_ROMD4_const_out_wire),
        .Q_group_tf_fly(horizontal_tf4_wire)
    );

    TW_ROM5_1024_64 u_TW_ROM5_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD5_out_wire),
        .Q_const(siang_ROMD5_const_out_wire),
        .Q_group_tf_fly(horizontal_tf5_wire)
    );

    TW_ROM6_1024_64 u_TW_ROM6_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD6_out_wire),
        .Q_const(siang_ROMD6_const_out_wire),
        .Q_group_tf_fly(horizontal_tf6_wire)
    );

    TW_ROM7_1024_64 u_TW_ROM7_1024_64 (
        //input
        .stage_counter(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .rst_n(rst_n),
        .CLK(clk),
        .CEN(RomCen_wire),
        .state(state),
        //output
        .Q(siang_ROMD7_out_wire),
        .Q_const(siang_ROMD7_const_out_wire),
        .Q_group_tf_fly(horizontal_tf7_wire)
    );

    stage_delay siang_stage_delay(
        .clk(clk),
        .rst_n(rst_n),
        .state(state),
        .stage(data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .stage_delay_out(stage_delay_out)
    );

    
    //                                                                        
 	MulMod128_on_the_fly siang_u0_on_the_fly(
                                .S_out(siang_MulB0_wire_fly),                          
                                .const_in(siang_MulB0_const_wire),    //const                          
 		                        .B_in(siang_MulB0_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ; 
    //                                                                        
 	MulMod128_on_the_fly siang_u1_on_the_fly(
                                .S_out(siang_MulB1_wire_fly),                          
                                .const_in(siang_MulB1_const_wire),    //const                          
 		                        .B_in(siang_MulB1_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u2_on_the_fly(
                                .S_out(siang_MulB2_wire_fly),                          
                                .const_in(siang_MulB2_const_wire),    //const                          
 		                        .B_in(siang_MulB2_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;     
    //                                                                        
 	MulMod128_on_the_fly siang_u3_on_the_fly(
                                .S_out(siang_MulB3_wire_fly),                          
                                .const_in(siang_MulB3_const_wire),    //const                          
 		                        .B_in(siang_MulB3_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u4_on_the_fly(
                                .S_out(siang_MulB4_wire_fly),                          
                                .const_in(siang_MulB4_const_wire),    //const                          
 		                        .B_in(siang_MulB4_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u5_on_the_fly(
                                .S_out(siang_MulB5_wire_fly),                          
                                .const_in(siang_MulB5_const_wire),    //const                          
 		                        .B_in(siang_MulB5_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u6_on_the_fly(
                                .S_out(siang_MulB6_wire_fly),                          
                                .const_in(siang_MulB6_const_wire),    //const                          
 		                        .B_in(siang_MulB6_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u7_on_the_fly(
                                .S_out(siang_MulB7_wire_fly),                          
                                .const_in(siang_MulB7_const_wire),    //const                          
 		                        .B_in(siang_MulB7_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u8_on_the_fly(
                                .S_out(siang_MulB8_wire_fly),                          
                                .const_in(siang_MulB8_const_wire),    //const                          
 		                        .B_in(siang_MulB8_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u9_on_the_fly(
                                .S_out(siang_MulB9_wire_fly),                          
                                .const_in(siang_MulB9_const_wire),    //const                          
 		                        .B_in(siang_MulB9_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u10_on_the_fly(
                                .S_out(siang_MulB10_wire_fly),                          
                                .const_in(siang_MulB10_const_wire),    //const                          
 		                        .B_in(siang_MulB10_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u11_on_the_fly(
                                .S_out(siang_MulB11_wire_fly),                          
                                .const_in(siang_MulB11_const_wire),    //const                          
 		                        .B_in(siang_MulB11_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u12_on_the_fly(
                                .S_out(siang_MulB12_wire_fly),                          
                                .const_in(siang_MulB12_const_wire),    //const                          
 		                        .B_in(siang_MulB12_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u13_on_the_fly(
                                .S_out(siang_MulB13_wire_fly),                          
                                .const_in(siang_MulB13_const_wire),    //const                          
 		                        .B_in(siang_MulB13_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u14_on_the_fly(
                                .S_out(siang_MulB14_wire_fly),                          
                                .const_in(siang_MulB14_const_wire),    //const                          
 		                        .B_in(siang_MulB14_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    //                                                                        
 	MulMod128_on_the_fly siang_u15_on_the_fly(
                                .S_out(siang_MulB15_wire_fly),                          
                                .const_in(siang_MulB15_const_wire),    //const                          
 		                        .B_in(siang_MulB15_wire),                                 
 		                        .N_in(N_D4_wire),                                  
 						        .rst_n(rst_n),                                     
                                .clk(clk),    
                                .Mul_sel(Mul_sel_D_wire),    
                                .stage_counter(stage_delay_out),
                                .state(state)                  
    ) ;  
    
    //Pipeline Register for ROM
    R16_ROMPipe_const siang_R16_ROMPipe_const(
        //output 
        .ROM0_const_out(siang_ROMD0_const_out_D_wire),
        .ROM1_const_out(siang_ROMD1_const_out_D_wire),
        .ROM2_const_out(siang_ROMD2_const_out_D_wire),
        .ROM3_const_out(siang_ROMD3_const_out_D_wire),
        .ROM4_const_out(siang_ROMD4_const_out_D_wire),
        .ROM5_const_out(siang_ROMD5_const_out_D_wire),
        .ROM6_const_out(siang_ROMD6_const_out_D_wire),
        .ROM7_const_out(siang_ROMD7_const_out_D_wire),

        //input
        .ROM0_const_in(siang_ROMD0_const_out_wire),
        .ROM1_const_in(siang_ROMD1_const_out_wire),
        .ROM2_const_in(siang_ROMD2_const_out_wire),
        .ROM3_const_in(siang_ROMD3_const_out_wire),
        .ROM4_const_in(siang_ROMD4_const_out_wire),
        .ROM5_const_in(siang_ROMD5_const_out_wire),
        .ROM6_const_in(siang_ROMD6_const_out_wire),
        .ROM7_const_in(siang_ROMD7_const_out_wire),
        .rst_n(rst_n),
        .clk(clk)
    );

    //Pipeline Register				                                          
 	R16_ROMPipeReg1 siang_u_R16_ROMPipeReg1(
                                      .ROMD0_Dout(siang_ROMD0_D_wire),              
 				                      .ROMD1_Dout(siang_ROMD1_D_wire),              
 				                      .ROMD2_Dout(siang_ROMD2_D_wire),              
 				                      .ROMD3_Dout(siang_ROMD3_D_wire),              
 					                  .ROMD4_Dout(siang_ROMD4_D_wire),              
 					                  .ROMD5_Dout(siang_ROMD5_D_wire),              
 					                  .ROMD6_Dout(siang_ROMD6_D_wire),              
 					                  .ROMD7_Dout(siang_ROMD7_D_wire),                   
 			                          .ROMD0_in(siang_ROMD0_out_wire),              
 					                  .ROMD1_in(siang_ROMD1_out_wire),              
 					                  .ROMD2_in(siang_ROMD2_out_wire),              
 					                  .ROMD3_in(siang_ROMD3_out_wire),              
 					                  .ROMD4_in(siang_ROMD4_out_wire),              
 					                  .ROMD5_in(siang_ROMD5_out_wire),              
 					                  .ROMD6_in(siang_ROMD6_out_wire),              
 					                  .ROMD7_in(siang_ROMD7_out_wire),                   
                                      .rst_n(rst_n),                       
                                      .clk(clk)                            
                                       ) ;
    

    // for Mul const
    Mux3_const siang_Mux3_const(
        //output
        .MulB0_out_const_64(siang_MulB0_const_wire),
        .MulB1_out_const_64(siang_MulB1_const_wire),
        .MulB2_out_const_64(siang_MulB2_const_wire),
        .MulB3_out_const_64(siang_MulB3_const_wire),
        .MulB4_out_const_64(siang_MulB4_const_wire),
        .MulB5_out_const_64(siang_MulB5_const_wire),
        .MulB6_out_const_64(siang_MulB6_const_wire),
        .MulB7_out_const_64(siang_MulB7_const_wire),
        .MulB8_out_const_64(siang_MulB8_const_wire),
        .MulB9_out_const_64(siang_MulB9_const_wire),
        .MulB10_out_const_64(siang_MulB10_const_wire),
        .MulB11_out_const_64(siang_MulB11_const_wire),
        .MulB12_out_const_64(siang_MulB12_const_wire),
        .MulB13_out_const_64(siang_MulB13_const_wire),
        .MulB14_out_const_64(siang_MulB14_const_wire),
        .MulB15_out_const_64(siang_MulB15_const_wire),
        //input
        .ROMD0_in_const128(siang_ROMD0_const_out_D_wire),
        .ROMD1_in_const128(siang_ROMD1_const_out_D_wire),
        .ROMD2_in_const128(siang_ROMD2_const_out_D_wire),
        .ROMD3_in_const128(siang_ROMD3_const_out_D_wire),
        .ROMD4_in_const128(siang_ROMD4_const_out_D_wire),
        .ROMD5_in_const128(siang_ROMD5_const_out_D_wire),
        .ROMD6_in_const128(siang_ROMD6_const_out_D_wire),
        .ROMD7_in_const128(siang_ROMD7_const_out_D_wire),

        .Mul_sel(Mul_sel_D_wire)
    );

    
    //for Mul                                                                 
 	Mux3 siang_u_Mux3(
                .MulB0_out(siang_MulB0_wire),                                       
 			    .MulB1_out(siang_MulB1_wire),                                       
 			    .MulB2_out(siang_MulB2_wire),                                       
 			    .MulB3_out(siang_MulB3_wire),                                       
 				.MulB4_out(siang_MulB4_wire),                                       
 			    .MulB5_out(siang_MulB5_wire),                                       
 			    .MulB6_out(siang_MulB6_wire),                                       
 			    .MulB7_out(siang_MulB7_wire),                                       
 			    .MulB8_out(siang_MulB8_wire),                                       
 			    .MulB9_out(siang_MulB9_wire),                                       
 			    .MulB10_out(siang_MulB10_wire),                                     
 			    .MulB11_out(siang_MulB11_wire),                                     
 			    .MulB12_out(siang_MulB12_wire),                                     
 			    .MulB13_out(siang_MulB13_wire),                                     
 			    .MulB14_out(siang_MulB14_wire),                                     
 			    .MulB15_out(siang_MulB15_wire),                                     
 				.MulA1_out(MulA1_wire),                                       
 				.MulA2_out(MulA2_wire),                                       
 				.MulA3_out(MulA3_wire),                                       
 				.MulA4_out(MulA4_wire),                                       
 			    .MulA5_out(MulA5_wire),                                       
 			    .MulA6_out(MulA6_wire),                                       
 			    .MulA7_out(MulA7_wire),                                       
 			    .MulA9_out(MulA9_wire),                                       
 			    .MulA10_out(MulA10_wire),                                     
 			    .MulA11_out(MulA11_wire),                                     
 			    .MulA12_out(MulA12_wire),                                     
 			    .MulA13_out(MulA13_wire),                                     
 			    .MulA14_out(MulA14_wire),                                     
 			    .MulA15_out(MulA15_wire),                                                        
                .ROMD0_in(siang_ROMD0_D_wire),                                      
 			    .ROMD1_in(siang_ROMD1_D_wire),                                      
 				.ROMD2_in(siang_ROMD2_D_wire),                                      
 				.ROMD3_in(siang_ROMD3_D_wire),                                      
 			    .ROMD4_in(siang_ROMD4_D_wire),                                      
 			    .ROMD5_in(siang_ROMD5_D_wire),                                      
 			    .ROMD6_in(siang_ROMD6_D_wire),                                      
 			    .ROMD7_in(siang_ROMD7_D_wire),                                                    
 				.RA1D_in(RA1D_out_wire),                                      
 				.RA2D_in(RA2D_out_wire),                                      
 				.RA3D_in(RA3D_out_wire),                                      
 				.RA4D_in(RA4D_out_wire),                                      
 			    .RA5D_in(RA5D_out_wire),                                      
 			    .RA6D_in(RA6D_out_wire),                                      
 			    .RA7D_in(RA7D_out_wire),                                      
 			    .RA9D_in(RA9D_out_wire),                                      
 			    .RA10D_in(RA10D_out_wire),                                    
 			    .RA11D_in(RA11D_out_wire),                                    
 			    .RA12D_in(RA12D_out_wire),                                    
 			    .RA13D_in(RA13D_out_wire),                                    
 			    .RA14D_in(RA14D_out_wire),                                    
 			    .RA15D_in(RA15D_out_wire),                                    
 			    .Mul_sel(Mul_sel_D_wire)                                                                
 			    ) ;
    
    
    //                                                                        
 	MulMod128 u0_MulMod128(.S_out(MulMod0_out_wire),                          
                         .A_in(RA0D_out_wire),                              
 		                   .B_in(siang_MulB0_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u1_MulMod128(.S_out(MulMod1_out_wire),                          
                         .A_in(MulA1_wire),                                 
 		                   .B_in(siang_MulB1_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u2_MulMod128(.S_out(MulMod2_out_wire),                          
                         .A_in(MulA2_wire),                                 
 		                   .B_in(siang_MulB2_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u3_MulMod128(.S_out(MulMod3_out_wire),                          
                         .A_in(MulA3_wire),                                 
 		                   .B_in(siang_MulB3_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u4_MulMod128(.S_out(MulMod4_out_wire),                          
                         .A_in(MulA4_wire),                                 
 		                   .B_in(siang_MulB4_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u5_MulMod128(.S_out(MulMod5_out_wire),                          
                         .A_in(MulA5_wire),                                 
 		                   .B_in(siang_MulB5_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                         .clk(clk)                                          
                         ) ;                                                
 	//                                                                        
 	MulMod128 u6_MulMod128(.S_out(MulMod6_out_wire),                          
                            .A_in(MulA6_wire),                              
 		                   .B_in(siang_MulB6_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                            .clk(clk)                                       
                            ) ;                                             
 	//                                                                        
 	MulMod128 u7_MulMod128(.S_out(MulMod7_out_wire),                          
                            .A_in(MulA7_wire),                              
 		                   .B_in(siang_MulB7_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                            .clk(clk)                                       
                            ) ;                                             
 	//                                                                        
 	MulMod128 u8_MulMod128(.S_out(MulMod8_out_wire),                          
                            .A_in(RA8D_out_wire),                           
 		                   .B_in(siang_MulB8_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                            .clk(clk)                                       
                            ) ;                                             
 	//                                                                        
 	MulMod128 u9_MulMod128(.S_out(MulMod9_out_wire),                          
                            .A_in(MulA9_wire),                              
 		                   .B_in(siang_MulB9_wire_fly),                                 
 		                   .N_in(N_D4_wire),                                  
 						   .rst_n(rst_n),                                     
                            .clk(clk)                                       
                            ) ;                                             
 	//                                                                        
 	MulMod128 u10_MulMod128(.S_out(MulMod10_out_wire),                        
                             .A_in(MulA10_wire),                            
 		                    .B_in(siang_MulB10_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;                                            
 	//                                                                        
 	MulMod128 u11_MulMod128(.S_out(MulMod11_out_wire),                        
                             .A_in(MulA11_wire),                            
 		                    .B_in(siang_MulB11_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;                                            
 	//                                                                        
 	MulMod128 u12_MulMod128(.S_out(MulMod12_out_wire),                        
                             .A_in(MulA12_wire),                            
 		                    .B_in(siang_MulB12_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;                                            
 	//                                                                        
 	MulMod128 u13_MulMod128(.S_out(MulMod13_out_wire),                        
                             .A_in(MulA13_wire),                            
 		                    .B_in(siang_MulB13_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;                                            
 	//                                                                        
 	MulMod128 u14_MulMod128(.S_out(MulMod14_out_wire),                        
                             .A_in(MulA14_wire),                            
 		                    .B_in(siang_MulB14_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;                                            
 	//                                                                        
 	MulMod128 u15_MulMod128(.S_out(MulMod15_out_wire),                        
                             .A_in(MulA15_wire),                            
 		                    .B_in(siang_MulB15_wire_fly),                               
 		                    .N_in(N_D4_wire),                                 
 							.rst_n(rst_n),                                    
                             .clk(clk)                                      
                             ) ;
    
    //-------------------------------------------------------	



    //------------group tf fly---------------------------
    wire [P_WIDTH-1:0] horizontal_tf_out;

    horizontal_top horizontal_top(
        .S_out  (horizontal_tf_out),

        .horizontal_ROM0_in    (horizontal_tf0_wire),
        .horizontal_ROM1_in    (horizontal_tf1_wire),
        .horizontal_ROM2_in    (horizontal_tf2_wire),
        .horizontal_ROM3_in    (horizontal_tf3_wire),
        .horizontal_ROM4_in    (horizontal_tf4_wire),
        .horizontal_ROM5_in    (horizontal_tf5_wire),
        .horizontal_ROM6_in    (horizontal_tf6_wire),
        .horizontal_ROM7_in    (horizontal_tf7_wire),
        .rst_n          (rst_n),
        .clk            (clk),
        .state          (state),
        .stage_counter  (data_cnt_wire[DC_WIDTH-1:DCNT_BP4]),
        .CEN            (RomCen_wire),
        .N_in           (N_D4_wire)

    );
    //---------------------------------------------------							                                          
 endmodule                                                                  
