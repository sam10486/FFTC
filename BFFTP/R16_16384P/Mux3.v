`timescale 1 ns/1 ps                                                                       
module Mux3(MulB0_out,                                                                     
			MulB1_out,                                                                     
			MulB2_out,                                                                     
			MulB3_out,                                                                     
			MulB4_out,                                                                     
			MulB5_out,                                                                     
			MulB6_out,                                                                     
			MulB7_out,                                                                     
			MulB8_out,                                                                     
			MulB9_out,                                                                     
			MulB10_out,                                                                    
			MulB11_out,                                                                    
			MulB12_out,                                                                    
			MulB13_out,                                                                    
			MulB14_out,                                                                    
			MulB15_out,                                                                    
			MulA1_out,                                                                     
			MulA2_out,                                                                     
			MulA3_out,                                                                     
			MulA4_out,                                                                     
			MulA5_out,                                                                     
			MulA6_out,                                                                     
			MulA7_out,                                                                     
			MulA9_out,                                                                     
			MulA10_out,                                                                    
			MulA11_out,                                                                    
			MulA12_out,                                                                    
			MulA13_out,                                                                    
			MulA14_out,                                                                    
			MulA15_out,                                                                                                                                    
            ROMD0_in,                                                                      
			ROMD1_in,                                                                      
			ROMD2_in,                                                                      
			ROMD3_in,                                                                      
			ROMD4_in,                                                                      
			ROMD5_in,                                                                      
			ROMD6_in,                                                                      
			ROMD7_in,                                                                                                                                         
			RA1D_in,                                                                       
			RA2D_in,                                                                       
			RA3D_in,                                                                       
			RA4D_in,                                                                       
			RA5D_in,                                                                       
			RA6D_in,                                                                       
			RA7D_in,                                                                       
			RA9D_in,                                                                       
			RA10D_in,                                                                      
			RA11D_in,                                                                      
			RA12D_in,                                                                      
			RA13D_in,                                                                      
			RA14D_in,                                                                      
			RA15D_in,                                                                      
			Mul_sel                                                                  
			  ) ;                                                                            
			                                                                                 
parameter P_WIDTH   = 64 ;                                                                 
parameter SD_WIDTH  = 128 ;                                                                
parameter SEG1  = 64 ;                                                                     
parameter SEG2  = 128 ;                                                                    
                                                                                           
parameter P_ONE   = 64'd1 ;                                                                
//parameter PINV    = 64'd18442240469788262401; // inverse N                                    
                                                                                           
output [P_WIDTH-1:0] MulB0_out ;                                                           
output [P_WIDTH-1:0] MulB1_out ;                                                           
output [P_WIDTH-1:0] MulB2_out ;                                                           
output [P_WIDTH-1:0] MulB3_out ;                                                           
output [P_WIDTH-1:0] MulB4_out ;                                                           
output [P_WIDTH-1:0] MulB5_out ;                                                           
output [P_WIDTH-1:0] MulB6_out ;                                                           
output [P_WIDTH-1:0] MulB7_out ;                                                           
output [P_WIDTH-1:0] MulB8_out ;                                                           
output [P_WIDTH-1:0] MulB9_out ;                                                           
output [P_WIDTH-1:0] MulB10_out ;                                                          
output [P_WIDTH-1:0] MulB11_out ;                                                          
output [P_WIDTH-1:0] MulB12_out ;                                                          
output [P_WIDTH-1:0] MulB13_out ;                                                          
output [P_WIDTH-1:0] MulB14_out ;                                                          
output [P_WIDTH-1:0] MulB15_out ;                                                          
                                                                                           
output [P_WIDTH-1:0] MulA1_out ;                                                           
output [P_WIDTH-1:0] MulA2_out ;                                                           
output [P_WIDTH-1:0] MulA3_out ;                                                           
output [P_WIDTH-1:0] MulA4_out ;                                                           
output [P_WIDTH-1:0] MulA5_out ;                                                           
output [P_WIDTH-1:0] MulA6_out ;                                                           
output [P_WIDTH-1:0] MulA7_out ;                                                           
output [P_WIDTH-1:0] MulA9_out ;                                                           
output [P_WIDTH-1:0] MulA10_out ;                                                          
output [P_WIDTH-1:0] MulA11_out ;                                                          
output [P_WIDTH-1:0] MulA12_out ;                                                          
output [P_WIDTH-1:0] MulA13_out ;                                                          
output [P_WIDTH-1:0] MulA14_out ;                                                          
output [P_WIDTH-1:0] MulA15_out ;                                                          
                                                                                                                                      
input [P_WIDTH-1:0]  ROMD0_in ;                                                            
input [SD_WIDTH-1:0] ROMD1_in ;                                                            
input [SD_WIDTH-1:0] ROMD2_in ;                                                            
input [SD_WIDTH-1:0] ROMD3_in ;                                                            
input [SD_WIDTH-1:0] ROMD4_in ;                                                            
input [SD_WIDTH-1:0] ROMD5_in ;                                                            
input [SD_WIDTH-1:0] ROMD6_in ;                                                            
input [SD_WIDTH-1:0] ROMD7_in ;                                                                                                                     
input [P_WIDTH-1:0]  RA1D_in ;                                                             
input [P_WIDTH-1:0]  RA2D_in ;                                                             
input [P_WIDTH-1:0]  RA3D_in ;                                                             
input [P_WIDTH-1:0]  RA4D_in ;                                                             
input [P_WIDTH-1:0]  RA5D_in ;                                                             
input [P_WIDTH-1:0]  RA6D_in ;                                                             
input [P_WIDTH-1:0]  RA7D_in ;                                                             
input [P_WIDTH-1:0]  RA9D_in ;                                                             
input [P_WIDTH-1:0]  RA10D_in ;                                                            
input [P_WIDTH-1:0]  RA11D_in ;                                                            
input [P_WIDTH-1:0]  RA12D_in ;                                                            
input [P_WIDTH-1:0]  RA13D_in ;                                                            
input [P_WIDTH-1:0]  RA14D_in ;                                                            
input [P_WIDTH-1:0]  RA15D_in ;                                                            
input                Mul_sel ;                                                             
                                                          
                                                                                           
                                                                                           
                                                                                           
	//                                                                                       
	assign MulB0_out = P_ONE ;                                       
	//                                                                                       
	assign MulB1_out  = (Mul_sel==1'd1) ? ROMD0_in : P_ONE ;                                       
	//                                                                                       
	assign MulB2_out  = (Mul_sel==1'd1) ? ROMD1_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                       
	assign MulB3_out  = (Mul_sel==1'd1) ? ROMD1_in[SEG1-1:0] : P_ONE ;				                         
	//                                                                                       
	assign MulB4_out  = (Mul_sel==1'd1) ? ROMD2_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                       
	assign MulB5_out  = (Mul_sel==1'd1) ? ROMD2_in[SEG1-1:0] : P_ONE ;	                                     
	//                                                                                       
	assign MulB6_out  = (Mul_sel==1'd1) ? ROMD3_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                       
	assign MulB7_out  = (Mul_sel==1'd1) ? ROMD3_in[SEG1-1:0] : P_ONE ;	                                     
	//                                                                                       
	assign MulB8_out  = (Mul_sel==1'd1) ? ROMD4_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                       
	assign MulB9_out  = (Mul_sel==1'd1) ? ROMD4_in[SEG1-1:0] : P_ONE ;	                                     
	//                                                                                      
	assign MulB10_out = (Mul_sel==1'd1) ? ROMD5_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                      
	assign MulB11_out = (Mul_sel==1'd1) ? ROMD5_in[SEG1-1:0] : P_ONE ;	                                     
	//                                                                                      
	assign MulB12_out = (Mul_sel==1'd1) ? ROMD6_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                      
	assign MulB13_out = (Mul_sel==1'd1) ? ROMD6_in[SEG1-1:0] : P_ONE ;	                                     
	//                                                                                      
	assign MulB14_out = (Mul_sel==1'd1) ? ROMD7_in[SEG2-1:SEG1] : P_ONE ;				                         
	//                                                                                      
	assign MulB15_out = (Mul_sel==1'd1) ? ROMD7_in[SEG1-1:0] : P_ONE ;	                                     
	                                                                                         
	                                                                                         
    // change RA output position in IFFT                                                   
	assign MulA1_out =   RA1D_in ;                                
	//                                                            
	assign MulA2_out =   RA2D_in ;                                
	//                                                            
	assign MulA3_out =   RA3D_in ;                                
	//                                                            
	assign MulA4_out =   RA4D_in ;                                
	//                                                            
	assign MulA5_out =   RA5D_in ;                                
	//                                                            
	assign MulA6_out =   RA6D_in ;                                
	//                                                            
	assign MulA7_out =   RA7D_in ;                                 
	//                                                            
	assign MulA9_out =   RA9D_in ;                                 
	//                                                            
	assign MulA10_out =  RA10D_in ;                               
	//                                                            
	assign MulA11_out =  RA11D_in ;                               
	//                                                            
	assign MulA12_out =  RA12D_in ;                               
	//                                                            
	assign MulA13_out =  RA13D_in ;                               
	//                                                            
	assign MulA14_out =  RA14D_in ;                               
	//                                                            
	assign MulA15_out =  RA15D_in ;                                                                                    
	                                                                                         
endmodule                                                                                  
