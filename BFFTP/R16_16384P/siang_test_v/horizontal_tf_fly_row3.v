`timescale 1 ns/1 ps     

module horizontal_tf_fly_row3(
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


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        horizontal_factor[0] <= 64'h0000000000000001 ; // don't work
        horizontal_factor[1] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[2] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[3] <= 64'hb85da29d03198d33 ;
        horizontal_factor[4] <= 64'h2d3e749c32068452 ;
        horizontal_factor[5] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[6] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[7] <= 64'hb85da29d03198d33 ;
        horizontal_factor[8] <= 64'h6fb69219dde133b9 ;
        horizontal_factor[9] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[10] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[11] <= 64'hb85da29d03198d33 ;
        horizontal_factor[12] <= 64'h401ad1288bb80f1a ;
        horizontal_factor[13] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[14] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[15] <= 64'hb85da29d03198d33 ;
        horizontal_factor[16] <= 64'h6ce8024cb0531c09 ;
        horizontal_factor[17] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[18] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[19] <= 64'hb85da29d03198d33 ;
        horizontal_factor[20] <= 64'h2d3e749c32068452 ;
        horizontal_factor[21] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[22] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[23] <= 64'hb85da29d03198d33 ;
        horizontal_factor[24] <= 64'hfcb23459753affc3 ;
        horizontal_factor[25] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[26] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[27] <= 64'hb85da29d03198d33 ;
        horizontal_factor[28] <= 64'h401ad1288bb80f1a ;
        horizontal_factor[29] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[30] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[31] <= 64'hb85da29d03198d33 ;
        horizontal_factor[32] <= 64'hbf562ae382c86418 ;
        horizontal_factor[33] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[34] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[35] <= 64'hb85da29d03198d33 ;
        horizontal_factor[36] <= 64'h2d3e749c32068452 ;
        horizontal_factor[37] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[38] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[39] <= 64'hb85da29d03198d33 ;
        horizontal_factor[40] <= 64'h6fb69219dde133b9 ;
        horizontal_factor[41] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[42] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[43] <= 64'hb85da29d03198d33 ;
        horizontal_factor[44] <= 64'h401ad1288bb80f1a ;
        horizontal_factor[45] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[46] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[47] <= 64'hb85da29d03198d33 ;
        horizontal_factor[48] <= 64'h39afad6c328b16f6 ;
        horizontal_factor[49] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[50] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[51] <= 64'hb85da29d03198d33 ;
        horizontal_factor[52] <= 64'h2d3e749c32068452 ;
        horizontal_factor[53] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[54] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[55] <= 64'hb85da29d03198d33 ;
        horizontal_factor[56] <= 64'hfcb23459753affc3 ;
        horizontal_factor[57] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[58] <= 64'hf3dd150bf2cea5ad ;
        horizontal_factor[59] <= 64'hb85da29d03198d33 ;
        horizontal_factor[60] <= 64'h401ad1288bb80f1a ;
        horizontal_factor[61] <= 64'h75c91fcd00f90ea6 ;
        horizontal_factor[62] <= 64'h4cf76c2c4d3c6865 ;
        horizontal_factor[63] <= 64'hb85da29d03198d33 ;
    end 
end


always @(posedge clk or negedge rst_n) begin
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

always @(posedge clk or negedge rst_n) begin
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

always @(posedge clk or negedge rst_n) begin
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