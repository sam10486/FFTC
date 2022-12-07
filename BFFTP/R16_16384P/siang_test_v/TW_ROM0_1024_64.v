 `timescale 1 ns/1 ps     

 module TW_ROM0_1024_64(
   stage_counter,
   rst_n,
   CLK,
   CEN,
   state,

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
         buf_data_stage0[0][0] <= 64'h0000000000000001; // BC=0
         buf_data_stage0[0][1] <= 64'h9ab4d5fb2ded1731; // BC=64
         buf_data_stage0[0][2] <= 64'hfffdffff00000003; // BC=128
         buf_data_stage0[0][3] <= 64'h5b11501d07d1bfa5; // BC=192
         
         buf_data_stage0[1][0] <= 64'h381d997f2d35d682    ;
         buf_data_stage0[1][1] <= 64'h213b4515ad98a128    ;
         buf_data_stage0[1][2] <= 64'h9038d8928d6a77ab    ;
         buf_data_stage0[1][3] <= 64'h75fb2ef9e55cdff8    ;
         buf_data_stage0[2][0] <= 64'h915be1a8a0ea4674    ;
         buf_data_stage0[2][1] <= 64'hd26d7df5f16e8d21    ;
         buf_data_stage0[2][2] <= 64'hd27e817d0526f174    ;
         buf_data_stage0[2][3] <= 64'h8ead190fdecaa1f9    ;
         buf_data_stage0[3][0] <= 64'h7de340fb66a3942d    ;
         buf_data_stage0[3][1] <= 64'h616884339c3ac741    ;
         buf_data_stage0[3][2] <= 64'h5175b4b04f3ef167    ;
         buf_data_stage0[3][3] <= 64'h2be7cff240dd89c8    ;
         buf_data_stage0[4][0] <= 64'h2207b30251d4c9a8    ;
         buf_data_stage0[4][1] <= 64'h8614fceadd5c2aa7    ;
         buf_data_stage0[4][2] <= 64'h4abac25b09ae7b09    ;
         buf_data_stage0[4][3] <= 64'hbd063f1db48f1c30    ;
         buf_data_stage0[5][0] <= 64'hd782274663f8b408    ;
         buf_data_stage0[5][1] <= 64'hb906ba78585d33f9    ;
         buf_data_stage0[5][2] <= 64'hf867869c167fdf05    ;
         buf_data_stage0[5][3] <= 64'h952ac43725ac8ab9    ;
         buf_data_stage0[6][0] <= 64'h252502e45f699196    ;
         buf_data_stage0[6][1] <= 64'he4f9daeb27607da9    ;
         buf_data_stage0[6][2] <= 64'h215546f5c49c2c49    ;
         buf_data_stage0[6][3] <= 64'h18cb671704991405    ;
         buf_data_stage0[7][0] <= 64'hc26241d7d497e9b7    ;
         buf_data_stage0[7][1] <= 64'hca9e389bcf6275cd    ;
         buf_data_stage0[7][2] <= 64'h2da6da812ce10161    ;
         buf_data_stage0[7][3] <= 64'h386ad2740ffe1f9a    ;
         buf_data_stage0[8][0] <= 64'h7fb5acc30389f4d0    ;
         buf_data_stage0[8][1] <= 64'hbfb08ae0b9c1b5da    ;
         buf_data_stage0[8][2] <= 64'hbc455272609af01f    ;
         buf_data_stage0[8][3] <= 64'hfdeba23e89465e98    ;
         buf_data_stage0[9][0] <= 64'h75c91fcd00f90ea6    ;
         buf_data_stage0[9][1] <= 64'h04ed5c6d6ef8d494    ;
         buf_data_stage0[9][2] <= 64'h8eac3da8418d0ad0    ;
         buf_data_stage0[9][3] <= 64'ha7d7dae896cc90f5    ;
         buf_data_stage0[10][0] <= 64'h6b551fea26657a45   ;
         buf_data_stage0[10][1] <= 64'he36e57ec1a6b0de0   ;
         buf_data_stage0[10][2] <= 64'ha24bf3098ca017ff   ;
         buf_data_stage0[10][3] <= 64'hfb447b02e4b01772   ;
         buf_data_stage0[11][0] <= 64'h0776fe07a33f934f   ;
         buf_data_stage0[11][1] <= 64'h3bc10f75aa162847   ;
         buf_data_stage0[11][2] <= 64'hec40b58f428e7c0c   ;
         buf_data_stage0[11][3] <= 64'h0808cabf73181c3c   ;
         buf_data_stage0[12][0] <= 64'h08dda69734d315e3   ;
         buf_data_stage0[12][1] <= 64'hff0f4098018c8ae7   ;
         buf_data_stage0[12][2] <= 64'h98c6e387b6d4a728   ;
         buf_data_stage0[12][3] <= 64'h67207e18844b1704   ;
         buf_data_stage0[13][0] <= 64'h2db18ffce1c45c86   ;
         buf_data_stage0[13][1] <= 64'hca29fe77059fada5   ;
         buf_data_stage0[13][2] <= 64'h825d5c70e382d7f8   ;
         buf_data_stage0[13][3] <= 64'h3c1bf1b0082efadc   ;
         buf_data_stage0[14][0] <= 64'h4a3f9ccc62d9a86a   ;
         buf_data_stage0[14][1] <= 64'h313ea535debade01   ;
         buf_data_stage0[14][2] <= 64'h0a1273e5ff4cab06   ;
         buf_data_stage0[14][3] <= 64'h5c0f8cf607e1dbf5   ;
         buf_data_stage0[15][0] <= 64'hd0e5c71177433cdc   ;
         buf_data_stage0[15][1] <= 64'ha0ab7e95c458c04e   ;
         buf_data_stage0[15][2] <= 64'h99f09f9d7cab0a09   ;
         buf_data_stage0[15][3] <= 64'hc38f747a85de4aa4   ;
         buf_data_stage0[16][0] <= 64'h912b7e3e532ae35f   ;
         buf_data_stage0[16][1] <= 64'ha697460fbe475779   ;
         buf_data_stage0[16][2] <= 64'h5f1c5627a2d38f6a   ;
         buf_data_stage0[16][3] <= 64'h121d0f9208af78ae   ;
         buf_data_stage0[17][0] <= 64'ha4fc6533afc6b89a   ;
         buf_data_stage0[17][1] <= 64'h49375632f3234320   ;
         buf_data_stage0[17][2] <= 64'h0e5d6adb29f61ab9   ;
         buf_data_stage0[17][3] <= 64'h5fc8c61f92acfef5   ;
         buf_data_stage0[18][0] <= 64'hf3f04b444500c07c   ;
         buf_data_stage0[18][1] <= 64'h71aa2dd46d516325   ;
         buf_data_stage0[18][2] <= 64'hd0600c88208bf2d9   ;
         buf_data_stage0[18][3] <= 64'hc1618106364c8441   ;
         buf_data_stage0[19][0] <= 64'hf3dd150bf2cea5ad   ;
         buf_data_stage0[19][1] <= 64'he489eb510cbcac01   ;
         buf_data_stage0[19][2] <= 64'h7248447c0fb718b0   ;
         buf_data_stage0[19][3] <= 64'h9a6fbd29f01d3a8e   ;
         buf_data_stage0[20][0] <= 64'h9c4563b91246b28e   ;
         buf_data_stage0[20][1] <= 64'h38ad57d63b6ebd12   ;
         buf_data_stage0[20][2] <= 64'h0bfca2e5ec00c233   ;
         buf_data_stage0[20][3] <= 64'h478a38cf268a625c   ;
         buf_data_stage0[21][0] <= 64'h0895af5e49b87318   ;
         buf_data_stage0[21][1] <= 64'h1efef91570d1a0c9   ;
         buf_data_stage0[21][2] <= 64'hcc3ecb4af22d8acd   ;
         buf_data_stage0[21][3] <= 64'h0a411087d3ce6133   ;
         buf_data_stage0[22][0] <= 64'hb2f9b0a95af59d08   ;
         buf_data_stage0[22][1] <= 64'h393d81bb63a9abc8   ;
         buf_data_stage0[22][2] <= 64'hca90ab68173f55ee   ;
         buf_data_stage0[22][3] <= 64'h17743c23caca915e   ;
         buf_data_stage0[23][0] <= 64'h32c3f888d962f857   ;
         buf_data_stage0[23][1] <= 64'hd79cc90aa516352e   ;
         buf_data_stage0[23][2] <= 64'h83c83e4ba3d808fc   ;
         buf_data_stage0[23][3] <= 64'hb2c847e9dc4363c1   ;
         buf_data_stage0[24][0] <= 64'h97017c5dccfb9554   ;
         buf_data_stage0[24][1] <= 64'hc398180c38caffd7   ;
         buf_data_stage0[24][2] <= 64'h0a9f5ec592b3f2a1   ;
         buf_data_stage0[24][3] <= 64'h5769be83a1aff873   ;
         buf_data_stage0[25][0] <= 64'h03f08ae670ad3bd5   ;
         buf_data_stage0[25][1] <= 64'h91fe3ae9a969d0d7   ;
         buf_data_stage0[25][2] <= 64'h7a6a3471f72760e6   ;
         buf_data_stage0[25][3] <= 64'h0c7b2300c8a8187d   ;
         buf_data_stage0[26][0] <= 64'h8b62f95739390d9d   ;
         buf_data_stage0[26][1] <= 64'h3b11a1800cff9f70   ;
         buf_data_stage0[26][2] <= 64'h08dd803d6521a471   ;
         buf_data_stage0[26][3] <= 64'hf44329005cffcf03   ;
         buf_data_stage0[27][0] <= 64'h02665526fe6cf647   ;
         buf_data_stage0[27][1] <= 64'h28cf9fb6222dadcc   ;
         buf_data_stage0[27][2] <= 64'h6df0ad73a727ee35   ;
         buf_data_stage0[27][3] <= 64'hb69afb1083c7f193   ;
         buf_data_stage0[28][0] <= 64'hd8452f144f2e3d4b   ;
         buf_data_stage0[28][1] <= 64'h2af9c535a5611386   ;
         buf_data_stage0[28][2] <= 64'hd7cbbfccfc86c97c   ;
         buf_data_stage0[28][3] <= 64'ha47c3fa8d52dc7c2   ;
         buf_data_stage0[29][0] <= 64'hcdf3dbe9fc90756b   ;
         buf_data_stage0[29][1] <= 64'h297ddf99fd5283bd   ;
         buf_data_stage0[29][2] <= 64'hf93dbeb3b0f67fde   ;
         buf_data_stage0[29][3] <= 64'h8c4dc48eb9d9551b   ;
         buf_data_stage0[30][0] <= 64'h22e4ea3d3cd49ceb   ;
         buf_data_stage0[30][1] <= 64'h58c03fd10103f325   ;
         buf_data_stage0[30][2] <= 64'h37795ad14e23f949   ;
         buf_data_stage0[30][3] <= 64'h4b947d9a81aa99d2   ;
         buf_data_stage0[31][0] <= 64'h1a8c7b40a550e18a   ;
         buf_data_stage0[31][1] <= 64'ha2cf6ca76b817fb4   ;
         buf_data_stage0[31][2] <= 64'h7b83abdf412342cf   ;
         buf_data_stage0[31][3] <= 64'h6ce8024cb0531c09   ;
         buf_data_stage0[32][0] <= 64'hdcee6ba66b6361d7   ;
         buf_data_stage0[32][1] <= 64'hadda166b62c2ba2c   ;
         buf_data_stage0[32][2] <= 64'h1ee20087ae155450   ;
         buf_data_stage0[32][3] <= 64'hba856751f25d9591   ;
         buf_data_stage0[33][0] <= 64'hab80a9849f5c9159   ;
         buf_data_stage0[33][1] <= 64'hefff77cd527387a6   ;
         buf_data_stage0[33][2] <= 64'he146145091c3b86c   ;
         buf_data_stage0[33][3] <= 64'he1184ab494839431   ;
         buf_data_stage0[34][0] <= 64'hb2464d358bee3699   ;
         buf_data_stage0[34][1] <= 64'h111b3f084b6e9153   ;
         buf_data_stage0[34][2] <= 64'h5cef828fb248e99a   ;
         buf_data_stage0[34][3] <= 64'h817fe73314eddbba   ;
         buf_data_stage0[35][0] <= 64'hadb2dae29606e340   ;
         buf_data_stage0[35][1] <= 64'h59157e3f1bcde14e   ;
         buf_data_stage0[35][2] <= 64'hdf2089b7e1d44df3   ;
         buf_data_stage0[35][3] <= 64'hf310c4e2341aac63   ;
         buf_data_stage0[36][0] <= 64'h4d6a3319af264a28   ;
         buf_data_stage0[36][1] <= 64'habcdfb1bc44931c8   ;
         buf_data_stage0[36][2] <= 64'ha05107e6c4808d71   ;
         buf_data_stage0[36][3] <= 64'hfdd46da57ecb43be   ;
         buf_data_stage0[37][0] <= 64'h71b7f913eea00bdf   ;
         buf_data_stage0[37][1] <= 64'hc92b365033d7ca47   ;
         buf_data_stage0[37][2] <= 64'hd98a14e7cf68d86e   ;
         buf_data_stage0[37][3] <= 64'h912804f1d4518e93   ;
         buf_data_stage0[38][0] <= 64'h9a3bb9d470ad0f86   ;
         buf_data_stage0[38][1] <= 64'hbd6bbb1a325e80f5   ;
         buf_data_stage0[38][2] <= 64'ha1c2924f550434dd   ;
         buf_data_stage0[38][3] <= 64'h02b91178daf2e17d   ;
         buf_data_stage0[39][0] <= 64'h2d3e749c32068452   ;
         buf_data_stage0[39][1] <= 64'hd4430a71a869e574   ;
         buf_data_stage0[39][2] <= 64'h68a0852b4d45c72e   ;
         buf_data_stage0[39][3] <= 64'hc8bac41065b8c441   ;
         buf_data_stage0[40][0] <= 64'he104978443ea74c5   ;
         buf_data_stage0[40][1] <= 64'hfb37f9b38ff8bbb2   ;
         buf_data_stage0[40][2] <= 64'ha976a734b6df3367   ;
         buf_data_stage0[40][3] <= 64'h8ba4d377135a8dc4   ;
         buf_data_stage0[41][0] <= 64'h7d23c62c76b8a104   ;
         buf_data_stage0[41][1] <= 64'hb99583ab25ca3c75   ;
         buf_data_stage0[41][2] <= 64'h2be69ee879cb29c0   ;
         buf_data_stage0[41][3] <= 64'hf2eabbc252ec37a9   ;
         buf_data_stage0[42][0] <= 64'h227b9fdd365d00ac   ;
         buf_data_stage0[42][1] <= 64'h62b58dad5d9b386a   ;
         buf_data_stage0[42][2] <= 64'h03e4d300ac74b309   ;
         buf_data_stage0[42][3] <= 64'h393c6024d691f175   ;
         buf_data_stage0[43][0] <= 64'h60796f94d5757c59   ;
         buf_data_stage0[43][1] <= 64'h8913a944437be72c   ;
         buf_data_stage0[43][2] <= 64'he917343e8a156490   ;
         buf_data_stage0[43][3] <= 64'hf146cb90d9816777   ;
         buf_data_stage0[44][0] <= 64'h2fefbfe46ea8d5c6   ;
         buf_data_stage0[44][1] <= 64'hc431d60f18588071   ;
         buf_data_stage0[44][2] <= 64'h348aa2775d1ae8bd   ;
         buf_data_stage0[44][3] <= 64'hdb637b6ddcd0b9f6   ;
         buf_data_stage0[45][0] <= 64'hc806ca248abfabca   ;
         buf_data_stage0[45][1] <= 64'h4d768679d45bbec6   ;
         buf_data_stage0[45][2] <= 64'ha4307ecaa9c9fd20   ;
         buf_data_stage0[45][3] <= 64'h106d643cb5abc130   ;
         buf_data_stage0[46][0] <= 64'h892a4dd966a15378   ;
         buf_data_stage0[46][1] <= 64'h5eda60f9e21f8647   ;
         buf_data_stage0[46][2] <= 64'hcfb1ce7068f68687   ;
         buf_data_stage0[46][3] <= 64'hef32fdb486338e82   ;
         buf_data_stage0[47][0] <= 64'hca229fd580c44658   ;
         buf_data_stage0[47][1] <= 64'h36e6ee0a706c8023   ;
         buf_data_stage0[47][2] <= 64'hc7ea3e234135227d   ;
         buf_data_stage0[47][3] <= 64'h9172fb3bbcee4eed   ;
         buf_data_stage0[48][0] <= 64'h6b353155d3c8bdc5   ;
         buf_data_stage0[48][1] <= 64'h6fb69219dde133b9   ;
         buf_data_stage0[48][2] <= 64'hf834bb1a0a3df986   ;
         buf_data_stage0[48][3] <= 64'h53c76871dff702a1   ;
         buf_data_stage0[49][0] <= 64'h406d6230c4007205   ;
         buf_data_stage0[49][1] <= 64'hf4e07c743d5322f9   ;
         buf_data_stage0[49][2] <= 64'hd86f3c604c62ece6   ;
         buf_data_stage0[49][3] <= 64'haae67e437390aa58   ;
         buf_data_stage0[50][0] <= 64'hd615b370aeed19a6   ;
         buf_data_stage0[50][1] <= 64'h9950c23e238c236f   ;
         buf_data_stage0[50][2] <= 64'h11fe0908c4bd3d50   ;
         buf_data_stage0[50][3] <= 64'h67473d64cb95c097   ;
         buf_data_stage0[51][0] <= 64'hbcd5c57029b9c4d3   ;
         buf_data_stage0[51][1] <= 64'h16ce261a18c02f0a   ;
         buf_data_stage0[51][2] <= 64'h6525376dde5556c4   ;
         buf_data_stage0[51][3] <= 64'h83541ab37db4bd31   ;
         buf_data_stage0[52][0] <= 64'h6a07aefc1cf821c1   ;
         buf_data_stage0[52][1] <= 64'h1d99c647a348c31b   ;
         buf_data_stage0[52][2] <= 64'h3295240897e95181   ;
         buf_data_stage0[52][3] <= 64'h286e45fdd32107fb   ;
         buf_data_stage0[53][0] <= 64'hc29d035cb7ebd737   ;
         buf_data_stage0[53][1] <= 64'h75fbf22b1d4bbca1   ;
         buf_data_stage0[53][2] <= 64'hd01296e27692a37f   ;
         buf_data_stage0[53][3] <= 64'h8e5fa9bf1eee9fd1   ;
         buf_data_stage0[54][0] <= 64'hb5609d15159f67c6   ;
         buf_data_stage0[54][1] <= 64'he9931a946dbbcb36   ;
         buf_data_stage0[54][2] <= 64'h610b0eec656a658b   ;
         buf_data_stage0[54][3] <= 64'h079159b310a24508   ;
         buf_data_stage0[55][0] <= 64'hd0b407bb096f67e3   ;
         buf_data_stage0[55][1] <= 64'h36d11d9ae31cc4c6   ;
         buf_data_stage0[55][2] <= 64'hc22bfc982256840c   ;
         buf_data_stage0[55][3] <= 64'ha8e074fc016fbd68   ;
         buf_data_stage0[56][0] <= 64'hbbdfdceff9b2d4ca   ;
         buf_data_stage0[56][1] <= 64'hd922f0469ddab66c   ;
         buf_data_stage0[56][2] <= 64'h144bc67bad4714b8   ;
         buf_data_stage0[56][3] <= 64'h64e0a4d91c445ad2   ;
         buf_data_stage0[57][0] <= 64'h28ce83ee0b3ded8b   ;
         buf_data_stage0[57][1] <= 64'h5c8a273523823baa   ;
         buf_data_stage0[57][2] <= 64'h6eaaf1601e58432f   ;
         buf_data_stage0[57][3] <= 64'hf3560765956f776d   ;
         buf_data_stage0[58][0] <= 64'h575eb97c69429fc1   ;
         buf_data_stage0[58][1] <= 64'hb01916faf34e2f02   ;
         buf_data_stage0[58][2] <= 64'hfc42a073457ec0c5   ;
         buf_data_stage0[58][3] <= 64'hd438475a1493a4d2   ;
         buf_data_stage0[59][0] <= 64'h21c889bd56eb81f0   ;
         buf_data_stage0[59][1] <= 64'hf0cc3ddf72d20532   ;
         buf_data_stage0[59][2] <= 64'h2c3665a3c151f548   ;
         buf_data_stage0[59][3] <= 64'h5b75961c6164d19f   ;
         buf_data_stage0[60][0] <= 64'h00cd94611114ce8e   ;
         buf_data_stage0[60][1] <= 64'h5356e9a7c3d367f5   ;
         buf_data_stage0[60][2] <= 64'h3bbd06984aebc0e1   ;
         buf_data_stage0[60][3] <= 64'h03744ba95af6fe3e   ;
         buf_data_stage0[61][0] <= 64'hb7ed6fd97bea1daa   ;
         buf_data_stage0[61][1] <= 64'h37b202532b6388a3   ;
         buf_data_stage0[61][2] <= 64'h54d3e7dfd788a302   ;
         buf_data_stage0[61][3] <= 64'h5977addf5b6dd771   ;
         buf_data_stage0[62][0] <= 64'hd5a7afcd075f52e8   ;
         buf_data_stage0[62][1] <= 64'h402ccdbfe7c0149b   ;
         buf_data_stage0[62][2] <= 64'ha5e550dc6e5a5fdd   ;
         buf_data_stage0[62][3] <= 64'hbba3cbff6b007910   ;
         buf_data_stage0[63][0] <= 64'hae7d2abe72929acf   ;
         buf_data_stage0[63][1] <= 64'h58c3de196dbcf497   ;
         buf_data_stage0[63][2] <= 64'hd1df70583aa377bd   ;
         buf_data_stage0[63][3] <= 64'h0c26e0b997ad762f   ;
   
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
                     2'd0: Q <= buf_data_stage0[group_th][0];
                     2'd1: Q <= buf_data_stage0[group_th][1];
                     2'd2: Q <= buf_data_stage0[group_th][2];
                     2'd3: Q <= buf_data_stage0[group_th][3];
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