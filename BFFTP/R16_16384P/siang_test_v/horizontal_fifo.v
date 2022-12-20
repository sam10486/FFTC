`timescale 1 ns/1 ps

module horizontal_fifo (
    fifo_out,

    data_in_delay0,
    data_in_delay4,
    data_in_delay8,
    data_in_delay12,
    mode, 
    clk,
    rst_n
);

    parameter P_WIDTH   = 64    ;  
    

    output reg [P_WIDTH-1:0] fifo_out;
    input [P_WIDTH-1:0] data_in_delay0;
    input [P_WIDTH-1:0] data_in_delay4;
    input [P_WIDTH-1:0] data_in_delay8;
    input [P_WIDTH-1:0] data_in_delay12;
    input [1:0] mode; // 0: dealy 0, 1:dealy 4, 2:dealy8, 3:delay12
    input clk;
    input rst_n;
    reg [P_WIDTH-1:0] fifo_array_4 [0:4]; 
    reg [P_WIDTH-1:0] fifo_array_8 [0:8]; 
    reg [P_WIDTH-1:0] fifo_array_12 [0:12]; 

    always @(*) begin
        fifo_array_12[0] = data_in_delay12;
        fifo_array_8[0] = data_in_delay8;
        fifo_array_4[0] = data_in_delay4;
    end

    integer i ;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 12 ; i = i + 1) begin
                fifo_array_12[i+1] <= 64'd0;
            end
            for (i = 0; i < 8 ; i = i + 1) begin
                fifo_array_8[i+1] <= 64'd0;
            end
            for (i = 0; i < 4 ; i = i + 1) begin
                fifo_array_4[i+1] <= 64'd0;
            end
        end else begin
            for (i = 0; i < 12 ; i = i + 1) begin
                fifo_array_12[i+1] <= fifo_array_12[i];
            end
            for (i = 0; i < 8 ; i = i + 1) begin
                fifo_array_8[i+1] <= fifo_array_8[i];
            end
            for (i = 0; i < 4; i = i + 1) begin
                fifo_array_4[i+1] <= fifo_array_4[i];
            end
        end
    end   

    always @(*) begin
        case (mode)
            2'd0: fifo_out = data_in_delay0;
            2'd1: fifo_out = fifo_array_4[4];
            2'd2: fifo_out = fifo_array_8[8];
            2'd3: fifo_out = fifo_array_12[12];
            //default: fifo_out = 64'd0;
        endcase
    end
endmodule