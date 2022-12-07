// Copyright (C) IBM, All Rights Reserved


#include <cstring>
#include <string>
#include <iomanip>
#include <ctime>
#include <cstring>
#include <iostream>
#include <fstream>
#include <sstream>
#include <NTL/tools.h>
#include <NTL/ZZ.h>
#include <time.h>

NTL_CLIENT
#include "NTT.h"
#include "bluestein.h"
#include "SPMB.h"

main(int argc, char *argv[])
{
  
  NTT test;  // prime is power of 2,can used to fft or original DFT
  NTT tt;    // prime is not power of 2 ,just only using DFT function
             // verification
  SPMB spmb;
             
  unsigned long fft_point;
  unsigned long order; // order of 65536-th ROU
  ZZ fft_prime;
  ZZ twiddle_65536; //65536-th root of unity
  ZZ fft_twiddle;
 
 
  fft_point = 4096;
  conv(fft_prime,"18446744069414584321");
  conv(twiddle_65536,"14603442835287214144");
  //generate fft_point Root of unity by 65536-th root of unity 
  order = 65536/fft_point;
  fft_twiddle = PowerMod(twiddle_65536,order,fft_prime);
  test.NTT_init(fft_point,fft_prime,fft_twiddle);
  //**********************************************************
  //BFFT paramter
  bluestein  bfft;
  ofstream   m_ROU_o; 
  long m;    //m-th cyclotomic polynomial 
  long phim; //phi(m)
  long m_2;  //2m

  ZZ m_2_rou; // 2m-th root of unity
  ZZ m_rou;   // m-th root of unity
  ZZ prime_tmp;
  //ZZ tmp;
  
  m    = 1705;  
  phim = 1200;
  m_2  = 2 * m;
  
  //**********************************************************
  std::vector<ZZ> A_NTT;
  std::vector<ZZ> B_NTT;
  std::vector<ZZ> C_NTT;
  std::vector<ZZ> h2_NTT;
  std::vector<ZZ> test_golden_NTT;
  A_NTT.resize(fft_point);
  B_NTT.resize(fft_point);
  C_NTT.resize(fft_point);
  h2_NTT.resize(fft_point);
  test_golden_NTT.resize(fft_point);
  
  unsigned long radix;
  unsigned long addr;
  unsigned long bc;
  int offset;
  radix  = 4;
  addr   = fft_point/(2*radix);
  offset = (int)fft_point/radix;
  bc     = fft_point / radix;
  
  int addr_width  = 0;
  int radix_width = 0;
  int No_shift    = 0;
  int bc_width    = 0;
  double addr_w;
  double radix_w;
  double bc_w;
  addr_w      = log2((double)fft_point);
  radix_w     = log2((double)radix);
  bc_w        = log2((double)bc);
  addr_width  = (int) addr_w;
  radix_width = (int) radix_w;
  bc_width    = (int) bc_w;
  No_shift = addr_width - radix_width; 
  unsigned long MulDA,MulDB;
  MulDA = 1;
  MulDB = 1020;
  
  spmb.init(fft_point,radix,bc_width);
/******************************************************************/
//Given DATA Start
/*****************************************************************/  
  ofstream A_output;
  ofstream B_output;
  A_output.open("./conv/A_In_data.txt");
  B_output.open("./conv/B_In_data.txt");
  int counter;
  int loop_address;
  int loop_counter;
  int loop_index;
  int counter_deadline;
  counter_deadline = fft_point / (2*radix);
  
    while(counter < counter_deadline){ 
       if((spmb.ma[loop_index] == counter )&& (spmb.bn[loop_index] == 0) ){
          for(int j=0;j<radix;j++){
            loop_address = loop_index + offset * j;
            if(j==0) {
                //if(counter<1)A_NTT[loop_address] = MulDA;
                //else A_NTT[loop_address] = 0;
                 A_NTT[loop_address] = 0;
            }
            if(j==1) {
               if(counter<1)A_NTT[loop_address] = MulDA;
               else A_NTT[loop_address] = 0;
            }
            if(j==2) {
                A_NTT[loop_address] = 0;         
            } 
            if(j==3) {
                A_NTT[loop_address] = 0;
            }
          }           
           loop_index = 0;
           counter = counter + 1;
       }
       else loop_index = loop_index + 1;
    }
    
    loop_index = 0;
    counter    = 0;
    //bank 1
    while(counter < counter_deadline){ 
       if((spmb.ma[loop_index] == counter )&& (spmb.bn[loop_index] == 1) ){
          for(int j=0;j<radix;j++){
            loop_address = loop_index + offset * j;
            if(j==0) {
               A_NTT[loop_address] = 0;
            }
            if(j==1) {
                A_NTT[loop_address] = 0;
            }
            if(j==2) {
                A_NTT[loop_address] = 0;         
            } 
            if(j==3) {
                A_NTT[loop_address] = 0;
            }
          }           
           loop_index = 0;
           counter = counter + 1;
       }
       else loop_index = loop_index + 1;
    }


  for(int i=0;i<fft_point;i++){
    conv(B_NTT[i],i);
    A_output << A_NTT[i] <<"\n";  
    B_output << B_NTT[i] <<"\n";  
  }
  
 /********************************************************************************/
 //Given DATA OVER
 /********************************************************************************/
 //generate 2m-th root of unity (mod prime_tmp)  is used to bfft
 spmb.BM_parameter(m_2);
 prime_tmp  = spmb.test_prime;
 bfft.N_ROU(prime_tmp,m_2,m_2_rou);
 
 std::cout<<"m_2_rou: "<<m_2_rou<<"\n";
 //generate h2_freq and h2_time
 bfft.init(prime_tmp,m_2_rou,m);
 //output h2_time data
 //spmb.h2_time_o(B_NTT); 
 std::cout << "spmb test prime: " << spmb.test_prime << "\n";
 spmb.h2_time_o(bfft.h2_time);
 //spmb.re_order_factor(m,m_2_rou);
//===============================================================
  
  for(int i=0;i<fft_point;i++){
    h2_NTT[i] = bfft.h2_time[i];
    //B_NTT[i]  = bfft.h2_time[i];
  }
 
//===============================================================

 m_rou = PowerMod(m_2_rou,2,prime_tmp);
 //verification 
 //golden data paramter set
 ofstream golden_out;
 golden_out.open("./DataForVerilog/GoldenData.txt");
 std::vector<ZZ>  dft_i;    // size = m
 std::vector<ZZ>  golden;
 tt.NTT_init(m,prime_tmp,m_rou);
 golden.resize(m);
 dft_i.resize(m);
 for(int k=0;k<phim;k++){
     dft_i[k] = A_NTT[k];
 }
 tt.NTT_slow_t(dft_i,golden);
 
 for(int k=0;k<m;k++){
     golden_out << golden[k];
     golden_out << "\n";
 }
 golden_out.close();
 
 /*******************************************************************************/
 //input re-order
 //mult by m-th root of unity w^(1/2*i^2)
 
 for(int i=0;i<fft_point;i++){
     if(i<m){
        unsigned long exp;
        ZZ w_2m_tmp_i;    // tmp
        exp = pow(i,2); // i^2
        exp = exp % (2*m);  
        PowerMod(w_2m_tmp_i,m_2_rou,exp,prime_tmp); //tmp = w^(1/2*i^2)
        MulMod(A_NTT[i],A_NTT[i],w_2m_tmp_i,prime_tmp);
     }
     else conv(A_NTT[i],"0"); 
 }
 
//======================================================================
 test.NTT_t(A_NTT);
 test.NTT_t(B_NTT);
 test.NTT_t(h2_NTT);
 //test.NTT_pointwise_mult(C_NTT,A_NTT,bfft.h2_freq);  // BFFT
 test.NTT_pointwise_mult(C_NTT,A_NTT,B_NTT);
 test.NTT_pointwise_mult(test_golden_NTT,A_NTT,h2_NTT);
 //test.NTT_pointwise_mult(test_golden_NTT,A_NTT,B_NTT);
 //spmb.B_freq_o(bfft.h2_freq);
 test.INTT_t(C_NTT);
 test.INTT_t(test_golden_NTT);
 //=================================================
 //output B_NTT data
 //spmb.B_freq_o(B_NTT);
 //=================================================
 //BFFT
 
 for(int i=0; i < m;i++){
     test_golden_NTT[i] = test_golden_NTT[i] % prime_tmp;
 }
 
 for(int i=0;i<fft_point;i++){
     if( i < m){
         unsigned long exp;
         ZZ w_2m_tmp_o;
         exp = pow(i,2);
         PowerMod(w_2m_tmp_o,m_2_rou,exp,prime_tmp);
         test_golden_NTT[i] = MulMod(test_golden_NTT[i],w_2m_tmp_o,prime_tmp);
     }
     else test_golden_NTT[i] = 0;
 }
 
 /*******************************************************************************/
 ofstream output_file;
 ofstream test_golden;
 output_file.open("./conv/A_mul_B.txt");
 test_golden.open("./DataForVerilog/test_golden.txt");
 for(int j=0; j < fft_point; j++){
	 output_file << C_NTT[j];
     test_golden << test_golden_NTT[j];
	 //test_golden << C_NTT[j];
     output_file <<"\n";
     test_golden << "\n";
 }
 output_file.close();
 test_golden.close();
 
 int error;
 error = 0;
 for(int i=0;i<m;i++){
     if(test_golden_NTT[i] != golden[i]) error ++;
 }
 std::cout << "error: " << error <<"\n";
}

