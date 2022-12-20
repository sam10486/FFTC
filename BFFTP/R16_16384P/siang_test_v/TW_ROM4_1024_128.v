 `timescale 1 ns/1 ps     

 module TW_ROM4_1024_128(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,
   horizontal_data_in,
   ROM4_w,

   Q,
   Q_const
 );
   parameter                  SC_WIDTH    = 3;
   parameter                  P_WIDTH     = 128 ; 	
   parameter                  stage_num = 4;
   parameter                  ROMA_WIDTH  = 10;
   parameter                  init_store_data = 4;
   parameter                  group_stage0 = 64;
   parameter                  group_stage1 = 4;
   parameter S_WIDTH   = 4 ; 
   parameter                  SEG1  = 64 ;                                                                     
   parameter                  SEG2  = 128 ; 
   parameter                  horizontal_DW = 64;

   input [SC_WIDTH-1:0]       stage_counter        ; 
   input                      rst_n                ;      
   input                      CLK                  ;
   input                      CEN                  ;
   input [S_WIDTH-1:0]        state                ;
   input [horizontal_DW-1:0]        horizontal_data_in     ;
   input [1:0]                      ROM4_w               ;
   output reg [P_WIDTH-1:0] Q     ;
   output reg [P_WIDTH-1:0] Q_const     ;
     
   reg [P_WIDTH-1:0] buf_data_stage0 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage1 [0:group_stage1-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage2 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_const [0:stage_num-1];      
   reg [3:0] cnt_0;
   reg [3:0] cnt_1;
   reg [1:0] cnt_2;

   reg [1:0] horizontal_cnt;
   reg [1:0] horizontal_cnt_delay;
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;

   reg [P_WIDTH-1:0] Q_Mux;
   reg [horizontal_DW-1:0] horizontal_row1_in_delay;
   reg [horizontal_DW-1:0] horizontal_row2_in_delay;

   reg [1:0] ROM4_w_delay;
   reg [1:0] ROM4_w_dealy_fifo [0:12];
   reg [horizontal_DW-1:0] horizontal_row2_in_delay_fifo [0:12];


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0]   <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[1]   <= 128'hfffffffeffffffc1_52ca810d84ba33e7    ; // BC=64
         buf_data_stage0[2]   <= 128'h0000000000001000_dfffffff00002001    ; // BC=128
         buf_data_stage0[3]   <= 128'hfffffffefffc0001_bf8a7473016d6c46    ; // BC=192
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'hfffffffeffffffc1_52ca810d84ba33e7; // BC=64
         buf_data_stage1[0][2] <= 128'h0000000000001000_dfffffff00002001; // BC=128
         buf_data_stage1[0][3] <= 128'hfffffffefffc0001_bf8a7473016d6c46; // BC=192

         buf_data_stage1[1][0] <= 128'hfffdffff00000003_7b83abdf412342cf; // BC=16
         buf_data_stage1[1][1] <= 128'h007fffffffffff80_c5ff6cb7eb38fddc;
         buf_data_stage1[1][2] <= 128'hdfffffff00002001_ad578f3a5feeae66;
         buf_data_stage1[1][3] <= 128'h00000007fff7fff8_702ff66b35e27493;
         buf_data_stage1[2][0] <= 128'hffeffffefffffff1_59428f55043e67bb; // BC=32
         buf_data_stage1[2][1] <= 128'h0400000000000400_c5e4bb2a5aa63a07;
         buf_data_stage1[2][2] <= 128'hfffffffdffff0002_5162deb878a773ba;
         buf_data_stage1[2][3] <= 128'h00000040003fffc0_6c109cd02b5225ea;
         buf_data_stage1[3][0] <= 128'hfff7ffff00000001_d3946b6a55f9087f; // BC=48
         buf_data_stage1[3][1] <= 128'h0200000000000000_60db79e8cc72fe5b;
         buf_data_stage1[3][2] <= 128'h7fffffff00000001_62ae44218641740b;
         buf_data_stage1[3][3] <= 128'h0000001fffffffe0_f5aec5dd857522ee;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'h0000000001000000_fffff7ff00000801; // BC=64
         buf_data_stage2[2] <= 128'h0001000000000000_ffbfffff00000001; // BC=128
         buf_data_stage2[3] <= 128'h000000ffffffff00_fffffffd00000001; // BC=192
      end else begin
         case (ROM4_w_delay)
            2'd1: buf_data_stage0[horizontal_cnt_delay][SEG2-1:SEG1] <= horizontal_row1_in_delay;
            2'd2: buf_data_stage0[horizontal_cnt_delay][SEG1-1:0] <= horizontal_row2_in_delay;
            default: buf_data_stage0[horizontal_cnt_delay] <= buf_data_stage0[horizontal_cnt_delay];
         endcase
      end
   end


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         Q_Mux <= 128'd0;
      end else begin
         if (~CEN) begin
            case (stage_counter)
               3'd0: begin
                  case (cnt_0)
                     2'd0: Q_Mux <= buf_data_stage0[0];
                     2'd1: Q_Mux <= buf_data_stage0[1];
                     2'd2: Q_Mux <= buf_data_stage0[2];
                     2'd3: Q_Mux <= buf_data_stage0[3];
                     //default: Q_Mux <= 128'd0;
                  endcase
               end
               3'd1: begin
                  case (cnt_1)
                     2'd0: Q_Mux <= buf_data_stage1[stage1_group_th][0];
                     2'd1: Q_Mux <= buf_data_stage1[stage1_group_th][1];
                     2'd2: Q_Mux <= buf_data_stage1[stage1_group_th][2];
                     2'd3: Q_Mux <= buf_data_stage1[stage1_group_th][3];
                     //default: Q_Mux <= 128'd0;
                  endcase
               end
               3'd2: begin
                  case (cnt_2)
                     2'd0: Q_Mux <= buf_data_stage2[0];
                     2'd1: Q_Mux <= buf_data_stage2[1];
                     2'd2: Q_Mux <= buf_data_stage2[2];
                     2'd3: Q_Mux <= buf_data_stage2[3];
                     //default: Q_Mux <= 128'd0;
                  endcase
               end 
               default: Q_Mux <= 128'h1_0000000000000001;
            endcase
         end else begin
            Q_Mux <= 128'h1_0000000000000001;
         end
      end
   end

   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         cnt_0 <= 4'd0;
         cnt_1 <= 4'd0;
         cnt_2 <= 2'd0;
      end else begin
         if (~CEN) begin
            case (stage_counter)
               3'd0: begin
                  if (cnt_0 == 4'd15) begin
                     cnt_0 <= 4'd0;
                  end else begin
                     cnt_0 <= cnt_0 + 4'd1;
                  end
               end
               3'd1: begin
                  if (cnt_1 == 4'd15) begin
                     cnt_1 <= 4'd0;
                  end else begin
                     if (state == 4'd4 || state == 4'd6) begin
                        cnt_1 <= cnt_1 + 4'd1;
                     end else begin
                        cnt_1 <= 4'd0;
                     end
                  end
               end
               3'd2: begin
                  if (cnt_2 == 2'd3) begin
                     cnt_2 <= 2'd0;
                  end else begin
                     if (state == 4'd4 || state == 4'd6) begin
                        cnt_2 <= cnt_2 + 2'd1;
                     end else begin
                        cnt_2 <= 2'd0;
                     end
                  end
               end 
               default: begin
                  cnt_0 <= 2'd0;
                  cnt_1 <= 2'd0;
                  cnt_2 <= 2'd0;
               end
            endcase
         end
      end
   end

   // ------------------for stage 0------------------
   always @(posedge CLK or negedge rst_n) begin
      if (!rst_n) begin
         horizontal_cnt <= 2'd0;
      end else begin
         if (ROM4_w == 2'd1 || ROM4_w == 2'd2) begin
            if (horizontal_cnt == 2'd3) begin
               horizontal_cnt <= 2'd0;
            end else begin
               horizontal_cnt <= horizontal_cnt + 2'd1;
            end
         end else begin
            horizontal_cnt <= 2'd0;
         end
      end
   end

   always @(posedge CLK or negedge rst_n) begin
      if (!rst_n) begin
         horizontal_cnt_delay <= 2'd0;
      end else begin
         horizontal_cnt_delay <= horizontal_cnt;
      end
   end

   always @(posedge CLK or negedge rst_n) begin
      if (!rst_n) begin
         ROM4_w_delay <= 2'd0;
      end else begin
         ROM4_w_delay <= ROM4_w;
      end
   end
   //-------------------for stage 1----------------
   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         cnt_1_group <= 5'd0;
      end else begin
         if (cnt_1 == 4'd15) begin
            if (cnt_1_group == 5'd15) begin
               cnt_1_group <= 5'd0;
            end else begin
               cnt_1_group <= cnt_1_group + 5'd1;
            end
         end else begin
            cnt_1_group <= cnt_1_group;
         end
      end
   end
   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         stage1_group_th <= 2'd0;
      end else begin
         if (cnt_1_group == 5'd15 && cnt_1 == 4'd15) begin
            stage1_group_th <= stage1_group_th + 2'd1;
         end else begin
            stage1_group_th <= stage1_group_th;
         end
      end
   end
   //----------------------------------------------
   
   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         buf_const[0] <= 128'h0000000001000000_fffff7ff00000801;
         buf_const[1] <= 128'h0000000001000000_fffff7ff00000801;
      end else begin
         if (~CEN) begin
            case (stage_counter)
               3'd0: Q_const <= buf_const[0];
               3'd1: Q_const <= buf_const[1];
               default: Q_const <= Q_const;
            endcase
         end
      end
   end

   //----------output mux-------------------
   always @(*) begin
      if (ROM4_w_delay == 2'd1 && ROM4_w_dealy_fifo[12] == 2'd2) begin
         Q = {horizontal_row1_in_delay, horizontal_row2_in_delay_fifo[12]};
      end else if (ROM4_w_delay == 2'd1) begin
         Q = {horizontal_row1_in_delay, 64'd0} ;
      end else if (ROM4_w_dealy_fifo[12] == 2'd2) begin
         Q = {64'd0, horizontal_row2_in_delay_fifo[12]} ;
      end else begin
         Q = Q_Mux;
      end
   end

   always @(posedge CLK or negedge rst_n) begin
      if (!rst_n) begin
         horizontal_row1_in_delay <= 64'd0;
         horizontal_row2_in_delay <= 64'd0;
      end else begin
         horizontal_row1_in_delay <= horizontal_data_in;
         horizontal_row2_in_delay <= horizontal_data_in;
      end
   end


   integer i;
   always @(*) begin
      ROM4_w_dealy_fifo[0] = ROM4_w_delay;
      horizontal_row2_in_delay_fifo[0] = horizontal_row2_in_delay;
   end

   always @(posedge CLK or negedge rst_n) begin
      if (!rst_n) begin
         for (i = 0; i < 12 ; i = i + 1) begin
            ROM4_w_dealy_fifo[i+1] <= 64'd0;
         end
         for (i = 0; i < 12 ; i = i + 1) begin
            horizontal_row2_in_delay_fifo[i+1] <= 64'd0;
         end
      end else begin
         for (i = 0; i < 12 ; i = i + 1) begin
            ROM4_w_dealy_fifo[i+1] <= ROM4_w_dealy_fifo[i];
         end
         for (i = 0; i < 12 ; i = i + 1) begin
            horizontal_row2_in_delay_fifo[i+1] <= horizontal_row2_in_delay_fifo[i];
         end
      end
   end

   endmodule