 `timescale 1 ns/1 ps     

 module TW_ROM4_1024_64(
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
         buf_data_stage0[0][1]   <= 128'hfffffffeffffffc1_52ca810d84ba33e7    ; // BC=64
         buf_data_stage0[0][2]   <= 128'h0000000000001000_dfffffff00002001    ; // BC=128
         buf_data_stage0[0][3]   <= 128'hfffffffefffc0001_bf8a7473016d6c46    ; // BC=192
         buf_data_stage0[1][0]   <= 128'hd0e5c71177433cdc_4a3f9ccc62d9a86a    ;
         buf_data_stage0[1][1]   <= 128'hc68e3b6d2f30c935_b056b27b51487fcd    ;
         buf_data_stage0[1][2]   <= 128'h5c71248233cdb2f2_273e6095cab05f5f    ;
         buf_data_stage0[1][3]   <= 128'he3b6df5b0c934398_cc267039902d703f    ;
         buf_data_stage0[2][0]   <= 128'h912b7e3e532ae35f_f3f04b444500c07c    ;
         buf_data_stage0[2][1]   <= 128'hb520704635472865_95748ac7aba736dd    ;
         buf_data_stage0[2][2]   <= 128'hb7e3ee44ae35e6ee_00c88f0ebf2d82fa    ;
         buf_data_stage0[2][3]   <= 128'h07046ea6728644ae_fbe42146eeff0587    ;
         buf_data_stage0[3][0]   <= 128'h1a8c7b40a550e18a_d8452f144f2e3d4b    ;
         buf_data_stage0[3][1]   <= 128'h5ce12fcfabc79d87_418eb28ba7bb1e8b    ;
         buf_data_stage0[3][2]   <= 128'hc7b40bfd0e189e58_bbfcdd446c97b284    ;
         buf_data_stage0[3][3]   <= 128'h12fd008a79d86a32_015a1957e0fa91f1    ;
         buf_data_stage0[4][0]   <= 128'hdcee6ba66b6361d7_4d6a3319af264a28    ;
         buf_data_stage0[4][1]   <= 128'hc465162d27278a78_0c8138e3edb38e2b    ;
         buf_data_stage0[4][2]   <= 128'he6ba7484361d6232_107e764d08d705fb    ;
         buf_data_stage0[4][3]   <= 128'h5162deb878a773ba_49660d80f10bf752    ;
         buf_data_stage0[5][0]   <= 128'hca229fd580c44658_227b9fdd365d00ac    ;
         buf_data_stage0[5][1]   <= 128'h77580a6cceee6a33_529c948f9931e599    ;
         buf_data_stage0[5][2]   <= 128'h29fd64ae4465735e_4d300b054b308fc2    ;
         buf_data_stage0[5][3]   <= 128'h80a6d463e6a3288b_7f6bc0c63a2ce4f2    ;
         buf_data_stage0[6][0]   <= 128'h6b353155d3c8bdc5_b5609d15159f67c6    ;
         buf_data_stage0[6][1]   <= 128'h32b3aa700dd08edb_9b395aa9910d32bb    ;
         buf_data_stage0[6][2]   <= 128'h531563ef8bdc494d_b0eecc66a658a9f0    ;
         buf_data_stage0[6][3]   <= 128'h3aa7040808edacd5_99339f30ebe01e46    ;
         buf_data_stage0[7][0]   <= 128'hae7d2abe72929acf_bbdfdceff9b2d4ca    ;
         buf_data_stage0[7][1]   <= 128'h60b550375b594c6c_b743ee2189526537    ;
         buf_data_stage0[7][2]   <= 128'hd2abf21029ace519_bc67bc18714b7ebc    ;
         buf_data_stage0[7][3]   <= 128'h55037bc094c6b9f5_6c99fb6b94b99383    ;
         buf_data_stage0[8][0]   <= 128'h58c3de196dbcf497_36d11d9ae31cc4c6    ;
         buf_data_stage0[8][1]   <= 128'hcf08798d90c2da57_7500d9c66a5efd31    ;
         buf_data_stage0[8][2]   <= 128'h3de19c67cf496a74_074fcaa4fbd67572    ;
         buf_data_stage0[8][3]   <= 128'h8798e5fc2da56310_2decfc45bb920c3f    ;
         buf_data_stage0[9][0]   <= 128'h6fb69219dde133b9_bd6bbb1a325e80f5    ;
         buf_data_stage0[9][1]   <= 128'h125b796c87b311dc_8f5b6c01bef2c8e9    ;
         buf_data_stage0[9][2]   <= 128'h6921a4d9133b8905_91178dda2e17cfd5    ;
         buf_data_stage0[9][3]   <= 128'hb796c9a0311dbedb_15a1f0aca2e6d4b2    ;
         buf_data_stage0[10][0]  <= 128'h36e6ee0a706c8023_f867869c167fdf05   ;
         buf_data_stage0[10][1]  <= 128'h46447d55e4dff74e_b54ef21094dd51e6   ;
         buf_data_stage0[10][2]  <= 128'h6ee0aa74c8022c92_ce03a5fb9dbd6da8   ;
         buf_data_stage0[10][3]  <= 128'h47d562b1ff74db9c_0ba67f08d38231d5   ;
         buf_data_stage0[11][0]  <= 128'hadda166b62c2ba2c_8913a944437be72c   ;
         buf_data_stage0[11][1]  <= 128'h897a64fb4f51752c_ba32f0227aa6dc3b   ;
         buf_data_stage0[11][2]  <= 128'ha166c1092ba2b523_6cb91cac167760ec   ;
         buf_data_stage0[11][3]  <= 128'ha64fbd8c1752b769_aeaf8b1342228246   ;
         buf_data_stage0[12][0]  <= 128'ha2cf6ca76b817fb4_e489eb510cbcac01   ;
         buf_data_stage0[12][1]  <= 128'h4c24d5fc1fa01329_6deee0df1239d41d   ;
         buf_data_stage0[12][2]  <= 128'hf6ca80e417fb35d4_fbd2a8a7d3a8d65a   ;
         buf_data_stage0[12][3]  <= 128'h4d5fc6bc01328b3e_59d4b5812a88a8e2   ;
         buf_data_stage0[13][0]  <= 128'ha697460fbe475779_37b202532b6388a3   ;
         buf_data_stage0[13][1]  <= 128'h5a2e7be66e2a21ea_cb0607f41dd73f96   ;
         buf_data_stage0[13][2]  <= 128'h7461064d75778597_7addfb4ddd770a69   ;
         buf_data_stage0[13][3]  <= 128'he7be6c84a21e9a5e_7d43b528850e4f91   ;
         buf_data_stage0[14][0]  <= 128'ha0ab7e95c458c04e_58c03fd10103f325   ;
         buf_data_stage0[14][1]  <= 128'hd5205a65e9cfeca9_21a94b9e7701adce   ;
         buf_data_stage0[14][2]  <= 128'hb7e9664f8c04d5f6_47d9acd3a99d1b47   ;
         buf_data_stage0[14][3]  <= 128'h05a66beefeca82ae_9a939d5b08cf1af9   ;
         buf_data_stage0[15][0]  <= 128'h9ab4d5fb2ded1731_a0ab7e95c458c04e   ;
         buf_data_stage0[15][1]  <= 128'h52ca810d84ba33e7_83d81879d53d7de7   ;
         buf_data_stage0[15][2]  <= 128'h4d5fbc89d1730655_f747b495e4aa33c8   ;
         buf_data_stage0[15][3]  <= 128'ha810dd77a33e6ad4_e8679b64fadf8252   ;
         buf_data_stage0[16][0]  <= 128'h5b11501d07d1bfa5_121d0f9208af78ae   ;
         buf_data_stage0[16][1]  <= 128'h3babf8a70b9016d7_3aa655c68237533d   ;
         buf_data_stage0[16][2]  <= 128'h1501d62e1bfa4a4f_a0dc5443326f4ec5   ;
         buf_data_stage0[16][3]  <= 128'hbf8a7473016d6c46_5a71ed33c2034dcc   ;
         buf_data_stage0[17][0]  <= 128'hc38f747a85de4aa4_bba3cbff6b007910   ;
         buf_data_stage0[17][1]  <= 128'h1c22e12d886d5731_6a0ebea56445f1fb   ;
         buf_data_stage0[17][2]  <= 128'hf747b495e4aa33c8_8c1ff5b213f6712e   ;
         buf_data_stage0[17][3]  <= 128'h2e12da48d5730e3e_cb4bfb8a7809e8d3   ;
         buf_data_stage0[18][0]  <= 128'h121d0f9208af78ae_817fe73314eddbba   ;
         buf_data_stage0[18][1]  <= 128'h78bc1b78d421d485_9d17dc6c938396f9   ;
         buf_data_stage0[18][2]  <= 128'hd0f921abf78adedf_5a48b7562e44e82e   ;
         buf_data_stage0[18][3]  <= 128'hc1b794cd1d484875_491d333418f27aca   ;
         buf_data_stage0[19][0]  <= 128'h6ce8024cb0531c09_83541ab37db4bd31   ;
         buf_data_stage0[19][1]  <= 128'hc5ff6cb7eb38fddc_865373891e32e0ec   ;
         buf_data_stage0[19][2]  <= 128'h8024d1d331c08932_f39fe87a17c72a93   ;
         buf_data_stage0[19][3]  <= 128'hf6cb8b128fddb3a1_caaad87290ae39c5   ;
         buf_data_stage0[20][0]  <= 128'hba856751f25d9591_754ae602f03d55b5   ;
         buf_data_stage0[20][1]  <= 128'h5ea62b54689a9bef_79542c5014345191   ;
         buf_data_stage0[20][2]  <= 128'h56752acdd9590458_5eb8c1fa176798ce   ;
         buf_data_stage0[20][3]  <= 128'h62b54c73a9beea16_6303877e9be32092   ;
         buf_data_stage0[21][0]  <= 128'h9172fb3bbcee4eed_c85e3636cabe24e1   ;
         buf_data_stage0[21][1]  <= 128'ha34130ebc46c44e5_e019ff3dff6fdd7f   ;
         buf_data_stage0[21][2]  <= 128'h2fb3c4e5e4eec6e9_cd6f2dc6b6ff9258   ;
         buf_data_stage0[21][3]  <= 128'h130ec67ac44e45cc_9ff9e040d7a0ff95   ;
         buf_data_stage0[22][0]  <= 128'h53c76871dff702a1_5c2d04b317242475   ;
         buf_data_stage0[22][1]  <= 128'h0e25e373023f57d5_284ec0fb27e74b4f   ;
         buf_data_stage0[22][2]  <= 128'h7687233b702a0ac4_9db1e9daf2f8b9a0   ;
         buf_data_stage0[22][3]  <= 128'h5e373105f57d4f1e_9322809c53709c80   ;
         buf_data_stage0[23][0]  <= 128'h0c26e0b997ad762f_8ba4d377135a8dc4   ;
         buf_data_stage0[23][1]  <= 128'hf647d19614a27444_9287d4e8f5b621e8   ;
         buf_data_stage0[23][2]  <= 128'h6e0b9a3cd762ef3e_3803a22745985ab3   ;
         buf_data_stage0[23][3]  <= 128'h7d1970ae2744309c_dbe66cc9f544ac8a   ;
         buf_data_stage0[24][0]  <= 128'hd1df70583aa377bd_68a0852b4d45c72e   ;
         buf_data_stage0[24][1]  <= 128'h8823e9bc572210f5_d14efbb391ceeff3   ;
         buf_data_stage0[24][2]  <= 128'hf70590c7377bc2e3_e6fcbdd62fa27c78   ;
         buf_data_stage0[24][3]  <= 128'h3e9bcdf4210f477e_0d3cae656a62034b   ;
         buf_data_stage0[25][0]  <= 128'hf834bb1a0a3df986_2be69ee879cb29c0   ;
         buf_data_stage0[25][1]  <= 128'hf2d1393e70819ebf_45510f2e44f215fd   ;
         buf_data_stage0[25][2]  <= 128'h4bb1b026df98507d_c4a3af7d79ee3399   ;
         buf_data_stage0[25][3]  <= 128'h1393f63519ebe0d3_b9478e881407fbfc   ;
         buf_data_stage0[26][0]  <= 128'hc7ea3e234135227d_fb447b02e4b01772   ;
         buf_data_stage0[26][1]  <= 128'h057076fdb2b760f2_5e4ccaf42adc8acc   ;
         buf_data_stage0[26][2]  <= 128'ha3e240915227c382_f2ca790f7eecb2e7   ;
         buf_data_stage0[26][3]  <= 128'h076fdb82760f1fa9_9402ffcb227e9eef   ;
         buf_data_stage0[27][0]  <= 128'h1ee20087ae155450_bd063f1db48f1c30   ;
         buf_data_stage0[27][1]  <= 128'h477fde0c7aaaec08_54a3a992fb184707   ;
         buf_data_stage0[27][2]  <= 128'h20087ccf5544fe12_1151eaacb1b893c9   ;
         buf_data_stage0[27][3]  <= 128'hfde0cc21aec07b89_35cf611672d8537f   ;
         buf_data_stage0[28][0]  <= 128'h7b83abdf412342cf_3bbd06984aebc0e1   ;
         buf_data_stage0[28][1]  <= 128'h1f150810b72f4c5f_22ed15a842407081   ;
         buf_data_stage0[28][2]  <= 128'h3abdfbca342ce848_777598b888f13178   ;
         buf_data_stage0[28][3]  <= 128'h50810d63f4c5ee0f_7a6cfe951ab5cc68   ;
         buf_data_stage0[29][0]  <= 128'h5f1c5627a2d38f6a_11fe0908c4bd3d50   ;
         buf_data_stage0[29][1]  <= 128'h38ea75ff4b1c2598_2e30a6b31a8fda5a   ;
         buf_data_stage0[29][2]  <= 128'hc562801e38f69a0f_a889732cc281668c   ;
         buf_data_stage0[29][3]  <= 128'ha75ff83fc2597c72_71846dcc64634a5c   ;
         buf_data_stage0[30][0]  <= 128'h99f09f9d7cab0a09_0e5d6adb29f61ab9   ;
         buf_data_stage0[30][1]  <= 128'h83d81879d53d7de7_0dce780354c042d8   ;
         buf_data_stage0[30][2]  <= 128'h09f9e169b0a08661_281ca3b32a618ee7   ;
         buf_data_stage0[30][3]  <= 128'h8187a590d7de67c3_646863f674acd5a2   ;
         buf_data_stage0[31][0]  <= 128'hfffdffff00000003_7b83abdf412342cf   ;
         buf_data_stage0[31][1]  <= 128'h007fffffffffff80_c5ff6cb7eb38fddc   ;
         buf_data_stage0[31][2]  <= 128'hdfffffff00002001_ad578f3a5feeae66   ;
         buf_data_stage0[31][3]  <= 128'h00000007fff7fff8_702ff66b35e27493   ;
         buf_data_stage0[32][0]  <= 128'hffeffffefffffff1_59428f55043e67bb   ;
         buf_data_stage0[32][1]  <= 128'h0400000000000400_c5e4bb2a5aa63a07   ;
         buf_data_stage0[32][2]  <= 128'hfffffffdffff0002_5162deb878a773ba   ;
         buf_data_stage0[32][3]  <= 128'h00000040003fffc0_6c109cd02b5225ea   ;
         buf_data_stage0[33][0]  <= 128'hb2cc1aa6fcf0b4de_5844b84b7389c543   ;
         buf_data_stage0[33][1]  <= 128'h4cf95613c3d2c8ad_6d0c671c951532e8   ;
         buf_data_stage0[33][2]  <= 128'hc1aa7afb0b4dd4d4_c89840d0b22224aa   ;
         buf_data_stage0[33][3]  <= 128'h9561410c2c8acb31_fa40f9e646a125a0   ;
         buf_data_stage0[34][0]  <= 128'hd372e962b1400f80_9b9fbe878d822258   ;
         buf_data_stage0[34][1]  <= 128'h2345a71eaffc2035_18ffd0f745c85d25   ;
         buf_data_stage0[34][2]  <= 128'h2e96384b00f7f2c9_0620c0d9496f28a8   ;
         buf_data_stage0[34][3]  <= 128'h5a71ed33c2034dcc_7165e033f77da2a4   ;
         buf_data_stage0[35][0]  <= 128'h8a8df6e55efde538_322df9137f93662b   ;
         buf_data_stage0[35][1]  <= 128'h5c8246854086b223_340fbe483942c822   ;
         buf_data_stage0[35][2]  <= 128'hdf6e5e97de537758_ef300971e2fd85a3   ;
         buf_data_stage0[35][3]  <= 128'h246859d06b222a38_b0a0b4a566ae8a4c   ;
         buf_data_stage0[36][0]  <= 128'h59428f55043e67bb_c224f4d8b0e5e6d4   ;
         buf_data_stage0[36][1]  <= 128'haf5c2aa7f0661157_889bd78ab81efde4   ;
         buf_data_stage0[36][2]  <= 128'h28f555d7e67baa6c_087e7186eb3bc331   ;
         buf_data_stage0[36][3]  <= 128'hc2aa89fb6115650b_a3ed885a47d3c99b   ;
         buf_data_stage0[37][0]  <= 128'hfafdf655f12048fc_b37f088a4dfd6a73   ;
         buf_data_stage0[37][1]  <= 128'h40826a44b7edc13f_d035d7a7bd7363d7   ;
         buf_data_stage0[37][2]  <= 128'hdf656ec1048fb051_3751b2e10d7dd7f0   ;
         buf_data_stage0[37][3]  <= 128'h26a44f86dc13ebf8_e346a5397e2fed6a   ;
         buf_data_stage0[38][0]  <= 128'h5affae0fd8d81396_93f1a9aae11f11f7   ;
         buf_data_stage0[38][1]  <= 128'h40147bf2c9fb1a97_9b0aa0de59d074d1   ;
         buf_data_stage0[38][2]  <= 128'hfae1033c81395a51_f9118c6250e0e4f7   ;
         buf_data_stage0[38][3]  <= 128'h47bf30a0b1a96bff_68e1d000ed356f55   ;
         buf_data_stage0[39][0]  <= 128'hbf562ae382c86418_484af27ff41fc8ce   ;
         buf_data_stage0[39][1]  <= 128'h2a7546ef4de6fa30_17c5e63fb9553690   ;
         buf_data_stage0[39][2]  <= 128'h62ae44218641740b_9fcc0e7300a70e61   ;
         buf_data_stage0[39][3]  <= 128'h546ef7856fa2fd59_c59d5350a0f560a2   ;
         buf_data_stage0[40][0]  <= 128'h48bb429405cd1ea3_4f01ddbca741ea4d   ;
         buf_data_stage0[40][1]  <= 128'hd12f5aeb8cb85753_cc90b7ca6352d287   ;
         buf_data_stage0[40][2]  <= 128'hb42944e7d1ea2b75_06cf617edc120f21   ;
         buf_data_stage0[40][3]  <= 128'hf5aec5dd857522ee_ea8f0baac04d37b9   ;
         buf_data_stage0[41][0]  <= 128'ha769004743919df4_cc5f047230849d4b   ;
         buf_data_stage0[41][1]  <= 128'h25bfee051b98832a_a273580023ba9a38   ;
         buf_data_stage0[41][2]  <= 128'h90047eaf19df358a_3a7dcbf2f345baac   ;
         buf_data_stage0[41][3]  <= 128'hfee0541488329da5_6688c57e6c0ca9f9   ;
         buf_data_stage0[42][0]  <= 128'haeba188cd9e2730b_9201bae757fd085d   ;
         buf_data_stage0[42][1]  <= 128'h5179dc9d87633d6c_b3650fcf7ca4636e   ;
         buf_data_stage0[42][2]  <= 128'ha188d8892730a515_ac5d5c339e4b6629   ;
         buf_data_stage0[42][3]  <= 128'h9dc9dd8d33d6bae9_f2657992926ed7fc   ;
         buf_data_stage0[43][0]  <= 128'h18e86d133a956718_7e1440ddc1f78fdb   ;
         buf_data_stage0[43][1]  <= 128'hc5e4bb2a5aa63a07_9c647c0d8c31ae27   ;
         buf_data_stage0[43][2]  <= 128'h86d1353756717e72_6fdcd605b9fcca55   ;
         buf_data_stage0[43][3]  <= 128'h4bb2b20863a063a2_fdfb8f4cfad791bb   ;
         buf_data_stage0[44][0]  <= 128'h0d527d671268e9d9_c8965a2fcb3a8743   ;
         buf_data_stage0[44][1]  <= 128'hab60a63765c589c4_f4099008c8ae6010   ;
         buf_data_stage0[44][2]  <= 128'h27d671fb8e9d8f2b_71dec1916362631c   ;
         buf_data_stage0[44][3]  <= 128'h0a638112589c354a_18eb6b950398df82   ;
         buf_data_stage0[45][0]  <= 128'hbdffba837c90d665_8309054cdbe2a574   ;
         buf_data_stage0[45][1]  <= 128'h80115ef0dbca66f0_ddf9a26c283bcd69   ;
         buf_data_stage0[45][2]  <= 128'hfba843a80d664421_052d572f008be4f7   ;
         buf_data_stage0[45][3]  <= 128'h15ef15bda66ef7ff_8f4627191a73b23c   ;
         buf_data_stage0[46][0]  <= 128'h070bd10da3da4b6e_f899a025b28a5f8f   ;
         buf_data_stage0[46][1]  <= 128'h3d0bbc95096d2482_b4515cec8a127ded   ;
         buf_data_stage0[46][2]  <= 128'hbd10daada4b6df90_9db38972215640e4   ;
         buf_data_stage0[46][3]  <= 128'hbbc95466d2481c30_fa5b580df78a04d2   ;
         buf_data_stage0[47][0]  <= 128'h81efc17180eb1719_aeba188cd9e2730b   ;
         buf_data_stage0[47][1]  <= 128'h840fa37ec53a39e1_29fd64ae4465735e   ;
         buf_data_stage0[47][2]  <= 128'hfc17202cb17187e2_47d562b1ff74db9c   ;
         buf_data_stage0[47][3]  <= 128'hfa37f493a39e07c0_24091f607c3815c2   ;
         buf_data_stage0[48][0]  <= 128'h969e9096afde4510_d16910f590d26cbf   ;
         buf_data_stage0[48][1]  <= 128'h585bda2e086ebc26_40147bf2c9fb1a97   ;
         buf_data_stage0[48][2]  <= 128'he9097466e450f697_90047eaf19df358a   ;
         buf_data_stage0[48][3]  <= 128'hbda2e60bebc25a7b_563efdeec494cacf   ;
         buf_data_stage0[49][0]  <= 128'h08e1dd39f4b32822_04656c63be721398   ;
         buf_data_stage0[49][1]  <= 128'hc788b17fd335f783_792387705d19ec67   ;
         buf_data_stage0[49][2]  <= 128'h1dd39fd932821f72_35be35e7bacdef73   ;
         buf_data_stage0[49][3]  <= 128'h8b1809ab5f782388_854add3a58547f57   ;
         buf_data_stage0[50][0]  <= 128'h13ba0dc5308326f5_6877d6c80beebd2c   ;
         buf_data_stage0[50][1]  <= 128'h117c8eaedf3642c5_11bd9543df25108a   ;
         buf_data_stage0[50][2]  <= 128'ha0dc5443326f4ec5_795b36e6e6324570   ;
         buf_data_stage0[50][3]  <= 128'hc8eaef0a642c4ee9_f6c3dc0a202d9283   ;
         buf_data_stage0[51][0]  <= 128'h9d24a3f365407288_4bff3d3bb07ee453   ;
         buf_data_stage0[51][1]  <= 128'hb6d702feafe35e28_68ba35d110dcb4ea   ;
         buf_data_stage0[51][2]  <= 128'h4a3f40260728762e_1197a3055c1a1ab2   ;
         buf_data_stage0[51][3]  <= 128'h702ff66b35e27493_e49e9894c5d01041   ;
         buf_data_stage0[52][0]  <= 128'h7b44e9e9b36084e7_d7389ff9172fbfec   ;
         buf_data_stage0[52][1]  <= 128'h2ec5857427dec65f_564d14c46123d6ca   ;
         buf_data_stage0[52][2]  <= 128'h4e9ea2ea084e684c_711945cf35ca7116   ;
         buf_data_stage0[52][3]  <= 128'h58574569ec65ed14_d6741c1411c752a9   ;
         buf_data_stage0[53][0]  <= 128'h8e947c9b70553a9c_f63dd40903a20e0c   ;
         buf_data_stage0[53][1]  <= 128'h5ae0d8ffeab15924_582927494a2e6828   ;
         buf_data_stage0[53][2]  <= 128'h47c9bfee53a9b717_1a0cfd7a80fd5d7b   ;
         buf_data_stage0[53][3]  <= 128'h0d90045915923a52_fba36745014fe6ea   ;
         buf_data_stage0[54][0]  <= 128'hd16910f590d26cbf_554046c4a3938c8d   ;
         buf_data_stage0[54][1]  <= 128'ha5bbc266cb64d075_fb91502ffe55b98a   ;
         buf_data_stage0[54][2]  <= 128'h910f662326cbe2ea_d4662d8810ac0fc3   ;
         buf_data_stage0[54][3]  <= 128'hbc2677114d0745a5_ea3b680ad66e01c6   ;
         buf_data_stage0[55][0]  <= 128'h6a7c9217f0ce3407_eb74fb279398e703   ;
         buf_data_stage0[55][1]  <= 128'h60db79e8cc72fe5b_ad128cbc80f19bff   ;
         buf_data_stage0[55][2]  <= 128'hc92185b3e3406959_4cf1f3012cc1fed7   ;
         buf_data_stage0[55][3]  <= 128'hb79e92d42fe5a9f3_e179723fd9404f76   ;
         buf_data_stage0[56][0]  <= 128'hd3946b6a55f9087f_8cb984ebc4e4d006   ;
         buf_data_stage0[56][1]  <= 128'h1ae5253581bde075_c459c201fd4af049   ;
         buf_data_stage0[56][2]  <= 128'h46b6b2989087e2c7_f800f03224347908   ;
         buf_data_stage0[56][3]  <= 128'h525359c9de074e52_d896fa2ab63d9dbf   ;
         buf_data_stage0[57][0]  <= 128'h872961b98ab1f7f0_77f48838e36b9f32   ;
         buf_data_stage0[57][1]  <= 128'h35a7917b53820422_f0831a14ae5f8d70   ;
         buf_data_stage0[57][2]  <= 128'h961ba11d1f7ef78e_3499b7859f5235ef   ;
         buf_data_stage0[57][3]  <= 128'h7917b89220421ca6_cd76c22da58a36e1   ;
         buf_data_stage0[58][0]  <= 128'hce93f9dcfeb25738_310c7972c8ac7e85   ;
         buf_data_stage0[58][1]  <= 128'h5b01888c536a3234_2fe45b1568832754   ;
         buf_data_stage0[58][2]  <= 128'h3f9ddcd425737317_9618cf65ef07b8de   ;
         buf_data_stage0[58][3]  <= 128'h1888cae6a3233a50_5e524e2217f76a51   ;
         buf_data_stage0[59][0]  <= 128'h9414a4e45d3a428f_93eeee91fdb257eb   ;
         buf_data_stage0[59][1]  <= 128'hfad6c6c2b16f5c66_514e4fdc17d5cec9   ;
         buf_data_stage0[59][2]  <= 128'h4a4e4f14a428e6bf_3e1c07369d317652   ;
         buf_data_stage0[59][3]  <= 128'h6c6c3ac3f5c65053_2700d34b46fd99ab   ;
         buf_data_stage0[60][0]  <= 128'h19aad578da05feeb_0eeb4fc8d71a1dce   ;
         buf_data_stage0[60][1]  <= 128'h954aa1c27e804547_1a379bc281163941   ;
         buf_data_stage0[60][2]  <= 128'had578f3a5feeae66_8f15d906607a6bd6   ;
         buf_data_stage0[60][3]  <= 128'haa1c313c045466ac_83558c411a91d75a   ;
         buf_data_stage0[61][0]  <= 128'hf31566a7f1f722b4_508baa02512a9634   ;
         buf_data_stage0[61][1]  <= 128'h3aa655c68237533d_7fa8b77d0bbc5b76   ;
         buf_data_stage0[61][2]  <= 128'h566a8e50722b30cf_ab1b016fa6fd3df6   ;
         buf_data_stage0[61][3]  <= 128'h655c6bcd7533cc56_b57825fd3cdb526a   ;
         buf_data_stage0[62][0]  <= 128'he09445e538924149_5e51dffc1188236f   ;
         buf_data_stage0[62][1]  <= 128'hdaee8678db6fadf9_da7aa645159b98c2   ;
         buf_data_stage0[62][2]  <= 128'h445e6192241481f7_d9ce898c926914a4   ;
         buf_data_stage0[62][3]  <= 128'he8679b64fadf8252_72154aea311aec92   ;
         buf_data_stage0[63][0]  <= 128'hfff7ffff00000001_d3946b6a55f9087f   ;
         buf_data_stage0[63][1]  <= 128'h0200000000000000_60db79e8cc72fe5b   ;
         buf_data_stage0[63][2]  <= 128'h7fffffff00000001_62ae44218641740b   ;
         buf_data_stage0[63][3]  <= 128'h0000001fffffffe0_f5aec5dd857522ee   ;
   
         //stage 1
         buf_data_stage1[0][0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage1[0][1] <= 128'hfffffffeffffffc1_52ca810d84ba33e7; // BC=64
         buf_data_stage1[0][2] <= 128'h0000000000001000_dfffffff00002001; // BC=128
         buf_data_stage1[0][3] <= 128'hfffffffefffc0001_bf8a7473016d6c46; // BC=192

         buf_data_stage1[1][0] <= 128'hfffdffff00000003_7b83abdf412342cf; // BC=16
         buf_data_stage1[1][1] <= 128'h007fffffffffff80_c5ff6cb7eb38fddc;
         buf_data_stage1[1][2] <= 128'hdfffffff00002001_ad578f3a5feeae66;
         buf_data_stage1[1][3] <= 128'h00000007fff7fff8_702ff66b35e27493;
         buf_data_stage1[2][0] <= 128'hffeffffefffffff1_59428f55043e67bb; // BC=32
         buf_data_stage1[2][1] <= 128'h0400000000000400_c5e4bb2a5aa63a07;
         buf_data_stage1[2][2] <= 128'hfffffffdffff0002_5162deb878a773ba;
         buf_data_stage1[2][3] <= 128'h00000040003fffc0_6c109cd02b5225ea;
         buf_data_stage1[3][0] <= 128'hfff7ffff00000001_d3946b6a55f9087f; // BC=48
         buf_data_stage1[3][1] <= 128'h0200000000000000_60db79e8cc72fe5b;
         buf_data_stage1[3][2] <= 128'h7fffffff00000001_62ae44218641740b;
         buf_data_stage1[3][3] <= 128'h0000001fffffffe0_f5aec5dd857522ee;

         //stage 2
         buf_data_stage2[0] <= 128'h0000000000000001_0000000000000001; // BC=0
         buf_data_stage2[1] <= 128'h0000000001000000_fffff7ff00000801; // BC=64
         buf_data_stage2[2] <= 128'h0001000000000000_ffbfffff00000001; // BC=128
         buf_data_stage2[3] <= 128'h000000ffffffff00_fffffffd00000001; // BC=192
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
         buf_const[0] <= 128'h0000000001000000_fffff7ff00000801;
         buf_const[1] <= 128'h0000000001000000_fffff7ff00000801;
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