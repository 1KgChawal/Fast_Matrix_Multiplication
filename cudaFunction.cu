#include <iostream>
#include "cudaFunction.h.cu"

template <typename T>
__global__ void dkernal(T* d_M, T* d_M1, T* d_M2, int rows, int cols, int r_c) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    int j = blockIdx.y * blockDim.y + threadIdx.y;
    if (i < rows && j < cols) {
        d_M[i * cols + j] = 0;
        for (int k = 0; k < r_c; k++) {
            d_M[i * cols + j] += d_M1[i * r_c + k] * d_M2[k * cols + j];
        }
    }
}

template<typename T>
void cudaMultiply(T* M1,T* M2,T* M,int rows, int cols,int r_c){
    unsigned int size1=rows*r_c*sizeof(T);
    unsigned int size2=r_c*cols*sizeof(T);
    unsigned int size=rows*cols*sizeof(T);
    T *d_M1,*d_M2,*d_M;
    cudaMalloc(&d_M,size);
    cudaMalloc(&d_M1,size1);
    cudaMalloc(&d_M2,size2);
    cudaMemcpy(d_M1,M1,size1,cudaMemcpyHostToDevice);
    cudaMemcpy(d_M2,M2,size2,cudaMemcpyHostToDevice);
    dim3 block(16,16);
    dim3 grid((rows+block.x-1)/block.x,(cols+block.y-1)/block.y);
    dkernal<<<grid,block>>>(d_M,d_M1,d_M2,rows,cols,r_c);
    cudaMemcpy(M,d_M,size,cudaMemcpyDeviceToHost);
    cudaFree(d_M);
    cudaFree(d_M1);
    cudaFree(d_M2);
}
