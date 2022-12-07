 `timescale 1 ns/1 ps     

 module on_the_fly_pip(
    data_in,
    rst_n,
    clk,

    data_out
 );
    parameter P_WIDTH = 64;

    input [P_WIDTH-1:0] data_in;
    input rst_n;
    input clk;

    output reg [P_WIDTH-1:0] data_out;


    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            data_out <= 64'd0;
        end else begin
            data_out <= data_in;
        end
    end

endmodule