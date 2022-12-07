//==================================================                               
//Writer     : shiyong wu                                                          
//Date       : 2020/6/18                                                           
//Note       : ROM register file                                                   
//==================================================                               
`timescale 1 ns/1 ps                                                               
module R16_orderROM_Pipe(                                                           
                      reorderROM0_o,                                               
                      reorderROM1_o,                                               
                      reorderROM2_o,                                               
                      reorderROM3_o,                                               
                      ireorderROM0_o,                                              
                      ireorderROM1_o,                                              
                      ireorderROM2_o,                                              
                      ireorderROM3_o,                                              
						reorderROM0_i,                                               
						reorderROM1_i,                                               
						reorderROM2_i,                                               
						reorderROM3_i,                                               
						ireorderROM0_i,                                              
						ireorderROM1_i,                                              
						ireorderROM2_i,                                              
						ireorderROM3_i,                                              
						rst_n,                                                       
						clk                                                          
						) ;                                                          
    parameter SD_WIDTH  = 128;                                                     
	  parameter SD_ZERO   = 128'd0;                                                  
    parameter P_WIDTH   = 64;                                                      
	  parameter P_ZERO    = 64'd0;                                                   
                                                                                   
    output [SD_WIDTH-1:0] reorderROM0_o;                                            
    output [SD_WIDTH-1:0] reorderROM1_o;                                            
    output [SD_WIDTH-1:0] reorderROM2_o;                                            
    output [SD_WIDTH-1:0] reorderROM3_o;                                            
    output [SD_WIDTH-1:0] ireorderROM0_o;                                           
    output [SD_WIDTH-1:0] ireorderROM1_o;                                           
    output [SD_WIDTH-1:0] ireorderROM2_o;                                           
    output [P_WIDTH-1:0]  ireorderROM3_o;                                           
                                                                                   
	input [SD_WIDTH-1:0]  reorderROM0_i;                                              
	input [SD_WIDTH-1:0]  reorderROM1_i;                                              
	input [SD_WIDTH-1:0]  reorderROM2_i;                                              
	input [SD_WIDTH-1:0]  reorderROM3_i;                                              
	input [SD_WIDTH-1:0]  ireorderROM0_i;                                             
	input [SD_WIDTH-1:0]  ireorderROM1_i;                                             
	input [SD_WIDTH-1:0]  ireorderROM2_i;                                             
	input [P_WIDTH-1:0]   ireorderROM3_i;                                             
	input rst_n;                                                                     
	input clk;                                                                       
                                                                                   
                                                                                   
	  reg [SD_WIDTH-1:0] reorderROM0_o;                                               
    reg [SD_WIDTH-1:0] reorderROM1_o;                                               
    reg [SD_WIDTH-1:0] reorderROM2_o;                                               
    reg [SD_WIDTH-1:0] reorderROM3_o;                                               
    reg [SD_WIDTH-1:0] ireorderROM0_o;                                              
    reg [SD_WIDTH-1:0] ireorderROM1_o;                                              
    reg [SD_WIDTH-1:0] ireorderROM2_o;                                              
    reg [P_WIDTH-1:0] ireorderROM3_o;                                              
                                                                                   
    always@(posedge clk,negedge rst_n)begin                                        
		if(~rst_n)begin                                                              
			reorderROM0_o  <= SD_ZERO;                                                
			reorderROM1_o  <= SD_ZERO;                                                
			reorderROM2_o  <= SD_ZERO;                                                
			reorderROM3_o  <= SD_ZERO;                                                
			ireorderROM0_o <= SD_ZERO;                                                
			ireorderROM1_o <= SD_ZERO;                                                
			ireorderROM2_o <= SD_ZERO;                                                
			ireorderROM3_o <= P_ZERO;                                                
		end                                                                          
		else begin                                                                   
			reorderROM0_o  <= reorderROM0_i;                                         
		    reorderROM1_o  <= reorderROM1_i;                                         
		    reorderROM2_o  <= reorderROM2_i;                                         
		    reorderROM3_o  <= reorderROM3_i;                                         
		    ireorderROM0_o <= ireorderROM0_i;                                        
		    ireorderROM1_o <= ireorderROM1_i;                                        
		    ireorderROM2_o <= ireorderROM2_i;                                        
		    ireorderROM3_o <= ireorderROM3_i;                                        
		end                                                                          
	end                                                                              
                                                                                   
endmodule                                                                          
