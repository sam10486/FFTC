`timescale 1 ns/1 ps 

module horizontal_Mux3 (
    horizontal_tf1_output,
    horizontal_tf2_output,
    horizontal_tf3_output,
    horizontal_tf4_output,
    horizontal_tf5_output,
    horizontal_tf6_output,
    horizontal_tf7_output,
    horizontal_tf8_output,
    horizontal_tf9_output,
    horizontal_tf10_output,
    horizontal_tf11_output,
    horizontal_tf12_output,
    horizontal_tf13_output,
    horizontal_tf14_output,
    horizontal_tf15_output,

    horizontal_ROM0_in,
    horizontal_ROM1_in,
    horizontal_ROM2_in,
    horizontal_ROM3_in,
    horizontal_ROM4_in,
    horizontal_ROM5_in,
    horizontal_ROM6_in,
    horizontal_ROM7_in
);

    parameter P_WIDTH   = 64 ;                                                                 
    parameter SD_WIDTH  = 128 ;                                                                
    parameter SEG1  = 64 ;                                                                     
    parameter SEG2  = 128 ; 
                                                       
    output [P_WIDTH-1:0] horizontal_tf1_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf2_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf3_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf4_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf5_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf6_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf7_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf8_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf9_output ;                                                           
    output [P_WIDTH-1:0] horizontal_tf10_output ;                                                          
    output [P_WIDTH-1:0] horizontal_tf11_output ;                                                          
    output [P_WIDTH-1:0] horizontal_tf12_output ;                                                          
    output [P_WIDTH-1:0] horizontal_tf13_output ;                                                          
    output [P_WIDTH-1:0] horizontal_tf14_output ;                                                          
    output [P_WIDTH-1:0] horizontal_tf15_output ;

    input [P_WIDTH-1:0]  horizontal_ROM0_in ;
    input [SD_WIDTH-1:0] horizontal_ROM1_in ;
    input [SD_WIDTH-1:0] horizontal_ROM2_in ;
    input [SD_WIDTH-1:0] horizontal_ROM3_in ;
    input [SD_WIDTH-1:0] horizontal_ROM4_in ;
    input [SD_WIDTH-1:0] horizontal_ROM5_in ;
    input [SD_WIDTH-1:0] horizontal_ROM6_in ;
    input [SD_WIDTH-1:0] horizontal_ROM7_in ;


    assign horizontal_tf1_output    = horizontal_ROM0_in;
    assign horizontal_tf2_output    = horizontal_ROM1_in[SEG2-1:SEG1]; 
    assign horizontal_tf3_output    = horizontal_ROM1_in[SEG1-1:0]; 
    assign horizontal_tf4_output    = horizontal_ROM2_in[SEG2-1:SEG1]; 
    assign horizontal_tf5_output    = horizontal_ROM2_in[SEG1-1:0]; 
    assign horizontal_tf6_output    = horizontal_ROM3_in[SEG2-1:SEG1]; 
    assign horizontal_tf7_output    = horizontal_ROM3_in[SEG1-1:0]; 
    assign horizontal_tf8_output    = horizontal_ROM4_in[SEG2-1:SEG1]; 
    assign horizontal_tf9_output    = horizontal_ROM4_in[SEG1-1:0];
    assign horizontal_tf10_output   = horizontal_ROM5_in[SEG2-1:SEG1]; 
    assign horizontal_tf11_output   = horizontal_ROM5_in[SEG1-1:0]; 
    assign horizontal_tf12_output   = horizontal_ROM6_in[SEG2-1:SEG1]; 
    assign horizontal_tf13_output   = horizontal_ROM6_in[SEG1-1:0]; 
    assign horizontal_tf14_output   = horizontal_ROM7_in[SEG2-1:SEG1]; 
    assign horizontal_tf15_output   = horizontal_ROM7_in[SEG1-1:0]; 


endmodule