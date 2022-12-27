`timescale 1 ns/1 ps 

module delay_buffer (
    data_out,
    
    clk,
    rst_n,
    data_in
);

    parameter P_WIDTH   = 64    ;  
    
    output reg [P_WIDTH-1:0] data_out;

    input clk;
    input rst_n;
    input [P_WIDTH-1:0] data_in;
    
    reg [P_WIDTH-1:0] buffer_array [0:3]; 

    always @(*) begin
        buffer_array[0] = data_in;
    end

    integer i ;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 3 ; i = i + 1) begin
                buffer_array[i+1] <= 64'd0;
            end 
        end else begin
            for (i = 0; i < 3 ; i = i + 1) begin
                buffer_array[i+1] <= buffer_array[i];
            end
        end
    end

    always @(*) begin
        data_out = buffer_array[3];
    end
endmodule