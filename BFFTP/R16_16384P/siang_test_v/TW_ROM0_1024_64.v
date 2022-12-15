 `timescale 1 ns/1 ps     

 module TW_ROM0_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,
   horizontal_tf_in,
   ROM0_w,

   Q,
   Q_const
 );
   parameter                  SC_WIDTH    = 3;
   parameter                  P_WIDTH     = 64 ; 	
   parameter                  stage_num = 4;
   parameter                  ROMA_WIDTH  = 10;
   parameter                  init_store_data = 4;
   parameter                  group_stage0 = 64;
   parameter                  group_stage1 = 4;
   parameter S_WIDTH   = 4 ; 

   input [SC_WIDTH-1:0]       stage_counter        ; 
   input                      rst_n                ;      
   input                      CLK                  ;
   input                      CEN                  ;
   input [S_WIDTH-1:0]        state                ;
   input [P_WIDTH-1:0]        horizontal_tf_in     ;
   input                      ROM0_w        ;
   output reg [P_WIDTH-1:0]   Q                ;
   output reg [P_WIDTH-1:0]   Q_const          ; 
     
   reg [P_WIDTH-1:0] buf_data_stage0 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage1 [0:group_stage1-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage2 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_const [0:stage_num-1];      
   reg [3:0] cnt_0;
   reg [3:0] cnt_1;
   reg [1:0] cnt_2;

   //reg [5:0] group_th;
   reg [1:0] horizontal_cnt;
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0] <= 64'h0000000000000001; // BC=0
         buf_data_stage0[1] <= 64'h9ab4d5fb2ded1731; // BC=64
         buf_data_stage0[2] <= 64'hfffdffff00000003; // BC=128
         buf_data_stage0[3] <= 64'h5b11501d07d1bfa5; // BC=192
         
         //stage 1
         buf_data_stage1[0][0] <= 64'h0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 64'h9ab4d5fb2ded1731; // BC=64
         buf_data_stage1[0][2] <= 64'hfffdffff00000003; // BC=128
         buf_data_stage1[0][3] <= 64'h5b11501d07d1bfa5; // BC=192

         buf_data_stage1[1][0] <= 64'h1a8c7b40a550e18a; // BC=16
         buf_data_stage1[1][1] <= 64'ha2cf6ca76b817fb4;
         buf_data_stage1[1][2] <= 64'h7b83abdf412342cf;
         buf_data_stage1[1][3] <= 64'h6ce8024cb0531c09;
         buf_data_stage1[2][0] <= 64'hdcee6ba66b6361d7; // BC=32
         buf_data_stage1[2][1] <= 64'hadda166b62c2ba2c;
         buf_data_stage1[2][2] <= 64'h1ee20087ae155450;
         buf_data_stage1[2][3] <= 64'hba856751f25d9591;
         buf_data_stage1[3][0] <= 64'hae7d2abe72929acf; // BC=48
         buf_data_stage1[3][1] <= 64'h58c3de196dbcf497;
         buf_data_stage1[3][2] <= 64'hd1df70583aa377bd;
         buf_data_stage1[3][3] <= 64'h0c26e0b997ad762f;

         //stage 2
         buf_data_stage2[0] <= 64'h0000000000000001; // BC=0
         buf_data_stage2[1] <= 64'hfff7ffff00000001; // BC=64
         buf_data_stage2[2] <= 64'hfffffffeffffffc1; // BC=128
         buf_data_stage2[3] <= 64'h0200000000000000; // BC=192
      end else begin
         if (ROM0_w) begin
            buf_data_stage0[horizontal_cnt] <= horizontal_tf_in;
         end
      end
   end


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         Q <= 64'd0;
      end else begin
         if (~CEN) begin
            case (stage_counter)
               3'd0: begin
                  case (cnt_0)
                     2'd0: Q <= buf_data_stage0[0];
                     2'd1: Q <= buf_data_stage0[1];
                     2'd2: Q <= buf_data_stage0[2];
                     2'd3: Q <= buf_data_stage0[3];
                     default: Q <= 64'd0;
                  endcase
               end
               3'd1: begin
                  case (cnt_1)
                     2'd0: Q <= buf_data_stage1[stage1_group_th][0];
                     2'd1: Q <= buf_data_stage1[stage1_group_th][1];
                     2'd2: Q <= buf_data_stage1[stage1_group_th][2];
                     2'd3: Q <= buf_data_stage1[stage1_group_th][3];
                     default: Q <= 64'd0;
                  endcase
               end
               3'd2: begin
                  case (cnt_2)
                     2'd0: Q <= buf_data_stage2[0];
                     2'd1: Q <= buf_data_stage2[1];
                     2'd2: Q <= buf_data_stage2[2];
                     2'd3: Q <= buf_data_stage2[3];
                     default: Q <= 64'd0;
                  endcase
               end 
               default: Q <= 64'd1;
            endcase
         end else begin
            Q <= 64'd1;
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

   //-------------------for stage 0------------------
   always @(posedge CLK or rst_n) begin
      if (!rst_n) begin
         horizontal_cnt <= 2'd0;
      end else begin
         if (ROM0_w) begin
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
         buf_const[0] <= 64'hfff7ffff00000001;
         buf_const[1] <= 64'hfff7ffff00000001;
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

   endmodule