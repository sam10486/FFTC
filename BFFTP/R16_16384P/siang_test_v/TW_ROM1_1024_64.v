 `timescale 1 ns/1 ps     

 module TW_ROM1_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,

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

   input [SC_WIDTH-1:0] stage_counter  ; 
   input rst_n                  ;      
   input CLK                  ;
   input  CEN                  ;
   input [S_WIDTH-1:0] state;
   output reg [P_WIDTH-1:0] Q     ;
   output reg [P_WIDTH-1:0] Q_const     ;
     
   reg [P_WIDTH-1:0] buf_data_stage0 [0:group_stage0-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage1 [0:group_stage1-1][0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_data_stage2 [0:init_store_data-1];  
   reg [P_WIDTH-1:0] buf_const [0:stage_num-1];      
   reg [3:0] cnt_0;
   reg [3:0] cnt_1;
   reg [1:0] cnt_2;

   reg [5:0] group_th;
   reg [3:0] cnt_1_group;
   reg [1:0] stage1_group_th;


   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         //stage 0
         //group 0
         buf_data_stage0[0][0] <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[0][1] <= 128'hfffdffff00000003_5b11501d07d1bfa5    ; // BC=64
         buf_data_stage0[0][2] <= 128'hfff7ffff00000001_ffeffffefffffff1    ; // BC=128
         buf_data_stage0[0][3] <= 128'hffeffffefffffff1_52ca810d84ba33e7    ; // BC=192
         buf_data_stage0[1][0] <= 128'h7de340fb66a3942d_915be1a8a0ea4674    ;
         buf_data_stage0[1][1] <= 128'h5175b4b04f3ef167_8ead190fdecaa1f9    ;
         buf_data_stage0[1][2] <= 128'h56bccae307df2437_6877d6c80beebd2c    ;
         buf_data_stage0[1][3] <= 128'hcf458607a58505a6_64a0824ea45cb7f5    ;
         buf_data_stage0[2][0] <= 128'h2207b30251d4c9a8_4a3f9ccc62d9a86a    ;
         buf_data_stage0[2][1] <= 128'h4abac25b09ae7b09_5c0f8cf607e1dbf5    ;
         buf_data_stage0[2][2] <= 128'h1aad715998139ee4_08a0059a9f304af9    ;
         buf_data_stage0[2][3] <= 128'h14dfb28c12daa34a_b056b27b51487fcd    ;
         buf_data_stage0[3][0] <= 128'hc26241d7d497e9b7_2207b30251d4c9a8    ;
         buf_data_stage0[3][1] <= 128'h2da6da812ce10161_bd063f1db48f1c30    ;
         buf_data_stage0[3][2] <= 128'ha3895b400ec4b7d2_14dfb28c12daa34a    ;
         buf_data_stage0[3][3] <= 128'h20ee98f7d40ad43f_7ac0c526a8f55662    ;
         buf_data_stage0[4][0] <= 128'h7fb5acc30389f4d0_d8452f144f2e3d4b    ;
         buf_data_stage0[4][1] <= 128'hbc455272609af01f_a47c3fa8d52dc7c2    ;
         buf_data_stage0[4][2] <= 128'hf367e3af661c19fe_b5b81bc8fe6ea295    ;
         buf_data_stage0[4][3] <= 128'heb74fb279398e703_418eb28ba7bb1e8b    ;
         buf_data_stage0[5][0] <= 128'h0776fe07a33f934f_03f08ae670ad3bd5    ;
         buf_data_stage0[5][1] <= 128'hec40b58f428e7c0c_0c7b2300c8a8187d    ;
         buf_data_stage0[5][2] <= 128'h754ae602f03d55b5_554046c4a3938c8d    ;
         buf_data_stage0[5][3] <= 128'h7325eb8bac81767a_80714570a58bca65    ;
         buf_data_stage0[6][0] <= 128'h08dda69734d315e3_6b551fea26657a45    ;
         buf_data_stage0[6][1] <= 128'h98c6e387b6d4a728_fb447b02e4b01772    ;
         buf_data_stage0[6][2] <= 128'h1c2e596734b9ed86_a7bb9afe98517761    ;
         buf_data_stage0[6][3] <= 128'haa82495a1c427cdd_246a04c0653c8839    ;
         buf_data_stage0[7][0] <= 128'hd0e5c71177433cdc_7fb5acc30389f4d0    ;
         buf_data_stage0[7][1] <= 128'h99f09f9d7cab0a09_fdeba23e89465e98    ;
         buf_data_stage0[7][2] <= 128'he09445e538924149_eb74fb279398e703    ;
         buf_data_stage0[7][3] <= 128'hb2cc1aa6fcf0b4de_13dd47a18f9289b0    ;
         buf_data_stage0[8][0] <= 128'h912b7e3e532ae35f_bbdfdceff9b2d4ca    ;
         buf_data_stage0[8][1] <= 128'h5f1c5627a2d38f6a_64e0a4d91c445ad2    ;
         buf_data_stage0[8][2] <= 128'hf31566a7f1f722b4_266295c733de0c97    ;
         buf_data_stage0[8][3] <= 128'hd372e962b1400f80_b743ee2189526537    ;
         buf_data_stage0[9][0] <= 128'hf3dd150bf2cea5ad_575eb97c69429fc1    ;
         buf_data_stage0[9][1] <= 128'h7248447c0fb718b0_d438475a1493a4d2    ;
         buf_data_stage0[9][2] <= 128'h2a38698aa867355e_f63dd40903a20e0c    ;
         buf_data_stage0[9][3] <= 128'h169f824723e40ffb_f9ba41162c743fad    ;
         buf_data_stage0[10][0] <= 128'h9c4563b91246b28e_b5609d15159f67c6   ;
         buf_data_stage0[10][1] <= 128'h0bfca2e5ec00c233_079159b310a24508   ;
         buf_data_stage0[10][2] <= 128'h4dc76dca1dcd7461_5c44d4ac776633ac   ;
         buf_data_stage0[10][3] <= 128'hd7389ff9172fbfec_9b395aa9910d32bb   ;
         buf_data_stage0[11][0] <= 128'h32c3f888d962f857_bcd5c57029b9c4d3   ;
         buf_data_stage0[11][1] <= 128'h83c83e4ba3d808fc_83541ab37db4bd31   ;
         buf_data_stage0[11][2] <= 128'h790134e7c4486138_8e710d54bb721bd5   ;
         buf_data_stage0[11][3] <= 128'hc5c2e13ef2613d03_4c767973cff43d86   ;
         buf_data_stage0[12][0] <= 128'h97017c5dccfb9554_9c4563b91246b28e   ;
         buf_data_stage0[12][1] <= 128'h0a9f5ec592b3f2a1_478a38cf268a625c   ;
         buf_data_stage0[12][2] <= 128'h72719822e2f31fe9_d7389ff9172fbfec   ;
         buf_data_stage0[12][3] <= 128'h74cb6a5ff62cea9b_d4aa0a622450bb8f   ;
         buf_data_stage0[13][0] <= 128'h02665526fe6cf647_d5a7afcd075f52e8   ;
         buf_data_stage0[13][1] <= 128'h6df0ad73a727ee35_bba3cbff6b007910   ;
         buf_data_stage0[13][2] <= 128'ha4900c97a938069b_7a348d2c86e8a1fe   ;
         buf_data_stage0[13][3] <= 128'h22bac6c06ba0a8c5_f4cc8ff50ffad951   ;
         buf_data_stage0[14][0] <= 128'hd8452f144f2e3d4b_f3f04b444500c07c   ;
         buf_data_stage0[14][1] <= 128'hd7cbbfccfc86c97c_c1618106364c8441   ;
         buf_data_stage0[14][2] <= 128'h9d05868d78a93b9c_04f6fba064478760   ;
         buf_data_stage0[14][3] <= 128'hb5b81bc8fe6ea295_95748ac7aba736dd   ;
         buf_data_stage0[15][0] <= 128'h1a8c7b40a550e18a_912b7e3e532ae35f   ;
         buf_data_stage0[15][1] <= 128'h7b83abdf412342cf_121d0f9208af78ae   ;
         buf_data_stage0[15][2] <= 128'h19aad578da05feeb_d372e962b1400f80   ;
         buf_data_stage0[15][3] <= 128'h8a8df6e55efde538_5a2e7be66e2a21ea   ;
         buf_data_stage0[16][0] <= 128'hdcee6ba66b6361d7_a0ab7e95c458c04e   ;
         buf_data_stage0[16][1] <= 128'h1ee20087ae155450_e09445e538924149   ;
         buf_data_stage0[16][2] <= 128'h9414a4e45d3a428f_070bd10da3da4b6e   ;
         buf_data_stage0[16][3] <= 128'h59428f55043e67bb_83d81879d53d7de7   ;
         buf_data_stage0[17][0] <= 128'hadb2dae29606e340_ca29fe77059fada5   ;
         buf_data_stage0[17][1] <= 128'hdf2089b7e1d44df3_9be8f1dc7fe87bb0   ;
         buf_data_stage0[17][2] <= 128'h0eeb4fc8d71a1dce_9b9fbe878d822258   ;
         buf_data_stage0[17][3] <= 128'h42a8f15d4dc607a7_68a8e3a61f4a0221   ;
         buf_data_stage0[18][0] <= 128'h4d6a3319af264a28_58c03fd10103f325   ;
         buf_data_stage0[18][1] <= 128'ha05107e6c4808d71_c6be195a51eafdcd   ;
         buf_data_stage0[18][2] <= 128'h15f286cd98cfe484_449bf2aaecd669f9   ;
         buf_data_stage0[18][3] <= 128'h5541dbfb3f3b268d_21a94b9e7701adce   ;
         buf_data_stage0[19][0] <= 128'h2d3e749c32068452_3bc10f75aa162847   ;
         buf_data_stage0[19][1] <= 128'h68a0852b4d45c72e_754ae602f03d55b5   ;
         buf_data_stage0[19][2] <= 128'h388e6fcba4e2fa28_c824673e55fbd908   ;
         buf_data_stage0[19][3] <= 128'h9d3595d1295daf33_efd29bf35c60fd3c   ;
         buf_data_stage0[20][0] <= 128'he104978443ea74c5_e489eb510cbcac01   ;
         buf_data_stage0[20][1] <= 128'ha976a734b6df3367_2a38698aa867355e   ;
         buf_data_stage0[20][2] <= 128'h9db5e0abbc292779_42407f15e9545468   ;
         buf_data_stage0[20][3] <= 128'h2b22490639ab02af_6deee0df1239d41d   ;
         buf_data_stage0[21][0] <= 128'h60796f94d5757c59_393d81bb63a9abc8   ;
         buf_data_stage0[21][1] <= 128'he917343e8a156490_9275285285506f7b   ;
         buf_data_stage0[21][2] <= 128'ha09154537ca9af78_93f1a9aae11f11f7   ;
         buf_data_stage0[21][3] <= 128'h398baf54a1fb9965_5bd525c7302a84b3   ;
         buf_data_stage0[22][0] <= 128'h2fefbfe46ea8d5c6_3b11a1800cff9f70   ;
         buf_data_stage0[22][1] <= 128'h348aa2775d1ae8bd_c85e3636cabe24e1   ;
         buf_data_stage0[22][2] <= 128'h52ac8ab8ff24f4c5_3fe51801480a8a18   ;
         buf_data_stage0[22][3] <= 128'ha65d172813bc8d2d_c89ff0a3b796e3c3   ;
         buf_data_stage0[23][0] <= 128'hca229fd580c44658_c398180c38caffd7   ;
         buf_data_stage0[23][1] <= 128'hc7ea3e234135227d_72719822e2f31fe9   ;
         buf_data_stage0[23][2] <= 128'hce93f9dcfeb25738_484af27ff41fc8ce   ;
         buf_data_stage0[23][3] <= 128'hfafdf655f12048fc_58284e98530357c3   ;
         buf_data_stage0[24][0] <= 128'h6b353155d3c8bdc5_e104978443ea74c5   ;
         buf_data_stage0[24][1] <= 128'hf834bb1a0a3df986_8ba4d377135a8dc4   ;
         buf_data_stage0[24][2] <= 128'h872961b98ab1f7f0_2b22490639ab02af   ;
         buf_data_stage0[24][3] <= 128'h5affae0fd8d81396_320192dd01d113bf   ;
         buf_data_stage0[25][0] <= 128'hbcd5c57029b9c4d3_227b9fdd365d00ac   ;
         buf_data_stage0[25][1] <= 128'h6525376dde5556c4_393c6024d691f175   ;
         buf_data_stage0[25][2] <= 128'hade6b2312b87347d_cfb29c59980582cd   ;
         buf_data_stage0[25][3] <= 128'h8e710d54bb721bd5_529c948f9931e599   ;
         buf_data_stage0[26][0] <= 128'h6a07aefc1cf821c1_e4f9daeb27607da9   ;
         buf_data_stage0[26][1] <= 128'h3295240897e95181_5c2d04b317242475   ;
         buf_data_stage0[26][2] <= 128'h7a17183e77e437ff_271fdb3738b8eb24   ;
         buf_data_stage0[26][3] <= 128'h53b340b5204653f4_aaae4285d8f4edc9   ;
         buf_data_stage0[27][0] <= 128'hd0b407bb096f67e3_616884339c3ac741   ;
         buf_data_stage0[27][1] <= 128'hc22bfc982256840c_56bccae307df2437   ;
         buf_data_stage0[27][2] <= 128'h830fb4843dded11c_322df9137f93662b   ;
         buf_data_stage0[27][3] <= 128'hfadeed4ae4c72415_a292d3d73043a655   ;
         buf_data_stage0[28][0] <= 128'hbbdfdceff9b2d4ca_4d6a3319af264a28   ;
         buf_data_stage0[28][1] <= 128'h144bc67bad4714b8_fdd46da57ecb43be   ;
         buf_data_stage0[28][2] <= 128'h72303268e785ac96_5541dbfb3f3b268d   ;
         buf_data_stage0[28][3] <= 128'h266295c733de0c97_0c8138e3edb38e2b   ;
         buf_data_stage0[29][0] <= 128'h21c889bd56eb81f0_892a4dd966a15378   ;
         buf_data_stage0[29][1] <= 128'h2c3665a3c151f548_ef32fdb486338e82   ;
         buf_data_stage0[29][2] <= 128'ha29548a34debc5a1_5844b84b7389c543   ;
         buf_data_stage0[29][3] <= 128'h28a1f5702d1f6c43_4967c16f781e6e58   ;
         buf_data_stage0[30][0] <= 128'h00cd94611114ce8e_b2464d358bee3699   ;
         buf_data_stage0[30][1] <= 128'h3bbd06984aebc0e1_817fe73314eddbba   ;
         buf_data_stage0[30][2] <= 128'he8877758a3088f14_9eb26db8148079c4   ;
         buf_data_stage0[30][3] <= 128'hc435a8a134c43547_b9303de8245bab45   ;
         buf_data_stage0[31][0] <= 128'hae7d2abe72929acf_dcee6ba66b6361d7   ;
         buf_data_stage0[31][1] <= 128'hd1df70583aa377bd_ba856751f25d9591   ;
         buf_data_stage0[31][2] <= 128'hd3946b6a55f9087f_59428f55043e67bb   ;
         buf_data_stage0[31][3] <= 128'hbf562ae382c86418_897a64fb4f51752c   ;
         buf_data_stage0[32][0] <= 128'h58c3de196dbcf497_7b83abdf412342cf   ;
         buf_data_stage0[32][1] <= 128'h0c26e0b997ad762f_9d24a3f365407288   ;
         buf_data_stage0[32][2] <= 128'h6a7c9217f0ce3407_5ce12fcfabc79d87   ;
         buf_data_stage0[32][3] <= 128'h48bb429405cd1ea3_c5ff6cb7eb38fddc   ;
         buf_data_stage0[33][0] <= 128'h5356e9a7c3d367f5_f93dbeb3b0f67fde   ;
         buf_data_stage0[33][1] <= 128'h03744ba95af6fe3e_e548156afcd13684   ;
         buf_data_stage0[33][2] <= 128'h7319e1644d40b953_8309054cdbe2a574   ;
         buf_data_stage0[33][3] <= 128'hb0c528475d4af35b_ec8edc2d89aab964   ;
         buf_data_stage0[34][0] <= 128'hf0cc3ddf72d20532_0e5d6adb29f61ab9   ;
         buf_data_stage0[34][1] <= 128'h5b75961c6164d19f_356866e5b199e2d5   ;
         buf_data_stage0[34][2] <= 128'he774696eef031cf3_c0e6b2ea0e51d9aa   ;
         buf_data_stage0[34][3] <= 128'hc224f4d8b0e5e6d4_0dce780354c042d8   ;
         buf_data_stage0[35][0] <= 128'hd922f0469ddab66c_6df0ad73a727ee35   ;
         buf_data_stage0[35][1] <= 128'h64e0a4d91c445ad2_93eeee91fdb257eb   ;
         buf_data_stage0[35][2] <= 128'hca6b1129823bb7ee_666ab63f64c26e41   ;
         buf_data_stage0[35][3] <= 128'h02a71ddd26cc0928_59413bb10e039b6e   ;
         buf_data_stage0[36][0] <= 128'h36d11d9ae31cc4c6_3bbd06984aebc0e1   ;
         buf_data_stage0[36][1] <= 128'ha8e074fc016fbd68_7319e1644d40b953   ;
         buf_data_stage0[36][2] <= 128'hecf8e718ecd8cf70_cc9ae7babacc5c81   ;
         buf_data_stage0[36][3] <= 128'h6cdff481a7e55282_22ed15a842407081   ;
         buf_data_stage0[37][0] <= 128'h1d99c647a348c31b_6eaaf1601e58432f   ;
         buf_data_stage0[37][1] <= 128'h286e45fdd32107fb_e906e3ed39ac0064   ;
         buf_data_stage0[37][2] <= 128'hb4eae5b9323e0715_cc5f047230849d4b   ;
         buf_data_stage0[37][3] <= 128'h903966f72fefdc7b_2a7e265da42224fd   ;
         buf_data_stage0[38][0] <= 128'h16ce261a18c02f0a_cc3ecb4af22d8acd   ;
         buf_data_stage0[38][1] <= 128'h83541ab37db4bd31_310c7972c8ac7e85   ;
         buf_data_stage0[38][2] <= 128'h56df39fe30d17c73_da94286a91e33a03   ;
         buf_data_stage0[38][3] <= 128'h40dc1259d5a00847_6fbbde080c67b343   ;
         buf_data_stage0[39][0] <= 128'h6fb69219dde133b9_83c83e4ba3d808fc   ;
         buf_data_stage0[39][1] <= 128'h53c76871dff702a1_0e3ad74e485be598   ;
         buf_data_stage0[39][2] <= 128'hd16910f590d26cbf_4f01ddbca741ea4d   ;
         buf_data_stage0[39][3] <= 128'ha769004743919df4_4dee055bef270fed   ;
         buf_data_stage0[40][0] <= 128'h36e6ee0a706c8023_68a0852b4d45c72e   ;
         buf_data_stage0[40][1] <= 128'h9172fb3bbcee4eed_80d2bcb05393e568   ;
         buf_data_stage0[40][2] <= 128'h8e947c9b70553a9c_b062d8e77e5eeb8c   ;
         buf_data_stage0[40][3] <= 128'haeba188cd9e2730b_d14efbb391ceeff3   ;
         buf_data_stage0[41][0] <= 128'hc431d60f18588071_d98a14e7cf68d86e   ;
         buf_data_stage0[41][1] <= 128'hdb637b6ddcd0b9f6_fb466140b287e819   ;
         buf_data_stage0[41][2] <= 128'h4bff3d3bb07ee453_9201bae757fd085d   ;
         buf_data_stage0[41][3] <= 128'h54e11979db75c1a2_b5fec365eb9c5b65   ;
         buf_data_stage0[42][0] <= 128'h8913a944437be72c_2be69ee879cb29c0   ;
         buf_data_stage0[42][1] <= 128'hf146cb90d9816777_fefed1ad1d5efaff   ;
         buf_data_stage0[42][2] <= 128'h7c7de4204a26647d_b70e74c251d7bf20   ;
         buf_data_stage0[42][3] <= 128'h67c133f45c8e5642_45510f2e44f215fd   ;
         buf_data_stage0[43][0] <= 128'hfb37f9b38ff8bbb2_348aa2775d1ae8bd   ;
         buf_data_stage0[43][1] <= 128'h8ba4d377135a8dc4_4bff3d3bb07ee453   ;
         buf_data_stage0[43][2] <= 128'h54d38039cda45986_041006d855ca8e8c   ;
         buf_data_stage0[43][3] <= 128'hf627652a9bbcf7fc_27212451cbd182b7   ;
         buf_data_stage0[44][0] <= 128'hd4430a71a869e574_3295240897e95181   ;
         buf_data_stage0[44][1] <= 128'hc8bac41065b8c441_b4eae5b9323e0715   ;
         buf_data_stage0[44][2] <= 128'h80d2bcb05393e568_7e1440ddc1f78fdb   ;
         buf_data_stage0[44][3] <= 128'hbd74d2392089739d_e46e808037be014b   ;
         buf_data_stage0[45][0] <= 128'habcdfb1bc44931c8_e146145091c3b86c   ;
         buf_data_stage0[45][1] <= 128'hfdd46da57ecb43be_04656c63be721398   ;
         buf_data_stage0[45][2] <= 128'h98e1ddb5d8e380ba_1fd59ead28dba9eb   ;
         buf_data_stage0[45][3] <= 128'h74e409a56d33e4fe_b9ed52a1df1af3f9   ;
         buf_data_stage0[46][0] <= 128'h59157e3f1bcde14e_11fe0908c4bd3d50   ;
         buf_data_stage0[46][1] <= 128'hf310c4e2341aac63_d296e39e11f5e6e8   ;
         buf_data_stage0[46][2] <= 128'h03972190f1fba71b_7a93239e44b996b6   ;
         buf_data_stage0[46][3] <= 128'h75d65f2a2719395c_2e30a6b31a8fda5a   ;
         buf_data_stage0[47][0] <= 128'hadda166b62c2ba2c_f834bb1a0a3df986   ;
         buf_data_stage0[47][1] <= 128'hba856751f25d9591_d16910f590d26cbf   ;
         buf_data_stage0[47][2] <= 128'h7b44e9e9b36084e7_32b3aa700dd08edb   ;
         buf_data_stage0[47][3] <= 128'h18e86d133a956718_0e25e373023f57d5   ;
         buf_data_stage0[48][0] <= 128'ha2cf6ca76b817fb4_36e6ee0a706c8023   ;
         buf_data_stage0[48][1] <= 128'h6ce8024cb0531c09_ce93f9dcfeb25738   ;
         buf_data_stage0[48][2] <= 128'h9d24a3f365407288_aeba188cd9e2730b   ;
         buf_data_stage0[48][3] <= 128'h0d527d671268e9d9_057076fdb2b760f2   ;
         buf_data_stage0[49][0] <= 128'h2af9c535a5611386_4d768679d45bbec6   ;
         buf_data_stage0[49][1] <= 128'ha47c3fa8d52dc7c2_508baa02512a9634   ;
         buf_data_stage0[49][2] <= 128'h3a22d4f729ae82d7_d49a52a121e630ca   ;
         buf_data_stage0[49][3] <= 128'hc4a95690fd4bcd51_f3e04d2b8d80b82a   ;
         buf_data_stage0[50][0] <= 128'h28cf9fb6222dadcc_9038d8928d6a77ab   ;
         buf_data_stage0[50][1] <= 128'hb69afb1083c7f193_ce12933a28ae76a0   ;
         buf_data_stage0[50][2] <= 128'h93eeee91fdb257eb_f899a025b28a5f8f   ;
         buf_data_stage0[50][3] <= 128'h9ae3e1bfd889d318_81344168a8c8021e   ;
         buf_data_stage0[51][0] <= 128'hc398180c38caffd7_8913a944437be72c   ;
         buf_data_stage0[51][1] <= 128'h5769be83a1aff873_a09154537ca9af78   ;
         buf_data_stage0[51][2] <= 128'h40e639a7c067e319_67c133f45c8e5642   ;
         buf_data_stage0[51][3] <= 128'h484af27ff41fc8ce_ba32f0227aa6dc3b   ;
         buf_data_stage0[52][0] <= 128'hd79cc90aa516352e_98c6e387b6d4a728   ;
         buf_data_stage0[52][1] <= 128'hb2c847e9dc4363c1_a407f39b04c804df   ;
         buf_data_stage0[52][2] <= 128'h0e3ad74e485be598_c8965a2fcb3a8743   ;
         buf_data_stage0[52][3] <= 128'ha2a91de43f54785e_37e079c4ed3a3f1a   ;
         buf_data_stage0[53][0] <= 128'h38ad57d63b6ebd12_8eac3da8418d0ad0   ;
         buf_data_stage0[53][1] <= 128'h478a38cf268a625c_77f48838e36b9f32   ;
         buf_data_stage0[53][2] <= 128'h58be2489beb3a0e1_8db80ca1c1bc569e   ;
         buf_data_stage0[53][3] <= 128'h26a6cbacc67b70a5_0a0945b04cdbc2ea   ;
         buf_data_stage0[54][0] <= 128'he489eb510cbcac01_f867869c167fdf05   ;
         buf_data_stage0[54][1] <= 128'h9a6fbd29f01d3a8e_8c753d15d3c88b20   ;
         buf_data_stage0[54][2] <= 128'h456f9a1a5a8f8a35_1f762e3101d2fe36   ;
         buf_data_stage0[54][3] <= 128'h42407f15e9545468_b54ef21094dd51e6   ;
         buf_data_stage0[55][0] <= 128'ha697460fbe475779_2da6da812ce10161   ;
         buf_data_stage0[55][1] <= 128'h121d0f9208af78ae_8cb984ebc4e4d006   ;
         buf_data_stage0[55][2] <= 128'h13ba0dc5308326f5_676f89d9da059271   ;
         buf_data_stage0[55][3] <= 128'hbdffba837c90d665_e54b62ed0078198f   ;
         buf_data_stage0[56][0] <= 128'ha0ab7e95c458c04e_36d11d9ae31cc4c6   ;
         buf_data_stage0[56][1] <= 128'hc38f747a85de4aa4_830fb4843dded11c   ;
         buf_data_stage0[56][2] <= 128'h08e1dd39f4b32822_6cdff481a7e55282   ;
         buf_data_stage0[56][3] <= 128'h070bd10da3da4b6e_7500d9c66a5efd31   ;
         buf_data_stage0[57][0] <= 128'hff0f4098018c8ae7_75fbf22b1d4bbca1   ;
         buf_data_stage0[57][1] <= 128'h67207e18844b1704_2b6240a11aebd447   ;
         buf_data_stage0[57][2] <= 128'ha407f39b04c804df_b37f088a4dfd6a73   ;
         buf_data_stage0[57][3] <= 128'h571bdda6f0c75b5d_fb5a472d5b572075   ;
         buf_data_stage0[58][0] <= 128'h3bc10f75aa162847_bd6bbb1a325e80f5   ;
         buf_data_stage0[58][1] <= 128'h0808cabf73181c3c_b52c7a96cea85747   ;
         buf_data_stage0[58][2] <= 128'h421aaf4e7baf2eba_685128688bc6ed60   ;
         buf_data_stage0[58][3] <= 128'hc824673e55fbd908_8f5b6c01bef2c8e9   ;
         buf_data_stage0[59][0] <= 128'hbfb08ae0b9c1b5da_59157e3f1bcde14e   ;
         buf_data_stage0[59][1] <= 128'hfdeba23e89465e98_0eeb4fc8d71a1dce   ;
         buf_data_stage0[59][2] <= 128'hfa2a31f1570bcb93_75d65f2a2719395c   ;
         buf_data_stage0[59][3] <= 128'hf94bb5cc11fc3991_37dd91cf8aec8378   ;
         buf_data_stage0[60][0] <= 128'hca9e389bcf6275cd_f0cc3ddf72d20532   ;
         buf_data_stage0[60][1] <= 128'h386ad2740ffe1f9a_a29548a34debc5a1   ;
         buf_data_stage0[60][2] <= 128'h8cb984ebc4e4d006_c224f4d8b0e5e6d4   ;
         buf_data_stage0[60][3] <= 128'h6f8f800e93a24348_f2669703ab82ae0c   ;
         buf_data_stage0[61][0] <= 128'h8614fceadd5c2aa7_f4e07c743d5322f9   ;
         buf_data_stage0[61][1] <= 128'hbd063f1db48f1c30_5e51dffc1188236f   ;
         buf_data_stage0[61][2] <= 128'hc371151de75b1b8a_bb246379f220f3ba   ;
         buf_data_stage0[61][3] <= 128'h25925b86f8f38cab_e430e7b5e744c6b7   ;
         buf_data_stage0[62][0] <= 128'h616884339c3ac741_37b202532b6388a3   ;
         buf_data_stage0[62][1] <= 128'h2be7cff240dd89c8_93e420ae7ed19ebd   ;
         buf_data_stage0[62][2] <= 128'ha45b1e29219fed1b_d57d24906efda72d   ;
         buf_data_stage0[62][3] <= 128'h322df9137f93662b_cb0607f41dd73f96   ;
         buf_data_stage0[63][0] <= 128'h9ab4d5fb2ded1731_58c3de196dbcf497   ;
         buf_data_stage0[63][1] <= 128'h5b11501d07d1bfa5_d3946b6a55f9087f   ;
         buf_data_stage0[63][2] <= 128'h969e9096afde4510_48bb429405cd1ea3   ;
         buf_data_stage0[63][3] <= 128'h81efc17180eb1719_8823e9bc572210f5   ;
   
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
                     2'd0: Q <= buf_data_stage0[group_th][0];
                     2'd1: Q <= buf_data_stage0[group_th][1];
                     2'd2: Q <= buf_data_stage0[group_th][2];
                     2'd3: Q <= buf_data_stage0[group_th][3];
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
   always @(posedge CLK or negedge rst_n) begin
      if (~rst_n) begin
         group_th <= 6'd0;
      end else begin
         if (~CEN) begin
            if (cnt_0 == 4'd15) begin
               if (group_th == 6'd63) begin
                  group_th <= 6'd0;                  
               end else begin
                  group_th <= group_th + 6'd1;
               end
            end else begin
               group_th <= group_th;
            end
         end else begin
            group_th <= 6'd0;
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