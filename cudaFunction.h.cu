#include <iostream>

template <typename T>
__global__ void dkernal(T* d_M, T* d_M1, T* d_M2, int rows, int cols, int r_c);

template<typename T>
void cudaMultiply(T* M1,T* M2,T* M,int rows, int cols,int r_c);