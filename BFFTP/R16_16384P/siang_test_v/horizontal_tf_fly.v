`timescale 1 ns/1 ps     

module horizontal_tf_fly(
    Q,

    rst_n,
    clk,
    state,
    stage_counter,
    CEN
) ;

parameter S_WIDTH   = 4 ; 
parameter P_WIDTH     = 64 ;
parameter SC_WIDTH    = 3; 

output reg [P_WIDTH-1:0] Q;
input                   rst_n           ;
input                   clk             ;
input [S_WIDTH-1:0]     state           ;
input [SC_WIDTH-1:0]    stage_counter   ; 
input                   CEN             ;

reg [P_WIDTH-1:0] factor_diff [0:63];
reg [3:0] cnt;
reg [5:0] factor_diff_idx;


always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        factor_diff[0] <= 64'h0000000000000001 ;
        factor_diff[1] <= 64'h381d997f2d35d682 ;
        factor_diff[2] <= 64'h7de340fb66a3942d ;
        factor_diff[3] <= 64'hca333ad173fb5e07 ;
        factor_diff[4] <= 64'hc26241d7d497e9b7 ;
        factor_diff[5] <= 64'h381d997f2d35d682 ;
        factor_diff[6] <= 64'h0660fb30268dc6a7 ;
        factor_diff[7] <= 64'hca333ad173fb5e07 ;
        factor_diff[8] <= 64'hd0e5c71177433cdc ;
        factor_diff[9] <= 64'h381d997f2d35d682 ;
        factor_diff[10] <= 64'h7de340fb66a3942d ;
        factor_diff[11] <= 64'hca333ad173fb5e07 ;
        factor_diff[12] <= 64'hec27626a65910c21 ;
        factor_diff[13] <= 64'h381d997f2d35d682 ;
        factor_diff[14] <= 64'h0660fb30268dc6a7 ;
        factor_diff[15] <= 64'hca333ad173fb5e07 ;
        factor_diff[16] <= 64'h1a8c7b40a550e18a ;
        factor_diff[17] <= 64'h381d997f2d35d682 ;
        factor_diff[18] <= 64'h7de340fb66a3942d ;
        factor_diff[19] <= 64'hca333ad173fb5e07 ;
        factor_diff[20] <= 64'hc26241d7d497e9b7 ;
        factor_diff[21] <= 64'h381d997f2d35d682 ;
        factor_diff[22] <= 64'h0660fb30268dc6a7 ;
        factor_diff[23] <= 64'hca333ad173fb5e07 ;
        factor_diff[24] <= 64'h2945179da0987634 ;
        factor_diff[25] <= 64'h381d997f2d35d682 ;
        factor_diff[26] <= 64'h7de340fb66a3942d ;
        factor_diff[27] <= 64'hca333ad173fb5e07 ;
        factor_diff[28] <= 64'hec27626a65910c21 ;
        factor_diff[29] <= 64'h381d997f2d35d682 ;
        factor_diff[30] <= 64'h0660fb30268dc6a7 ;
        factor_diff[31] <= 64'hca333ad173fb5e07 ;
        factor_diff[32] <= 64'hae7d2abe72929acf ;
        factor_diff[33] <= 64'h381d997f2d35d682 ;
        factor_diff[34] <= 64'h7de340fb66a3942d ;
        factor_diff[35] <= 64'hca333ad173fb5e07 ;
        factor_diff[36] <= 64'hc26241d7d497e9b7 ;
        factor_diff[37] <= 64'h381d997f2d35d682 ;
        factor_diff[38] <= 64'h0660fb30268dc6a7 ;
        factor_diff[39] <= 64'hca333ad173fb5e07 ;
        factor_diff[40] <= 64'hd0e5c71177433cdc ;
        factor_diff[41] <= 64'h381d997f2d35d682 ;
        factor_diff[42] <= 64'h7de340fb66a3942d ;
        factor_diff[43] <= 64'hca333ad173fb5e07 ;
        factor_diff[44] <= 64'hec27626a65910c21 ;
        factor_diff[45] <= 64'h381d997f2d35d682 ;
        factor_diff[46] <= 64'h0660fb30268dc6a7 ;
        factor_diff[47] <= 64'hca333ad173fb5e07 ;
        factor_diff[48] <= 64'h5f9c5e4b5315aa64 ;
        factor_diff[49] <= 64'h381d997f2d35d682 ;
        factor_diff[50] <= 64'h7de340fb66a3942d ;
        factor_diff[51] <= 64'hca333ad173fb5e07 ;
        factor_diff[52] <= 64'hc26241d7d497e9b7 ;
        factor_diff[53] <= 64'h381d997f2d35d682 ;
        factor_diff[54] <= 64'h0660fb30268dc6a7 ;
        factor_diff[55] <= 64'hca333ad173fb5e07 ;
        factor_diff[56] <= 64'h2945179da0987634 ;
        factor_diff[57] <= 64'h381d997f2d35d682 ;
        factor_diff[58] <= 64'h7de340fb66a3942d ;
        factor_diff[59] <= 64'hca333ad173fb5e07 ;
        factor_diff[60] <= 64'hec27626a65910c21 ;
        factor_diff[61] <= 64'h381d997f2d35d682 ;
        factor_diff[62] <= 64'h0660fb30268dc6a7 ;
        factor_diff[63] <= 64'hca333ad173fb5e07 ;
    end 
end


always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        cnt <= 4'd0;
    end else begin
        if (~CEN) begin
            if (stage_counter == 3'd0) begin
                if (cnt == 4'd15) begin
                    cnt <= 4'd0;
                end else begin
                    cnt <= cnt + 4'd1;
                end
            end
        end
    end
end

always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        factor_diff_idx <= 6'd1;
    end else begin
        if (cnt == 4'd7) begin
            factor_diff_idx <= factor_diff_idx + 6'd1;
        end else begin
            factor_diff_idx <= factor_diff_idx;
        end
    end
end

always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        Q <= 64'd0;
    end else begin
        if (~CEN) begin
           if (cnt >= 4'd0 && cnt <= 4'd3) begin
                Q <= factor_diff[factor_diff_idx];
            end else begin
                Q <= 64'd0;
            end 
        end
    end
end

endmodule