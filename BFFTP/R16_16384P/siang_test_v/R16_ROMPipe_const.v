`timescale 1 ns/1 ps

module R16_ROMPipe_const(
    //output 
    ROM0_const_out,
    ROM1_const_out,
    ROM2_const_out,
    ROM3_const_out,
    ROM4_const_out,
    ROM5_const_out,
    ROM6_const_out,
    ROM7_const_out,

    //input
    ROM0_const_in,
    ROM1_const_in,
    ROM2_const_in,
    ROM3_const_in,
    ROM4_const_in,
    ROM5_const_in,
    ROM6_const_in,
    ROM7_const_in,
    rst_n,
    clk
);

    parameter P_WIDTH   = 64 ;					                     
    parameter SD_WIDTH  = 128 ;                                     
    parameter P_ZERO    = 64'h0 ;                                   
    parameter SD_ZERO   = 128'h0 ;    

    output reg [P_WIDTH-1:0]    ROM0_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM1_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM2_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM3_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM4_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM5_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM6_const_out  ;
    output reg [SD_WIDTH-1:0]   ROM7_const_out  ;
    
    input  [P_WIDTH-1:0]    ROM0_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM1_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM2_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM3_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM4_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM5_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM6_const_in  ;                              
    input  [SD_WIDTH-1:0]   ROM7_const_in  ; 

    input                   rst_n ;                                 
    input                   clk ; 

    reg [P_WIDTH-1:0]    ROM0_const_in_D0reg ;
    reg [P_WIDTH-1:0]    ROM0_const_in_D1reg ;
    reg [P_WIDTH-1:0]    ROM0_const_in_D2reg ;
    reg [P_WIDTH-1:0]    ROM0_const_in_D3reg ;
    reg [P_WIDTH-1:0]    ROM0_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM1_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM1_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM1_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM1_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM1_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM2_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM2_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM2_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM2_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM2_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM3_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM3_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM3_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM3_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM3_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM4_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM4_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM4_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM4_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM4_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM5_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM5_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM5_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM5_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM5_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM6_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM6_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM6_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM6_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM6_const_in_D4reg ;
    reg [SD_WIDTH-1:0]   ROM7_const_in_D0reg ;
    reg [SD_WIDTH-1:0]   ROM7_const_in_D1reg ;
    reg [SD_WIDTH-1:0]   ROM7_const_in_D2reg ;
    reg [SD_WIDTH-1:0]   ROM7_const_in_D3reg ;
    reg [SD_WIDTH-1:0]   ROM7_const_in_D4reg ;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            ROM0_const_in_D0reg <= P_ZERO   ;
            ROM0_const_in_D1reg <= P_ZERO   ;
            ROM0_const_in_D2reg <= P_ZERO   ;
            ROM0_const_in_D3reg <= P_ZERO   ;
            ROM0_const_in_D4reg <= P_ZERO   ;
            ROM0_const_out      <= P_ZERO   ;
            
            ROM1_const_in_D0reg <= SD_ZERO  ;
            ROM1_const_in_D1reg <= SD_ZERO  ;
            ROM1_const_in_D2reg <= SD_ZERO  ;
            ROM1_const_in_D3reg <= SD_ZERO  ;
            ROM1_const_in_D4reg <= SD_ZERO  ;
            ROM1_const_out       <= SD_ZERO  ;

            ROM2_const_in_D0reg <= SD_ZERO  ;
            ROM2_const_in_D1reg <= SD_ZERO  ;
            ROM2_const_in_D2reg <= SD_ZERO  ;
            ROM2_const_in_D3reg <= SD_ZERO  ;
            ROM2_const_in_D4reg <= SD_ZERO  ;
            ROM2_const_out      <= SD_ZERO  ;

            ROM3_const_in_D0reg <= SD_ZERO  ;
            ROM3_const_in_D1reg <= SD_ZERO  ;
            ROM3_const_in_D2reg <= SD_ZERO  ;
            ROM3_const_in_D3reg <= SD_ZERO  ;
            ROM3_const_in_D4reg <= SD_ZERO  ;
            ROM3_const_out      <= SD_ZERO  ;

            ROM4_const_in_D0reg <= SD_ZERO  ;
            ROM4_const_in_D1reg <= SD_ZERO  ;
            ROM4_const_in_D2reg <= SD_ZERO  ;
            ROM4_const_in_D3reg <= SD_ZERO  ;
            ROM4_const_in_D4reg <= SD_ZERO  ;
            ROM4_const_out      <= SD_ZERO  ;

            ROM5_const_in_D0reg <= SD_ZERO  ;
            ROM5_const_in_D1reg <= SD_ZERO  ;
            ROM5_const_in_D2reg <= SD_ZERO  ;
            ROM5_const_in_D3reg <= SD_ZERO  ;
            ROM5_const_in_D4reg <= SD_ZERO  ;
            ROM5_const_out      <= SD_ZERO  ;

            ROM6_const_in_D0reg <= SD_ZERO  ;
            ROM6_const_in_D1reg <= SD_ZERO  ;
            ROM6_const_in_D2reg <= SD_ZERO  ;
            ROM6_const_in_D3reg <= SD_ZERO  ;
            ROM6_const_in_D4reg <= SD_ZERO  ;
            ROM6_const_out      <= SD_ZERO  ;

            ROM7_const_in_D0reg <= SD_ZERO  ;
            ROM7_const_in_D1reg <= SD_ZERO  ;
            ROM7_const_in_D2reg <= SD_ZERO  ;
            ROM7_const_in_D3reg <= SD_ZERO  ;
            ROM7_const_in_D4reg <= SD_ZERO  ;
            ROM7_const_out      <= SD_ZERO  ;
        end else begin
            ROM0_const_in_D0reg <= ROM0_const_in;
            ROM0_const_in_D1reg <= ROM0_const_in_D0reg;
            ROM0_const_in_D2reg <= ROM0_const_in_D1reg;
            ROM0_const_in_D3reg <= ROM0_const_in_D2reg;
            ROM0_const_in_D4reg <= ROM0_const_in_D3reg;
            ROM0_const_out      <= ROM0_const_in_D4reg;

            ROM1_const_in_D0reg <= ROM1_const_in;
            ROM1_const_in_D1reg <= ROM1_const_in_D0reg;
            ROM1_const_in_D2reg <= ROM1_const_in_D1reg;
            ROM1_const_in_D3reg <= ROM1_const_in_D2reg;
            ROM1_const_in_D4reg <= ROM1_const_in_D3reg;
            ROM1_const_out      <= ROM1_const_in_D4reg;

            ROM2_const_in_D0reg <= ROM2_const_in;
            ROM2_const_in_D1reg <= ROM2_const_in_D0reg;
            ROM2_const_in_D2reg <= ROM2_const_in_D1reg;
            ROM2_const_in_D3reg <= ROM2_const_in_D2reg;
            ROM2_const_in_D4reg <= ROM2_const_in_D3reg;
            ROM2_const_out      <= ROM2_const_in_D4reg;

            ROM3_const_in_D0reg <= ROM3_const_in;
            ROM3_const_in_D1reg <= ROM3_const_in_D0reg;
            ROM3_const_in_D2reg <= ROM3_const_in_D1reg;
            ROM3_const_in_D3reg <= ROM3_const_in_D2reg;
            ROM3_const_in_D4reg <= ROM3_const_in_D3reg;
            ROM3_const_out      <= ROM3_const_in_D4reg;


            ROM4_const_in_D0reg <= ROM4_const_in;
            ROM4_const_in_D1reg <= ROM4_const_in_D0reg;
            ROM4_const_in_D2reg <= ROM4_const_in_D1reg;
            ROM4_const_in_D3reg <= ROM4_const_in_D2reg;
            ROM4_const_in_D4reg <= ROM4_const_in_D3reg;
            ROM4_const_out      <= ROM4_const_in_D4reg;


            ROM5_const_in_D0reg <= ROM5_const_in;
            ROM5_const_in_D1reg <= ROM5_const_in_D0reg;
            ROM5_const_in_D2reg <= ROM5_const_in_D1reg;
            ROM5_const_in_D3reg <= ROM5_const_in_D2reg;
            ROM5_const_in_D4reg <= ROM5_const_in_D3reg;
            ROM5_const_out      <= ROM5_const_in_D4reg;


            ROM6_const_in_D0reg <= ROM6_const_in;
            ROM6_const_in_D1reg <= ROM6_const_in_D0reg;
            ROM6_const_in_D2reg <= ROM6_const_in_D1reg;
            ROM6_const_in_D3reg <= ROM6_const_in_D2reg;
            ROM6_const_in_D4reg <= ROM6_const_in_D3reg;
            ROM6_const_out      <= ROM6_const_in_D4reg;

            ROM7_const_in_D0reg <= ROM7_const_in;
            ROM7_const_in_D1reg <= ROM7_const_in_D0reg;
            ROM7_const_in_D2reg <= ROM7_const_in_D1reg;
            ROM7_const_in_D3reg <= ROM7_const_in_D2reg;
            ROM7_const_in_D4reg <= ROM7_const_in_D3reg;
            ROM7_const_out      <= ROM7_const_in_D4reg;
        end
    end
    
    
endmodule