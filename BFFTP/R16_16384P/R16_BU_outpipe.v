//=============================================
//Writer:Shi-Yong Wu                           
//                                             
//Note:R16 data output pipe                     
//=============================================
module R16_BU_outpipe(                             
  CRUD0_o,                                     
  CRUD1_o,                                     
  CRUD2_o,                                     
  CRUD3_o,                                     
  CRUD4_o,                                     
  CRUD5_o,                                     
  CRUD6_o,                                     
  CRUD7_o,                                     
  CRUD8_o,                                     
  CRUD9_o,                                     
  CRUD10_o,                                     
  CRUD11_o,                                     
  CRUD12_o,                                     
  CRUD13_o,                                     
  CRUD14_o,                                     
  CRUD15_o,                                     
  BR0_o,                                     
  BR1_o,                                     
  BR2_o,                                     
  BR3_o,                                     
  BR4_o,                                     
  BR5_o,                                     
  BR6_o,                                     
  BR7_o,                                     
  BR8_o,                                     
  BR9_o,                                     
  BR10_o,                                     
  BR11_o,                                     
  BR12_o,                                     
  BR13_o,                                     
  BR14_o,                                     
  BR15_o,                                     
  CRUD0_i,                                      
  CRUD1_i,                                      
  CRUD2_i,                                      
  CRUD3_i,                                      
  CRUD4_i,                                      
  CRUD5_i,                                      
  CRUD6_i,                                      
  CRUD7_i,                                      
  CRUD8_i,                                      
  CRUD9_i,                                      
  CRUD10_i,                                     
  CRUD11_i,                                     
  CRUD12_i,                                     
  CRUD13_i,                                     
  CRUD14_i,                                     
  CRUD15_i,                                     
  rst_n,                                        
  clk                                           
);                                              
                                                
  parameter P_WIDTH    = 64;
  parameter P_ZERO     = 64'd0;
  parameter BRD_WIDTH  = 20;                      
  parameter BRD_ZERO   = 20'd0;                   
                                                
  output [P_WIDTH-1:0] CRUD0_o;              
  output [P_WIDTH-1:0] CRUD1_o;              
  output [P_WIDTH-1:0] CRUD2_o;              
  output [P_WIDTH-1:0] CRUD3_o;              
  output [P_WIDTH-1:0] CRUD4_o;              
  output [P_WIDTH-1:0] CRUD5_o;              
  output [P_WIDTH-1:0] CRUD6_o;              
  output [P_WIDTH-1:0] CRUD7_o;              
  output [P_WIDTH-1:0] CRUD8_o;              
  output [P_WIDTH-1:0] CRUD9_o;              
  output [P_WIDTH-1:0] CRUD10_o;             
  output [P_WIDTH-1:0] CRUD11_o;             
  output [P_WIDTH-1:0] CRUD12_o;             
  output [P_WIDTH-1:0] CRUD13_o;             
  output [P_WIDTH-1:0] CRUD14_o;             
  output [P_WIDTH-1:0] CRUD15_o;             
  output [BRD_WIDTH-1:0] BR0_o;              
  output [BRD_WIDTH-1:0] BR1_o;              
  output [BRD_WIDTH-1:0] BR2_o;              
  output [BRD_WIDTH-1:0] BR3_o;              
  output [BRD_WIDTH-1:0] BR4_o;              
  output [BRD_WIDTH-1:0] BR5_o;              
  output [BRD_WIDTH-1:0] BR6_o;              
  output [BRD_WIDTH-1:0] BR7_o;              
  output [BRD_WIDTH-1:0] BR8_o;              
  output [BRD_WIDTH-1:0] BR9_o;              
  output [BRD_WIDTH-1:0] BR10_o;             
  output [BRD_WIDTH-1:0] BR11_o;             
  output [BRD_WIDTH-1:0] BR12_o;             
  output [BRD_WIDTH-1:0] BR13_o;             
  output [BRD_WIDTH-1:0] BR14_o;             
  output [BRD_WIDTH-1:0] BR15_o;             
                                                
  input  [P_WIDTH-1:0] CRUD0_i;              
  input  [P_WIDTH-1:0] CRUD1_i;              
  input  [P_WIDTH-1:0] CRUD2_i;              
  input  [P_WIDTH-1:0] CRUD3_i;              
  input  [P_WIDTH-1:0] CRUD4_i;              
  input  [P_WIDTH-1:0] CRUD5_i;              
  input  [P_WIDTH-1:0] CRUD6_i;              
  input  [P_WIDTH-1:0] CRUD7_i;              
  input  [P_WIDTH-1:0] CRUD8_i;              
  input  [P_WIDTH-1:0] CRUD9_i;              
  input  [P_WIDTH-1:0] CRUD10_i;             
  input  [P_WIDTH-1:0] CRUD11_i;             
  input  [P_WIDTH-1:0] CRUD12_i;             
  input  [P_WIDTH-1:0] CRUD13_i;             
  input  [P_WIDTH-1:0] CRUD14_i;             
  input  [P_WIDTH-1:0] CRUD15_i;             
  input  				  rst_n;                
  input 				  clk;                  
                                                
  reg[P_WIDTH-1:0] CRUD0_o;                  
  reg[P_WIDTH-1:0] CRUD1_o;                  
  reg[P_WIDTH-1:0] CRUD2_o;                  
  reg[P_WIDTH-1:0] CRUD3_o;                  
  reg[P_WIDTH-1:0] CRUD4_o;                  
  reg[P_WIDTH-1:0] CRUD5_o;                  
  reg[P_WIDTH-1:0] CRUD6_o;                  
  reg[P_WIDTH-1:0] CRUD7_o;                  
  reg[P_WIDTH-1:0] CRUD8_o;                  
  reg[P_WIDTH-1:0] CRUD9_o;                  
  reg[P_WIDTH-1:0] CRUD10_o;                 
  reg[P_WIDTH-1:0] CRUD11_o;                 
  reg[P_WIDTH-1:0] CRUD12_o;                 
  reg[P_WIDTH-1:0] CRUD13_o;                 
  reg[P_WIDTH-1:0] CRUD14_o;                 
  reg[P_WIDTH-1:0] CRUD15_o;                 
  reg[BRD_WIDTH-1:0] BR0_o;                  
  reg[BRD_WIDTH-1:0] BR1_o;                  
  reg[BRD_WIDTH-1:0] BR2_o;                  
  reg[BRD_WIDTH-1:0] BR3_o;                  
  reg[BRD_WIDTH-1:0] BR4_o;                  
  reg[BRD_WIDTH-1:0] BR5_o;                  
  reg[BRD_WIDTH-1:0] BR6_o;                  
  reg[BRD_WIDTH-1:0] BR7_o;                  
  reg[BRD_WIDTH-1:0] BR8_o;                  
  reg[BRD_WIDTH-1:0] BR9_o;                  
  reg[BRD_WIDTH-1:0] BR10_o;                 
  reg[BRD_WIDTH-1:0] BR11_o;                 
  reg[BRD_WIDTH-1:0] BR12_o;                 
  reg[BRD_WIDTH-1:0] BR13_o;                 
  reg[BRD_WIDTH-1:0] BR14_o;                 
  reg[BRD_WIDTH-1:0] BR15_o;                 
                                                
  always@(posedge clk,negedge rst_n)begin       
		if(~rst_n)begin                             
		    	CRUD0_o    <=  P_ZERO;               
		    	CRUD1_o    <=  P_ZERO;               
		    	CRUD2_o    <=  P_ZERO;               
		    	CRUD3_o    <=  P_ZERO;               
		    	CRUD4_o    <=  P_ZERO;               
		    	CRUD5_o    <=  P_ZERO;               
		    	CRUD6_o    <=  P_ZERO;               
		    	CRUD7_o    <=  P_ZERO;               
		    	CRUD8_o    <=  P_ZERO;               
		    	CRUD9_o    <=  P_ZERO;               
		    	CRUD10_o   <=  P_ZERO;               
		    	CRUD11_o   <=  P_ZERO;               
		    	CRUD12_o   <=  P_ZERO;               
		    	CRUD13_o   <=  P_ZERO;               
		    	CRUD14_o   <=  P_ZERO;               
		    	CRUD15_o   <=  P_ZERO;               
		    	BR0_o      <=  BRD_ZERO;               
		    	BR1_o      <=  BRD_ZERO;               
		    	BR2_o      <=  BRD_ZERO;               
		    	BR3_o      <=  BRD_ZERO;               
		    	BR4_o      <=  BRD_ZERO;               
		    	BR5_o      <=  BRD_ZERO;               
		    	BR6_o      <=  BRD_ZERO;               
		    	BR7_o      <=  BRD_ZERO;               
		    	BR8_o      <=  BRD_ZERO;               
		    	BR9_o      <=  BRD_ZERO;               
		    	BR10_o     <=  BRD_ZERO;               
		    	BR11_o     <=  BRD_ZERO;               
		    	BR12_o     <=  BRD_ZERO;               
		    	BR13_o     <=  BRD_ZERO;               
		    	BR14_o     <=  BRD_ZERO;               
		    	BR15_o     <=  BRD_ZERO;               
		end                                         
		else begin                                  
 	       CRUD0_o    <=  CRUD0_i;                 
 	       CRUD1_o    <=  CRUD1_i;                 
 	       CRUD2_o    <=  CRUD2_i;                 
 	       CRUD3_o    <=  CRUD3_i;                 
 	       CRUD4_o    <=  CRUD4_i;                 
 	       CRUD5_o    <=  CRUD5_i;                 
 	       CRUD6_o    <=  CRUD6_i;                 
 	       CRUD7_o    <=  CRUD7_i;                 
 	       CRUD8_o    <=  CRUD8_i;                 
 	       CRUD9_o    <=  CRUD9_i;                 
 	       CRUD10_o   <=  CRUD10_i;                
 	       CRUD11_o   <=  CRUD11_i;                
 	       CRUD12_o   <=  CRUD12_i;                
 	       CRUD13_o   <=  CRUD13_i;                
 	       CRUD14_o   <=  CRUD14_i;                
 	       CRUD15_o   <=  CRUD15_i;                
 	       BR0_o      <=  CRUD0_o[19:0];                 
 	       BR1_o      <=  CRUD1_o[19:0];                 
 	       BR2_o      <=  CRUD2_o[19:0];                 
 	       BR3_o      <=  CRUD3_o[19:0];                 
 	       BR4_o      <=  CRUD4_o[19:0];                 
 	       BR5_o      <=  CRUD5_o[19:0];                 
 	       BR6_o      <=  CRUD6_o[19:0];                 
 	       BR7_o      <=  CRUD7_o[19:0];                 
 	       BR8_o      <=  CRUD8_o[19:0];                 
 	       BR9_o      <=  CRUD9_o[19:0];                 
 	       BR10_o     <=  CRUD10_o[19:0];                
 	       BR11_o     <=  CRUD11_o[19:0];                
 	       BR12_o     <=  CRUD12_o[19:0];                
 	       BR13_o     <=  CRUD13_o[19:0];                
 	       BR14_o     <=  CRUD14_o[19:0];                
 	       BR15_o     <=  CRUD15_o[19:0];                
		end                                         
  end                                           
                                                
endmodule                                       
