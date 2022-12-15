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

reg [P_WIDTH-1:0] horizontal_factor [0:63];
reg [3:0] cnt;
reg [5:0] horizontal_factor_idx;


always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        horizontal_factor[0] <= 64'h0000000000000001 ; // don't work
        horizontal_factor[1] <= 64'h381d997f2d35d682 ;
        horizontal_factor[2] <= 64'h7de340fb66a3942d ;
        horizontal_factor[3] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[4] <= 64'hc26241d7d497e9b7 ;
        horizontal_factor[5] <= 64'h381d997f2d35d682 ;
        horizontal_factor[6] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[7] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[8] <= 64'hd0e5c71177433cdc ;
        horizontal_factor[9] <= 64'h381d997f2d35d682 ;
        horizontal_factor[10] <= 64'h7de340fb66a3942d ;
        horizontal_factor[11] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[12] <= 64'hec27626a65910c21 ;
        horizontal_factor[13] <= 64'h381d997f2d35d682 ;
        horizontal_factor[14] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[15] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[16] <= 64'h1a8c7b40a550e18a ;
        horizontal_factor[17] <= 64'h381d997f2d35d682 ;
        horizontal_factor[18] <= 64'h7de340fb66a3942d ;
        horizontal_factor[19] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[20] <= 64'hc26241d7d497e9b7 ;
        horizontal_factor[21] <= 64'h381d997f2d35d682 ;
        horizontal_factor[22] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[23] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[24] <= 64'h2945179da0987634 ;
        horizontal_factor[25] <= 64'h381d997f2d35d682 ;
        horizontal_factor[26] <= 64'h7de340fb66a3942d ;
        horizontal_factor[27] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[28] <= 64'hec27626a65910c21 ;
        horizontal_factor[29] <= 64'h381d997f2d35d682 ;
        horizontal_factor[30] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[31] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[32] <= 64'hae7d2abe72929acf ;
        horizontal_factor[33] <= 64'h381d997f2d35d682 ;
        horizontal_factor[34] <= 64'h7de340fb66a3942d ;
        horizontal_factor[35] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[36] <= 64'hc26241d7d497e9b7 ;
        horizontal_factor[37] <= 64'h381d997f2d35d682 ;
        horizontal_factor[38] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[39] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[40] <= 64'hd0e5c71177433cdc ;
        horizontal_factor[41] <= 64'h381d997f2d35d682 ;
        horizontal_factor[42] <= 64'h7de340fb66a3942d ;
        horizontal_factor[43] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[44] <= 64'hec27626a65910c21 ;
        horizontal_factor[45] <= 64'h381d997f2d35d682 ;
        horizontal_factor[46] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[47] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[48] <= 64'h5f9c5e4b5315aa64 ;
        horizontal_factor[49] <= 64'h381d997f2d35d682 ;
        horizontal_factor[50] <= 64'h7de340fb66a3942d ;
        horizontal_factor[51] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[52] <= 64'hc26241d7d497e9b7 ;
        horizontal_factor[53] <= 64'h381d997f2d35d682 ;
        horizontal_factor[54] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[55] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[56] <= 64'h2945179da0987634 ;
        horizontal_factor[57] <= 64'h381d997f2d35d682 ;
        horizontal_factor[58] <= 64'h7de340fb66a3942d ;
        horizontal_factor[59] <= 64'hca333ad173fb5e07 ;
        horizontal_factor[60] <= 64'hec27626a65910c21 ;
        horizontal_factor[61] <= 64'h381d997f2d35d682 ;
        horizontal_factor[62] <= 64'h0660fb30268dc6a7 ;
        horizontal_factor[63] <= 64'hca333ad173fb5e07 ;
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
        horizontal_factor_idx <= 6'd1;
    end else begin
        if (cnt == 4'd15) begin
            horizontal_factor_idx <= horizontal_factor_idx + 6'd1;
        end else begin
            horizontal_factor_idx <= horizontal_factor_idx;
        end
    end
end

always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        Q <= 64'd0;
    end else begin
        if (~CEN) begin
           //if (cnt >= 4'd0 && cnt <= 4'd3) begin
                Q <= horizontal_factor[horizontal_factor_idx];
            //end else begin
            //    Q <= 64'd0;
            //end 
        end
    end
end

endmodule