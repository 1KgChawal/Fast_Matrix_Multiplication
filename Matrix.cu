#include "Matrix.h"
#include "cudaFunction.h"

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
Matrix<T> Matrix<T>::multiply(Matrix<T>& M1, Matrix<T>& M2) {
    Matrix M(M1.getRows(), M2.getCols());
    cudaMultiply(M1.data(),M2.data(),M.data(),M1.getRows(),M2.getCols(),M1.getCols());
    return M;
}
