#include <iostream>

template<typename T>
class Matrix{
    private:
    int rows,cols;
    T* vector;
    public:
    Matrix(){
        rows=0;
        cols=0;
        vector=nullptr;
    }
    Matrix(int r,int c) : rows(r), cols(c){
        vector=new T [r*c];
    }
    T& operator()(int r,int c){
        return vector[r*c+c];
    }
    const T& operator(int r,int c) const{
        return vector[r*cols+c];
    }
    T* data{
        return vector;
    }
    int getRows(){
        return rows;
    }
    int getCols(){
        return cols;
    }
    unsigned int bytes(){
        return r*c*sizeof(T);
    }
    Matrix<T> operator*(Matrix<T>& M){
        return multiply(*this,M);
    } 
    Matrix<T> multiply(Matrix<T>& M1,Matrix<T>& M2){
        Matrix M(M1.getRows(),M2.getCols());
        int k=M1.getCols();
        T* d_M1,d_M2,d_M;
        cudaMalloc(&d_M1,M1.bytes());
        cudaMalloc(&d_M2,M2.bytes());
        cudaMalloc(&d_M,M.bytes());
        
    }
};