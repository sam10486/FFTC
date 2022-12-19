`timescale 1 ns/1 ps 

module horizontal_out_process (
    horizontal_ROM0     ,
    horizontal_ROM1     ,
    horizontal_ROM2     ,
    ROM0_w              ,
    ROM1_w              ,
    ROM2_w              ,
    ROM3_w              ,
    ROM4_w              ,
    ROM5_w              ,
    ROM6_w              ,
    ROM7_w              ,

    horizontal_mul0_in  ,
    horizontal_mul1_in  ,
    horizontal_en_in    ,
    clk                 ,
    rst_n
);
    
    parameter S_WIDTH   = 4     ;  
    parameter P_WIDTH   = 64    ;  
    parameter SD_WIDTH  = 128   ;  
    parameter DC_WIDTH  = 13    ;
    parameter DCNT_BP4  = 10    ; 
    parameter ZERO = 64'd0;

    output [P_WIDTH-1:0] horizontal_ROM0    ;
    output [P_WIDTH-1:0] horizontal_ROM1    ;
    output reg [P_WIDTH-1:0] horizontal_ROM2    ;
    output reg           ROM0_w             ;
    output reg [1:0]     ROM1_w             ;
    output reg [1:0]     ROM2_w             ;
    output reg [1:0]     ROM3_w             ;
    output reg [1:0]     ROM4_w             ;
    output reg [1:0]     ROM5_w             ;
    output reg [1:0]     ROM6_w             ;
    output reg [1:0]     ROM7_w             ;

    input [P_WIDTH-1:0] horizontal_mul0_in  ;
    input [P_WIDTH-1:0] horizontal_mul1_in  ;
    input               horizontal_en_in    ;
    input               clk                 ;
    input               rst_n               ;

    reg [3:0]           cnt                             ;
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            cnt <= 4'd0;
        end else begin
            if (horizontal_en_in) begin
                if (cnt == 4'd15) begin
                    cnt <= 4'd0;
                end else begin
                    cnt <= cnt + 4'd1;
                end
            end else begin
                cnt <= 4'd0;
            end
        end
    end

    assign horizontal_ROM0 = (cnt >= 4'd0 && cnt <= 4'd3)   ? horizontal_mul0_in : 64'd0    ;
    assign horizontal_ROM1 = (cnt >= 4'd4 && cnt <= 4'd11)  ? horizontal_mul0_in : 64'd0    ;
    // ROM2
    always @(*) begin
        case (ROM2_w)
            2'd1: begin
                if (cnt >= 4'd12 && cnt <= 4'd15)   horizontal_ROM2 = horizontal_mul0_in;
                else                                horizontal_ROM2 = 64'd0;
            end
            2'd2: begin
                if (cnt >= 4'd0 && cnt <= 4'd3)     horizontal_ROM2 = horizontal_mul1_in;
                else                                horizontal_ROM2 = 64'd0;
            end 
            default: horizontal_ROM2 = 64'd0;
        endcase
    end

    always @(*) begin
        if (horizontal_en_in) begin
            if (cnt >= 4'd0 && cnt <= 4'd3) begin
                ROM0_w = 1'd1;
                ROM1_w = 2'd0;
                ROM2_w = 2'd2;
                ROM3_w = 2'd0;
                ROM4_w = 2'd2;
                ROM5_w = 2'd0;
                ROM6_w = 2'd2;
                ROM7_w = 2'd0;
            end else if (cnt >= 4'd4 && cnt <= 4'd7) begin
                ROM0_w = 1'd0;
                ROM1_w = 2'd1;
                ROM2_w = 2'd0;
                ROM3_w = 2'd1;
                ROM4_w = 2'd0;
                ROM5_w = 2'd1;
                ROM6_w = 2'd0;
                ROM7_w = 2'd1;
            end else if (cnt >= 4'd8 && cnt <= 4'd11) begin
                ROM0_w = 1'd0;
                ROM1_w = 2'd2;
                ROM2_w = 2'd0;
                ROM3_w = 2'd2;
                ROM4_w = 2'd0;
                ROM5_w = 2'd2;
                ROM6_w = 2'd0;
                ROM7_w = 2'd2;
            end else begin
                ROM0_w = 1'd0;
                ROM1_w = 2'd0;
                ROM2_w = 2'd1;
                ROM3_w = 2'd0;
                ROM4_w = 2'd1;
                ROM5_w = 2'd0;
                ROM6_w = 2'd1;
                ROM7_w = 2'd0;
            end
        end else begin
            ROM0_w = 1'd0;
            ROM1_w = 2'd0;
            ROM2_w = 2'd0;
            ROM3_w = 2'd0;
            ROM4_w = 2'd0;
            ROM5_w = 2'd0;
            ROM6_w = 2'd0;
            ROM7_w = 2'd0;
        end
    end

endmodule