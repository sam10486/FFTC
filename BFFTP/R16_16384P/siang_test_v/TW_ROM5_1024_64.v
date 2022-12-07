 `timescale 1 ns/1 ps     

 module TW_ROM5_1024_64(
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
         buf_data_stage0[0][0]   <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[0][1]   <= 128'h007fffffffffff80_3babf8a70b9016d7    ; // BC=64
         buf_data_stage0[0][2]   <= 128'h7fffffff00000001_fffffffdffff0002    ; // BC=128
         buf_data_stage0[0][3]   <= 128'h00000040003fffc0_fbc8a1ec30654b2b    ; // BC=192
         buf_data_stage0[1][0]   <= 128'h08dda69734d315e3_2db18ffce1c45c86    ;
         buf_data_stage0[1][1]   <= 128'hce471deb4ad63627_f90393edf4414910    ;
         buf_data_stage0[1][2]   <= 128'he596750d9ed85e3e_8e3e9403b2f01a35    ;
         buf_data_stage0[1][3]   <= 128'hda94e4ec0c8eaa0a_77cfc9aba435d602    ;
         buf_data_stage0[2][0]   <= 128'h9c4563b91246b28e_d5a7afcd075f52e8    ;
         buf_data_stage0[2][1]   <= 128'h00d74681ffcf7343_170cfff63fe1bc2f    ;
         buf_data_stage0[2][2]   <= 128'h76dca6b8d7460b24_48d2d0118a1fd85d    ;
         buf_data_stage0[2][3]   <= 128'h8018465e00535ce3_c027ece19abfd333    ;
         buf_data_stage0[3][0]   <= 128'h97017c5dccfb9554_02665526fe6cf647    ;
         buf_data_stage0[3][1]   <= 128'h58284e98530357c3_59413bb10e039b6e    ;
         buf_data_stage0[3][2]   <= 128'h1982355631fe88d9_ac6c08e50a8c4dd5    ;
         buf_data_stage0[3][3]   <= 128'h567e541e5595d32e_b64afd4ccbd73061    ;
         buf_data_stage0[4][0]   <= 128'he104978443ea74c5_616884339c3ac741    ;
         buf_data_stage0[4][1]   <= 128'ha25632a74833266b_50cd47280836f256    ;
         buf_data_stage0[4][2]   <= 128'h5e0ac59d92778625_df913b1b3662acde    ;
         buf_data_stage0[4][3]   <= 128'hdbe66cc9f544ac8a_b0a0b4a566ae8a4c    ;
         buf_data_stage0[5][0]   <= 128'h8614fceadd5c2aa7_04ed5c6d6ef8d494    ;
         buf_data_stage0[5][1]   <= 128'hbe703862dc38f430_e601f21c65127ba4    ;
         buf_data_stage0[5][2]   <= 128'h1151eaacb1b893c9_3499b7859f5235ef    ;
         buf_data_stage0[5][3]   <= 128'h91e385e7cd54964a_a8d03947cf7153c3    ;
         buf_data_stage0[6][0]   <= 128'hadb2dae29606e340_71b7f913eea00bdf    ;
         buf_data_stage0[6][1]   <= 128'h37dd91cf8aec8378_b5fec365eb9c5b65    ;
         buf_data_stage0[6][2]   <= 128'hb4fc8e5fa1dcdf12_184b93c9547976ab    ;
         buf_data_stage0[6][3]   <= 128'h3a89be43e1650aa4_50fd03004636d4ca    ;
         buf_data_stage0[7][0]   <= 128'h6b353155d3c8bdc5_d0b407bb096f67e3    ;
         buf_data_stage0[7][1]   <= 128'hf2d1393e70819ebf_c7e2c0d4a410a62b    ;
         buf_data_stage0[7][2]   <= 128'h961ba11d1f7ef78e_eed4bdf972414053    ;
         buf_data_stage0[7][3]   <= 128'h47bf30a0b1a96bff_9b19ede1c5c92ee3    ;
         buf_data_stage0[8][0]   <= 128'h36e6ee0a706c8023_2da6da812ce10161    ;
         buf_data_stage0[8][1]   <= 128'ha34130ebc46c44e5_d19ec4eac6cbfea4    ;
         buf_data_stage0[8][2]   <= 128'h47c9bfee53a9b717_f89da4165927098a    ;
         buf_data_stage0[8][3]   <= 128'h9dc9dd8d33d6bae9_744868f199c7952e    ;
         buf_data_stage0[9][0]   <= 128'h5175b4b04f3ef167_a24bf3098ca017ff    ;
         buf_data_stage0[9][1]   <= 128'h50cd47280836f256_9834d61b26044d35    ;
         buf_data_stage0[9][2]   <= 128'h5860874c505a530c_8055b91516edad55    ;
         buf_data_stage0[9][3]   <= 128'hfbe486d42c821cc0_03dff4927104bb85    ;
         buf_data_stage0[10][0]  <= 128'h6df0ad73a727ee35_6eaaf1601e58432f   ;
         buf_data_stage0[10][1]  <= 128'hdbfcd9ebb1fe596a_be47047694ffe73b   ;
         buf_data_stage0[10][2]  <= 128'hac6c08e50a8c4dd5_f0472fcd49d4a33b   ;
         buf_data_stage0[10][3]  <= 128'h2700d34b46fd99ab_6688c57e6c0ca9f9   ;
         buf_data_stage0[11][0]  <= 128'hbc455272609af01f_7248447c0fb718b0   ;
         buf_data_stage0[11][1]  <= 128'h260713e978f980bd_a41979575c1d72d2   ;
         buf_data_stage0[11][2]  <= 128'h4fb287f08e702149_abcc6550694fcf75   ;
         buf_data_stage0[11][3]  <= 128'hc3833fa0cf804a54_2a8a8cf78d659043   ;
         buf_data_stage0[12][0]  <= 128'hd922f0469ddab66c_1d99c647a348c31b   ;
         buf_data_stage0[12][1]  <= 128'hc7d6c99eeee94b9a_7a39f04306f2005f   ;
         buf_data_stage0[12][2]  <= 128'hb112a4c9bb7ed35a_966f7c01fdc7a6fd   ;
         buf_data_stage0[12][3]  <= 128'h888b5a32db600a9d_08ca7e7580cd6adc   ;
         buf_data_stage0[13][0]  <= 128'h1d99c647a348c31b_5eda60f9e21f8647   ;
         buf_data_stage0[13][1]  <= 128'he46e808037be014b_a2cd42a64c2068be   ;
         buf_data_stage0[13][2]  <= 128'hae5b9e71e07144b2_bce638bebab3461c   ;
         buf_data_stage0[13][3]  <= 128'h6420ff5a8e1640e6_7138a85486304e32   ;
         buf_data_stage0[14][0]  <= 128'he489eb510cbcac01_37b202532b6388a3   ;
         buf_data_stage0[14][1]  <= 128'h6410b55cf8b15ca7_06f7d43b4b9850e5   ;
         buf_data_stage0[14][2]  <= 128'hf9a1a9fef8a34baa_d2491446da72c2a9   ;
         buf_data_stage0[14][3]  <= 128'h03a751acae610902_e02c5c8a01ab2c19   ;
         buf_data_stage0[15][0]  <= 128'ha2cf6ca76b817fb4_a697460fbe475779   ;
         buf_data_stage0[15][1]  <= 128'hc5ff6cb7eb38fddc_3aa655c68237533d   ;
         buf_data_stage0[15][2]  <= 128'h4a3f40260728762e_fba843a80d664421   ;
         buf_data_stage0[15][3]  <= 128'h0a638112589c354a_2801efe569a0e3aa   ;
         buf_data_stage0[16][0]  <= 128'hba856751f25d9591_e09445e538924149   ;
         buf_data_stage0[16][1]  <= 128'h2ec5857427dec65f_3d0bbc95096d2482   ;
         buf_data_stage0[16][2]  <= 128'h86d1353756717e72_8187a590d7de67c3   ;
         buf_data_stage0[16][3]  <= 128'h6c109cd02b5225ea_39fd950521f71e23   ;
         buf_data_stage0[17][0]  <= 128'hdb637b6ddcd0b9f6_75581b7bdf565423   ;
         buf_data_stage0[17][1]  <= 128'h0030b100e046eb53_5373b2a9e173b1cd   ;
         buf_data_stage0[17][2]  <= 128'h1197a3055c1a1ab2_052d572f008be4f7   ;
         buf_data_stage0[17][3]  <= 128'h0fdc8a56703bce2a_6be2194b831ab7eb   ;
         buf_data_stage0[18][0]  <= 128'h754ae602f03d55b5_5e51dffc1188236f   ;
         buf_data_stage0[18][1]  <= 128'h36851cf7dfa2619d_36e7215477c311af   ;
         buf_data_stage0[18][2]  <= 128'h07e15525b2c41ddc_0e7b6cb74c6b61bd   ;
         buf_data_stage0[18][3]  <= 128'h902ecf310b13bf4b_66e83fa69cfb69eb   ;
         buf_data_stage0[19][0]  <= 128'ha3895b400ec4b7d2_4dc76dca1dcd7461   ;
         buf_data_stage0[19][1]  <= 128'hc459c201fd4af049_564d14c46123d6ca   ;
         buf_data_stage0[19][2]  <= 128'hf89da4165927098a_74682009f7342ff3   ;
         buf_data_stage0[19][3]  <= 128'h815a87db60d25926_8a1771c4e0a741dc   ;
         buf_data_stage0[20][0]  <= 128'h830fb4843dded11c_a407f39b04c804df   ;
         buf_data_stage0[20][1]  <= 128'h4844ad07ce36faff_da6973da315e2f73   ;
         buf_data_stage0[20][2]  <= 128'he1109771607742d1_079c5251a3f19c82   ;
         buf_data_stage0[20][3]  <= 128'h98e482800b3dd404_5ac6c4c5dc557db7   ;
         buf_data_stage0[21][0]  <= 128'h15f286cd98cfe484_a1fab4b0d751db41   ;
         buf_data_stage0[21][1]  <= 128'haf89011a31365cd6_08ae6749d3bd4fc1   ;
         buf_data_stage0[21][2]  <= 128'h33980dbdd76135a9_73fcab729e0c31ed   ;
         buf_data_stage0[21][3]  <= 128'he764d194705faef9_c4f8d3d28caabfba   ;
         buf_data_stage0[22][0]  <= 128'he8877758a3088f14_fbb64d16feeac6c6   ;
         buf_data_stage0[22][1]  <= 128'hf295d780cef2ae72_33ad23e2b5e0635d   ;
         buf_data_stage0[22][2]  <= 128'hae7bb875c5c80337_b3fd3e9933dc0f94   ;
         buf_data_stage0[22][3]  <= 128'h9886a8c6e0c442fa_263cb3158630baed   ;
         buf_data_stage0[23][0]  <= 128'hf31566a7f1f722b4_388e6fcba4e2fa28   ;
         buf_data_stage0[23][1]  <= 128'h2345a71eaffc2035_a2cb7187dda318f0   ;
         buf_data_stage0[23][2]  <= 128'h07046ea6728644ae_eb512865e349a283   ;
         buf_data_stage0[23][3]  <= 128'h2801efe569a0e3aa_b0d466a1677f2d44   ;
         buf_data_stage0[24][0]  <= 128'hc38f747a85de4aa4_b2c847e9dc4363c1   ;
         buf_data_stage0[24][1]  <= 128'hc788b17fd335f783_8f47b01167b0bf72   ;
         buf_data_stage0[24][2]  <= 128'hbd10daada4b6df90_dbd20d332b4b5e74   ;
         buf_data_stage0[24][3]  <= 128'h9665043e4d5f5482_e83d49953786fecc   ;
         buf_data_stage0[25][0]  <= 128'ha47c3fa8d52dc7c2_d438475a1493a4d2   ;
         buf_data_stage0[25][1]  <= 128'h774ac226945f4a4f_708afd81177c7d3e   ;
         buf_data_stage0[25][2]  <= 128'h95691c1ebcd503b6_a411726243fac065   ;
         buf_data_stage0[25][3]  <= 128'h35d05ad885d5063b_eb01faba0ac9eb4b   ;
         buf_data_stage0[26][0]  <= 128'h5b75961c6164d19f_f2eabbc252ec37a9   ;
         buf_data_stage0[26][1]  <= 128'h22e5a40a3f38c37a_50f396532eb49c6f   ;
         buf_data_stage0[26][2]  <= 128'h4f4d97305e6d33de_f15082800e2ee657   ;
         buf_data_stage0[26][3]  <= 128'he0639e42310f33c3_3af7e3e8e33983b6   ;
         buf_data_stage0[27][0]  <= 128'hb2c847e9dc4363c1_f310c4e2341aac63   ;
         buf_data_stage0[27][1]  <= 128'h714a2c69e9069a04_55c3a89b8e7e1651   ;
         buf_data_stage0[27][2]  <= 128'h91de4e1f4785d5d6_07022c727ac96456   ;
         buf_data_stage0[27][3]  <= 128'h0b7cb2fe2d286337_c8e6056ccdf114b1   ;
         buf_data_stage0[28][0]  <= 128'h68a0852b4d45c72e_bd063f1db48f1c30   ;
         buf_data_stage0[28][1]  <= 128'hdc640d07c741760f_c8135cf549572d86   ;
         buf_data_stage0[28][2]  <= 128'h595d1c68daf3262d_0c52723b55661854   ;
         buf_data_stage0[28][3]  <= 128'h9c5f44f851d2c18c_59b2c10fe3e5528f   ;
         buf_data_stage0[29][0]  <= 128'he917343e8a156490_4b947d9a81aa99d2   ;
         buf_data_stage0[29][1]  <= 128'hdbaaeaf7d5942229_349c47f25cf4c558   ;
         buf_data_stage0[29][2]  <= 128'hbaf54db7b9964c68_00ba98ef336d6301   ;
         buf_data_stage0[29][3]  <= 128'h9535eeeb589f8691_5b18a916cc3941e7   ;
         buf_data_stage0[30][0]  <= 128'h6525376dde5556c4_a4307ecaa9c9fd20   ;
         buf_data_stage0[30][1]  <= 128'h865373891e32e0ec_7fa8b77d0bbc5b76   ;
         buf_data_stage0[30][2]  <= 128'h10d5549e21bd4719_d76ab4e550db201c   ;
         buf_data_stage0[30][3]  <= 128'h70e68f89d2432a3b_3cc619252fef929c   ;
         buf_data_stage0[31][0]  <= 128'hd1df70583aa377bd_1ee20087ae155450   ;
         buf_data_stage0[31][1]  <= 128'h1ae5253581bde075_2ec5857427dec65f   ;
         buf_data_stage0[31][2]  <= 128'h62ae44218641740b_5162deb878a773ba   ;
         buf_data_stage0[31][3]  <= 128'hbf210fc4ce5182d6_52ace2fc90457a99   ;
         buf_data_stage0[32][0]  <= 128'h48bb429405cd1ea3_5ce12fcfabc79d87   ;
         buf_data_stage0[32][1]  <= 128'h3de19c67cf496a74_8024d1d331c08932   ;
         buf_data_stage0[32][2]  <= 128'h7d1970ae2744309c_246859d06b222a38   ;
         buf_data_stage0[32][3]  <= 128'h185b4ac60695836e_fc6bc4e828b3db2b   ;
         buf_data_stage0[33][0]  <= 128'h40dc1259d5a00847_03ed2eb1bfcfe13d   ;
         buf_data_stage0[33][1]  <= 128'he261a2f802f09e94_18106f7ac84403ea   ;
         buf_data_stage0[33][2]  <= 128'h952ffbdc0b3e0d51_117e5b05e28013dc   ;
         buf_data_stage0[33][3]  <= 128'hfe87b0b572a920c7_c8411bc0dc6a8b76   ;
         buf_data_stage0[34][0]  <= 128'h67c133f45c8e5642_1fd59ead28dba9eb   ;
         buf_data_stage0[34][1]  <= 128'h3a944cc8be72b76f_84ab5759394301ef   ;
         buf_data_stage0[34][2]  <= 128'hd1b8d4de6227c51c_38770d639ec6686e   ;
         buf_data_stage0[34][3]  <= 128'h20c6a4487c83821c_6f634022bbffddf4   ;
         buf_data_stage0[35][0]  <= 128'hbd74d2392089739d_8ddd90a1451f8409   ;
         buf_data_stage0[35][1]  <= 128'h30a727ca9e5732bc_5961cbcd4d19ea49   ;
         buf_data_stage0[35][2]  <= 128'hefbb4630eeff22ec_2a3ea8fa4ef4a288   ;
         buf_data_stage0[35][3]  <= 128'hb0d466a1677f2d44_e7186f3abc330f79   ;
         buf_data_stage0[36][0]  <= 128'h4f01ddbca741ea4d_418eb28ba7bb1e8b   ;
         buf_data_stage0[36][1]  <= 128'h83e4c279808fb7c4_5868e15a93b9b630   ;
         buf_data_stage0[36][2]  <= 128'h2c5f0ad97b21e405_a5b8f82acabf12a6   ;
         buf_data_stage0[36][3]  <= 128'h3fb8241e023a3d1f_8aeb5dad35f2eff4   ;
         buf_data_stage0[37][0]  <= 128'h8ddd90a1451f8409_b09f911815950e0f   ;
         buf_data_stage0[37][1]  <= 128'h665a3ed81f547d3d_5285317c06f7a6d9   ;
         buf_data_stage0[37][2]  <= 128'hdd703dfae97e8a56_59522bbcb8264fc7   ;
         buf_data_stage0[37][3]  <= 128'h7055c16142d75e0b_c78bffa9b2a42adb   ;
         buf_data_stage0[38][0]  <= 128'heeb43ab53470ad77_be5161bae8b301ef   ;
         buf_data_stage0[38][1]  <= 128'hbbfcdd446c97b284_ce03a5fb9dbd6da8   ;
         buf_data_stage0[38][2]  <= 128'he5c7a94411927417_b591570ca51621fc   ;
         buf_data_stage0[38][3]  <= 128'hc9b426bd944a47e5_bc462696fe19e1a8   ;
         buf_data_stage0[39][0]  <= 128'hc68e3b6d2f30c935_beda1eb60562cef9   ;
         buf_data_stage0[39][1]  <= 128'h09f9e169b0a08661_4d3779efa8dc3746   ;
         buf_data_stage0[39][2]  <= 128'he8679b64fadf8252_dbe66cc9f544ac8a   ;
         buf_data_stage0[39][3]  <= 128'ha7afbccedd4d33e6_dd33d2a5becdfe6e   ;
         buf_data_stage0[40][0]  <= 128'h5a2e7be66e2a21ea_58284e98530357c3   ;
         buf_data_stage0[40][1]  <= 128'hd0f921abf78adedf_639a80147e318bf2   ;
         buf_data_stage0[40][2]  <= 128'hc8eaef0a642c4ee9_5e63fd115368fe84   ;
         buf_data_stage0[40][3]  <= 128'h843a909064420046_01b9924255da6fa1   ;
         buf_data_stage0[41][0]  <= 128'h2a4595fa0b2602d5_f04d2d0f749d4cf4   ;
         buf_data_stage0[41][1]  <= 128'h44ba95e66fe3dfc9_c7972f9ac7e84cf0   ;
         buf_data_stage0[41][2]  <= 128'h7a6cfe951ab5cc68_5e524e2217f76a51   ;
         buf_data_stage0[41][3]  <= 128'h480e101b5a4f3ad8_087c239142904422   ;
         buf_data_stage0[42][0]  <= 128'h0c8138e3edb38e2b_8f5b6c01bef2c8e9   ;
         buf_data_stage0[42][1]  <= 128'h46da67c9b43bd023_66d0bf8577e51e08   ;
         buf_data_stage0[42][2]  <= 128'h892638e9fd1a6388_d50ae8c88565c447   ;
         buf_data_stage0[42][3]  <= 128'ha5e217edfd8b1bf7_c8950341c0ae445f   ;
         buf_data_stage0[43][0]  <= 128'h4bb8993938cece8e_b6b2246e6aaa4f1a   ;
         buf_data_stage0[43][1]  <= 128'h074fcaa4fbd67572_f39fe87a17c72a93   ;
         buf_data_stage0[43][2]  <= 128'h639898b8c243b3e4_70e68f89d2432a3b   ;
         buf_data_stage0[43][3]  <= 128'h8214c5468193200c_ffbdca05e0d506ae   ;
         buf_data_stage0[44][0]  <= 128'h5871d8d927628cf3_bb15aecc21063523   ;
         buf_data_stage0[44][1]  <= 128'had274485e1f99c7a_154541d39af775f7   ;
         buf_data_stage0[44][2]  <= 128'hec4eb985bfea32e7_302ceec1a6f99f05   ;
         buf_data_stage0[44][3]  <= 128'h0f0331c347907080_2334d9cc3a45cd10   ;
         buf_data_stage0[45][0]  <= 128'h0fbc22867a75ee4f_7b63067d2cd53e83   ;
         buf_data_stage0[45][1]  <= 128'h8cabf7b181c3bf80_90a290ff07fcc19c   ;
         buf_data_stage0[45][2]  <= 128'h42c508d84519086b_ccad194469b5c064   ;
         buf_data_stage0[45][3]  <= 128'h3f1e20400737db99_6703a5c4d703e33e   ;
         buf_data_stage0[46][0]  <= 128'h041006d855ca8e8c_b9303de8245bab45   ;
         buf_data_stage0[46][1]  <= 128'haa277919ae8bccb8_ba08e4b31f1a41e8   ;
         buf_data_stage0[46][2]  <= 128'hd51ab8b92ced4ab3_9dbb772f3247a25e   ;
         buf_data_stage0[46][3]  <= 128'h28ba19a42c59a2e9_fc31e4f4973be0a5   ;
         buf_data_stage0[47][0]  <= 128'hc465162d27278a78_125b796c87b311dc   ;
         buf_data_stage0[47][1]  <= 128'h20087ccf5544fe12_961ba11d1f7ef78e   ;
         buf_data_stage0[47][2]  <= 128'h6c6c3ac3f5c65053_fee0541488329da5   ;
         buf_data_stage0[47][3]  <= 128'h555d80f6baa6bd71_3f6352d7be0d2ec7   ;
         buf_data_stage0[48][0]  <= 128'h8a8df6e55efde538_fafdf655f12048fc   ;
         buf_data_stage0[48][1]  <= 128'hc7b40bfd0e189e58_6ee0aa74c8022c92   ;
         buf_data_stage0[48][2]  <= 128'h50810d63f4c5ee0f_1888cae6a3233a50   ;
         buf_data_stage0[48][3]  <= 128'h78f3b0d3eae6552b_8d889c8b0a5145e8   ;
         buf_data_stage0[49][0]  <= 128'h169f824723e40ffb_27b909aac8836bbe   ;
         buf_data_stage0[49][1]  <= 128'hd150ce69ea5ac0c3_e817dd796f1732d9   ;
         buf_data_stage0[49][2]  <= 128'hee0df8019d41c922_2dd1a405847e9d22   ;
         buf_data_stage0[49][3]  <= 128'h8ad29f9e5dd5c797_b36e75f82456f86b   ;
         buf_data_stage0[50][0]  <= 128'h53b340b5204653f4_d75b6a9730ff93af   ;
         buf_data_stage0[50][1]  <= 128'h7aefc86f821c0960_d6adb38461ab8f1b   ;
         buf_data_stage0[50][2]  <= 128'h6fdcd605b9fcca55_646863f674acd5a2   ;
         buf_data_stage0[50][3]  <= 128'h3ef1fb4ffe85e8e8_eacf388ba93f194e   ;
         buf_data_stage0[51][0]  <= 128'h266295c733de0c97_c824673e55fbd908   ;
         buf_data_stage0[51][1]  <= 128'hfdcf0b582d4c9443_0b5902ece7c0b13c   ;
         buf_data_stage0[51][2]  <= 128'he610f9b3ad205130_42c508d84519086b   ;
         buf_data_stage0[51][3]  <= 128'h6959b5de958dcfce_15525baa41ddbf82   ;
         buf_data_stage0[52][0]  <= 128'hf94bb5cc11fc3991_54e11979db75c1a2   ;
         buf_data_stage0[52][1]  <= 128'h08ae17971b5d9405_aa277919ae8bccb8   ;
         buf_data_stage0[52][2]  <= 128'h7701e33785a3f7af_0b100e076eb52ffd   ;
         buf_data_stage0[52][3]  <= 128'hf25135fc9205d5cf_d859da948bfbeffa   ;
         buf_data_stage0[53][0]  <= 128'h9ae3e1bfd889d318_b6bf46de259b9a8a   ;
         buf_data_stage0[53][1]  <= 128'hf9fb64aedadcbd74_b67171d591404e74   ;
         buf_data_stage0[53][2]  <= 128'h13bb167439b6da6c_9385891b41d19828   ;
         buf_data_stage0[53][3]  <= 128'h9291a145ea6c1112_fce969d9f93e76bc   ;
         buf_data_stage0[54][0]  <= 128'h322df9137f93662b_b37f088a4dfd6a73   ;
         buf_data_stage0[54][1]  <= 128'h88433fd9ac7409ea_296e346a2a37e2ff   ;
         buf_data_stage0[54][2]  <= 128'hc0364ce9d8e0afa0_a9779410970a267d   ;
         buf_data_stage0[54][3]  <= 128'h29c5fb0b1a5ba4e2_a15dc95a70a740d8   ;
         buf_data_stage0[55][0]  <= 128'hfafdf655f12048fc_02a71ddd26cc0928   ;
         buf_data_stage0[55][1]  <= 128'h29fd64ae4465735e_bc67bc18714b7ebc   ;
         buf_data_stage0[55][2]  <= 128'h076fdb82760f1fa9_bb56cd64204b29ad   ;
         buf_data_stage0[55][3]  <= 128'hddcd465037316c07_d29b5390aef7f73d   ;
         buf_data_stage0[56][0]  <= 128'hd16910f590d26cbf_eb74fb279398e703   ;
         buf_data_stage0[56][1]  <= 128'h25bfee051b98832a_08ae17971b5d9405   ;
         buf_data_stage0[56][2]  <= 128'hb796c9a0311dbedb_713e99ef980bcda0   ;
         buf_data_stage0[56][3]  <= 128'h7233be6aa0ac3898_cd0b47ee9006b44b   ;
         buf_data_stage0[57][0]  <= 128'h03972190f1fba71b_da8cd6f201eb6ffa   ;
         buf_data_stage0[57][1]  <= 128'h8a68355839b1a91e_1a180480f9f6fc4f   ;
         buf_data_stage0[57][2]  <= 128'h07022c727ac96456_2721b38e6c7f2179   ;
         buf_data_stage0[57][3]  <= 128'he3272b70620cef3c_0187efa217c01ae8   ;
         buf_data_stage0[58][0]  <= 128'h14dfb28c12daa34a_5c44d4ac776633ac   ;
         buf_data_stage0[58][1]  <= 128'h7b30273d4c9a7de0_31a95574bcb35167   ;
         buf_data_stage0[58][2]  <= 128'hf692ae5a13dd2aec_b3ecf8a89fff649e   ;
         buf_data_stage0[58][3]  <= 128'h59b2c10fe3e5528f_edd7c03b9cf5d886   ;
         buf_data_stage0[59][0]  <= 128'h54d38039cda45986_c435a8a134c43547   ;
         buf_data_stage0[59][1]  <= 128'h7626b51b10c2013e_6e9a8172367f4acb   ;
         buf_data_stage0[59][2]  <= 128'h192dd33d113bece0_2299d1bfc3b3a21e   ;
         buf_data_stage0[59][3]  <= 128'h779eff60c3745b2d_480e101b5a4f3ad8   ;
         buf_data_stage0[60][0]  <= 128'h40e639a7c067e319_98e1ddb5d8e380ba   ;
         buf_data_stage0[60][1]  <= 128'hed435feff80dcc93_a3319fc864a27b2a   ;
         buf_data_stage0[60][2]  <= 128'h9fcc0e7300a70e61_49660d80f10bf752   ;
         buf_data_stage0[60][3]  <= 128'h83f919b672a89642_fb947d018caabe25   ;
         buf_data_stage0[61][0]  <= 128'h58be2489beb3a0e1_7e1394abc498ed1b   ;
         buf_data_stage0[61][1]  <= 128'h564d14c46123d6ca_b4515cec8a127ded   ;
         buf_data_stage0[61][2]  <= 128'ha0a62f8f0bb8e2b6_a6bad0385591ffdb   ;
         buf_data_stage0[61][3]  <= 128'hcf6e149a5bb875c8_190043afc0778f2b   ;
         buf_data_stage0[62][0]  <= 128'ha407f39b04c804df_d296e39e11f5e6e8   ;
         buf_data_stage0[62][1]  <= 128'h3908962dce2928d6_5b37184fd19a529f   ;
         buf_data_stage0[62][2]  <= 128'hfd9bfd8fd467fc3e_0a6b348bfda59d1d   ;
         buf_data_stage0[62][3]  <= 128'h18eb6b950398df82_1615808fda32c626   ;
         buf_data_stage0[63][0]  <= 128'h969e9096afde4510_6a7c9217f0ce3407   ;
         buf_data_stage0[63][1]  <= 128'h840fa37ec53a39e1_d2abf21029ace519   ;
         buf_data_stage0[63][2]  <= 128'ha810dd77a33e6ad4_7d1970ae2744309c   ;
         buf_data_stage0[63][3]  <= 128'h1d62e30fa4a4eeb0_e4421e8e1740a9d6   ;
   
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