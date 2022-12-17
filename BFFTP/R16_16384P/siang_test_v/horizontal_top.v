`timescale 1 ns/1 ps 

module horizontal_top (
    Mul0_S_out,
    Mul1_S_out,
    ROM0_w,
    ROM1_w,
    ROM2_w,
    ROM3_w,
    ROM4_w,
    ROM5_w,
    ROM6_w,
    ROM7_w,


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

    output [P_WIDTH-1:0]    Mul0_S_out   ;
    output [P_WIDTH-1:0]    Mul1_S_out   ;
    output                  ROM0_w  ;
    output [1:0]            ROM1_w  ;
    output [1:0]            ROM2_w  ;
    output [1:0]            ROM3_w  ;
    output [1:0]            ROM4_w  ;
    output [1:0]            ROM5_w  ;
    output [1:0]            ROM6_w  ;
    output [1:0]            ROM7_w  ;

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

    wire [P_WIDTH-1:0] horizon_row0_based;
    wire [P_WIDTH-1:0] horizon_row1_based;
    reg [1:0] cnt;
    reg [1:0] tf_order_cnt;
    reg CEN_delay;
    reg [3:0] group_cnt ;

    wire [P_WIDTH-1:0] fifo_out0;
    wire [P_WIDTH-1:0] fifo_out1;
    wire [P_WIDTH-1:0] fifo_out2;
    wire [P_WIDTH-1:0] fifo_out3;

    reg [P_WIDTH-1:0] A_in_mul_DifRom_row0;
    reg [P_WIDTH-1:0] A_in_mul_DifRom_row1;
    reg [P_WIDTH-1:0] Mul_DifRom_row0_out_delay1;
    reg [P_WIDTH-1:0] Mul_DifRom_row1_out_delay1;

    wire [P_WIDTH-1:0] Mul_DifRom_row0  ;
    wire [P_WIDTH-1:0] Mul_DifRom_row1  ;
    
    wire [P_WIDTH-1:0]   horizontal_ROM0 ;
    wire [P_WIDTH-1:0]   horizontal_ROM1 ;
    wire [P_WIDTH-1:0]   horizontal_ROM2 ;
    reg                  horizontal_en   ;
    wire                 ROM0_w          ;
    wire [1:0]           ROM1_w          ;
    wire [1:0]           ROM2_w          ;
    wire [1:0]           ROM3_w          ;
    wire [1:0]           ROM4_w          ;
    wire [1:0]           ROM5_w          ;
    wire [1:0]           ROM6_w          ;
    wire [1:0]           ROM7_w          ;

    reg [P_WIDTH-1:0] Mul_DifRom_const_row0 ;
    reg [P_WIDTH-1:0] Comp_DifRom_const_row0 ;

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
            horizontal_en <= 1'd0;
        end else begin
            if (stage_counter == 4'd0 && !CEN_delay) begin
                if (cnt == 2'd2) begin
                    horizontal_en <= 1'd1;
                end
            end else begin
                horizontal_en <= 1'd0;
            end
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            tf_order_cnt <= 2'd0;
        end else begin
            if (stage_counter == 4'd0) begin
                if (cnt == 2'd3) begin
                    tf_order_cnt <= tf_order_cnt + 2'd1;
                end else begin
                    tf_order_cnt <= tf_order_cnt;
                end
            end else begin
               tf_order_cnt <= 2'd0; 
            end
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            group_cnt <= 4'd0;
        end else begin
            if (stage_counter == 4'd0 && !CEN_delay) begin
                if (group_cnt == 4'd15) begin
                    group_cnt <= 4'd0;
                end else begin
                    group_cnt <= group_cnt + 4'd1;
                end
            end else begin
               group_cnt <= 4'd0; 
            end
        end
    end

    //--------------------------------
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            Mul_DifRom_row0_out_delay1 <= 64'd0;
            Mul_DifRom_row1_out_delay1 <= 64'd0;
        end else begin
            Mul_DifRom_row0_out_delay1 <= Mul_DifRom_row0;
            Mul_DifRom_row1_out_delay1 <= Mul_DifRom_row1;
        end
    end

    always @(*) begin
        if (tf_order_cnt > 0) begin
            A_in_mul_DifRom_row0 = Mul_DifRom_row0_out_delay1;
            A_in_mul_DifRom_row1 = Mul_DifRom_row1_out_delay1;
        end else begin
            A_in_mul_DifRom_row0 = horizon_row0_based;
            A_in_mul_DifRom_row1 = horizon_row1_based;
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            Comp_DifRom_const_row0 <= 64'd0;
        end else begin
            if (group_cnt == 4'd0 && !CEN_delay) begin
                Comp_DifRom_const_row0 <= A_in_mul_DifRom_row0;
            end
        end
    end
    
    always @(*) begin
        if (group_cnt == 4'd0) begin
            Mul_DifRom_const_row0 = A_in_mul_DifRom_row0;
        end else begin
            Mul_DifRom_const_row0 = Comp_DifRom_const_row0;
        end
    end

    MulMod128 Mul_DifRom0(
        .S_out(Mul_DifRom_row0),        
        .A_in(A_in_mul_DifRom_row0),              
        .B_in(Mul_DifRom_const_row0),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );

    MulMod128 Mul_DifRom1(
        .S_out(Mul_DifRom_row1),        
        .A_in(A_in_mul_DifRom_row1),              
        .B_in(Mul_DifRom_const_row0),     
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

        .horizontal_ROM0_in     (horizontal_ROM0_in)  ,
        .horizontal_ROM1_in     (horizontal_ROM1_in)  ,
        .horizontal_ROM2_in     (horizontal_ROM2_in)  ,
        .horizontal_ROM3_in     (horizontal_ROM3_in)  ,
        .horizontal_ROM4_in     (horizontal_ROM4_in)  ,
        .horizontal_ROM5_in     (horizontal_ROM5_in)  ,
        .horizontal_ROM6_in     (horizontal_ROM6_in)  ,
        .horizontal_ROM7_in     (horizontal_ROM7_in)  
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

    horizontal_tf_fly_row0 horizontal_tf_fly_row0(
        .Q             (horizon_row0_based),
        
        .rst_n         (rst_n),  
        .clk           (clk),  
        .state         (state),  
        .stage_counter (stage_counter) ,
        .CEN           (CEN)
    );

    horizontal_tf_fly_row1 horizontal_tf_fly_row1(
        .Q             (horizon_row1_based),
        
        .rst_n         (rst_n),  
        .clk           (clk),  
        .state         (state),  
        .stage_counter (stage_counter) ,
        .CEN           (CEN)
    );

    MulMod128 horizon_mul0(
        .S_out(Mul0_S_out),        
        .A_in(fifo_out0),              
        .B_in(A_in_mul_DifRom_row0),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );

    MulMod128 horizon_mul1(
        .S_out(Mul1_S_out),        
        .A_in(fifo_out1),              
        .B_in(A_in_mul_DifRom_row1),     
        .N_in(N_in),                 
        .rst_n(rst_n),                    
        .clk(clk)                        
    );

    horizontal_out_process horizontal_out_process(
        .horizontal_ROM0     (horizontal_ROM0),
        .horizontal_ROM1     (horizontal_ROM1),
        .horizontal_ROM2     (horizontal_ROM2),
        .ROM0_w              (ROM0_w         ),
        .ROM1_w              (ROM1_w         ),
        .ROM2_w              (ROM2_w         ),
        .ROM3_w              (ROM3_w         ),
        .ROM4_w              (ROM4_w         ),
        .ROM5_w              (ROM5_w         ),
        .ROM6_w              (ROM6_w         ),
        .ROM7_w              (ROM7_w         ),

        .horizontal_mul0_in  (Mul0_S_out        ),
        .horizontal_en_in    (horizontal_en     ),
        .clk                 (clk               ),
        .rst_n               (rst_n             )
    );
endmodule