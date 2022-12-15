 `timescale 1 ns/1 ps     

 module TW_ROM1_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,
   horizontal_tf_in,
   ROM1_w,

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
   parameter                  S_WIDTH   = 4 ; 
   parameter                  SEG1  = 64 ;                                                                     
   parameter                  SEG2  = 128 ; 
   parameter                  horizontal_DW = 64;

   input [SC_WIDTH-1:0]       stage_counter        ; 
   input                      rst_n                ;      
   input                      CLK                  ;
   input                      CEN                  ;
   input [S_WIDTH-1:0]        state                ;
   input [horizontal_DW-1:0]  horizontal_tf_in     ;
   input [1:0]                ROM1_w               ;
   output reg [P_WIDTH-1:0]   Q                    ;
   output reg [P_WIDTH-1:0]   Q_const              ;
     
   reg [P_WIDTH-1:0] buf_data_stage0 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage1 [0:group_stage1-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage2 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_const [0:stage_num-1];      
   reg [3:0] cnt_0;
   reg [3:0] cnt_1;
   reg [1:0] cnt_2;

   reg [1:0] horizontal_cnt;
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0] <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[1] <= 128'hfffdffff00000003_5b11501d07d1bfa5    ; // BC=64
         buf_data_stage0[2] <= 128'hfff7ffff00000001_ffeffffefffffff1    ; // BC=128
         buf_data_stage0[3] <= 128'hffeffffefffffff1_52ca810d84ba33e7    ; // BC=192
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'hfffdffff00000003_5b11501d07d1bfa5; // BC=64
         buf_data_stage1[0][2] <= 128'hfff7ffff00000001_ffeffffefffffff1; // BC=128
         buf_data_stage1[0][3] <= 128'hffeffffefffffff1_52ca810d84ba33e7; // BC=192

         buf_data_stage1[1][0] <= 128'hae7d2abe72929acf_dcee6ba66b6361d7; // BC=16
         buf_data_stage1[1][1] <= 128'hd1df70583aa377bd_ba856751f25d9591;
         buf_data_stage1[1][2] <= 128'hd3946b6a55f9087f_59428f55043e67bb;
         buf_data_stage1[1][3] <= 128'hbf562ae382c86418_897a64fb4f51752c;
         buf_data_stage1[2][0] <= 128'h58c3de196dbcf497_7b83abdf412342cf; // BC=32
         buf_data_stage1[2][1] <= 128'h0c26e0b997ad762f_9d24a3f365407288;
         buf_data_stage1[2][2] <= 128'h6a7c9217f0ce3407_5ce12fcfabc79d87;
         buf_data_stage1[2][3] <= 128'h48bb429405cd1ea3_c5ff6cb7eb38fddc;
         buf_data_stage1[3][0] <= 128'h9ab4d5fb2ded1731_58c3de196dbcf497; // BC=48
         buf_data_stage1[3][1] <= 128'h5b11501d07d1bfa5_d3946b6a55f9087f;
         buf_data_stage1[3][2] <= 128'h969e9096afde4510_48bb429405cd1ea3;
         buf_data_stage1[3][3] <= 128'h81efc17180eb1719_8823e9bc572210f5;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'hfffffffeffffffc1_0200000000000000; // BC=64
         buf_data_stage2[2] <= 128'h0000000000001000_fffffffefffc0001; // BC=128
         buf_data_stage2[3] <= 128'hfffffffefffc0001_fffff7ff00000801; // BC=192
      end else begin
         case (ROM1_w)
            2'd1: buf_data_stage0[horizontal_cnt][SEG2-1:SEG1] <= horizontal_tf_in;
            2'd2: buf_data_stage0[horizontal_cnt][SEG1-1:0] <= horizontal_tf_in;
            default: buf_data_stage0[horizontal_cnt] <= buf_data_stage0[horizontal_cnt];
         endcase
      end
   end


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         Q <= 128'd0;
      end else begin
         if (~CEN) begin
            case (stage_counter)
               3'd0: begin
                  case (cnt_0)
                     2'd0: Q <= buf_data_stage0[0];
                     2'd1: Q <= buf_data_stage0[1];
                     2'd2: Q <= buf_data_stage0[2];
                     2'd3: Q <= buf_data_stage0[3];
                     default: Q <= 128'd0;
                  endcase
               end
               3'd1: begin
                  case (cnt_1)
                     2'd0: Q <= buf_data_stage1[stage1_group_th][0];
                     2'd1: Q <= buf_data_stage1[stage1_group_th][1];
                     2'd2: Q <= buf_data_stage1[stage1_group_th][2];
                     2'd3: Q <= buf_data_stage1[stage1_group_th][3];
                     default: Q <= 128'd0;
                  endcase
               end
               3'd2: begin
                  case (cnt_2)
                     2'd0: Q <= buf_data_stage2[0];
                     2'd1: Q <= buf_data_stage2[1];
                     2'd2: Q <= buf_data_stage2[2];
                     2'd3: Q <= buf_data_stage2[3];
                     default: Q <= 128'd0;
                  endcase
               end 
               default: Q <= 128'h1_0000000000000001;
            endcase
         end else begin
            Q <= 128'h1_0000000000000001;
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

   // for stage 0
   always @(posedge CLK or rst_n) begin
      if (!rst_n) begin
         horizontal_cnt <= 2'd0;
      end else begin
         if (ROM1_w == 2'd1 || ROM1_w == 2'd2) begin
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
         buf_const[0] <= 128'hfffffffeffffffc1_0200000000000000;
         buf_const[1] <= 128'hfffffffeffffffc1_0200000000000000;
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