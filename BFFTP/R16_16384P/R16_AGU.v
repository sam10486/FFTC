 `timescale 1 ns/1 ps                                
 module R16_AGU(BN_out,                              
                MA,                                  
                ROMA,                                
                Mul_sel_out,
                BU_mode_sel_out,
                DC_mode_sel_out,//for raidx-4 delay commutator 				
                RDC_sel_out,                         
                data_cnt_reg,                        
                rc_sel_in,                           
                AGU_en,                              
                wrfd_en_in,                          
                rst_n,                               
                clk                          
                ) ;                                  
 parameter A_WIDTH     = 9;
 parameter DC_WIDTH    = 13;
 parameter BC_WIDTH    = 10;
 parameter SC_WIDTH    = 3;
 parameter ROMA_WIDTH  = 10;
 
 parameter DC_ZERO   = 13'h0 ;
 parameter ROMA_ZERO = 10'h0 ;
 
parameter S0      = 3'd0; 
parameter S1      = 3'd1; 
parameter S2      = 3'd2; 
parameter S3      = 3'd3;

  parameter DCNT_V1  = 13'd4143; //data counter value1 for data_cnt_wire      
  parameter DCNT_V2  = 13'd1025; //data counter value2 for data_cnt_wire      

 
 parameter DCNT_BP1 = 3 ;
 parameter DCNT_BP2 = 4 ;
 parameter DCNT_BP3 = 9 ;
 parameter DCNT_BP4 = 10 ;


 output                  BN_out ;                                    
 output [A_WIDTH-1:0]    MA ;                                        
 output [ROMA_WIDTH-1:0] ROMA ;       
 output                  BU_mode_sel_out;
 output                  DC_mode_sel_out; 
 output                  Mul_sel_out ;                               
 output [3:0]            RDC_sel_out ;                               
 output [DC_WIDTH-1:0]   data_cnt_reg ;                              
                          
                           
 input                   rc_sel_in ;                                 
 input                   AGU_en ;                                    
 input                   wrfd_en_in ;                                
 input                   rst_n ;                                     
 input                   clk ;                                       
                                                                     
                                                                                                 
 reg   [DC_WIDTH-1:0] data_cnt_reg ; // data counter                 
 reg   [3:0]          RDCsel_cnt_reg ; // RDC select counter         
 reg                  BN_out ;                                       
 reg   [3:0]          RDC_sel_out ; 
 reg                  BU_mode_sel_out;
 reg                  DC_mode_sel_out; 
 reg                  Mul_sel_out ;                                  
                                                                     
                                                                                                
 wire  [DC_WIDTH-1:0] data_cnt_wire ;                                
 wire  [3:0]          RDCsel_cnt_wire ;                              
 wire  [BC_WIDTH-1:0] BC_wire ; // butterfly counter                 
 wire                 xor_d0_wire;
 wire                 xor_d1_wire;
 wire                 xor_d2_wire;
 wire                 xor_d3_wire;
 wire                 xor_d4_wire;

 wire  [SC_WIDTH-1:0] SC_wire ; // stage counter 
 wire                 BN_wire ;                  
 wire [3:0]           RDC_sel_wire ;
 wire                 BU_mode_sel_wire;
 wire                 DC_mode_sel_wire; 
 wire                 Mul_sel_wire ;             
 
 wire  [BC_WIDTH-1:0] BC_RR_wire;
  
 	//                                                                                                          
   assign data_cnt_wire = (((AGU_en==1'b1)&&(data_cnt_reg==DCNT_V1))||                                         
                           ((rc_sel_in==1'b1)&&(AGU_en==1'b1)&&(data_cnt_reg==DCNT_V2)))?                      
                           DC_ZERO : (AGU_en==1'b1)?
                           (data_cnt_reg + 1'b1) : data_cnt_reg ;                                              
                                                                                                               
 	//                                                                                                          
   assign RDCsel_cnt_wire = (((AGU_en==1'b1)&&(data_cnt_reg==DCNT_V1))||                                       
                             ((rc_sel_in==1'b1)&&(AGU_en==1'b1)&&(data_cnt_reg==DCNT_V2)))?                     
                             4'd0 : ((AGU_en==1'b1)||(wrfd_en_in==1'b1))?
                             (RDCsel_cnt_reg + 1'b1) : RDCsel_cnt_reg ;                                         
 	                                                                                                            
 	// for Gray code 	 
   assign xor_d0_wire = data_cnt_reg[9]^data_cnt_reg[8];
   assign xor_d1_wire = data_cnt_reg[8]^data_cnt_reg[7];
   assign xor_d2_wire = data_cnt_reg[7]^data_cnt_reg[6];
   assign xor_d3_wire = data_cnt_reg[6]^data_cnt_reg[5];
   assign xor_d4_wire = data_cnt_reg[5]^data_cnt_reg[4];

   assign BC_wire = (rc_sel_in==1'b1)?   
                    ({data_cnt_reg[3:0],data_cnt_reg[9:4]}):       
                    ({data_cnt_reg[DCNT_BP1:0],                                         
                      data_cnt_reg[DCNT_BP3],                                           
                      xor_d0_wire,
                      xor_d1_wire,
                      xor_d2_wire,
                      xor_d3_wire,
                      xor_d4_wire
                       }) ;

   //                                                                                                                 
   assign SC_wire = data_cnt_reg[DC_WIDTH-1:DCNT_BP4] ;                                                               
   
   // Barrel shifter, rc_sel_in=1, right rotate 4-bit                                                                 
   assign BC_RR_wire = ( rc_sel_in == 1'b1 )? ({BC_wire[3:2],BC_wire[5:4],BC_wire[9:6],BC_wire[1:0]}):
                       ((SC_wire == S0) || (SC_wire == S3)) ? BC_wire:
                       (SC_wire == S1) ? ({BC_wire[3:0],BC_wire[BC_WIDTH-1:4]}) :
					   (SC_wire == S2) ? ({BC_wire[5:0],BC_wire[BC_WIDTH-1:6]}):BC_wire ;

   assign BN_wire = (^BC_RR_wire) ;
   // Address, rc_sel_in=1 MA=(BC_RR_wire[BC_WIDTH-1:1])                                                              
                        
   assign MA = (BC_RR_wire[9:1]) ;                                                                                                                   
   // ROM Address                                                                                                     
   assign ROMA = (SC_wire==S0) ? (BC_RR_wire) :                                                                        
                 (SC_wire==S1) ? ({BC_RR_wire[5:0],4'd0}):
				 (SC_wire==S2) ? ({BC_RR_wire[1:0],8'd0}): ROMA_ZERO;
   //                                                                                                                 
   assign Mul_sel_wire = (AGU_en==1'b1)? 1'd1 : 1'd0 ;     

   //Butterflyt unit mode select   
   assign BU_mode_sel_wire = ( SC_wire == S3) ? 1'd1 : 1'd0;
   //                                                                                                                 
   assign RDC_sel_wire = (wrfd_en_in==1'b1) ? RDCsel_cnt_reg : data_cnt_reg[3:0]  ;                                   
   
   //NTT radix-4 DC sel
   assign DC_mode_sel_wire = ( SC_wire == S2 ) ? 1'd1 : 1'd0;
   //                                                                                                                 
   always @(posedge clk or negedge rst_n) begin                                                                       
   	if(~rst_n) begin                                                                                               
           data_cnt_reg <= DC_ZERO ;
           BN_out <= 1'b0 ;
		       BU_mode_sel_out <= 1'b0;
		       DC_mode_sel_out <= 1'b0;
           RDC_sel_out <= 4'd0 ;
           Mul_sel_out <= 2'd0 ;                                                                            
           RDCsel_cnt_reg <= 4'd0 ;
   	end                                                                                                            
   	else begin                                                                                                     
           data_cnt_reg <= data_cnt_wire ;                                                                            
           BN_out <= BN_wire ;
		       BU_mode_sel_out <= BU_mode_sel_wire;
		       DC_mode_sel_out <= DC_mode_sel_wire;
           RDC_sel_out <= RDC_sel_wire ;                                                                              
           Mul_sel_out <= Mul_sel_wire ;                                                                                                                                                   
           RDCsel_cnt_reg <= RDCsel_cnt_wire ;                                                                        
   	end                                                                                                            
   end                                                                                                               
                                                                                                                      
 endmodule                                                                                                            
