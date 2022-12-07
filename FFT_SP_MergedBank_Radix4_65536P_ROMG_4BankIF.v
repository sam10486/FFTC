//==================================================          
//Writer     : Jheng-Hao Ye  
//Date       : 2018/8/1
//Note       : Finite_Field_FFT 65536P-FFTs 
//             Radix4 Butterfly 
//             Single-Port Merged-Bank Memory Addressing Algorithm
//             Integer Multiplication
//             Base = 24-bit
//             ROM Table Generator
//             Partition a ROM into 4 banks ROM, maximum open file is 30, output IFFT ROM0, ROM1
//==================================================
module FFT_SP_MergedBank_Radix4_65536P_ROMG_4BankIF ;

parameter D_WIDTH = 64 ; //data width 
parameter DIV2_WIDTH = 32 ; //data width/2
parameter EXP_WIDTH = 64 ; //exponentiation width
parameter POINT_NUM = 4096 ; // total number of point
parameter BF_POINT_NUM = 4 ; // butterfly number of point 
parameter B_WIDTH = 12 ; //log_2(POINT_NUM)
parameter ADDR_WIDTH = 1024 ; //POINT_NUM/BF_POINT_NUM
parameter P = 6 ; // Stage Num
parameter G = 256 ; // POINT_NUM/((BF_POINT_NUM)^2)
parameter R = 4 ; // BF_POINT_NUM
parameter S = 2 ; // log_2(BF_POINT_NUM)
parameter RR_WIDTH = 10 ; //Rotate width = log_2(ADDR_WIDTH)
parameter GC_WIDTH = 8 ; // Gray code width = log_2(G)

parameter BASE = 24 ;
parameter BASE_WIDTH = 24 ; //log_2(BASE)
parameter MUL_WIDTH = 786432 ; //BASE*(POINT_NUM/2)

parameter IFFTROM0_DATA0 = "./ROM_Data_Bank/R4_65536P_IFFTROM0_D0_4Bank.txt" ;
parameter IFFTROM0_DATA1 = "./ROM_Data_Bank/R4_65536P_IFFTROM0_D1_4Bank.txt" ;
parameter IFFTROM0_DATA2 = "./ROM_Data_Bank/R4_65536P_IFFTROM0_D2_4Bank.txt" ;
parameter IFFTROM0_DATA3 = "./ROM_Data_Bank/R4_65536P_IFFTROM0_D3_4Bank.txt" ;
//
parameter IFFTROM1_DATA0 = "./ROM_Data_Bank/R4_65536P_IFFTROM1_D0_4Bank.txt" ;
parameter IFFTROM1_DATA1 = "./ROM_Data_Bank/R4_65536P_IFFTROM1_D1_4Bank.txt" ;
parameter IFFTROM1_DATA2 = "./ROM_Data_Bank/R4_65536P_IFFTROM1_D2_4Bank.txt" ;
parameter IFFTROM1_DATA3 = "./ROM_Data_Bank/R4_65536P_IFFTROM1_D3_4Bank.txt" ;



reg[D_WIDTH-1:0] prime ; // prime
reg[EXP_WIDTH-1:0] exp ; // exponentiation
reg[D_WIDTH-1:0] tw_B ; // butterfly twiddle factor1 of generator
reg[D_WIDTH-1:0] tw_N ; // additional twiddle factor of generator
reg[D_WIDTH-1:0] x[0:POINT_NUM-1] ; // input data1
reg[D_WIDTH-1:0] x2[0:POINT_NUM-1] ; // input data2
reg[2*D_WIDTH-1:0] B0Mem1[0:ADDR_WIDTH-1] ; // Bank0 Memory1
reg[2*D_WIDTH-1:0] B1Mem1[0:ADDR_WIDTH-1] ; // Bank1 Memory1
reg[2*D_WIDTH-1:0] B0Mem2[0:ADDR_WIDTH-1] ; // Bank0 Memory2
reg[2*D_WIDTH-1:0] B1Mem2[0:ADDR_WIDTH-1] ; // Bank1 Memory2
reg[D_WIDTH-1:0] S1[0:POINT_NUM-1] ; // Stage 1
reg[D_WIDTH-1:0] S2[0:POINT_NUM-1] ; // Stage 2
reg[D_WIDTH-1:0] S3[0:POINT_NUM-1] ; // Stage 3
reg[D_WIDTH-1:0] S4[0:POINT_NUM-1] ; // Stage 4
reg[D_WIDTH-1:0] S5[0:POINT_NUM-1] ; // Stage 5
reg[D_WIDTH-1:0] S6[0:POINT_NUM-1] ; // Stage 6
reg[D_WIDTH-1:0] S7[0:POINT_NUM-1] ; // Stage 7
reg[D_WIDTH-1:0] S8[0:POINT_NUM-1] ; // Stage 8
reg[D_WIDTH-1:0] FFT_Result[0:POINT_NUM-1] ; // FFT1 result
reg[D_WIDTH-1:0] FFT2_Result[0:POINT_NUM-1] ; // FFT2 result
reg[D_WIDTH-1:0] PW_Result[0:POINT_NUM-1] ; // FFT1*FFT2 point-wise multiplication
reg[D_WIDTH-1:0] tw_BF_Table[0:POINT_NUM-1] ; // Butterfly twiddle factor table
reg[D_WIDTH-1:0] tw_N_Table[0:POINT_NUM-1] ; // addition twiddle factor table
reg[2*D_WIDTH-1:0] ROM1[0:ADDR_WIDTH-1] ; // FFT ROM1
reg[2*D_WIDTH-1:0] ROM2[0:ADDR_WIDTH-1] ; // FFT ROM2
reg[2*D_WIDTH-1:0] IFFT_ROM1[0:ADDR_WIDTH-1] ; // IFFT ROM1
reg[2*D_WIDTH-1:0] IFFT_ROM2[0:ADDR_WIDTH-1] ; // IFFT ROM2
reg[D_WIDTH-1:0] t_S ;

reg[D_WIDTH-1:0] IFFT_Result[0:POINT_NUM-1] ; // IFFT result
reg[D_WIDTH-1:0] INVN ; // 1/N
reg[D_WIDTH-1:0] PN ; // point number
reg[B_WIDTH-1:0] oldindex ; 
reg[B_WIDTH-1:0] newindex ;
reg[B_WIDTH-1:0] brindex[0:BF_POINT_NUM-1] ;

reg[RR_WIDTH-1:0] BC ;
reg[RR_WIDTH-1:0] BRBC ;
reg               BN ;
reg[RR_WIDTH-1:0] MA ;
reg[2*D_WIDTH-1:0] MD ;
reg[D_WIDTH-1:0] op0 ; 
reg[D_WIDTH-1:0] op1 ; 
reg[D_WIDTH-1:0] op2 ; 
reg[D_WIDTH-1:0] op3 ; 
reg[D_WIDTH-1:0] R4_D0 ; 
reg[D_WIDTH-1:0] R4_D1 ; 
reg[D_WIDTH-1:0] R4_D2 ; 
reg[D_WIDTH-1:0] R4_D3 ; 
reg[D_WIDTH-1:0] romD0 ; 
reg[D_WIDTH-1:0] romD1 ; 
reg[D_WIDTH-1:0] romD2 ; 
reg[D_WIDTH-1:0] romD3 ;
reg[D_WIDTH-1:0] buf_R4D0[0:R-2] ; 
reg[D_WIDTH-1:0] buf_R4D1[0:R-2] ; 
reg[D_WIDTH-1:0] buf_R4D2[0:R-2] ;
reg[D_WIDTH-1:0] buf_R4D3[0:R-2] ;
reg[RR_WIDTH-1:0] buf_Addr[0:R-2] ;
reg               buf_bn[0:R-2] ; 
reg[RR_WIDTH-1:0] ROMA ;


reg[BASE_WIDTH-1:0] MUL_Result[0:POINT_NUM-1] ;
reg[BASE_WIDTH-1:0] base ;
reg[D_WIDTH-1:0] sum ;
reg[D_WIDTH-1:0] quo ;
reg[MUL_WIDTH-1:0] MUL_in1 ;
reg[MUL_WIDTH-1:0] MUL_in2 ;
reg[2*MUL_WIDTH-1:0] MUL_Result_golden ;

reg[RR_WIDTH-1:0] ia ; //2018/08/01

integer i, j, t, k, m, z, a ;
integer out_ifM0D0,out_ifM0D1,out_ifM0D2,out_ifM0D3,out_ifM1D0,out_ifM1D1,out_ifM1D2,out_ifM1D3  ;

//output file
initial begin
    // IFFT ROM0---
    out_ifM0D0 = $fopen(IFFTROM0_DATA0);
    if(out_ifM0D0 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM0D1 = $fopen(IFFTROM0_DATA1);
    if(out_ifM0D1 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM0D2 = $fopen(IFFTROM0_DATA2);
    if(out_ifM0D2 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM0D3 = $fopen(IFFTROM0_DATA3);
    if(out_ifM0D3 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	// IFFT ROM1---
	out_ifM1D0 = $fopen(IFFTROM1_DATA0);
    if(out_ifM1D0 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM1D1 = $fopen(IFFTROM1_DATA1);
    if(out_ifM1D1 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM1D2 = $fopen(IFFTROM1_DATA2);
    if(out_ifM1D2 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
	out_ifM1D3 = $fopen(IFFTROM1_DATA3);
    if(out_ifM1D3 == 0) begin
      $display("Output file open error !");
      $finish;
    end
	
end 

initial begin
  
	// prime = 2^64-2^32+1
	prime = 0 ;
	prime[0] = 1 ;
	for(j=(D_WIDTH-1); j>=DIV2_WIDTH; j=j-1) begin
		prime[j] = 1 ;
	end 
	
	$display("prime = %h",prime) ;
  
	
	// tw_B = 64'd16 ;
	tw_B = 64'd281474976710656 ; // 2^48, 4-point twiddle factor of generator
	exp = 64'h0 ;
	for(i=0;i<BF_POINT_NUM;i=i+1) begin	 
		tw_BF_Table[i] = ModExp(prime, tw_B, exp) ;
	    exp = exp + 1 ;
	end
	
	tw_N = 64'hcaa9d9e2_e7048840 ; // 65536-point twiddle factor of generator
	//tw_N = 64'd18445618169508003841; // 
    // tw_N = 64'hc26241d7_d497e9b7 ; // 4096-point twiddle factor of generator
	// tw_N = 64'h1a8c7b40_a550e18a ; // 1024-point twiddle factor of generator
	// tw_N = 64'h9ab4d5fb_2ded1731 ; // 256-point twiddle factor of generator
	// tw_N = 64'd8 ; // 64-point twiddle factor of generator
	// tw_N = 64'd4096 ; // 2^12 16-point twiddle factor of generator
	exp = 64'h0 ;
	for(i=0;i<POINT_NUM;i=i+1) begin	 
		tw_N_Table[i] = ModExp(prime, tw_N, exp) ;
		// $display("tw_N_Table[%d] = %d",i,tw_N_Table[i]) ;
	    exp = exp + 16 ;
	end
	
	
	// Load FFT ROM Data
	for(i=0;i<(POINT_NUM/BF_POINT_NUM);i=i+1) begin
		ROM1[i] = {tw_N_Table[0*i],tw_N_Table[1*i]} ;
		ROM2[i] = {tw_N_Table[2*i],tw_N_Table[3*i]} ;
		// $display("ROM1[%d] = %d",i, ROM1[i]) ;
		// $display("ROM2[%d] = %d",i, ROM2[i]) ;
	end
	
	
	// Load IFFT ROM Data
	for(i=0;i<(POINT_NUM/BF_POINT_NUM);i=i+1) begin
		if(i==0) begin
			IFFT_ROM1[i] = {tw_N_Table[0],tw_N_Table[0]} ;
			IFFT_ROM2[i] = {tw_N_Table[0],tw_N_Table[0]} ;
		end
		else begin
			IFFT_ROM1[i] = {tw_N_Table[0*i],tw_N_Table[POINT_NUM-1*i]} ;
			IFFT_ROM2[i] = {tw_N_Table[POINT_NUM-2*i],tw_N_Table[POINT_NUM-3*i]} ;
		end	
		// $display("IFFT_ROM1[%d] = %d",i, IFFT_ROM1[i]) ;
		// $display("IFFT_ROM2[%d] = %d",i, IFFT_ROM2[i]) ;
	end
	
	// Generation IFFT ROM Data 4 banks
	for(i=0;i<(ADDR_WIDTH/4);i=i+1) begin
			if(i==0) begin
				$fdisplay(out_ifM0D0,"%b",tw_N_Table[0]) ;
				$fdisplay(out_ifM1D0,"%b",{tw_N_Table[0],tw_N_Table[0]}) ;
			end
			else begin
				$fdisplay(out_ifM0D0,"%b",tw_N_Table[POINT_NUM-1*i]) ;
				$fdisplay(out_ifM1D0,"%b",{tw_N_Table[POINT_NUM-2*i],tw_N_Table[POINT_NUM-3*i]}) ;
			end
	end
	for(i=(ADDR_WIDTH/4);i<(ADDR_WIDTH/2);i=i+1) begin
			if(i==0) begin
				$fdisplay(out_ifM0D1,"%b",tw_N_Table[0]) ;
				$fdisplay(out_ifM1D1,"%b",{tw_N_Table[0],tw_N_Table[0]}) ;
			end
			else begin
				$fdisplay(out_ifM0D1,"%b",tw_N_Table[POINT_NUM-1*i]) ;
				$fdisplay(out_ifM1D1,"%b",{tw_N_Table[POINT_NUM-2*i],tw_N_Table[POINT_NUM-3*i]}) ;
			end
	end
	for(i=(ADDR_WIDTH/2);i<(3*ADDR_WIDTH/4);i=i+1) begin
			if(i==0) begin
				$fdisplay(out_ifM0D2,"%b",tw_N_Table[0]) ;
				$fdisplay(out_ifM1D2,"%b",{tw_N_Table[0],tw_N_Table[0]}) ;
			end
			else begin
				$fdisplay(out_ifM0D2,"%b",tw_N_Table[POINT_NUM-1*i]) ;
				$fdisplay(out_ifM1D2,"%b",{tw_N_Table[POINT_NUM-2*i],tw_N_Table[POINT_NUM-3*i]}) ;
			end
	end
	for(i=(3*ADDR_WIDTH/4);i<ADDR_WIDTH;i=i+1) begin
			if(i==0) begin
				$fdisplay(out_ifM0D3,"%b",tw_N_Table[0]) ;
				$fdisplay(out_ifM1D3,"%b",{tw_N_Table[0],tw_N_Table[0]}) ;
			end
			else begin
				$fdisplay(out_ifM0D3,"%b",tw_N_Table[POINT_NUM-1*i]) ;
				$fdisplay(out_ifM1D3,"%b",{tw_N_Table[POINT_NUM-2*i],tw_N_Table[POINT_NUM-3*i]}) ;
			end
	end
	
	
	$display("\n") ;
	$display("  ===========================================================  ") ;
	$display("  ==== VERFICATION OF MULTIPLCIATION IS COMPLETED ====  ") ;
	$display("  ===========================================================  ") ;
	// if((Qx == GOLDEN_KPX)&&(Qy == GOLDEN_KPY)) begin
  		// $display("\n    CORRECT \n") ;
	// end
	// else begin
  		// $display("\n    ERROR \n") ;
	// end
  
end



//GF(p) modular addition
	function [D_WIDTH-1:0] GF_Add ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] op_a ;
		input [D_WIDTH-1:0] op_b ;
    
		reg [D_WIDTH:0] temp ;
    
		begin
			temp = (op_a + op_b) % prime ; 
			GF_Add = temp ;
		end
	endfunction

//GF(p) modular subtraction
	function [D_WIDTH-1:0] GF_Sub ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] op_a ;
		input [D_WIDTH-1:0] op_b ;
    
		reg [D_WIDTH:0] temp ;
    
		begin
			if(op_a >= op_b) temp = op_a - op_b ; 
			else temp = op_a - op_b + prime ;
		GF_Sub = temp ;
		end
	endfunction

  
//GF(p) modular multiplication
  function [D_WIDTH-1:0] GF_Mul ; // output
    input [D_WIDTH-1:0] prime ;
    input [D_WIDTH-1:0] op_a ;
    input [D_WIDTH-1:0] op_b ;
    
    reg [2*D_WIDTH-1:0] temp ; 
    
    begin
    	temp = (op_a * op_b) % prime;
    	GF_Mul = temp ; 
    end
  endfunction    


// modular exponentiation
	function [D_WIDTH-1:0] ModExp ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] op_a ;
		input [EXP_WIDTH-1:0] exp_in ;
		
		reg [D_WIDTH-1:0] Z1 ;
		reg [2*D_WIDTH-1:0] t_Z1 ;
		integer i ;
  
		begin  
			Z1 = 1 ;
			for(i=(EXP_WIDTH-1);i>=0;i=i-1) begin	  
				t_Z1 = Z1 * Z1 ;
				Z1 = t_Z1 % prime ;
	  
				if(exp_in[i] == 1) begin
					t_Z1 = Z1 * op_a ;
					Z1 = t_Z1 % prime ;
				end
				// $display("Z1 = %d", Z1) ;
			end
			ModExp = Z1 ; 
		end
	endfunction 

/*
// Radix4 Butterfly output0
	function [D_WIDTH-1:0] R4BF_out0 ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] in0 ;
		input [D_WIDTH-1:0] in1 ;
		input [D_WIDTH-1:0] in2 ;
		input [D_WIDTH-1:0] in3 ;
		input [D_WIDTH-1:0] tw0 ; // tw^0
		input [D_WIDTH-1:0] tw1 ; // tw^1
		
		reg [D_WIDTH-1:0] temp [0:1] ;
		
		begin
			temp[0] = GF_Add(prime, in0, in1) ;
			temp[1] = GF_Add(prime, in2, in3) ;
			R4BF_out0 = GF_Add(prime, temp[0], temp[1]) ; // (x[0]+x[1])+(x[2]+x[3])
		end
	endfunction

	
// Radix4 Butterfly output1
	function [D_WIDTH-1:0] R4BF_out1 ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] in0 ;
		input [D_WIDTH-1:0] in1 ;
		input [D_WIDTH-1:0] in2 ;
		input [D_WIDTH-1:0] in3 ;
		input [D_WIDTH-1:0] tw0 ; // tw^0
		input [D_WIDTH-1:0] tw1 ; // tw^1
		
		reg [D_WIDTH-1:0] temp [0:1] ;
		
		begin
			temp[0] = GF_Sub(prime, in0, in2) ;
			temp[1] = GF_Sub(prime, in1, in3) ;
			temp[1] = GF_Mul(prime, temp[1], tw1) ;
			R4BF_out1 = GF_Add(prime, temp[0], temp[1]) ; // (x[0]-x[2])+w*(x[1]-x[3])
		end
	endfunction	

	
// Radix4 Butterfly output2
	function [D_WIDTH-1:0] R4BF_out2 ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] in0 ;
		input [D_WIDTH-1:0] in1 ;
		input [D_WIDTH-1:0] in2 ;
		input [D_WIDTH-1:0] in3 ;
		input [D_WIDTH-1:0] tw0 ; // tw^0
		input [D_WIDTH-1:0] tw1 ; // tw^1
		
		reg [D_WIDTH-1:0] temp [0:1] ;
		
		begin
			temp[0] = GF_Add(prime, in0, in2) ;
			temp[1] = GF_Add(prime, in1, in3) ;
			R4BF_out2 = GF_Sub(prime, temp[0], temp[1]) ; // (x[0]+x[2])-(x[1]-x[3])
		end
	endfunction	


// Radix4 Butterfly output3
	function [D_WIDTH-1:0] R4BF_out3 ; // output
		input [D_WIDTH-1:0] prime ;
		input [D_WIDTH-1:0] in0 ;
		input [D_WIDTH-1:0] in1 ;
		input [D_WIDTH-1:0] in2 ;
		input [D_WIDTH-1:0] in3 ;
		input [D_WIDTH-1:0] tw0 ; // tw^0
		input [D_WIDTH-1:0] tw1 ; // tw^1
		
		reg [D_WIDTH-1:0] temp [0:1] ;
		
		begin
			temp[0] = GF_Sub(prime, in0, in2) ;
			temp[1] = GF_Sub(prime, in1, in3) ;
			temp[1] = GF_Mul(prime, temp[1], tw1) ;
			R4BF_out3 = GF_Sub(prime, temp[0], temp[1]) ; // (x[0]-x[2])-16*(x[1]-x[3])
		end
	endfunction	


//Right Rotate
	function [RR_WIDTH-1:0] RR ; // output
		input [RR_WIDTH-1:0] op_a ;
		input [RR_WIDTH-1:0] rr_b ;
    
    
		begin
			if(rr_b == 14'd12) begin
				RR = {op_a[11:0],op_a[RR_WIDTH-1:12]} ;
			end
			else if(rr_b == 14'd10) begin
				RR = {op_a[9:0],op_a[RR_WIDTH-1:10]} ;
			end
			else if(rr_b == 14'd8) begin
				RR = {op_a[7:0],op_a[RR_WIDTH-1:8]} ;
			end
			else if(rr_b == 14'd6) begin
				RR = {op_a[5:0],op_a[RR_WIDTH-1:6]} ;
			end
			else if(rr_b == 14'd4) begin
				RR = {op_a[3:0],op_a[RR_WIDTH-1:4]} ;
			end
			else if(rr_b == 14'd2) begin
				RR = {op_a[1:0],op_a[RR_WIDTH-1:2]} ;
			end
			else begin // rr_b == 14'd0, rr_b == 14'd14
				RR = op_a ;
			end
		end
	endfunction

//Gray Code
	function [GC_WIDTH-1:0] GC ; // output
		input [GC_WIDTH-1:0] op_a ;
    
    
		begin
			GC = {op_a[GC_WIDTH-1],(op_a[GC_WIDTH-1]^op_a[10]),(op_a[10]^op_a[9]),(op_a[9]^op_a[8]),(op_a[8]^op_a[7]),(op_a[7]^op_a[6]),(op_a[6]^op_a[5]),(op_a[5]^op_a[4]),(op_a[4]^op_a[3]),(op_a[3]^op_a[2]),(op_a[2]^op_a[1]),(op_a[1]^op_a[0])} ;
		end
	endfunction	
  
 */ 
  
endmodule  