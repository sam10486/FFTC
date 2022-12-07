`timescale 1 ns/1 ps 

module Mux3_const(
    //output
    MulB0_out_const_64,
    MulB1_out_const_64,
    MulB2_out_const_64,
    MulB3_out_const_64,
    MulB4_out_const_64,
    MulB5_out_const_64,
    MulB6_out_const_64,
    MulB7_out_const_64,
    MulB8_out_const_64,
    MulB9_out_const_64,
    MulB10_out_const_64,
    MulB11_out_const_64,
    MulB12_out_const_64,
    MulB13_out_const_64,
    MulB14_out_const_64,
    MulB15_out_const_64,
    //input
    ROMD0_in_const128,
    ROMD1_in_const128,
    ROMD2_in_const128,
    ROMD3_in_const128,
    ROMD4_in_const128,
    ROMD5_in_const128,
    ROMD6_in_const128,
    ROMD7_in_const128,   
    Mul_sel
);

    parameter P_WIDTH   = 64 ;                                                                 
    parameter SD_WIDTH  = 128 ;                                                                
    parameter SEG1  = 64 ;                                                                     
    parameter SEG2  = 128 ;                                                                    

    parameter P_ONE   = 64'd1 ;
    parameter PINV    = 64'd18445618169508003841; // inverse N

    output [P_WIDTH-1:0] MulB0_out_const_64  ;
    output [P_WIDTH-1:0] MulB1_out_const_64  ;
    output [P_WIDTH-1:0] MulB2_out_const_64  ;
    output [P_WIDTH-1:0] MulB3_out_const_64  ;
    output [P_WIDTH-1:0] MulB4_out_const_64  ;
    output [P_WIDTH-1:0] MulB5_out_const_64  ;
    output [P_WIDTH-1:0] MulB6_out_const_64  ;
    output [P_WIDTH-1:0] MulB7_out_const_64  ;
    output [P_WIDTH-1:0] MulB8_out_const_64  ;
    output [P_WIDTH-1:0] MulB9_out_const_64  ;
    output [P_WIDTH-1:0] MulB10_out_const_64 ;
    output [P_WIDTH-1:0] MulB11_out_const_64 ;
    output [P_WIDTH-1:0] MulB12_out_const_64 ;
    output [P_WIDTH-1:0] MulB13_out_const_64 ;
    output [P_WIDTH-1:0] MulB14_out_const_64 ;
    output [P_WIDTH-1:0] MulB15_out_const_64 ;

    input [P_WIDTH-1:0]     ROMD0_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD1_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD2_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD3_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD4_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD5_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD6_in_const128   ;
    input [SD_WIDTH-1:0]    ROMD7_in_const128   ;

    input                 Mul_sel ;  

    assign MulB0_out_const_64 = P_ONE ;   

    assign MulB1_out_const_64 = (Mul_sel==1'd1) ? ROMD0_in_const128 : P_ONE ;

    assign MulB2_out_const_64 = (Mul_sel==1'd1) ? ROMD1_in_const128[SEG2-1:SEG1] : P_ONE ;			

    assign MulB3_out_const_64 = (Mul_sel==1'd1) ? ROMD1_in_const128[SEG1-1:0] : P_ONE ;

    assign MulB4_out_const_64 = (Mul_sel==1'd1) ? ROMD2_in_const128[SEG2-1:SEG1] : P_ONE ;	

    assign MulB5_out_const_64 = (Mul_sel==1'd1) ? ROMD2_in_const128[SEG1-1:0] : P_ONE ;	

    assign MulB6_out_const_64 = (Mul_sel==1'd1) ? ROMD3_in_const128[SEG2-1:SEG1] : P_ONE ;	

    assign MulB7_out_const_64 = (Mul_sel==1'd1) ? ROMD3_in_const128[SEG1-1:0] : P_ONE ;	    

    assign MulB8_out_const_64 = (Mul_sel==1'd1) ? ROMD4_in_const128[SEG2-1:SEG1] : P_ONE ;

    assign MulB9_out_const_64 = (Mul_sel==1'd1) ? ROMD4_in_const128[SEG1-1:0] : P_ONE ;	       

    assign MulB10_out_const_64 = (Mul_sel==1'd1) ? ROMD5_in_const128[SEG2-1:SEG1] : P_ONE ;		

    assign MulB11_out_const_64 = (Mul_sel==1'd1) ? ROMD5_in_const128[SEG1-1:0] : P_ONE ;	 

    assign MulB12_out_const_64 = (Mul_sel==1'd1) ? ROMD6_in_const128[SEG2-1:SEG1] : P_ONE ;		

    assign MulB13_out_const_64 = (Mul_sel==1'd1) ? ROMD6_in_const128[SEG1-1:0] : P_ONE ;

    assign MulB14_out_const_64 = (Mul_sel==1'd1) ? ROMD7_in_const128[SEG2-1:SEG1] : P_ONE ;

    assign MulB15_out_const_64 = (Mul_sel==1'd1) ? ROMD7_in_const128[SEG1-1:0] : P_ONE ;


endmodule
