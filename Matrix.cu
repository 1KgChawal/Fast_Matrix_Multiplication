#include "Matrix.h"

template <typename T>
Matrix<T>::Matrix() {
    rows = 0;
    cols = 0;
    vector = nullptr;
}
template <typename T>
Matrix<T>::Matrix(int r, int c) : rows(r), cols(c) {
    vector = new T[r * c];
}
template <typename T>
T& Matrix<T>::operator()(int r, int c) {
    return vector[r * cols + c];
}
template <typename T>
const T& Matrix<T>::operator()(int r, int c) const {
    return vector[r * cols + c];
}
template <typename T>
T* Matrix<T>::data() {
    return vector;
}
template <typename T>
int Matrix<T>::getRows() {
    return rows;
}
template <typename T>
int Matrix<T>::getCols() {
    return cols;
}
template <typename T>
unsigned int Matrix<T>::bytes() {
    return rows * cols * sizeof(T);
}
template<typename T>
void Matrix<T>::print(){
    for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
            std::cout<<(*this)(i,j)<<" ";
        }
        std::cout<<"\n";
    }
}
template <typename T>
Matrix<T> Matrix<T>::operator*(Matrix<T>& M) {
    return multiply(*this, M);
}
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
template <typename T>
Matrix<T> Matrix<T>::multiply(Matrix<T>& M1, Matrix<T>& M2) {
    Matrix M(M1.getRows(), M2.getCols());
    int k = M1.getCols();
    T *d_M1, *d_M2, *d_M;
    cudaMalloc(&d_M1, M1.bytes());
    cudaMalloc(&d_M2, M2.bytes());
    cudaMalloc(&d_M, M.bytes());
    cudaMemcpy(d_M1, M1.data(), M1.bytes(), cudaMemcpyHostToDevice);
    cudaMemcpy(d_M2, M2.data(), M2.bytes(), cudaMemcpyHostToDevice);
    dim3 block(16, 16);
    dim3 grid((M.getRows() + blockDim.x - 1) / blockDim.x, (M.getCols() + blockDim.y - 1) / blockDim.y);
    dkernal<<<grid, block>>>(d_M, d_M1, d_M2, M.getRows(), M.getCols(), k);
    cudaMemcpy(M.data(), d_M, M.bytes(), cudaMemcpyDeviceToHost);
    cudaFree(d_M);
    cudaFree(d_M1);
    cudaFree(d_M2);
    return M;
}