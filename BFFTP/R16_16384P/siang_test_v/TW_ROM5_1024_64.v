 `timescale 1 ns/1 ps     

 module TW_ROM5_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,
   horizontal_data_in,
   ROM5_w,

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
   input [horizontal_DW-1:0]  horizontal_data_in   ;
   input [1:0]                ROM5_w               ;
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
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0]   <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[1]   <= 128'h007fffffffffff80_3babf8a70b9016d7    ; // BC=64
         buf_data_stage0[2]   <= 128'h7fffffff00000001_fffffffdffff0002    ; // BC=128
         buf_data_stage0[3]   <= 128'h00000040003fffc0_fbc8a1ec30654b2b    ; // BC=192
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'h007fffffffffff80_3babf8a70b9016d7; // BC=64
         buf_data_stage1[0][2] <= 128'h7fffffff00000001_fffffffdffff0002; // BC=128
         buf_data_stage1[0][3] <= 128'h00000040003fffc0_fbc8a1ec30654b2b; // BC=192

         buf_data_stage1[1][0] <= 128'hd1df70583aa377bd_1ee20087ae155450; // BC=16
         buf_data_stage1[1][1] <= 128'h1ae5253581bde075_2ec5857427dec65f;
         buf_data_stage1[1][2] <= 128'h62ae44218641740b_5162deb878a773ba;
         buf_data_stage1[1][3] <= 128'hbf210fc4ce5182d6_52ace2fc90457a99;
         buf_data_stage1[2][0] <= 128'h48bb429405cd1ea3_5ce12fcfabc79d87; // BC=32
         buf_data_stage1[2][1] <= 128'h3de19c67cf496a74_8024d1d331c08932;
         buf_data_stage1[2][2] <= 128'h7d1970ae2744309c_246859d06b222a38;
         buf_data_stage1[2][3] <= 128'h185b4ac60695836e_fc6bc4e828b3db2b;
         buf_data_stage1[3][0] <= 128'h969e9096afde4510_6a7c9217f0ce3407; // BC=48
         buf_data_stage1[3][1] <= 128'h840fa37ec53a39e1_d2abf21029ace519;
         buf_data_stage1[3][2] <= 128'ha810dd77a33e6ad4_7d1970ae2744309c;
         buf_data_stage1[3][3] <= 128'h1d62e30fa4a4eeb0_e4421e8e1740a9d6;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'hfffffffec0000001_0001fffffffe0000; // BC=64
         buf_data_stage2[2] <= 128'h1000000000000000_fffffffb00000005; // BC=128
         buf_data_stage2[3] <= 128'hfbffffff04000001_0008000000000000; // BC=192
      end else begin
         case (ROM5_w)
            2'd1: buf_data_stage0[horizontal_cnt][SEG2-1:SEG1] <= horizontal_data_in;
            2'd2: buf_data_stage0[horizontal_cnt][SEG1-1:0] <= horizontal_data_in;
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
         if (ROM5_w == 2'd1 || ROM5_w == 2'd2) begin
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
         buf_const[0] <= 128'hfffffffec0000001_0001fffffffe0000;
         buf_const[1] <= 128'hfffffffec0000001_0001fffffffe0000;
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