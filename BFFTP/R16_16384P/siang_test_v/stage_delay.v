`timescale 1 ns/1 ps   

module stage_delay (
    clk,
    rst_n,
    state,
    stage,

    stage_delay_out

);

    parameter SC_WIDTH    = 3; 
    parameter S_WIDTH   = 4 ;

    input clk;
    input rst_n;
    input [S_WIDTH-1:0] state;
    input [SC_WIDTH-1:0] stage;

    output reg [SC_WIDTH-1:0] stage_delay_out;

    reg [5:0] cnt;


    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 6'd0;
        end else begin
            if (state == 4'd5 || state == 4'd6) begin
                if (cnt == 6'd55) begin
                    cnt <= cnt;
                end else begin
                    cnt <= cnt + 6'd1;
                end
            end else begin
                cnt <= 6'd0;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            stage_delay_out <= 3'd0;
        end else begin
            if (cnt == 6'd55) begin
                stage_delay_out <= stage;
            end
        end
    end

endmodule