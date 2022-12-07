#include <iostream>
#include <NTL/ZZ.h>
#include <time.h>

#include "NTT.h"

using namespace NTL;

void NTT::NTT_init(unsigned long n, ZZ prime, ZZ root){
	N = n;
	ZZ N_ZZ;
	N_ZZ = N;
	p = prime;
	W = root;
	InvMod(IW, W, p); //calculate inverse of w
	InvMod(IN, N_ZZ, p); //calculate Inverse of N
}

void NTT::NTT_BU(ZZ &a,ZZ &b){
	ZZ tmp_a;
	ZZ tmp_b;
	AddMod(tmp_a, a, b, p);
	if (b < 0)b = b + p;
	SubMod(tmp_b, a, b, p);
	a = tmp_a;
	b = tmp_b;
}

void NTT::NTT_t(std::vector<ZZ> &A) {
	unsigned long  S;//stage
	unsigned int   bias;
	unsigned int   nc; //number of class
	unsigned int   ne; //number of element for each class
	S = (unsigned long)ceil(log2(N));
	std::vector<std::vector<ZZ> > A_t;
	ZZ factor;   //base factor
	ZZ factor_t; //acctually mul factor
	bias = N;
	
	for (int i = 0; i < S; i++) { //DIT 
		nc = N / bias;
		ne = bias;
		A_t.resize(nc); //resize
		for (int k = 0; k < nc; k++) {
			A_t[k].resize(ne);
		}                              //resize
		for (unsigned int j = 0; j < nc; j++) {
			for (unsigned int jj = 0; jj < (ne); jj++) {
				A_t[j][jj] = A[j * ne + jj];
			} //given value
		}
		bias = bias >> 1; //divide by 2
		if (i == 0) factor = W;
		else SqrMod(factor, factor, p); 

		for (unsigned int s = 0; s < nc; s++) {
			for (unsigned int ss = 0; ss < (ne/2); ss++) {
				NTT_BU(A_t[s][ss], A_t[s][ss + bias]);
				PowerMod(factor_t, factor, ss, p);
				MulMod(A_t[s][ss + bias], A_t[s][ss + bias], factor_t, p);
			}
		}
		for (unsigned int x_index = 0; x_index < nc; x_index++) {
			for (unsigned int y_index = 0; y_index < ne; y_index++) {
				A[x_index*ne + y_index] = A_t[x_index][y_index];  //write back
			}
		}
	}
	//data relocation
	ZZ tmp;
	int exchange_position = 0;
	int bit=0;
	int bit_weight = 0;
	int p_tmp = 0;
	for (int i = 0; i < N; i++) {
		p_tmp = i;
		exchange_position = 0;
		for (int ls = 0; ls < S; ls++) {
			bit = p_tmp % 2;
			bit_weight = 1 << ((S-1) - ls);
			if (bit == 1) exchange_position = exchange_position + bit_weight;
			else  exchange_position = exchange_position;
			p_tmp = p_tmp >> 1;
		}
		// exchange_posistion > i , then data exchange 
		if (exchange_position > i) {
			tmp = A[i];
			A[i] = A[exchange_position];
			A[exchange_position] = tmp;
		}
	}

}

void NTT::INTT_t(std::vector<ZZ> &A) {
	unsigned long  S;//stage
	unsigned int   bias;
	unsigned int   nc; //number of class
	unsigned int   ne; //number of element for each class
	S = (unsigned long)ceil(log2(N));
	std::vector<std::vector<ZZ> > A_t;
	ZZ factor;   //base factor
	ZZ factor_t; //acctually mul factor
	bias = N;

	for (int i = 0; i < S; i++) {
		nc = N / bias;
		ne = bias;
		A_t.resize(nc); //resize
		for (int k = 0; k < nc; k++) {
			A_t[k].resize(ne);
		}                              //resize
		for (unsigned int j = 0; j < nc; j++) {
			for (unsigned int jj = 0; jj < (ne); jj++) {
				A_t[j][jj] = A[j * ne + jj];
			} //given value
		}

		bias = bias >> 1; //divide by 2
		if (i == 0) factor = IW;
		else SqrMod(factor, factor, p);

		for (unsigned int s = 0; s < nc; s++) {
			for (unsigned int ss = 0; ss < (ne / 2); ss++) {
				NTT_BU(A_t[s][ss], A_t[s][ss + bias]);
				PowerMod(factor_t, factor, ss, p);
				MulMod(A_t[s][ss + bias], A_t[s][ss + bias], factor_t, p);
			}
		}
		for (unsigned int x_index = 0; x_index < nc; x_index++) {
			for (unsigned int y_index = 0; y_index < ne; y_index++) {
				A[x_index*ne + y_index] = A_t[x_index][y_index];  //write back
			}
		}
	}
	//data relocation
	ZZ tmp;
	int exchange_position = 0;
	int bit = 0;
	int bit_weight = 0;
	int p_tmp = 0;
	for (int i = 0; i < N; i++) {
		p_tmp = i;
		exchange_position = 0;
		for (int ls = 0; ls < S; ls++) {
			bit = p_tmp % 2;
			bit_weight = 1 << ((S - 1) - ls);
			if (bit == 1) exchange_position = exchange_position + bit_weight;
			else  exchange_position = exchange_position;
			p_tmp = p_tmp >> 1;
		}
		// exchange_posistion > i , then data exchange 
		if (exchange_position > i) {
			tmp = A[i];
			A[i] = A[exchange_position];
			A[exchange_position] = tmp;
		}
	}
	for (int i = 0; i < N; i++) {
		MulMod(A[i], A[i], IN, p);
	}
}

void NTT::NTT_pointwise_add(std::vector<ZZ> &A, std::vector<ZZ> b, std::vector<ZZ> c) {
	if(A.size() != N)A.resize(N);
	for (unsigned long i = 0; i < N; i++) {
		AddMod(A[i], b[i], c[i], p);
	}
}

void NTT::NTT_pointwise_sub(std::vector<ZZ> &A, std::vector<ZZ> b, std::vector<ZZ> c) {
	if(A.size() != N)A.resize(N);
	for (unsigned long i = 0; i < N; i++) {
		SubMod(A[i], b[i], c[i], p);
	}
}

void NTT::NTT_pointwise_mult(std::vector<ZZ> &A, std::vector<ZZ> b, std::vector<ZZ> c) {
	if(A.size() != N) A.resize(N); //resize A arrary to N point
	for (long i = 0; i < N; i++) {
		MulMod(A[i], b[i], c[i], p); 
	}
}

void NTT::NTT_LN_decompose(ZZ a, std::vector<ZZ> &A,long sample_bitsize) {
	A.resize(N); //resize N-point
	for (int i = 0; i < N/2-1; i++) {
		NTL::trunc(A[i], a, sample_bitsize);  // puts k low order bits of |a| into x
		a = a >> sample_bitsize;
	}
	for (int j = N / 2; j < N; j++) {
		A[j] = 0; 
	}//zero-padding
}

void NTT::NTT_reconstruct(ZZ &a, std::vector<ZZ> &A, long sample_bitsize) {
	//std::cout << "A size:" << A.size() << std::endl;
	ZZ weight;
	ZZ weight_1;
	ZZ tmp;
	ZZ carry;
	ZZ base;

	NTL::conv(base, "16777216"); //base
	NTL::conv(weight_1, "1");
	NTL::conv(a, "0");
	NTL::conv(carry, "0");
	//resolve carries
	for (long j = 0; j < N; j++) {
		AddMod(A[j], A[j], carry, p);
		if (A[j] >= base) {	
			div(carry, A[j], base); // A[j]/base
			rem(A[j], A[j], base);// A[j] % base
		}
		else {
			carry = 0;
		}
	}
	//recombine
	for (long i = 0; i < N; i++) {
		if (i == 0)weight = weight_1;
		else weight = weight << sample_bitsize;

		tmp = A[i] * weight;
		a = a + tmp;
	}
}

void NTT::NTT_slow_t(std::vector<ZZ> &a, std::vector<ZZ> &A) {
	ZZ tw;
	ZZ factor;
	ZZ tmp;
	A.resize(N); //resize
	for (long i = 0; i < N; i++) {
		PowerMod(tw, W, i, p);
		A[i] = 0;
		for (long j = 0; j < N; j++) {
			PowerMod(factor, tw, j, p);
			MulMod(tmp, a[j], factor, p);
			AddMod(A[i], A[i], tmp, p);
		}
	}
}

void NTT::INTT_slow_t(std::vector<ZZ> &A, std::vector<ZZ> &a) {
	ZZ tw;
	ZZ factor;
	ZZ tmp;
	a.resize(N); //resize
	for (long i = 0; i < N; i++) {
		PowerMod(tw, IW, i, p);
		A[i] = 0;
		if ((i % 1024) == 0)std::cout << "run" << std::endl;
		for (long j = 0; j < N; j++) {
			PowerMod(factor, tw, j, p);
			MulMod(tmp, A[j], factor, p);
			AddMod(a[i], a[i], tmp, p);
		}
		MulMod(a[i], a[i], IN, p);
	}
}