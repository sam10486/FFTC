 `timescale 1 ns/1 ps     

 module TW_ROM3_1024_64(
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
         buf_data_stage0[0][1] <= 128'hffeffffefffffff1_81efc17180eb1719    ; // BC=64
         buf_data_stage0[0][2] <= 128'h0200000000000000_0400000000000400    ; // BC=128
         buf_data_stage0[0][3] <= 128'hdfffffff00002001_e9097466e450f697    ; // BC=192
         buf_data_stage0[1][0] <= 128'h2207b30251d4c9a8_d782274663f8b408    ;
         buf_data_stage0[1][1] <= 128'h14dfb28c12daa34a_887ed29b21bdd6bb    ;
         buf_data_stage0[1][2] <= 128'h54a3a992fb184707_422cffbdc5e23135    ;
         buf_data_stage0[1][3] <= 128'hac25b545e7b08b55_53d1660388b1f739    ;
         buf_data_stage0[2][0] <= 128'hd8452f144f2e3d4b_03f08ae670ad3bd5    ;
         buf_data_stage0[2][1] <= 128'hb5b81bc8fe6ea295_2411babf1806a91a    ;
         buf_data_stage0[2][2] <= 128'hbe9e5c79d5b11928_afee4ec11b1cdcd6    ;
         buf_data_stage0[2][3] <= 128'hbbfcdd446c97b284_ab4b17941db405e1    ;
         buf_data_stage0[3][0] <= 128'h7fb5acc30389f4d0_0776fe07a33f934f    ;
         buf_data_stage0[3][1] <= 128'heb74fb279398e703_c824673e55fbd908    ;
         buf_data_stage0[3][2] <= 128'h260713e978f980bd_36851cf7dfa2619d    ;
         buf_data_stage0[3][3] <= 128'h552731cdaf01e43c_aaf4ebdbf2eb9bdf    ;
         buf_data_stage0[4][0] <= 128'hbbdfdceff9b2d4ca_bcd5c57029b9c4d3    ;
         buf_data_stage0[4][1] <= 128'h266295c733de0c97_40dc1259d5a00847    ;
         buf_data_stage0[4][2] <= 128'h73f365a91e94da9d_63bcaaad23790ae4    ;
         buf_data_stage0[4][3] <= 128'hbc67bc18714b7ebc_f39fe87a17c72a93    ;
         buf_data_stage0[5][0] <= 128'hbcd5c57029b9c4d3_ab80a9849f5c9159    ;
         buf_data_stage0[5][1] <= 128'h8e710d54bb721bd5_08d35be355abacdf    ;
         buf_data_stage0[5][2] <= 128'h865373891e32e0ec_792387705d19ec67    ;
         buf_data_stage0[5][3] <= 128'h5376e437556c39ae_56c63c2d21397fba    ;
         buf_data_stage0[6][0] <= 128'h9c4563b91246b28e_b7ed6fd97bea1daa    ;
         buf_data_stage0[6][1] <= 128'hd7389ff9172fbfec_d57d24906efda72d    ;
         buf_data_stage0[6][2] <= 128'h8e248d648ca2e7d4_c3af11453fa746eb    ;
         buf_data_stage0[6][3] <= 128'hca2e5f7f0c232f41_ea4e3badb18ac57c    ;
         buf_data_stage0[7][0] <= 128'h912b7e3e532ae35f_32c3f888d962f857    ;
         buf_data_stage0[7][1] <= 128'hd372e962b1400f80_a2a91de43f54785e    ;
         buf_data_stage0[7][2] <= 128'h3aa655c68237533d_8f47b01167b0bf72    ;
         buf_data_stage0[7][3] <= 128'hc562801e38f69a0f_ad74e568be597f1d    ;
         buf_data_stage0[8][0] <= 128'ha0ab7e95c458c04e_c398180c38caffd7    ;
         buf_data_stage0[8][1] <= 128'h070bd10da3da4b6e_3fa0e866c11aab26    ;
         buf_data_stage0[8][2] <= 128'hc788b17fd335f783_ed435feff80dcc93    ;
         buf_data_stage0[8][3] <= 128'hf747b495e4aa33c8_b6a606aecea9a8b4    ;
         buf_data_stage0[9][0] <= 128'h3bc10f75aa162847_71aa2dd46d516325    ;
         buf_data_stage0[9][1] <= 128'hc824673e55fbd908_03ed2eb1bfcfe13d    ;
         buf_data_stage0[9][2] <= 128'h79542c5014345191_8e6c9907f210a3f6    ;
         buf_data_stage0[9][3] <= 128'h8cabf7b181c3bf80_6fba06937875ffb1    ;
         buf_data_stage0[10][0] <= 128'he489eb510cbcac01_f4e07c743d5322f9   ;
         buf_data_stage0[10][1] <= 128'h42407f15e9545468_e4a773bdffe37ed1   ;
         buf_data_stage0[10][2] <= 128'ha41979575c1d72d2_36e7215477c311af   ;
         buf_data_stage0[10][3] <= 128'hfbd2a8a7d3a8d65a_d9ce898c926914a4   ;
         buf_data_stage0[11][0] <= 128'hc398180c38caffd7_5356e9a7c3d367f5   ;
         buf_data_stage0[11][1] <= 128'h484af27ff41fc8ce_cc9ae7babacc5c81   ;
         buf_data_stage0[11][2] <= 128'hc67195fee60739d1_ceb5edfbad43296d   ;
         buf_data_stage0[11][3] <= 128'h9be83f90ff872a8a_5a8a1f8f435463bd   ;
         buf_data_stage0[12][0] <= 128'he104978443ea74c5_8614fceadd5c2aa7   ;
         buf_data_stage0[12][1] <= 128'h2b22490639ab02af_7e133f628acd9609   ;
         buf_data_stage0[12][2] <= 128'h9287d4e8f5b621e8_9b691e37c31cd54a   ;
         buf_data_stage0[12][3] <= 128'h6a735604f3366569_fb28c27aaa349eb3   ;
         buf_data_stage0[13][0] <= 128'h616884339c3ac741_04ed5c6d6ef8d494   ;
         buf_data_stage0[13][1] <= 128'h322df9137f93662b_8db80ca1c1bc569e   ;
         buf_data_stage0[13][2] <= 128'he938758d9804b96a_bb2d99212d82b729   ;
         buf_data_stage0[13][3] <= 128'h7cff26cbd89c7d42_df397a97681ca43d   ;
         buf_data_stage0[14][0] <= 128'h4d6a3319af264a28_227b9fdd365d00ac   ;
         buf_data_stage0[14][1] <= 128'h5541dbfb3f3b268d_73314b7001287e73   ;
         buf_data_stage0[14][2] <= 128'h835e4c93cc06df06_1358e965fe9f4cf4   ;
         buf_data_stage0[14][3] <= 128'h107e764d08d705fb_513263cae028630c   ;
         buf_data_stage0[15][0] <= 128'hdcee6ba66b6361d7_ca229fd580c44658   ;
         buf_data_stage0[15][1] <= 128'h59428f55043e67bb_aeba188cd9e2730b   ;
         buf_data_stage0[15][2] <= 128'hfad6c6c2b16f5c66_40826a44b7edc13f   ;
         buf_data_stage0[15][3] <= 128'h20087ccf5544fe12_47c9bfee53a9b717   ;
         buf_data_stage0[16][0] <= 128'h7b83abdf412342cf_f834bb1a0a3df986   ;
         buf_data_stage0[16][1] <= 128'h5ce12fcfabc79d87_125b796c87b311dc   ;
         buf_data_stage0[16][2] <= 128'h5c8246854086b223_531563ef8bdc494d   ;
         buf_data_stage0[16][3] <= 128'had578f3a5feeae66_90047eaf19df358a   ;
         buf_data_stage0[17][0] <= 128'h6df0ad73a727ee35_d01296e27692a37f   ;
         buf_data_stage0[17][1] <= 128'h666ab63f64c26e41_8103751aad10d7de   ;
         buf_data_stage0[17][2] <= 128'h514e4fdc17d5cec9_d035d7a7bd7363d7   ;
         buf_data_stage0[17][3] <= 128'h00c984dc8069a5b7_f088b016d6a724c9   ;
         buf_data_stage0[18][0] <= 128'h3bbd06984aebc0e1_2be69ee879cb29c0   ;
         buf_data_stage0[18][1] <= 128'hcc9ae7babacc5c81_9a9f15078d70e2ef   ;
         buf_data_stage0[18][2] <= 128'hf295d780cef2ae72_3c62cf3d8a10382e   ;
         buf_data_stage0[18][3] <= 128'h777598b888f13178_5689e42ba2eb79b6   ;
         buf_data_stage0[19][0] <= 128'h83c83e4ba3d808fc_a05107e6c4808d71   ;
         buf_data_stage0[19][1] <= 128'h4f01ddbca741ea4d_0c8138e3edb38e2b   ;
         buf_data_stage0[19][2] <= 128'h8f47b01167b0bf72_a3319fc864a27b2a   ;
         buf_data_stage0[19][3] <= 128'h134e83d486137870_409a5e213e4fd8b2   ;
         buf_data_stage0[20][0] <= 128'h68a0852b4d45c72e_a47c3fa8d52dc7c2   ;
         buf_data_stage0[20][1] <= 128'hb062d8e77e5eeb8c_0d100c8ade4da136   ;
         buf_data_stage0[20][2] <= 128'hb29a8b8da8943368_9c535d0511385d51   ;
         buf_data_stage0[20][3] <= 128'he6fcbdd62fa27c78_43ab62320ad76115   ;
         buf_data_stage0[21][0] <= 128'h348aa2775d1ae8bd_5fc8c61f92acfef5   ;
         buf_data_stage0[21][1] <= 128'h041006d855ca8e8c_68a54931827951c4   ;
         buf_data_stage0[21][2] <= 128'h68ba35d110dcb4ea_756333c53431fb6d   ;
         buf_data_stage0[21][3] <= 128'hc8ab951c4f4c4ad6_6b2eacf31d9a93f2   ;
         buf_data_stage0[22][0] <= 128'h3295240897e95181_3c1bf1b0082efadc   ;
         buf_data_stage0[22][1] <= 128'h7e1440ddc1f78fdb_68a8e3a61f4a0221   ;
         buf_data_stage0[22][2] <= 128'h132fd2a2ee6b0315_9fe77cfbfada435e   ;
         buf_data_stage0[22][3] <= 128'h7183ef1f437fe85f_c00bc2278de8b6c7   ;
         buf_data_stage0[23][0] <= 128'hf834bb1a0a3df986_386ad2740ffe1f9a   ;
         buf_data_stage0[23][1] <= 128'h32b3aa700dd08edb_96495fa8c7bfa7cc   ;
         buf_data_stage0[23][2] <= 128'h40147bf2c9fb1a97_e389c99f275cc357   ;
         buf_data_stage0[23][3] <= 128'h961ba11d1f7ef78e_f89da4165927098a   ;
         buf_data_stage0[24][0] <= 128'h36e6ee0a706c8023_bc455272609af01f   ;
         buf_data_stage0[24][1] <= 128'haeba188cd9e2730b_13dd47a18f9289b0   ;
         buf_data_stage0[24][2] <= 128'h5ae0d8ffeab15924_5acc38339f4cf805   ;
         buf_data_stage0[24][3] <= 128'h2fb3c4e5e4eec6e9_bb5cd0b3c399006c   ;
         buf_data_stage0[25][0] <= 128'h8913a944437be72c_f93dbeb3b0f67fde   ;
         buf_data_stage0[25][1] <= 128'h67c133f45c8e5642_a0881975ab5f10cb   ;
         buf_data_stage0[25][2] <= 128'he086f7cd7666e0e0_3dbeaca80756a321   ;
         buf_data_stage0[25][3] <= 128'h6cb91cac167760ec_23135572a3138cd5   ;
         buf_data_stage0[26][0] <= 128'h98c6e387b6d4a728_a5e550dc6e5a5fdd   ;
         buf_data_stage0[26][1] <= 128'hc8965a2fcb3a8743_f4cc8ff50ffad951   ;
         buf_data_stage0[26][2] <= 128'h5f6da94def60c8eb_7afcddcff52e72a6   ;
         buf_data_stage0[26][3] <= 128'he596750d9ed85e3e_4a7fc37813522288   ;
         buf_data_stage0[27][0] <= 128'h2da6da812ce10161_7248447c0fb718b0   ;
         buf_data_stage0[27][1] <= 128'h676f89d9da059271_dd852b82d0d4fffa   ;
         buf_data_stage0[27][2] <= 128'hc459c201fd4af049_d150ce69ea5ac0c3   ;
         buf_data_stage0[27][3] <= 128'h95b40b244b7d15c8_07f162b945467bdc   ;
         buf_data_stage0[28][0] <= 128'h36d11d9ae31cc4c6_8913a944437be72c   ;
         buf_data_stage0[28][1] <= 128'h6cdff481a7e55282_e1a41ab1a2a0e9d9   ;
         buf_data_stage0[28][2] <= 128'hc1c63988c9cc243c_0fb302cedc6a6f9a   ;
         buf_data_stage0[28][3] <= 128'h074fcaa4fbd67572_baf54db7b9964c68   ;
         buf_data_stage0[29][0] <= 128'h59157e3f1bcde14e_215546f5c49c2c49   ;
         buf_data_stage0[29][1] <= 128'h75d65f2a2719395c_c18944fc27e095fa   ;
         buf_data_stage0[29][2] <= 128'h1a379bc281163941_502e484899195dae   ;
         buf_data_stage0[29][3] <= 128'h0c4e3272aac620cf_fdb375fc8eb23d8f   ;
         buf_data_stage0[30][0] <= 128'hf0cc3ddf72d20532_c92b365033d7ca47   ;
         buf_data_stage0[30][1] <= 128'hc224f4d8b0e5e6d4_9201bae757fd085d   ;
         buf_data_stage0[30][2] <= 128'h22e5a40a3f38c37a_09a8a31d1b350cd9   ;
         buf_data_stage0[30][3] <= 128'h5961cbcd4d19ea49_184b93c9547976ab   ;
         buf_data_stage0[31][0] <= 128'h58c3de196dbcf497_adda166b62c2ba2c   ;
         buf_data_stage0[31][1] <= 128'h48bb429405cd1ea3_c465162d27278a78   ;
         buf_data_stage0[31][2] <= 128'h60db79e8cc72fe5b_c5e4bb2a5aa63a07   ;
         buf_data_stage0[31][3] <= 128'h6e0b9a3cd762ef3e_28f555d7e67baa6c   ;
         buf_data_stage0[32][0] <= 128'hd3946b6a55f9087f_9d24a3f365407288   ;
         buf_data_stage0[32][1] <= 128'h8823e9bc572210f5_954aa1c27e804547   ;
         buf_data_stage0[32][2] <= 128'hd2abf21029ace519_8024d1d331c08932   ;
         buf_data_stage0[32][3] <= 128'h62ae44218641740b_50810d63f4c5ee0f   ;
         buf_data_stage0[33][0] <= 128'ha29548a34debc5a1_f87f98020c02408b   ;
         buf_data_stage0[33][1] <= 128'hf2669703ab82ae0c_e872721a5076c7f3   ;
         buf_data_stage0[33][2] <= 128'h889bd78ab81efde4_32901513fcf020bc   ;
         buf_data_stage0[33][3] <= 128'h1f57055bf6c42d76_ff0a48026e3c2377   ;
         buf_data_stage0[34][0] <= 128'h0eeb4fc8d71a1dce_e906e3ed39ac0064   ;
         buf_data_stage0[34][1] <= 128'h37dd91cf8aec8378_f2167bda2397e71e   ;
         buf_data_stage0[34][2] <= 128'h2dae343b6e33f525_6076688bf776c0cb   ;
         buf_data_stage0[34][3] <= 128'h8f15d906607a6bd6_3a7dcbf2f345baac   ;
         buf_data_stage0[35][0] <= 128'h830fb4843dded11c_58be2489beb3a0e1   ;
         buf_data_stage0[35][1] <= 128'h7500d9c66a5efd31_8e248d648ca2e7d4   ;
         buf_data_stage0[35][2] <= 128'h407bbda1f67e22f5_a38cf6e0a625bb88   ;
         buf_data_stage0[35][3] <= 128'heed4bdf972414053_74682009f7342ff3   ;
         buf_data_stage0[36][0] <= 128'h8cb984ebc4e4d006_4bff3d3bb07ee453   ;
         buf_data_stage0[36][1] <= 128'he54b62ed0078198f_54dd51ab36c2ced5   ;
         buf_data_stage0[36][2] <= 128'he389c99f275cc357_37b6eb830b9f524a   ;
         buf_data_stage0[36][3] <= 128'hf800f03224347908_7621b9695d0cd22b   ;
         buf_data_stage0[37][0] <= 128'ha407f39b04c804df_7e1394abc498ed1b   ;
         buf_data_stage0[37][1] <= 128'h37e079c4ed3a3f1a_7b5b3141d4625834   ;
         buf_data_stage0[37][2] <= 128'hf4099008c8ae6010_696514beb2a9b801   ;
         buf_data_stage0[37][3] <= 128'hbdda747d75b5ca8f_4416929f8021d7ed   ;
         buf_data_stage0[38][0] <= 128'ha09154537ca9af78_7d25a48af842e44f   ;
         buf_data_stage0[38][1] <= 128'hba32f0227aa6dc3b_9d17dc6c938396f9   ;
         buf_data_stage0[38][2] <= 128'h96f9535e57c589f9_fe733965ddbb97e9   ;
         buf_data_stage0[38][3] <= 128'hbaf54db7b9964c68_f5bfc31d599973bf   ;
         buf_data_stage0[39][0] <= 128'hce93f9dcfeb25738_ecf8e718ecd8cf70   ;
         buf_data_stage0[39][1] <= 128'h057076fdb2b760f2_3c12decf884bb921   ;
         buf_data_stage0[39][2] <= 128'h29fd64ae4465735e_074fcaa4fbd67572   ;
         buf_data_stage0[39][3] <= 128'hdf656ec1048fb051_0d9c6df5efd308b0   ;
         buf_data_stage0[40][0] <= 128'hd16910f590d26cbf_266295c733de0c97   ;
         buf_data_stage0[40][1] <= 128'h0e25e373023f57d5_653bb56c711204b3   ;
         buf_data_stage0[40][2] <= 128'h6921a4d9133b8905_0326959b5ac958dd   ;
         buf_data_stage0[40][3] <= 128'h90047eaf19df358a_6c99fb6b94b99383   ;
         buf_data_stage0[41][0] <= 128'hb4eae5b9323e0715_cd39da154846b5db   ;
         buf_data_stage0[41][1] <= 128'he46e808037be014b_5a47184682864635   ;
         buf_data_stage0[41][2] <= 128'h9c647c0d8c31ae27_a889732cc281668c   ;
         buf_data_stage0[41][3] <= 128'h966f7c01fdc7a6fd_0a6b348bfda59d1d   ;
         buf_data_stage0[42][0] <= 128'h4bff3d3bb07ee453_5844b84b7389c543   ;
         buf_data_stage0[42][1] <= 128'h27212451cbd182b7_81c43f0c0b7e0c32   ;
         buf_data_stage0[42][2] <= 128'h1d60fdc8880703bd_4caf5643f7e5d0a9   ;
         buf_data_stage0[42][3] <= 128'h1197a3055c1a1ab2_092a2a65c5fbbccc   ;
         buf_data_stage0[43][0] <= 128'h80d2bcb05393e568_42a8f15d4dc607a7   ;
         buf_data_stage0[43][1] <= 128'hd14efbb391ceeff3_1a379bc281163941   ;
         buf_data_stage0[43][2] <= 128'h30a727ca9e5732bc_b4fc8e5fa1dcdf12   ;
         buf_data_stage0[43][3] <= 128'h4d239ddf9739c429_ec7363514e77cc44   ;
         buf_data_stage0[44][0] <= 128'h0e3ad74e485be598_22bac6c06ba0a8c5   ;
         buf_data_stage0[44][1] <= 128'h4dee055bef270fed_04445b5b936a0565   ;
         buf_data_stage0[44][2] <= 128'hcc90b7ca6352d287_00c984dc8069a5b7   ;
         buf_data_stage0[44][3] <= 128'h91de4e1f4785d5d6_13bb167439b6da6c   ;
         buf_data_stage0[45][0] <= 128'h7319e1644d40b953_f54f46045b470e81   ;
         buf_data_stage0[45][1] <= 128'h22ed15a842407081_06c7535788c631a5   ;
         buf_data_stage0[45][2] <= 128'h6e9a8172367f4acb_5285317c06f7a6d9   ;
         buf_data_stage0[45][3] <= 128'h528480e0af35a4f4_0f707704ba885dd1   ;
         buf_data_stage0[46][0] <= 128'h93eeee91fdb257eb_a7bb9afe98517761   ;
         buf_data_stage0[46][1] <= 128'h59413bb10e039b6e_9834d61b26044d35   ;
         buf_data_stage0[46][2] <= 128'hf9fb64aedadcbd74_6ccd42dd48dd4d18   ;
         buf_data_stage0[46][3] <= 128'h3e1c07369d317652_13f0802da23bed12   ;
         buf_data_stage0[47][0] <= 128'h9d24a3f365407288_b2cc1aa6fcf0b4de   ;
         buf_data_stage0[47][1] <= 128'hc5ff6cb7eb38fddc_c788b17fd335f783   ;
         buf_data_stage0[47][2] <= 128'hf6ca80e417fb35d4_445e6192241481f7   ;
         buf_data_stage0[47][3] <= 128'h27d671fb8e9d8f2b_2e12da48d5730e3e   ;
         buf_data_stage0[48][0] <= 128'hba856751f25d9591_f31566a7f1f722b4   ;
         buf_data_stage0[48][1] <= 128'h897a64fb4f51752c_78bc1b78d421d485   ;
         buf_data_stage0[48][2] <= 128'hc5e4bb2a5aa63a07_c562801e38f69a0f   ;
         buf_data_stage0[48][3] <= 128'h4e9ea2ea084e684c_e7be6c84a21e9a5e   ;
         buf_data_stage0[49][0] <= 128'hfdd46da57ecb43be_ec4db23b7af29272   ;
         buf_data_stage0[49][1] <= 128'h0c8138e3edb38e2b_6fbbde080c67b343   ;
         buf_data_stage0[49][2] <= 128'hc6fd9686b306c09e_ecb4bbe5d8acc33d   ;
         buf_data_stage0[49][3] <= 128'h1ddb671c380b9672_1ba9c0bd7cdc7bfc   ;
         buf_data_stage0[50][0] <= 128'h56bccae307df2437_d9275303e8ae5801   ;
         buf_data_stage0[50][1] <= 128'ha292d3d73043a655_1ba99339d76ebe02   ;
         buf_data_stage0[50][2] <= 128'h340fbe483942c822_b0eecc66a658a9f0   ;
         buf_data_stage0[50][3] <= 128'h5860874c505a530c_95aaa2c3d32ba64d   ;
         buf_data_stage0[51][0] <= 128'h8ba4d377135a8dc4_a29548a34debc5a1   ;
         buf_data_stage0[51][1] <= 128'h320192dd01d113bf_229a78d0a6cb9857   ;
         buf_data_stage0[51][2] <= 128'h7626b51b10c2013e_665a3ed81f547d3d   ;
         buf_data_stage0[51][3] <= 128'h3803a22745985ab3_087e7186eb3bc331   ;
         buf_data_stage0[52][0] <= 128'h72719822e2f31fe9_a45b1e29219fed1b   ;
         buf_data_stage0[52][1] <= 128'h58284e98530357c3_50cd47280836f256   ;
         buf_data_stage0[52][2] <= 128'h17c5e63fb9553690_7cff26cbd89c7d42   ;
         buf_data_stage0[52][3] <= 128'hb6a606aecea9a8b4_2d3d7d2d3a6545d7   ;
         buf_data_stage0[53][0] <= 128'h2a38698aa867355e_e6490a2829b07fcd   ;
         buf_data_stage0[53][1] <= 128'h6deee0df1239d41d_6cc5b35066a5cd76   ;
         buf_data_stage0[53][2] <= 128'hd150ce69ea5ac0c3_f8cf663e1dbf4a40   ;
         buf_data_stage0[53][3] <= 128'hf82473a740ffae97_3067da8353e8284a   ;
         buf_data_stage0[54][0] <= 128'h754ae602f03d55b5_508baa02512a9634   ;
         buf_data_stage0[54][1] <= 128'hefd29bf35c60fd3c_e4a6f0cd950fb405   ;
         buf_data_stage0[54][2] <= 128'h6fe07aaaf934ef89_07ecb4df9fd1f5bd   ;
         buf_data_stage0[54][3] <= 128'h5eb8c1fa176798ce_e61778b604e935db   ;
         buf_data_stage0[55][0] <= 128'he09445e538924149_388e6fcba4e2fa28   ;
         buf_data_stage0[55][1] <= 128'h83d81879d53d7de7_d14efbb391ceeff3   ;
         buf_data_stage0[55][2] <= 128'h5c71248233cdb2f2_0852bb5e5c72d976   ;
         buf_data_stage0[55][3] <= 128'hc1aa7afb0b4dd4d4_d6360d4b6a33510d   ;
         buf_data_stage0[56][0] <= 128'h121d0f9208af78ae_8ba4d377135a8dc4   ;
         buf_data_stage0[56][1] <= 128'h5a2e7be66e2a21ea_a25632a74833266b   ;
         buf_data_stage0[56][2] <= 128'h80115ef0dbca66f0_7f9b48b28bbb104d   ;
         buf_data_stage0[56][3] <= 128'ha0dc5443326f4ec5_a1eb6c432cef8413   ;
         buf_data_stage0[57][0] <= 128'h478a38cf268a625c_bf1af8ad0d499232   ;
         buf_data_stage0[57][1] <= 128'hd4aa0a622450bb8f_54b9bbe44d5781e4   ;
         buf_data_stage0[57][2] <= 128'h564d14c46123d6ca_e817dd796f1732d9   ;
         buf_data_stage0[57][3] <= 128'he248a1763a0e0a75_0824f08fcb7f49b6   ;
         buf_data_stage0[58][0] <= 128'h83541ab37db4bd31_c6be195a51eafdcd   ;
         buf_data_stage0[58][1] <= 128'h4c767973cff43d86_1ae0994c95598b93   ;
         buf_data_stage0[58][2] <= 128'hc8fb697997fdee51_95ad18593f948c89   ;
         buf_data_stage0[58][3] <= 128'hf39fe87a17c72a93_00ba98ef336d6301   ;
         buf_data_stage0[59][0] <= 128'h64e0a4d91c445ad2_1c2e596734b9ed86   ;
         buf_data_stage0[59][1] <= 128'hb743ee2189526537_37e079c4ed3a3f1a   ;
         buf_data_stage0[59][2] <= 128'h563888b54cfdb601_6e3884f94a727674   ;
         buf_data_stage0[59][3] <= 128'hb112a4c9bb7ed35a_fd9bfd8fd467fc3e   ;
         buf_data_stage0[60][0] <= 128'hfdeba23e89465e98_286e45fdd32107fb   ;
         buf_data_stage0[60][1] <= 128'h13dd47a18f9289b0_5ab6fdcd05ab9fcd   ;
         buf_data_stage0[60][2] <= 128'had128cbc80f19bff_9c647c0d8c31ae27   ;
         buf_data_stage0[60][3] <= 128'ha31f2512bcb9205e_440de40078fda81f   ;
         buf_data_stage0[61][0] <= 128'ha47c3fa8d52dc7c2_02b91178daf2e17d   ;
         buf_data_stage0[61][1] <= 128'h418eb28ba7bb1e8b_8f5b6c01bef2c8e9   ;
         buf_data_stage0[61][2] <= 128'hd5aa5b8ead0cabf2_bbb1aefbe80f442a   ;
         buf_data_stage0[61][3] <= 128'h2d4f763ce82d6c5e_18abd45cc1ea68ef   ;
         buf_data_stage0[62][0] <= 128'hbd063f1db48f1c30_d438475a1493a4d2   ;
         buf_data_stage0[62][1] <= 128'h7ac0c526a8f55662_ef57e2eea04fcf00   ;
         buf_data_stage0[62][2] <= 128'h9b691e37c31cd54a_916fba35e2f014ff   ;
         buf_data_stage0[62][3] <= 128'h1151eaacb1b893c9_1a0cfd7a80fd5d7b   ;
         buf_data_stage0[63][0] <= 128'h5b11501d07d1bfa5_0c26e0b997ad762f   ;
         buf_data_stage0[63][1] <= 128'h52ca810d84ba33e7_8823e9bc572210f5   ;
         buf_data_stage0[63][2] <= 128'h840fa37ec53a39e1_3de19c67cf496a74   ;
         buf_data_stage0[63][3] <= 128'he9097466e450f697_55037bc094c6b9f5   ;
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'hffeffffefffffff1_81efc17180eb1719; // BC=64
         buf_data_stage1[0][2] <= 128'h0200000000000000_0400000000000400; // BC=128
         buf_data_stage1[0][3] <= 128'hdfffffff00002001_e9097466e450f697; // BC=192

         buf_data_stage1[1][0] <= 128'h58c3de196dbcf497_adda166b62c2ba2c; // BC=16
         buf_data_stage1[1][1] <= 128'h48bb429405cd1ea3_c465162d27278a78;
         buf_data_stage1[1][2] <= 128'h60db79e8cc72fe5b_c5e4bb2a5aa63a07;
         buf_data_stage1[1][3] <= 128'h6e0b9a3cd762ef3e_28f555d7e67baa6c;
         buf_data_stage1[2][0] <= 128'hd3946b6a55f9087f_9d24a3f365407288; // BC=32
         buf_data_stage1[2][1] <= 128'h8823e9bc572210f5_954aa1c27e804547;
         buf_data_stage1[2][2] <= 128'hd2abf21029ace519_8024d1d331c08932;
         buf_data_stage1[2][3] <= 128'h62ae44218641740b_50810d63f4c5ee0f;
         buf_data_stage1[3][0] <= 128'h5b11501d07d1bfa5_0c26e0b997ad762f; // BC=48
         buf_data_stage1[3][1] <= 128'h52ca810d84ba33e7_8823e9bc572210f5;
         buf_data_stage1[3][2] <= 128'h840fa37ec53a39e1_3de19c67cf496a74;
         buf_data_stage1[3][3] <= 128'he9097466e450f697_55037bc094c6b9f5;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'hfffffffefffc0001_0000001fffffffe0; // BC=64
         buf_data_stage2[2] <= 128'h0000001000000000_fffffbff00000001; // BC=128
         buf_data_stage2[3] <= 128'hffbfffff00000001_0000000000008000; // BC=192
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
         buf_const[0] <= 128'hfffffffefffc0001_0000001fffffffe0;
         buf_const[1] <= 128'hfffffffefffc0001_0000001fffffffe0;
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