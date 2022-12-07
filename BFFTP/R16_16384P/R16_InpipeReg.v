//===================================                               
//Note:input data pipline buffer                                    
//===================================                               
`timescale 1ns/1ps                                                  
module R16_InpipeReg(                                               
        ExtValid_in,                                                
        ExtB0_D0_in,                                                
        ExtB0_D1_in,                                                
        ExtB0_D2_in,                                                
        ExtB0_D3_in,                                                
        ExtB0_D4_in,                                                
        ExtB0_D5_in,                                                
        ExtB0_D6_in,                                                
        ExtB0_D7_in,                                                
        ExtB1_D0_in,                                                
        ExtB1_D1_in,                                                
        ExtB1_D2_in,                                                
        ExtB1_D3_in,                                                
        ExtB1_D4_in,                                                
        ExtB1_D5_in,                                                
        ExtB1_D6_in,                                                
        ExtB1_D7_in,                                                
        ExtValid_out,                                               
        ExtB0_D0_out,                                               
        ExtB0_D1_out,                                               
        ExtB0_D2_out,                                               
        ExtB0_D3_out,                                               
        ExtB0_D4_out,                                               
        ExtB0_D5_out,                                               
        ExtB0_D6_out,                                               
        ExtB0_D7_out,                                               
        ExtB1_D0_out,                                               
        ExtB1_D1_out,                                               
        ExtB1_D2_out,                                               
        ExtB1_D3_out,                                               
        ExtB1_D4_out,                                               
        ExtB1_D5_out,                                               
        ExtB1_D6_out,                                               
        ExtB1_D7_out,                                               
        rst_n,                                                      
        clk                                                         
);                                                                  
                                                                    
    parameter CP_WIDTH = 22;
    parameter CP_ZERO  = 22'd0;
                                                                    
    output                ExtValid_out;                             
    output [CP_WIDTH-1:0] ExtB0_D0_out;                             
    output [CP_WIDTH-1:0] ExtB0_D1_out;                             
    output [CP_WIDTH-1:0] ExtB0_D2_out;                             
    output [CP_WIDTH-1:0] ExtB0_D3_out;                             
    output [CP_WIDTH-1:0] ExtB0_D4_out;                             
    output [CP_WIDTH-1:0] ExtB0_D5_out;                             
    output [CP_WIDTH-1:0] ExtB0_D6_out;                             
    output [CP_WIDTH-1:0] ExtB0_D7_out;                             
    output [CP_WIDTH-1:0] ExtB1_D0_out;                             
    output [CP_WIDTH-1:0] ExtB1_D1_out;                             
    output [CP_WIDTH-1:0] ExtB1_D2_out;                             
    output [CP_WIDTH-1:0] ExtB1_D3_out;                             
    output [CP_WIDTH-1:0] ExtB1_D4_out;                             
    output [CP_WIDTH-1:0] ExtB1_D5_out;                             
    output [CP_WIDTH-1:0] ExtB1_D6_out;                             
    output [CP_WIDTH-1:0] ExtB1_D7_out;                             
                                                                    
    input                 ExtValid_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D0_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D1_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D2_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D3_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D4_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D5_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D6_in;                              
    input  [CP_WIDTH-1:0] ExtB0_D7_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D0_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D1_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D2_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D3_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D4_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D5_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D6_in;                              
    input  [CP_WIDTH-1:0] ExtB1_D7_in;                              
                                                                    
    input                rst_n;                                     
    input                clk;                                       
                                                                    
    reg                ExtValid_reg0;                               
    reg                ExtValid_reg1;                               
    reg                ExtValid_reg2;                               
    reg                ExtValid_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D0_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D0_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D1_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D1_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D2_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D2_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D3_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D3_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D4_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D4_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D5_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D5_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D6_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D6_out;                                
    reg [CP_WIDTH-1:0] ExtB0_D7_d;                                
    reg [CP_WIDTH-1:0] ExtB0_D7_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D0_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D0_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D1_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D1_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D2_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D2_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D3_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D3_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D4_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D4_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D5_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D5_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D6_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D6_out;                                
    reg [CP_WIDTH-1:0] ExtB1_D7_d;                                
    reg [CP_WIDTH-1:0] ExtB1_D7_out;                                
                                                                    
                                                                    
                                                                    
    always@(posedge clk or negedge rst_n)begin                      
        if(~rst_n)begin                                             
            ExtValid_reg0     <= 1'b0    ;                          
            ExtValid_reg1     <= 1'b0    ;                          
            ExtValid_reg2     <= 1'b0    ;                          
            ExtValid_out      <= 1'b0    ;                          
            //                                                      
            ExtB0_D0_out      <= CP_ZERO  ;                          
            ExtB0_D1_out      <= CP_ZERO  ;                          
            ExtB0_D2_out      <= CP_ZERO  ;                          
            ExtB0_D3_out      <= CP_ZERO  ;                          
            ExtB0_D4_out      <= CP_ZERO  ;                          
            ExtB0_D5_out      <= CP_ZERO  ;                          
            ExtB0_D6_out      <= CP_ZERO  ;                          
            ExtB0_D7_out      <= CP_ZERO  ;                          
            ExtB1_D0_out      <= CP_ZERO  ;                          
            ExtB1_D1_out      <= CP_ZERO  ;                          
            ExtB1_D2_out      <= CP_ZERO  ;                          
            ExtB1_D3_out      <= CP_ZERO  ;                          
            ExtB1_D4_out      <= CP_ZERO  ;                          
            ExtB1_D5_out      <= CP_ZERO  ;                          
            ExtB1_D6_out      <= CP_ZERO  ;                          
            ExtB1_D7_out      <= CP_ZERO  ;                          
            ExtB0_D0_d      <= CP_ZERO  ;                          
            ExtB0_D1_d      <= CP_ZERO  ;                          
            ExtB0_D2_d      <= CP_ZERO  ;                          
            ExtB0_D3_d      <= CP_ZERO  ;                          
            ExtB0_D4_d      <= CP_ZERO  ;                          
            ExtB0_D5_d      <= CP_ZERO  ;                          
            ExtB0_D6_d      <= CP_ZERO  ;                          
            ExtB0_D7_d      <= CP_ZERO  ;                          
            ExtB1_D0_d      <= CP_ZERO  ;                          
            ExtB1_D1_d      <= CP_ZERO  ;                          
            ExtB1_D2_d      <= CP_ZERO  ;                          
            ExtB1_D3_d      <= CP_ZERO  ;                          
            ExtB1_D4_d      <= CP_ZERO  ;                          
            ExtB1_D5_d      <= CP_ZERO  ;                          
            ExtB1_D6_d      <= CP_ZERO  ;                          
            ExtB1_D7_d      <= CP_ZERO  ;                          
            //                                                      
        end                                                         
        else begin                                                  
            ExtValid_reg0     <= ExtValid_in     ;                  
            ExtValid_reg1     <= ExtValid_reg0   ;                  
            ExtValid_reg2     <= ExtValid_reg1   ;                  
            ExtValid_out      <= ExtValid_reg2   ;                  
            //                                                      
            ExtB0_D0_d        <= ExtB0_D0_in     ;                  
            ExtB0_D0_out      <= ExtB0_D0_d      ;                  
            ExtB0_D1_d        <= ExtB0_D1_in     ;                  
            ExtB0_D1_out      <= ExtB0_D1_d      ;                  
            ExtB0_D2_d        <= ExtB0_D2_in     ;                  
            ExtB0_D2_out      <= ExtB0_D2_d      ;                  
            ExtB0_D3_d        <= ExtB0_D3_in     ;                  
            ExtB0_D3_out      <= ExtB0_D3_d      ;                  
            ExtB0_D4_d        <= ExtB0_D4_in     ;                  
            ExtB0_D4_out      <= ExtB0_D4_d      ;                  
            ExtB0_D5_d        <= ExtB0_D5_in     ;                  
            ExtB0_D5_out      <= ExtB0_D5_d      ;                  
            ExtB0_D6_d        <= ExtB0_D6_in     ;                  
            ExtB0_D6_out      <= ExtB0_D6_d      ;                  
            ExtB0_D7_d        <= ExtB0_D7_in     ;                  
            ExtB0_D7_out      <= ExtB0_D7_d      ;                  
            ExtB1_D0_d        <= ExtB1_D0_in     ;                  
            ExtB1_D0_out      <= ExtB1_D0_d      ;                  
            ExtB1_D1_d        <= ExtB1_D1_in     ;                  
            ExtB1_D1_out      <= ExtB1_D1_d      ;                  
            ExtB1_D2_d        <= ExtB1_D2_in     ;                  
            ExtB1_D2_out      <= ExtB1_D2_d      ;                  
            ExtB1_D3_d        <= ExtB1_D3_in     ;                  
            ExtB1_D3_out      <= ExtB1_D3_d      ;                  
            ExtB1_D4_d        <= ExtB1_D4_in     ;                  
            ExtB1_D4_out      <= ExtB1_D4_d      ;                  
            ExtB1_D5_d        <= ExtB1_D5_in     ;                  
            ExtB1_D5_out      <= ExtB1_D5_d      ;                  
            ExtB1_D6_d        <= ExtB1_D6_in     ;                  
            ExtB1_D6_out      <= ExtB1_D6_d      ;                  
            ExtB1_D7_d        <= ExtB1_D7_in     ;                  
            ExtB1_D7_out      <= ExtB1_D7_d      ;                  
        end                                                         
    end                                                             
endmodule	                                                          
