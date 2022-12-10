`timescale 1 ns/1 ps 

module horizontal_top (
    S_out,


    horizontal_ROM0_in,
    horizontal_ROM1_in,
    horizontal_ROM2_in,
    horizontal_ROM3_in,
    horizontal_ROM4_in,
    horizontal_ROM5_in,
    horizontal_ROM6_in,
    horizontal_ROM7_in,

    rst_n,
    clk,
    state,
    stage_counter,
    CEN,
    N_in
);

    parameter S_WIDTH   = 4     ;  
    parameter P_WIDTH   = 64    ;  
    parameter SD_WIDTH  = 128   ;  
    parameter DC_WIDTH  = 13    ;
    parameter DCNT_BP4  = 10    ; 

    output [P_WIDTH-1:0] S_out;

    input [P_WIDTH-1:0]  horizontal_ROM0_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM1_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM2_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM3_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM4_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM5_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM6_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM7_in  ;

    input clk;
    input rst_n;
    input [S_WIDTH-1:0] state;
    input [DC_WIDTH-1:DCNT_BP4] stage_counter;
    input CEN;
    input [P_WIDTH-1:0] N_in;

    wire [P_WIDTH-1:0] tf1     ;
    wire [P_WIDTH-1:0] tf2     ;
    wire [P_WIDTH-1:0] tf3     ;
    wire [P_WIDTH-1:0] tf4     ;
    wire [P_WIDTH-1:0] tf5     ;
    wire [P_WIDTH-1:0] tf6     ;
    wire [P_WIDTH-1:0] tf7     ;
    wire [P_WIDTH-1:0] tf8     ;
    wire [P_WIDTH-1:0] tf9     ;
    wire [P_WIDTH-1:0] tf10    ;
    wire [P_WIDTH-1:0] tf11    ;
    wire [P_WIDTH-1:0] tf12    ;
    wire [P_WIDTH-1:0] tf13    ;
    wire [P_WIDTH-1:0] tf14    ;
    wire [P_WIDTH-1:0] tf15    ;

    wire [P_WIDTH-1:0] siang_group_tf_fly_wire;

    wire [P_WIDTH-1:0] A_in ;
 
    assign A_in = tf1;

    horizontal_Mux3 horizontal_Mux3(
        .horizontal_tf1_output  (tf1 )  ,
        .horizontal_tf2_output  (tf2 )  ,
        .horizontal_tf3_output  (tf3 )  ,
        .horizontal_tf4_output  (tf4 )  ,
        .horizontal_tf5_output  (tf5 )  ,
        .horizontal_tf6_output  (tf6 )  ,
        .horizontal_tf7_output  (tf7 )  ,
        .horizontal_tf8_output  (tf8 )  ,
        .horizontal_tf9_output  (tf9 )  ,
        .horizontal_tf10_output (tf10)  ,
        .horizontal_tf11_output (tf11)  ,
        .horizontal_tf12_output (tf12)  ,
        .horizontal_tf13_output (tf13)  ,
        .horizontal_tf14_output (tf14)  ,
        .horizontal_tf15_output (tf15)  ,

        .horizontal_ROM0_in    (horizontal_ROM0_in)  ,
        .horizontal_ROM1_in    (horizontal_ROM1_in)  ,
        .horizontal_ROM2_in    (horizontal_ROM2_in)  ,
        .horizontal_ROM3_in    (horizontal_ROM3_in)  ,
        .horizontal_ROM4_in    (horizontal_ROM4_in)  ,
        .horizontal_ROM5_in    (horizontal_ROM5_in)  ,
        .horizontal_ROM6_in    (horizontal_ROM6_in)  ,
        .horizontal_ROM7_in    (horizontal_ROM7_in)  
    );


    horizontal_tf_fly horizontal_tf_fly0(
        .Q             (siang_group_tf_fly_wire),
        
        .rst_n         (rst_n),  
        .clk           (clk),  
        .state         (state),  
        .stage_counter (stage_counter) ,
        .CEN           (CEN)
    );

    MulMod128 mul_group_tf_fly0(
        .S_out(S_out),        
        .A_in(A_in),              
        .B_in(siang_group_tf_fly_wire),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );
endmodule