#include <iostream>

template <typename T>
class Matrix {
   private:
    int rows, cols;
    T* vector;

   public:
    Matrix() {
        rows = 0;
        cols = 0;
        vector = nullptr;
    }
    Matrix(int r, int c) : rows(r), cols(c) {
        vector = new T[r * c];
    }
    T& operator()(int r, int c) {
        return vector[r * c + c];
    }
    const T& operator(int r, int c) const {
        return vector[r * cols + c];
    }
    T* data {
        return vector;
    }
    int getRows() {
        return rows;
    }
    int getCols() {
        return cols;
    }
    unsigned int bytes() {
        return r * c * sizeof(T);
    }
    Matrix<T> operator*(Matrix<T>& M) {
        return multiply(*this, M);
    }
    Matrix<T> multiply(Matrix<T>& M1, Matrix<T>& M2) {
        Matrix M(M1.getRows(), M2.getCols());
        int k = M1.getCols();
        T *d_M1, d_M2, d_M;
        cudaMalloc(&d_M1, M1.bytes());
        cudaMalloc(&d_M2, M2.bytes());
        cudaMalloc(&d_M, M.bytes());
        cudaMemcpy(d_M1, M1.data(), M1.bytes(), cudaMemcpyHostToDevice);
        cudaMemcpy(d_M2, M2.data(), M2.bytes(), cudaMemcpyHostToDevice);
        dim3 block(16, 16);
        dim3 grid((M.getRows() + blockDim.x - 1) / blockDim.x, (M.getCols() + blockDim.y - 1) / blockDim.y);
        dkernal<<<grid,block>>>(d_M,d_M1,d_M2,M.getRows(),M.getCols(),k);
        cudaMemcpy(M.data(),d_M,M.bytes(),cudaMemcpyDeviceToHost);
        return M;
    }
};

template <typename T>
__global__ void dkernal(T* d_M, T* d_M1, T* d_M2, int rows, int cols, int r_c) {
    int i=blockIdx.x*blockDim.x+threadIdx.x;
    int j=blockIdx.y*blockDim.y+threadIdx.y;
    if(i<rows&&j<cols){
        d_M[i*cols+j]=0;
        for(int k=0;k<r_c;k++){
            d_M[i*cols+j]+=d_M1[i*r_c+k]+d_M2[k*cols+j];
        }
    }
}