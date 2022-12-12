 //==================================================                                                                         
 //Writer     : Shi-Yong Wu                                                                                                  
 //Date       : 2020/6/20                                                                                                      
 //Note       : testbench for Merged Bank FFT Processor                                                                       
 //==================================================                                                                         
                                                                                                                              
  `include "FFTP.v"      
  `include "CenCtrl.v"    
  `include "Mux1.v"    
  `include "Mux2.v"    
  `include "Mux3.v"    
  `include "R16_AGU.v"    
  `include "BU.v"    
  `include "BU_S0.v"    
  `include "Pipe.v"    
  `include "Radix16_Pipe.v"    
  `include "Ctrl_PipeReg1.v"    
  `include "R16_PipeReg2.v"    
  `include "R16_PipeReg4.v"    
  `include "R16_PipeReg4_2.v"    
  `include "R16_NPipeReg2.v"    
  `include "R16_NPipeReg3.v"    
  `include "R16_ROMPipeReg1.v"    
  `include "Mod192.v"    
  `include "Mod192PD.v"    
  `include "MulMod128.v"    
  `include "MulMod128PD.v"    
  `include "Mul64.v"    
  `include "ModMux.v"    
  `include "R16_DC.v"    
  `include "R16_WAddr.v"    
  `include "CLA4.v"  
  `include "CLA16.v"  
  `include "CLA16clg.v"  
  `include "CLA32.v"  
  `include "CLA32clg.v"  
  `include "CLA64_co.v"  
  `include "CLA64clg_co.v"  
  `include "CLA65.v"  
  `include "CLA65clg.v"  
  `include "Mux4.v"  
  `include "R16_WD_buf.v"  
  `include "SRAM_SP_512_128.v" 
                                    
  //-------------siang record-------------
  	`include "./siang_test_v/TW_ROM0_1024_64.v"
	`include "./siang_test_v/TW_ROM1_1024_64.v"
	`include "./siang_test_v/TW_ROM2_1024_64.v"
	`include "./siang_test_v/TW_ROM3_1024_64.v"
	`include "./siang_test_v/TW_ROM4_1024_64.v"
	`include "./siang_test_v/TW_ROM5_1024_64.v"
	`include "./siang_test_v/TW_ROM6_1024_64.v"
	`include "./siang_test_v/TW_ROM7_1024_64.v"
	`include "./siang_test_v/on_the_fly_pip.v"
	`include "./siang_test_v/MulMod128_on_the_fly.v"
	`include "./siang_test_v/stage_delay.v"
	`include "./siang_test_v/R16_ROMPipe_const.v"
	`include "./siang_test_v/Mux3_const.v"

	`include "./siang_test_v/horizontal_tf_fly.v"
	`include "./siang_test_v/horizontal_top.v"
	`include "./siang_test_v/horizontal_Mux3.v"
	`include "./siang_test_v/horizontal_fifo.v"
	`include "./siang_test_v/DifRom_tf_const.v"
  //-------------------------------------
                                                                                                                              
 `timescale 1 ns/1 ps                                                                                                         
                                                                                                                              
 module test_FFTP ;                                                                                                           
 parameter CYCLE = 5 ;                                                                                                       
 parameter P_WIDTH   = 64 ;  
 parameter test_data_index_over = 1024;                                                
 parameter POINT_NUM = 16384; // total number of point                                                                        
 parameter BF_POINT_NUM = 16 ; // butterfly number of point                                                                    
 parameter INI_VALUE = 1024; //(POINT_NUM/BF_POINT_NUM)      
 parameter ADDR_VALUE =512; //(POINT_NUM/(BF_POINT_NUM*2))  


 parameter golden_file = "./data/test_golden.txt";  
 parameter A_B0R0  = "./data/A_b0radix0.txt";  
 parameter A_B0R1  = "./data/A_b0radix1.txt";  
 parameter A_B0R2  = "./data/A_b0radix2.txt";  
 parameter A_B0R3  = "./data/A_b0radix3.txt";  
 parameter A_B0R4  = "./data/A_b0radix4.txt";  
 parameter A_B0R5  = "./data/A_b0radix5.txt";  
 parameter A_B0R6  = "./data/A_b0radix6.txt";  
 parameter A_B0R7  = "./data/A_b0radix7.txt";  
 parameter A_B0R8  = "./data/A_b0radix8.txt";  
 parameter A_B0R9  = "./data/A_b0radix9.txt";  
 parameter A_B0R10  = "./data/A_b0radix10.txt";  
 parameter A_B0R11  = "./data/A_b0radix11.txt";  
 parameter A_B0R12  = "./data/A_b0radix12.txt";  
 parameter A_B0R13  = "./data/A_b0radix13.txt";  
 parameter A_B0R14  = "./data/A_b0radix14.txt";  
 parameter A_B0R15  = "./data/A_b0radix15.txt"; 

 parameter A_B1R0  = "./data/A_b1radix0.txt";  
 parameter A_B1R1  = "./data/A_b1radix1.txt";  
 parameter A_B1R2  = "./data/A_b1radix2.txt";  
 parameter A_B1R3  = "./data/A_b1radix3.txt";  
 parameter A_B1R4  = "./data/A_b1radix4.txt";  
 parameter A_B1R5  = "./data/A_b1radix5.txt";  
 parameter A_B1R6  = "./data/A_b1radix6.txt";  
 parameter A_B1R7  = "./data/A_b1radix7.txt";  
 parameter A_B1R8  = "./data/A_b1radix8.txt";  
 parameter A_B1R9  = "./data/A_b1radix9.txt";  
 parameter A_B1R10  = "./data/A_b1radix10.txt";  
 parameter A_B1R11  = "./data/A_b1radix11.txt";  
 parameter A_B1R12  = "./data/A_b1radix12.txt";  
 parameter A_B1R13  = "./data/A_b1radix13.txt";  
 parameter A_B1R14  = "./data/A_b1radix14.txt";  
 parameter A_B1R15  = "./data/A_b1radix15.txt";  
 
 
 wire                MulValid_out ;                                                                                            
 wire [P_WIDTH-1:0] MulD0_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD1_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD2_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD3_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD4_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD5_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD6_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD7_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD8_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD9_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD10_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD11_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD12_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD13_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD14_out ;                                                                                              
 wire [P_WIDTH-1:0] MulD15_out ;                                                                                              
                                                                                                                              
 reg  [P_WIDTH-1:0] ExtB0_D0_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D1_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D2_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D3_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D4_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D5_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D6_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D7_in ;
 reg  [P_WIDTH-1:0] ExtB0_D8_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D9_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D10_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D11_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D12_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D13_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D14_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB0_D15_in ; 

 reg  [P_WIDTH-1:0] ExtB1_D0_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D1_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D2_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D3_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D4_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D5_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D6_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D7_in ;     
 reg  [P_WIDTH-1:0] ExtB1_D8_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D9_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D10_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D11_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D12_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D13_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D14_in ;                                                                                            
 reg  [P_WIDTH-1:0] ExtB1_D15_in ; 

 reg  [P_WIDTH-1:0] N_in ;                                                                                                    
 reg                ExtValid_in ;                                                                                             
 reg                rst_n ;                                                                                                   
 reg                clk ;                                                                                                     
                                                                                                                              
                                                                                                                              
 reg [P_WIDTH-1:0]  golden_mem[0:POINT_NUM-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R0_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R1_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R2_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R3_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R4_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R5_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R6_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R7_mem[0:ADDR_VALUE-1]; 
 reg [P_WIDTH-1:0]  Ext_B0R8_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R9_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R10_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R11_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R12_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R13_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R14_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B0R15_mem[0:ADDR_VALUE-1];

 reg [P_WIDTH-1:0]  Ext_B1R0_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R1_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R2_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R3_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R4_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R5_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R6_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R7_mem[0:ADDR_VALUE-1];  
 reg [P_WIDTH-1:0]  Ext_B1R8_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R9_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R10_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R11_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R12_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R13_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R14_mem[0:ADDR_VALUE-1];                                                                               
 reg [P_WIDTH-1:0]  Ext_B1R15_mem[0:ADDR_VALUE-1];                                                                               
                                                                                                                              
 integer            i, j ,k ,ef,error;                                                                                             
 integer            gd; // golden_data                                                                                        
                                                                                                                              
     //read file                                                                                                              
     initial begin 
     	   $readmemh(A_B0R0,Ext_B0R0_mem);
     	   $readmemh(A_B0R1,Ext_B0R1_mem);
     	   $readmemh(A_B0R2,Ext_B0R2_mem);
     	   $readmemh(A_B0R3,Ext_B0R3_mem);
     	   $readmemh(A_B0R4,Ext_B0R4_mem);
     	   $readmemh(A_B0R5,Ext_B0R5_mem);
     	   $readmemh(A_B0R6,Ext_B0R6_mem);
     	   $readmemh(A_B0R7,Ext_B0R7_mem);
		   $readmemh(A_B0R8,Ext_B0R8_mem);
     	   $readmemh(A_B0R9,Ext_B0R9_mem);
     	   $readmemh(A_B0R10,Ext_B0R10_mem);
     	   $readmemh(A_B0R11,Ext_B0R11_mem);
     	   $readmemh(A_B0R12,Ext_B0R12_mem);
     	   $readmemh(A_B0R13,Ext_B0R13_mem);
     	   $readmemh(A_B0R14,Ext_B0R14_mem);
     	   $readmemh(A_B0R15,Ext_B0R15_mem);

     	   $readmemh(A_B1R0,Ext_B1R0_mem);
     	   $readmemh(A_B1R1,Ext_B1R1_mem);
     	   $readmemh(A_B1R2,Ext_B1R2_mem);
     	   $readmemh(A_B1R3,Ext_B1R3_mem);
     	   $readmemh(A_B1R4,Ext_B1R4_mem);
     	   $readmemh(A_B1R5,Ext_B1R5_mem);
     	   $readmemh(A_B1R6,Ext_B1R6_mem);
     	   $readmemh(A_B1R7,Ext_B1R7_mem);
		   $readmemh(A_B1R8,Ext_B1R8_mem);
     	   $readmemh(A_B1R9,Ext_B1R9_mem);
     	   $readmemh(A_B1R10,Ext_B1R10_mem);
     	   $readmemh(A_B1R11,Ext_B1R11_mem);
     	   $readmemh(A_B1R12,Ext_B1R12_mem);
     	   $readmemh(A_B1R13,Ext_B1R13_mem);
     	   $readmemh(A_B1R14,Ext_B1R14_mem);
     	   $readmemh(A_B1R15,Ext_B1R15_mem);
         //golden data                                                                                                        
         k = 0;                                                                                                               
         gd = $fopen(golden_file,"r");
         if(gd == 0) begin                                                                                                    
             $display("read file open error !");
             $finish;                                                                                                         
         end                                                                                                                  
         while(!$feof(gd))begin                                                                                               
             ef = $fscanf(gd , "%d",golden_mem[k]); 
             k  = k + 1;                                                                                                      
         end                                                                                                                  
     end                                                                                                                      
                                                                                                                              
 	//                                                                                                                          
 	FFTP u_FFTP(.MulValid_out(MulValid_out),                                                                                    
 				.MulD0_out(MulD0_out),                                                                                          
 				.MulD1_out(MulD1_out),                                                                                          
 				.MulD2_out(MulD2_out),                                                                                          
 				.MulD3_out(MulD3_out),                                                                                          
 				.MulD4_out(MulD4_out),                                                                                          
 				.MulD5_out(MulD5_out),                                                                                          
 				.MulD6_out(MulD6_out),                                                                                          
 				.MulD7_out(MulD7_out),                                                                                          
 				.MulD8_out(MulD8_out),                                                                                          
 				.MulD9_out(MulD9_out),                                                                                          
 				.MulD10_out(MulD10_out),                                                                                          
 				.MulD11_out(MulD11_out),                                                                                          
 				.MulD12_out(MulD12_out),                                                                                          
 				.MulD13_out(MulD13_out),                                                                                          
 				.MulD14_out(MulD14_out),                                                                                          
 				.MulD15_out(MulD15_out),  

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
 				.N_in(N_in),                                                                                                    
 				.ExtValid_in(ExtValid_in),                                                                                      
 				.rst_n(rst_n),                                                                                                  
 				.clk(clk)                                                                                                       
 				) ;                                                                                                             
                                                                                                                              
                                                                                                                              
 	always #(0.5*CYCLE) clk = ~clk ;                                                                                            
                                                                                                                              
                                                                                                                              
     //FSDB                                                                                                                   
 	initial begin                                                                                                               
 		$fsdbDumpfile("FFTP.fsdb"); 
 		$fsdbDumpvars ;  
		$fsdbDumpvars("+struct", "+mda", u_FFTP);
		//#2620 $fsdbDumpon;
		//#24300 $fsdbDumpoff;                                                                                                    
        //$dumpfile("FFTP.vcd");
        //$shm_open("FFTP.shm");
        //$shm_probe(test_FFTP.u_FFTP, "ASCM"); 
 	end  

 	initial begin                                                                                                               
 		                                                                                                                        
 		clk = 1 ;                                                                                                               
 		rst_n = 1 ;                                                                                                             
 		ExtValid_in = 0 ;                                                                                                       
 		N_in = 64'hFFFFFFFF_00000001 ;                                                                                          
 		ExtB0_D0_in = 0 ;                                                                                                       
 		ExtB0_D1_in = 0 ;                                                                                                       
 		ExtB0_D2_in = 0 ;                                                                                                       
 		ExtB0_D3_in = 0 ;                                                                                                       
 		ExtB0_D4_in = 0 ;                                                                                                       
 		ExtB0_D5_in = 0 ;                                                                                                       
 		ExtB0_D6_in = 0 ;                                                                                                       
 		ExtB0_D7_in = 0 ;  
		ExtB0_D8_in = 0 ;                                                                                                       
 		ExtB0_D9_in = 0 ;                                                                                                       
 		ExtB0_D10_in = 0 ;                                                                                                       
 		ExtB0_D11_in = 0 ;                                                                                                       
 		ExtB0_D12_in = 0 ;                                                                                                       
 		ExtB0_D13_in = 0 ;                                                                                                       
 		ExtB0_D14_in = 0 ;                                                                                                       
 		ExtB0_D15_in = 0 ;  

 		ExtB1_D0_in = 0 ;                                                                                                       
 		ExtB1_D1_in = 0 ;                                                                                                       
 		ExtB1_D2_in = 0 ;                                                                                                       
 		ExtB1_D3_in = 0 ;                                                                                                       
 		ExtB1_D4_in = 0 ;                                                                                                       
 		ExtB1_D5_in = 0 ;                                                                                                       
 		ExtB1_D6_in = 0 ;                                                                                                       
 		ExtB1_D7_in = 0 ;     
		ExtB1_D8_in = 0 ;                                                                                                       
 		ExtB1_D9_in = 0 ;                                                                                                       
 		ExtB1_D10_in = 0 ;                                                                                                       
 		ExtB1_D11_in = 0 ;                                                                                                       
 		ExtB1_D12_in = 0 ;                                                                                                       
 		ExtB1_D13_in = 0 ;                                                                                                       
 		ExtB1_D14_in = 0 ;                                                                                                       
 		ExtB1_D15_in = 0 ;                                                                                                       
 		//                                                                                                                      
 		#(CYCLE)                                                                                                                
 		rst_n = 0 ;                                                                                                             
 		                                                                                                                        
 		#(3.1*CYCLE)                                                                                                            
 		rst_n = 1 ;                                                                                                             
 		                                                                                                                        
 		#(2*CYCLE)                                                                                                              
 		ExtValid_in = 1 ;                                                                                                       
 		                                                                                                                        
 		#(0.1*CYCLE)                                                                                                            
 		// Load parameters                                                                                                      
 		                                                                                                                        
 		///*                                                                                                                    
 		//---test Mul all 1-----------------------                                                                              
 		// address=0~31                                                                                                         
 		for(j=0;j<ADDR_VALUE;j=j+1) begin                                                                                       
 			#(CYCLE)                                                                                                            
 		                                                                                                                        
 			ExtB0_D0_in  = Ext_B0R0_mem[j] ;                                                                                       
          	ExtB0_D1_in  = Ext_B0R1_mem[j] ;                                                                                       
 			ExtB0_D2_in  = Ext_B0R2_mem[j] ;                                                                                               
 			ExtB0_D3_in  = Ext_B0R3_mem[j] ;                                                                                               
 			ExtB0_D4_in  = Ext_B0R4_mem[j] ;                                                                                               
 			ExtB0_D5_in  = Ext_B0R5_mem[j] ;                                                                                               
 			ExtB0_D6_in  = Ext_B0R6_mem[j] ;                                                                                               
 			ExtB0_D7_in  = Ext_B0R7_mem[j] ;  
			ExtB0_D8_in  = Ext_B0R8_mem[j] ;                                                                                       
          	ExtB0_D9_in  = Ext_B0R9_mem[j] ;                                                                                       
 			ExtB0_D10_in  = Ext_B0R10_mem[j] ;                                                                                               
 			ExtB0_D11_in  = Ext_B0R11_mem[j] ;                                                                                               
 			ExtB0_D12_in  = Ext_B0R12_mem[j] ;                                                                                               
 			ExtB0_D13_in  = Ext_B0R13_mem[j] ;                                                                                               
 			ExtB0_D14_in  = Ext_B0R14_mem[j] ;                                                                                               
 			ExtB0_D15_in  = Ext_B0R15_mem[j] ;                                                                                              
                                                                                                                         
 			                                                                                                               
 			ExtB1_D0_in  = Ext_B1R0_mem[j] ;                                                                                               
 			ExtB1_D1_in  = Ext_B1R1_mem[j] ;                                                                                               
 			ExtB1_D2_in  = Ext_B1R2_mem[j] ;                                                                                               
 			ExtB1_D3_in  = Ext_B1R3_mem[j] ;                                                                                               
 			ExtB1_D4_in  = Ext_B1R4_mem[j] ;                                                                                               
 			ExtB1_D5_in  = Ext_B1R5_mem[j] ;                                                                                               
 			ExtB1_D6_in  = Ext_B1R6_mem[j] ;                                                                                               
 			ExtB1_D7_in  = Ext_B1R7_mem[j] ; 
			ExtB1_D8_in  = Ext_B1R8_mem[j] ;                                                                                               
 			ExtB1_D9_in  = Ext_B1R9_mem[j] ;                                                                                               
 			ExtB1_D10_in  = Ext_B1R10_mem[j] ;                                                                                               
 			ExtB1_D11_in  = Ext_B1R11_mem[j] ;                                                                                               
 			ExtB1_D12_in  = Ext_B1R12_mem[j] ;                                                                                               
 			ExtB1_D13_in  = Ext_B1R13_mem[j] ;                                                                                               
 			ExtB1_D14_in  = Ext_B1R14_mem[j] ;                                                                                               
 			ExtB1_D15_in  = Ext_B1R15_mem[j] ;                                                                                               
 		                                                                                                                        
 		end		                                                                                                                
 		//*/                                                                                                                    
 		                                                                                                                        
 		//                                                                                                                      
 		#(CYCLE)                                                                                                                
 		ExtValid_in = 0 ;                                                                                                       
 		error = 0;                                                                                                                        
 		//        
		/*                                                                                                            
 		@(posedge MulValid_out)                                                                                                 
 		@(posedge clk)                                                                                                                                                                                                             
 		$display(" ==== Check Final Result  ==== ") ;          
 		for(i=0; i< test_data_index_over; i=i+1) begin                                                                       
 			#(CYCLE)        //Mul_Result_Golden                                                                                 
 			if(MulD0_out == golden_mem[16*i+0]) $display("MulD0_out[%d] = %d", 16*i,MulD0_out) ;
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD0_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i,MulD0_out,16*i,golden_mem[16*i]) ;
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			                //Mul_Result_Golden                                                                                 
 			if(MulD1_out == golden_mem[16*i+1]) $display("MulD1_out[%d] = %d", 16*i+1,MulD1_out) ; 
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD1_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+1,MulD1_out,16*i+1,golden_mem[16*i +1] ) ;
 				//$stop ;                                                                                                       
 			end                                                                                                                 
                             //Mul_Result_Golden                                                                              
 			if(MulD2_out == golden_mem[16*i+2]) $display("MulD2_out[%d] = %d", 16*i+2,MulD2_out) ;
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD2_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+2,MulD2_out,16*i+2,golden_mem[16*i + 2]) ;
 				//$stop ;                                                                                                       
 			end                                                                                                                 
                             //Mul_Result_Golden                                                                              
 			if(MulD3_out == golden_mem[16*i+3]) $display("MulD3_out[%d] = %d", 16*i+3,MulD3_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD3_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+3,MulD3_out,16*i+3,golden_mem[16*i + 3]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD4_out == golden_mem[16*i+4]) $display("MulD4_out[%d] = %d", 16*i+4,MulD4_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD4_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+4,MulD4_out,16*i+4,golden_mem[16*i + 4]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD5_out == golden_mem[16*i+5]) $display("MulD5_out[%d] = %d", 16*i+5,MulD5_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD5_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+5,MulD5_out,16*i+5,golden_mem[16*i + 5]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD6_out == golden_mem[16*i+6]) $display("MulD6_out[%d] = %d", 16*i+6,MulD6_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD6_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+6,MulD6_out,16*i+6,golden_mem[16*i + 6]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD7_out == golden_mem[16*i+7]) $display("MulD7_out[%d] = %d", 16*i+7,MulD7_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD7_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+7,MulD7_out,16*i+7,golden_mem[16*i + 7]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD8_out == golden_mem[16*i+8]) $display("MulD8_out[%d] = %d", 16*i+8,MulD8_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD8_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+8,MulD8_out,16*i+8,golden_mem[16*i + 8]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD9_out == golden_mem[16*i+9]) $display("MulD9_out[%d] = %d", 16*i+9,MulD9_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD9_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+9,MulD9_out,16*i+9,golden_mem[16*i + 9]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD10_out == golden_mem[16*i+10]) $display("MulD10_out[%d] = %d", 16*i+10,MulD10_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD10_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+10,MulD10_out,16*i+10,golden_mem[16*i + 10]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD11_out == golden_mem[16*i+11]) $display("MulD11_out[%d] = %d", 16*i+11,MulD11_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD11_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+11,MulD11_out,16*i+11,golden_mem[16*i + 11]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD12_out == golden_mem[16*i+12]) $display("MulD12_out[%d] = %d", 16*i+12,MulD12_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD12_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+12,MulD12_out,16*i+12,golden_mem[16*i + 12]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD13_out == golden_mem[16*i+13]) $display("MulD13_out[%d] = %d", 16*i+13,MulD13_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD13_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+13,MulD13_out,16*i+13,golden_mem[16*i + 13]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD14_out == golden_mem[16*i+14]) $display("MulD14_out[%d] = %d", 16*i+14,MulD14_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD14_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+14,MulD14_out,16*i+14,golden_mem[16*i + 14]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 			if(MulD15_out == golden_mem[16*i+15]) $display("MulD15_out[%d] = %d", 16*i+15,MulD15_out) ;  
 			else begin                                                                                                          
 				error = error + 1;
 				$display("MulD15_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+15,MulD15_out,16*i+15,golden_mem[16*i + 15]) ; 
 				//$stop ;                                                                                                       
 			end                                                                                                                 
 		end                                                                                                                     
 		$display("  ==== VERFICATION OF MULTIPLCIATION IS COMPLETED  ==== ") ;  
 		$display("Total error = %d",error) ; 
 	                                                                                                                    
 		                                                                                                                        
 		#(10*CYCLE)   		                                                                                                    
 		$finish ; */                                                                                                             
 	end 
	                                                                                                                                                                                                                                 
 	                                                                                                                            
 	always @(posedge clk) begin
		if (MulValid_out) begin
			$display(" ==== Check Final Result  ==== ") ;          
 			for(i=0; i< test_data_index_over; i=i+1) begin                                                                                                                                                        
 				if(MulD0_out == golden_mem[16*i+0]) $display("MulD0_out[%d] = %d", 16*i,MulD0_out) ;
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD0_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i,MulD0_out,16*i,golden_mem[16*i]) ;
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				                //Mul_Result_Golden                                                                                 
 				if(MulD1_out == golden_mem[16*i+1]) $display("MulD1_out[%d] = %d", 16*i+1,MulD1_out) ; 
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD1_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+1,MulD1_out,16*i+1,golden_mem[16*i +1] ) ;
 					//$stop ;                                                                                                       
 				end                                                                                                                 
        	                     //Mul_Result_Golden                                                                              
 				if(MulD2_out == golden_mem[16*i+2]) $display("MulD2_out[%d] = %d", 16*i+2,MulD2_out) ;
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD2_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+2,MulD2_out,16*i+2,golden_mem[16*i + 2]) ;
 					//$stop ;                                                                                                       
 				end                                                                                                                 
        	                     //Mul_Result_Golden                                                                              
 				if(MulD3_out == golden_mem[16*i+3]) $display("MulD3_out[%d] = %d", 16*i+3,MulD3_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD3_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+3,MulD3_out,16*i+3,golden_mem[16*i + 3]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD4_out == golden_mem[16*i+4]) $display("MulD4_out[%d] = %d", 16*i+4,MulD4_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD4_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+4,MulD4_out,16*i+4,golden_mem[16*i + 4]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD5_out == golden_mem[16*i+5]) $display("MulD5_out[%d] = %d", 16*i+5,MulD5_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD5_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+5,MulD5_out,16*i+5,golden_mem[16*i + 5]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD6_out == golden_mem[16*i+6]) $display("MulD6_out[%d] = %d", 16*i+6,MulD6_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD6_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+6,MulD6_out,16*i+6,golden_mem[16*i + 6]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD7_out == golden_mem[16*i+7]) $display("MulD7_out[%d] = %d", 16*i+7,MulD7_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD7_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+7,MulD7_out,16*i+7,golden_mem[16*i + 7]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD8_out == golden_mem[16*i+8]) $display("MulD8_out[%d] = %d", 16*i+8,MulD8_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD8_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+8,MulD8_out,16*i+8,golden_mem[16*i + 8]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD9_out == golden_mem[16*i+9]) $display("MulD9_out[%d] = %d", 16*i+9,MulD9_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD9_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+9,MulD9_out,16*i+9,golden_mem[16*i + 9]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD10_out == golden_mem[16*i+10]) $display("MulD10_out[%d] = %d", 16*i+10,MulD10_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD10_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+10,MulD10_out,16*i+10,golden_mem[16*i + 10]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD11_out == golden_mem[16*i+11]) $display("MulD11_out[%d] = %d", 16*i+11,MulD11_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD11_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+11,MulD11_out,16*i+11,golden_mem[16*i + 11]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD12_out == golden_mem[16*i+12]) $display("MulD12_out[%d] = %d", 16*i+12,MulD12_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD12_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+12,MulD12_out,16*i+12,golden_mem[16*i + 12]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD13_out == golden_mem[16*i+13]) $display("MulD13_out[%d] = %d", 16*i+13,MulD13_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD13_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+13,MulD13_out,16*i+13,golden_mem[16*i + 13]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD14_out == golden_mem[16*i+14]) $display("MulD14_out[%d] = %d", 16*i+14,MulD14_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD14_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+14,MulD14_out,16*i+14,golden_mem[16*i + 14]) ; 
 					//$stop ;                                                                                                       
 				end                                                                                                                 
 				if(MulD15_out == golden_mem[16*i+15]) $display("MulD15_out[%d] = %d", 16*i+15,MulD15_out) ;  
 				else begin                                                                                                          
 					error = error + 1;
 					$display("MulD15_out[%d] = %d, Mul_Result_Golden[%d] = %d", 16*i+15,MulD15_out,16*i+15,golden_mem[16*i + 15]) ; 
 					//$stop ;                                                                                                       
 				end 
				#(CYCLE) ;       //Mul_Result_Golden                                                                                                                
 			end                                                                                                                     
 			$display("  ==== VERFICATION OF MULTIPLCIATION IS COMPLETED  ==== ") ;  
 			$display("Total error = %d",error) ; 
 			//                                                                                                                    
	
 			#(10*CYCLE)   		                                                                                                    
 			$finish ;
		end
	end                                                                                                                            
 endmodule                                                                                                                    
