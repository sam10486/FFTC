 `timescale 1 ns/1 ps     

 module TW_ROM7_1024_64(
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
         buf_data_stage0[0][1]   <= 128'h0400000000000400_840fa37ec53a39e1    ; // BC=64
         buf_data_stage0[0][2]   <= 128'h0000001fffffffe0_00000040003fffc0    ; // BC=128
         buf_data_stage0[0][3]   <= 128'h00007fff7fff8000_2e60ca9625a7a426    ; // BC=192
         buf_data_stage0[1][0]   <= 128'h0776fe07a33f934f_6b551fea26657a45    ;
         buf_data_stage0[1][1]   <= 128'h36851cf7dfa2619d_e9c9602df84016dc    ;
         buf_data_stage0[1][2]   <= 128'h67f269dea92dd52c_9402ffcb227e9eef    ;
         buf_data_stage0[1][3]   <= 128'hf44c33983b102d65_1bbe39233467cb2a    ;
         buf_data_stage0[2][0]   <= 128'hbcd5c57029b9c4d3_b5609d15159f67c6    ;
         buf_data_stage0[2][1]   <= 128'h63bcaaad23790ae4_7621448999cf98c3    ;
         buf_data_stage0[2][2]   <= 128'h37389a482e0eb79b_ad4cb15331517114    ;
         buf_data_stage0[2][3]   <= 128'h6f215c7319494ddc_966a2cd9346b2489    ;
         buf_data_stage0[3][0]   <= 128'h32c3f888d962f857_9c4563b91246b28e    ;
         buf_data_stage0[3][1]   <= 128'h8f47b01167b0bf72_564d14c46123d6ca    ;
         buf_data_stage0[3][2]   <= 128'h2c5f0ad97b21e405_8018465e00535ce3    ;
         buf_data_stage0[3][3]   <= 128'hf617ee2d20f20f94_7a238ea4d62f8923    ;
         buf_data_stage0[4][0]   <= 128'hc398180c38caffd7_e489eb510cbcac01    ;
         buf_data_stage0[4][1]   <= 128'hed435feff80dcc93_d150ce69ea5ac0c3    ;
         buf_data_stage0[4][2]   <= 128'h195ffac7739d0399_03a751acae610902    ;
         buf_data_stage0[4][3]   <= 128'h01b9924255da6fa1_315f1b6f45a7e092    ;
         buf_data_stage0[5][0]   <= 128'h5356e9a7c3d367f5_f4e07c743d5322f9    ;
         buf_data_stage0[5][1]   <= 128'hceb5edfbad43296d_d623104607204bfa    ;
         buf_data_stage0[5][2]   <= 128'h7a6cfe951ab5cc68_72154aea311aec92    ;
         buf_data_stage0[5][3]   <= 128'ha8652d8580dd12eb_d9ca4f20ad73673b    ;
         buf_data_stage0[6][0]   <= 128'h8614fceadd5c2aa7_ca29fe77059fada5    ;
         buf_data_stage0[6][1]   <= 128'h9b691e37c31cd54a_18ffd0f745c85d25    ;
         buf_data_stage0[6][2]   <= 128'hab8554ce91db0dc5_05df5b7876a26e7f    ;
         buf_data_stage0[6][3]   <= 128'h639aa92c2f418fc8_afeefb44972e38fb    ;
         buf_data_stage0[7][0]   <= 128'hca229fd580c44658_e104978443ea74c5    ;
         buf_data_stage0[7][1]   <= 128'h40826a44b7edc13f_7626b51b10c2013e    ;
         buf_data_stage0[7][2]   <= 128'h1888cae6a3233a50_dbe66cc9f544ac8a    ;
         buf_data_stage0[7][3]   <= 128'hfdb827d6f1fa8f8a_7762098f9534e00f    ;
         buf_data_stage0[8][0]   <= 128'hf834bb1a0a3df986_68a0852b4d45c72e    ;
         buf_data_stage0[8][1]   <= 128'h531563ef8bdc494d_30a727ca9e5732bc    ;
         buf_data_stage0[8][2]   <= 128'h47bf30a0b1a96bff_9c5f44f851d2c18c    ;
         buf_data_stage0[8][3]   <= 128'h7b89299521ca586f_88806e89ef5d348f    ;
         buf_data_stage0[9][0]   <= 128'ha05107e6c4808d71_8ead190fdecaa1f9    ;
         buf_data_stage0[9][1]   <= 128'ha3319fc864a27b2a_e817dd796f1732d9    ;
         buf_data_stage0[9][2]   <= 128'h9011ae0b65cd5508_f6c3dc0a202d9283    ;
         buf_data_stage0[9][3]   <= 128'h944f652b057ca1b4_246281c9ea41e56d    ;
         buf_data_stage0[10][0]  <= 128'ha47c3fa8d52dc7c2_bba3cbff6b007910   ;
         buf_data_stage0[10][1]  <= 128'h9c535d0511385d51_550dd143a5fdc5a2   ;
         buf_data_stage0[10][2]  <= 128'ha5b8f82acabf12a6_c027ece19abfd333   ;
         buf_data_stage0[10][3]  <= 128'h270baa0c4e88b53e_d0702b4fa5850323   ;
         buf_data_stage0[11][0]  <= 128'h386ad2740ffe1f9a_a47c3fa8d52dc7c2   ;
         buf_data_stage0[11][1]  <= 128'he389c99f275cc357_bbfcdd446c97b284   ;
         buf_data_stage0[11][2]  <= 128'hffc3f337f2e1be3f_35d05ad885d5063b   ;
         buf_data_stage0[11][3]  <= 128'heb986ac2a32e613c_7736c5f47bad0eae   ;
         buf_data_stage0[12][0]  <= 128'hbc455272609af01f_6df0ad73a727ee35   ;
         buf_data_stage0[12][1]  <= 128'h5acc38339f4cf805_f9fb64aedadcbd74   ;
         buf_data_stage0[12][2]  <= 128'h135e03c863f7add4_2700d34b46fd99ab   ;
         buf_data_stage0[12][3]  <= 128'he99f0093bcd9f8ed_e32492c926b8f871   ;
         buf_data_stage0[13][0]  <= 128'h7248447c0fb718b0_6eaaf1601e58432f   ;
         buf_data_stage0[13][1]  <= 128'hd150ce69ea5ac0c3_a273580023ba9a38   ;
         buf_data_stage0[13][2]  <= 128'hf6e315f0c0145a7f_ee340c708ad7317d   ;
         buf_data_stage0[13][3]  <= 128'h4b5818458a8e1a63_eed81953025ad522   ;
         buf_data_stage0[14][0]  <= 128'h8913a944437be72c_f867869c167fdf05   ;
         buf_data_stage0[14][1]  <= 128'h0fb302cedc6a6f9a_6ba79115d33f8470   ;
         buf_data_stage0[14][2]  <= 128'h6f7ce56e6e0df1f8_473b7adb07287dd9   ;
         buf_data_stage0[14][3]  <= 128'h8d4df33d7c51b2e5_1570d5aa621fb4a7   ;
         buf_data_stage0[15][0]  <= 128'hadda166b62c2ba2c_36e6ee0a706c8023   ;
         buf_data_stage0[15][1]  <= 128'hc5e4bb2a5aa63a07_29fd64ae4465735e   ;
         buf_data_stage0[15][2]  <= 128'h58574569ec65ed14_9dc9dd8d33d6bae9   ;
         buf_data_stage0[15][3]  <= 128'h54c740c6eea159d5_44f8702b3ebf7d96   ;
         buf_data_stage0[16][0]  <= 128'h9d24a3f365407288_d16910f590d26cbf   ;
         buf_data_stage0[16][1]  <= 128'h8024d1d331c08932_961ba11d1f7ef78e   ;
         buf_data_stage0[16][2]  <= 128'ha80e50ebb35d3094_7233be6aa0ac3898   ;
         buf_data_stage0[16][3]  <= 128'h3811262fc3549f5a_272b4a007cb44e50   ;
         buf_data_stage0[17][0]  <= 128'h58be2489beb3a0e1_fb466140b287e819   ;
         buf_data_stage0[17][1]  <= 128'ha38cf6e0a625bb88_88affa10302c027a   ;
         buf_data_stage0[17][2]  <= 128'hd6741c1411c752a9_f2657992926ed7fc   ;
         buf_data_stage0[17][3]  <= 128'hc4b770eac9a9b2ec_8f2ed55c675eb176   ;
         buf_data_stage0[18][0]  <= 128'h4bff3d3bb07ee453_554046c4a3938c8d   ;
         buf_data_stage0[18][1]  <= 128'h37b6eb830b9f524a_ab4b17941db405e1   ;
         buf_data_stage0[18][2]  <= 128'h0fdc8a56703bce2a_9621581eee35db86   ;
         buf_data_stage0[18][3]  <= 128'h73ea49389538465f_5233b7dc384dcff3   ;
         buf_data_stage0[19][0]  <= 128'hecf8e718ecd8cf70_14dfb28c12daa34a   ;
         buf_data_stage0[19][1]  <= 128'h074fcaa4fbd67572_1151eaacb1b893c9   ;
         buf_data_stage0[19][2]  <= 128'h9b19ede1c5c92ee3_59b2c10fe3e5528f   ;
         buf_data_stage0[19][3]  <= 128'h7aceae3e9b37fd21_1955b4db2f9c0e19   ;
         buf_data_stage0[20][0]  <= 128'h266295c733de0c97_322df9137f93662b   ;
         buf_data_stage0[20][1]  <= 128'h0326959b5ac958dd_5860874c505a530c   ;
         buf_data_stage0[20][2]  <= 128'h7bc192dab7ebb43a_29c5fb0b1a5ba4e2   ;
         buf_data_stage0[20][3]  <= 128'h592b1b9f420230f5_e9bef19f943351cb   ;
         buf_data_stage0[21][0]  <= 128'h42a8f15d4dc607a7_449bf2aaecd669f9   ;
         buf_data_stage0[21][1]  <= 128'hb4fc8e5fa1dcdf12_d8ee035ac2ceaa0e   ;
         buf_data_stage0[21][2]  <= 128'hb8c0f4d6f220df77_e066dac52197b009   ;
         buf_data_stage0[21][3]  <= 128'h3b9be22924d251cc_8a917274941e6a4f   ;
         buf_data_stage0[22][0]  <= 128'h22bac6c06ba0a8c5_9eb26db8148079c4   ;
         buf_data_stage0[22][1]  <= 128'h00c984dc8069a5b7_5a48b7562e44e82e   ;
         buf_data_stage0[22][2]  <= 128'h7415189b34920f53_8e4b3d91a41e7460   ;
         buf_data_stage0[22][3]  <= 128'h0d34b6dfd99aad90_66dc2ed0e8018cc7   ;
         buf_data_stage0[23][0]  <= 128'hb2cc1aa6fcf0b4de_266295c733de0c97   ;
         buf_data_stage0[23][1]  <= 128'h445e6192241481f7_b112a4c9bb7ed35a   ;
         buf_data_stage0[23][2]  <= 128'h9e169ba908660f61_6959b5de958dcfce   ;
         buf_data_stage0[23][3]  <= 128'h82903ed6f1a38edc_124ffab1b1f5b268   ;
         buf_data_stage0[24][0]  <= 128'hf31566a7f1f722b4_830fb4843dded11c   ;
         buf_data_stage0[24][1]  <= 128'hc562801e38f69a0f_074fcaa4fbd67572   ;
         buf_data_stage0[24][2]  <= 128'h3ee456615e6ed482_98e482800b3dd404   ;
         buf_data_stage0[24][3]  <= 128'h1ed341c734dcba59_9ede260d92ee264f   ;
         buf_data_stage0[25][0]  <= 128'ha29548a34debc5a1_508baa02512a9634   ;
         buf_data_stage0[25][1]  <= 128'h665a3ed81f547d3d_d643cc60bc12fefa   ;
         buf_data_stage0[25][2]  <= 128'hbd78b40aefde3777_cb4dfa7b1f5bcf82   ;
         buf_data_stage0[25][3]  <= 128'hea8fa7924a287d5d_1d2453fd2897985e   ;
         buf_data_stage0[26][0]  <= 128'ha45b1e29219fed1b_356866e5b199e2d5   ;
         buf_data_stage0[26][1]  <= 128'h7cff26cbd89c7d42_281ca3b32a618ee7   ;
         buf_data_stage0[26][2]  <= 128'h33fda34b409e977c_1ff275c4f4a0373a   ;
         buf_data_stage0[26][3]  <= 128'h138fa8304c8b7e45_853859421a29524d   ;
         buf_data_stage0[27][0]  <= 128'h388e6fcba4e2fa28_a407f39b04c804df   ;
         buf_data_stage0[27][1]  <= 128'h0852bb5e5c72d976_e596750d9ed85e3e   ;
         buf_data_stage0[27][2]  <= 128'h9c5f44f851d2c18c_18eb6b950398df82   ;
         buf_data_stage0[27][3]  <= 128'h8e5b2ebe674d6575_f9b8aafa7391c77c   ;
         buf_data_stage0[28][0]  <= 128'h8ba4d377135a8dc4_754ae602f03d55b5   ;
         buf_data_stage0[28][1]  <= 128'h7f9b48b28bbb104d_8cabf7b181c3bf80   ;
         buf_data_stage0[28][2]  <= 128'h6b51b86e2013d89e_902ecf310b13bf4b   ;
         buf_data_stage0[28][3]  <= 128'h7762098f9534e00f_5d737bca43ef08a2   ;
         buf_data_stage0[29][0]  <= 128'h1c2e596734b9ed86_9275285285506f7b   ;
         buf_data_stage0[29][1]  <= 128'h6e3884f94a727674_43c23e23a915de89   ;
         buf_data_stage0[29][2]  <= 128'h973db0bbe2f7225a_68e1d000ed356f55   ;
         buf_data_stage0[29][3]  <= 128'h4e4ece71eaa09257_ce72d8356c27e447   ;
         buf_data_stage0[30][0]  <= 128'h286e45fdd32107fb_393c6024d691f175   ;
         buf_data_stage0[30][1]  <= 128'h9c647c0d8c31ae27_4d300b054b308fc2   ;
         buf_data_stage0[30][2]  <= 128'h6420ff5a8e1640e6_adc050c5699d4a73   ;
         buf_data_stage0[30][3]  <= 128'h8635c4cbed3ab96f_8d8a0892d846022b   ;
         buf_data_stage0[31][0]  <= 128'h0c26e0b997ad762f_ba856751f25d9591   ;
         buf_data_stage0[31][1]  <= 128'h3de19c67cf496a74_20087ccf5544fe12   ;
         buf_data_stage0[31][2]  <= 128'hf5aec5dd857522ee_6c109cd02b5225ea   ;
         buf_data_stage0[31][3]  <= 128'he92d4e775a9f2487_851cd7d63119458c   ;
         buf_data_stage0[32][0]  <= 128'h8823e9bc572210f5_c5ff6cb7eb38fddc   ;
         buf_data_stage0[32][1]  <= 128'h55037bc094c6b9f5_50810d63f4c5ee0f   ;
         buf_data_stage0[32][2]  <= 128'he4421e8e1740a9d6_fc6bc4e828b3db2b   ;
         buf_data_stage0[32][3]  <= 128'h98d73e94c6b9494e_8a8cd56a31ed0300   ;
         buf_data_stage0[33][0]  <= 128'h5ab6fdcd05ab9fcd_6fbbde080c67b343   ;
         buf_data_stage0[33][1]  <= 128'h440de40078fda81f_d2d1064dd4cf30fc   ;
         buf_data_stage0[33][2]  <= 128'hb573f993f3ac4cc0_9c0bd987c7bfbe46   ;
         buf_data_stage0[33][3]  <= 128'h1fb503d75e8e7c11_c77626d856bd794a   ;
         buf_data_stage0[34][0]  <= 128'h37e079c4ed3a3f1a_45510f2e44f215fd   ;
         buf_data_stage0[34][1]  <= 128'hfd9bfd8fd467fc3e_845d69385900af9b   ;
         buf_data_stage0[34][2]  <= 128'ha747e3385ca8e423_08280ff7ee6560eb   ;
         buf_data_stage0[34][3]  <= 128'h8cff879fbf80c646_8e633e248f18b3d0   ;
         buf_data_stage0[35][0]  <= 128'ha25632a74833266b_e46e808037be014b   ;
         buf_data_stage0[35][1]  <= 128'ha1eb6c432cef8413_6fdcd605b9fcca55   ;
         buf_data_stage0[35][2]  <= 128'h0664cd4baed4ddb7_0fc75da747667192   ;
         buf_data_stage0[35][3]  <= 128'h9df0824b24a1f53b_00bd0b8c1ebbf21c   ;
         buf_data_stage0[36][0]  <= 128'hd14efbb391ceeff3_865373891e32e0ec   ;
         buf_data_stage0[36][1]  <= 128'hd6360d4b6a33510d_952ffbdc0b3e0d51   ;
         buf_data_stage0[36][2]  <= 128'h39ddfe459c428b2e_6f215c7319494ddc   ;
         buf_data_stage0[36][3]  <= 128'h466a2184f2d434f3_c6ab6f9c389868bf   ;
         buf_data_stage0[37][0]  <= 128'h50cd47280836f256_a2cd42a64c2068be   ;
         buf_data_stage0[37][1]  <= 128'h2d3d7d2d3a6545d7_092a2a65c5fbbccc   ;
         buf_data_stage0[37][2]  <= 128'h06de4ab5df78d03f_b1d5eac173ec739d   ;
         buf_data_stage0[37][3]  <= 128'h4ca8bada0ba79f79_1862fc776983e904   ;
         buf_data_stage0[38][0]  <= 128'h229a78d0a6cb9857_808a0180758e1de9   ;
         buf_data_stage0[38][1]  <= 128'h087e7186eb3bc331_fbe42146eeff0587   ;
         buf_data_stage0[38][2]  <= 128'hd9730adad33ddb0c_c3c50026f4180323   ;
         buf_data_stage0[38][3]  <= 128'h6778661e88b96903_11bc1a4aa8b7537c   ;
         buf_data_stage0[39][0]  <= 128'h78bc1b78d421d485_260713e978f980bd   ;
         buf_data_stage0[39][1]  <= 128'he7be6c84a21e9a5e_7701e33785a3f7af   ;
         buf_data_stage0[39][2]  <= 128'h843a909064420046_38c7ef5b6f11549d   ;
         buf_data_stage0[39][3]  <= 128'h43d34ba2c45f23ac_36fd1518c22b85e6   ;
         buf_data_stage0[40][0]  <= 128'hc788b17fd335f783_c459c201fd4af049   ;
         buf_data_stage0[40][1]  <= 128'h2e12da48d5730e3e_ec4eb985bfea32e7   ;
         buf_data_stage0[40][2]  <= 128'h66bef046a82adfa6_d36c7b3aa8e256d1   ;
         buf_data_stage0[40][3]  <= 128'hae61c7b98f42ef26_5c37c7bfab49d122   ;
         buf_data_stage0[41][0]  <= 128'h04445b5b936a0565_2361ecff96ab9783   ;
         buf_data_stage0[41][1]  <= 128'h13bb167439b6da6c_aa50779a25f39521   ;
         buf_data_stage0[41][2]  <= 128'h6d40ac9f0a33e7ee_ead464175d5606e0   ;
         buf_data_stage0[41][3]  <= 128'h36db4d7d51c1e3f9_6399591837123d19   ;
         buf_data_stage0[42][0]  <= 128'h1a379bc281163941_792387705d19ec67   ;
         buf_data_stage0[42][1]  <= 128'hec7363514e77cc44_4e70f4a1b1a01196   ;
         buf_data_stage0[42][2]  <= 128'h22c7281c96455f90_22b0a8fe8a44c147   ;
         buf_data_stage0[42][3]  <= 128'hcef98861a29a0d57_908469ad612ad5d7   ;
         buf_data_stage0[43][0]  <= 128'h653bb56c711204b3_f295d780cef2ae72   ;
         buf_data_stage0[43][1]  <= 128'h6c99fb6b94b99383_7a6cfe951ab5cc68   ;
         buf_data_stage0[43][2]  <= 128'h224096533648bc12_9d1bfe643a21ddd7   ;
         buf_data_stage0[43][3]  <= 128'h97327051d58e222e_52d86293d12ea57a   ;
         buf_data_stage0[44][0]  <= 128'h3c12decf884bb921_22e5a40a3f38c37a   ;
         buf_data_stage0[44][1]  <= 128'h0d9c6df5efd308b0_dd703dfae97e8a56   ;
         buf_data_stage0[44][2]  <= 128'h09772418742d01ef_d0c9661056dd6588   ;
         buf_data_stage0[44][3]  <= 128'hfa6115fd52112b43_de9450f9d9968fb7   ;
         buf_data_stage0[45][0]  <= 128'h54dd51ab36c2ced5_1e64bd01ca206b88   ;
         buf_data_stage0[45][1]  <= 128'h7621b9695d0cd22b_15a1f0aca2e6d4b2   ;
         buf_data_stage0[45][2]  <= 128'hd859da948bfbeffa_c8950341c0ae445f   ;
         buf_data_stage0[45][3]  <= 128'ha19a45509a2e8d75_e4e34eab0a493fdc   ;
         buf_data_stage0[46][0]  <= 128'h8e248d648ca2e7d4_e019ff3dff6fdd7f   ;
         buf_data_stage0[46][1]  <= 128'h74682009f7342ff3_2721b38e6c7f2179   ;
         buf_data_stage0[46][2]  <= 128'h945cfa6da71158ef_abaf41fe7d10ca41   ;
         buf_data_stage0[46][3]  <= 128'he685fe508c760062_036d466b7600f5b8   ;
         buf_data_stage0[47][0]  <= 128'h954aa1c27e804547_c788b17fd335f783   ;
         buf_data_stage0[47][1]  <= 128'h50810d63f4c5ee0f_e8679b64fadf8252   ;
         buf_data_stage0[47][2]  <= 128'hd008a8cc86a31ed1_2da4903830e3dd1f   ;
         buf_data_stage0[47][3]  <= 128'h98bdc1d5572091a2_9159660cc27e785b   ;
         buf_data_stage0[48][0]  <= 128'hc465162d27278a78_5a2e7be66e2a21ea   ;
         buf_data_stage0[48][1]  <= 128'h28f555d7e67baa6c_07046ea6728644ae   ;
         buf_data_stage0[48][2]  <= 128'he4f14ee68e6beb5c_843a909064420046   ;
         buf_data_stage0[48][3]  <= 128'hcf754d7a11dff784_4b2f8e2ac8d169c8   ;
         buf_data_stage0[49][0]  <= 128'he1a41ab1a2a0e9d9_f9ba41162c743fad   ;
         buf_data_stage0[49][1]  <= 128'hbaf54db7b9964c68_1a0cfd7a80fd5d7b   ;
         buf_data_stage0[49][2]  <= 128'h541d3b03775f6eac_62d976a15f6160a5   ;
         buf_data_stage0[49][3]  <= 128'h32c98ce86e8cbc09_9dfe214f9c22bf61   ;
         buf_data_stage0[50][0]  <= 128'hdd852b82d0d4fffa_aaae4285d8f4edc9   ;
         buf_data_stage0[50][1]  <= 128'h07f162b945467bdc_944fce96095f93e8   ;
         buf_data_stage0[50][2]  <= 128'h1a9fff2434ba9066_dedc5ae0894940ba   ;
         buf_data_stage0[50][3]  <= 128'ha8cf7b7e59042d58_fd8c65b28e024c8b   ;
         buf_data_stage0[51][0]  <= 128'h13dd47a18f9289b0_0c8138e3edb38e2b   ;
         buf_data_stage0[51][1]  <= 128'hbb5cd0b3c399006c_33980dbdd76135a9   ;
         buf_data_stage0[51][2]  <= 128'hf25135fc9205d5cf_a5e217edfd8b1bf7   ;
         buf_data_stage0[51][3]  <= 128'h73200d682145dc08_47d02883abe24047   ;
         buf_data_stage0[52][0]  <= 128'h96495fa8c7bfa7cc_37dd91cf8aec8378   ;
         buf_data_stage0[52][1]  <= 128'hf89da4165927098a_07022c727ac96456   ;
         buf_data_stage0[52][2]  <= 128'hf7f4f96c3edf1168_2f1190772b6cb6b9   ;
         buf_data_stage0[52][3]  <= 128'h24e13120c76a4bf5_cef98861a29a0d57   ;
         buf_data_stage0[53][0]  <= 128'h0d100c8ade4da136_81344168a8c8021e   ;
         buf_data_stage0[53][1]  <= 128'h43ab62320ad76115_9db38972215640e4   ;
         buf_data_stage0[53][2]  <= 128'hc9b426bd944a47e5_8c4b0670084ed146   ;
         buf_data_stage0[53][3]  <= 128'h5aec22972fa7971f_b23ffb4a7665fd96   ;
         buf_data_stage0[54][0]  <= 128'h0c8138e3edb38e2b_cb0607f41dd73f96   ;
         buf_data_stage0[54][1]  <= 128'h409a5e213e4fd8b2_f6b273a8dd74dec9   ;
         buf_data_stage0[54][2]  <= 128'hb671c55db9671e23_730a1c9eadfb5bf7   ;
         buf_data_stage0[54][3]  <= 128'hc9fb163722b92599_47acbbd6a82db6ec   ;
         buf_data_stage0[55][0]  <= 128'h125b796c87b311dc_58284e98530357c3   ;
         buf_data_stage0[55][1]  <= 128'h90047eaf19df358a_9fcc0e7300a70e61   ;
         buf_data_stage0[55][2]  <= 128'hf6623b7cbe2e96f0_6700bb9325c05f18   ;
         buf_data_stage0[55][3]  <= 128'h3be6b12dc38978dd_c6abb4de7b50d7fd   ;
         buf_data_stage0[56][0]  <= 128'haeba188cd9e2730b_4f01ddbca741ea4d   ;
         buf_data_stage0[56][1]  <= 128'h47c9bfee53a9b717_91de4e1f4785d5d6   ;
         buf_data_stage0[56][2]  <= 128'h3c4e6149ec6e8d05_3fb8241e023a3d1f   ;
         buf_data_stage0[56][3]  <= 128'h7536e2d691911f56_696bce641c528b1b   ;
         buf_data_stage0[57][0]  <= 128'h7e133f628acd9609_7a93239e44b996b6   ;
         buf_data_stage0[57][1]  <= 128'hfb28c27aaa349eb3_1a351fb4996e7efe   ;
         buf_data_stage0[57][2]  <= 128'h59b2c10fe3e5528f_1615808fda32c626   ;
         buf_data_stage0[57][3]  <= 128'h4693d6405453da4b_48cca860d691c612   ;
         buf_data_stage0[58][0]  <= 128'hcc9ae7babacc5c81_b056b27b51487fcd   ;
         buf_data_stage0[58][1]  <= 128'h5a8a1f8f435463bd_8ccd4b9a5e5928ff   ;
         buf_data_stage0[58][2]  <= 128'h598b900613177889_f1205adf8b475840   ;
         buf_data_stage0[58][3]  <= 128'h6a8c7794442f9678_7d05093975ffa656   ;
         buf_data_stage0[59][0]  <= 128'h3fa0e866c11aab26_041006d855ca8e8c   ;
         buf_data_stage0[59][1]  <= 128'hb6a606aecea9a8b4_1197a3055c1a1ab2   ;
         buf_data_stage0[59][2]  <= 128'h235564b7e88d8e68_28ba19a42c59a2e9   ;
         buf_data_stage0[59][3]  <= 128'hd5351668560a13a7_c7e218ea400c2c41   ;
         buf_data_stage0[60][0]  <= 128'ha2a91de43f54785e_67c133f45c8e5642   ;
         buf_data_stage0[60][1]  <= 128'had74e568be597f1d_baf54db7b9964c68   ;
         buf_data_stage0[60][2]  <= 128'hea8f0baac04d37b9_20c6a4487c83821c   ;
         buf_data_stage0[60][3]  <= 128'hcb2fe38986336f49_d3b03cb6f6eababf   ;
         buf_data_stage0[61][0]  <= 128'h40dc1259d5a00847_8db80ca1c1bc569e   ;
         buf_data_stage0[61][1]  <= 128'hf39fe87a17c72a93_3499b7859f5235ef   ;
         buf_data_stage0[61][2]  <= 128'hb40108d7307cabe6_97a98474ca43c20d   ;
         buf_data_stage0[61][3]  <= 128'hf8e55240931d9e5e_b60276ad80b77c6b   ;
         buf_data_stage0[62][0]  <= 128'hc824673e55fbd908_b37f088a4dfd6a73   ;
         buf_data_stage0[62][1]  <= 128'haaf4ebdbf2eb9bdf_44b6ae40a3529d31   ;
         buf_data_stage0[62][2]  <= 128'hbf7b20e63bf7f736_a21afbaf3d7660eb   ;
         buf_data_stage0[62][3]  <= 128'h5d737bca43ef08a2_64e14e8149dbf5ec   ;
         buf_data_stage0[63][0]  <= 128'h81efc17180eb1719_48bb429405cd1ea3   ;
         buf_data_stage0[63][1]  <= 128'he9097466e450f697_62ae44218641740b   ;
         buf_data_stage0[63][2]  <= 128'h1d62e30fa4a4eeb0_185b4ac60695836e   ;
         buf_data_stage0[63][3]  <= 128'h8a1ed2c254b2a044_98d73e94c6b9494e   ;
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'h0400000000000400_840fa37ec53a39e1; // BC=64
         buf_data_stage1[0][2] <= 128'h0000001fffffffe0_00000040003fffc0; // BC=128
         buf_data_stage1[0][3] <= 128'h00007fff7fff8000_2e60ca9625a7a426; // BC=192

         buf_data_stage1[1][0] <= 128'h0c26e0b997ad762f_ba856751f25d9591; // BC=16
         buf_data_stage1[1][1] <= 128'h3de19c67cf496a74_20087ccf5544fe12;
         buf_data_stage1[1][2] <= 128'hf5aec5dd857522ee_6c109cd02b5225ea;
         buf_data_stage1[1][3] <= 128'he92d4e775a9f2487_851cd7d63119458c;
         buf_data_stage1[2][0] <= 128'h8823e9bc572210f5_c5ff6cb7eb38fddc; // BC=32
         buf_data_stage1[2][1] <= 128'h55037bc094c6b9f5_50810d63f4c5ee0f;
         buf_data_stage1[2][2] <= 128'he4421e8e1740a9d6_fc6bc4e828b3db2b;
         buf_data_stage1[2][3] <= 128'h98d73e94c6b9494e_8a8cd56a31ed0300;
         buf_data_stage1[3][0] <= 128'h81efc17180eb1719_48bb429405cd1ea3; // BC=48
         buf_data_stage1[3][1] <= 128'he9097466e450f697_62ae44218641740b;
         buf_data_stage1[3][2] <= 128'h1d62e30fa4a4eeb0_185b4ac60695836e;
         buf_data_stage1[3][3] <= 128'h8a1ed2c254b2a044_98d73e94c6b9494e;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'hfffffbff00000001_1fffffffe0000000; // BC=64
         buf_data_stage2[2] <= 128'h000ffffffff00000_fbffffff04000001; // BC=128
         buf_data_stage2[3] <= 128'h0000000040000000_007fffffff800000; // BC=192
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
         buf_const[0] <= 128'hfffffbff00000001_1fffffffe0000000;
         buf_const[1] <= 128'hfffffbff00000001_1fffffffe0000000;
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