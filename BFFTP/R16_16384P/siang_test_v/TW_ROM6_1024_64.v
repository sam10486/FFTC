 `timescale 1 ns/1 ps     

 module TW_ROM6_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,

   Q,
   Q_const,
   Q_group_tf_fly
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
   output reg [P_WIDTH-1:0] Q_group_tf_fly;
     
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
         buf_data_stage0[0][1]   <= 128'h0200000000000000_585bda2e086ebc26    ; // BC=64
         buf_data_stage0[0][2]   <= 128'hfffffffefffc0001_00000007fff7fff8    ; // BC=128
         buf_data_stage0[0][3]   <= 128'hfffff7ff00000801_7202dad8187e103f    ; // BC=192
         buf_data_stage0[1][0]   <= 128'h7fb5acc30389f4d0_75c91fcd00f90ea6    ;
         buf_data_stage0[1][1]   <= 128'h260713e978f980bd_02ddf1a92518339e    ;
         buf_data_stage0[1][2]   <= 128'h4cf1f3012cc1fed7_095cbf1ad4c23ab1    ;
         buf_data_stage0[1][3]   <= 128'hb05983fcfd0c981d_9b785d3e235eecb7    ;
         buf_data_stage0[2][0]   <= 128'hbbdfdceff9b2d4ca_575eb97c69429fc1    ;
         buf_data_stage0[2][1]   <= 128'h73f365a91e94da9d_f9e69c5d08b93175    ;
         buf_data_stage0[2][2]   <= 128'h8c3d29b4acdaef80_7e2ef8f9fceff10b    ;
         buf_data_stage0[2][3]   <= 128'h6959b5de958dcfce_62d976a15f6160a5    ;
         buf_data_stage0[3][0]   <= 128'h912b7e3e532ae35f_f3dd150bf2cea5ad    ;
         buf_data_stage0[3][1]   <= 128'h3aa655c68237533d_a41979575c1d72d2    ;
         buf_data_stage0[3][2]   <= 128'h07046ea6728644ae_ee0df8019d41c922    ;
         buf_data_stage0[3][3]   <= 128'ha8e50c88b30cea9a_162b94d367bdbf81    ;
         buf_data_stage0[4][0]   <= 128'ha0ab7e95c458c04e_3bc10f75aa162847    ;
         buf_data_stage0[4][1]   <= 128'hc788b17fd335f783_36851cf7dfa2619d    ;
         buf_data_stage0[4][2]   <= 128'h05a66beefeca82ae_d502137b8f102024    ;
         buf_data_stage0[4][3]   <= 128'h39fd950521f71e23_15525baa41ddbf82    ;
         buf_data_stage0[5][0]   <= 128'hc398180c38caffd7_71aa2dd46d516325    ;
         buf_data_stage0[5][1]   <= 128'hc67195fee60739d1_c24117e4ee1e2802    ;
         buf_data_stage0[5][2]   <= 128'h9fcc0e7300a70e61_fbe42146eeff0587    ;
         buf_data_stage0[5][3]   <= 128'ha8014e1c18bf19c7_b1c3bd0f3cfc12d2    ;
         buf_data_stage0[6][0]   <= 128'he104978443ea74c5_213b4515ad98a128    ;
         buf_data_stage0[6][1]   <= 128'h9287d4e8f5b621e8_7b1ad4eed9c4b960    ;
         buf_data_stage0[6][2]   <= 128'ha1eb6c432cef8413_4416929f8021d7ed    ;
         buf_data_stage0[6][3]   <= 128'hac59df0778624a20_26ab23ff8e076660    ;
         buf_data_stage0[7][0]   <= 128'hdcee6ba66b6361d7_2d3e749c32068452    ;
         buf_data_stage0[7][1]   <= 128'hfad6c6c2b16f5c66_cb50d3ca1b06a621    ;
         buf_data_stage0[7][2]   <= 128'h5162deb878a773ba_eb512865e349a283    ;
         buf_data_stage0[7][3]   <= 128'he4f14ee68e6beb5c_39ddfe459c428b2e    ;
         buf_data_stage0[8][0]   <= 128'h7b83abdf412342cf_83c83e4ba3d808fc    ;
         buf_data_stage0[8][1]   <= 128'h5c8246854086b223_55b886c72ae1e8a9    ;
         buf_data_stage0[8][2]   <= 128'h50810d63f4c5ee0f_2c5f0ad97b21e405    ;
         buf_data_stage0[8][3]   <= 128'he5e98bdb3775720a_20d34071b5e73243    ;
         buf_data_stage0[9][0]   <= 128'h83c83e4ba3d808fc_d86f3c604c62ece6    ;
         buf_data_stage0[9][1]   <= 128'h8f47b01167b0bf72_36e7215477c311af    ;
         buf_data_stage0[9][2]   <= 128'h06cf617edc120f21_800e409772457948    ;
         buf_data_stage0[9][3]   <= 128'h3fb8241e023a3d1f_b3731823fd381f1e    ;
         buf_data_stage0[10][0]  <= 128'h68a0852b4d45c72e_8ead190fdecaa1f9   ;
         buf_data_stage0[10][1]  <= 128'hb29a8b8da8943368_be1a9323a46736eb   ;
         buf_data_stage0[10][2]  <= 128'heb512865e349a283_2dd1a405847e9d22   ;
         buf_data_stage0[10][3]  <= 128'hd1c693443262ca6b_8a16a343349fa060   ;
         buf_data_stage0[11][0]  <= 128'hf834bb1a0a3df986_a05107e6c4808d71   ;
         buf_data_stage0[11][1]  <= 128'h40147bf2c9fb1a97_c6fd9686b306c09e   ;
         buf_data_stage0[11][2]  <= 128'h1393f63519ebe0d3_e4c944f56df057cb   ;
         buf_data_stage0[11][3]  <= 128'h1033d7c195a50052_e3fa34c62af37ec8   ;
         buf_data_stage0[12][0]  <= 128'h36e6ee0a706c8023_5175b4b04f3ef167   ;
         buf_data_stage0[12][1]  <= 128'h5ae0d8ffeab15924_7481bb131b26754d   ;
         buf_data_stage0[12][2]  <= 128'h47d562b1ff74db9c_d472858f6f255af4   ;
         buf_data_stage0[12][3]  <= 128'h9bfee9b69b716b84_00972d22d85a210d   ;
         buf_data_stage0[13][0]  <= 128'h2da6da812ce10161_a24bf3098ca017ff   ;
         buf_data_stage0[13][1]  <= 128'hc459c201fd4af049_e9c9602df84016dc   ;
         buf_data_stage0[13][2]  <= 128'h95fa95dffa7cb69c_ccaf4891c8acba1c   ;
         buf_data_stage0[13][3]  <= 128'hf7f4f96c3edf1168_c089a68c38db95fc   ;
         buf_data_stage0[14][0]  <= 128'h36d11d9ae31cc4c6_bd6bbb1a325e80f5   ;
         buf_data_stage0[14][1]  <= 128'hc1c63988c9cc243c_58aa086960127272   ;
         buf_data_stage0[14][2]  <= 128'h89939847ece8db45_ba1c894f7a0c0ae5   ;
         buf_data_stage0[14][3]  <= 128'h19d9d1b66f130719_bd45cda8a68eee76   ;
         buf_data_stage0[15][0]  <= 128'h58c3de196dbcf497_6fb69219dde133b9   ;
         buf_data_stage0[15][1]  <= 128'h60db79e8cc72fe5b_40147bf2c9fb1a97   ;
         buf_data_stage0[15][2]  <= 128'h8798e5fc2da56310_5e373105f57d4f1e   ;
         buf_data_stage0[15][3]  <= 128'h185b4ac60695836e_70408438dacd4c56   ;
         buf_data_stage0[16][0]  <= 128'hd3946b6a55f9087f_ce93f9dcfeb25738   ;
         buf_data_stage0[16][1]  <= 128'hd2abf21029ace519_6ee0aa74c8022c92   ;
         buf_data_stage0[16][2]  <= 128'h525359c9de074e52_26a44f86dc13ebf8   ;
         buf_data_stage0[16][3]  <= 128'h37bc0e9c6b9f4ab0_ec67ad74e45cbed0   ;
         buf_data_stage0[17][0]  <= 128'h830fb4843dded11c_3b5ec4fbd76062d3   ;
         buf_data_stage0[17][1]  <= 128'h407bbda1f67e22f5_546f5e5ec2c48deb   ;
         buf_data_stage0[17][2]  <= 128'h2decfc45bb920c3f_9322809c53709c80   ;
         buf_data_stage0[17][3]  <= 128'h09772418742d01ef_232bb5b5d70b412d   ;
         buf_data_stage0[18][0]  <= 128'h8cb984ebc4e4d006_310c7972c8ac7e85   ;
         buf_data_stage0[18][1]  <= 128'he389c99f275cc357_ecb4bbe5d8acc33d   ;
         buf_data_stage0[18][2]  <= 128'hec4eb985bfea32e7_79cc265e3e11c8a6   ;
         buf_data_stage0[18][3]  <= 128'hd97fd464f2a78e28_e62feed3bb136c90   ;
         buf_data_stage0[19][0]  <= 128'hce93f9dcfeb25738_3a22d4f729ae82d7   ;
         buf_data_stage0[19][1]  <= 128'h29fd64ae4465735e_bbfcdd446c97b284   ;
         buf_data_stage0[19][2]  <= 128'h1888cae6a3233a50_a5b8f82acabf12a6   ;
         buf_data_stage0[19][3]  <= 128'h6d4646743288a7f6_7a944f75274161a4   ;
         buf_data_stage0[20][0]  <= 128'hd16910f590d26cbf_14dfb28c12daa34a   ;
         buf_data_stage0[20][1]  <= 128'h6921a4d9133b8905_63f1e718f1c2f430   ;
         buf_data_stage0[20][2]  <= 128'hbc2677114d0745a5_0273dc7ca7ddf84d   ;
         buf_data_stage0[20][3]  <= 128'h6c9a0e8adbeda487_554cf3d5b0dc4548   ;
         buf_data_stage0[21][0]  <= 128'h80d2bcb05393e568_0b72784bf5a551a2   ;
         buf_data_stage0[21][1]  <= 128'h30a727ca9e5732bc_dc48f4619551a73c   ;
         buf_data_stage0[21][2]  <= 128'h0d3cae656a62034b_eaca84506a320c25   ;
         buf_data_stage0[21][3]  <= 128'h60d4c4063510c29d_0779ad043952055b   ;
         buf_data_stage0[22][0]  <= 128'h0e3ad74e485be598_c5f8ef0307d207d0   ;
         buf_data_stage0[22][1]  <= 128'hcc90b7ca6352d287_1ce7138a68686305   ;
         buf_data_stage0[22][2]  <= 128'ha2c6a5a469a038ec_c671d021532e7930   ;
         buf_data_stage0[22][3]  <= 128'h20d34071b5e73243_a6eeedaabd5d32be   ;
         buf_data_stage0[23][0]  <= 128'h9d24a3f365407288_ecf8e718ecd8cf70   ;
         buf_data_stage0[23][1]  <= 128'hf6ca80e417fb35d4_bfc98e476840b3de   ;
         buf_data_stage0[23][2]  <= 128'h702ff66b35e27493_2df7aceab5f9b380   ;
         buf_data_stage0[23][3]  <= 128'hfc6bc4e828b3db2b_cfc45e9720c3ed22   ;
         buf_data_stage0[24][0]  <= 128'hba856751f25d9591_a3895b400ec4b7d2   ;
         buf_data_stage0[24][1]  <= 128'hc5e4bb2a5aa63a07_e389c99f275cc357   ;
         buf_data_stage0[24][2]  <= 128'h62b54c73a9beea16_9c202c19af0483bb   ;
         buf_data_stage0[24][3]  <= 128'h13537dd417e71793_ede5c37b8e1ab49e   ;
         buf_data_stage0[25][0]  <= 128'h8ba4d377135a8dc4_c6be195a51eafdcd   ;
         buf_data_stage0[25][1]  <= 128'h7626b51b10c2013e_03fd159c3f324a74   ;
         buf_data_stage0[25][2]  <= 128'hb2218401c8f22e94_c47f29184c557cb7   ;
         buf_data_stage0[25][3]  <= 128'h2b91e45cfb09d89b_4cb03a2492e51f67   ;
         buf_data_stage0[26][0]  <= 128'h72719822e2f31fe9_974a88969b8c2817   ;
         buf_data_stage0[26][1]  <= 128'h17c5e63fb9553690_0c23ebcdc236e66b   ;
         buf_data_stage0[26][2]  <= 128'h9f72aa6c805dc9c7_97a7a9fd289734e8   ;
         buf_data_stage0[26][3]  <= 128'h6700bb9325c05f18_b348c08059d1cf5a   ;
         buf_data_stage0[27][0]  <= 128'he09445e538924149_4dc76dca1dcd7461   ;
         buf_data_stage0[27][1]  <= 128'h5c71248233cdb2f2_d57d6740ebd11c76   ;
         buf_data_stage0[27][2]  <= 128'he8679b64fadf8252_8018465e00535ce3   ;
         buf_data_stage0[27][3]  <= 128'h6df5bf04343971c5_247ad93511e28e34   ;
         buf_data_stage0[28][0]  <= 128'h121d0f9208af78ae_83541ab37db4bd31   ;
         buf_data_stage0[28][1]  <= 128'h80115ef0dbca66f0_5c570e689c4d2433   ;
         buf_data_stage0[28][2]  <= 128'hc1b794cd1d484875_1805e13d0e355b7d   ;
         buf_data_stage0[28][3]  <= 128'h843a909064420046_6f215c7319494ddc   ;
         buf_data_stage0[29][0]  <= 128'h64e0a4d91c445ad2_912804f1d4518e93   ;
         buf_data_stage0[29][1]  <= 128'h563888b54cfdb601_7f91460500bde8e5   ;
         buf_data_stage0[29][2]  <= 128'h6c99fb6b94b99383_7af948c65f9fed1a   ;
         buf_data_stage0[29][3]  <= 128'hdd29732627fd58e3_d5c344a9b662853b   ;
         buf_data_stage0[30][0]  <= 128'hfdeba23e89465e98_17743c23caca915e   ;
         buf_data_stage0[30][1]  <= 128'had128cbc80f19bff_9b0aa0de59d074d1   ;
         buf_data_stage0[30][2]  <= 128'h7701e33785a3f7af_753578f8631a4f94   ;
         buf_data_stage0[30][3]  <= 128'hcd0b47ee9006b44b_c78bffa9b2a42adb   ;
         buf_data_stage0[31][0]  <= 128'h5b11501d07d1bfa5_6ce8024cb0531c09   ;
         buf_data_stage0[31][1]  <= 128'h840fa37ec53a39e1_c7b40bfd0e189e58   ;
         buf_data_stage0[31][2]  <= 128'hbf8a7473016d6c46_702ff66b35e27493   ;
         buf_data_stage0[31][3]  <= 128'h7202dad8187e103f_10d644545ee0eaf8   ;
         buf_data_stage0[32][0]  <= 128'h52ca810d84ba33e7_897a64fb4f51752c   ;
         buf_data_stage0[32][1]  <= 128'he9097466e450f697_28f555d7e67baa6c   ;
         buf_data_stage0[32][2]  <= 128'hfbc8a1ec30654b2b_52ace2fc90457a99   ;
         buf_data_stage0[32][3]  <= 128'h2e60ca9625a7a426_851cd7d63119458c   ;
         buf_data_stage0[33][0]  <= 128'h13dd47a18f9289b0_9a9f15078d70e2ef   ;
         buf_data_stage0[33][1]  <= 128'ha31f2512bcb9205e_c31a6b1f52d8e455   ;
         buf_data_stage0[33][2]  <= 128'he179723fd9404f76_c345d6f2a80d1545   ;
         buf_data_stage0[33][3]  <= 128'h6bb2809e7e8a8c7d_3dc673072dc39d31   ;
         buf_data_stage0[34][0]  <= 128'hb743ee2189526537_c89ff0a3b796e3c3   ;
         buf_data_stage0[34][1]  <= 128'hb112a4c9bb7ed35a_5180187ea8a17c02   ;
         buf_data_stage0[34][2]  <= 128'h4776fda66b26dd10_37931c5ae037a1ca   ;
         buf_data_stage0[34][3]  <= 128'h6cd64db9b29ac44b_81140f004ee5e7fc   ;
         buf_data_stage0[35][0]  <= 128'h5a2e7be66e2a21ea_ce471deb4ad63627   ;
         buf_data_stage0[35][1]  <= 128'ha0dc5443326f4ec5_bdda747d75b5ca8f   ;
         buf_data_stage0[35][2]  <= 128'h1064de9d785968ba_6750e84685e3d1a7   ;
         buf_data_stage0[35][3]  <= 128'haef0b2d0c4ee8372_09bcb7f00f0bf670   ;
         buf_data_stage0[36][0]  <= 128'h83d81879d53d7de7_ba32f0227aa6dc3b   ;
         buf_data_stage0[36][1]  <= 128'hc1aa7afb0b4dd4d4_133f4c44e5641984   ;
         buf_data_stage0[36][2]  <= 128'h9e169ba908660f61_541d3b03775f6eac   ;
         buf_data_stage0[36][3]  <= 128'h1410cc1eacb306aa_c8f907036ec56bb4   ;
         buf_data_stage0[37][0]  <= 128'h58284e98530357c3_f90393edf4414910   ;
         buf_data_stage0[37][1]  <= 128'hb6a606aecea9a8b4_c00bc2278de8b6c7   ;
         buf_data_stage0[37][2]  <= 128'hc59d5350a0f560a2_0292de514d60e02d   ;
         buf_data_stage0[37][3]  <= 128'he541eac05d32da99_5e03468dda2a38ea   ;
         buf_data_stage0[38][0]  <= 128'h320192dd01d113bf_ae7aeba28f11e539   ;
         buf_data_stage0[38][1]  <= 128'h3803a22745985ab3_35be35e7bacdef73   ;
         buf_data_stage0[38][2]  <= 128'hb48b30b4b104c807_1b753d5be9d6ecfb   ;
         buf_data_stage0[38][3]  <= 128'h7762098f9534e00f_272ff7350008831c   ;
         buf_data_stage0[39][0]  <= 128'h897a64fb4f51752c_ed0e610eae3ad206   ;
         buf_data_stage0[39][1]  <= 128'h4e9ea2ea084e684c_71ddd296c0927fd6   ;
         buf_data_stage0[39][2]  <= 128'h6c109cd02b5225ea_6959b5de958dcfce   ;
         buf_data_stage0[39][3]  <= 128'h7456a44b5ed13a7b_6fda6b296dd0fb89   ;
         buf_data_stage0[40][0]  <= 128'hc5ff6cb7eb38fddc_260713e978f980bd   ;
         buf_data_stage0[40][1]  <= 128'h27d671fb8e9d8f2b_d47a1a36289afec3   ;
         buf_data_stage0[40][2]  <= 128'h4d1d3b1e089317fe_287f0de202148b05   ;
         buf_data_stage0[40][3]  <= 128'h3811262fc3549f5a_73200d682145dc08   ;
         buf_data_stage0[41][0]  <= 128'h4dee055bef270fed_9b5f8d70975679c5   ;
         buf_data_stage0[41][1]  <= 128'h91de4e1f4785d5d6_a7330e94f38124de   ;
         buf_data_stage0[41][2]  <= 128'hea8f0baac04d37b9_4f2a38729c2ca150   ;
         buf_data_stage0[41][3]  <= 128'hc7809a6ea8aa477a_275c514903739e01   ;
         buf_data_stage0[42][0]  <= 128'hd14efbb391ceeff3_9d17dc6c938396f9   ;
         buf_data_stage0[42][1]  <= 128'h4d239ddf9739c429_03de8dd8bab4446d   ;
         buf_data_stage0[42][2]  <= 128'h112e73884037453c_b8b332e6c3614d93   ;
         buf_data_stage0[42][3]  <= 128'h88806e89ef5d348f_66dc2ed0e8018cc7   ;
         buf_data_stage0[43][0]  <= 128'h0e25e373023f57d5_5aadd703850e97e9   ;
         buf_data_stage0[43][1]  <= 128'h90047eaf19df358a_087e7186eb3bc331   ;
         buf_data_stage0[43][2]  <= 128'h7233be6aa0ac3898_7055c16142d75e0b   ;
         buf_data_stage0[43][3]  <= 128'h0541587129da4012_cda67bb548a69e35   ;
         buf_data_stage0[44][0]  <= 128'h057076fdb2b760f2_3bcec735f954e77d   ;
         buf_data_stage0[44][1]  <= 128'hdf656ec1048fb051_9472f1187302b6cc   ;
         buf_data_stage0[44][2]  <= 128'h24091f607c3815c2_90f592c81afc68df   ;
         buf_data_stage0[44][3]  <= 128'h44f8702b3ebf7d96_0f4d7aae0df76474   ;
         buf_data_stage0[45][0]  <= 128'he54b62ed0078198f_b0e7f6bb5b83a2cf   ;
         buf_data_stage0[45][1]  <= 128'hf800f03224347908_808a9c9cfd5089ef   ;
         buf_data_stage0[45][2]  <= 128'h744868f199c7952e_263cb3158630baed   ;
         buf_data_stage0[45][3]  <= 128'h3f338f2a1be3e004_0598609ac1b2cff5   ;
         buf_data_stage0[46][0]  <= 128'h7500d9c66a5efd31_2a7e265da42224fd   ;
         buf_data_stage0[46][1]  <= 128'heed4bdf972414053_f0472fcd49d4a33b   ;
         buf_data_stage0[46][2]  <= 128'h98e482800b3dd404_ee22b2e36316f91d   ;
         buf_data_stage0[46][3]  <= 128'h08167ba7feb7bb53_d03348f11550e9f8   ;
         buf_data_stage0[47][0]  <= 128'h8823e9bc572210f5_78bc1b78d421d485   ;
         buf_data_stage0[47][1]  <= 128'h62ae44218641740b_07046ea6728644ae   ;
         buf_data_stage0[47][2]  <= 128'h590c82e7bc2e2090_c5443d33f4ec45f3   ;
         buf_data_stage0[47][3]  <= 128'hef785c402fd58aba_1efe591a0e3a9d80   ;
         buf_data_stage0[48][0]  <= 128'h48bb429405cd1ea3_c68e3b6d2f30c935   ;
         buf_data_stage0[48][1]  <= 128'h6e0b9a3cd762ef3e_1dd39fd932821f72   ;
         buf_data_stage0[48][2]  <= 128'hf5aec5dd857522ee_9e169ba908660f61   ;
         buf_data_stage0[48][3]  <= 128'h970aea454309b82f_954678e081c2f444   ;
         buf_data_stage0[49][0]  <= 128'h6cdff481a7e55282_03dd4662d4b10ac1   ;
         buf_data_stage0[49][1]  <= 128'h074fcaa4fbd67572_ab4b17941db405e1   ;
         buf_data_stage0[49][2]  <= 128'h2df7aceab5f9b380_72719194e58595cc   ;
         buf_data_stage0[49][3]  <= 128'hd56bf3662a381d40_30f9e70989046eb0   ;
         buf_data_stage0[50][0]  <= 128'h676f89d9da059271_58bf28a1050a3271   ;
         buf_data_stage0[50][1]  <= 128'h95b40b244b7d15c8_f15a21aec9a3d767   ;
         buf_data_stage0[50][2]  <= 128'hd896fa2ab63d9dbf_e346a5397e2fed6a   ;
         buf_data_stage0[50][3]  <= 128'hd36c7b3aa8e256d1_3fa0e3406cdfc223   ;
         buf_data_stage0[51][0]  <= 128'haeba188cd9e2730b_cc9ae7babacc5c81   ;
         buf_data_stage0[51][1]  <= 128'h2fb3c4e5e4eec6e9_9e164c050b9528cf   ;
         buf_data_stage0[51][2]  <= 128'h9dc9dd8d33d6bae9_9886a8c6e0c442fa   ;
         buf_data_stage0[51][3]  <= 128'hec67ad74e45cbed0_fc7bf9166c314a13   ;
         buf_data_stage0[52][0]  <= 128'h32b3aa700dd08edb_cc18126c74948d0b   ;
         buf_data_stage0[52][1]  <= 128'h961ba11d1f7ef78e_ac6c08e50a8c4dd5   ;
         buf_data_stage0[52][2]  <= 128'h563efdeec494cacf_113a62ec92496505   ;
         buf_data_stage0[52][3]  <= 128'h7b89299521ca586f_0d34b6dfd99aad90   ;
         buf_data_stage0[53][0]  <= 128'hb062d8e77e5eeb8c_137f6b27271dd74e   ;
         buf_data_stage0[53][1]  <= 128'he6fcbdd62fa27c78_143bae7f162e4571   ;
         buf_data_stage0[53][2]  <= 128'h9c5f44f851d2c18c_dfb4e58470a68853   ;
         buf_data_stage0[53][3]  <= 128'h08a3a5830e239bf3_3d78d8378129025d   ;
         buf_data_stage0[54][0]  <= 128'h4f01ddbca741ea4d_b056b27b51487fcd   ;
         buf_data_stage0[54][1]  <= 128'h134e83d486137870_0059aa7d04af8f76   ;
         buf_data_stage0[54][2]  <= 128'h890c26f056cd3c08_f663f167f4a3f074   ;
         buf_data_stage0[54][3]  <= 128'hf0ad9a771e404d3b_d19453655c063336   ;
         buf_data_stage0[55][0]  <= 128'h5ce12fcfabc79d87_beda1eb60562cef9   ;
         buf_data_stage0[55][1]  <= 128'had578f3a5feeae66_3803a22745985ab3   ;
         buf_data_stage0[55][2]  <= 128'h40bfdd5c89e57385_356055da66568959   ;
         buf_data_stage0[55][3]  <= 128'hc313cae6466ab55f_1b86e8b63d89d94b   ;
         buf_data_stage0[56][0]  <= 128'h59428f55043e67bb_484af27ff41fc8ce   ;
         buf_data_stage0[56][1]  <= 128'h20087ccf5544fe12_1982355631fe88d9   ;
         buf_data_stage0[56][2]  <= 128'hc2aa89fb6115650b_0cfc6317d63c67e8   ;
         buf_data_stage0[56][3]  <= 128'h0cc22aca07b88022_e541eac05d32da99   ;
         buf_data_stage0[57][0]  <= 128'h2b22490639ab02af_d784a7fb60013523   ;
         buf_data_stage0[57][1]  <= 128'h6a735604f3366569_7c50568bee83815b   ;
         buf_data_stage0[57][2]  <= 128'hdbe66cc9f544ac8a_c027ece19abfd333   ;
         buf_data_stage0[57][3]  <= 128'ha7ea89586a5da9ce_bfb8b4349e8d234c   ;
         buf_data_stage0[58][0]  <= 128'h484af27ff41fc8ce_d49a52a121e630ca   ;
         buf_data_stage0[58][1]  <= 128'h9be83f90ff872a8a_baa02a1aa9633af8   ;
         buf_data_stage0[58][2]  <= 128'h35ff0e54dcc9212c_7a21d244c5b2897a   ;
         buf_data_stage0[58][3]  <= 128'h01b9924255da6fa1_fa3eb79e082aac6d   ;
         buf_data_stage0[59][0]  <= 128'h070bd10da3da4b6e_903966f72fefdc7b   ;
         buf_data_stage0[59][1]  <= 128'hf747b495e4aa33c8_7183ef1f437fe85f   ;
         buf_data_stage0[59][2]  <= 128'hbbc95466d2481c30_47c0e2891ae2663a   ;
         buf_data_stage0[59][3]  <= 128'h2da4903830e3dd1f_a3019ad514ecd02e   ;
         buf_data_stage0[60][0]  <= 128'hd372e962b1400f80_a65d172813bc8d2d   ;
         buf_data_stage0[60][1]  <= 128'hc562801e38f69a0f_37b6eb830b9f524a   ;
         buf_data_stage0[60][2]  <= 128'h5a71ed33c2034dcc_e49e9894c5d01041   ;
         buf_data_stage0[60][3]  <= 128'hff84069a97c7158b_00e0779c52ffcf4f   ;
         buf_data_stage0[61][0]  <= 128'h266295c733de0c97_887ed29b21bdd6bb   ;
         buf_data_stage0[61][1]  <= 128'hbc67bc18714b7ebc_ce03a5fb9dbd6da8   ;
         buf_data_stage0[61][2]  <= 128'ha8e296fccda4998b_791163edf846f946   ;
         buf_data_stage0[61][3]  <= 128'h0f9b49330512f19f_be080f3034bdd301   ;
         buf_data_stage0[62][0]  <= 128'heb74fb279398e703_5c44d4ac776633ac   ;
         buf_data_stage0[62][1]  <= 128'h552731cdaf01e43c_159b318324507f87   ;
         buf_data_stage0[62][2]  <= 128'h135e03c863f7add4_15cb0004c54a9f63   ;
         buf_data_stage0[62][3]  <= 128'h38c7ef5b6f11549d_966a2cd9346b2489   ;
         buf_data_stage0[63][0]  <= 128'hffeffffefffffff1_bf562ae382c86418   ;
         buf_data_stage0[63][1]  <= 128'hdfffffff00002001_6e0b9a3cd762ef3e   ;
         buf_data_stage0[63][2]  <= 128'h00000040003fffc0_bf210fc4ce5182d6   ;
         buf_data_stage0[63][3]  <= 128'h00007fff7fff8000_e92d4e775a9f2487   ;
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'h0200000000000000_585bda2e086ebc26; // BC=64
         buf_data_stage1[0][2] <= 128'hfffffffefffc0001_00000007fff7fff8; // BC=128
         buf_data_stage1[0][3] <= 128'hfffff7ff00000801_7202dad8187e103f; // BC=192

         buf_data_stage1[1][0] <= 128'h5b11501d07d1bfa5_6ce8024cb0531c09; // BC=16
         buf_data_stage1[1][1] <= 128'h840fa37ec53a39e1_c7b40bfd0e189e58;
         buf_data_stage1[1][2] <= 128'hbf8a7473016d6c46_702ff66b35e27493;
         buf_data_stage1[1][3] <= 128'h7202dad8187e103f_10d644545ee0eaf8;
         buf_data_stage1[2][0] <= 128'h52ca810d84ba33e7_897a64fb4f51752c; // BC=32
         buf_data_stage1[2][1] <= 128'he9097466e450f697_28f555d7e67baa6c;
         buf_data_stage1[2][2] <= 128'hfbc8a1ec30654b2b_52ace2fc90457a99;
         buf_data_stage1[2][3] <= 128'h2e60ca9625a7a426_851cd7d63119458c;
         buf_data_stage1[3][0] <= 128'hffeffffefffffff1_bf562ae382c86418; // BC=48
         buf_data_stage1[3][1] <= 128'hdfffffff00002001_6e0b9a3cd762ef3e;
         buf_data_stage1[3][2] <= 128'h00000040003fffc0_bf210fc4ce5182d6;
         buf_data_stage1[3][3] <= 128'h00007fff7fff8000_e92d4e775a9f2487;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'h0000001000000000_ff7fffff00800001; // BC=64
         buf_data_stage2[2] <= 128'h000000ffffffff00_ffffbfff00004001; // BC=128
         buf_data_stage2[3] <= 128'hfffffffefffff001_ffffffdf00000021; // BC=192
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
         buf_const[0] <= 128'h0000001000000000_ff7fffff00800001;
         buf_const[1] <= 128'h0000001000000000_ff7fffff00800001;
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

   always @(posedge CLK or posedge rst_n) begin
      if (!rst_n) begin
         Q_group_tf_fly <= 128'd0;
      end else begin
         if (~CEN) begin
            if (stage_counter == 3'd0) begin
               if (cnt_0 >= 0 && cnt_0 <= 3) begin
                  Q_group_tf_fly <= buf_data_stage0[group_th][cnt_0];
               end else begin
                  Q_group_tf_fly <= 128'd0;
               end
            end else begin
               Q_group_tf_fly <= 128'd0;
            end
         end
      end
   end

   endmodule