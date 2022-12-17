 `timescale 1 ns/1 ps     

 module TW_ROM2_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,
   horizontal_row0_in,
   horizontal_row1_in,
   ROM2_w,

   Q,
   Q_const,
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
   input [horizontal_DW-1:0]  horizontal_row0_in   ;
   input [horizontal_DW-1:0]  horizontal_row1_in   ;
   input [1:0]                ROM2_w               ;
   output reg [P_WIDTH-1:0]   Q                    ;
   output reg [P_WIDTH-1:0]   Q_const              ;
     
   reg [P_WIDTH-1:0] buf_data_stage0 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage1 [0:group_stage1-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage2 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_const [0:stage_num-1];      
   reg [3:0] cnt_0;
   reg [3:0] cnt_1;
   reg [1:0] cnt_2;
   reg [3:0] stage0_group_cnt;

   reg [1:0] horizontal_cnt;
   reg [1:0] horizontal_cnt_delay;
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;

   reg [P_WIDTH-1:0] Q_Mux;
   reg [horizontal_DW-1:0] horizontal_row0_in_delay;
   reg [horizontal_DW-1:0] horizontal_row1_in_delay;
   reg [1:0] ROM2_w_delay;


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0] <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[1] <= 128'hfff7ffff00000001_969e9096afde4510    ; // BC=64
         buf_data_stage0[2] <= 128'hfffffffeffffffc1_007fffffffffff80    ; // BC=128
         buf_data_stage0[3] <= 128'h0200000000000000_840fa37ec53a39e1    ; // BC=192
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'hfff7ffff00000001_969e9096afde4510; // BC=64
         buf_data_stage1[0][2] <= 128'hfffffffeffffffc1_007fffffffffff80; // BC=128
         buf_data_stage1[0][3] <= 128'h0200000000000000_840fa37ec53a39e1; // BC=192

         buf_data_stage1[1][0] <= 128'h9ab4d5fb2ded1731_a2cf6ca76b817fb4; // BC=16
         buf_data_stage1[1][1] <= 128'h969e9096afde4510_8a8df6e55efde538;
         buf_data_stage1[1][2] <= 128'h52ca810d84ba33e7_c5ff6cb7eb38fddc;
         buf_data_stage1[1][3] <= 128'h585bda2e086ebc26_c7b40bfd0e189e58;
         buf_data_stage1[2][0] <= 128'h5b11501d07d1bfa5_ba856751f25d9591; // BC=32
         buf_data_stage1[2][1] <= 128'h81efc17180eb1719_c465162d27278a78;
         buf_data_stage1[2][2] <= 128'h3babf8a70b9016d7_2ec5857427dec65f;
         buf_data_stage1[2][3] <= 128'h840fa37ec53a39e1_20087ccf5544fe12;
         buf_data_stage1[3][0] <= 128'hfffdffff00000003_d1df70583aa377bd; // BC=48
         buf_data_stage1[3][1] <= 128'hffeffffefffffff1_48bb429405cd1ea3;
         buf_data_stage1[3][2] <= 128'h007fffffffffff80_1ae5253581bde075;
         buf_data_stage1[3][3] <= 128'h0400000000000400_3de19c67cf496a74;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'h0000000000001000_7fffffff00000001; // BC=64
         buf_data_stage2[2] <= 128'h0000000001000000_fffffffec0000001; // BC=128
         buf_data_stage2[3] <= 128'h0000001000000000_1fffffffe0000000; // BC=192
      end else begin
         case (ROM2_w_delay)
            2'd1: buf_data_stage0[horizontal_cnt_delay][SEG2-1:SEG1] <= horizontal_row0_in_delay;
            2'd2: buf_data_stage0[horizontal_cnt_delay][SEG1-1:0] <= horizontal_row1_in_delay;
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
                     default: Q_Mux <= 128'd0;
                  endcase
               end
               3'd1: begin
                  case (cnt_1)
                     2'd0: Q_Mux <= buf_data_stage1[stage1_group_th][0];
                     2'd1: Q_Mux <= buf_data_stage1[stage1_group_th][1];
                     2'd2: Q_Mux <= buf_data_stage1[stage1_group_th][2];
                     2'd3: Q_Mux <= buf_data_stage1[stage1_group_th][3];
                     default: Q_Mux <= 128'd0;
                  endcase
               end
               3'd2: begin
                  case (cnt_2)
                     2'd0: Q_Mux <= buf_data_stage2[0];
                     2'd1: Q_Mux <= buf_data_stage2[1];
                     2'd2: Q_Mux <= buf_data_stage2[2];
                     2'd3: Q_Mux <= buf_data_stage2[3];
                     default: Q_Mux <= 128'd0;
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


   // ---------------for stage 0----------------------
   always @(posedge CLK or rst_n) begin
      if (!rst_n) begin
         horizontal_cnt <= 2'd0;
      end else begin
         if (ROM2_w == 2'd1 || ROM2_w == 2'd2) begin
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

   always @(posedge CLK or posedge rst_n) begin
      if (!rst_n) begin
         horizontal_cnt_delay <= 2'd0;
      end else begin
         horizontal_cnt_delay <= horizontal_cnt;
      end
   end

   always @(posedge CLK or posedge rst_n) begin
      if (!rst_n) begin
         ROM2_w_delay <= 2'd0;
      end else begin
         ROM2_w_delay <= ROM2_w;
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
         buf_const[0] <= 128'h0000000000001000_7fffffff00000001;
         buf_const[1] <= 128'h0000000000001000_7fffffff00000001;
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
      if (ROM2_w_delay == 2'd1) begin
         Q = {horizontal_row0_in_delay, 64'd0} ;
      end else if (ROM2_w_delay == 2'd2) begin
         Q = {64'd0, horizontal_row1_in_delay} ;
      end else begin
         Q = Q_Mux;
      end
   end

   always @(posedge CLK or posedge rst_n) begin
      if (!rst_n) begin
         horizontal_row0_in_delay <= 64'd0;
         horizontal_row1_in_delay <= 64'd0;
      end else begin
         horizontal_row0_in_delay <= horizontal_row0_in;
         horizontal_row1_in_delay <= horizontal_row1_in;
      end
   end

   endmodule