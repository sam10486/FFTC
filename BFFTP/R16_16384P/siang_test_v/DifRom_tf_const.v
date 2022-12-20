`timescale 1 ns/1 ps    


module DifRom_tf_const (
    Q_DifRom_tf1,
    Q_DifRom_tf5,
    Q_DifRom_tf9,
    Q_DifRom_tf13,

    rst_n,
    clk,
    stage_counter,
    CEN
);

    parameter S_WIDTH   = 4 ; 
    parameter P_WIDTH     = 64 ;
    parameter SC_WIDTH    = 3; 

    output reg [P_WIDTH-1:0] Q_DifRom_tf1;
    output reg [P_WIDTH-1:0] Q_DifRom_tf5;
    output reg [P_WIDTH-1:0] Q_DifRom_tf9;
    output reg [P_WIDTH-1:0] Q_DifRom_tf13;
    input                   rst_n           ;
    input                   clk             ;
    input [SC_WIDTH-1:0]    stage_counter   ; 
    input                   CEN             ;

    reg [P_WIDTH-1:0] DifRom_tf_const [0:3];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            DifRom_tf_const[0] <= 64'h381d997f2d35d682 ;
            DifRom_tf_const[1] <= 64'h252502e45f699196 ;
            DifRom_tf_const[2] <= 64'h4a3f9ccc62d9a86a ;
            DifRom_tf_const[3] <= 64'h75c91fcd00f90ea6 ;
        end else begin
            if (~CEN) begin
                if (stage_counter == 3'd0) begin
                    Q_DifRom_tf1    <=  DifRom_tf_const[0]  ;
                    Q_DifRom_tf5    <=  DifRom_tf_const[1]  ;
                    Q_DifRom_tf9    <=  DifRom_tf_const[2]  ;
                    Q_DifRom_tf13   <=  DifRom_tf_const[3]  ;
                end
            end
        end
    end
  
endmodule