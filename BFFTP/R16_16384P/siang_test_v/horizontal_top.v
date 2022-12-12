`timescale 1 ns/1 ps 

module horizontal_top (
    S_out,


    horizontal_ROM0_in,
    horizontal_ROM1_in,
    horizontal_ROM2_in,
    horizontal_ROM3_in,
    horizontal_ROM4_in,
    horizontal_ROM5_in,
    horizontal_ROM6_in,
    horizontal_ROM7_in,

    rst_n,
    clk,
    state,
    stage_counter,
    CEN,
    N_in
);

    parameter S_WIDTH   = 4     ;  
    parameter P_WIDTH   = 64    ;  
    parameter SD_WIDTH  = 128   ;  
    parameter DC_WIDTH  = 13    ;
    parameter DCNT_BP4  = 10    ; 
    parameter ZERO = 64'd0;
    parameter W_1 = 64'h381d997f2d35d682 ;

    output [P_WIDTH-1:0] S_out;

    input [P_WIDTH-1:0]  horizontal_ROM0_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM1_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM2_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM3_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM4_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM5_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM6_in  ;
    input [SD_WIDTH-1:0] horizontal_ROM7_in  ;

    input clk;
    input rst_n;
    input [S_WIDTH-1:0] state;
    input [DC_WIDTH-1:DCNT_BP4] stage_counter;
    input CEN;
    input [P_WIDTH-1:0] N_in;

    wire [P_WIDTH-1:0] tf1     ;
    wire [P_WIDTH-1:0] tf2     ;
    wire [P_WIDTH-1:0] tf3     ;
    wire [P_WIDTH-1:0] tf4     ;
    wire [P_WIDTH-1:0] tf5     ;
    wire [P_WIDTH-1:0] tf6     ;
    wire [P_WIDTH-1:0] tf7     ;
    wire [P_WIDTH-1:0] tf8     ;
    wire [P_WIDTH-1:0] tf9     ;
    wire [P_WIDTH-1:0] tf10    ;
    wire [P_WIDTH-1:0] tf11    ;
    wire [P_WIDTH-1:0] tf12    ;
    wire [P_WIDTH-1:0] tf13    ;
    wire [P_WIDTH-1:0] tf14    ;
    wire [P_WIDTH-1:0] tf15    ;

    wire [P_WIDTH-1:0] siang_group_tf_fly_wire;
    reg [1:0] cnt;
    reg [1:0] tf_order_cnt;
    reg CEN_delay;

    wire [P_WIDTH-1:0] fifo_out0;
    wire [P_WIDTH-1:0] fifo_out1;
    wire [P_WIDTH-1:0] fifo_out2;
    wire [P_WIDTH-1:0] fifo_out3;

    wire [P_WIDTH-1:0] Q_DifRom_tf1  ;
    wire [P_WIDTH-1:0] Q_DifRom_tf5  ;
    wire [P_WIDTH-1:0] Q_DifRom_tf9  ;
    wire [P_WIDTH-1:0] Q_DifRom_tf13  ;

    reg [P_WIDTH-1:0] A_in_mul_DifRom1;
    reg [P_WIDTH-1:0] mul_DifRom_tf1_out_delay1;

    wire [P_WIDTH-1:0] mul_DifRom_tf1_out  ;


    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            CEN_delay <= 1'd1;
        end else begin
            CEN_delay <= CEN;
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            cnt <= 2'd0;
        end else begin
            if (stage_counter == 4'd0 && !CEN_delay) begin
                if (cnt == 2'd3) begin
                    cnt <= 2'd0;
                end else begin
                    cnt <= cnt + 2'd1;
                end
            end else begin
                cnt <= 2'd0;
            end
        end
    end
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            tf_order_cnt <= 2'd0;
        end else begin
            if (stage_counter == 4'd0) begin
                if (cnt == 2'd3 && !CEN) begin
                    tf_order_cnt <= tf_order_cnt + 2'd1;
                end else begin
                    tf_order_cnt <= tf_order_cnt;
                end
            end else begin
               tf_order_cnt <= 2'd0; 
            end
        end
    end

    //-----------
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            mul_DifRom_tf1_out_delay1 <= 64'd0;
        end else begin
            mul_DifRom_tf1_out_delay1 <= mul_DifRom_tf1_out;
        end
    end

    always @(*) begin
        if (tf_order_cnt > 0) begin
            A_in_mul_DifRom1 = mul_DifRom_tf1_out_delay1;
        end else begin
            A_in_mul_DifRom1 = Q_DifRom_tf1;
        end
    end

    DifRom_tf_const DifRom_tf_const(
        .Q_DifRom_tf1   (Q_DifRom_tf1 )  ,
        .Q_DifRom_tf5   (Q_DifRom_tf5 )  ,
        .Q_DifRom_tf9   (Q_DifRom_tf9 )  ,
        .Q_DifRom_tf13  (Q_DifRom_tf13)  ,
        .rst_n          (rst_n        )  ,
        .clk            (clk          )  ,
        .stage_counter  (stage_counter)  ,
        .CEN            (CEN          )  
    );

    MulMod128 mul_DifRom1(
        .S_out(mul_DifRom_tf1_out),        
        .A_in(A_in_mul_DifRom1),              
        .B_in(W_1),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );
    
    //----------------
    horizontal_Mux3 horizontal_Mux3(
        .horizontal_tf1_output  (tf1 )  ,
        .horizontal_tf2_output  (tf2 )  ,
        .horizontal_tf3_output  (tf3 )  ,
        .horizontal_tf4_output  (tf4 )  ,
        .horizontal_tf5_output  (tf5 )  ,
        .horizontal_tf6_output  (tf6 )  ,
        .horizontal_tf7_output  (tf7 )  ,
        .horizontal_tf8_output  (tf8 )  ,
        .horizontal_tf9_output  (tf9 )  ,
        .horizontal_tf10_output (tf10)  ,
        .horizontal_tf11_output (tf11)  ,
        .horizontal_tf12_output (tf12)  ,
        .horizontal_tf13_output (tf13)  ,
        .horizontal_tf14_output (tf14)  ,
        .horizontal_tf15_output (tf15)  ,

        .horizontal_ROM0_in    (horizontal_ROM0_in)  ,
        .horizontal_ROM1_in    (horizontal_ROM1_in)  ,
        .horizontal_ROM2_in    (horizontal_ROM2_in)  ,
        .horizontal_ROM3_in    (horizontal_ROM3_in)  ,
        .horizontal_ROM4_in    (horizontal_ROM4_in)  ,
        .horizontal_ROM5_in    (horizontal_ROM5_in)  ,
        .horizontal_ROM6_in    (horizontal_ROM6_in)  ,
        .horizontal_ROM7_in    (horizontal_ROM7_in)  
    );

    horizontal_fifo horizontal_fifo0(
        .fifo_out   (fifo_out0),

        .data_in_delay0     (tf1),
        .data_in_delay4     (tf2),
        .data_in_delay8     (tf3),
        .data_in_delay12    (tf4),
        .mode       (tf_order_cnt), 
        .clk        (clk),
        .rst_n      (rst_n)
    );

    horizontal_fifo horizontal_fifo1(
        .fifo_out   (fifo_out1),

        .data_in_delay0     (tf5),
        .data_in_delay4     (tf6),
        .data_in_delay8     (tf7),
        .data_in_delay12    (tf8),
        .mode       (tf_order_cnt), 
        .clk        (clk),
        .rst_n      (rst_n)
    );

    horizontal_fifo horizontal_fifo2(
        .fifo_out   (fifo_out2),

        .data_in_delay0     (tf9),
        .data_in_delay4     (tf10),
        .data_in_delay8     (tf11),
        .data_in_delay12    (tf12),
        .mode       (tf_order_cnt), 
        .clk        (clk),
        .rst_n      (rst_n)
    );

    horizontal_fifo horizontal_fifo3(
        .fifo_out   (fifo_out3),

        .data_in_delay0     (tf13),
        .data_in_delay4     (tf14),
        .data_in_delay8     (tf15),
        .data_in_delay12    (ZERO),
        .mode       (tf_order_cnt), 
        .clk        (clk),
        .rst_n      (rst_n)
    );

    horizontal_tf_fly horizontal_tf_fly0(
        .Q             (siang_group_tf_fly_wire),
        
        .rst_n         (rst_n),  
        .clk           (clk),  
        .state         (state),  
        .stage_counter (stage_counter) ,
        .CEN           (CEN)
    );

    MulMod128 mul_group_tf_fly0(
        .S_out(S_out),        
        .A_in(fifo_out0),              
        .B_in(A_in_mul_DifRom1),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );
endmodule