 `timescale 1 ns/1 ps     

 module TW_ROM2_1024_64(
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
         buf_data_stage0[0][0] <= 128'h0000000000000001_0000000000000001    ; // BC=0
         buf_data_stage0[0][1] <= 128'hfff7ffff00000001_969e9096afde4510    ; // BC=64
         buf_data_stage0[0][2] <= 128'hfffffffeffffffc1_007fffffffffff80    ; // BC=128
         buf_data_stage0[0][3] <= 128'h0200000000000000_840fa37ec53a39e1    ; // BC=192
         buf_data_stage0[1][0] <= 128'hc26241d7d497e9b7_252502e45f699196    ;
         buf_data_stage0[1][1] <= 128'ha3895b400ec4b7d2_3b5ec4fbd76062d3    ;
         buf_data_stage0[1][2] <= 128'h676f89d9da059271_aaae4285d8f4edc9    ;
         buf_data_stage0[1][3] <= 128'h1da92fd34ed20ba9_38093227d1c5370a    ;
         buf_data_stage0[2][0] <= 128'h7fb5acc30389f4d0_6b551fea26657a45    ;
         buf_data_stage0[2][1] <= 128'hf367e3af661c19fe_d19f2ca6bf67eecc    ;
         buf_data_stage0[2][2] <= 128'h1294cf1f1d82cc20_6d033d73d7fa0069    ;
         buf_data_stage0[2][3] <= 128'h260713e978f980bd_e9c9602df84016dc    ;
         buf_data_stage0[3][0] <= 128'hd0e5c71177433cdc_08dda69734d315e3    ;
         buf_data_stage0[3][1] <= 128'he09445e538924149_a407f39b04c804df    ;
         buf_data_stage0[3][2] <= 128'hc68e3b6d2f30c935_ce471deb4ad63627    ;
         buf_data_stage0[3][3] <= 128'hdaee8678db6fadf9_3908962dce2928d6    ;
         buf_data_stage0[4][0] <= 128'h912b7e3e532ae35f_9c4563b91246b28e    ;
         buf_data_stage0[4][1] <= 128'hf31566a7f1f722b4_58be2489beb3a0e1    ;
         buf_data_stage0[4][2] <= 128'hb520704635472865_00d74681ffcf7343    ;
         buf_data_stage0[4][3] <= 128'h3aa655c68237533d_564d14c46123d6ca    ;
         buf_data_stage0[5][0] <= 128'h32c3f888d962f857_b7ed6fd97bea1daa    ;
         buf_data_stage0[5][1] <= 128'h790134e7c4486138_a84ea4e3129b18ad    ;
         buf_data_stage0[5][2] <= 128'h4f01ddbca741ea4d_cb0607f41dd73f96    ;
         buf_data_stage0[5][3] <= 128'hbfb2c5efede7b21f_a0b6dbae409634f6    ;
         buf_data_stage0[6][0] <= 128'h97017c5dccfb9554_a4fc6533afc6b89a    ;
         buf_data_stage0[6][1] <= 128'h72719822e2f31fe9_356866e5b199e2d5    ;
         buf_data_stage0[6][2] <= 128'h3fa0e866c11aab26_68a54931827951c4    ;
         buf_data_stage0[6][3] <= 128'h6399f72a433805dd_292559fdc01b1476    ;
         buf_data_stage0[7][0] <= 128'h1a8c7b40a550e18a_97017c5dccfb9554    ;
         buf_data_stage0[7][1] <= 128'h19aad578da05feeb_40e639a7c067e319    ;
         buf_data_stage0[7][2] <= 128'h5ce12fcfabc79d87_58284e98530357c3    ;
         buf_data_stage0[7][3] <= 128'h954aa1c27e804547_ed435feff80dcc93    ;
         buf_data_stage0[8][0] <= 128'hdcee6ba66b6361d7_e104978443ea74c5    ;
         buf_data_stage0[8][1] <= 128'h9414a4e45d3a428f_54d38039cda45986    ;
         buf_data_stage0[8][2] <= 128'hc465162d27278a78_a25632a74833266b    ;
         buf_data_stage0[8][3] <= 128'hfad6c6c2b16f5c66_7626b51b10c2013e    ;
         buf_data_stage0[9][0] <= 128'h2d3e749c32068452_213b4515ad98a128    ;
         buf_data_stage0[9][1] <= 128'h388e6fcba4e2fa28_7e1394abc498ed1b    ;
         buf_data_stage0[9][2] <= 128'hb062d8e77e5eeb8c_81344168a8c8021e    ;
         buf_data_stage0[9][3] <= 128'hdc640d07c741760f_d997f6545d681c7f    ;
         buf_data_stage0[10][0] <= 128'he104978443ea74c5_ca29fe77059fada5   ;
         buf_data_stage0[10][1] <= 128'h9db5e0abbc292779_5cb8e3e8e38b2f02   ;
         buf_data_stage0[10][2] <= 128'hbeda1eb60562cef9_f90393edf4414910   ;
         buf_data_stage0[10][3] <= 128'h9287d4e8f5b621e8_18ffd0f745c85d25   ;
         buf_data_stage0[11][0] <= 128'hca229fd580c44658_8614fceadd5c2aa7   ;
         buf_data_stage0[11][1] <= 128'hce93f9dcfeb25738_14dfb28c12daa34a   ;
         buf_data_stage0[11][2] <= 128'h77580a6cceee6a33_be703862dc38f430   ;
         buf_data_stage0[11][3] <= 128'h5b01888c536a3234_7b30273d4c9a7de0   ;
         buf_data_stage0[12][0] <= 128'h6b353155d3c8bdc5_adb2dae29606e340   ;
         buf_data_stage0[12][1] <= 128'h872961b98ab1f7f0_03972190f1fba71b   ;
         buf_data_stage0[12][2] <= 128'h32b3aa700dd08edb_37dd91cf8aec8378   ;
         buf_data_stage0[12][3] <= 128'h35a7917b53820422_8a68355839b1a91e   ;
         buf_data_stage0[13][0] <= 128'hd0b407bb096f67e3_71b7f913eea00bdf   ;
         buf_data_stage0[13][1] <= 128'h830fb4843dded11c_fb466140b287e819   ;
         buf_data_stage0[13][2] <= 128'hd2fe1108a4260775_9d7ac5d525c9e4b7   ;
         buf_data_stage0[13][3] <= 128'h3c12decf884bb921_09a8a31d1b350cd9   ;
         buf_data_stage0[14][0] <= 128'hbbdfdceff9b2d4ca_b5609d15159f67c6   ;
         buf_data_stage0[14][1] <= 128'h72303268e785ac96_d1ac9220d4aaba78   ;
         buf_data_stage0[14][2] <= 128'h0808c3d2934acdaf_bd3c44cda5669d59   ;
         buf_data_stage0[14][3] <= 128'h73f365a91e94da9d_7621448999cf98c3   ;
         buf_data_stage0[15][0] <= 128'hae7d2abe72929acf_6b353155d3c8bdc5   ;
         buf_data_stage0[15][1] <= 128'hd3946b6a55f9087f_d16910f590d26cbf   ;
         buf_data_stage0[15][2] <= 128'h60b550375b594c6c_f2d1393e70819ebf   ;
         buf_data_stage0[15][3] <= 128'h1ae5253581bde075_25bfee051b98832a   ;
         buf_data_stage0[16][0] <= 128'h58c3de196dbcf497_36e6ee0a706c8023   ;
         buf_data_stage0[16][1] <= 128'h6a7c9217f0ce3407_fafdf655f12048fc   ;
         buf_data_stage0[16][2] <= 128'hcf08798d90c2da57_a34130ebc46c44e5   ;
         buf_data_stage0[16][3] <= 128'h60db79e8cc72fe5b_29fd64ae4465735e   ;
         buf_data_stage0[17][0] <= 128'hd922f0469ddab66c_b99583ab25ca3c75   ;
         buf_data_stage0[17][1] <= 128'hca6b1129823bb7ee_babc31a5f7452d8f   ;
         buf_data_stage0[17][2] <= 128'hb743ee2189526537_45510f2e44f215fd   ;
         buf_data_stage0[17][3] <= 128'h653bb56c711204b3_3c62cf3d8a10382e   ;
         buf_data_stage0[18][0] <= 128'h36d11d9ae31cc4c6_f867869c167fdf05   ;
         buf_data_stage0[18][1] <= 128'hecf8e718ecd8cf70_887ed29b21bdd6bb   ;
         buf_data_stage0[18][2] <= 128'h4bb8993938cece8e_9cc7f16771890a4a   ;
         buf_data_stage0[18][3] <= 128'hc1c63988c9cc243c_6ba79115d33f8470   ;
         buf_data_stage0[19][0] <= 128'h6fb69219dde133b9_5175b4b04f3ef167   ;
         buf_data_stage0[19][1] <= 128'hd16910f590d26cbf_322df9137f93662b   ;
         buf_data_stage0[19][2] <= 128'h125b796c87b311dc_50cd47280836f256   ;
         buf_data_stage0[19][3] <= 128'ha5bbc266cb64d075_88433fd9ac7409ea   ;
         buf_data_stage0[20][0] <= 128'h36e6ee0a706c8023_6df0ad73a727ee35   ;
         buf_data_stage0[20][1] <= 128'h8e947c9b70553a9c_9ae3e1bfd889d318   ;
         buf_data_stage0[20][2] <= 128'h46447d55e4dff74e_dbfcd9ebb1fe596a   ;
         buf_data_stage0[20][3] <= 128'h5ae0d8ffeab15924_f9fb64aedadcbd74   ;
         buf_data_stage0[21][0] <= 128'hfb37f9b38ff8bbb2_d0600c88208bf2d9   ;
         buf_data_stage0[21][1] <= 128'h54d38039cda45986_d5c64d9b0837bd71   ;
         buf_data_stage0[21][2] <= 128'h320192dd01d113bf_808a0180758e1de9   ;
         buf_data_stage0[21][3] <= 128'hcb1ff17696e99e96_a2dd4def163248e6   ;
         buf_data_stage0[22][0] <= 128'hd4430a71a869e574_37795ad14e23f949   ;
         buf_data_stage0[22][1] <= 128'h80d2bcb05393e568_449bf2aaecd669f9   ;
         buf_data_stage0[22][2] <= 128'hef3d635fe586a336_5079a93985408cf2   ;
         buf_data_stage0[22][3] <= 128'hcb50d3ca1b06a621_03fd159c3f324a74   ;
         buf_data_stage0[23][0] <= 128'hadda166b62c2ba2c_bc455272609af01f   ;
         buf_data_stage0[23][1] <= 128'h7b44e9e9b36084e7_f94bb5cc11fc3991   ;
         buf_data_stage0[23][2] <= 128'h897a64fb4f51752c_260713e978f980bd   ;
         buf_data_stage0[23][3] <= 128'h2ec5857427dec65f_08ae17971b5d9405   ;
         buf_data_stage0[24][0] <= 128'ha2cf6ca76b817fb4_d922f0469ddab66c   ;
         buf_data_stage0[24][1] <= 128'h9d24a3f365407288_266295c733de0c97   ;
         buf_data_stage0[24][2] <= 128'h4c24d5fc1fa01329_c7d6c99eeee94b9a   ;
         buf_data_stage0[24][3] <= 128'hb6d702feafe35e28_fdcf0b582d4c9443   ;
         buf_data_stage0[25][0] <= 128'hc398180c38caffd7_f4e07c743d5322f9   ;
         buf_data_stage0[25][1] <= 128'h40e639a7c067e319_b5cd9ce7e3092692   ;
         buf_data_stage0[25][2] <= 128'h19f9fcc0cd400a71_46606ef81bd56a2b   ;
         buf_data_stage0[25][3] <= 128'hc67195fee60739d1_d623104607204bfa   ;
         buf_data_stage0[26][0] <= 128'hd79cc90aa516352e_111b3f084b6e9153   ;
         buf_data_stage0[26][1] <= 128'h0e3ad74e485be598_9eb26db8148079c4   ;
         buf_data_stage0[26][2] <= 128'h18cdbd20ba72b4b6_a0063319c48911a1   ;
         buf_data_stage0[26][3] <= 128'h714a2c69e9069a04_64d363e2e36984dc   ;
         buf_data_stage0[27][0] <= 128'ha697460fbe475779_1d99c647a348c31b   ;
         buf_data_stage0[27][1] <= 128'h13ba0dc5308326f5_53b340b5204653f4   ;
         buf_data_stage0[27][2] <= 128'h5a2e7be66e2a21ea_e46e808037be014b   ;
         buf_data_stage0[27][3] <= 128'h117c8eaedf3642c5_7aefc86f821c0960   ;
         buf_data_stage0[28][0] <= 128'ha0ab7e95c458c04e_e489eb510cbcac01   ;
         buf_data_stage0[28][1] <= 128'h08e1dd39f4b32822_169f824723e40ffb   ;
         buf_data_stage0[28][2] <= 128'hd5205a65e9cfeca9_6410b55cf8b15ca7   ;
         buf_data_stage0[28][3] <= 128'hc788b17fd335f783_d150ce69ea5ac0c3   ;
         buf_data_stage0[29][0] <= 128'hbfb08ae0b9c1b5da_1efef91570d1a0c9   ;
         buf_data_stage0[29][1] <= 128'hfa2a31f1570bcb93_4f406e935a5df363   ;
         buf_data_stage0[29][2] <= 128'h13dd47a18f9289b0_6fbbde080c67b343   ;
         buf_data_stage0[29][3] <= 128'h7573836b3d0d1b7f_5af5e52487317f77   ;
         buf_data_stage0[30][0] <= 128'hca9e389bcf6275cd_91fe3ae9a969d0d7   ;
         buf_data_stage0[30][1] <= 128'h8cb984ebc4e4d006_554046c4a3938c8d   ;
         buf_data_stage0[30][2] <= 128'h5871d8d927628cf3_e1373fc9d5f9e0c4   ;
         buf_data_stage0[30][3] <= 128'hd19ec4eac6cbfea4_08ae6749d3bd4fc1   ;
         buf_data_stage0[31][0] <= 128'h9ab4d5fb2ded1731_a2cf6ca76b817fb4   ;
         buf_data_stage0[31][1] <= 128'h969e9096afde4510_8a8df6e55efde538   ;
         buf_data_stage0[31][2] <= 128'h52ca810d84ba33e7_c5ff6cb7eb38fddc   ;
         buf_data_stage0[31][3] <= 128'h585bda2e086ebc26_c7b40bfd0e189e58   ;
         buf_data_stage0[32][0] <= 128'h5b11501d07d1bfa5_ba856751f25d9591   ;
         buf_data_stage0[32][1] <= 128'h81efc17180eb1719_c465162d27278a78   ;
         buf_data_stage0[32][2] <= 128'h3babf8a70b9016d7_2ec5857427dec65f   ;
         buf_data_stage0[32][3] <= 128'h840fa37ec53a39e1_20087ccf5544fe12   ;
         buf_data_stage0[33][0] <= 128'h386ad2740ffe1f9a_02b91178daf2e17d   ;
         buf_data_stage0[33][1] <= 128'h6f8f800e93a24348_71118abcd4bc1ea7   ;
         buf_data_stage0[33][2] <= 128'he54b62ed0078198f_1e64bd01ca206b88   ;
         buf_data_stage0[33][3] <= 128'h1c1ffc3f176f2e1c_2924ff6c434dc5e4   ;
         buf_data_stage0[34][0] <= 128'hfdeba23e89465e98_393c6024d691f175   ;
         buf_data_stage0[34][1] <= 128'hf94bb5cc11fc3991_611808a968bfd509   ;
         buf_data_stage0[34][2] <= 128'h8517701dae685a40_2ebb3670a47f5e74   ;
         buf_data_stage0[34][3] <= 128'had128cbc80f19bff_4d300b054b308fc2   ;
         buf_data_stage0[35][0] <= 128'hc38f747a85de4aa4_db637b6ddcd0b9f6   ;
         buf_data_stage0[35][1] <= 128'h070bd10da3da4b6e_041006d855ca8e8c   ;
         buf_data_stage0[35][2] <= 128'h1c22e12d886d5731_0030b100e046eb53   ;
         buf_data_stage0[35][3] <= 128'h3d0bbc95096d2482_aa277919ae8bccb8   ;
         buf_data_stage0[36][0] <= 128'h121d0f9208af78ae_754ae602f03d55b5   ;
         buf_data_stage0[36][1] <= 128'hbdffba837c90d665_0fbc22867a75ee4f   ;
         buf_data_stage0[36][2] <= 128'h78bc1b78d421d485_36851cf7dfa2619d   ;
         buf_data_stage0[36][3] <= 128'h80115ef0dbca66f0_8cabf7b181c3bf80   ;
         buf_data_stage0[37][0] <= 128'hb2c847e9dc4363c1_75581b7bdf565423   ;
         buf_data_stage0[37][1] <= 128'ha2a91de43f54785e_a0881975ab5f10cb   ;
         buf_data_stage0[37][2] <= 128'h4dee055bef270fed_2361ecff96ab9783   ;
         buf_data_stage0[37][3] <= 128'h55b886c72ae1e8a9_dc48f4619551a73c   ;
         buf_data_stage0[38][0] <= 128'h5769be83a1aff873_d64ce931e66568cb   ;
         buf_data_stage0[38][1] <= 128'h484af27ff41fc8ce_b056b27b51487fcd   ;
         buf_data_stage0[38][2] <= 128'h25905f019401e356_d7fe995533ed41c3   ;
         buf_data_stage0[38][3] <= 128'hed435feff80dcc93_f8cf663e1dbf4a40   ;
         buf_data_stage0[39][0] <= 128'h6ce8024cb0531c09_a3895b400ec4b7d2   ;
         buf_data_stage0[39][1] <= 128'h0d527d671268e9d9_5871d8d927628cf3   ;
         buf_data_stage0[39][2] <= 128'hc5ff6cb7eb38fddc_c459c201fd4af049   ;
         buf_data_stage0[39][3] <= 128'hab60a63765c589c4_ad274485e1f99c7a   ;
         buf_data_stage0[40][0] <= 128'hba856751f25d9591_830fb4843dded11c   ;
         buf_data_stage0[40][1] <= 128'h18e86d133a956718_4bb8993938cece8e   ;
         buf_data_stage0[40][2] <= 128'h5ea62b54689a9bef_4844ad07ce36faff   ;
         buf_data_stage0[40][3] <= 128'hc5e4bb2a5aa63a07_074fcaa4fbd67572   ;
         buf_data_stage0[41][0] <= 128'hc8bac41065b8c441_2913051b4c2a56ea   ;
         buf_data_stage0[41][1] <= 128'hbd74d2392089739d_00220c6f631e16bc   ;
         buf_data_stage0[41][2] <= 128'hd14efbb391ceeff3_792387705d19ec67   ;
         buf_data_stage0[41][3] <= 128'ha2cb7187dda318f0_84ab5759394301ef   ;
         buf_data_stage0[42][0] <= 128'h8ba4d377135a8dc4_508baa02512a9634   ;
         buf_data_stage0[42][1] <= 128'hf627652a9bbcf7fc_a25e6176e9104e94   ;
         buf_data_stage0[42][2] <= 128'h16cb2218295c8f23_d55393f969640b09   ;
         buf_data_stage0[42][3] <= 128'h7626b51b10c2013e_d643cc60bc12fefa   ;
         buf_data_stage0[43][0] <= 128'h9172fb3bbcee4eed_15f286cd98cfe484   ;
         buf_data_stage0[43][1] <= 128'haeba188cd9e2730b_0c8138e3edb38e2b   ;
         buf_data_stage0[43][2] <= 128'ha34130ebc46c44e5_af89011a31365cd6   ;
         buf_data_stage0[43][3] <= 128'h5179dc9d87633d6c_46da67c9b43bd023   ;
         buf_data_stage0[44][0] <= 128'h53c76871dff702a1_e8877758a3088f14   ;
         buf_data_stage0[44][1] <= 128'ha769004743919df4_2a4595fa0b2602d5   ;
         buf_data_stage0[44][2] <= 128'h0e25e373023f57d5_f295d780cef2ae72   ;
         buf_data_stage0[44][3] <= 128'h25bfee051b98832a_44ba95e66fe3dfc9   ;
         buf_data_stage0[45][0] <= 128'ha8e074fc016fbd68_3614b5eacbe6050b   ;
         buf_data_stage0[45][1] <= 128'h6cdff481a7e55282_f9ba41162c743fad   ;
         buf_data_stage0[45][2] <= 128'hc7e2c0d4a410a62b_708afd81177c7d3e   ;
         buf_data_stage0[45][3] <= 128'hc802df7a06ab5f9c_8475ae8c3a4d12bd   ;
         buf_data_stage0[46][0] <= 128'h64e0a4d91c445ad2_9275285285506f7b   ;
         buf_data_stage0[46][1] <= 128'h02a71ddd26cc0928_b09f911815950e0f   ;
         buf_data_stage0[46][2] <= 128'hc7d6c99eeee94b9a_ac2e7eab2e3c5ffe   ;
         buf_data_stage0[46][3] <= 128'h563888b54cfdb601_43c23e23a915de89   ;
         buf_data_stage0[47][0] <= 128'h0c26e0b997ad762f_f31566a7f1f722b4   ;
         buf_data_stage0[47][1] <= 128'h48bb429405cd1ea3_5a2e7be66e2a21ea   ;
         buf_data_stage0[47][2] <= 128'hf647d19614a27444_2345a71eaffc2035   ;
         buf_data_stage0[47][3] <= 128'hd12f5aeb8cb85753_d0f921abf78adedf   ;
         buf_data_stage0[48][0] <= 128'hd1df70583aa377bd_c38f747a85de4aa4   ;
         buf_data_stage0[48][1] <= 128'hbf562ae382c86418_c68e3b6d2f30c935   ;
         buf_data_stage0[48][2] <= 128'h8823e9bc572210f5_c788b17fd335f783   ;
         buf_data_stage0[48][3] <= 128'h2a7546ef4de6fa30_09f9e169b0a08661   ;
         buf_data_stage0[49][0] <= 128'h144bc67bad4714b8_a7d7dae896cc90f5   ;
         buf_data_stage0[49][1] <= 128'h266295c733de0c97_8db80ca1c1bc569e   ;
         buf_data_stage0[49][2] <= 128'hed0e610eae3ad206_02ddf1a92518339e   ;
         buf_data_stage0[49][3] <= 128'h675a8e29087cda4a_c3da8d02d0acf716   ;
         buf_data_stage0[50][0] <= 128'hc22bfc982256840c_f44329005cffcf03   ;
         buf_data_stage0[50][1] <= 128'hfadeed4ae4c72415_2741aa0eb1bc98e3   ;
         buf_data_stage0[50][2] <= 128'h7500d9c66a5efd31_e019ff3dff6fdd7f   ;
         buf_data_stage0[50][3] <= 128'h4844ad07ce36faff_d803d6df1a470f73   ;
         buf_data_stage0[51][0] <= 128'hf834bb1a0a3df986_a47c3fa8d52dc7c2   ;
         buf_data_stage0[51][1] <= 128'h5affae0fd8d81396_eeb43ab53470ad77   ;
         buf_data_stage0[51][2] <= 128'hf2d1393e70819ebf_774ac226945f4a4f   ;
         buf_data_stage0[51][3] <= 128'h40147bf2c9fb1a97_bbfcdd446c97b284   ;
         buf_data_stage0[52][0] <= 128'hc7ea3e234135227d_5b75961c6164d19f   ;
         buf_data_stage0[52][1] <= 128'hfafdf655f12048fc_8ddd90a1451f8409   ;
         buf_data_stage0[52][2] <= 128'h057076fdb2b760f2_22e5a40a3f38c37a   ;
         buf_data_stage0[52][3] <= 128'h40826a44b7edc13f_665a3ed81f547d3d   ;
         buf_data_stage0[53][0] <= 128'ha976a734b6df3367_67473d64cb95c097   ;
         buf_data_stage0[53][1] <= 128'h2b22490639ab02af_7a93239e44b996b6   ;
         buf_data_stage0[53][2] <= 128'ha25632a74833266b_5a47184682864635   ;
         buf_data_stage0[53][3] <= 128'h376dbe66953f544b_e0908d6ad3d4fee1   ;
         buf_data_stage0[54][0] <= 128'h68a0852b4d45c72e_bba3cbff6b007910   ;
         buf_data_stage0[54][1] <= 128'h9d3595d1295daf33_96140c88282b4636   ;
         buf_data_stage0[54][2] <= 128'hd7deb511ae8e349b_b5cf80287fb0263c   ;
         buf_data_stage0[54][3] <= 128'hb29a8b8da8943368_550dd143a5fdc5a2   ;
         buf_data_stage0[55][0] <= 128'h1ee20087ae155450_b2c847e9dc4363c1   ;
         buf_data_stage0[55][1] <= 128'h59428f55043e67bb_4f01ddbca741ea4d   ;
         buf_data_stage0[55][2] <= 128'h477fde0c7aaaec08_714a2c69e9069a04   ;
         buf_data_stage0[55][3] <= 128'haf5c2aa7f0661157_83e4c279808fb7c4   ;
         buf_data_stage0[56][0] <= 128'h7b83abdf412342cf_68a0852b4d45c72e   ;
         buf_data_stage0[56][1] <= 128'h8a8df6e55efde538_bd74d2392089739d   ;
         buf_data_stage0[56][2] <= 128'h1f150810b72f4c5f_dc640d07c741760f   ;
         buf_data_stage0[56][3] <= 128'h5c8246854086b223_30a727ca9e5732bc   ;
         buf_data_stage0[57][0] <= 128'h0a9f5ec592b3f2a1_cfb1ce7068f68687   ;
         buf_data_stage0[57][1] <= 128'h74cb6a5ff62cea9b_9e4bce62edabab35   ;
         buf_data_stage0[57][2] <= 128'h58284e98530357c3_a2cd42a64c2068be   ;
         buf_data_stage0[57][3] <= 128'hcd2567e474c5595e_a60fa40ef8646a13   ;
         buf_data_stage0[58][0] <= 128'h83c83e4ba3d808fc_8ead190fdecaa1f9   ;
         buf_data_stage0[58][1] <= 128'hc5c2e13ef2613d03_a90795b2c56e6325   ;
         buf_data_stage0[58][2] <= 128'h0df06cf609fdc121_2de2dd1a127847ea   ;
         buf_data_stage0[58][3] <= 128'h8f47b01167b0bf72_e817dd796f1732d9   ;
         buf_data_stage0[59][0] <= 128'h5f1c5627a2d38f6a_e917343e8a156490   ;
         buf_data_stage0[59][1] <= 128'hd372e962b1400f80_67c133f45c8e5642   ;
         buf_data_stage0[59][2] <= 128'h38ea75ff4b1c2598_dbaaeaf7d5942229   ;
         buf_data_stage0[59][3] <= 128'h2345a71eaffc2035_3a944cc8be72b76f   ;
         buf_data_stage0[60][0] <= 128'h99f09f9d7cab0a09_6525376dde5556c4   ;
         buf_data_stage0[60][1] <= 128'hb2cc1aa6fcf0b4de_40dc1259d5a00847   ;
         buf_data_stage0[60][2] <= 128'h83d81879d53d7de7_865373891e32e0ec   ;
         buf_data_stage0[60][3] <= 128'h4cf95613c3d2c8ad_e261a2f802f09e94   ;
         buf_data_stage0[61][0] <= 128'hbc455272609af01f_d01296e27692a37f   ;
         buf_data_stage0[61][1] <= 128'heb74fb279398e703_b37f088a4dfd6a73   ;
         buf_data_stage0[61][2] <= 128'heeab6337d943f870_276fd7ae450aee4b   ;
         buf_data_stage0[61][3] <= 128'h22c135e019c63f7b_bf22b933bbca08a1   ;
         buf_data_stage0[62][0] <= 128'h2da6da812ce10161_6eaaf1601e58432f   ;
         buf_data_stage0[62][1] <= 128'h20ee98f7d40ad43f_096b54843b34462c   ;
         buf_data_stage0[62][2] <= 128'h96495fa8c7bfa7cc_f2167bda2397e71e   ;
         buf_data_stage0[62][3] <= 128'hc459c201fd4af049_a273580023ba9a38   ;
         buf_data_stage0[63][0] <= 128'hfffdffff00000003_d1df70583aa377bd   ;
         buf_data_stage0[63][1] <= 128'hffeffffefffffff1_48bb429405cd1ea3   ;
         buf_data_stage0[63][2] <= 128'h007fffffffffff80_1ae5253581bde075   ;
         buf_data_stage0[63][3] <= 128'h0400000000000400_3de19c67cf496a74   ;
   
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